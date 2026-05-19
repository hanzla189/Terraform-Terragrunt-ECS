include "root" {
  path = find_in_parent_folders()
}

inputs = {
  project     = "vouch"
  environment = "dev"

  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]

  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24",
    "10.10.13.0/24"
  ]

  database_subnet_cidrs = [
    "10.10.21.0/24",
    "10.10.22.0/24",
    "10.10.23.0/24"
  ]
}
