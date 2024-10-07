job "actions-runner-builder" {
  datacenters = ["dc1"]
  type        = "service"

  group "actions-runner-builder" {
    count = 1

    network {

      port "http" {
      }
    }

    scaling {
      enabled = true
      min     = 1
      max     = 3

      policy {
        evaluation_interval = "30s"
        cooldown            = "1m"

        check "cpu_usage" {
          source = "datadog"
          query  = "avg:container.memory.usage{host:vs-nomad*, container_name:actions-runner-builder*}"

          strategy "target-value" {
            target = 104857600 #Increase to true value. 
          }
        }
      }
    }
    task "actions-runner-builder" {
      driver = "docker"

      config {
        image        = "ghcr.io/benjamin-lykins/actions-runner-builder:latest"
        ports        = ["http"]
        network_mode = "host"
      }

      env {
        REPO      = "benjamin-lykins/nomad-image-factory"
        NAME      = "nomad-runner-${NOMAD_SHORT_ALLOC_ID}"
        LABELS    = "autoscaler"
        HTTP_PORT = "${NOMAD_PORT_http}"
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
