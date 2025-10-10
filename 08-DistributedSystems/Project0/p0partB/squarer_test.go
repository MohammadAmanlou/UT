package p0partB

import (
	"fmt"
	"testing"
	"time"
)

const (
	timeoutMillis = 5000
)

func TestBasicCorrectness(t *testing.T) {
	fmt.Println("Running TestBasicCorrectness.")
	input := make(chan int)
	sq := SquarerImpl{}
	squares := sq.Initialize(input)
	go func() {
		input <- 2
	}()
	timeoutChan := time.After(time.Duration(timeoutMillis) * time.Millisecond)
	select {
	case <-timeoutChan:
		t.Error("Test timed out.")
	case result := <-squares:
		if result != 4 {
			t.Error("Error, got result", result, ", expected 4 (=2^2).")
		}
	}
}

func TestConcurrentProcessing(t *testing.T) {
	fmt.Println("Running TestConcurrentProcessing.")
	input := make(chan int, 3)
	sq := SquarerImpl{}
	squares := sq.Initialize(input)

	input <- 5
	input <- -6
	input <- 7
	close(input)

	expectedResults := []int{25, 36, 49}
	for _, expected := range expectedResults {
		select {
		case result := <-squares:
			if result != expected {
				t.Errorf("Expected %d, but got %d", expected, result)
			}
		case <-time.After(time.Duration(timeoutMillis) * time.Millisecond):
			t.Error("Test timed out.")
		}
	}
	sq.Close()
}

func TestClosingInputChannel(t *testing.T) {
	fmt.Println("Running TestClosingInputChannel.")
	input := make(chan int)
	sq := SquarerImpl{}
	squares := sq.Initialize(input)

	go func() {
		input <- 8
		close(input)
	}()

	select {
	case result := <-squares:
		if result != 64 {
			t.Errorf("Expected 64, but got %d", result)
		}
	case <-time.After(time.Duration(timeoutMillis) * time.Millisecond):
		t.Error("Test timed out.")
	}

	select {
	case _, ok := <-squares:
		if ok {
			t.Error("Expected channel to be closed, but received a value.")
		}
	case <-time.After(time.Duration(500) * time.Millisecond):
	}
	sq.Close()
}

func TestLargeInputSet(t *testing.T) {
	fmt.Println("Running TestLargeInputSet.")
	input := make(chan int, 201)
	sq := SquarerImpl{}
	squares := sq.Initialize(input)

	go func() {
		for i := -100; i <= 100; i++ {
			input <- i
		}
		close(input)
	}()

	for i := -100; i <= 100; i++ {
		expected := i * i
		select {
		case result := <-squares:
			if result != expected {
				t.Errorf("Expected %d, but got %d", expected, result)
			}
		case <-time.After(time.Duration(timeoutMillis) * time.Millisecond):
			t.Errorf("Test timed out for value %d.", i)
		}
	}
	sq.Close()
}
