job "hcp-tf-agent" {
  datacenters = ["dc1"]
  type        = "service"

  group "hcp-tf-agent" {
    count = 1

    task "hcp-tf-agent" {
      driver = "docker"

      config {
        image = "hashicorp/tfc-agent:latest"
      }

      env {
        TFC_AGENT_TOKEN  = "REPLACE_ME"
        TFC_AGENT_NAME   = "${NOMAD_TASK_NAME}-${NOMAD_ALLOC_ID}"
        TFC_AGENT_SINGLE = true
      }

      resources {
        cpu    = 500
        memory = 256
      }

    }
  }
}
