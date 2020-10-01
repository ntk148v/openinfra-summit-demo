#!/bin/sh

yum update -y
yum install python3-devel python3-pip -y

# Create a user to run the server process - skip this step if your image already has one.
# quietly add a user without password
adduser --quiet --disabled-password --shell /bin/bash --home /home/demo --gecos "User" demo

# set password
echo "demo:demopass" | chpasswd
# Install a tiny application
cd /home/demo
cat >app.py <<EOF
#!/usr/bin/env python
import socket
from flask import Flask

hostname = socket.gethostname()
app = Flask(__name__)

@app.route('/')
def index():
    return "Hello from {0}!" . format(hostname)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
EOF

# create virtualenv and install dependencies
python3 -m venv venv
venv/bin/pip install flask gunicorn

# make the demo user to be the owner of the application
chown -R demo:demo app.py
