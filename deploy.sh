#!/bin/sh
set -e
set -x
ssh isucon@54.168.155.12 '/home/isucon/notify.sh deploying...; cd ~/deploy && git pull && supervisorctl restart isucon_perl && /home/isucon/notify.sh deployed'
