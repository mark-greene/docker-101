#!/bin/bash
function clean {
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
    docker volume rm $(docker volume ls --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

docker ps
echo
docker images
echo
docker-compose down
echo
echo Cleaning
clean
echo
echo Removing images
docker rmi -f myapp
docker rmi -f mark-phoenix
docker rmi -f mark-phoenix-db
docker rmi -f mark-rails
docker rmi -f mark-ruby
docker rmi -f mark-postgres
docker rmi -f mark-base
echo
echo Cleaning
clean
echo
echo Removing myapp
rm -rf ./myapp/*
touch ./myapp/.keep
