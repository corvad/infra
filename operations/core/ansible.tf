resource "local_file" "inventory_ini" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tpl", {
    sshPort   = var.sshPort,
    gerrit = "git.${var.cloudflare_zone}",
    jenkins = "jenkins.${var.cloudflare_zone}",
  })
}
