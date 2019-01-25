#! /bin/bash
apt-get update
apt-get -y upgrade
apt-get install build-essential -y
apt-get install python libssl-dev -y
apt-get install git
echo America/New_York | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
ulimit -c ulimited
ulimit -c
wget -qO- https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install --yes nodejs
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install --yes docker-engine
EOF
