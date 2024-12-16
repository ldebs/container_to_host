non_blocking_error() {
    echo Risky container stuff...
    sleep 0.5
    echo Non blocking error container stuff ! >&2
    sleep 0.5
    
    echo -e ${CC}Almost ${OC}OK$NC
}

run non_blocking_error
