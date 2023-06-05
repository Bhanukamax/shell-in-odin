package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:mem"

Error :: enum {
  None,
  No_Input,
}

handle_input :: proc(words: []string) {
  prog, args := words[0], words[1:]
  if strings.compare(prog, "exit") == 0{
    fmt.println("should exit")
    return
  } else if strings.compare(prog, "one") == 0{
    fmt.println("should one")
  } else  {
    fmt.println("just a program")
    pid, err := os.fork()
    if err != os.ERROR_NONE {
      fmt.println("faild to fork")
      return
    }
    if pid == 0{
      err = os.execvp(prog, args)
      if err != os.ERROR_NONE {
      fmt.println("Error in program")
      return
      }
    }
  }
}

read_input :: proc() {
  fmt.print("⚒: ")
  buf:[1024]u8
  n, err := os.read(os.stdin, buf[:])

  if err < 0 {
    fmt.println("Error reading input")
  } else {
    arr2 := strings.split(string(buf[0:n - 1]), " ")
    fmt.println("in read_input", arr2)
    handle_input(arr2)
  }
}

main  :: proc ()  {
  fmt.println("this is a test")
  for {
    words: [dynamic]string
    args: []string
    err: Error
    read_input()
    if err != .None {
      return
    }
  }
  return
}
