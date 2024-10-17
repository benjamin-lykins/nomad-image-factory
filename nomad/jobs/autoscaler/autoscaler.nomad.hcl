job "autoscaler" {
  datacenters = ["dc1"]

  group "autoscaler" {
    count = 1

    task "autoscaler" {
      driver = "docker"

      config {
        image   = "hashicorp/nomad-autoscaler:0.3.5"
        command = "nomad-autoscaler"
        args    = ["agent", "-config", "${NOMAD_TASK_DIR}/config.hcl"]
      }

      template {
        data = <<EOF
plugin_dir = "/plugins"

nomad {
  address = "http://{{env "attr.unique.network.ip-address" }}:4646"
}
apm "datadog" {
  driver = "datadog"

  config = {
    dd_api_key = "###"
    dd_app_key = "###"

    site = "datadoghq.com"
  }
}
strategy "target-value" {
  driver = "target-value"
}
          EOF

        destination = "${NOMAD_TASK_DIR}/config.hcl"
      }
    }
  }
}
