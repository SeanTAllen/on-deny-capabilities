## On Deny Capabilities for Safe, Fast Actors

---

### Sean T. Allen

Member of the **Pony** core team

[@SeanTAllen](https://twitter.com/seantallen)

[www.seantallen.com](https://www.seantallen.com)

---

This is a talk about **concurrency**.

---

This is a talk about **going fast**.

---

This talk is about **Pony** and **Deny Capabilities**.

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

#### Data race freedom

note:

how many folks know the difference between a data race and a race condition?

---

#### Data race

Two memory accesses attempts where both:

@ul[spaced]
- Target the same location
- Are performed concurrently by two threads
- Are not reads
- Are not synchronization operations
@ulend

---

#### The actor model can help prevent data races

@ul[spaced]
- All variables are "protected" by an actor - no global variables
- Actors are processed sequentially 1 message a time by a single thread
@ulend

@snap[south span-100]
@[1](Actors are "synchronization operations")
@[2](But sending data from one actor to another can cause problems...)
@snapend

---

### Fast

---

#### How to go fast

@ul[spaced]
- Avoid coordination @note[global knowledge, silence is golden, meetings]
- Avoid contention @note[locks]
- Measure it @note[you only get what you measure]
@ulend

---

#### How actors can help with fast

@ul[spaced]
- make coordination explicit
- make contention explicit
@ulend

---

#### How actors can hurt fast

@ul[spaced]
- naive implementations can be very slow
- message queues are points of contention
- locks are usually faster than a large memory copy
@ulend

---

**Deny capabilities** for **safe**, **fast** actors

---

### Deny capabilities

doing unsafe fast things safely

note:

talk a bit about object capabilities. reference capabilities. deny certain things.

---

### Deny capabilities

statically confirm you aren't doing something unsafe

---

### Alias control

---

#### What is an alias?

@ul[spaced]
- Aliases are "names" for things in memory
- Aliases allow you to access a thing at a location
@ulend

---

#### Aliases in Pony

@ul[spaced]
- When you **assign** a value to a variable or a field.
- When you **pass** a value as an argument to a method.
- When you **call a method**, an alias of the receiver of the call is created. It is accessible as `this` within the method body.
@ulend

---

#### Count the aliases

@code[pony](src/say.pony)

@snap[south span-100]
@[2, zoom-14](`msg` and `out` are aliases)
@[3, zoom-14](`x` is an alias)
@[4, zoom-14](`x` is aliased when passed to `print`)
@[1-5]()
@snapend

---

### Capabilities

Annotations on code that can be used to statically confirm some property

---

@code[pony](src/capabilities-example.pony)

@snap[south span-100]
@[3, zoom-14](`val` is a capability)
@[3, zoom-14](`val` is part of the type at compile-time)
@[3, zoom-14](`val` says "the alias `msg` to the String `Hello World` is immutable")
@snapend

---

#### What can you deny?

@ul[spaced]
- Reading
- Mutating
- Aliasing
- Sending
- Sharing
@ulend

---

#### Some capabilities

@ul[spaced]
- ref @note[plain old mutable)
- val @note[plain old immutable]
- iso @note[only 1 alias]
- tag @note[only identity]
@ulend

note:

I like to map capabilities onto rules that I learned in the 90s when writing lots of multithreaded C++. Those rules helped me keep from segfaulting my code.

---

#### ref

@ul[spaced]
- **allows** reading
- **allows** mutation
- **denies** sending
- **allows** unlimited aliases
- **denies** sharing
@ulend

---

#### iso

@ul[spaced]
- **allows** reading
- **allows** mutation
- **allows** sending
- **denies** aliasing
- **denies** sharing
@ulend

---

#### val

@ul[spaced]
- **allows** reading
- **denies** mutation
- **allows** sending
- **allows** unlimited aliases
- **allows** sharing
@ulend

---

#### tag

@ul[spaced]
- **denies** reading
- **denies** mutation
- **allows** aliasing
- **allows** sharing
- **allows** sending
@ulend

---

@snap[north-west span-55]
**Readable**

@ul[spaced]
- ref
- iso
- val
@ulend
@snapend

@snap[north-east span-55 fragment]
**Mutable**

@ul[spaced]
- ref
- iso
@snapend
@ulend

@snap[south-east span-55 fragment]
**Aliasable**

@ul[spaced]
- ref
- val
- tag
@ulend
@snapend

@snap[south-west span-55 fragment]
**Sendable**

@ul[spaced]
- val
- tag
- iso
@ulend
@snapend

@snap[midpoint span-55 fragment]
**Shareable**

@ul[spaced]
- val
- tag
@snapend
@ulend

---

#### There's no platonic ideal for deny capabilities.

note:

Different languages could provide different capabilities

Pony might change some of its capabilities in the future

---

### Code (and errors!)

---

@code[pony](src/ref-hello-world.pony)

@snap[south span-100]
@[3, zoom-14](`Hello World` String is mutable)
@[4, zoom-14](send `msg` to actor `out`)
@[3, zoom-14](`ref` isn't sendable)
@[4, zoom-14](which will result in an error here)
@snapend

---

@code[text, zoom-6](src/ref-hello-world-error.txt)

@snap[south span-100]
@[2-3, zoom-14](`msg` isn't the correct type)
@[6-7, zoom-14](`msg` is `String ref`)
@[9-11, zoom-14](`print` requires `String val` or `Array[U8] val`)
@snapend

---

The compiler just statically checked our data sharing.

@snap[fragment]
Let's fix it
@snapend

---

@code[pony](src/hello-world.pony)

@snap[south span-100]
@[3, zoom-14](`Hello World` String is immutable)
@[4, zoom-14](send `msg` to actor `out`)
@[3, zoom-14](`val` is sendable)
@[4, zoom-14](no error here)
@snapend

---

More information...

https://www.seantallen.com/talks/deny-capabilities/
