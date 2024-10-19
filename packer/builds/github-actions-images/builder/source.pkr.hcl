/*
  This block defines a Docker source for a Packer build configuration.

  - source "docker" "actions-runner-builder":
    Specifies the use of Docker as the source for building an image named "actions-runner-builder".

  - image:
    Sets the base image to "ubuntu:latest".

  - commit:
    Indicates that changes to the container should be committed to a new image.

  - changes:
    A list of changes to apply to the base image:
      - "USER runner": Sets the user to "runner".
      - "ENTRYPOINT [\"/start.sh\"]": Sets the entrypoint to "/start.sh".
      - "LABEL release=${var.runner_version}": Adds a label "release_version" with the value of the variable "runner_version".
*/
source "docker" "actions-runner-builder" {
  image  = "ubuntu:latest"
  commit = true
  changes = [
    "USER runner",
    "ENTRYPOINT [\"/start.sh\"]",
    "LABEL runner_version=${var.runner_version}",
  ]
}