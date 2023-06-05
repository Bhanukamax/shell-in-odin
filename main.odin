package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:mem"

Error :: enum {
  None,
  No_Input,
}

ShellState :: enum {
  Exit,
  Continue,
}

buf:[1024]u8

handle_input :: proc(words: []string) -> ShellState {
  prog, args := words[0], words[1:]
  if strings.compare(prog, "exit") == 0{
    return .Exit
  } else if strings.compare(prog, "cd") == 0{
    fmt.println("builtin 'cd' not implemented")
    return .Continue
  } else  {
    pid, err := os.fork()
    if err != os.ERROR_NONE {
      fmt.println("faild to fork")
      return .Exit
    } else if pid == 0{
      err = os.execvp(prog, args)
      if err != os.ERROR_NONE {
      fmt.println("Error in program")
      return .Exit
      }
      return .Continue
    }
    return .Continue
  }
}


read_input :: proc() -> (int, Error) {
  fmt.print("⚒: ")
  n, err := os.read(os.stdin, buf[:])
  if err < 0 {
    fmt.println("Error reading input")
    return 0, .No_Input
  } else {
    return n, .None
  }
}

main  :: proc ()  {
  fmt.println("this is a test")
  for {
    n, err := read_input()
    arr2 := strings.split(string(buf[0:n - 1]), " ")
    fmt.println("in read_input", arr2)
    state := handle_input(arr2)
    if state == .Exit {
      return
    }
    if err != .None {
      return
    }
  }
  return
}
