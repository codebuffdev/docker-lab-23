#!/bin/bash
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install docker-ce
sudo usermod -aG docker $USER

echo "docker is set-up & running"

# Create a Docker voluem 
docker volume create portainer_data

# Create a Docker network bridge for isolation
docker network create portainer-net

# Start Portainer container within the Codespace
docker run -d -p 8000:8000 -p 9443:9443 \
    --name portainer --network portainer-net --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest