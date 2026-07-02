# ☁️ AWS Infrastructure Provisioning with Terraform

---
<p align="center">

  ![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
  ![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=FF9900)
  ![VPC](https://img.shields.io/badge/Amazon_VPC-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
  ![EC2](https://img.shields.io/badge/Amazon_EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)
  ![S3](https://img.shields.io/badge/Amazon_S3-569A31?style=for-the-badge&logo=amazons3&logoColor=white)
  ![ALB](https://img.shields.io/badge/Application_Load_Balancer-FF9900?style=for-the-badge)
  ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
  ![AWS CLI](https://img.shields.io/badge/AWS_CLI-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)

</p>

---

## 📖 Overview

This project provisions a complete and scalable **AWS infrastructure** using **Terraform**.

The infrastructure is designed in line with AWS best practices, separating public and private resources and leveraging reusable, dynamic Terraform configurations.

### Infrastructure includes

- 🌐 Custom VPC
- 🌍 Public Subnets
- 🔒 Private Subnets
- 🚪 Internet Gateway (IGW)
- 🔁 NAT Gateway
- 💻 EC2 Instances in Private Subnets
- 🛡️ Bastion Host in Public Subnet
- ⚖️ Application Load Balancer (ALB)
- 🔐 Security Groups
- 📦 S3 Bucket
- 📤 Terraform Outputs

The project is completely **parameterized** with variables and makes extensive use of **`for_each`** to dynamically create multiple AWS resources.

---

## 🏗️ Architecture

<div align="center">
  <img src=Architecture.webp>
</div>

---

## 📂 Project Structure

```text
terraform/
├── alb.tf
├── data.tf
├── ec2.tf
├── locals.tf
├── outputs.tf
├── provider.tf
├── s3.tf
├── sg.tf
├── terraform.tfvars
├── userdata.sh
├── variables.tf
└── vpc.tf

Architecture.webp
LICENSE
README.md
```

---

## ✨ Features

- Modular Terraform configuration
- Dynamic resource creation using `for_each`
- Public and Private subnet architecture
- Internet Gateway & NAT Gateway configuration
- Bastion Host for secure administration
- EC2 instances deployed in private subnets
- Internet-facing Application Load Balancer
- Security Groups for controlled network access
- Configurable through `terraform.tfvars`
- User data bootstrap script for EC2

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure as Code |
| AWS VPC | Networking |
| Amazon EC2 | Compute |
| Amazon S3 | Storage |
| Application Load Balancer | Traffic Distribution |
| AWS CLI | Authentication & Deployment |

---

## 📦 Prerequisites

Install and configure the following before running the project.

### 1. [**Terraform**](https://developer.hashicorp.com/terraform/install)

Verify installation:

```bash
terraform -version
```

---

### 2. [**AWS CLI**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Verify installation:

```bash
aws --version
```

---

### 3. Configure AWS Credentials

- Run:

```bash
aws configure
```

- Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region
Default Output Format
```

- Example:

```text
AWS Access Key ID     : AKIA****************
AWS Secret Access Key : ********************
Default region        : us-east-1
Default output format : json
```

---

## ⚙️ Terraform Execution

### Initialize Terraform

```bash
terraform init
```

---

### Validate Configuration

```bash
terraform validate
```

---

### Format Terraform Files

```bash
terraform fmt
```

---

### Review Execution Plan

```bash
terraform plan
```

---

### Deploy Infrastructure

```bash
terraform apply
```

Or

```bash
terraform apply --auto-approve
```

---

### View Outputs

```bash
terraform output
```

---

### Destroy Infrastructure

```bash
terraform destroy
```

Or

```bash
terraform destroy --auto-approve
```

---

## 📄 Configuration

Infrastructure values are configured using:

```text
terraform.tfvars
```

Example:

```hcl
region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  public-a = "10.0.1.0/24"
  public-b = "10.0.2.0/24"
}

private_subnets = {
  private-a = "10.0.11.0/24"
  private-b = "10.0.12.0/24"
}
```

---

## 🔄 Dynamic Resource Creation

This project uses Terraform's **`for_each`** extensively to dynamically create resources such as:

- Public Subnets
- Private Subnets
- Route Tables
- Route Table Associations
- Security Group Rules
- EC2 Instances

This approach makes the infrastructure scalable, reusable, and easy to maintain.

---

## 🔒 Infrastructure Flow

```
Internet
     │
     ▼
Internet Gateway
     │
     ▼
Application Load Balancer
     │
     ▼
Public Subnets
     │
     ├── Bastion Host
     │
     ▼
NAT Gateway
     │
     ▼
Private Subnets
     │
     └── EC2 Instances
```

---

## 📜 License

This project is licensed under the **Apache License 2.0**.

See the **LICENSE** file for details.

---

# 👨‍💻 Author

Built using **Terraform** to automate AWS infrastructure provisioning following Infrastructure as Code (IaC) best practices.
