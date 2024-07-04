config {
  call_module_type = "all"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
    enabled = true
    version = "0.30.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
