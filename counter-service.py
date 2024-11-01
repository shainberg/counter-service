#!flask/bin/python
from flask import Flask, request, request_started

app = Flask(__name__)
counter = 0
@app.route('/', methods=["POST", "GET"])
def index():
    global counter
    if request.method == "POST":
        counter+=1
        return "Hmm, Plus 1 please "
    else:
        return str(f"Our counter is: {counter} ")
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
