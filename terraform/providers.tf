terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.8.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.4.0"
    }
  }
}

provider "kind" {}
provider "docker" {}