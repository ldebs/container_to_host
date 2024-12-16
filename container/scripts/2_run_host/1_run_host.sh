run_host(){
  log "$HC#### $@$NC$I"

  # Read from HOST_OUT and HOST_ERR in real-time
  while true; do cat $HOST_OUT; done &
  opid=$!
  while true; do cat $HOST_ERR >&2; done &
  epid=$!

  # Capture status result
  res=$(mktemp -u)
  $(cat $HOST_STS > $res) &
  spid=$!

  # Send command to host
  echo "$@" > $HOST_CMD

  # Wait for the background process to finish reading status from HOST_STS
  wait $spid

  # Kill and wait the read processes
  kill $opid $epid
  wait $opid > /dev/null 2>&1
  wait $epid > /dev/null 2>&1
  
  # capture and delete the result
  status=$(cat $res)
  rm $res

  log "$HC#### end status $status$N"
  sync
  return $status
}

# check for needed env var for pipes/files
check_env HOST_CMD HOST_STS HOST_OUT HOST_ERR HOST_IN
