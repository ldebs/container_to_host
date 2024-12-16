error(){
    echo -e "$EC$@" >&2
    echo -e "${B}Fatal error$N" >&2
    sync
    exit 1
}

handle_error() {
    msg="$FILE: Error [$1] occurred on command at line $2"
    error "$msg"
}

trap 'handle_error "$?" "$LINENO"' ERR

check_env() {
  for v in $@; do
    if [ "$(eval echo \$"$v")" = "" ]; then error "$v environment variable is empty"; fi
  done
}
