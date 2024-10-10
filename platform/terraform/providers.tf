provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      name = "platform"
      repo = "k8s-platform"
    }
  }
}
