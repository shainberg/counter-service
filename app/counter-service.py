#!flask/bin/python
import os
import redis
from flask import Flask, request, request_started

# Get env variables from configMap, if no values exist set to localhost:6379
redis_host = os.getenv('REDIS_HOST', 'localhost')
redis_port = int(os.getenv('REDIS_PORT', 6379))

# Connect to redis
r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)

# Define key name
key = 'counter'

app = Flask(__name__)

@app.route('/', methods=["POST", "GET"])
def index():

    if request.method == "POST":
        
        # Increase counter by 1 and update variable
        r.incr(key)
        counter = int(r.get(key))

        return "Hmm, Plus 1 please "
    
    else:

        # Get couter value
        counter = int(r.get(key) or 0)     #set to 0 if doesnt exist
        return str(f"Our counter is: {counter} ")
    
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
