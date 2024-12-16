CONTAINER_VALUE="from container"

host_stuff=$(cat -v <<EOF
  for i in 1 2 3; do
    echo -e "Host $U$CONTAINER_VALUE$rU stuff \$i..."
    if [ "\$((\$i%2))" = "0" ]; then echo "Non blocking error" >&2; fi
    sleep 0.5
  done
EOF
)

run_host "$host_stuff"
run_host "echo Done;echo ...almost >&2"