non_blocking_error() {
    echo Risky container stuff...
    sleep 1
    echo Non blocking error container stuff ! >&2
    sleep 1
    
    echo -e ${CC}Almost ${OC}OK$NC
}

run non_blocking_error
