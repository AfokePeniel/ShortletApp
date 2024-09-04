# ShortletApp Infrastructure

This repository contains the infrastructure as code for the ShortletApp project, using Terraform to manage Google Cloud Platform (GCP) resources.

## Overview

The infrastructure includes:
- Google Kubernetes Engine (GKE) cluster
- VPC network and subnet
- Firewall rules
- Kubernetes resources (namespace, deployment, service)

## Prerequisites

- Google Cloud Platform account
- Terraform installed locally (for manual runs)
- GitHub account (for CI/CD)

## Setup

1. Fork this repository.

2. Set up the following secrets in your GitHub repository:
   - `GCP_PROJECT_ID`: Your Google Cloud Project ID
   - `GCP_SA_KEY`: The JSON key of a service account with necessary permissions
   - `TERRAFORM_SERVICE_ACCOUNT`: The email of the Terraform service account

3. Enable the following APIs in your GCP project:
   - Compute Engine API
   - Kubernetes Engine API
   - Container Registry API
   - Cloud Resource Manager API
   - Identity and Access Management (IAM) API

## Infrastructure Components

- `main.tf`: Defines the main infrastructure components (VPC, GKE cluster, firewall rules)
- `variables.tf`: Defines input variables
- `outputs.tf`: Defines output values
- `providers.tf`: Configures the required providers
- `.github/workflows/main.yml`: Defines the CI/CD pipeline

## CI/CD Pipeline

The GitHub Actions workflow in `.github/workflows/main.yml` automates the following steps:
1. Checkout code
2. Set up Terraform
3. Initialize Terraform
4. Import existing resources (if any)
5. Plan Terraform changes
6. Apply Terraform changes

## Manual Deployment

For manual deployment:

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Plan the changes:
   ```
   terraform plan -var="project_id=YOUR_PROJECT_ID" -var="image_tag=latest" -var="terraform_service_account=YOUR_SA_EMAIL" -out=tfplan
   ```

3. Apply the changes:
   ```
   terraform apply tfplan
   ```

## Important Notes

- The infrastructure is designed to work with existing resources. If you're starting from scratch, you may need to remove the `terraform import` steps from the GitHub Actions workflow.
- Always review the plan output before applying changes, especially in production environments.
- Ensure your service account has the necessary permissions in GCP to create and manage the defined resources.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.