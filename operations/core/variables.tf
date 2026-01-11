variable "hcloud_token" {
  description = "API token for hetzner."
  sensitive   = true
}

variable "region" {
  default     = "ash"
  description = "Deployment region."
}

variable "gerritNodeType" {
  default     = "ccx13"
  description = "Type of gerrit node."
}

variable "jenkinsNodeType" {
  default     = "ccx13"
  description = "Type of jenkins node."
}

variable "sshPublicKey" {
  type        = string
  description = "SSH public key for accessing the nodes."
}

variable "sshPort" {
  description = "SSH port for accessing the servers."
  type        = string
  default     = "2200"
}

# Cloudflare variables
variable "cloudflare_zone" {
  description = "Domain name for your Cloudflare zone"
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

variable "cloudflare_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}
