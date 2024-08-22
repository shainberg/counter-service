# Counter Web Server

This project is a Counter Python web server that counts the number of POST requests it has served and returns the count on every GET request. The application is containerized using Docker for ease of deployment.

## Features

- **POST Requests**: Increments a counter for each POST request received.
- **GET Requests**: Returns the current count of POST requests.
- **Documentation**: Accessible at `/docs` endpoint.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine.

## Local Run (as Container)

1. **Clone the Repository**: 
If you haven't already, clone the repository containing the Dockerfile and application code:
    ```bash
   git clone <repository-url>
   cd <repository-directory>
    ```
2. **Build the Docker Image**:
Build the Docker image using the following command:
    ```bash
    docker build -t counter-web-server .
    ```
3. **Run the Docker Container**:
Start a Docker container from the built image and expose the application's port. The application will run in detached mode:
    ```bash
    docker run -d -p 8000:8000 simple-web-server
    ```
4. **Accessing the Application**:
Open a web browser or use a tool like curl to access http://localhost:8000/docs to verify that the server is up and running.
5. **Stopping the Docker Container**:
To stop the Docker container, first find the container ID:
    ```bash
    docker ps
    ``` 
Then, stop the container using the ID:
    ```bash
    docker stop <container_id>
    ``` 
Replace <container_id> with the ID of your running container.


