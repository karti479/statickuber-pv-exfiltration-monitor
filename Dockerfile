FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    bpftrace \
    linux-headers-$(uname -r) \
    bash \
    curl \
    && apt-get clean

# Copy the monitoring script
COPY monitor-ebpf.sh /usr/local/bin/monitor-ebpf.sh

# Make the script executable
RUN chmod +x /usr/local/bin/monitor-ebpf.sh

# Entrypoint to execute the monitoring script
ENTRYPOINT ["/usr/local/bin/monitor-ebpf.sh"]
