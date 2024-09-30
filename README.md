# PV Exfiltration Monitoring Helm Chart

This Helm chart deploys a Persistent Volume (PV) Exfiltration Monitoring solution that uses eBPF to monitor file operations within Kubernetes. It provides the flexibility to choose different monitoring systems like Prometheus, Datadog, or fallback to local file logging.

## Features:
- Real-time monitoring of PVs for file operations (read/write/delete).
- Configurable alerts for unauthorized file accesses and large data transfers.
- Flexible integration with Prometheus, Datadog, or file-based logging.

## Quick Start:

1. **Add the Helm repository**:
   ```bash
   helm repo add pv-exfiltration-monitor https://your-helm-repo-url.com
