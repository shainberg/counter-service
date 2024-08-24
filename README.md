
# Counter Web Server

This project provides a Python script and a FastAPI application for managing a counter stored in a Kubernetes ConfigMap. The counter can be retrieved and incremented through HTTP endpoints

## Overview

The project includes:
- `ConfigMapUpdater`: A Python class that interacts with a Kubernetes ConfigMap to read and update a JSON-encoded counter.
- A FastAPI application that provides HTTP endpoints to get and increment the counter.
- 
## Features

- **Atomic Updates**: Ensures the counter is updated atomically, handling conflicts with retries.
- **REST API**: Provides a RESTful interface for interacting with the counter.
  - **POST Requests**: Increments a counter for each POST request received.
  - **GET Requests**: Returns the current count of POST requests.
  - **Documentation**: Accessible at `/docs` endpoint.

## CI/CD Pipeline Overview
This project utilizes a comprehensive CI/CD pipeline implemented via GitHub Actions. The pipeline automates several key tasks, including environment setup, code linting, building and pushing Docker images, packaging Helm charts, and deploying the application to AWS.

### Required Environment Variables
These variables must be provided, typically as secrets or in the repository/workflow settings, because they contain sensitive information or are specific to the deployment environment:

`AWS_ACCESS_KEY_ID`: An AWS IAM access key ID required to authenticate and access AWS services. This should be stored as a secret in the GitHub repository to keep it secure.

`AWS_SECRET_ACCESS_KEY`: The corresponding secret access key for the AWS IAM user. Like AWS_ACCESS_KEY_ID, this should also be stored securely as a secret.

`AWS_REGION`: Specifies the AWS region where the resources are deployed (e.g., us-west-2). This ensures that the pipeline interacts with the correct regional AWS services.

`EKS_CLUSTER_NAME`: The name of the Amazon EKS (Elastic Kubernetes Service) cluster where the application will be deployed. This variable is crucial for configuring kubectl to interact with the correct Kubernetes cluster.


### Key Features:
* **Branch and Tag-Based Workflow**: The pipeline triggers on all branches and tags, with specific behaviors depending on the branch or tag name.
* **Environment Detection**: The determine-environment-and-tag job dynamically determines the deployment environment (dev, preprod, or prod) based on the branch or tag name and sets the appropriate Docker image tag.
* **Helm Chart Linting and Packaging**: Helm charts are linted and packaged to ensure they meet quality standards before deployment.
* **Docker Image Build and Push**: The application is built into a Docker image using Docker Buildx, with caching to speed up subsequent builds. The image is then pushed to GitHub Container Registry.
* **AWS Deployment Configuration**: The pipeline uses environment variables for AWS credentials (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION) and for the EKS cluster name (EKS_CLUSTER_NAME). These variables are used to authenticate with AWS and deploy the application to an Amazon EKS cluster.
* **Deployment to AWS**: The application is deployed to the specified Amazon EKS cluster using Helm, with environment-specific configurations.

This setup ensures that the application is consistently built, tested, and deployed with minimal manual intervention, providing a robust mechanism for continuous delivery. The integration with AWS allows for seamless deployment and management of cloud resources.

## Feature Tasks
1. **Replace ConfigMap with a Database using a Repository Pattern**:

    Implement a repository pattern to abstract data access, allowing for easy replacement of ConfigMap with a database like Redis or MongoDB.
2. **Implement Logging**:

    Replace print statements with the Python logging module for better log management and monitoring.
3. **Integrate Pydantic Models**:

    Use Pydantic to validate and structure API responses, ensuring consistency and type safety across endpoints.
