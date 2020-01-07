### On Deny Capabilities for Safe, Fast Actors

Note:

- note test
---

Sean T. Allen

Member of the Pony core team

@SeanTAllen

www.seantallen.com




---

What to expect.

Basic introduction to Pony.

Lots of terms.

---

This is a talk about concurrency.

This is a talk about going fast.

---

This talk is about Pony and Deny Capabilities.

---

Actor model. Perhaps you've heard of erlang.
Basics:

- actors "protect a resource"
- process messages
- communicate with other actors via messaging

---

Example:

tcp connection

---

What makes for safety?

---

Some stuff on safety

---

Actors are great for safety.

In particular, data-races.

---

Data race vs race condition

---

What is Fast?

---

Coordination avoidance.

Avoid contention.

Locks etc.

---

How actors can help with fast.

---

How actors can hurt fast.

---

Deny capabilities- doing unsafe fast things safely.

---

A bit of background on capabilities

<add references to overview>

---

Deny capabilities are about access to things, access to data

Statically confirm you aren't doing something unsafe.

---

Deny capabilities are about alias control.

---

What is an alias?

---

There's no platonic ideal for deny capabilities.

(different languages could provide different capabilities)
(pony might change some of its capabilities in the future).

---

Let's look at some capabilities.

- ref
- val
- iso
- tag

(there are a couple of others)

---

I like to map capabilities onto rules that I learned in the 90s when writing lots of multithreaded C++. Those rules helped me keep from segfaulting my code.

---

Examples...

with errors

---?color=linear-gradient(100deg, white 90%, #BE5869 10%)

```pony
actor Main
  new create(env: Env) =>
    env.out.print("Hello World!")
```




