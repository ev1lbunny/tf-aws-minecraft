aws_credentials_profile = "profile_name"
ingress_access_cidr     = "127.0.0.1/32"
instance_types_array = [
  {
    instance_type     = "t2.small",
    weighted_capacity = 1,
  },
  {
    instance_type     = "t3.small",
    weighted_capacity = 1,
  },

]
subnet_ids = [
  "subnet-1234125142",
  "subnet-123416541342",
  "subnet-123514325215"
]
