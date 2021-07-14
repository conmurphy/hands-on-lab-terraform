resource "aci_lldp_interface_policy" "test_lldp" {
    name = var.aci_tenant 
}

resource "aci_attachable_access_entity_profile" "test_ep" {
    name = var.aci_tenant 
  
}

resource "aci_lacp_policy" "test_lacp" {
  name = var.aci_tenant 
}

resource "aci_leaf_interface_profile" "test_leaf_profile" {
    name = var.aci_tenant 
}

resource "aci_leaf_profile" "tf_leaf_prof" {
    name = var.aci_tenant 
}


resource "aci_miscabling_protocol_interface_policy" "test_miscable" {
    name = var.aci_tenant 
}


resource "aci_access_port_selector" "test_selector" {
    leaf_interface_profile_dn = aci_leaf_interface_profile.test_leaf_profile.id
    name = var.aci_tenant 
    access_port_selector_type = "ALL"
    
}

