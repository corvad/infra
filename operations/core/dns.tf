resource "cloudflare_dns_record" "gerrit_v4" {
  zone_id = var.cloudflare_zone_id
  name    = "git.${var.cloudflare_zone}"
  type    = "A"
  content = hcloud_server.gerrit.ipv4_address
  ttl     = 60
  proxied = false
}

resource "cloudflare_dns_record" "gerrit_v6" {
  zone_id = var.cloudflare_zone_id
  name    = "git.${var.cloudflare_zone}"
  type    = "AAAA"
  content = hcloud_server.gerrit.ipv6_address
  ttl     = 60
  proxied = false
}

resource "cloudflare_dns_record" "jenkins_v4" {
  zone_id = var.cloudflare_zone_id
  name    = "jenkins.${var.cloudflare_zone}"
  type    = "A"
  content = hcloud_server.jenkins.ipv4_address
  ttl     = 60
  proxied = false
}

resource "cloudflare_dns_record" "jenkins_v6" {
  zone_id = var.cloudflare_zone_id
  name    = "jenkins.${var.cloudflare_zone}"
  type    = "AAAA"
  content = hcloud_server.jenkins.ipv6_address
  ttl     = 60
  proxied = false
}
