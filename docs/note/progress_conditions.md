---
title: Progress conditions
date: 2020-07-28
tags:
- concurrent
---

並行プログラムの主要な(?) progress conditions,

- deadlock-free
- starvation-free
- lock-free
- wait-free
- obstruction-free

についての雑メモ.

## これらの関係

![](https://i.imgur.com/HDdGp0Q.png)

from [[Herlihy+, 2011]][1]

## Lock-free
A method is **lock-free** if **some** thread that calls that method eventually returns.

## Wait-free
A method is **wait-free** if **every** thread that calls that method eventually returns.

## Wait-free bounded
TODO

## Obstruction-free

We say that a method call executes **in isolation** for a duration if no other threads take steps during that time.

A method is **obstruction-free** if every thread that calls that method returns if that thread executes in isolation for long enough.

The obstruction-free property requires the scheduler to allow each thread to run in isolation for a sufficient duration.

## Non-blocking properties らの関係性

wait-free => lock-free => obstruction-free

## Deadlock-free and starvation-free が要求していること

1. These properties guarantee progress only if each thread eventually leaves each critical section.

2. deadlock-free requirement constrains both
    - the scheduler, which cannot halt a thread in a critical section,
    - and the software, which must use the lock correctly

## Refs:

- papers:
    - [Herlihy, Maurice, and Nir Shavit. "On the nature of progress." International Conference On Principles Of Distributed Systems. Springer, Berlin, Heidelberg, 2011][1]
- books:
    - [Herlihy, Maurice, and Nir Shavit. The art of multiprocessor programming. Morgan Kaufmann, 2011][5] (& [和訳版][6])
- others:
    - [Blog: Lock-Free and Wait-Free, definition and examples][2]
    - [Wikipedia: Non-blocking algorithm][3]
    - [togetter: lock-freeとobstruction-freeとwait-freeの違い][4]

[1]: https://www.cs.tau.ac.il/~shanir/progress.pdf
[2]: http://concurrencyfreaks.blogspot.com/2013/05/lock-free-and-wait-free-definition-and.html
[3]: https://en.m.wikipedia.org/wiki/Non-blocking_algorithm
[4]: https://togetter.com/li/36803
[5]: https://dl.acm.org/doi/book/10.5555/2385452
[6]: https://amzn.to/2Pcv4Qr
