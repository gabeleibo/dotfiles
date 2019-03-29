provider "digitalocean" {}

resource "digitalocean_droplet" "dev" {
  ssh_keys           = [24253915]         # doctl compute ssh-key list
  image              = "ubuntu-18-10-x64"
  region             = "fra1"
  size               = "s-4vcpu-8gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "dev"


  provisioner "remote-exec" {
    script = "bootstrap.sh"

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "pull-secrets.sh"
    destination = "/mnt/secrets/pull-secrets.sh"

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /mnt/secrets/pull-secrets.sh",
    ]

    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "dev" {
  name = "dev"

  droplet_ids = ["${digitalocean_droplet.dev.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "3222"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "udp"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

output "public_ip" {
  value = "${digitalocean_droplet.dev.ipv4_address}"
}
