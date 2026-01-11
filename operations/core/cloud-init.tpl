#cloud-config
write_files:
  - path: /etc/ssh/sshd_config.d/ssh-hardening.conf
    content: |
      PasswordAuthentication no
      Port ${sshPort}
      KbdInteractiveAuthentication no
      ChallengeResponseAuthentication no
      MaxAuthTries 2
      X11Forwarding no
      AllowAgentForwarding no
      AuthorizedKeysFile .ssh/authorized_keys
      AllowUsers root
runcmd:
  - systemctl daemon-reload
  - systemctl restart ssh