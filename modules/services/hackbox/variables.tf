# Declare variable

variable "droplet_name" {
    description = "The name to use for the new droplet"
    type = "string"
}

variable "droplet_region" {
    description = "The name of the droplet region"
    type = "string"
    default = "lon1"
}

variable "droplet_size_list" {
    description = "List of droplet size"
    type = map(string)
    default = {
        small = "s-1vcpu-1gb"
        medium = "s-1vcpu-2gb"
    }
}

variable "droplet_size" {
    description = "The size of the droplet"
}

variable "droplet_image" {
    description = "The image slug to use for the new droplet"
    type = "string"
    default = "debian-10-x64"
}

variable "ssh_public_key" {
    description = "Name of the register SSH Public key"
    type = "string"
}

variable "ssh_private_key" {
    description = "SSH Private key path"
    type = "string"
}
