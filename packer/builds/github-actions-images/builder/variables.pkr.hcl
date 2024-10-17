variable "runner_version" {
  type    = string
  default = "2.319.1"
  description = "The version of the GitHub Actions Runner to build."
}

variable "registry_username" {
  type    = string
  default = env("REGISTRY_USERNAME")
}

variable "registry_token" {
  type    = string
  default = env("REGISTRY_TOKEN")
}

variable "registry_server" {
  type    = string
  default = "ghcr.io"
}

variable "additional_tags" {
  type    = list(string)
  default = []
}