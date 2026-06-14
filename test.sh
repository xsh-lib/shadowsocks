#!/bin/bash
#
# Smoke + functional tests for xsh-lib/shadowsocks. Plain assertions, no
# external test framework (mirrors xsh-lib/core/test.sh).
#
# Usage:
#   xsh load xsh-lib/core xsh-lib/shadowsocks   # one-time
#   bash test.sh                                # or: zsh test.sh
#

# Make the `xsh` function available when run as a child process. Under bash it
# is inherited as an exported function (no-op here); zsh cannot export functions,
# so a child `zsh test.sh` sources ~/.xshrc to define xsh as a real zsh function.
if ! type xsh 2>/dev/null | grep -q 'function'; then
    # shellcheck source=/dev/null
    . ~/.xshrc
fi

set -e -o pipefail

xsh log info "xsh list ss/"
xsh list 'ss/*' >/dev/null

# ----------------------------------------------------------------------------
# import-smoke: every function utility sources cleanly (under zsh each is
# sourced with the injected `emulate -L ksh`).
# ----------------------------------------------------------------------------
xsh log info "import-smoke: all ss function utilities"
while read -r __lpue; do
    [ -z "$__lpue" ] && continue
    xsh import "$__lpue"
done < <(xsh list 'ss/*' | awk '$1 == "[functions]" {print $2}')

# ----------------------------------------------------------------------------
# ss/libev/plugin/v2ray/config — rewrites an ss-libev JSON config to add the
# v2ray-plugin `plugin`/`plugin_opts` keys (pure transform via /json/parser).
# ----------------------------------------------------------------------------
xsh log info "ss/libev/plugin/v2ray/config (plugin keys)"
__cfg=$(mktemp "${TMPDIR:-/tmp}/xsh-ss-test.XXXXXXXX")
printf '%s' '{"server":"0.0.0.0","server_port":8388,"password":"pw","method":"aes-256-gcm"}' > "$__cfg"

__out=$(xsh ss/libev/plugin/v2ray/config -f "$__cfg" -b /usr/local/bin/v2ray-plugin)
case $__out in
    *'/usr/local/bin/v2ray-plugin'*) : ;;
    *) echo "FAIL: plugin not added: $__out" >&2; exit 1 ;;
esac
case $__out in
    *'server;loglevel=none'*) : ;;
    *) echo "FAIL: plugin_opts missing: $__out" >&2; exit 1 ;;
esac

xsh log info "ss/libev/plugin/v2ray/config (-n/-c/-k adds tls opts)"
__out_tls=$(xsh ss/libev/plugin/v2ray/config -f "$__cfg" -b /usr/local/bin/v2ray-plugin \
    -n example.com -c /tmp/cert.pem -k /tmp/key.pem)
case $__out_tls in
    *'tls'*'host=example.com'*'cert=/tmp/cert.pem'*'key=/tmp/key.pem'*) : ;;
    *) echo "FAIL: tls plugin_opts missing: $__out_tls" >&2; exit 1 ;;
esac
rm -f "$__cfg"

xsh log info "ss/libev/plugin/v2ray/config (missing config file = error)"
! xsh ss/libev/plugin/v2ray/config -f /no/such/file 2>/dev/null

echo
echo "All tests passed."

exit
