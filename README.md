# Reusable Terraform Modules

This repository is structured as **reusable Terraform modules** you can plug into different projects.  
This README focuses strictly on the **modules** (VPC, Security Groups, Compute, RDS, Backend bucket) and how to reuse them.

## Table of Contents

- [Modules Included](#modules-included)
- [Repository Structure (Modules)](#repository-structure-modules)
- [How to Reuse These Modules in Another Project](#how-to-reuse-these-modules-in-another-project)
- [Example Root Usage (Modules Only)](#example-root-usage-modules-only)
- [What Variables You Usually Override (Across Projects)](#what-variables-you-usually-override-across-projects)
- [Outputs You’ll Typically Reuse](#outputs-youll-typically-reuse)
- [Best Practices (Real-World Use)](#best-practices-real-world-use)
- [How To Run (Modules Consumer Project)](#how-to-run-modules-consumer-project)
- [Troubleshooting (Common Module Reuse Issues)](#troubleshooting-common-module-reuse-issues)
- [Summary](#summary)

## Modules Included

### 1. `vpc-module/`
Creates the networking foundation:  
- VPC  
- Public subnets (2 AZs)  
- Private subnets (2 AZs)  
- Internet Gateway  
- Public route table + associations  

**Why reuse it:** Any app needs networking, and the module already gives you a clean 2-AZ layout.

### 2. `web_security_group-module/`
Creates the **web/app security group** (for EC2 in public subnet):  
- SSH (ideally restricted to your IP `/32`)  
- HTTP (80)  
- Optional HTTPS (443)  
- Outbound allowed  

**Why reuse it:** Any public-facing EC2/ALB setup needs this pattern.

### 3. `db_security_group-module/`
Creates the **database security group**:  
- Allows MySQL (3306) **only from the web security group**  
- Outbound allowed (or restricted depending on your preference)  

**Why reuse it:** This is the normal “app-to-db only” security posture.

### 4. `compute-module/`
Creates EC2 compute:  
- Ubuntu AMI lookup  
- EC2 instance  
- Attaches to subnet + security group(s)  
- Uses key pair name for SSH access  

**Why reuse it:** Most projects need the same EC2 wiring, only the subnet/SG changes.

### 5. `rds-module/`
Creates MySQL RDS:  
- DB subnet group (private subnets)  
- RDS instance (MySQL)  
- Supports best-practice defaults (private, encrypted, backup retention, etc.)  

**Why reuse it:** Most MySQL deployments follow the same structure, only sizing + password differ.

### 6. `bucket-module/` (Terraform backend module)
Creates S3 bucket for Terraform remote state (and optionally DynamoDB locking if you add it later).  

**Why reuse it:** Remote state is a common requirement across projects.  

> ⚠️ Note: Terraform **backend blocks cannot accept variables** directly.  
> The bucket still needs to exist first, then you configure `backend.tf` in the root project.

## Repository Structure (Modules)

```bash
Terraform-modules/
├── app-module
│   ├── compute-module/
│   ├── db_security_group-module/
│   ├── rds-module/
│   ├── vpc-module/
│   └── web_security_group-module/
└── bucket-module/
```

## How to Reuse These Modules in Another Project

### Option A: Copy modules into a new repo (simple + beginner friendly)
1. Create a new folder/project, e.g.:  
   ```bash
   mkdir my-new-project && cd my-new-project
   ```
2. Copy the modules you need:  
   ```bash
   cp -R /path/to/Terraform-modules/app-module/vpc-module ./modules/vpc
   cp -R /path/to/Terraform-modules/app-module/compute-module ./modules/compute
   cp -R /path/to/Terraform-modules/app-module/web_security_group-module ./modules/web_sg
   cp -R /path/to/Terraform-modules/app-module/db_security_group-module ./modules/db_sg
   cp -R /path/to/Terraform-modules/app-module/rds-module ./modules/rds
   ```

### Option B: Use as a “modules repo” (cleaner for teams)
Keep this repo as your modules library, then reference it via git source (example):  
```hcl
module "vpc" {
  source = "git::https://github.com/MuhdJamiu001/terraform-modules.git//app-module/vpc-module?ref=main"
  wp_zone1 = var.wp_zone1
  wp_zone2 = var.wp_zone2
}
```  
(Use tags/releases later for stability.)

## Example Root Usage (Modules Only)

This shows how modules connect together.  
```hcl
module "vpc" {
  source = "./modules/vpc"
  wp_zone1 = var.wp_zone1
  wp_zone2 = var.wp_zone2
}

module "web_security_group" {
  source = "./modules/web_sg"
  wp_vpc_id = module.vpc.wp_vpc_id
  wp_ssh_cidr = var.wp_ssh_cidr
}

module "db_security_group" {
  source = "./modules/db_sg"
  wp_vpc_id = module.vpc.wp_vpc_id
  wp_web_sg_id = module.web_security_group.wp_security_group_id
}

module "rds" {
  source = "./modules/rds"
  wp_db_subnet_ids = module.vpc.wp_private_subnet_ids
  wp_db_security_group_ids = [module.db_security_group.wp_db_security_group_id]
  # Typically overridden in tfvars in real projects
  wp_db_password = var.wp_db_password
}

module "compute" {
  source = "./modules/compute"
  subnet_id = module.vpc.wp_public_subnet_ids[0]
  security_group_ids = [module.web_security_group.wp_security_group_id]
  key_name = var.wp_key_name
}
```

## What Variables You Usually Override (Across Projects)

### Common overrides
- `wp_zone1`, `wp_zone2` → depends on region/account  
- `wp_ssh_cidr` → lock down to your IP `/32`  
- `wp_key_name` → your key pair name  
- `wp_db_password` → always set securely  

### Usually leave defaults
- Instance type if it has a sensible default  
- DB name / username if defaults are OK  
- Subnet CIDRs if this is a learning/test project  

## Outputs You’ll Typically Reuse

You don’t *have* to output everything — output only what the next module/root needs.  

**Common useful outputs:**  
- VPC module:  
  - `wp_vpc_id`  
  - `wp_public_subnet_ids`  
  - `wp_private_subnet_ids`  
- Web SG module:  
  - `wp_security_group_id`  
- DB SG module:  
  - `wp_db_security_group_id`  
- RDS module:  
  - `wp_db_address` (host)  
  - `wp_db_endpoint` (host:port)  
- Compute module:  
  - `wp_instance_public_ip`  
  - `wp_instance_public_dns`  

## Best Practices (Real-World Use)

### 1. Keep modules small and focused
These are already nicely separated:  
- Networking  
- Security  
- Compute  
- Database  
That’s exactly what you want.

### 2. Don’t over-output
Only output values that:  
- You need in root  
- You need in another module  
- You need to display to the user after apply  

### 3. Don’t hardcode dangerous defaults in production
Examples:  
- `0.0.0.0/0` for SSH is *fine for learning* but not production  
- DB deletion protection should be enabled in production  
- Remote state bucket should have `force_destroy = false` in production  

### 4. Remote state locking for teams
If multiple people will run Terraform:  
- Use **S3 backend**  
- Add **DynamoDB locking**  
This prevents 2 people applying at the same time and corrupting the state.

## How To Run (Modules Consumer Project)

From your **root project** (the one calling modules):  
```bash
terraform init
terraform validate
terraform plan
terraform apply
```

## Troubleshooting (Common Module Reuse Issues)

### “Unsupported attribute … module.X has no attribute”
You’re trying to use an output that isn’t defined.  
**Fix:**  
- Open the module’s `output.tf`  
- Add the missing output  
- Run `terraform init -reconfigure` if needed  

### “Required attribute not specified”
The module expects an input variable that root didn’t pass.  
**Fix:**  
- Check the module `variables.tf`  
- Pass it in the module block or set it in `terraform.tfvars`  

## Summary

This repo gives you **clean building blocks** for:  
- VPC (2 AZ)  
- Web SG  
- DB SG  
- EC2 instance  
- RDS MySQL  
- Optional backend bucket module  

You can reuse them by copying into a new project or referencing them via git.

## Author

Built by MuhdJamiu Agbabiaka - Reusable Terraform Modules
