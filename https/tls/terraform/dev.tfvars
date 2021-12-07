region           = "ap-south-1"
instance_count   = 1
dns              = "dev.first-mistake.co.in"
zone_id          = "Z03909793FNMW9NDC1F8J"
app_name         = "bridge-learn"
key_pair         = "mac"
ami_id           = "ami-052cef05d01020f1d"
instance_type    = "t2.micro"
api_port         = 5000
security_group   = ["sg-f2ec078b"]
subnets          = ["subnet-921d0ffa", "subnet-f50645b9", "subnet-150f856e"]
instance_profile = "admin-test"
tags             = { "Name" = "Bridge-Learn", "Created-By" = "Santosh", "Env" = "Dev" }
vpc_id           = "vpc-4b3bce20"
ssl_cert_arn     = "arn:aws:acm:ap-south-1:791350922346:certificate/5acddd42-0689-435f-82fb-0c89f4d8e4a8"
ec2_subnet       = "subnet-921d0ffa"