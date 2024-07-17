FROM python:3.10-alpine

WORKDIR /counter-service

COPY ["./counter-service.py", "./requirements.txt", "./"] 

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "counter-service.py"]