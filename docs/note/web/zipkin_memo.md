---
title: Zipkin 備忘録
posted_date: 2020-07-30
tags:
- web
---

!!! info
    書き足していく

#### Http Client の呼び出し先の service name を指定する方法[^1]

```kotlin
HttpTracing.create(tracing).clientOf("hogeRemoteServer")
```


[^1]: https://github.com/openzipkin/brave/blob/release-5.12.4/instrumentation/http/src/main/java/brave/http/HttpTracing.java#L83-L104
