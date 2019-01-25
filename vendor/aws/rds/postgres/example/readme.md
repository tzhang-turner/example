### AWS RDS Postgres

Launches a tagged Postgres DB in the corp-sandbox account's harbor subnets.

usage example

```terraform
region = "us-east-1"
profile = "corp-sandbox"

# postgres
instance_name = "asdf"
database_name = "asdf"
storage_type = "standard"
allocated_storage = "5"
engine_type = "postgres"
engine_version = "9.5.2"
instance_class = "db.t2.large"
database_user = "asdf"
database_password = "asdf"
is_multi_az = "false"

# tags
tag_name = "my db"
tag_environment = "dev"
tag_team = "cloud-arch"
tag_application = "my app"
tag_contact_email = "team email"
tag_customer = "the customer"
```
