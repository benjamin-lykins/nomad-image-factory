variable "job_name" {
  description = "The name to use as the job name which overrides using the pack name"
  type        = string
  default     = "actions-runner-nomad-pack"
}

variable "region" {
  description = "The region where jobs will be deployed"
  type        = string
  default     = ""
}

variable "datacenters" {
  description = "A list of datacenters in the region which are eligible for task placement"
  type        = list(string)
  default     = ["dc1"]
}

variable "resources" {
  description = "The resources to allocate to the job"
  type        = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "repository" {
  description = "The repository to use for the actions runner"
  type        = string
  default     = "benjamin-lykins/nomad-image-factory"
 }

