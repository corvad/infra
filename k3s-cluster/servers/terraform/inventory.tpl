[control-plane]
%{ for ip in control_plane_ips ~}
${ip}
%{ endfor ~}

[worker]
%{ for ip in worker_node_ips ~}
${ip}
%{ endfor ~}