# Create-resource-in-2-regions

## Description
Code that creates resource in 2 different AWS regions

## Pre-requirements


* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
* [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [AWS account and AWS Access Credentials](https://aws.amazon.com/account/)

## How to use this repo

- Clone
- Build
- Run
- Cleanup

---

### Clone the repo

```
$ git clone https://github.com/viv-garot/resource-in-2-regions
```

### Change directory

```
$ cd resource-in-2-regions
```

### Run

* Init

```
$ terraform init
```

_sample_

```

```

* Apply

```
$ terraform apply
```

_sample_

```

```

* Check the resource are created in 2 different regions

```
$ aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-central) --region=eu-central-1
$ aws ec2 describe-vpcs --filter --vpc-ids $(terraform output -raw vpc-north) --region=eu-north-1
```

_sample_

```

```

### Cleanup

```
$ terraform destroy
```


