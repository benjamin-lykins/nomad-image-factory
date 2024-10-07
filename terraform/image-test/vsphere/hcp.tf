
data "hcp_packer_artifact" "this" {
  bucket_name  = var.hcp_packer_bucket
  channel_name = "latest"
  platform     = var.platform
  region       = var.region
}

resource "hcp_packer_channel" "production" {
  name        = "production"
  bucket_name = var.hcp_packer_bucket
}

resource "hcp_packer_channel_assignment" "production" {
  bucket_name         = var.hcp_packer_bucket
  channel_name        = "production"
  version_fingerprint = data.hcp_packer_artifact.this.version_fingerprint
  depends_on = [
    vsphere_virtual_machine.linux,
    vsphere_virtual_machine.windows,
    hcp_packer_channel.production
  ]
}
