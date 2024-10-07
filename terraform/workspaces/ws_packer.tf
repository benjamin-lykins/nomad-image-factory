module "packer" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.11.0"

  for_each = var.workspaces["packer"]

  organization   = var.organization
  workspace_name = each.key
  workspace_desc = "Packer Test Deployments"
  project_name   = "packer"

  auto_apply   = true
  force_delete = true //only for easy cleanup in demo

  workspace_tags = ["type:packer"]

}
