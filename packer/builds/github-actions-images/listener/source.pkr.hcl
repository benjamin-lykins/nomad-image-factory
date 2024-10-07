source "docker" "actions-runner-listener" {
  image  = "ubuntu:latest"
  commit = true
  changes = [
    "USER runner",
    "ENTRYPOINT [\"/start.sh\"]",
  ]
}