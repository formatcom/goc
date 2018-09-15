package main

import "C"
import (
	"fmt"
)

//export Show
func Show() {
	fmt.Println("Hello World");
}

// We need the main function to make possible
func main(){}
