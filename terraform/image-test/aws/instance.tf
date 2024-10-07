resource "aws_instance" "this" {
  count                = var.platform == "aws" ? 1 : 0
  ami                  = data.hcp_packer_artifact.this.external_identifier
  instance_type        = "t2.micro"
  subnet_id            = var.aws_subnet_id
  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name = lower("${var.hcp_packer_bucket}-test")
  }
}
