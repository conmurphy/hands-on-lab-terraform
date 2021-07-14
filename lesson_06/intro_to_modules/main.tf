locals  {
    app_profiles = {
      "firstApp" = {
        "epg" : ["web","app", "db"],
      },
      "secondApp" = {
        "epg" : ["frontend","backend"],
      },
      "thirdApp" = {
        "epg" : ["primary","secondary"],
      } 
    }
}


module "application" {
  source = "./modules/application"
  
  for_each = local.app_profiles

  aci_tenant = var.aci_tenant
  app_name = each.key
  epg = toset(each.value["epg"])

  flood_on_encap = "disabled"

  
  
}

