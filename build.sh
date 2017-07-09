#!/bin/bash
set -ex
docker build -t mark-base ./mark-base
sleep 1
docker build -t mark-ruby ./mark-ruby
sleep 1
docker build -t mark-rails ./mark-rails
sleep 1
cp -R ./myapp_template/* ./myapp
