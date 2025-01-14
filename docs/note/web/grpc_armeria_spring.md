---
title: Armeria x Spring x Kotlin x gRPC
date: 2021-01-30
tags:
- armeria
- kotlin
- web
- grpc
---

:fontawesome-brands-github: [okue/grpc-samples-in-kotlin]

Armeria, Spring Boot を使って, gRPC サーバーを Kotlin で実装する例.

### Logging

[Armeria] の大きな魅力は logging や tracing が簡単にできること.

特に Logback 用に提供されている [RequestContextExportingAppender][1] は強力で,
[logback.xml] をこんな感じに含めるだけで, リクエストに関する情報が MDC に含まれてくれる.


### Error handling

エラーハンドリングは, `io.grpc.ServerInterceptor` を使ってやっている.

- [ErrorHandlingServerInterceptor.kt](https://github.com/okue/grpc-samples-in-kotlin/blob/main/grpc-kotlin-armeria-spring/src/main/kotlin/example/kt/armeria/spring/ErrorHandlingServerInterceptor.kt)
- https://grpc.io/docs/guides/error/#richer-error-model

この feature https://github.com/line/armeria/issues/3307 が実装されたら, `io.grpc.ServerInterceptor` を書かずにもっとわかりやすい実装ができそうだ.


### Kotlin coroutine

Armeria のリクエストコンテキストはスレッドローカルに保存されている.

コルーチンを Armeria の提供しない Executor, Dispatchers.IO 等にディスパッチする場合は, リクエストコンテキストをしっかり伝搬させる必要がある.

そのため `kotlinx.coroutines.ThreadContextElement` を実装した [ArmeriaRequestContext.kt] を使うようにしている.

また, grpc-kotlin を使う場合, Armeria は [`useBlockingTaskExecutor` オプションの有無によってディスパッチされるスレッドが異なる][2].


[okue/grpc-samples-in-kotlin]: https://github.com/okue/grpc-samples-in-kotlin/tree/main/grpc-kotlin-armeria-spring
[Armeria]: https://armeria.dev/
[logback.xml]: https://github.com/okue/grpc-samples-in-kotlin/blob/main/grpc-kotlin-armeria-spring/src/main/resources/logback.xml
[ArmeriaRequestContext.kt]: https://github.com/okue/grpc-samples-in-kotlin/blob/main/grpc-kotlin-armeria-spring/src/main/kotlin/example/kt/armeria/spring/ArmeriaRequestContext.kthttps://github.com/okue/grpc-samples-in-kotlin/blob/main/grpc-kotlin-armeria-spring/src/main/kotlin/example/kt/armeria/spring/ArmeriaRequestContext.kt
[1]: https://armeria.dev/docs/advanced-logging/
[2]: https://github.com/line/armeria/blob/master/grpc/src/main/java/com/linecorp/armeria/server/grpc/ArmeriaCoroutineContextInterceptor.java#L37-L41
