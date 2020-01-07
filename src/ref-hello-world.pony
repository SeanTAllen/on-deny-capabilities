actor Main
  new create(env: Env) =>
    let msg: String ref = "Hello World!".clone()
    env.out.print(msg)
