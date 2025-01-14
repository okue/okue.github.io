---
title: BlockHound Tips
date: 2020-08-07
---

## BlockHound が Mono#awaitFirst() を検知しないようにする

kotlinx.coroutines (version 1.3.8) が提供する [BlockHound](https://github.com/reactor/BlockHound) integration だと,
アプリケーションを実行してから最初の `Mono#awaitFirst()` の呼び出しを blocking call だと判定する.

というのも, [`contextInjectors`](https://github.com/Kotlin/kotlinx.coroutines/blob/1.3.8/reactive/kotlinx-coroutines-reactive/src/ReactiveFlow.kt#L145) という変数
を初期化するときに `ServiceLoader.load` が実行されるためである.


なので, ReactiveFlow.kt ファイルの static 変数の初期化時の blocking call を無視するようにした.

```kotlin
BlockHound.builder()
    .with(CoroutinesBlockHoundIntegration())
    .allowBlockingCallsInside(
        "kotlinx.coroutines.reactive.ReactiveFlowKt", "<clinit>"
    )
    .install()
```

