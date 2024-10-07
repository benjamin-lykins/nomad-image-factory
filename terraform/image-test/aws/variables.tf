variable "image_type" {
  description = "The type of image to test"
  type        = string
  default     = "linux"
}

variable "platform" {
  description = "The target platform to provision the image"
  type        = string
  default     = "azure"
}

variable "hcp_packer_bucket" {
  description = "The name of the bucket to store the packer artifacts"
  type        = string
}

variable "region" {
  description = "The region to deploy the VM"
  type        = string
  default     = "us-east-2"
}

variable "aws_subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  default     = "subnet-07fbac7881b9b68d2"
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with the instance"
  default     = "SSM"
}
