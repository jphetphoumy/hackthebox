# Configure Droplet

# ------------------------------------
# Set the data for SSH Key fingerprint
# ------------------------------------

data "digitalocean_ssh_key" "default" {
    name = "${var.ssh_public_key}"
}

# -----------------------------------
# Create the Digital Ocean droplet
# -----------------------------------

resource "digitalocean_droplet" "default" {
    image = "debian-10-x64"
    name = "${var.droplet_name}"
    region = "${var.droplet_region}"
    size = "${var.droplet_size_list["${var.droplet_size}"]}"
    ssh_keys = [data.digitalocean_ssh_key.default.fingerprint]

    provisioner "file" {
      source = "${path.module}/scripts/install.sh"
      destination = "/tmp/install.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/install.sh",
            "/tmp/install.sh"
        ]
    }

    connection {
        type = "ssh"
        user = "root"
        private_key = "${file(var.ssh_private_key)}"
        host = "${self.ipv4_address}"
    }
}


