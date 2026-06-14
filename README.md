# xsh-lib/shadowsocks

xsh Library - Shadowsocks toolkit.

About xsh and its libraries, check out [xsh document](https://github.com/alexzhangs/xsh)

## Requirements

1. bash or zsh

    Tested with bash:
    * 4.3.48 on Linux
    * 3.2.57 on macOS

    The utilities also run under **zsh** (the default shell on modern macOS);
    xsh executes them under zsh's ksh emulation. Tested with zsh 5.x.
    Requires xsh >= 0.7.0 for zsh.

## Dependency

1. xsh-lib/core

    This library depends on [xsh-lib/core](https://github.com/xsh-lib/core) which should be loaded first before to use this library.

    ```bash
    xsh load xsh-lib/core
    ```

## Installation

Assume [xsh](https://github.com/alexzhangs/xsh) is already installed at your local.

To load this library into `xsh` issue below command:

```bash
xsh load xsh-lib/shadowsocks
```

The loaded library can be referred as name `ss`.

## Usage

List available utilities for this library:

```bash
xsh list ss
```
