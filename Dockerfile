FROM python:3-slim

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY counter-service/counter-service.py counter-service.py 

CMD [ "python", "./counter-service.py" ]
