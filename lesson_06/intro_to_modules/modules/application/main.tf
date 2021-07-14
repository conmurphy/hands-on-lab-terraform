
resource "aci_tenant" "aci_tenant" {
  name        = var.aci_tenant    
}

resource "aci_application_profile" "aci_application_profile" {
  tenant_dn = aci_tenant.aci_tenant.id
  name       = var.app_name
}

resource "aci_application_epg" "aci_application_epg" {
    for_each = var.epg
    application_profile_dn  = aci_application_profile.aci_application_profile.id
    name = each.key
    name_alias     = each.key
    description    = "this is the web epg created by terraform"
    
    flood_on_encap    = var.flood_on_encap
    fwd_ctrl          = var.fwd_ctrl
    has_mcast_source  = var.has_mcast_source
    match_t           = var.match_t
    pc_enf_pref       = var.pc_enf_pref
    pref_gr_memb      = var.pref_gr_memb
    prio              = var.prio
    shutdown          = var.shutdown
  }

