# Table of Contents
- [Getting familiar with Terraform commands and files](#1-getting-familiar-with-terraform-commands-and-files)
- [Config structure and variables](#2-config-structure-and-variables)
- [More on Variables and Dependencies](#3-more-on-variables-and-dependencies)
- [Understanding Terraform State](#3b-understanding-terraform-state)
- [Resources vs Data Source](#4-resources-vs-data-source)
- [Importing existing configuratiion](#5-importing-existing-configuratiion)
- [Intro to Directory Structure and Modules](#6-intro-to-directory-structure-and-modules)
- [Introto Terraform Cloud](#7-intro-to-terraform-cloud)
- [Optional: Other Useful Terraform Commands](#optional--other-useful-terraform-commands)
- [References](#references)

## 1. Getting familiar with Terraform commands and files
- Clone the following Git repository

`git clone https://github.com/conmurphy/hands-on-lab-terraform.git`  

- Navigate to the folder containing the first lesson

`cd hands-on-lab-terraform/lesson_01/`  

- In a browser go to https://sandboxapicdc.cisco.com/ and login (`admin`/`ciscopsdt`)  

- Verify that no tenant exists with your Cisco username  

- Initialise Terraform - This will download the required Terraform providers  

`terraform init`  

<details>
  <summary>Click to see expected output</summary>
  
  ```
  Initializing the backend...

    Initializing provider plugins...
    - Finding ciscodevnet/aci versions matching "0.4.1"...
    - Installing ciscodevnet/aci v0.4.1...
    - Installed ciscodevnet/aci v0.4.1 (signed by a HashiCorp partner, key ID 433649E2C56309DE)

    Partner and community providers are signed by their developers.
    If you'd like to know more about provider signing, you can read about it here:
    https://www.terraform.io/docs/cli/plugins/signing.html

    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.


    Warning: Interpolation-only expressions are deprecated

    on main.tf line 15, in provider "aci":
    15:   username = "${var.apic_username}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
  ```
</details>
  
- Perform a dry run of your Terraform configuration using the `plan` command. You should see resources that will be created. 

`terraform plan`  

  - You will need to enter the ACI URL, username, and password. Use your **username** for the tenant name


  ```
  var.aci_tenant
  Enter a value: conmurphy

  var.apic_password
  Enter a value: ciscopsdt

  var.apic_url
  Enter a value: https://sandboxapicdc.cisco.com 

  var.apic_username
  Enter a value: admin
  ```


<details>
  <summary>Click to see expected output</summary>
  
  ```
  An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aci_application_epg.db will be created
  + resource "aci_application_epg" "db" {
      + annotation             = "orchestrator:terraform"
      + application_profile_dn = (known after apply)
      + description            = "this is the database epg created by terraform"
      + exception_tag          = (known after apply)
      + flood_on_encap         = "disabled"
      + fwd_ctrl               = "none"
      + has_mcast_source       = "no"
      + id                     = (known after apply)
      + is_attr_based_epg      = (known after apply)
      + match_t                = "AtleastOne"
      + name                   = "db"
      + name_alias             = "db"
      + pc_enf_pref            = "unenforced"
      + pref_gr_memb           = "exclude"
      + prio                   = "unspecified"
      + shutdown               = "no"
    }

  # aci_application_epg.web will be created
  + resource "aci_application_epg" "web" {
      + annotation             = "orchestrator:terraform"
      + application_profile_dn = (known after apply)
      + description            = "this is the web epg created by terraform"
      + exception_tag          = (known after apply)
      + flood_on_encap         = "disabled"
      + fwd_ctrl               = "none"
      + has_mcast_source       = "no"
      + id                     = (known after apply)
      + is_attr_based_epg      = (known after apply)
      + match_t                = "AtleastOne"
      + name                   = "web"
      + name_alias             = "web"
      + pc_enf_pref            = "unenforced"
      + pref_gr_memb           = "exclude"
      + prio                   = "unspecified"
      + shutdown               = "no"
    }

  # aci_application_profile.myWebsite will be created
  + resource "aci_application_profile" "myWebsite" {
      + annotation  = "orchestrator:terraform"
      + description = (known after apply)
      + id          = (known after apply)
      + name        = "my_website"
      + name_alias  = (known after apply)
      + prio        = (known after apply)
      + tenant_dn   = (known after apply)
    }

  # aci_bridge_domain.bd_for_subnet will be created
  + resource "aci_bridge_domain" "bd_for_subnet" {
      + annotation                  = "orchestrator:terraform"
      + arp_flood                   = (known after apply)
      + bridge_domain_type          = (known after apply)
      + description                 = "This bridge domain is created by the Terraform ACI provider"
      + ep_clear                    = (known after apply)
      + ep_move_detect_mode         = (known after apply)
      + host_based_routing          = (known after apply)
      + id                          = (known after apply)
      + intersite_bum_traffic_allow = (known after apply)
      + intersite_l2_stretch        = (known after apply)
      + ip_learning                 = (known after apply)
      + ipv6_mcast_allow            = (known after apply)
      + limit_ip_learn_to_subnets   = (known after apply)
      + ll_addr                     = (known after apply)
      + mac                         = (known after apply)
      + mcast_allow                 = (known after apply)
      + multi_dst_pkt_act           = (known after apply)
      + name                        = "bd_for_subnet"
      + name_alias                  = (known after apply)
      + optimize_wan_bandwidth      = (known after apply)
      + tenant_dn                   = (known after apply)
      + unicast_route               = (known after apply)
      + unk_mac_ucast_act           = (known after apply)
      + unk_mcast_act               = (known after apply)
      + v6unk_mcast_act             = (known after apply)
      + vmac                        = (known after apply)
    }

  # aci_subnet.demosubnet will be created
  + resource "aci_subnet" "demosubnet" {
      + annotation  = "orchestrator:terraform"
      + ctrl        = (known after apply)
      + description = "This subject is created by Terraform"
      + id          = (known after apply)
      + ip          = "172.16.1.1/24"
      + name_alias  = (known after apply)
      + parent_dn   = (known after apply)
      + preferred   = (known after apply)
      + scope       = "private"
      + virtual     = (known after apply)
    }

  # aci_tenant.aci_tenant will be created
  + resource "aci_tenant" "aci_tenant" {
      + annotation  = "orchestrator:terraform"
      + description = (known after apply)
      + id          = (known after apply)
      + name        = "conmurphy"
      + name_alias  = (known after apply)
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Warning: Interpolation-only expressions are deprecated

  on main.tf line 15, in provider "aci":
  15:   username = "${var.apic_username}"

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.

(and 7 more similar warnings elsewhere)


------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
  ```
</details>


- Push the configuration to the ACI fabric using the `apply` command  

`terraform apply --auto-approve`  

  - You will need to enter the ACI URL, username, and password. Use your **username** for the tenant name


  ```
  var.aci_tenant
  Enter a value: conmurphy

  var.apic_password
  Enter a value: ciscopsdt

  var.apic_url
  Enter a value: https://sandboxapicdc.cisco.com 

  var.apic_username
  Enter a value: admin
  ```


<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 2s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.db: Creating...
    aci_application_epg.web: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 5s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.web: Creation complete after 5s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Creation complete after 5s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Creation complete after 0s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Warning: Interpolation-only expressions are deprecated

      on main.tf line 15, in provider "aci":
      15:   username = "${var.apic_username}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
  ```
</details>


- Verify in the ACI GUI in the `Tenants` tab that your new tenant has been created and within the tenant a new application profile has been created.

- Destroy your ACI tenant and all objects within that tenant.

`terraform destroy`

 - You will need to enter the ACI URL, username, and password. Use your **username** for the tenant name

 - You will also need to type `yes` when asked if you really want to destroy all resources? 


  ```
  var.aci_tenant
  Enter a value: conmurphy

  var.apic_password
  Enter a value: ciscopsdt

  var.apic_url
  Enter a value: https://sandboxapicdc.cisco.com 

  var.apic_username
  Enter a value: admin
  ```

<details>
  <summary>Click to see expected output</summary>

   ```
   An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      # aci_application_epg.db will be destroyed
      - resource "aci_application_epg" "db" {
          - annotation             = "orchestrator:terraform" -> null
          - application_profile_dn = "uni/tn-conmurphy/ap-my_website" -> null
          - description            = "this is the database epg created by terraform" -> null
          - flood_on_encap         = "disabled" -> null
          - has_mcast_source       = "no" -> null
          - id                     = "uni/tn-conmurphy/ap-my_website/epg-db" -> null
          - is_attr_based_epg      = "no" -> null
          - match_t                = "AtleastOne" -> null
          - name                   = "db" -> null
          - name_alias             = "db" -> null
          - pc_enf_pref            = "unenforced" -> null
          - pref_gr_memb           = "exclude" -> null
          - prio                   = "unspecified" -> null
          - shutdown               = "no" -> null
        }

      # aci_application_epg.web will be destroyed
      - resource "aci_application_epg" "web" {
          - annotation             = "orchestrator:terraform" -> null
          - application_profile_dn = "uni/tn-conmurphy/ap-my_website" -> null
          - description            = "this is the web epg created by terraform" -> null
          - flood_on_encap         = "disabled" -> null
          - has_mcast_source       = "no" -> null
          - id                     = "uni/tn-conmurphy/ap-my_website/epg-web" -> null
          - is_attr_based_epg      = "no" -> null
          - match_t                = "AtleastOne" -> null
          - name                   = "web" -> null
          - name_alias             = "web" -> null
          - pc_enf_pref            = "unenforced" -> null
          - pref_gr_memb           = "exclude" -> null
          - prio                   = "unspecified" -> null
          - shutdown               = "no" -> null
        }

      # aci_application_profile.myWebsite will be destroyed
      - resource "aci_application_profile" "myWebsite" {
          - annotation = "orchestrator:terraform" -> null
          - id         = "uni/tn-conmurphy/ap-my_website" -> null
          - name       = "my_website" -> null
          - prio       = "unspecified" -> null
          - tenant_dn  = "uni/tn-conmurphy" -> null
        }

      # aci_bridge_domain.bd_for_subnet will be destroyed
      - resource "aci_bridge_domain" "bd_for_subnet" {
          - annotation                  = "orchestrator:terraform" -> null
          - arp_flood                   = "no" -> null
          - bridge_domain_type          = "regular" -> null
          - description                 = "This bridge domain is created by the Terraform ACI provider" -> null
          - ep_clear                    = "no" -> null
          - host_based_routing          = "no" -> null
          - id                          = "uni/tn-conmurphy/BD-bd_for_subnet" -> null
          - intersite_bum_traffic_allow = "no" -> null
          - intersite_l2_stretch        = "no" -> null
          - ip_learning                 = "yes" -> null
          - limit_ip_learn_to_subnets   = "yes" -> null
          - ll_addr                     = "::" -> null
          - mac                         = "00:22:BD:F8:19:FF" -> null
          - mcast_allow                 = "no" -> null
          - multi_dst_pkt_act           = "bd-flood" -> null
          - name                        = "bd_for_subnet" -> null
          - optimize_wan_bandwidth      = "no" -> null
          - tenant_dn                   = "uni/tn-conmurphy" -> null
          - unicast_route               = "yes" -> null
          - unk_mac_ucast_act           = "proxy" -> null
          - unk_mcast_act               = "flood" -> null
          - v6unk_mcast_act             = "flood" -> null
          - vmac                        = "not-applicable" -> null
        }

      # aci_subnet.demosubnet will be destroyed
      - resource "aci_subnet" "demosubnet" {
          - annotation  = "orchestrator:terraform" -> null
          - ctrl        = "nd" -> null
          - description = "This subject is created by Terraform" -> null
          - id          = "uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]" -> null
          - ip          = "172.16.1.1/24" -> null
          - parent_dn   = "uni/tn-conmurphy/BD-bd_for_subnet" -> null
          - preferred   = "no" -> null
          - scope       = "private" -> null
          - virtual     = "no" -> null
        }

      # aci_tenant.aci_tenant will be destroyed
      - resource "aci_tenant" "aci_tenant" {
          - annotation = "orchestrator:terraform" -> null
          - id         = "uni/tn-conmurphy" -> null
          - name       = "conmurphy" -> null
        }

    Plan: 0 to add, 0 to change, 6 to destroy.


    Warning: Interpolation-only expressions are deprecated

      on main.tf line 15, in provider "aci":
      15:   username = "${var.apic_username}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)

    Do you really want to destroy all resources?
      Terraform will destroy all your managed infrastructure, as shown above.
      There is no undo. Only 'yes' will be accepted to confirm.

      Enter a value: yes

    aci_subnet.demosubnet: Destroying... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.web: Destroying... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Destroying... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Destruction complete after 2s
    aci_application_epg.db: Destruction complete after 2s
    aci_application_epg.web: Destruction complete after 2s
    aci_bridge_domain.bd_for_subnet: Destroying... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_profile.myWebsite: Destroying... [id=uni/tn-conmurphy/ap-my_website]
    aci_application_profile.myWebsite: Destruction complete after 0s
    aci_bridge_domain.bd_for_subnet: Destruction complete after 0s
    aci_tenant.aci_tenant: Destroying... [id=uni/tn-conmurphy]
    aci_tenant.aci_tenant: Destruction complete after 0s

    Destroy complete! Resources: 6 destroyed.
  ```
</details>

## 2. Config structure and variables

- Navigate to the next lesson

`cd hands-on-lab-terraform/lesson_02/`

You will notice that instead of a single `main.tf` file we now have multiple `.tf` files. By default Terraform will read all `.tf` files in the directory from which the Terraform command was ran. 

The names of the files do not matter so long as they end in `.tf`. In our example we have split the files into their specific purposes. 

<details>
  <summary>Click to get more details on each file</summary>

  #### `versions.tf`

  ```
    terraform {
      required_providers {
        aci = {
          source = "ciscodevnet/aci"
          version = "0.4.1"
        }
      }
      required_version = ">= 0.13.4"
    }
  ```
  We define the providers and required versions as well as the version of Terraform that we will require

  #### `providers.tf`

  ```
    provider "aci" {
      username = "${var.apic_username}"
      password = "${var.apic_password}"
      url      = "${var.apic_url}"
      insecure = true
    }
  ```
  This points Terraform to our ACI provider. It references the variables we will receive from the user input

  #### `variables.tf`
  ```
    variable "aci_tenant" {}
    variable "apic_url" {}
    variable "apic_username" {}
    variable "apic_password" {}
  ```
  This lets Terraform know that we expect four variables. We could also define a default value if needed.

  ```
    variable "aci_tenant" {}
    variable "apic_url" {
      default = "https://sandboxapicdc.cisco.com"
    }
    variable "apic_username" {}
    variable "apic_password" {}
  ```

  #### `terraform.tfvars`
  ```
    apic_url = "https://sandboxapicdc.cisco.com"
    apic_username = "admin"
  ```
  We need to initialise variables within Terraform. This is the previous step. If we don't provide any default values Terraform will ask for this through the input prompt when we run the `terraform plan` and `terraform apply` commands. This was the behaviour we saw in the previous lesson.

  If we want to define values for the Terraform variables, but want to keep them out of the code, we can add them to a separate file call `terraform.tfvars`. An example of this may be credentials or specific environment configuration that we don't want committed to our version control system.

  Alternatively you can define an environmental variable using the prefix TF_VAR. For example, `TF_VAR_apic_url` 

  https://www.terraform.io/docs/cli/config/environment-variables.html

  #### `aci.tf`

  We've included all our ACI Terraform configuration in this file. This works for our small example however it can quickly grow. Later on we will look at examples how to break your infrastructure configuration into smaller, more manageable pieces. 

</details>

- Verify that no tenant exists with your Cisco username  

- Initialise Terraform - This will download the required Terraform providers  

`terraform init`  

<details>
  <summary>Click to see expected output</summary>
  
  ```
  Initializing the backend...

    Initializing provider plugins...
    - Finding ciscodevnet/aci versions matching "0.4.1"...
    - Installing ciscodevnet/aci v0.4.1...
    - Installed ciscodevnet/aci v0.4.1 (signed by a HashiCorp partner, key ID 433649E2C56309DE)

    Partner and community providers are signed by their developers.
    If you'd like to know more about provider signing, you can read about it here:
    https://www.terraform.io/docs/cli/plugins/signing.html

    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.


    Warning: Interpolation-only expressions are deprecated

    on main.tf line 15, in provider "aci":
    15:   username = "${var.apic_username}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
  ```
</details>

- Perform a dry run of your Terraform configuration using the `plan` command. You should see resources that will be created. 

`terraform plan`  

  - Note that this time you are only asked for your tenant name and ACI password. This is because the `terraform.tfvars` file contains the values for the `apic_url` and `apic_username`. Use your **username** for the tenant name

  ```
  var.aci_tenant
  Enter a value: conmurphy

  var.apic_password
  Enter a value: ciscopsdt
  ```

<details>
  <summary>Click to see expected output</summary>
  
  ```
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # aci_application_epg.db will be created
      + resource "aci_application_epg" "db" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the database epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "disabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "db"
          + name_alias             = "db"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_epg.web will be created
      + resource "aci_application_epg" "web" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "disabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "web"
          + name_alias             = "web"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_profile.myWebsite will be created
      + resource "aci_application_profile" "myWebsite" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "my_website"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # aci_bridge_domain.bd_for_subnet will be created
      + resource "aci_bridge_domain" "bd_for_subnet" {
          + annotation                  = "orchestrator:terraform"
          + arp_flood                   = (known after apply)
          + bridge_domain_type          = (known after apply)
          + description                 = "This bridge domain is created by the Terraform ACI provider"
          + ep_clear                    = (known after apply)
          + ep_move_detect_mode         = (known after apply)
          + host_based_routing          = (known after apply)
          + id                          = (known after apply)
          + intersite_bum_traffic_allow = (known after apply)
          + intersite_l2_stretch        = (known after apply)
          + ip_learning                 = (known after apply)
          + ipv6_mcast_allow            = (known after apply)
          + limit_ip_learn_to_subnets   = (known after apply)
          + ll_addr                     = (known after apply)
          + mac                         = (known after apply)
          + mcast_allow                 = (known after apply)
          + multi_dst_pkt_act           = (known after apply)
          + name                        = "bd_for_subnet"
          + name_alias                  = (known after apply)
          + optimize_wan_bandwidth      = (known after apply)
          + tenant_dn                   = (known after apply)
          + unicast_route               = (known after apply)
          + unk_mac_ucast_act           = (known after apply)
          + unk_mcast_act               = (known after apply)
          + v6unk_mcast_act             = (known after apply)
          + vmac                        = (known after apply)
        }

      # aci_subnet.demosubnet will be created
      + resource "aci_subnet" "demosubnet" {
          + annotation  = "orchestrator:terraform"
          + ctrl        = (known after apply)
          + description = "This subject is created by Terraform"
          + id          = (known after apply)
          + ip          = "172.16.1.1/24"
          + name_alias  = (known after apply)
          + parent_dn   = (known after apply)
          + preferred   = (known after apply)
          + scope       = "private"
          + virtual     = (known after apply)
        }

      # aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

    Plan: 6 to add, 0 to change, 0 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>

- Push the configuration to the ACI fabric using the `apply` command  

`terraform apply --auto-approve`  

  - Note that this time you are only asked for your tenant name and ACI password. This is because the `terraform.tfvars` file contains the values for the `apic_url` and `apic_username`. Use your **username** for the tenant name

  ```
  var.aci_tenant
  Enter a value: conmurphy

  var.apic_password
  Enter a value: ciscopsdt
  ```
  
<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 1s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.web: Creating...
    aci_application_epg.db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 3s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.web: Creation complete after 4s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.db: Creation complete after 4s [id=uni/tn-conmurphy/ap-my_website/epg-db]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
  ```
</details>

- Verify in the ACI GUI in the `Tenants` tab that your new tenant has been created and within the tenant a new application profile has been created. **Note that the ACI configuration has remained the same, we've simply split the Terraform configuration into separate files** 

- Cleanup your ACI tenant and all objects within that tenant.

`terraform destroy`


## 3. More on Variables and Dependencies


We've already seen some variables used to store the URL, username, password, and ACI tenant name. We also have other options to store data, such as **Terraform Local Values**

> Terraform locals are named values that you can refer to in your configuration. You can use local values to simplify your Terraform configuration and avoid repetition. Local values (locals) can also help you write more readable configuration by using meaningful names rather than hard-coding values.

https://learn.hashicorp.com/tutorials/terraform/locals

- Before we continue let's reduce the amount of input we need to provide by creating environmental variables for our tenant name and password

**IMPORTANT NOTE: YOU NEED TO INSERT YOUR USERNAME**

- `export TF_VAR_aci_tenant=<your username here>`

- `export TF_VAR_apic_password=ciscopsdt`

- Navigate to the next lesson

`cd hands-on-lab-terraform/lesson_03/`

- Open the `variables.tf` file and view the new local values we have. 

Since our EPGs have a number of common properties we will store those in a local variable. If we need to change one in the future we only have to change it in this one place and all resources using the local variable will be updated.

- Open the `aci.tf` file and have a look at the `resource "aci_application_epg"`. See how we can reference the local variables with `local.`. For example, `flood_on_encap = local.flood_on_encap`

- Initialise Terraform - This will download the required Terraform providers  

`terraform init`  

- Push the configuration to the ACI fabric using the `apply` command  

`terraform apply --auto-approve`  

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 1s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.web: Creating...
    aci_application_epg.db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 2s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.web: Creation complete after 3s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.db: Creation complete after 3s [id=uni/tn-conmurphy/ap-my_website/epg-db]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
  ```
</details>

- Open the `variables.tf` file and modified the  `local.flood_on_encap` variable from `disabled` to `enabled`

- Run a plan and look at the results

`terraform plan`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      ~ update in-place

    Terraform will perform the following actions:

      # aci_application_epg.db will be updated in-place
      ~ resource "aci_application_epg" "db" {
          ~ flood_on_encap               = "disabled" -> "enabled"
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-db"
            name                         = "db"
            # (21 unchanged attributes hidden)
        }

      # aci_application_epg.web will be updated in-place
      ~ resource "aci_application_epg" "web" {
          ~ flood_on_encap               = "disabled" -> "enabled"
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-web"
            name                         = "web"
            # (21 unchanged attributes hidden)
        }

    Plan: 0 to add, 2 to change, 0 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>

As you can see, we have updated the variable in one location but the two EPGs using this variable will automatically be updated. This becomes very useful when we are working with large quantities of resources that have common properties.

**Output Values**

Terraform can also return and print values after a plan has been applied. This is through the use of the output value. This feature is useful when you start to use modules within Terraform.

- Open the `variables.tf` file and after the `locals` block paste the following. Then save the file.

```
output "application_profile_id" {
  value = aci_application_profile.myWebsite.id
}
```

<details>
   <summary>Click to show entire variables.tf file</summary>

  ```
    variable "apic_url" {}
    variable "apic_username" {}
    variable "apic_password" {}
    variable "aci_tenant" {}

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
  ```

</details>

- Re-run the apply command 

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.db: Modifying... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.web: Modifying... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.web: Modifications complete after 1s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Modifications complete after 1s [id=uni/tn-conmurphy/ap-my_website/epg-db]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    Apply complete! Resources: 0 added, 2 changed, 0 destroyed.

    Outputs:

    application_profile_id = "uni/tn-conmurphy/ap-my_website"
  ```
</details>

You should see right at the very end an Output Value with the ID of your application profile.

- Open the `variables.tf` file and delete the output variable in preparation for the next lesson. Then save the file. 

```
output "application_profile_id" {
  value = aci_application_profile.myWebsite.id
}
```

**Dependencies**

ACI, just like many other products is built using many different objects. These object often relate to each other in some way. For example, an EPG is contained within an Application Profile (AP), and an AP lives in a Tenant.

We can see these relationships in our ACI configuration.

- Open the `aci.tf` file and look at the resource `resource "aci_application_epg" "web"`

To tell ACI which AP this EPG belongs to we can reference the AP resource. 

- Look at the next line, `application_profile_dn  = "${aci_application_profile.myWebsite.id}"`

This means that the ID or distinguished name of the application profile to which this EPG belongs is the ID of an application profile called `myWebsite`. 

- In the `aci.tf` file locate the `resource "aci_application_profile" "myWebsite" ` which should be right above the EPG.

You can also see that the application profile is linked to the Tenant ID in the same way.

**Important Notes:** 
- Terraform will automatically link these resources together when a plan is applied. There is an inherent dependency because one resource is referencing another. That means a tenant will be created before an AP, and an AP created before and EPG.
- In the case where you don't have a link between two resources but need to ensure one resource is created before another, you can use `depends_on`

  https://www.terraform.io/docs/language/meta-arguments/depends_on.html


## 3b. Understanding Terraform State

So far we've been configuring our ACI fabric with Terraform however how is the configuration tracked? 

This is performed through the use of a Statefile. 

<details>
   <summary>Click to read more about Terraform state</summary>

  >  Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

  > This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.

  https://www.terraform.io/docs/language/state/index.html

</details>
- If you're noot still in lesson_03, navigate to the folder

`cd hands-on-lab-terraform/lesson_03/`

- Run another `plan` and confirm that no new objects are created.

`terraform plan`

  - Note that you may see some updates but you shouldn't see any new creations as the tenant and objects should still be existing from the previous `apply`

<details>
   <summary>Click to see expected output</summary>

  ```
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      ~ update in-place

    Terraform will perform the following actions:

      # aci_application_epg.db will be updated in-place
      ~ resource "aci_application_epg" "db" {
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-db"
            name                         = "db"
            # (22 unchanged attributes hidden)
        }

      # aci_application_epg.web will be updated in-place
      ~ resource "aci_application_epg" "web" {
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-web"
            name                         = "web"
            # (22 unchanged attributes hidden)
        }

    Plan: 0 to add, 2 to change, 0 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.

  ```

</details>

- Open the `terraform.tfstate` file in a text editor and have a look through. This is all the configuration that Terraform knows about in relation to your ACI fabric. It contains all of the managed resources like Tenant, App profile, and EPGs, including properties that we haven't configured in our Terraform files.

**IMPORTANT POINT:** Terraform works by looking at the difference between the configuration in your `.tf` files and the configuration it knows about in the `terraform.tfstate` file. Based on this comparison it determines what operation needs to take place (Create, Update, or Delete a resource).

### What happens if we remove the state file?

- Rename the statefile so Terraform can't find it

`mv terraform.tfstate terraform.tfstate_hidden`

- Run another `plan` and notice that Terraform is planning to create new ACI Tenant, APN, EPG, and BD objects. 

`terraform plan`

<details>
   <summary>Click to see expected output</summary>

  ```
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # aci_application_epg.db will be created
      + resource "aci_application_epg" "db" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the database epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "disabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "db"
          + name_alias             = "db"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_epg.web will be created
      + resource "aci_application_epg" "web" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "disabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "web"
          + name_alias             = "web"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_profile.myWebsite will be created
      + resource "aci_application_profile" "myWebsite" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "my_website"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # aci_bridge_domain.bd_for_subnet will be created
      + resource "aci_bridge_domain" "bd_for_subnet" {
          + annotation                  = "orchestrator:terraform"
          + arp_flood                   = (known after apply)
          + bridge_domain_type          = (known after apply)
          + description                 = "This bridge domain is created by the Terraform ACI provider"
          + ep_clear                    = (known after apply)
          + ep_move_detect_mode         = (known after apply)
          + host_based_routing          = (known after apply)
          + id                          = (known after apply)
          + intersite_bum_traffic_allow = (known after apply)
          + intersite_l2_stretch        = (known after apply)
          + ip_learning                 = (known after apply)
          + ipv6_mcast_allow            = (known after apply)
          + limit_ip_learn_to_subnets   = (known after apply)
          + ll_addr                     = (known after apply)
          + mac                         = (known after apply)
          + mcast_allow                 = (known after apply)
          + multi_dst_pkt_act           = (known after apply)
          + name                        = "bd_for_subnet"
          + name_alias                  = (known after apply)
          + optimize_wan_bandwidth      = (known after apply)
          + tenant_dn                   = (known after apply)
          + unicast_route               = (known after apply)
          + unk_mac_ucast_act           = (known after apply)
          + unk_mcast_act               = (known after apply)
          + v6unk_mcast_act             = (known after apply)
          + vmac                        = (known after apply)
        }

      # aci_subnet.demosubnet will be created
      + resource "aci_subnet" "demosubnet" {
          + annotation  = "orchestrator:terraform"
          + ctrl        = (known after apply)
          + description = "This subject is created by Terraform"
          + id          = (known after apply)
          + ip          = "172.16.1.1/24"
          + name_alias  = (known after apply)
          + parent_dn   = (known after apply)
          + preferred   = (known after apply)
          + scope       = "private"
          + virtual     = (known after apply)
        }

      # aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

    Plan: 6 to add, 0 to change, 0 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.

  ```

</details>


This is a key principle of how Terraform works. Terraform will only interact with the objects that it knows about. **It won't automatically discover what has already been configured in the environment. (See importing later on)**

Since we effectively removed the statefile, Terraform did not know the ACI objects already existed and tried to recreate them.

### Will the plan apply correctly since the objects already exist?

- Push the configuration to the ACI fabric using the `apply` command  

`terraform apply --auto-approve`  
  
<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 1s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.web: Creating...
    aci_application_epg.db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 2s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.web: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Creation complete after 0s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 7 more similar warnings elsewhere)


    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
  ```
</details>

As you can see the apply should have gone through successfully, even though the ACI objects already exist. **Note that this behaviour is dependent on the Terraform provider.**

**In some cases you may receive an error that the object already exists. In that case you would need to import the existing configuration into your Terraform state file.**

**In our example, ACI is able to determine that the object exists and can update the existing configuration**

You'll also note that you should now have a new `terraform.tfstate` file alongside your `terraform.tfstate_hidden` file. This is because terraform did not find a file with the name, `terraform.tfstate`, and creatd a new one for you.

### What happens if delete the Terraform ACI config?
- Rename the ACI configuration file so Terraform can't find it

`mv aci.tf aci.tf_hidden`

- Run another `plan` and notice that Terraform is planning to delete all of your ACI configuration!

`terraform plan`

<details>
   <summary>Click to see expected output</summary>

  ```
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      # aci_application_epg.db will be destroyed
      - resource "aci_application_epg" "db" {
          - annotation                   = "orchestrator:terraform" -> null
          - application_profile_dn       = "uni/tn-conmurphy/ap-my_website" -> null
          - description                  = "this is the database epg created by terraform" -> null
          - flood_on_encap               = "disabled" -> null
          - has_mcast_source             = "no" -> null
          - id                           = "uni/tn-conmurphy/ap-my_website/epg-db" -> null
          - is_attr_based_epg            = "no" -> null
          - match_t                      = "AtleastOne" -> null
          - name                         = "db" -> null
          - name_alias                   = "db" -> null
          - pc_enf_pref                  = "unenforced" -> null
          - pref_gr_memb                 = "exclude" -> null
          - prio                         = "unspecified" -> null
          - relation_fv_rs_cons          = [] -> null
          - relation_fv_rs_cons_if       = [] -> null
          - relation_fv_rs_fc_path_att   = [] -> null
          - relation_fv_rs_graph_def     = [] -> null
          - relation_fv_rs_intra_epg     = [] -> null
          - relation_fv_rs_node_att      = [] -> null
          - relation_fv_rs_prot_by       = [] -> null
          - relation_fv_rs_prov          = [] -> null
          - relation_fv_rs_prov_def      = [] -> null
          - relation_fv_rs_sec_inherited = [] -> null
          - shutdown                     = "no" -> null
        }

      # aci_application_epg.web will be destroyed
      - resource "aci_application_epg" "web" {
          - annotation                   = "orchestrator:terraform" -> null
          - application_profile_dn       = "uni/tn-conmurphy/ap-my_website" -> null
          - description                  = "this is the web epg created by terraform" -> null
          - flood_on_encap               = "disabled" -> null
          - has_mcast_source             = "no" -> null
          - id                           = "uni/tn-conmurphy/ap-my_website/epg-web" -> null
          - is_attr_based_epg            = "no" -> null
          - match_t                      = "AtleastOne" -> null
          - name                         = "web" -> null
          - name_alias                   = "web" -> null
          - pc_enf_pref                  = "unenforced" -> null
          - pref_gr_memb                 = "exclude" -> null
          - prio                         = "unspecified" -> null
          - relation_fv_rs_cons          = [] -> null
          - relation_fv_rs_cons_if       = [] -> null
          - relation_fv_rs_fc_path_att   = [] -> null
          - relation_fv_rs_graph_def     = [] -> null
          - relation_fv_rs_intra_epg     = [] -> null
          - relation_fv_rs_node_att      = [] -> null
          - relation_fv_rs_prot_by       = [] -> null
          - relation_fv_rs_prov          = [] -> null
          - relation_fv_rs_prov_def      = [] -> null
          - relation_fv_rs_sec_inherited = [] -> null
          - shutdown                     = "no" -> null
        }

      # aci_application_profile.myWebsite will be destroyed
      - resource "aci_application_profile" "myWebsite" {
          - annotation = "orchestrator:terraform" -> null
          - id         = "uni/tn-conmurphy/ap-my_website" -> null
          - name       = "my_website" -> null
          - prio       = "unspecified" -> null
          - tenant_dn  = "uni/tn-conmurphy" -> null
        }

      # aci_bridge_domain.bd_for_subnet will be destroyed
      - resource "aci_bridge_domain" "bd_for_subnet" {
          - annotation                  = "orchestrator:terraform" -> null
          - arp_flood                   = "no" -> null
          - bridge_domain_type          = "regular" -> null
          - description                 = "This bridge domain is created by the Terraform ACI provider" -> null
          - ep_clear                    = "no" -> null
          - host_based_routing          = "no" -> null
          - id                          = "uni/tn-conmurphy/BD-bd_for_subnet" -> null
          - intersite_bum_traffic_allow = "no" -> null
          - intersite_l2_stretch        = "no" -> null
          - ip_learning                 = "yes" -> null
          - limit_ip_learn_to_subnets   = "yes" -> null
          - ll_addr                     = "::" -> null
          - mac                         = "00:22:BD:F8:19:FF" -> null
          - mcast_allow                 = "no" -> null
          - multi_dst_pkt_act           = "bd-flood" -> null
          - name                        = "bd_for_subnet" -> null
          - optimize_wan_bandwidth      = "no" -> null
          - relation_fv_rs_bd_flood_to  = [] -> null
          - relation_fv_rs_bd_to_out    = [] -> null
          - tenant_dn                   = "uni/tn-conmurphy" -> null
          - unicast_route               = "yes" -> null
          - unk_mac_ucast_act           = "proxy" -> null
          - unk_mcast_act               = "flood" -> null
          - v6unk_mcast_act             = "flood" -> null
          - vmac                        = "not-applicable" -> null
        }

      # aci_subnet.demosubnet will be destroyed
      - resource "aci_subnet" "demosubnet" {
          - annotation                      = "orchestrator:terraform" -> null
          - ctrl                            = "nd" -> null
          - description                     = "This subject is created by Terraform" -> null
          - id                              = "uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]" -> null
          - ip                              = "172.16.1.1/24" -> null
          - parent_dn                       = "uni/tn-conmurphy/BD-bd_for_subnet" -> null
          - preferred                       = "no" -> null
          - relation_fv_rs_bd_subnet_to_out = [] -> null
          - scope                           = "private" -> null
          - virtual                         = "no" -> null
        }

      # aci_tenant.aci_tenant will be destroyed
      - resource "aci_tenant" "aci_tenant" {
          - annotation                  = "orchestrator:terraform" -> null
          - id                          = "uni/tn-conmurphy" -> null
          - name                        = "conmurphy" -> null
          - relation_fv_rs_tn_deny_rule = [] -> null
        }

    Plan: 0 to add, 0 to change, 6 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on providers.tf line 3, in provider "aci":
      3:   username = "${var.apic_username}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 2 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.

  ```

</details>

Just like the previous example with the statefile, this is another key principle of how Terraform works. As noted above, Terraform looks at the difference between the state file and the configuration in the `.tf` files. 

In this example Terraform saw that the ACI fabric was configured (`terraform.tfstate` file) but could not find any required ACI configuration (we hid the `aci.tf` file).

Based on this it assumed the ACI configuration was no longer needed and removed it from the fabric (delete operation).

[Example of when things go wrong](https://www.youtube.com/watch?v=ix0Tw8uinWs)

- Cleanup your ACI configuration and all objects within that tenant.

`terraform destroy`


## 4. Resources vs Data Source

So far we've been creating, updating, and deleting resources with Terraform. What happens if a resource is already configured and we simply need to reference it?

We can use the Terraform `data source` to access configuration created outside of Terraform or by another Terraform plan. The data source is **read only**

https://www.terraform.io/docs/language/data-sources/index.html

- Navigate to the folder containing the next lesson

`cd hands-on-lab-terraform/lesson_04/`  

- Open `aci.tf` in your text editor and have a look at the `aci_tenant`. As you can see, rather than `resource "aci_tenant" "aci_tenant" {` we are using `data "aci_tenant" "aci_tenant" {`

Notice that we are specifying the name of a tenant, `common`. Terraform will not create a tenant like in previous lessons but instead use this existing tenant to create our application profiles and EPGs.

- Initialise Terraform  

`terraform init`

- Run a plan and look at the results

`terraform plan`

  - When prompted for the `aci_app_name` use your **username**
  ```
  var.aci_app_name
      Enter a value: conmurphy
  ```

<details>
  <summary>Click to see expected output</summary>
  
  ```
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # aci_application_epg.db will be created
      + resource "aci_application_epg" "db" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the database epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "db"
          + name_alias             = "db"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_epg.web will be created
      + resource "aci_application_epg" "web" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "web"
          + name_alias             = "web"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_profile.myWebsite will be created
      + resource "aci_application_profile" "myWebsite" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = "uni/tn-common"
        }

      # aci_bridge_domain.bd_for_subnet will be created
      + resource "aci_bridge_domain" "bd_for_subnet" {
          + annotation                  = "orchestrator:terraform"
          + arp_flood                   = (known after apply)
          + bridge_domain_type          = (known after apply)
          + description                 = "This bridge domain is created by the Terraform ACI provider"
          + ep_clear                    = (known after apply)
          + ep_move_detect_mode         = (known after apply)
          + host_based_routing          = (known after apply)
          + id                          = (known after apply)
          + intersite_bum_traffic_allow = (known after apply)
          + intersite_l2_stretch        = (known after apply)
          + ip_learning                 = (known after apply)
          + ipv6_mcast_allow            = (known after apply)
          + limit_ip_learn_to_subnets   = (known after apply)
          + ll_addr                     = (known after apply)
          + mac                         = (known after apply)
          + mcast_allow                 = (known after apply)
          + multi_dst_pkt_act           = (known after apply)
          + name                        = "bd_for_subnet"
          + name_alias                  = (known after apply)
          + optimize_wan_bandwidth      = (known after apply)
          + tenant_dn                   = "uni/tn-common"
          + unicast_route               = (known after apply)
          + unk_mac_ucast_act           = (known after apply)
          + unk_mcast_act               = (known after apply)
          + v6unk_mcast_act             = (known after apply)
          + vmac                        = (known after apply)
        }

      # aci_subnet.demosubnet will be created
      + resource "aci_subnet" "demosubnet" {
          + annotation  = "orchestrator:terraform"
          + ctrl        = (known after apply)
          + description = "This subject is created by Terraform"
          + id          = (known after apply)
          + ip          = "172.16.1.1/24"
          + name_alias  = (known after apply)
          + parent_dn   = (known after apply)
          + preferred   = (known after apply)
          + scope       = "private"
          + virtual     = (known after apply)
        }

    Plan: 5 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + application_profile_id = (known after apply)

    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>


- Notice in the output that the `resource aci_application_profile` references the tenant `common`

- Apply the configuration to the ACI fabric with your **username** as the `aci_app_name`

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-common/ap-conmurphy]
    aci_application_epg.web: Creating...
    aci_application_epg.db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 1s [id=uni/tn-common/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.db: Creation complete after 2s [id=uni/tn-common/ap-conmurphy/epg-db]
    aci_application_epg.web: Creation complete after 2s [id=uni/tn-common/ap-conmurphy/epg-web]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-common/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

    Outputs:

    application_profile_id = "uni/tn-common/ap-conmurphy"
  ```
</details>

- In a browser go to https://sandboxapicdc.cisco.com/ and login (`admin`/`ciscopsdt`)  

- Click on the `Tenant` tab and then double click to view the `common` tenant

- Expand the `Application Profiles` and verify that a profile with your username exists

- Cleanup your ACI configuration and all objects within that tenant.

`terraform destroy`

## 5. Importing existing configuratiion

- Navigate to the folder containing the next lesson

`cd hands-on-lab-terraform/lesson_05/`  

- Initialise Terraform  

`terraform init`

- Apply the configuration to setup the ACI fabric

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 1s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.db: Creating...
    aci_application_epg.web: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.web: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

    Outputs:

    application_profile_id = "uni/tn-conmurphy/ap-my_website"      
  ```
</details>

- Remove the Terraform state fiile

`mv terraform.tfstate terraform.tfstate_hidden`

- Re-run the Terraform plan to see what will happen.

`terraform plan`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # aci_application_epg.db will be created
      + resource "aci_application_epg" "db" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the database epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "db"
          + name_alias             = "db"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_epg.web will be created
      + resource "aci_application_epg" "web" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "web"
          + name_alias             = "web"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # aci_application_profile.myWebsite will be created
      + resource "aci_application_profile" "myWebsite" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "my_website"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # aci_bridge_domain.bd_for_subnet will be created
      + resource "aci_bridge_domain" "bd_for_subnet" {
          + annotation                  = "orchestrator:terraform"
          + arp_flood                   = (known after apply)
          + bridge_domain_type          = (known after apply)
          + description                 = "This bridge domain is created by the Terraform ACI provider"
          + ep_clear                    = (known after apply)
          + ep_move_detect_mode         = (known after apply)
          + host_based_routing          = (known after apply)
          + id                          = (known after apply)
          + intersite_bum_traffic_allow = (known after apply)
          + intersite_l2_stretch        = (known after apply)
          + ip_learning                 = (known after apply)
          + ipv6_mcast_allow            = (known after apply)
          + limit_ip_learn_to_subnets   = (known after apply)
          + ll_addr                     = (known after apply)
          + mac                         = (known after apply)
          + mcast_allow                 = (known after apply)
          + multi_dst_pkt_act           = (known after apply)
          + name                        = "bd_for_subnet"
          + name_alias                  = (known after apply)
          + optimize_wan_bandwidth      = (known after apply)
          + tenant_dn                   = (known after apply)
          + unicast_route               = (known after apply)
          + unk_mac_ucast_act           = (known after apply)
          + unk_mcast_act               = (known after apply)
          + v6unk_mcast_act             = (known after apply)
          + vmac                        = (known after apply)
        }

      # aci_subnet.demosubnet will be created
      + resource "aci_subnet" "demosubnet" {
          + annotation  = "orchestrator:terraform"
          + ctrl        = (known after apply)
          + description = "This subject is created by Terraform"
          + id          = (known after apply)
          + ip          = "172.16.1.1/24"
          + name_alias  = (known after apply)
          + parent_dn   = (known after apply)
          + preferred   = (known after apply)
          + scope       = "private"
          + virtual     = (known after apply)
        }

      # aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

    Plan: 6 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + application_profile_id = (known after apply)

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>

You should see the same output as what we've seen before. Since there's no longer a statefile, Terraform tries to recreate the environment. 

In a real world example we might already have our ACI fabric configured (brownfield) and we now want to start using Terraform to manage the configuration.

We can achieve this with `import`

https://www.terraform.io/docs/cli/import/index.html

Terraform import requires the format, `terraform import <address> <id>`. With ACI, the ID is the Distinguished Name of the ACI object.

- Import the existing ACI resources. **IMPORTANT NOTE: `Terraform import` requires your configuration to already exist and only imports the state.**


`terraform import aci_tenant.aci_tenant uni/tn-conmurphy`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)

    aci_tenant.aci_tenant: Importing from ID "uni/tn-conmurphy"...
    aci_tenant.aci_tenant: Import prepared!
      Prepared aci_tenant for import
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]

    Import successful!

    The resources that were imported are shown above. These resources are now in
    your Terraform state and will henceforth be managed by Terraform.


    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 9 more similar warnings elsewhere)
  ```
</details>

`terraform import aci_bridge_domain.bd_for_subnet uni/tn-conmurphy/BD-bd_for_subnet`

`terraform import aci_subnet.demosubnet "uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]"`

`terraform import aci_application_profile.myWebsite uni/tn-conmurphy/ap-my_website`

`terraform import aci_application_epg.web uni/tn-conmurphy/ap-my_website/epg-web`

`terraform import aci_application_epg.db uni/tn-conmurphy/ap-my_website/epg-db`

You should now have all the existing resourcs managed in your statefile. 

- Re-run the plan and apply to finalize the import

`terraform plan`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      ~ update in-place

    Terraform will perform the following actions:

      # aci_application_epg.db will be updated in-place
      ~ resource "aci_application_epg" "db" {
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-db"
            name                         = "db"
            # (22 unchanged attributes hidden)
        }

      # aci_application_epg.web will be updated in-place
      ~ resource "aci_application_epg" "web" {
          + fwd_ctrl                     = "none"
            id                           = "uni/tn-conmurphy/ap-my_website/epg-web"
            name                         = "web"
            # (22 unchanged attributes hidden)
        }

    Plan: 0 to add, 2 to change, 0 to destroy.

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Refreshing state... [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Refreshing state... [id=uni/tn-conmurphy/ap-my_website]
    aci_bridge_domain.bd_for_subnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_application_epg.db: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.web: Refreshing state... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_subnet.demosubnet: Refreshing state... [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]
    aci_application_epg.web: Modifying... [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.db: Modifying... [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.db: Modifications complete after 3s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.web: Modifications complete after 5s [id=uni/tn-conmurphy/ap-my_website/epg-web]

    Warning: Interpolation-only expressions are deprecated

      on aci.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 4 more similar warnings elsewhere)


    Apply complete! Resources: 0 added, 2 changed, 0 destroyed.

    Outputs:

    application_profile_id = "uni/tn-conmurphy/ap-my_website"
  ```
</details>

As you can see by the output, Terraform has successfully imported the configuration and when we re-run the plan, no new resources are created.

- Cleanup your ACI tenant and all objects within that tenant.

`terraform destroy`

## 6. Intro to Directory Structure and Modules

This lesson will give you an introduction to how you might structure your Terraform code and start building reuseable modules. Please have a look at the references below for detailed information and best practices.

**Directory Structures**

- Navigate to the folder containing the next lesson

`cd hands-on-lab-terraform/lesson_06/all_in_one/`  

- Intialise and apply the plan

`terraform init`


`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_attachable_access_entity_profile.test_ep: Creating...
    aci_lacp_policy.test_lacp: Creating...
    aci_miscabling_protocol_interface_policy.test_miscable: Creating...
    aci_leaf_interface_profile.test_leaf_profile: Creating...
    aci_leaf_profile.tf_leaf_prof: Creating...
    aci_lldp_interface_policy.test_lldp: Creating...
    aci_lacp_policy.test_lacp: Creation complete after 1s [id=uni/infra/lacplagp-conmurphy]
    aci_miscabling_protocol_interface_policy.test_miscable: Creation complete after 1s [id=uni/infra/mcpIfP-conmurphy]
    aci_leaf_interface_profile.test_leaf_profile: Creation complete after 1s [id=uni/infra/accportprof-conmurphy]
    aci_attachable_access_entity_profile.test_ep: Creation complete after 1s [id=uni/infra/attentp-conmurphy]
    aci_lldp_interface_policy.test_lldp: Creation complete after 1s [id=uni/infra/lldpIfP-conmurphy]
    aci_access_port_selector.test_selector: Creating...
    aci_tenant.aci_tenant: Creation complete after 3s [id=uni/tn-conmurphy]
    aci_leaf_profile.tf_leaf_prof: Creation complete after 3s [id=uni/infra/nprof-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_application_profile.anotherApplication: Creating...
    aci_application_profile.thirdApplication: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_access_port_selector.test_selector: Creation complete after 2s [id=uni/infra/accportprof-conmurphy/hports-conmurphy-typ-ALL]
    aci_application_profile.myWebsite: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.myWebsite-web: Creating...
    aci_application_epg.myWebsite-db: Creating...
    aci_application_profile.thirdApplication: Creation complete after 2s [id=uni/tn-conmurphy/ap-third_application]
    aci_application_profile.anotherApplication: Creation complete after 2s [id=uni/tn-conmurphy/ap-another_application]
    aci_application_epg.thirdApplication-db: Creating...
    aci_application_epg.anotherApplication-web: Creating...
    aci_application_epg.thirdApplication-web: Creating...
    aci_application_epg.anotherApplication-db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 4s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.myWebsite-db: Creation complete after 3s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.myWebsite-web: Creation complete after 3s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.thirdApplication-web: Creation complete after 3s [id=uni/tn-conmurphy/ap-third_application/epg-web]
    aci_application_epg.thirdApplication-db: Creation complete after 3s [id=uni/tn-conmurphy/ap-third_application/epg-db]
    aci_application_epg.anotherApplication-web: Creation complete after 3s [id=uni/tn-conmurphy/ap-another_application/epg-web]
    aci_application_epg.anotherApplication-db: Creation complete after 3s [id=uni/tn-conmurphy/ap-another_application/epg-db]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Warning: Interpolation-only expressions are deprecated

      on aci_tenants.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 10 more similar warnings elsewhere)


    Apply complete! Resources: 19 added, 0 changed, 0 destroyed.
  ```
</details>

- Note how many resources and what types of resources have been created (19 in the expected output). As you should see, there are a mixture of `leaf access policies` and `tenant/application policies`. 

**Important Note:** As you include more and more Terraform configuration, the time taken to refresh and apply increases. You also increase the size of the failure domain in the event that something goes wrong.

One option to address this issue is to separate your configuration into their own folders.

https://learn.hashicorp.com/tutorials/terraform/organize-configuration

- Cleanup your ACI tenant and all objects within that tenant.

`terraform destroy`

- Navigate to the next lesson

`cd hands-on-lab-terraform/lesson_06/structured/`  

- Have a look at the directory structure (in Windows Explorer, Finder, or the following commands)

`tree`

`ls -la`

`dir`

As you can see we have two sub folders, `aci_access_policies` and `aci_tenant`. In our example, we configure the ACI Access Policies less frequently than the Tenant policies (AP, EPGs etc) and so it makes sense to split this into two separate directories. 

- Navigate to the access policies

`cd hands-on-lab-terraform/lesson_06/structured/aci_access_policies/`  

- Intialise and apply the plan

`terraform init`

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_lldp_interface_policy.test_lldp: Creating...
    aci_miscabling_protocol_interface_policy.test_miscable: Creating...
    aci_lacp_policy.test_lacp: Creating...
    aci_leaf_interface_profile.test_leaf_profile: Creating...
    aci_attachable_access_entity_profile.test_ep: Creating...
    aci_leaf_profile.tf_leaf_prof: Creating...
    aci_miscabling_protocol_interface_policy.test_miscable: Creation complete after 4s [id=uni/infra/mcpIfP-conmurphy]
    aci_leaf_interface_profile.test_leaf_profile: Creation complete after 4s [id=uni/infra/accportprof-conmurphy]
    aci_lldp_interface_policy.test_lldp: Creation complete after 4s [id=uni/infra/lldpIfP-conmurphy]
    aci_lacp_policy.test_lacp: Creation complete after 4s [id=uni/infra/lacplagp-conmurphy]
    aci_attachable_access_entity_profile.test_ep: Creation complete after 4s [id=uni/infra/attentp-conmurphy]
    aci_access_port_selector.test_selector: Creating...
    aci_leaf_profile.tf_leaf_prof: Creation complete after 4s [id=uni/infra/nprof-conmurphy]
    aci_access_port_selector.test_selector: Creation complete after 0s [id=uni/infra/accportprof-conmurphy/hports-conmurphy-typ-ALL]

    Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
  ```
</details>

- Navigate to the tenant policies

`cd hands-on-lab-terraform/lesson_06/structured/aci_tenant/`  

- Intialise and apply the plan

`terraform init`

`terraform apply --auto-approve`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    aci_tenant.aci_tenant: Creating...
    aci_tenant.aci_tenant: Creation complete after 2s [id=uni/tn-conmurphy]
    aci_application_profile.myWebsite: Creating...
    aci_application_profile.anotherApplication: Creating...
    aci_application_profile.thirdApplication: Creating...
    aci_bridge_domain.bd_for_subnet: Creating...
    aci_application_profile.myWebsite: Creation complete after 0s [id=uni/tn-conmurphy/ap-my_website]
    aci_application_epg.myWebsite-db: Creating...
    aci_application_epg.myWebsite-web: Creating...
    aci_application_profile.anotherApplication: Creation complete after 0s [id=uni/tn-conmurphy/ap-another_application]
    aci_application_profile.thirdApplication: Creation complete after 0s [id=uni/tn-conmurphy/ap-third_application]
    aci_application_epg.thirdApplication-web: Creating...
    aci_application_epg.anotherApplication-web: Creating...
    aci_application_epg.thirdApplication-db: Creating...
    aci_application_epg.anotherApplication-db: Creating...
    aci_bridge_domain.bd_for_subnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet]
    aci_subnet.demosubnet: Creating...
    aci_application_epg.myWebsite-web: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-web]
    aci_application_epg.myWebsite-db: Creation complete after 2s [id=uni/tn-conmurphy/ap-my_website/epg-db]
    aci_application_epg.anotherApplication-web: Creation complete after 2s [id=uni/tn-conmurphy/ap-another_application/epg-web]
    aci_application_epg.thirdApplication-web: Creation complete after 2s [id=uni/tn-conmurphy/ap-third_application/epg-web]
    aci_application_epg.anotherApplication-db: Creation complete after 2s [id=uni/tn-conmurphy/ap-another_application/epg-db]
    aci_application_epg.thirdApplication-db: Creation complete after 2s [id=uni/tn-conmurphy/ap-third_application/epg-db]
    aci_subnet.demosubnet: Creation complete after 1s [id=uni/tn-conmurphy/BD-bd_for_subnet/subnet-[172.16.1.1/24]]

    Warning: Interpolation-only expressions are deprecated

      on aci_tenants.tf line 7, in resource "aci_bridge_domain" "bd_for_subnet":
      7:   tenant_dn   = "${aci_tenant.aci_tenant.id}"

    Terraform 0.11 and earlier required all non-constant expressions to be
    provided via interpolation syntax, but this pattern is now deprecated. To
    silence this warning, remove the "${ sequence from the start and the }"
    sequence from the end of this expression, leaving just the inner expression.

    Template interpolation syntax is still used to construct strings from
    expressions when the template includes multiple interpolation sequences or a
    mixture of literal strings and interpolations. This deprecation applies only
    to templates that consist entirely of a single interpolation sequence.

    (and 10 more similar warnings elsewhere)


    Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

    Outputs:

    application_profile_id = "uni/tn-conmurphy/ap-my_website"
  ```
</details>

- Cleanup the configuration

`terraform destroy`

- Navigate to the access policies

`cd hands-on-lab-terraform/lesson_06/structured/aci_access_policies/`  

- Cleanup the configuration

`terraform destroy`

As you can see, we have to run the Terraform commands twice, however each run is managing a smaller amount of resources. This becomes important as the configuration grows. It also means if we accidentially run the `destroy` command we have reduced the number of resources affected.

**Important Note:** There is no exact way to structure your directories however think about the following:

- What is the purpose for this configuration? 
- How often do the resources change? Does it make sense to refresh infrequently changing resources in the same plan as frequently changing resources?
- Will multiple people be managing the same configuration or do they have different areas of expertise?
- Is there a logical way to structure the configuration? e.g. using the same structure as the GUI - ACI splits up by tenant, access policies, fabric policies

**6. Into to Modules**

- Navigate to the next lesson

`cd hands-on-lab-terraform/lesson_06/intro_to_modules/`  

- Initialise Terraform and run a plan

`terraform init`

`terraform plan`

<details>
  <summary>Click to see expected output</summary>
  
  ```
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # module.application["firstApp"].aci_application_epg.aci_application_epg["app"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "app"
          + name_alias             = "app"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["firstApp"].aci_application_epg.aci_application_epg["db"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "db"
          + name_alias             = "db"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["firstApp"].aci_application_epg.aci_application_epg["web"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "web"
          + name_alias             = "web"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["firstApp"].aci_application_profile.aci_application_profile will be created
      + resource "aci_application_profile" "aci_application_profile" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "firstApp"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # module.application["firstApp"].aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

      # module.application["secondApp"].aci_application_epg.aci_application_epg["backend"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "backend"
          + name_alias             = "backend"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["secondApp"].aci_application_epg.aci_application_epg["frontend"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "frontend"
          + name_alias             = "frontend"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["secondApp"].aci_application_profile.aci_application_profile will be created
      + resource "aci_application_profile" "aci_application_profile" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "secondApp"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # module.application["secondApp"].aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

      # module.application["thirdApp"].aci_application_epg.aci_application_epg["primary"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "primary"
          + name_alias             = "primary"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["thirdApp"].aci_application_epg.aci_application_epg["secondary"] will be created
      + resource "aci_application_epg" "aci_application_epg" {
          + annotation             = "orchestrator:terraform"
          + application_profile_dn = (known after apply)
          + description            = "this is the web epg created by terraform"
          + exception_tag          = (known after apply)
          + flood_on_encap         = "enabled"
          + fwd_ctrl               = "none"
          + has_mcast_source       = "no"
          + id                     = (known after apply)
          + is_attr_based_epg      = (known after apply)
          + match_t                = "AtleastOne"
          + name                   = "secondary"
          + name_alias             = "secondary"
          + pc_enf_pref            = "unenforced"
          + pref_gr_memb           = "exclude"
          + prio                   = "unspecified"
          + shutdown               = "no"
        }

      # module.application["thirdApp"].aci_application_profile.aci_application_profile will be created
      + resource "aci_application_profile" "aci_application_profile" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "thirdApp"
          + name_alias  = (known after apply)
          + prio        = (known after apply)
          + tenant_dn   = (known after apply)
        }

      # module.application["thirdApp"].aci_tenant.aci_tenant will be created
      + resource "aci_tenant" "aci_tenant" {
          + annotation  = "orchestrator:terraform"
          + description = (known after apply)
          + id          = (known after apply)
          + name        = "conmurphy"
          + name_alias  = (known after apply)
        }

    Plan: 13 to add, 0 to change, 0 to destroy.

    ------------------------------------------------------------------------

    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
  ```
</details>

- Open the `main.tf` file in your editor and have a look at the structure. We've defined a nested map as a local value. In this example it's our application profiles and EPGs. This is specific to our example module but you could design and build modules to meet your requirements.

- Scroll down and you'll see a module to build our "application" (Application profiles and EPGs). For this module we are using the code found in the `./modules/application` folder. We then loop through each of the application profiles and use the map key for the app profile name (e.g. `firstApp`). We use the value of the `epg` key for our EPG names. Since there are multiple EPGs we create a set and pass the set to our module.

https://www.terraform.io/docs/language/functions/toset.html

- Navigate to the `application` module

`cd hands-on-lab-terraform/lesson_06/intro_to_modules/modules/application/`

- Open the `main.tf` file in your editor and have a look at how it's constructed.

The configuration looks very similar to how we previously configured the application profiles, however with a few changes. 

In our `aci_application_profile` resource we are defining the application name (this was `each.key`)

We only have a single `aci_application_epg` resource but note `for_each = var.epg`. Remember that we created a set from `each.value["epg"]` and stored this in the variable, `epg`. Since it's a set of strings we can loop through it and create a new resource for each EPG name it finds. The application profile and tenant name will remain the same which allows us to maintain the dependencies.

https://www.terraform.io/docs/language/meta-arguments/for_each.html

- Cleanup the environment

`terraform destroy`

**Important Note:** This was a basic introduction to modules and not necessarily a realistic example. Please have a look at the references to continue learning about module compilation.

## 7. Intro to Terraform Cloud

- Fork the current repo 

[SCREENSHOTS HERE]

## Optional: Other Useful Terraform Commands
Here are some further Terraform commands you might find useful when working with the CLI

- Output the deployment plan to a file called `plan.out`

`terraform plan -out plan.out`

- Limit the number of concurrent operations as Terraform walks the graph. 10 by default. 

`terraform apply --parallelism=5`

- Show the resources tracked by the state file

`terraform state list`

- Create a diagram of your Terraform resources

`terraform graph | dot -Tpng > graph.png`

- Taint a resource so that it is recreated on the next `terraform apply`

`terraform taint aci_application_epg.db`


## References

https://learn.hashicorp.com/tutorials/terraform/module

https://learn.hashicorp.com/tutorials/terraform/pattern-module-creation?in=terraform/modules

https://www.terraform.io/docs/language/functions/index.html

