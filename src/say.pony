primitive Say
  fun say(msg: String, out: OutStream) =>
    let x = "We say '" + msg + "'"
    out.print(x)
