source "docker" "actions-runner-builder" {
  image  = "ubuntu:latest"
  commit = true
  changes = [
    "USER runner",
    "ENTRYPOINT [\"/start.sh\"]",
    "LABEL release=${var.runner_version}",
  ]
}