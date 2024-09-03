# Time API on GKE

This project deploys a simple Time API to Google Kubernetes Engine (GKE) using Terraform and GitHub Actions.

## Prerequisites

- Google Cloud Platform account
- Terraform installed locally
- Docker installed locally
- `gcloud` CLI installed and configured

## Local Setup and Testing

1. Clone the repository:
   ```
   git clone https://github.com/your-username/time-api-gke.git
   cd time-api-gke
   ```

2. Build the Docker image locally:
   ```
   docker build -t time-api:local api/
   ```

3. Run the Docker container locally:
   ```
   docker run -p 8080:8080 time-api:local
   ```

4. Test the API locally:
   ```
   curl http://localhost:8080
   ```

   You should receive a JSON response with the current time.

## Deployment

1. Fork this repository to your GitHub account.

2. Set up the following secrets in your GitHub repository:
   - `GCP_PROJECT_ID`: Your Google Cloud Platform project ID
   - `GCP_SA_KEY`: The JSON key of a service account with necessary permissions


3. Push changes to the `main` branch to trigger the GitHub Actions workflow.

4. The workflow will:
   - Build and push the Docker image to Google Container Registry
   - Apply the Terraform configuration to set up the infrastructure
   - Deploy the API to the GKE cluster
   - Test the API accessibility

5. After successful deployment, you can access the API using the external IP of the LoadBalancer service:
   ```
   kubectl get service time-api-service -n time-api
   ```

   Use the EXTERNAL-IP to access the API:
   ```
   curl http://<EXTERNAL-IP>
   ```

## Infrastructure

The following GCP resources are created and managed by Terraform:

- VPC and Subnet
- NAT Gateway
- GKE Cluster
- IAM Roles and Policies
- Firewall Rules
- Kubernetes Resources (Namespace, Deployment, Service, Ingress)

All infrastructure is defined in the `terraform` directory and is applied as part of the CI/CD pipeline.

## Security

- A NAT gateway is used to manage outbound traffic from the GKE cluster.
- Firewall rules are implemented to secure the infrastructure.
- IAM roles are restricted to the principle of least privilege.
- Terraform Policy as Code (PaC) is implemented to enforce security policies.

## CI/CD Pipeline

The GitHub Actions workflow (.github/workflows/ci-cd.yaml) performs the following steps:

1. Runs Terraform to provision all required infrastructure
2. Builds the Docker image for the API
3. Deploys the API to the GKE cluster using Terraform
4. Verifies the API accessibility

## Cleanup

To avoid unnecessary charges, remember to destroy the resources when you're done:

1. Run Terraform destroy:
   ```
   cd terraform
   terraform destroy -var="project_id=YOUR_PROJECT_ID" 
   ```

2. Delete the Docker image from Google Container Registry if needed.