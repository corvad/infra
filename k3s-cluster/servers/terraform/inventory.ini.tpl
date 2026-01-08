[control_plane]
%{ for ip in control_plane_ips ~}
${ip}
%{ endfor ~}
[agent]
%{ for ip in worker_node_ips ~}
${ip}
%{ endfor ~}