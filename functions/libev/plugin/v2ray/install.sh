#? Description:
#?   Install Shadowsocks v2ray plugin on server.
#?   The installation requires Go version 1.6+.
#?   The installation requires root privilege to write into path `XSH_SS_LIBEV_PLUGIN_V2RAY_BIN`.
#?   The installation target is defined by `XSH_SS_LIBEV_PLUGIN_V2RAY_BIN`.
#?
#? Usage:
#?   @install
#?
#? @xsh /trap/err -eE
#?
function install () {
    declare tmpdir=/tmp/v2ray-plugin-$RANDOM
    git clone --depth 1 https://github.com/shadowsocks/v2ray-plugin "${tmpdir:?}"
    (cd "${tmpdir:?}" && go build && /bin/cp -a v2ray-plugin "${XSH_SS_LIBEV_PLUGIN_V2RAY_BIN}")
    rm -rf "${tmpdir:?}"
}