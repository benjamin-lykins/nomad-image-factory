source "amazon-ebs" "rhel" {
  source_ami                  = "ami-0aa8fc2422063977a"
  instance_type               = "t2.large"
  ssh_username                = "ec2-user"
  ami_name                    = "rhel-base"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"
}