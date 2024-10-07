variable "runner_version" {
  type    = string
  default = "2.319.1"
}

variable "runner_os" {
  type    = string
  default = "linux"
}

variable "runner_arch" {
  type    = string
  default = "x64"
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