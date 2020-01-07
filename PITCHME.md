## On Deny Capabilities for Safe, Fast Actors

---

### Sean T. Allen

Member of the **Pony** core team

[@SeanTAllen](https://twitter.com/seantallen)

[www.seantallen.com](https://www.seantallen.com)

---

### This is a talk about concurrency.

---

### This is a talk about going fast.

---

### This talk is about Pony and Deny Capabilities.

---

### Actor model

note:

how many people have heard of the actor model?

how many feel like experts?

Erlang. Akka.

---

### Actor model basics

@ul[spaced]
- Actors communicate with other actors via messaging
- Actors process messages @note[sequentially - 1 at a time]
- Actors "protect resources" @note[tcp connection, file]
@ulend

---

### Safe

note:

actors are great for safety. in particular data-races

---

### Data race freedom

note:

how many folks know the difference between a data race and a race condition?

---

### Data race

Two memory accesses attempts where both:

@ul[spaced]
- Target the same location
- Are performed concurrently by two threads
- Are not reads
- Are not synchronization operations
@ulend

---

The actor model doesn't allow for data races

@ul[spaced]
- No global variables
- All variables are "protected" by an actor
- Actors are processed sequentially 1 message a time by a single thread
- Actors are a "synchronization operation"
@ulend

---

### Fast

---

How to go fast...

@ul[spaced]
- Avoid coordination @note[global knowledge, silence is golden, meetings]
- Avoid contention @note[locks]
- Measure it @note[you only get what you measure]
@ulend

---

How actors can help with fast.

---

How actors can hurt fast.

---

### Deny capabilities

doing unsafe fast things safely.

note:

talk a bit about object capabilities. reference capabilities. deny certain things.

---

Deny capabilities are about safe access to data

Statically confirm you aren't doing something unsafe.

---

### Deny capabilities are about alias control.

---

### What is an alias?

@ul[spaced]
- Aliases are "names" for things in memory
- Aliases allow you to access a thing at a location
@ulend

---

### Aliases in Pony

@ul[spaced]
- When you **assign** a value to a variable or a field.
- When you **pass** a value as an argument to a method.
- When you **call a method**, an alias of the receiver of the call is created. It is accessible as `this` within the method body.
@ulend

---

### Count the aliases

```pony
primitive Say
  fun say(msg: String, out: OutStream) =>
    let x = "We say '" + msg + "'"
    out.print(x)
```

@[1, zoom-2](`msg` and `out` are aliases]
@[2, zoom-3](`x` is an alias]

---

Some capabilities:

@ul[spaced]
- ref @note[plain old mutable)
- val @note[plain old immutable]
- iso @note[only 1 alias]
- tag @note[only identity]
@ulend

---

I like to map capabilities onto rules that I learned in the 90s when writing lots of multithreaded C++. Those rules helped me keep from segfaulting my code.

---

There's no platonic ideal for deny capabilities.

@ul[spaced]
- Different languages could provide different capabilities
- Pony might change some of its capabilities in the future
@ulend

---

Examples...

with errors

---?color=linear-gradient(100deg, white 90%, #BE5869 10%)

```pony
actor Main
  new create(env: Env) =>
    env.out.print("Hello World!")
```




