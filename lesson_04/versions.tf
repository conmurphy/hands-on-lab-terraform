terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = ">=0.7.1"
    }
  }
  required_version = ">= 0.13.4"
}
