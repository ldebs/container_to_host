host_error=$(cat <<EOF
  read -r order
  echo Execute order \$order. >&2
  exit \$order
EOF
)

echo 55 > $HOST_IN
run_host "$host_error" || echo "Which order ?"
echo 66 > $HOST_IN
run_host "$host_error"
