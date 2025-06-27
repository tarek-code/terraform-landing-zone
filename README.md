# AWS Landing Zone POC using Terraform (Free Tier)

## 🌎 Introduction

This project demonstrates **Infrastructure as Code (IaC)** using **Terraform** to provision an AWS Landing Zone for a startup environment. It automates:

* Core networking (VPC, Subnets, Internet Gateway)
* Compute resources (EC2 Instances)
* Logging (CloudWatch & S3) in Production

It uses **CI/CD via GitHub Actions**, and separates environments using Git branches.

---

## 🏢 Project Structure

```bash
terraform-landing-zone/
├── .github/
│   └── workflows/
│       └── terraform.yml      # GitHub Actions pipeline
├── bootstrap/                 # Backend setup (S3 & DynamoDB)
├── envs/
│   ├── pre-prod/              # Pre-prod env config
│   │   ├── main.tf
│   │   ├── backend.tf
│   │   ├── terraform.tfvars
│   └── prod/                  # Production env config
│       ├── main.tf
│       ├── backend.tf
│       ├── terraform.tfvars
├── modules/
│   ├── network/               # VPC, Subnet, IGW
│   ├── compute/               # EC2
│   └── logging/               # S3 & CloudWatch (prod only)
├── README.md
```

---

## ⚖️ Terraform Workflow

### Commands

```bash
# In each environment (e.g., envs/pre-prod/)
terraform init          # Initialize backend and providers
terraform plan          # Review changes
terraform apply         # Apply changes
terraform destroy       # Tear down infrastructure
```

### Common Flags

* `-var-file="terraform.tfvars"`: Use env-specific variables
* `-auto-approve`: Skip confirmation for `apply`/`destroy`

---

## 📓 Environments & Branching

* `pre-prod` branch ✊:

  * On push: deploy to `envs/pre-prod/`
* `prod` branch (main) ⚡:

  * On merge: deploy to `envs/prod/`

Each environment has:

* Its own S3 bucket and DynamoDB table for state
* Separate resource counts
* Logging only enabled in `prod`

---

## 📊 Architecture Diagram

```
GitHub (Push/Merge)
     |
     v
GitHub Actions Workflow
     |
     +--> terraform init/plan/apply
            |
            +---> AWS
                    |
                    +--> VPC, Subnet, EC2
                    +--> (prod only) CloudWatch & S3 Logs
```

---

## 🔧 Terraform Fundamentals Used

* **Remote state management**: S3 + DynamoDB
* **Variables & tfvars**: for env-specific inputs
* **Modules**: reusable infrastructure
* **Resource naming**: consistent tagging via `poc-<env>-<resource>`
* **CI/CD**: automate IaC pipeline with GitHub Actions

---

## 🚀 Running the Project

```bash
# Bootstrap step
cd bootstrap
terraform init
terraform apply -var="bucket_name=..." -var="dynamodb_table_name=..."

# Pre-prod
cd ../envs/pre-prod
terraform init -reconfigure
terraform apply -var-file="terraform.tfvars"

# Prod
cd ../prod
terraform init -reconfigure
terraform apply -var-file="terraform.tfvars"
```

---

## 🌟 Notes

* Only Free Tier resources are used.
* Make sure S3 bucket and DynamoDB table are created before `init`.
* Logging module is used in **prod only**.

---

## 🚊 Submission

* Submit GitHub repo link to: **[ashref.mohsen@fawry.com](mailto:ashref.mohsen@fawry.com)**
* Ensure CI/CD applies Terraform correctly for both branches

---

Good luck ✨ & happy Terraforming ⚒️
