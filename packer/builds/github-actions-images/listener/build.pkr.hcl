build {
  name = "actions-runner-listener"
  sources = [
    "source.docker.actions-runner-listener"
  ]

  //     hcp_packer_registry {
  //     bucket_name = "actions-runner-listener"
  //     description = <<EOT
  // Image for scaling self-hosted GitHub Actions Runners.
  //     EOT
  //     bucket_labels = {
  //       "owner"          = "platform-team"
  //       "source"             = "ubuntu",
  //     }

  //   build_labels = {
  //     "build-time"   = timestamp()
  //     "build-source" = basename(path.cwd)
  //     "runner-version" = "${var.runner_version}"
  //     "runner-os" = "${var.runner_os}"
  //     "runner-arch" = "${var.runner_arch}"
  //   }
  // }

  provisioner "file" {
    source      = "packer/builds/github-actions-images/listener/scripts/start.sh"
    destination = "/start.sh"
  }

  provisioner "file" {
    source      = "packer/builds/github-actions-images/listener/files/nomad-packs/packs"
    destination = "/nomad-packs"
  }

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "RUNNER_VERSION=${var.runner_version}",
    ]
    script = "packer/builds/github-actions-images/listener/scripts/install.sh"
  }


  post-processors {
    post-processor "docker-tag" {
      repository = "${var.registry_server}/${var.registry_username}/actions-runner-listener"
      tags       = concat(["latest"], var.additional_tags)
    }
    post-processor "docker-push" {
      login          = true
      login_username = var.registry_username
      login_password = var.registry_token
      login_server   = var.registry_server
    }
  }

}