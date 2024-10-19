job "minio" {
  datacenters = ["dc1"]
  type        = "service"

  group "minio" {
    count = 1

    service {
      name = "minio"
      port = "api"
      provider = "nomad"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "api"
        interval = "10s"
        timeout  = "2s"
      }
    }

    network {
      port "api" {
        static = 9000
      }
      port "console" {
        static = 9001
      }
    }

    task "minio" {
      driver = "docker"

      config {
        image = "quay.io/minio/minio"
        args  = ["server", "/data", "--console-address", ":9001"]

        volumes = [
          "~/minio/data:/data"
        ]

        ports = ["api", "console"]
      }


      # You will want to change these values :)
      env {
        MINIO_ROOT_USER     = "ROOTNAME"
        MINIO_ROOT_PASSWORD = "CHANGEME123"
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}