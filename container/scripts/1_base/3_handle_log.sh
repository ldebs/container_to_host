# Function for logging with colors
log() {
  echo -e "$@"
}

# Function for logging debug messages
logdebug() {
  log "${DC}$@$NC" >&2
}

# Function for logging error messages
logerror() {
  log "$EC$@$NC" >&2
}

# Function for handling logs, either to a file or to standard output
handle_log() {
  if [ "$LOG_FILE" != "" ]; then
    touch "$LOG_FILE"
    exec > >(tee -a "$LOG_FILE") \
        2> >(while read -r line; do logerror "$line"; done 2>&1 | tee -a "$LOG_FILE"; sync)
  else
    exec 2> >(while read -r line; do logerror "$line"; done)
  fi
}
