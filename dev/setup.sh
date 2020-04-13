#!/usr/bin/env bash

# install docker
sudo apt-get install docker.io

# pull docker images
sudo docker pull redis
sudo docker pull mysql
sudo docker pull mongo
sudo docker pull elasticsearch
sudo docker pull kafka
sudo docker pull grafana
sudo docker pull superset
sudo docker pull etcd

# dump data

