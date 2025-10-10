package tester

import (
	"sync"
	"os"
	"os/signal"
	"fmt"
	"time"
	"strings"
	"slices"
	"github.com/anishathalye/porcupine"
	"6.5840/models1"
)

///
/// Public interface.
///

type Annotation struct {
	mu          *sync.Mutex
	annotations []porcupine.Annotation
	continuous  map[string]Continuous
	finalized   bool
}

type Continuous struct {
	start   int64
	desp    string
	details string
	bgcolor string
}

type FrameworkInfo struct {
	mu        *sync.Mutex
	nservers  int
	connected []bool
	crashed   []bool
	ckbegin   CheckerBegin
}

type CheckerBegin struct {
	ts      int64
	details string
}

// Using global variable feels disturbing, but also can't figure out a better
// way to support user-level annotations. An alternative would be passing an
// Annotation object to the start-up function of servers and clients, but that
// doesn't feel better.
//
// One potential problem with using a global Annotation object is that when
// running multiple test cases, some zombie threads in previous test cases could
// interfere the current one. An ad-hoc fix at the user level would be adding
// annotations only if the killed flag on the server is not set.
var annotation *Annotation = mkAnnotation()
var unit struct{} = captureSignal()
var finfo *FrameworkInfo

const (
	COLOR_INFO    string = "#FAFAFA"
	COLOR_NEUTRAL string = "#FFECB3"
	COLOR_SUCCESS string = "#C8E6C9"
	COLOR_FAILURE string = "#FFCDD2"
	COLOR_FAULT   string = "#B3E5FC"
	COLOR_USER    string = "#FFF176"
)

const (
	TAG_CHECKER   string = "$ Checker"
	TAG_PARTITION string = "$ Failure"
	TAG_INFO      string = "$ Test Info"
)

func FinalizeAnnotations(end string) []porcupine.Annotation {
	annotations := annotation.finalize()

	// XXX: Make the last annotation an interval one to work around Porcupine's
	// issue. Consider removing this once the issue is fixed.
	t := timestamp()
	aend := porcupine.Annotation{
		Tag: TAG_INFO,
		Start: t,
		End: t + 1000,
		Description: end,
		Details: end,
		BackgroundColor: COLOR_INFO,
	}
	annotations = append(annotations, aend)

	return annotations
}

func AnnotatePointColor(
	tag, desp, details, bgcolor string,
) {
	annotation.annotatePointColor(tag, desp, details, bgcolor)
}

func GetAnnotateTimestamp() int64 {
	return timestamp()
}

func AnnotateIntervalColor(
	tag string, start int64, desp, details, bgcolor string,
) {
	annotation.annotateIntervalColor(tag, start, desp, details, bgcolor)
}

func AnnotateContinuousColor(tag, desp, details, bgcolor string) {
	annotation.annotateContinuousColor(tag, desp, details, bgcolor)
}

func AnnotateContinuousEnd(tag string) {
	annotation.annotateContinuousEnd(tag)
}

// Used by users.

func Annotate(tag, desp, details string) {
	annotation.annotatePointColor(tag, desp, details, COLOR_USER)
}

func AnnotateInterval(tag string, start int64, desp, details string) {
	annotation.annotateIntervalColor(tag, start, desp, details, COLOR_USER)
}

func AnnotateContinuous(tag, desp, details string) {
	annotation.annotateContinuousColor(tag, desp, details, COLOR_USER)
}

// Used by test framework.

func AnnotateInfo(desp, details string) {
	AnnotatePointColor(TAG_INFO, desp, details, COLOR_INFO)
}

func AnnotateInfoInterval(start int64, desp, details string) {
	AnnotateIntervalColor(TAG_INFO, start, desp, details, COLOR_INFO)
}

func AnnotateTest(desp string, nservers int) {
	details := fmt.Sprintf("%s (%d servers)", desp, nservers)
	finfo = mkFrameworkInfo(nservers)
	annotation.clear()

	AnnotateInfo(details, details)
}

