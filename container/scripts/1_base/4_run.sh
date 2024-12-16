# Function to log and run a command
run() {
  # Log the command being run
  log "$B#### $@$rB"
  
  # Run the command passed to the function
  "$@"
}
