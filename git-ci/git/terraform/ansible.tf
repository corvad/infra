# Outputs the tunnel tokens to Ansible yaml file.
resource "local_file" "tunnel_tokens_file" {
  filename = "../ansible/values.yaml"
  content = templatefile("values.yaml.tpl", {
    gerrit_tunnel_token  = data.cloudflare_zero_trust_tunnel_cloudflared_token.gerrit_tunnel_token.token,
    jenkins_tunnel_token = data.cloudflare_zero_trust_tunnel_cloudflared_token.jenkins_tunnel_token.token,
    auth_tunnel_token    = data.cloudflare_zero_trust_tunnel_cloudflared_token.auth_tunnel_token.token,
  })
}

resource "local_file" "inventory_ini" {
  filename = "../ansible/inventory.ini"
  content = templatefile("inventory.ini.tpl", {
    gerrit_ip  = hcloud_server.gerrit.ipv4_address,
    jenkins_ip = hcloud_server.jenkins.ipv4_address,
    auth_ip    = hcloud_server.auth.ipv4_address,
  })
}