func AnnotateCheckerBegin(details string) {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	finfo.ckbegin = CheckerBegin{
		ts: timestamp(),
		details: details,
	}
}

func AnnotateCheckerEnd(desp, details, color string) {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	ckbegin := finfo.ckbegin

	if ckbegin.ts == 0 {
		// Annotate as a point-in-time if the begin timestamp is not set.
		AnnotatePointColor(TAG_CHECKER, desp, details, color)
		return
	}

	// Annotate as an interval if the begin timestamp is set.
	d := fmt.Sprintf("%s: %s", ckbegin.details, details)
	AnnotateIntervalColor(TAG_CHECKER, ckbegin.ts, desp, d, color)

	// Reset the checker begin timestamp.
	ckbegin.ts = 0
}

func AnnotateCheckerSuccess(desp, details string) {
	AnnotateCheckerEnd(desp, details, COLOR_SUCCESS)
}

func AnnotateCheckerFailure(desp, details string) {
	AnnotateCheckerEnd(desp, details, COLOR_FAILURE)
}

func AnnotateCheckerNeutral(desp, details string) {
	AnnotateCheckerEnd(desp, details, COLOR_NEUTRAL)
}

func SetAnnotationFinalized() {
	annotation.mu.Lock()
	defer annotation.mu.Unlock()

	annotation.finalized = true
}

func (an *Annotation) isFinalized() bool {
	annotation.mu.Lock()
	defer annotation.mu.Unlock()

	return annotation.finalized
}

func GetAnnotationFinalized() bool {
	return annotation.isFinalized()
}

// Used before log.Fatalf
func AnnotateCheckerFailureBeforeExit(desp, details string) {
	AnnotateCheckerFailure(desp, details)
	annotation.cleanup(true, "test failed")
}

// The current annotation API for failures is very hacky. We really should have
// just one function that reads the current network/server status. For network,
// we should be able to read whether an endname is enabled. However, if the
// endname is enabled from X to Y, but not Y to X, the annotation would be
// downright confusing. A better design (in the tester framework, not in the
// annotation layer) is to have a single boolean for each pair of servers; once
// we have such state, the annotation can then simply read the booleans to
// determine the network partitions.

// Two functions to annotate partitions: AnnotateConnection and
// AnnotateTwoPartitions. The connected field of ServerGrp (in group.go) is
// precise if and only if the ServerGrp.Partition is not used. Thus, we use the
// latter when ServerGrp.Partition is involved, and the former otherwise.
func AnnotateConnection(connection []bool) {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	if slices.Equal(finfo.connected, connection) {
		// Nothing to do if the connection is unchanged.
		return
	}

	copy(finfo.connected, connection)

	annotateFault()
}

func annotateFault() {
	trues := make([]bool, finfo.nservers)
	for id := range(trues) {
		trues[id] = true
	}
	falses := make([]bool, finfo.nservers)
	if slices.Equal(trues, finfo.connected) && slices.Equal(falses, finfo.crashed) {
		// No annotation when no partitions and no crashes.
		AnnotateContinuousEnd(TAG_PARTITION)
		return
	}

	// Now, each disconnected server sits in its own partition, connected
	// servers in one partition; crahsed servers indicated at the end.
	conn := make([]int, 0)
	crashes := make([]int, 0)
	var builder strings.Builder
	builder.WriteString("partition = ")
	for id, connected := range(finfo.connected) {
		if finfo.crashed[id] {
			crashes = append(crashes, id)
			continue
		}
		if connected {
			conn = append(conn, id)
		} else {
			builder.WriteString(fmt.Sprintf("[%v] ", id))
		}
	}
	if len(conn) > 0 {
		builder.WriteString(fmt.Sprintf("%v", conn))
	}
	if len(crashes) > 0 {
		builder.WriteString(fmt.Sprintf(" / crash = %v", crashes))
	}
	text := builder.String()
	AnnotateContinuousColor(TAG_PARTITION, text, text, COLOR_FAULT)
}

