variable "LINODE_API_TOKEN" {}

terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.26.0"
    }
  }
}

provider "linode" {
  token = var.LINODE_API_TOKEN
}

data "linode_image" "force" {
  # force-image-20220312012520
  id = "private/15794916"
}

resource "linode_instance" "force" {
  label           = data.linode_image.force.label
  image           = data.linode_image.force.id
  region          = "us-east"
  authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDS8CRlxUgy0lj/8BdFmC8Ot7A4FVKs2oPChWT8V4mzBequiKZj3jhw3ByOtJASg1VR61UEeg8DFPMzNlKQ1clSv4+KxCg4jex95Lv6C0DsoH4+TSSXDOUXsBeWeqs3UMjwFG6OYSpfoF65Sq8++FGVM42A+DK4tIHMGRrCtiwNGx7aBJy3lIQ5EHsBTIGd7qNWOood+iL2AwSpPRlQqducRAEyfBaFD7i3N7XqnYtYmBTif7WdW6yZ4h3aWaAv/SvMnsynqb+7DnaP+Q1gAcOuSSCGL1X4nkzIS88Sg1VC+kdN46nbllP++6W9oAnscUZ1offBM6OxNppK7gRQKecA9pWPgukgeIXpKRRrGUm7VQJLeK4q/hD9/Cwn6zCsI9Swu8tHXF4SJQQVMOYiAIlRn6MvaJRp3KQ1JM453KCTRDhBpfuv5UKsiJYyFjaEHdipRiPM+mJG0YFHS1+YywkmrC0kqh7VmdqUkHTrBPfPfVD2SKhjWcp2XV6l31L5elc= bbriski@Bobs-MacBook-Pro.local"]

  private_ip = true
  booted     = true
}

resource "linode_firewall" "force" {
  label = "force"

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.force.id]
}


output "instance_ip_addr" {
  value = linode_instance.force.ip_address
}
