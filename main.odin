package main

import "core:fmt"
import "core:os"

main  :: proc ()  {
  fmt.println("this is a test")
  pid, err := os.fork()
  if  err != os.ERROR_NONE {
    fmt.println("Error forking the process")
    return
  }
  if pid > 0 {
    os.execvp("ls", {})
  }
  fmt.println("successfully fork the process")
  fmt.println(pid)

}
