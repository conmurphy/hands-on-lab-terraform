variable "apic_url" {}
variable "apic_username" {}
variable "apic_password" {}
variable "aci_app_name" {}

locals {
    flood_on_encap    = "enabled"
    fwd_ctrl          = "none"
    has_mcast_source  = "no"
    match_t           = "AtleastOne"
    name_alias        = "web"
    pc_enf_pref       = "unenforced"
    pref_gr_memb      = "exclude"
    prio              = "unspecified"
    shutdown          = "no"
}

output "application_profile_id" {
  value = aci_application_profile.myWebsite.id
}