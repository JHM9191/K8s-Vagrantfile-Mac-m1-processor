#!/bin/bash

echo "[TASK 1] Pull required containers"
sudo kubeadm config images pull >/dev/null 2>&1

echo "[TASK 2] Initialize Kubernetes Cluster"
#kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null
sudo kubeadm init --apiserver-advertise-address=192.168.0.10 --pod-network-cidr=10.244.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 3] Deploy Calico network"
sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.16/manifests/calico.yaml >/dev/null 2>&1

kubectl --kubeconfig=/etc/kubernetes/admin.conf set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=skip-interface=cni*

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
sudo kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null

sudo mkdir $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

source <(kubeadm completion bash)
echo "source <(kubeadm completion bash)" >> ~/.bashrc
