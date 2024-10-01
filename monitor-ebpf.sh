#!/bin/bash

# Check if bpftrace is installed
if ! command -v bpftrace &> /dev/null; then
    echo "Error: bpftrace is not installed."
    exit 1
fi

# Check if the mount path exists
MOUNT_PATH="/mnt/data"
if [ ! -d "$MOUNT_PATH" ]; then
    echo "Error: Mount path $MOUNT_PATH does not exist."
    exit 1
fi

# Correct string comparison in bpftrace
bpftrace -e 'tracepoint:syscalls:sys_enter_openat /str(args->filename)[0:9] == "/mnt/data"/ {
    printf("File opened: %s\n", str(args->filename));
}' || { echo "Error: bpftrace execution failed."; exit 1; }

# Graceful shutdown handling
trap "echo 'Exiting eBPF monitor'; exit 0" SIGTERM SIGINT

