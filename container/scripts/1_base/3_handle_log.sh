log() {
  echo -e "$@"
}

logdebug() {
  log "${DC}$@$NC" >&2
}

logerror() {
  log "$EC$@$NC" >&2
}

handle_log() {
  if [ "$LOG_FILE" != "" ]; then
    touch "$LOG_FILE"
    exec > >(tee -a "$LOG_FILE") \
        2> >(while read -r line; do logerror "$line"; done | tee -a "$LOG_FILE")
  else
    exec 2> >(while read -r line; do logerror "$line"; done)
  fi
}
