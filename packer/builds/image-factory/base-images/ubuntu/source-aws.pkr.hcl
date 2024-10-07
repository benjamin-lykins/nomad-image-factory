

source "amazon-ebs" "ubuntu" {
  source_ami                  = "ami-085f9c64a9b75eed5"
  instance_type               = "t2.large"
  ssh_username                = "ubuntu"
  ami_name                    = "ubuntu-base"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}