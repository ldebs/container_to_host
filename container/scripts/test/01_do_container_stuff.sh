container_stuff() {
    echo Container stuff...
    sleep 0.5
    echo Other container stuff...
    sleep 0.5
    echo -e ${OC}OK$NC
}

run container_stuff
