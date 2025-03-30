# 🌐 Terraform S3 Static Portfolio Site

This project deploys a static portfolio website (based on the DevFolio template) to **AWS S3** using **Terraform**. It automates the creation of the infrastructure, enables public access, uploads the site files, and serves the site via S3 static hosting.

---

## 🚀 Features

- ✅ Fully automated deployment to AWS S3  
- ✅ Unique bucket name generation  
- ✅ Public access enabled via S3 bucket policy  
- ✅ Website hosting enabled with index & error pages  
- ✅ Recursive upload of all static files  
- ✅ MIME type detection for each file  
- ✅ Clean and modular Terraform code  

---

## 🛠 Requirements

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions
- An AWS account

---

## ⚙️ Usage

### 1. Clone the Repository

```bash
git clone https://github.com/neamulkabiremon/terraform-s3-portfolio-site.git
cd terraform-s3-portfolio-site
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Apply Configuration

```bash
terraform apply
```
Type yes when prompted.

### 🌍 Output
After successful deployment, Terraform will output your S3 static website URL. Open it in your browser to view your live portfolio.

### 🧹 Destroy Infrastructure
To clean up and delete all resources:

```bash
terraform destroy
```

### 🧠 Technologies Used
- Terraform
- AWS S3
- DevFolio HTML Template






   

