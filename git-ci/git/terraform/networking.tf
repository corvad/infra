resource "hcloud_firewall" "firewall" {
  name = "firewall"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0"]
  }
  apply_to {
    label_selector = "managed-by=terraform"
  }
  labels = {
    "managed-by" = "terraform"
  }
}