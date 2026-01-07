variable "hcloud_token" {
  description = "API token for hetzner."
  sensitive = true
}

variable "region" {
  default = "ash"
  description = "Deployment region."
}

variable "network_zone" {
  default = "us-east"
  description = "Network deployment zone."
}

variable "os_image" {
  default = "ubuntu-24.04"
  description = "OS image for the nodes."
}

variable "controlPlaneNodeCount" {
  default = 3
  description = "Number of control plane nodes to deploy."
}

variable "controlPlaneNodeType" {
  default = "cpx11"
  description = "Type of control plane nodes."
}

variable "workerNodeCount" {
  default = 3
  description = "Number of worker nodes to deploy."
}

variable "workerNodeType" {
  default = "cpx11"
  description = "Type of worker nodes."
}

variable "loadBalancerType" {
  default = "lb11"
  description = "Type of load balancer."
}