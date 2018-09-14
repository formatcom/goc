package main

import "C"
import (
	"fmt"
)

//export Step
func Step() {
	fmt.Println("Hola Mundo");
}

// We need the main function to make possible
func main(){}
