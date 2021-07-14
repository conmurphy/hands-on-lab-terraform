variable "aci_tenant" {}
variable "app_name" {}
variable "epg" {}

variable "flood_on_encap"{
    default = "enabled"
}  
variable "fwd_ctrl" {
    default = "none"
}
variable "has_mcast_source" {
    default = "no"
}
variable "match_t" {
    default = "AtleastOne"
}
variable "pc_enf_pref" {
    default = "unenforced"
}
variable "pref_gr_memb" {
    default = "exclude"
}
variable "prio" {
    default = "unspecified"
}
variable "shutdown" {
    default = "no"
}


