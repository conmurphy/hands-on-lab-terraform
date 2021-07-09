# 1. Getting familiar with Terraform commands and files
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

  - You will need to enter the ACI URL, username, and password  

  ```
  var.apic_password
  Enter a value: ciscopsdt

  var.apic_url
  Enter a value: https://sandboxapicdc.cisco.com 

  var.apic_username
  Enter a value: admin
  ```

  

- Push the configuration to the ACI fabric using the `apply` command
`terraform apply`  

- Verify in the ACI GUI that your 

