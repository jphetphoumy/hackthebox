# Variables

variable "ssh_public_key" {
    type = "string"
    description = "SSH Public key to add fingerprint to access the droplet"
}

variable "ssh_private_key" {
    type = "string"
    description = "SSH Private key path"
}

# Provider

provider "digitalocean" {}

# Configure Hackbox

module "hackbox" {
    source = "./modules/services/hackbox"

    droplet_name = "Hackbox"
    droplet_size = "small"
    ssh_public_key = "${var.ssh_public_key}" 
    ssh_private_key = "${var.ssh_private_key}"
}

output "public_ipv4" {
    value = module.hackbox.public_ipv4
    description = "Public ip set to droplet"
}

output "ssh_fingerprint" {
    value = module.hackbox.ssh_fingerprint
    description = "SSH Fingerprint"
}
