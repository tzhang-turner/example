# Usage
This module can be called to create an ASG and ELB.
Each ec2 instance behind the ELB will have a root volume and data volume attached, both backed by EBS.

aws_data_volume_delete_on_termination - whether the data volume should be automatically deleted when the ec2 instance (VM) that it's attached to is terminated.

aws_data_volume_device_name - "/dev/sdf" is recommended by Amazon, as of this writing.  See http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html

aws_data_volume_size_in_gigabytes

aws_data_volume_type - "gp2" (general purpose 2) is recommended by Amazon, as of this writing.  See http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html

aws_instance_type - Use an ec2 instance type that has "EBS only" storage.  See https://aws.amazon.com/ec2/instance-types/ .   If you use a type with "instance storage" (also known as "ephemeral storage") then you'll find both an instance storage volume and your data volume mounted on the same mountpoint.  In particular, the c3.* generation has this problem.

mkfs - how to format your data volume.  Usually "xvdf,/mnt,-t ext4", assuming you have aws_data_volume_device_name=/dev/sdf

elb_internal_bool - whether the ELB should be only internally accessible.  Default is true.

