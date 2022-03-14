output "workers_ips" {
  value = libvirt_domain.domain-distro.*.name
}