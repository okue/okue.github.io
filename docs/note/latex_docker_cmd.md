---
title: 5秒でLaTeX実行したいとき
posted_date: 2020-07-28
---

```
docker pull paperist/alpine-texlive-ja
docker run --rm -v ${PWD}:/workdir paperist/alpine-texlive-ja pdflatex ...
```

[^1]: https://qiita.com/Shitimi_613/items/9706d57fb7bc17cbed0e
[^2]: https://github.com/Paperist/docker-alpine-texlive-ja
