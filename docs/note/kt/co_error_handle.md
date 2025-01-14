---
title: 例外ハンドラと失敗の伝搬
date: 2020-07-27
tags:
- kotlin
- coroutine
---

コルーチンのエラーハンドリングは, めんどうくさい.

## CoroutineExceptionHandler

公式リファレンスに

!!! quote "[Exception Handling and Supervision][coRef1]"
    CoroutineExceptionHandler context element on a root coroutine can be used as generic catch block for this root coroutine and all its children where custom exception handling may take place

とあるように `CoroutineExceptionHandler` は, ルートのコルーチンに子コルーチンの投げた例外をハンドリングさせるために使う.

デフォルトだと, [`Thread.uncaughtExceptionHandler`](https://docs.oracle.com/javase/8/docs/api/java/lang/Thread.html#uncaughtExceptionHandler) が使われて[^1]

```
Exception in thread "DefaultDispatcher-worker-2 @coroutine#2" java.lang.IndexOutOfBoundsException
```

のような標準出力がされるのみで, エラーに気づけない.

`CoroutineExceptionHandler` は [`ServiceLoader`][serviceLoader] 経由でも設定できる[^2][^3]ので, ちゃんとアプリケーションのロガーで WARN か ERROR が残るようにしておくとよい.

## CancellationException

同じのスコープのコルーチンの失敗などによってコルーチンがキャンセルされると, `CancellationException` が投げられる.

このとき, 終了処理などハンドリングが必要なら, ちゃんと `try-catch` か `try-finally` を書かないといけない.

このハンドリングに, `CoroutineExceptionHandler` は使えないのも注意.

---

こんなスクリプトを動かしてみると, なんとなく分かる.

<script src="https://gist.github.com/okue/70b62bc4e835d45becc4146d02ee794b.js"></script>

[coRef1]: https://kotlinlang.org/docs/reference/coroutines/exception-handling.html#coroutineexceptionhandler
[serviceLoader]: https://docs.oracle.com/javase/8/docs/api/java/util/ServiceLoader.html
[^1]: https://github.com/Kotlin/kotlinx.coroutines/blob/1.3.7/kotlinx-coroutines-core/jvm/src/CoroutineExceptionHandlerImpl.kt#L39
[^2]: https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-exception-handler/index.html
[^3]: https://github.com/Kotlin/kotlinx.coroutines/blob/1.3.7/kotlinx-coroutines-core/jvm/src/CoroutineExceptionHandlerImpl.kt#L25-L40
