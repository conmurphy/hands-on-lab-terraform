## 1a. Getting familiar with Terraform commands and files
- Clone the following Git repository

`git clone `  

- Navigate to the folder containing the first lesson

`cd hands-on-lab-terraform/lesson_01/single_file/`  

- Navigate to https://sandboxapicdc.cisco.com/ and login (`admin`/`ciscopsdt`)  

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

### Summary
<details>
  <summary>Click to read the lesson summary</summary>

   We successfully initialised, planned, and applied our first Terraform configuration. You then deleted the Tenant and all associated configuration.

   If you look through the `main.tf` file you will see all the configuration necessary to build your ACI Tenant, Application Profile, EPGs, and Bridge Domain.
</details>

## 1b. Config structure and variables

- Navigate to the next lesson

`cd hands-on-lab-terraform/lesson_01/multiple_files/`

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

## 1c. Variables and Dependencies

## 2. Understanding Terraform State

So far we've been configuring our ACI fabric with Terraform however how is the configuration tracked? 

This is performed through the use of a Statefile. 

<details>
   <summary>Click to read more about Terraform state</summary>

  >  Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

  > This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.

  https://www.terraform.io/docs/language/state/index.html

</details>

- Before we continue let's reduce the amount of input we need to provide by creating environmental variables for our tenant name and password

- `export TF_VAR_aci_tenant=<your username here>`

- `export TF_VAR_apic_password=ciscopsdt`

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


## Resources vs Data Source
## Importing
## More on variables
## Modules

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
