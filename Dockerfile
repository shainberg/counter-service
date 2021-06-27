FROM python:3.7-alpine

RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
ADD counter-service.py counter-value.ini /app/


EXPOSE 80
CMD ["python", "/app/counter-service.py"]