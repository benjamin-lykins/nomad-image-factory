source "amazon-ebs" "windows-full" {
  source_ami                  = "ami-008687c5b5546727c"
  instance_type               = "t2.large"
  ami_name                    = "windows-full-base"
  subnet_id                   = "subnet-07fbac7881b9b68d2"
  associate_public_ip_address = "false"

  communicator   = "winrm"
  winrm_username   = "Administrator"
  winrm_insecure   = true
  winrm_use_ssl    = true
  user_data_file = "${path.cwd}/packer/builds/image-factory/base-images/windows/data/aws-bootstrap.txt"
}