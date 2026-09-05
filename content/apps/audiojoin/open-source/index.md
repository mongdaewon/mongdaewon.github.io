---
title: "Open Source - AudioJoin"
description: "The open source software included in AudioJoin, its license, and where to get its source code."
layout: "single"
---

**AudioJoin - Merge and Trim Audio Files**

Last updated: September 5, 2026

*This page is provided in English only.*

## LAME 3.100

AudioJoin includes the [LAME MP3 encoder](https://lame.sourceforge.io/), © 1998–2017 The LAME Project. LAME is distributed under the **GNU Library General Public License, version 2, or (at your option) any later version**. AudioJoin distributes it under **version 2.1** ([full text](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)).

Apple does not provide an MP3 encoder on iPhone or iPad, so AudioJoin uses LAME to write MP3 files. The encoding runs entirely on your device — no audio is uploaded anywhere.

## How it is linked

LAME is built as a **dynamic framework** and embedded in the app, rather than compiled into the app binary. That is what §6(a) of the license asks for: anyone can replace the library with their own build of LAME without needing any part of AudioJoin.

## What we changed

The source is upstream LAME 3.100, unmodified except for one line. Version 3.100 lists a symbol in its export file (`lame_init_old`) that no longer exists in the code, which stops the library from linking at all on Apple platforms. The build script removes that one line before compiling.

Nothing else is patched. The change is visible in the build script itself, so reading the script shows you exactly what differs from upstream.

## Getting the source

The LAME source tarball and the script that builds the framework are published here:

**[github.com/mongdaewon/audiojoin-lame](https://github.com/mongdaewon/audiojoin-lame)**

The repository contains the upstream LAME 3.100 tarball, its checksum, and `build-lame.sh`, which downloads (or verifies) the tarball, applies the one-line fix, and produces the `lame.xcframework` that AudioJoin embeds. Running it reproduces the exact library that ships with the app.

AudioJoin's own source code is not part of that repository and is not covered by the LGPL — the obligation is to make the library's source available, not the application's.

## Relinking with a different version of LAME

If you want AudioJoin built against a newer or differently configured LAME, email us and we will ship an update with it.

Email: mongdaewon@naver.com
