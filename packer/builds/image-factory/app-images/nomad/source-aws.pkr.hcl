data "hcp-packer-artifact" "aws-docker" {
  bucket_name   = "aws-docker"
  channel_name  = "latest"
  platform      = "aws"
  region        = "us-east-2"
}

source "amazon-ebs" "nomad-client" {
  region                      = "us-east-2"
  source_ami                  = data.hcp-packer-artifact.aws-docker.external_identifier
  instance_type               = "t2.small"
  ssh_username                = "ubuntu"
  ssh_agent_auth              = false
  ami_name                    = "nomad-client"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}

source "amazon-ebs" "nomad-server" {
  region                      = "us-east-2"
  source_ami                  = data.hcp-packer-artifact.aws-docker.external_identifier
  instance_type               = "t2.small"
  ssh_username                = "ubuntu"
  ssh_agent_auth              = false
  ami_name                    = "nomad-server"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}
source "amazon-ebs" "nomad-shared" {
  region                      = "us-east-2"
  source_ami                  = data.hcp-packer-artifact.aws-docker.external_identifier
  instance_type               = "t2.small"
  ssh_username                = "ubuntu"
  ssh_agent_auth              = false
  ami_name                    = "nomad-shared"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}