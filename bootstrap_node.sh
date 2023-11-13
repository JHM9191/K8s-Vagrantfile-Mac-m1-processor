#!/bin/bash

echo "[TASK 1] Join node to Kubernetes Cluster"
sudo apt install -qq -y sshpass >/dev/null 2>&1
sudo sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no master.k8s:/joincluster.sh /joincluster.sh 2>/dev/null
sudo bash /joincluster.sh >/dev/null 2>&1

sudo mkdir $HOME/.kube
sudo sshpass -p "kubeadmin" scp master:/etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

