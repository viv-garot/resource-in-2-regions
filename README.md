# Create-resource-in-2-regions

## Description
Code that creates resource (aws_pvc) in 2 different regions

## Pre-requirements


* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
* [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [AWS account and AWS Access Credentials](https://aws.amazon.com/account/)

## How to use this repo

- Clone
- Run
- Cleanup

---

### Clone the repo

```
git clone https://github.com/viv-garot/resource-in-2-regions
```

### Change directory

```
cd resource-in-2-regions
```

### Run

* Init:

```
terraform init
```

_sample_:

```
terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.52.0...
- Installed hashicorp/aws v3.52.0 (self-signed, key ID 34365D9472D7468F)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

* Apply:

```
terraform apply
```

_sample_:

```
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.vpc-central will be created
  + resource "aws_vpc" "vpc-central" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.1.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags_all                         = (known after apply)
    }

  # aws_vpc.vpc-north will be created
  + resource "aws_vpc" "vpc-north" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.1.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags_all                         = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vpc-central = (known after apply)
  + vpc-north   = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.vpc-central: Creating...
aws_vpc.vpc-north: Creating...
aws_vpc.vpc-central: Still creating... [10s elapsed]
aws_vpc.vpc-central: Creation complete after 12s [id=vpc-07568f9797fc7ca64]
aws_vpc.vpc-north: Still creating... [10s elapsed]
aws_vpc.vpc-north: Still creating... [20s elapsed]
aws_vpc.vpc-north: Creation complete after 26s [id=vpc-0c7c7678bd454b639]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vpc-central = "vpc-07568f9797fc7ca64"
vpc-north = "vpc-0c7c7678bd454b639"
```

* Confirm the vpcs have been created in 2 different regions:

```
aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-central) --region=eu-central-1
aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-north) --region=eu-north-1
```

_sample_:

```
aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-central) --region=eu-central-1
{
    "Vpcs": [
        {
            "CidrBlock": "10.1.0.0/16",
            "DhcpOptionsId": "dopt-e090308a",
            "State": "available",
            "VpcId": "vpc-07568f9797fc7ca64",
            "OwnerId": "267023797923",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-001db1639edbf2078",
                    "CidrBlock": "10.1.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": false
        }
    ]
}

aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-north) --region=eu-north-1
{
    "Vpcs": [
        {
            "CidrBlock": "10.1.0.0/16",
            "DhcpOptionsId": "dopt-c560cdac",
            "State": "available",
            "VpcId": "vpc-0c7c7678bd454b639",
            "OwnerId": "267023797923",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-08ef457843f168383",
                    "CidrBlock": "10.1.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": false
        }
    ]
}
```

### Cleanup

```
terraform destroy
```

_sample_:

```
terraform destroy

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.vpc-central will be destroyed
  - resource "aws_vpc" "vpc-central" {
      - arn                              = "arn:aws:ec2:eu-central-1:267023797923:vpc/vpc-07568f9797fc7ca64" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.1.0.0/16" -> null
      - default_network_acl_id           = "acl-00ee5ffdaa29a58b3" -> null
      - default_route_table_id           = "rtb-0cde6922a8a2c331a" -> null
      - default_security_group_id        = "sg-031b3bf2a30f95875" -> null
      - dhcp_options_id                  = "dopt-e090308a" -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-07568f9797fc7ca64" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-0cde6922a8a2c331a" -> null
      - owner_id                         = "267023797923" -> null
      - tags_all                         = {} -> null
    }

  # aws_vpc.vpc-north will be destroyed
  - resource "aws_vpc" "vpc-north" {
      - arn                              = "arn:aws:ec2:eu-north-1:267023797923:vpc/vpc-0c7c7678bd454b639" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.1.0.0/16" -> null
      - default_network_acl_id           = "acl-0b6a98204dff927d5" -> null
      - default_route_table_id           = "rtb-079509709f7a98a77" -> null
      - default_security_group_id        = "sg-012e76bcd7f79560e" -> null
      - dhcp_options_id                  = "dopt-c560cdac" -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-0c7c7678bd454b639" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-079509709f7a98a77" -> null
      - owner_id                         = "267023797923" -> null
      - tags_all                         = {} -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  - vpc-central = "vpc-07568f9797fc7ca64" -> null
  - vpc-north   = "vpc-0c7c7678bd454b639" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_vpc.vpc-central: Destroying... [id=vpc-07568f9797fc7ca64]
aws_vpc.vpc-north: Destroying... [id=vpc-0c7c7678bd454b639]
aws_vpc.vpc-central: Destruction complete after 0s
aws_vpc.vpc-north: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
```

