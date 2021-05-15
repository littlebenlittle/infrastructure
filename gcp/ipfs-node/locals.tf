locals {
  iap_cidr     = "35.235.240.0/20"
  cloud_config = <<-EOT
    #cloud-config
    write_files:
    - path: /etc/systemd/system/docker.service.d/startup_options.conf
      permissions: "0644"
      owner: root
      content: |
        [Service]
        ExecStart=
        ExecStart=/usr/bin/dockerd -H tcp://127.0.0.1:2375
    runcmd:
    - systemctl daemon-reload
    - systemctl restart docker.service
    EOT
}
