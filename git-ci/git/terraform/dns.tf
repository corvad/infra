# Creates a new remotely-managed tunnel for the Gerrit server.
resource "cloudflare_zero_trust_tunnel_cloudflared" "gerrit_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "Gerrit tunnel"
  config_src = "cloudflare"
}

# Reads the token used to run the tunnel on the server.
data "cloudflare_zero_trust_tunnel_cloudflared_token" "gerrit_tunnel_token" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.gerrit_tunnel.id
}

# Creates the CNAME record that routes git.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_dns_record" "git" {
  zone_id = var.cloudflare_zone_id
  name    = "git"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.gerrit_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# Configures tunnel with a published application for clientless access.
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "gerrit_tunnel_config" {
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.gerrit_tunnel.id
  account_id = var.cloudflare_account_id
  config = {
    ingress = [
      {
        hostname = "git.${var.cloudflare_zone}"
        service  = "http://localhost:8080"
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

# Creates a new remotely-managed tunnel for the Jenkins server.
resource "cloudflare_zero_trust_tunnel_cloudflared" "jenkins_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "Jenkins tunnel"
  config_src = "cloudflare"
}

# Reads the token used to run the tunnel on the server.
data "cloudflare_zero_trust_tunnel_cloudflared_token" "jenkins_tunnel_token" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.jenkins_tunnel.id
}

# Creates the CNAME record that routes jenkins.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_dns_record" "jenkins" {
  zone_id = var.cloudflare_zone_id
  name    = "jenkins"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.jenkins_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# Configures tunnel with a published application for clientless access.
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "jenkins_tunnel_config" {
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.jenkins_tunnel.id
  account_id = var.cloudflare_account_id
  config = {
    ingress = [
      {
        hostname = "jenkins.${var.cloudflare_zone}"
        service  = "http://localhost:8080"
      },
      {
        service = "http_status:404"
      }
    ]
  }
}
