# Declared Output

output "public_ipv4" {
    value = digitalocean_droplet.default.ipv4_address
    description = "Ipv4 Assign to droplet"
}

output "ssh_fingerprint" {
    value = data.digitalocean_ssh_key.default.fingerprint
    description = "MD5 SSH Fingerprint"
}
