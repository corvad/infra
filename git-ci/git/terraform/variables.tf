variable "hcloud_token" {
  description = "API token for hetzner."
  sensitive = true
}

variable "region" {
  default = "ash"
  description = "Deployment region."
}

variable "gerritNodeType" {
  default = "cpx11"
  description = "Type of gerrit node."
}

variable "jenkinsNodeType" {
  default = "cpx11"
  description = "Type of jenkins node."
}

variable "sshPublicKey" {
  type = string
  description = "SSH public key for accessing the nodes."
}

# Cloudflare variables
variable "cloudflare_zone" {
  description = "Domain used to expose the GCP VM instance to the Internet"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for your domain"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Email address for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}