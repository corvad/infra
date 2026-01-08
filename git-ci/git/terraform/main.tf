terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.58.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.15.0"
    }
  }
}

provider "cloudflare" {
  email = var.cloudflare_email
  api_token = var.cloudflare_token
}

provider "hcloud" {
  token = var.hcloud_token
}