# Prints the arguments to standard error with an additional message indicating that a fatal error has occurred the exit with status 1.
error() {
    echo -e "$EC$@" >&2
    echo -e "${B}Fatal error$N" >&2
    sync
    exit 1
}

# Indicate the status and the line number where an error occured
handle_error() {
    msg="$FILE: Error [$1] occurred on command at line $2"
    error "$msg"
}

# Set up a trap ERR signal
trap 'handle_error "$?" "$LINENO"' ERR

# Checks if each argument is set as an environment variable, and if not, calls the error function with an appropriate error message.
check_env() {
  for v in $@; do
    if [ "$(eval echo \$"$v")" = "" ]; then error "$v environment variable is empty"; fi
  done
}
