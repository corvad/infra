resource "hcloud_server" "gerrit" {
  name        = "gerrit"
  location    = var.region
  image       = "ubuntu-24.04"
  server_type = var.gerritNodeType
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  ssh_keys = [hcloud_ssh_key.ssh-key.id]
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_server" "jenkins" {
  name        = "jenkins"
  location    = var.region
  image       = "ubuntu-24.04"
  server_type = var.jenkinsNodeType
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  ssh_keys = [hcloud_ssh_key.ssh-key.id]
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_server" "auth" {
  name        = "auth"
  location    = var.region
  image       = "ubuntu-24.04"
  server_type = var.authNodeType
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  ssh_keys = [hcloud_ssh_key.ssh-key.id]
  labels = {
    "managed-by" = "terraform"
  }
}

resource "hcloud_ssh_key" "ssh-key" {
  name       = "ssh-key"
  public_key = var.sshPublicKey
  labels = {
    "managed-by" = "terraform"
  }
}
