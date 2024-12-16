CONTAINER_VALUE="from container"

host_stuff=$(cat -v <<EOF
  echo -e "Host $U$CONTAINER_VALUE$rU stuff..."
  sleep 1
  echo With some non blocking errors >&2
  sleep 1
EOF
)

run_host "$host_stuff"
run_host "echo Done;echo ...almost >&2"