Argo bootstrap script to be used as `user_data` input for Terraform modules.

Example usage:

```
module "bootstrap" {
  source = "git::ssh://git@github.com/turnercode/terraform.git//argo-bootstrap?ref=v2.0.0"
  customer = "cnn"
  package_size = "2x4x32"
  products = "test-test:dev,testing:prod"
}

resource "aws_instance" "node1" {
    user_data = "${module.bootstrap.user_data}"
}
```

Required Inputs:

* conftag = emeril-assets branch name (PROD/SHARED == master)

* chassis = EC2_VIRTUAL

* location = ec2

* customer = cnn, nba, cartoonnetwork, mss, etc...

* network = prod

* package_size = cpuxmemoryxdisk (so a c3.large == 2x4x16)

* environment = dev, prod, etc...

* owner = ictops, jtolsma, jkurz 

* products = product1:environment1,product2:environment2,... (ex: mss-hello-world:dev,mss-hello-world2:qa)

Optional Inputs:

* mkfs = setup raw disks using mkfs command [argo-bootstrap-api](https://bitbucket.org/vgtf/mss-argo-bootstrap-api/overview)

* lvm = setup disks using lvm command (requires mkfs command as well) [argo-bootstrap-api](https://bitbucket.org/vgtf/mss-argo-bootstrap-api/overview)

* nameservers = change the nameservers used versus defaults from emeril

* ntpservers = change the ntpservers used versus defaults from emeril

* real_customer = cnn, nba, cartoonnetwork, mss, etc... (allows for a different group to access nodes rather than just customer, mss instead of cnn for example)
