#!/bin/bash

echo "Deploying webapp containers..."
docker pull keamysh/tomcat:latest

echo "Creating network"
docker network create acada-app

for i in {1..6}; do
    docker stop acada-webapp$i >/dev/null 2>&1
    docker rm -f acada-webapp$i >/dev/null 2>&1
    host_port=$((8080 + i)) # maps 8081, 8082, ..., 8086

    docker run -d \
        --name acada-webapp$i \
        --hostname acada-webapp$i \
        --network acada-app \
        -p $host_port:8080 \
        keamysh/acada:latest

    echo "Deploying webapp$i container on port $host_port done"
done


sleep 10

echo "Deploying HAproxy container..."
docker rm haproxy -f >/dev/null 2>&1 || true
docker run -d --name haproxy --network acada-app -v /opt/docker_config_files/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro -p 9095:80 haproxy:latest
docker ps | grep -i haproxy*
echo "Deploying HAproxy container done"
