variable "apic_url" {}
variable "apic_username" {}
variable "apic_password" {}
variable "aci_tenant" {}

locals {
    flood_on_encap    = "disabled"
    fwd_ctrl          = "none"
    has_mcast_source  = "no"
    match_t           = "AtleastOne"
    name_alias        = "web"
    pc_enf_pref       = "unenforced"
    pref_gr_memb      = "exclude"
    prio              = "unspecified"
    shutdown          = "no"
}
