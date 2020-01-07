actor Main
  new create(env: Env) =>
    let msg: String val = "Hello World!"
    env.out.print(msg)
