#cloud-config
# vim: syntax=yaml
hostname: ${host_name}
manage_etc_hosts: true

runcmd:
  - hostnamectl set-hostname "initializing-${host_name}"
  #- sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
  #- sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=https://vault.centos.org|g" /etc/yum.repos.d/CentOS-*
  #- dnf clean all
  #- dnf swap centos-linux-repos centos-stream-repos
  - dnf install python36 -y
  - hostnamectl set-hostname ${host_name}

users:
  - name: root
    lock-passwd: false
    plain_text_passwd: root
  - name: terraform
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${auth_key}
      - ${auth_key_ansible}
      
  - name: ansible
    plain_text_passwd: unir2022
    homedir: /home/ansible
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${auth_key}
      - ${auth_key_ansible}

ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    terraform:linux
  expire: false
growpart:
  mode: auto
  devices: ['/']

