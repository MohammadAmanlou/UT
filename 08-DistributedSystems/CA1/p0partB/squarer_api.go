// Defines the interface for a Squarer. DO NOT MODIFY THIS FILE!

package p0partB

// Squarer objects take a chan and return a chan that passes squares of the elements on the input chan.
// Squarer's should not have factory methods: they should be initialized by doing eg
// squarer := squarer{}
// mySquaredChan := squarer.Initialize(myChan)
type Squarer interface {
	// Initialize should be called first and once. Should return a chan on which squares will be passed.
	Initialize(chan int) <-chan int
	// Close closes the Squarer: after Close returns, all resources associated with the Squarer, including all goroutines.
	// should be gone
	Close()
}
