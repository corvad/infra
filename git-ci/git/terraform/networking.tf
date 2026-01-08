resource "hcloud_firewall" "gerrit-firewall" {
  name = "gerrit-firewall"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0"]
  }
  apply_to {
    label_selector = "role=gerrit"
  }
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_firewall" "jenkins-firewall" {
  name = "jenkins-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  apply_to {
    label_selector = "role=jenkins"
  }
  labels = {
    "managed-by" = "terraform"
  }
}
