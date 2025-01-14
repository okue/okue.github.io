---
title: Protocol Buffers Style
posted_date: 2020-07-28
tags:
- grpc
---

Proto の style guide を読んで, 自分ならこう書いていこうもの.
Code style は大事.

- https://developers.google.com/protocol-buffers/docs/style
- https://buf.build/docs/style-guide

## TL; DR

filename = shouldbe/lower_snake_case/hoge.proto
```proto
 // This is the description about this proto file.
 // ......
 
 syntax = "proto3";
 
 package shoulebe.lower_snake_case;
 
 import "google/protobuf/empty.proto";
 
 option java_package = "com.fuga.grpc.hoge";
 option java_multiple_files = false;
 
 // service 定義内は, すべて UpperCamelCase で名付ける
 service HogeService {
     rpc Update (UpdateRequest) returns (UpdateResponse) {
     }
 }
 
 // メッセージ名は, UpperCamelCase
 message MyMessage {
     // フィールド名は, lower_snake_case で
     // repeated なら, 複数形に
     repeated string user_keys = 1;
 }
 
 enum HogeEnum {
     // UPPER_SNAKE_CASE で名付ける
     // 1つ目の enum value は, デフォルト値として `*_UNSPECIDIED` を用意する
     HOGE_ENUM_UNSPECIFIED = 0;
     HOGE_FIRST_VAL = 1;
 }
```

## File formatting
- 一行の長さに, 特別制限は設けない.
- インデントは, スペース4文字とする.

## File structure
- ファイル名は, lower_snake_case で付ける.
- ファイルは, 次の順で書いていく:
  - ファイルの概要
  - syntax = "proto3" 宣言
  - パッケージ名
  - import 文
  - ファイルオプション
  - その他

## File options
- `java_package`, `java_multiple_files` この辺は運用に合わせて決めたいところ.

## Packages
- パッケージ名は, lower_snake_case で付ける.
- パッケージ名とディレクトリが一致するように, ファイルを配置する

## Message and field name
- メッセージ名は, UpperCamelCase で付ける.
- フィールド名は, lower_snake_case で付ける.

```proto
 message SongServerRequest {
     string song_name = 1;
 }
```

## Repeated fields
- フィールド名を複数形にする

```proto
 message SongServerRequest {
     repeated string keys = 1;
     ...
     repeated MyMessage accounts = 17;
 }
```

## Enums
- enum名は, UpperCamelCase で付ける.
- enum value名は, UPPER_SNAKE_CASE で付ける.
- zero value enum として, ENUM_NAME_UNSPECIFIED を必ず定義する.

```proto
 enum Foo {
     // zero value enum
     FOO_UNSPECIFIED = 0;
     FOO_FIRST_VALUE = 1;
     FOO_SECOND_VALUE = 2;
 }
```

## Services
- サービス名およびメソッド名は, UpperCamelCase で定義する.

```proto
 service FooService {
     rpc GetSomething(FooRequest) returns (FooResponse);
 }
```

## Tips

- Protobuf Support プラグイン
    - https://plugins.jetbrains.com/plugin/8277-protobuf-support
    - シンタックスハイライト等, 最低限書けるようになる.
- Buf
    - https://github.com/bufbuild/buf
- Protolint
    - https://github.com/yoheimuta/protolint
    - ユーザ数や機能の多さ, ドキュメンテーションは Buf に劣るかもしれないが, IDEA plugin がある.
        - https://github.com/yoheimuta/intellij-protolint

IntelliJ IDEA での proto を書き心地は, あまりよくない.
いいプラグインがあれば知りたいところ.
