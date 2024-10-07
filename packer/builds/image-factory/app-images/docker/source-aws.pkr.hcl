data "hcp-packer-artifact" "aws-ubuntu" {
  bucket_name   = "aws-ubuntu"
  channel_name  = "latest"
  platform      = "aws"
  region        = "us-east-2"
}

source "amazon-ebs" "docker" {
  source_ami                  = data.hcp-packer-artifact.aws-ubuntu.external_identifier
  instance_type               = "t2.large"
  ssh_username                = "ubuntu"
  ami_name                    = "ubuntu-docker"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}