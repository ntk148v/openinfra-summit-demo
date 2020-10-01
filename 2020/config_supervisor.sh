#!/bin/sh

# configure supervisor to run a private gunicorn web server, and
# to autostart it on boot and when it crashes
# stdout and stderr logs from the server will go to /var/log/demo
mkdir /var/log/demo
cat >/etc/supervisor/conf.d/demo.conf <<EOF
[program:demo]
command=/home/demo/venv/bin/gunicorn -b 127.0.0.1:8000 -w 4 --chdir /home/demo --log-file - app:app
user=demo
autostart=true
autorestart=true
stderr_logfile=/var/log/demo/stderr.log
stdout_logfile=/var/log/demo/stdout.log
EOF
supervisorctl reread
supervisorctl update
systemctl restart supervisor
systemctl enable supervisor
