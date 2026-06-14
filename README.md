[![GitHub tag](https://img.shields.io/github/v/tag/xsh-lib/shadowsocks?sort=date)](https://github.com/xsh-lib/shadowsocks/tags)
[![GitHub](https://img.shields.io/github/license/xsh-lib/shadowsocks.svg?style=flat-square)](https://github.com/xsh-lib/shadowsocks/)
[![GitHub last commit](https://img.shields.io/github/last-commit/xsh-lib/shadowsocks.svg?style=flat-square)](https://github.com/xsh-lib/shadowsocks/commits/main)

[![CI](https://github.com/xsh-lib/shadowsocks/actions/workflows/ci.yml/badge.svg)](https://github.com/xsh-lib/shadowsocks/actions/workflows/ci.yml)
[![GitHub issues](https://img.shields.io/github/issues/xsh-lib/shadowsocks.svg?style=flat-square)](https://github.com/xsh-lib/shadowsocks/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/xsh-lib/shadowsocks.svg?style=flat-square)](https://github.com/xsh-lib/shadowsocks/pulls)

# xsh-lib/shadowsocks

xsh Library - Shadowsocks toolkit.

About xsh and its libraries, check out [xsh document](https://github.com/alexzhangs/xsh)

## Requirements

`xsh-lib/shadowsocks` is tested in CI ([GitHub Actions](https://github.com/xsh-lib/shadowsocks/actions/workflows/ci.yml)) on every push and pull request, across the following shell/OS combinations:

| Shell | Version | OS                    | Tested |
|-------|---------|-----------------------|:------:|
| bash  | 3.2     | macOS                 | ✅     |
| bash  | 4.4     | Linux (rockylinux:8)  | ✅     |
| bash  | 5.x     | Linux (ubuntu-latest) | ✅     |
| bash  | 5.x     | macOS (Homebrew)      | ✅     |
| zsh   | 5.x     | Linux (ubuntu-latest) | ✅     |
| zsh   | 5.x     | macOS                 | ✅     |

zsh utilities run under xsh's ksh emulation and require **xsh ≥ 0.7.0**.

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
