package kubernetes.security

deny[reason] {
  input.kind == "HelmChart"
  input.version != null
  input.apiVersion == "v2"
  reason := "Helm Chart must specify version and use apiVersion v2."
}

deny[reason] {
  input.kind == "ValuesFile"
  input.image.repository != null
  input.image.tag != null
  reason := "Image repository and tag must be specified in values.yaml."
}

deny[reason] {
  input.kind == "ValuesFile"
  input.monitoring.tool in ["prometheus","datadog","none"]
  reason := "Monitoring tool must be either 'prometheus', 'datadog', or 'none'."
}

deny[reason] {
  input.kind == "ValuesFile"
  input.monitoring.tool == "prometheus"
  input.prometheus.enabled != null
  reason := "Prometheus configuration must be enabled when monitoring tool is set to 'prometheus'."
}

deny[reason] {
  input.kind == "ValuesFile"
  input.monitoring.tool == "datadog"
  input.datadog.apiKey != null
  input.datadog.appKey != null
  reason := "Datadog API and App keys must be provided when 'datadog' is selected."
}

deny[reason] {
  input.kind == "DaemonSet"
  input.spec.template.spec.containers[_].resources.limits.memory != null
  input.spec.template.spec.containers[_].resources.requests.cpu != null
  reason := "DaemonSet containers must define memory limits and CPU requests."
}

deny[reason] {
  input.kind == "PrometheusRule"
  input.spec.groups[_].rules[_].expr != null
  reason := "Prometheus alert rules must define expressions for alert thresholds."
}

deny[reason] {
  input.kind == "ConfigMap"
  input.data.datadog.yaml != null
  re_match("metrics_prefix", input.data.datadog.yaml)
  reason := "Datadog metrics configuration must include a metrics prefix."
}

deny[reason] {
  input.kind == "Role"
  input.rules[_].resources in ["pods","nodes","persistentvolumes","persistentvolumeclaims"]
  reason := "RBAC roles must allow access to Pods, Nodes, and Persistent Volumes."
}

deny[reason] {
  input.kind == "DaemonSet"
  input.spec.template.spec.serviceAccountName != null
  reason := "DaemonSet must specify a valid ServiceAccount."
}

