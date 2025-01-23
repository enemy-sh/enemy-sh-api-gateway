variable "subscription_id" {
  type        = string
  description = "The subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "container_app_environment_id" {
  type        = string
  description = "The environment ID"
}

variable "container_app_environment_static_ip_address" {
  type        = string
  description = "The environment static IP address"
}

variable "image" {
  type        = string
  description = "The image name"
}

variable "repository_name" {
  type        = string
  description = "The repository name"
}

variable "sha" {
  type        = string
  description = "The image sha"
}

variable "github_token" {
  type        = string
  description = "The github token"
  sensitive   = true
}

variable "registry_username" {
  type        = string
  description = "The registry username"
  sensitive   = true
}

// variables not driven by pipeline
variable "cpu" {
  type        = string
  description = "CPU request"
}

variable "memory" {
  type        = string
  description = "Memory request"
}

variable "max_replicas" {
  type        = number
  description = "The maximum number of replicas"
}

variable "min_replicas" {
  type        = number
  description = "The minimum number of replicas"
}

variable "registry_server" {
  type        = string
  description = "The registry server"
}

// variables not driven by pipeline

variable "dns_zone_name" {
  type        = string
  description = "The DNS zone name"
}

variable "dns_zone_resource_group_name" {
  type        = string
  description = "The DNS zone resource group name"
}
