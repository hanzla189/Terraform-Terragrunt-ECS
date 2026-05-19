# Day 2 Runbook — Terraform VPC Foundation

## Client Day 2 requirement mapping

| Client requirement | Implementation |
|---|---|
| Terraform + Terragrunt repository | Root `terragrunt.hcl`, environment `terragrunt.hcl`, Terraform modules |
| 3-environment structure | `envs/dev`, `envs/staging`, `envs/prod` |
| VPC deployed to dev | Run GitHub Actions with `component=vpc`, `environment=dev`, `action=apply` |
| Public/private/database subnets across 3 AZs | VPC module creates 3 of each subnet type |
| Remote state in S3 | Bootstrap creates S3 bucket; Terragrunt config uses it |
| DynamoDB locking | Bootstrap creates `vouch-terraform-locks`; Terragrunt config uses it |
| Security Groups locked down | ALB, ECS app, RDS, Redis, and management SGs are created with scoped ingress |
| GitHub Actions runs plan on PR | Pull requests to `main` run a dev VPC plan |

## Deployment order

1. Configure GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. Configure GitHub Variables:
   - `AWS_REGION=eu-west-1`
   - `TF_STATE_BUCKET=vouch-terraform-state`
   - `TF_LOCK_TABLE=vouch-terraform-locks`

3. Run bootstrap:
   - component: `bootstrap`
   - action: `apply`

4. Run dev VPC plan:
   - component: `vpc`
   - environment: `dev`
   - action: `plan`

5. Run dev VPC apply:
   - component: `vpc`
   - environment: `dev`
   - action: `apply`

## Important S3 naming note

The requested clean name is:

```text
vouch-terraform-state
```

S3 bucket names are globally unique across AWS. If AWS rejects this bucket name because it is already taken, use an approved fallback such as:

```text
vouch-terraform-state-dev
vouch-terraform-state-client
vouch-terraform-state-<short-org-code>
```

Do not use random generated names for client delivery.

## Destruction order

Destroy VPC first:

```text
component=vpc
environment=dev
action=destroy
confirm_destroy=DESTROY
```

Then destroy bootstrap only after all environments are destroyed:

```text
component=bootstrap
action=destroy
confirm_destroy=DESTROY
```
