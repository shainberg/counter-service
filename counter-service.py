#!flask/bin/python
from flask import Flask, request, request_started, render_template_string

app = Flask(__name__)
counter = 0
@app.route('/', methods=["POST", "GET"])
def index():
    global counter
    if request.method == "POST":
        counter+=1
        return "Hmm, Plus 1 please "
    else:
        return render_template_string(f"<h1>Welcome to the Counter Service</h1><img src='/static/CHKP.png' alt='Logo'><p>Our counter is: {counter}</p>")
if __name__ == '__main__':
    app.run(debug=True,port=80,host='0.0.0.0')
