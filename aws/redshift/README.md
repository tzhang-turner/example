# Usage
This is a terraform for a basic redshift cluster.

```
terraform apply -var 'tag_name=redshift-terraform-test' -var 'tag_application=test' -var 'tag_team=test' -var 'tag_environment=test' -var 'tag_contact_email=john.doe@turner.com' -var 'cluster_id=redshift-terraform-test-cluster' -var 'db_name=redshift_terraform_test_db' -var 'master_username=usertest' -var 'master_password=userTest!123'
```

## ToDo's
- Add a cloud watch alert to send via SMS to the contact email when the storage size goes over 50%


## Variables that can be passed in

### Defaults that can be overridden

*region*
- defaults to us-east -1

*profile*
- defaults to default

*availability_zone*
- defaults to us-east-1a

*encrypted*
- defaults to false

*skip_final_snapshot*
- defaults to false

*number_of_nodes*
- defaults to 3

*cluster_type*
- defaults to multi-node

*node_type*
- defaults to dc1.large

### Required to be passed in

*tag_name*
```
-var 'tag_name=redshift-terraform-test' 
```

*tag_application*
```
-var 'tag_application=test' 
```

*tag_team*
```
-var 'tag_team=test' 
```

*tag_environment*
```
-var 'tag_environment=test' 
```

*tag_contact*
```
-var 'tag_contact_email=john.doe@turner.com' 
```

*cluster_id*
```
-var 'cluster_id=redshift-terraform-test-cluster' 
```

*db_name*
```
-var 'db_name=redshift_terraform_test_db' 
```

*master_username*
```
-var 'master_username=usertest' 
```

*master_password*
```
-var 'master_password=userTest!123'
```