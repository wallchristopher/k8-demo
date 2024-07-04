provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      name = "k8s-platform"
    }
  }
}
