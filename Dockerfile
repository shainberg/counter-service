# Use a slim version of Python as the base image
FROM python:3.10-slim

# Set the working directorydoc
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code
COPY counter-service.py .
RUN mkdir static
COPY CHKP.png ./static/

# Expose the port
EXPOSE 80

# Command to run the application
CMD ["python", "counter-service.py"]