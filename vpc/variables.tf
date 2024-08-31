variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for creating subnets"
  type        = list(string)
  default     = []
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway for the VPC"
  type        = bool
  default     = false
}

variable "enable_dhcp_options" {
  description = "Whether to create custom DHCP options for the VPC"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Domain name for custom DHCP options"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "List of domain name servers for custom DHCP options"
  type        = list(string)
  default     = []
}
