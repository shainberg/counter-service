# Use python image for amd64
FROM --platform=linux/amd64 python:3.12.5-slim

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# Set the working dir
WORKDIR /app

# Copy requirements file
COPY ./app/requirements.txt /app/requirements.txt

# Install all modules required
RUN pip install --no-cache-dir -r requirements.txt

# Copy app contents to container
COPY ./app /app

# expose app port
EXPOSE 80

# Define environment variable
ENV FLASK_APP=counter-service.py

# Run the application
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]
