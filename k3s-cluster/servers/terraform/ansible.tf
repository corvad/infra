resource "local_file" "ansible-inventory" {
  filename = "../ansible/inventory.ini"
  content = templatefile("inventory.ini.tpl", {
    control_plane_ips = [for server in hcloud_server.controlPlaneNode : server.ipv4_address]
    worker_node_ips   = [for server in hcloud_server.workerNode : server.ipv4_address]
  })
  depends_on = [hcloud_server.controlPlaneNode, hcloud_server.workerNode]
}
