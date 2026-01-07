resource "hcloud_server" "controlPlaneNode" {
  count = var.controlPlaneNodeCount
  name  = "control-plane-${count.index}"
  location = var.region
  image = var.os_image
  server_type = var.controlPlaneNodeType
  network {
    network_id = hcloud_network.network.id
    ip = "10.0.0.${count.index + 2}"
  }
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  labels = {
    "role" = "control-plane"
    "managed-by" = "terraform"
  }
  depends_on = [ hcloud_network_subnet.network-subnet ]
}

resource "hcloud_server" "workerNode" {
  count = var.workerNodeCount
  name  = "worker-node-${count.index}"
  location = var.region
  image = var.os_image
  server_type = var.workerNodeType
  network {
    network_id = hcloud_network.network.id
    ip = "10.0.0.${count.index + var.controlPlaneNodeCount + 2}"
  }
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  labels = {
    "role"="worker"
    "managed-by" = "terraform"
  }
  depends_on = [ hcloud_network_subnet.network-subnet ]
}