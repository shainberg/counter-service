#!flask/bin/python
import os
import redis
from flask import Flask, request, render_template

# Get env variables from configMap, if no values exist set to localhost:6379
redis_host = os.getenv('REDIS_HOST', 'localhost')
redis_port = int(os.getenv('REDIS_PORT', 6379))

# Connect to redis
r = redis.Redis(host=redis_host, port=redis_port, decode_responses=True)

# Test connection and crash if not connected
r.ping()

# Define key name for redis
key = 'counter'

app = Flask(__name__)

@app.route('/', methods=["POST", "GET"])
def index():

    if request.method == "POST":
        
        # Increase value of key in redis
        r.incr(key)
        # update counter variable with value from redis
        counter = int(r.get(key))

        return render_template('post_response.html')
    
    else:

        # Get couter value
        counter = int(r.get(key) or 0)     #set to 0 if doesnt exist
        
        return render_template('index.html', counter=counter)
    
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
