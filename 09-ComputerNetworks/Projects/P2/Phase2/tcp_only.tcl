set ns [new Simulator]
set tf [open tcp_only.tr w]
$ns trace-all $tf

proc finish {} {
    global ns tf
    $ns flush-trace
    close $tf
    exit 0
}

set tcp_src [$ns node]
set r1 [$ns node]
set r2 [$ns node]
set dst [$ns node]

$ns duplex-link $tcp_src $r1 10Mb 10ms DropTail
$ns duplex-link $r1 $r2 2Mb 20ms DropTail
$ns duplex-link $r2 $dst 10Mb 10ms DropTail
$ns queue-limit $r1 $r2 20

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $tcp_src $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $dst $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 1.0 "$ftp start"
$ns at 51.0 "finish"
$ns run