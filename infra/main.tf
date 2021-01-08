variable "do_token" {}
variable "allow_ssh_ips" {}
variable "region" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "igor_mbp" {
  name       = "Igor's MBP SSH key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_vpc" "network" {
  name   = "private-network"
  region = var.region
}

resource "digitalocean_volume" "db_mysql" {
  name                    = "mysql-volume"
  region                  = var.region
  size                    = 10
  initial_filesystem_type = "ext4"
}

resource "digitalocean_droplet" "app" {
  name     = "application"
  image    = "centos-7-x64"
  region   = var.region
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.igor_mbp.fingerprint]
  vpc_uuid = digitalocean_vpc.network.id
}

resource "digitalocean_droplet" "db" {
  name     = "db"
  image    = "centos-7-x64"
  region   = var.region
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.igor_mbp.id]
  vpc_uuid = digitalocean_vpc.network.id
}

resource "digitalocean_volume_attachment" "db_mysql" {
  droplet_id = digitalocean_droplet.db.id
  volume_id  = digitalocean_volume.db_mysql.id
}
