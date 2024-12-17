# Function to log and run a command into the host
run_host(){
  log "$HC#### $@$NC$I"

  # Read from HOST_OUT and HOST_ERR in real-time
  tmpOut=$(mktemp -u)
  while true; do cat $HOST_OUT | tee -a $tmpOut; sync; done &
  opid=$!
  tmpErr=$(mktemp -u)
  while true; do cat $HOST_ERR | tee -a $tmpErr >&2; sync; done &
  epid=$!

  # Send command to host
  echo "$@" > $HOST_CMD

  # Wait for status result
  status=$(cat $HOST_STS)

  # Kill and wait the read processes
  kill $opid $epid
  wait $opid > /dev/null 2>&1 || true
  wait $epid > /dev/null 2>&1 || true

  # set the REPLY variables
  export REPLY_OUT=$(cat $tmpOut)
  export REPLY_ERR=$(cat $tmpErr)
  rm $tmpOut $tmpErr
  
  log "$HC#### end status $status$N"
  sync
  return $status
}

# check for needed env var for pipes/files
check_env HOST_CMD HOST_STS HOST_OUT HOST_ERR HOST_IN
