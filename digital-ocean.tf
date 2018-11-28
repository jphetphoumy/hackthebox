variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "ovpn_file" {}

# Configure the digital Ocean Provider
provider "digitalocean" {
	token = "${var.do_token}"
}

# Create the hack the box server

resource "digitalocean_droplet" "hack-the-box" {
	image = "ubuntu-18-04-x64"
	name = "hack-the-box"
	region = "fra1"
	size = "1gb"
	ssh_keys = [
		"${var.ssh_fingerprint}"
	]

	connection {
		user = "root"
		type = "ssh"
		private_key = "${file(var.pvt_key)}"
		timeout = "2m"
	}

	# Copy Openvpn file
	provisioner "file" {
		source = "${var.ovpn_file}"
		destination = "/root/${var.ovpn_file}"
	}
	
	provisioner "remote-exec" {
		inline = [
			"export PATH=$PATH:/usr/bin",
			# install openvpn
			"sudo apt-get update",
			"sudo apt-get -y install openvpn",
			# install tmux and vim
			"sudo apt-get -y install tmux vim",
			"sudo apt-get -y install nmap",
			"sudo apt-get -y install golang",
			"echo 'export GOPATH=$HOME/go'",
			"mkdir $HOME/go ",
			"sudo apt-get -y install git",
			"git clone https://github.com/OJ/gobuster.git",
			"cd gobuster",
			"go get && go build && go install",
			"tmux new-session -d -s htb",
			"tmux send-keys openvpn Space ${var.ovpn_file} C-m"
		]
	}

}

