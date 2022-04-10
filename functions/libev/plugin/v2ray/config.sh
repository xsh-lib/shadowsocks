#? Description:
#?   Add v2ray plugin config to Shadowsocks server config.
#?   The following JSON properties will be added or updated if already exists:
#?     * plugin
#?     * plugin_opts
#?
#?   To enable TLS mode, the options -n, -c and -k must be used together.
#?   The config requires Python.
#?
#? Usage:
#?   @config [-n DOMAIN] [-c CERTIFICATE] [-k KEY]
#?           [-b V2RAY_BINARY] [-f SHADOWSOCKS_CONFIG]
#?           [-w]
#?
#? Options:
#?   [-n DOMAIN]
#?
#?   Domain name.
#?
#?   [-c CERTIFICATE]
#?
#?   TLS Certificate file.
#?   The existence of the certificate won't be checked.
#?
#?   [-k KEY]
#?
#?   Key file for the TLS Certificate.
#?   The existence of the key won't be checked.
#?
#?   [-b V2RAY_BINARY]
#?
#?   Specify the v2ray plugin binary, the default value is defined by `XSH_SS_LIBEV_PLUGIN_V2RAY_BIN`.
#?   The existence of the binary won't be checked.
#?
#?   [-f SHADOWSOCKS_CONFIG]
#?
#?   Specify the Shadowsocks config file, the default value is defined by `XSH_SS_LIBEV_CFG`.
#?
#?   [-w]
#?
#?   Write back the config to Shadowsocks config file.
#?
#? Output:
#?   The altered config.
#?
#? @xsh /trap/err -eE
#?
function config () {
    declare OPTIND OPTARG opt

    declare domain cert key \
            binary=$XSH_SS_LIBEV_PLUGIN_V2RAY_BIN \
            conf=$XSH_SS_LIBEV_CFG \
            save=0

    while getopts n:c:k:b:f:w opt; do
        case $opt in
            n)
                domain=${OPTARG:?}
                ;;
            c)
                cert=${OPTARG:?}
                ;;
            k)
                key=${OPTARG:?}
                ;;
            b)
                binary=${OPTARG:?}
                ;;
            f)
                conf=${OPTARG:?}
                ;;
            w)
                save=1
                ;;
            *)
                return 255
                ;;
        esac
    done

    if [[ ! -f ${conf} ]]; then
        xsh log error "not found config file: %s" "${conf}"
        return 255
    fi

    declare plugin_opts="server;loglevel=none"
    if [[ -n ${domain} && -n ${cert} && -n ${key} ]]; then
        plugin_opts=$(printf "%s;tls;host=%s;cert=%s;key=%s" "${plugin_opts}" "${domain}" "${cert}" "${key}")
    fi

    declare json py_exp output
    json=$(cat "${conf}")
    py_exp=$(printf 'dict(list({JSON}.items()) + [("plugin","%s"), ("plugin_opts","%s")])' "${binary}" "${plugin_opts}")
    output=$(xsh /json/parser eval "${json}" "${py_exp}")


    if [[ ${save} -eq 0 ]]; then
        printf "%s" "${output}"
    else
        printf "%s" "${output}" | tee "${conf}"
    fi
}