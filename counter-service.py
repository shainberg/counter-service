#!flask/bin/python
from flask import Flask, request, request_started
import os.path
from os import path

app = Flask(__name__)
counter = 0
counter_file = "counter/counter.txt"
@app.route('/', methods=["POST", "GET","DELETE"])
def index():
    global counter
    if request.method == "POST":
        counter+=1
# Store the new value
        file1 = open(counter_file, 'w')
        file1.write(str(counter))
        file1.close()
        return "Hmm, Plus 1 please "
    elif request.method == "GET":
        return str(f"Our counter is: {counter} ")
    elif request.method == "DELETE":
        counter=0
# Store the new value
        file1 = open(counter_file, 'w')
        file1.write(str(counter))
        file1.close()
        return str(f"Reset counter to 0")
if __name__ == '__main__':
# Read the old value
    if (path.exists(counter_file)):
        file1 = open(counter_file, 'r')
        Line = file1.readline()
        counter=int(Line)
        file1.close()
    else:
        file1 = open(counter_file, 'w')
        file1.write(str(counter))
        file1.close()
    app.run(debug=True,port=80,host='0.0.0.0')
