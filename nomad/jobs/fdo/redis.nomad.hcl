job "redis" {
  datacenters = ["dc1"]

  group "redis" {
    network {
      port "db" {
        static = 6379
      }
    }

    task "redis" {
      driver = "docker"

      config {
        image = "redis"

        ports = ["db"]
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
