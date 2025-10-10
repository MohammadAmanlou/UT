// A good implementation of a Squarer. DO NOT MODIFY THIS FILE!

package p0partB

// SquarerImpl is a good implementation of Squarer. It should hopefully pass any tests you write.
type SquarerImpl struct {
	input  chan int
	output chan int
	close  chan bool
	closed chan bool
}

// Initialize sets up the variables for the SquarerImpl structure.
func (sq *SquarerImpl) Initialize(input chan int) <-chan int {
	sq.input = input
	sq.close = make(chan bool)
	sq.closed = make(chan bool)
	sq.output = make(chan int)
	go sq.work()
	return sq.output
}

// Close returns when the input goroutine has stopped.
func (sq *SquarerImpl) Close() {
	sq.close <- true
	<-sq.closed
}

func (sq *SquarerImpl) work() {
	var toPush int
	dummy := make(chan int)
	pushOn := dummy
	pullOn := sq.input
	for {
		select {
		case unsquared := <-pullOn:
			toPush = unsquared * unsquared
			pushOn = sq.output
			pullOn = nil
		case pushOn <- toPush:
			pushOn = dummy
			pullOn = sq.input
		case <-sq.close:
			sq.closed <- true
			return
		}
	}
}
