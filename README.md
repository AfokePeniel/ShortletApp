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

## Cleanup

To avoid unnecessary charges, remember to destroy the resources when you're done:

1. Run Terraform destroy:
   ```
   cd terraform
   terraform destroy -var="project_id=YOUR_PROJECT_ID" 
   ```

2. Delete the Docker image from Google Container Registry if needed.