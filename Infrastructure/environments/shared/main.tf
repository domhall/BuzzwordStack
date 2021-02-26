module "bws-shared" {
  source = "../../modules/bws-shared///"
  do_token=var.do_token
  project_name="buzzword-stack-dom"
}
# TODO migrate to terragrunt