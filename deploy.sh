#!/bin/sh
set -ex

ssh isucon@$IPADDR "cd ~/deploy && git pull && carton install --deployment && supervisorctl restart isucon_perl"
