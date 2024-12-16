container_stuff() {
    echo Container stuff...
    sleep 1
    echo Other container stuff...
    sleep 1
    echo -e ${OC}OK$NC
}

run container_stuff
