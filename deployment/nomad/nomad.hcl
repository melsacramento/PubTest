variable NOMAD_TOKEN {}
variable EDGE_ID {}
variable EDGE_KEY {}
variable EDGE_INSECURE_POLL {}
variable DC {}
variable AGENT_SECRET {}
variable TLS_ENABLED {}
variable NOMAD_CACERT_CONTENT {}
variable NOMAD_CLIENT_CERT_CONTENT {}
variable NOMAD_CLIENT_KEY_CONTENT {}

job "portainer-agent" {

  datacenters = [var.DC]

  group "portainer-agent" {

    task "portainer-agent" {
      driver = "docker"

      env = {
        DC      = "Running on datacenter ${node.datacenter}"
        NOMAD_ADDR = var.TLS_ENABLED ? "https://${attr.nomad.advertise.address}" : "http://${attr.nomad.advertise.address}"
        NOMAD_TOKEN = var.NOMAD_TOKEN
        EDGE = 1
        EDGE_KEY = var.EDGE_KEY
        EDGE_ID = var.EDGE_ID
        EDGE_INSECURE_POLL = var.EDGE_INSECURE_POLL
        AGENT_SECRET = var.AGENT_SECRET
        NOMAD_CACERT_CONTENT = var.NOMAD_CACERT_CONTENT
        NOMAD_CLIENT_CERT_CONTENT = var.NOMAD_CLIENT_CERT_CONTENT
        NOMAD_CLIENT_KEY_CONTENT = var.NOMAD_CLIENT_KEY_CONTENT
      }

      config {
        image = "portainerci/agent:pr333"
        force_pull = true
      }
    }
  }
}
