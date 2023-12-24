package main

// #include <stdlib.h>
// #include "leechcore.h"
// #include "vmmdll.h"
import "C"
import (
	"fmt"
	"unsafe"
)

func main() {
	args := []string{"", "-device", "fpga"}

	cArgs := make([]C.LPSTR, len(args))
	for i, arg := range args {
		cArgs[i] = C.LPSTR(C.CString(arg))
		defer C.free(unsafe.Pointer(cArgs[i]))
	}

	vmm := C.VMMDLL_Initialize(C.DWORD(len(args)), &cArgs[0])

	if vmm == nil {
		fmt.Println("Failed to initialize FPGA")
		return
	}

	fmt.Printf("???")
}
