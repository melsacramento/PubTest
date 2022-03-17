job "demo" {
  datacenters = ["dc1"]

  namespace = "default"

  type = "service"

  group "nginx" {

    count = 1

    network {
      port "db" {
        static = 6379
        to = 6379
      }
    }

    task "nginx" {

      driver = "docker"

      config {
        image = "nginx:latest"

        ports = ["db"]
      }

      resources {
        cpu    = 256
        memory = 256
      }
    }
  }
}