// Currently this API does not work with failed servers, nor with the connected
// fields of ServerGrp (in group.go). It is used specifically for
// ServerGrp.Partition.
func AnnotateTwoPartitions(p1 []int, p2 []int) {
	// A bit hard to check whether the partition actually changes, so just
	// annotate on every invocation.
	text := fmt.Sprintf("partition = %v %v", p1, p2)
	AnnotateContinuousColor(TAG_PARTITION, text, text, COLOR_FAULT)
}

func AnnotateClearFailure() {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	for id := range(finfo.crashed) {
		finfo.crashed[id] = false
	}

	for id := range(finfo.connected) {
		finfo.connected[id] = true
	}

	AnnotateContinuousEnd(TAG_PARTITION)
}

func AnnotateShutdown(servers []int) {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	changed := false
	for _, id := range(servers) {
		if !finfo.crashed[id] {
			changed = true
		}
		finfo.crashed[id] = true
	}

	if !changed {
		// Nothing to do if the set of crashed servers is unchanged.
		return
	}

	annotateFault()
}

func AnnotateShutdownAll() {
	finfo.mu.Lock()
	n := finfo.nservers
	finfo.mu.Unlock()

	servers := make([]int, n)
	for i := range(servers) {
		servers[i] = i
	}
	AnnotateShutdown(servers)
}

func AnnotateRestart(servers []int) {
	finfo.mu.Lock()
	defer finfo.mu.Unlock()

	changed := false
	for _, id := range(servers) {
		if finfo.crashed[id] {
			changed = true
		}
		finfo.crashed[id] = false
	}

	if !changed {
		// Nothing to do if the set of crashed servers is unchanged.
		return
	}

	annotateFault()
}

func AnnotateRestartAll() {
	finfo.mu.Lock()
	n := finfo.nservers
	finfo.mu.Unlock()

	servers := make([]int, n)
	for i := range(servers) {
		servers[i] = i
	}
	AnnotateRestart(servers)
}

///
/// Internal.
///

func timestamp() int64 {
	return int64(time.Since(time.Unix(0, 0)))
}

func (an *Annotation) finalize() []porcupine.Annotation {
	an.mu.Lock()
	defer an.mu.Unlock()

	x := an.annotations

	t := timestamp()
	for tag, cont := range(an.continuous) {
		a := porcupine.Annotation{
			Tag: tag,
			Start: cont.start,
			End: t,
			Description: cont.desp,
			Details: cont.details,
			BackgroundColor: cont.bgcolor,
		}
		x = append(x, a)
	}

	an.finalized = true
	return x
}

func (an *Annotation) clear() {
	an.mu.Lock()
	an.annotations = make([]porcupine.Annotation, 0)
	an.continuous = make(map[string]Continuous)
	an.finalized = false
	an.mu.Unlock()
}

func (an *Annotation) annotatePointColor(
	tag, desp, details, bgcolor string,
) {
	an.mu.Lock()
	t := timestamp()
	a := porcupine.Annotation{
		Tag: tag,
		Start: t,
		Description: desp,
		Details: details,
		BackgroundColor: bgcolor,
	}
	an.annotations = append(an.annotations, a)
	an.mu.Unlock()
}

func (an *Annotation) annotateIntervalColor(
	tag string, start int64, desp, details, bgcolor string,
) {
	an.mu.Lock()
	a := porcupine.Annotation{
		Tag: tag,
		Start: start,
		End: timestamp(),
		Description: desp,
		Details: details,
		BackgroundColor: bgcolor,
	}
	an.annotations = append(an.annotations, a)
	an.mu.Unlock()
}

