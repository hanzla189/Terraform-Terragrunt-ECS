# Vouch Phase 1 — Day 2 Terraform VPC Foundation

This repository contains **Day 2 only** infrastructure for the Vouch Phase 1 Sprint 0 foundation.

## Scope

Included:
- Terraform + Terragrunt repository structure
- Remote Terraform state in S3
- DynamoDB state locking
- 3-environment structure: `dev`, `staging`, `prod`
- VPC foundation for each environment
- Public, private application, and database subnets across 3 AZs
- Internet Gateway
- NAT Gateway
- Route tables and associations
- S3 Gateway VPC Endpoint
- Locked-down security groups
- VPC Flow Logs to CloudWatch Logs
- GitHub Actions: PR plan, manual plan, apply, destroy

Not included yet:
- ECS / ALB target groups / listeners
- RDS instance
- Redis cluster
- SQS / Lambda
- WAF
- Secrets Manager application secrets
- Day 3+ services

## Default backend naming

Default backend bucket:

```text
vouch-terraform-state
```

Default lock table:

```text
vouch-terraform-locks
```

Important: S3 bucket names are globally unique. If `vouch-terraform-state` is already taken in AWS, override it with the GitHub Actions variable `TF_STATE_BUCKET`.

## GitHub Actions variables

```text
AWS_REGION      = eu-west-1
TF_STATE_BUCKET = vouch-terraform-state
TF_LOCK_TABLE   = vouch-terraform-locks
```

## GitHub Actions secrets

For personal testing only:

```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

For the client environment, use GitHub OIDC with an AWS IAM role instead of long-lived access keys.

## Deployment order

1. `bootstrap` + `apply`
2. `vpc` + `dev` + `plan`
3. `vpc` + `dev` + `apply`

Destroy requires the confirmation value: `DESTROY`.
