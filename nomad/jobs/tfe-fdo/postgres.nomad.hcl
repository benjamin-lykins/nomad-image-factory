job "postgres" {
  datacenters = ["dc1"]
  type        = "service"

  group "db" {
    count = 1

    network {
      port "db" {
        to = 5432
      }
    }

    task "postgres" {
      driver = "docker"

      config {
        image = "postgres"

        # Replace 'port_map' with 'ports'
        ports = ["db"]
      }

      # You will want to change these values :)
      env {
        POSTGRES_PASSWORD = "mysecretpassword"
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 512 # 512 MB
      }
    }
  }
}
