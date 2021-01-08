resource "digitalocean_firewall" "ssh" {
  name = "ssh"

  droplet_ids = [digitalocean_droplet.app.id, digitalocean_droplet.db.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allow_ssh_ips
  }
}

resource "digitalocean_firewall" "app_web" {
  name = "web"

  droplet_ids = [digitalocean_droplet.app.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8084"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "private_allow_all" {
  name = "private-allow-all"

  droplet_ids = [digitalocean_droplet.app.id, digitalocean_droplet.db.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = [digitalocean_vpc.network.ip_range]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    source_addresses = [digitalocean_vpc.network.ip_range]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = [digitalocean_vpc.network.ip_range]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = [digitalocean_vpc.network.ip_range]
  }
}

# not according to task. used only for docker.
resource "digitalocean_firewall" "internet_access" {
  name = "internet-access"

  droplet_ids = [digitalocean_droplet.app.id, digitalocean_droplet.db.id]

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}
