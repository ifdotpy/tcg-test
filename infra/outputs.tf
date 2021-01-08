resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      droplet-app-public-ip  = digitalocean_droplet.app.ipv4_address,
      droplet-app-private-ip = digitalocean_droplet.app.ipv4_address_private,
      droplet-db-public-ip   = digitalocean_droplet.db.ipv4_address,
      droplet-db-private-ip  = digitalocean_droplet.db.ipv4_address_private,
    }
  )
  filename = "inventory"
}
