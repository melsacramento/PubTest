variable NOMAD_TOKEN {}
variable EDGE_ID {}
variable EDGE_KEY {}
variable EDGE_INSECURE_POLL {}
variable DC {}
variable AGENT_SECRET {}

job "portainer-agent" {

  datacenters = [var.DC]

  group "portainer-agent" {
    task "portainer-agent" {
      driver = "docker"

      env = {
        DC      = "Running on datacenter ${node.datacenter}"
        NOMAD_ADDR = "http://${attr.nomad.advertise.address}"
        NOMAD_TOKEN = var.NOMAD_TOKEN
        EDGE = 1
        EDGE_KEY = var.EDGE_KEY
        EDGE_ID = var.EDGE_ID
        EDGE_INSECURE_POLL = var.EDGE_INSECURE_POLL
                                AGENT_SECRET = var.AGENT_SECRET
      }
      config {
        image = "portainerci/agent:2.13"
        force_pull = true
      }
    }
  }
}
