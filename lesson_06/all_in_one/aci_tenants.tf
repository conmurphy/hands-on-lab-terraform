
resource "aci_tenant" "aci_tenant" {
  name        = var.aci_tenant    
}

resource "aci_bridge_domain" "bd_for_subnet" {
  tenant_dn   = "${aci_tenant.aci_tenant.id}"
  name        = "bd_for_subnet"
  description = "This bridge domain is created by the Terraform ACI provider"
}

resource "aci_subnet" "demosubnet" {
  parent_dn                    = "${aci_bridge_domain.bd_for_subnet.id}"
  ip                                  = "172.16.1.1/24"
  description                         = "This subject is created by Terraform"
}




resource "aci_application_profile" "myWebsite" {
  tenant_dn = "${aci_tenant.aci_tenant.id}"
  name       = "my_website"
}

resource "aci_application_epg" "myWebsite-web" {
    application_profile_dn  = "${aci_application_profile.myWebsite.id}"
    name           = "web"
    name_alias     = "web"
    description    = "this is the web epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }


resource "aci_application_epg" "myWebsite-db" {
    application_profile_dn  = "${aci_application_profile.myWebsite.id}"
    name         = "db"
    name_alias   = "db"
    description  = "this is the database epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }


resource "aci_application_profile" "anotherApplication" {
  tenant_dn = "${aci_tenant.aci_tenant.id}"
  name       = "another_application"
}

resource "aci_application_epg" "anotherApplication-web" {
    application_profile_dn  = "${aci_application_profile.anotherApplication.id}"
    name           = "web"
    name_alias     = "web"
    description    = "this is the web epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }


resource "aci_application_epg" "anotherApplication-db" {
    application_profile_dn  = "${aci_application_profile.anotherApplication.id}"
    name         = "db"
    name_alias   = "db"
    description  = "this is the database epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }


resource "aci_application_profile" "thirdApplication" {
  tenant_dn = "${aci_tenant.aci_tenant.id}"
  name       = "third_application"
}

resource "aci_application_epg" "thirdApplication-web" {
    application_profile_dn  = "${aci_application_profile.thirdApplication.id}"
    name           = "web"
    name_alias     = "web"
    description    = "this is the web epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }


resource "aci_application_epg" "thirdApplication-db" {
    application_profile_dn  = "${aci_application_profile.thirdApplication.id}"
    name         = "db"
    name_alias   = "db"
    description  = "this is the database epg created by terraform"
    
    flood_on_encap    = local.flood_on_encap
    fwd_ctrl          = local.fwd_ctrl
    has_mcast_source  = local.has_mcast_source
    match_t           = local.match_t
    pc_enf_pref       = local.pc_enf_pref
    pref_gr_memb      = local.pref_gr_memb
    prio              = local.prio
    shutdown          = local.shutdown
  }

