job "[[ var "job_name" . ]]" {
  type   = "batch"

  [[ define "region" -]]
  [[- if var "region" . -]]
    region = "[[ var "region" . ]]"
  [[- end -]]
  [[- end -]]

  datacenters = [[ var "datacenters" . | toStringList ]]

  group "[[ var "job_name" . ]]" {

    network {
      port "http" {
      }
    }

    task "[[ var "job_name" . ]]" {
      driver = "docker"
      config {
        image = "ghcr.io/benjamin-lykins/actions-runner-builder:latest"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        REPO  = "[[ var "repository" . ]]"
        NODE_IP = "${attr.unique.network.ip-address}"
        HTTP_PORT = "${NOMAD_PORT_http}"
        NAME = "[[ var "job_name" . ]]"
        LABELS = "[[ var "job_name" . ]]"
      }

      resources {
        cpu    = [[ var "resources.cpu" . ]]
        memory = [[ var "resources.memory" . ]]
      }

      template {
        data = <<EOH
      TOKEN="{{ with nomadVar "nomad/jobs" }}{{ .GITHUB_TOKEN }}{{ end }}"
      EOH
        destination = "secrets/file.env"
        env         = true
      }
    }
  }
}
