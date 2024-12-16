host_error=$(cat <<EOF
  echo Execute order 66. >&2
  exit 66
EOF
)

run_host "$host_error"
