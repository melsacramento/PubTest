job "nginx-public-repo" {
  datacenters = ["dc1"]

  namespace = "default"

  type = "service"

  group "nginx" {

    count = 1

    network {
      port "db" {
        static = 8080
        to = 80
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
