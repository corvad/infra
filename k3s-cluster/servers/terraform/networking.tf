resource "hcloud_network" "network" {
  name = "network"
  ip_range = "10.0.0.0/16"
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_network_subnet" "network-subnet" {
  type       = "cloud"
  network_id = hcloud_network.network.id
  network_zone = var.network_zone
  ip_range   = "10.0.0.0/24"
}

resource "hcloud_firewall" "control-plane-firewall" {
  name = "control-plane-firewall"
  rule {
    direction = "in"
    protocol = "tcp"
    port = "6443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  apply_to {
    label_selector = "role=control-plane"
  }
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_firewall" "worker-firewall" {
  name = "worker-firewall"
  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  apply_to {
    label_selector = "role=worker"
  }
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_load_balancer" "load-balancer" {
  name = "load-balancer"
  load_balancer_type = var.loadBalancerType
  location = var.region
}

resource "hcloud_load_balancer_network" "attachment" {
  load_balancer_id = hcloud_load_balancer.load-balancer.id
  subnet_id = hcloud_network_subnet.network-subnet.id
  ip = "10.0.0.${var.controlPlaneNodeCount + var.workerNodeCount + 2}"
}

resource "hcloud_load_balancer_target" "control-plane-targets" {
  type = "label_selector"
  load_balancer_id = hcloud_load_balancer.load-balancer.id
  label_selector = "role=control-plane"
  use_private_ip = true
}

resource "hcloud_load_balancer_target" "worker-targets" {
  type = "label_selector"
  load_balancer_id = hcloud_load_balancer.load-balancer.id
  label_selector = "role=worker"
  use_private_ip = true
}

resource "hcloud_load_balancer_service" "web-service" {
  load_balancer_id = hcloud_load_balancer.load-balancer.id
  protocol = "tcp"
  listen_port = 80
  destination_port = 80
  health_check {
    protocol = "tcp"
    port = 80
    interval = 10
    timeout = 5
    retries = 3
  }
}

resource "hcloud_load_balancer_service" "websecure-service" {
  load_balancer_id = hcloud_load_balancer.load-balancer.id
  protocol = "tcp"
  listen_port = 443
  destination_port = 443
  health_check {
    protocol = "tcp"
    port = 443
    interval = 10
    timeout = 5
    retries = 3
  }
}