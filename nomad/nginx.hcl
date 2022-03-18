job "nginx-public-repo" {
  datacenters = ["dc1"]

  namespace = "default"

  type = "service"

  group "nginx" {

    count = 1

    network {
      port "db" {
        static = 80
        to = 8080
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
