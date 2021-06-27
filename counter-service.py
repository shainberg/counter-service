#!flask/bin/python
from flask import Flask, request, request_started
import configparser


config = configparser.ConfigParser()
config.read("counter-value.ini")
counter = int(config.get("counter_val", "counter"))

app = Flask(__name__)
@app.route('/', methods=["POST", "GET"])
def index():
    global counter
    if request.method == "POST":
        counter+=1
        config.set('counter_val', 'counter', str(counter))
        return "Hmm, Plus 1 please "
    else:
        return str(f"Our counter is: {counter} ! You are great!")

if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
