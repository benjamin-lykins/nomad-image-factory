job "actions-runner-listener" {
  datacenters = ["dc1"]
  type        = "service"

  group "actions-runner-listener" {
    count = 1

    task "actions-runner-listener" {
      driver = "docker"

      config {
        image = "ghcr.io/benjamin-lykins/actions-runner-listener:latest"
      }

      env {
        REPO      = "benjamin-lykins/nomad-image-factory"
        NODE_IP   = "${attr.unique.network.ip-address}"
        HTTP_PORT = "${NOMAD_PORT_http}"
        NAME      = "nomad-runner-${NOMAD_SHORT_ALLOC_ID}"
        NOMAD_ADDR   = "http://${attr.unique.network.ip-address}:4646"
        LABELS    = "azure,listener"
      }

      resources {
        cpu    = 1000
        memory = 1024
      }

      template {
        data        = <<EOH
TOKEN="{{ with nomadVar "nomad/jobs/" }}{{ .GITHUB_TOKEN }}{{ end }}"
EOH
        destination = "secrets/file.env"
        env         = true
      }
      
    }
  }
}
