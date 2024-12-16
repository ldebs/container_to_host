run_host(){
  log "$HC#### $@$NC$I"

  # Send command to host
  echo "$@" > $HOST_IN

  # Capture result
  res=$(mktemp -u)
  $(cat $HOST_CMD > $res) &
  cpid=$!
  
  # Read from HOST_OUT and HOST_ERR in real-time using tail -f
  tail -f $HOST_OUT &
  opid=$!
  tail -f $HOST_ERR >&2 &
  epid=$!

  # Wait for the background process to finish reading from HOST_CMD
  wait $cpid

  # Kill and wait the tail processes
  kill -SIGINT $opid $epid
  sleep 0.1
  kill $opid $epid
  wait $opid > /dev/null 2>&1
  wait $epid > /dev/null 2>&1
  
  # capture and delete the result
  status=$(cat $res)
  rm $res

  log "$HC#### end status $status$N"
  return $status
}

# check for needed env var for pipes/files
check_env HOST_IN HOST_CMD HOST_OUT HOST_ERR
