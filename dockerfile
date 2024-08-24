ARG PYTHON_VERSION=3.11
ARG BASE_IMAGE=python:$PYTHON_VERSION-slim

FROM $BASE_IMAGE as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM $BASE_IMAGE as app


ENV PATH=/root/.local/bin:$PATH

WORKDIR /app

COPY --from=builder /root/.local /root/.local

# Copy the application code
COPY src/ ./src/

CMD ["python", "./src/counter-service.py"]
EXPOSE 8000