func (an *Annotation) annotateContinuousColor(
	tag, desp, details, bgcolor string,
) {
	an.mu.Lock()
	defer an.mu.Unlock()

	cont, ok := an.continuous[tag]
	if !ok {
		// The first continuous annotation for tag. Simply add it to the
		// continuous map.
		an.continuous[tag] = Continuous{
			start: timestamp(),
			desp: desp,
			details: details,
			bgcolor: bgcolor,
		}
		return
	}

	// Subsequent continuous annotation for tag. Concretize the previous
	// annotation and add this one to the continuous map.
	t := timestamp()
	aprev := porcupine.Annotation{
		Tag: tag,
		Start: cont.start,
		End: t,
		Description: cont.desp,
		Details: cont.details,
		BackgroundColor: cont.bgcolor,
	}
	an.annotations = append(an.annotations, aprev)
	an.continuous[tag] = Continuous{
		// XXX: If the start timestamp of an event is too closer to the end
		// timestamp of another event, Porcupine seems to overlap the two
		// events. We add a delta (1000) as a workaround, but remove this once
		// this issue is resolved.
		start: t + 1000,
		desp: desp,
		details: details,
		bgcolor: bgcolor,
	}
}

func (an *Annotation) annotateContinuousEnd(tag string) {
	an.mu.Lock()
	defer an.mu.Unlock()

	cont, ok := an.continuous[tag]
	if !ok {
		// Nothing to end since there's no on-going continuous annotation for
		// tag.
	}

	// End the on-going continuous annotation for tag.
	t := timestamp()
	aprev := porcupine.Annotation{
		Tag: tag,
		Start: cont.start,
		End: t,
		Description: cont.desp,
		Details: cont.details,
		BackgroundColor: cont.bgcolor,
	}
	an.annotations = append(an.annotations, aprev)
	delete(an.continuous, tag)
}

func (an *Annotation) cleanup(failed bool, end string) {
	enabled := os.Getenv("VIS_ENABLE")
	if enabled == "never" || (!failed && enabled != "always") || an.isFinalized() {
		// Simply clean up the annotations without producing the vis file if
		// VIS_ENABLE is set to "never", OR if the test passes AND VIS_ENABLE is
		// not set to "always", OR the current test has already been finalized
		// (because CheckPorcupine has already produced a vis file).
		an.clear()
		return
	}

	annotations := an.finalize()
	if len(annotations) == 0 {
		// Skip empty annotations.
		return
	}

	// XXX: Make the last annotation an interval one to work around Porcupine's
	// issue. Consider removing this once the issue is fixed.
	t := timestamp()
	aend := porcupine.Annotation{
		Tag: TAG_INFO,
		Start: t,
		End: t + 1000,
		Description: end,
		Details: end,
		BackgroundColor: COLOR_INFO,
	}
	annotations = append(annotations, aend)

	fpath := os.Getenv("VIS_FILE")
	var file *os.File
	var err error
	if fpath == "" {
		// Save the vis file in a temporary file.
		file, err = os.CreateTemp("", "porcupine-*.html")
	} else {
		file, err = os.OpenFile(fpath, os.O_RDWR | os.O_CREATE | os.O_TRUNC, 0644)
	}
	if err != nil {
		fmt.Printf("info: failed to open visualization file %s (%v)\n", fpath, err)
		return
	}

	// Create a fresh linearization info without any client operations and use
	// models.KvModel simply as a placeholder.
	info := porcupine.LinearizationInfo{}
	info.AddAnnotations(annotations)
	porcupine.Visualize(models.KvModel, info, file)
	fmt.Printf("info: wrote visualization to %s\n", file.Name())
}

func mkAnnotation() *Annotation {
	an := Annotation{
		mu: new(sync.Mutex),
		annotations: make([]porcupine.Annotation, 0),
		continuous: make(map[string]Continuous),
		finalized: false,
	}

	return &an
}

func mkFrameworkInfo(nservers int) *FrameworkInfo {
	conn := make([]bool, nservers)
	for id := range(conn) {
		conn[id] = true
	}

	finfo := FrameworkInfo{
		mu: new(sync.Mutex),
		nservers: nservers,
		connected: conn,
		crashed: make([]bool, nservers),
	}

	return &finfo
}

func captureSignal() struct{} {
	// Capture SIGINT to visualize on interruption.
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	go func(){
		for range c {
			annotation.cleanup(true, "interrupted")
			os.Exit(1)
		}
	}()

	return struct{}{}
}
