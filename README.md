# Counter Service

## Overview

- This project is a simple Python nano service that counts the number of POST requests it receives and returns the count on each GET request. 
- It has been implemented as a Dockerized application deployed on Kubernetes, leveraging a ReplicaSet to ensure high availability.

## Features

- **Counter Functionality**: Increments a counter for every POST request and returns the current count for every GET request.
- **High Availability**: Deployed using a Kubernetes ReplicaSet to ensure that multiple instances of the service are running, providing resilience and load distribution.
- **Containerization**: The application is packaged as a Docker container, ensuring a consistent environment from development to production.
- **CI/CD Pipeline**: Integrated CI/CD pipeline for automated building and deployment upon changes to the codebase.

## Architecture

- The service is built using Flask and runs in a Docker container.
- AWS EKS Kubernetes is used for orchestration, with the deployment configured for automatic scaling and rollout updates.

## Setup Instructions

### Prerequisites

- Kubernetes cluster (minimally deployed via Terraform)
- The Runner of CI/CD will build and push to the Docker registry for image storage
- The Runner of CI/CD will deploy the Image in Main branch to EKS


### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<your-github-username>/counter-service.git
   cd counter-service
2. **Configure AWS Credentials:**
   - Ensure that your AWS credentials are configured. You can do this by creating a file at `~/.aws/credentials` with the following format:
   ```bash
   [default]
   aws_access_key_id = YOUR_ACCESS_KEY
   aws_secret_access_key = YOUR_SECRET_KEY
4. **Initialize the Terraform:**
   - Make sure your `versions.tf` file specifies the required provider and Terraform versions
   - aws module version: `5.62.0`
   - terraform client version: `1.3`
    ```bash
    cd terraform
    terraform init
    terraform apply
5. **Deploy the Kubernetes components:**
  - Navigate to the directory containing your Kubernetes manifests (`deployment` folder):
    ```bash
    kubectl apply -f deployment/
  - Verify the deployment
    ```bash
    kubectl get pods
    kubectl get svc
    kubectl get ingress
  - make sure the Ingress is providing you the DNS (of aws lb) as well, it might take many second at first time
  
  * Endpoints *
  - POST /: Increments the counter
  - GET /: Returns the current counter value.
    
### CI/CD Pipeline
- The CI pipeline is configured to trigger on every push to the main and dev branch, which builds the Docker image and pushes it to the Docker registry.
- The CD pipeline ensures that any new changes are automatically deployed to the production namespace in EKS Kubernetes.

## Future Improvements
- Implement Redis for better state management and performance.
- Introduce more advanced error handling and monitoring.
