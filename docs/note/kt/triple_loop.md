---
title: 三重ループをコルーチンで
posted_date: 2020-07-28
tags:
- kotlin
- coroutine
---

Kotlin のコルーチンというか continuation は一度しか呼べないので,
リフレクションで無理やり複数回呼べるようにしないといけない.

リフレクションは, @twitter:relizarov 氏の gist[^1] から拝借した.

<script src="https://gist.github.com/okue/3f3bd89c1baf6dfed732b41bb6668f77.js"></script>

`@RestrictsSuspension` というアノテーションを付けないといけないのは, よく分かってない...

[^1]: https://gist.github.com/elizarov/ddee47f927dda500dc493e945128d661
