# 1. Vagrantfile-Mac-m1-processor
Working vagrant file for provisioning Kubernetes environment in Mac m1 chip baremetal

<br>

# 2. Kubernetes spec

- control plane
  - node count: 1
  - name: master
  - ip: 192.168.0.10
- worker node
  - node count: 2
  - names: node1, node2
  - ip: 192.168.0.11(node1), 192.168.0.12(node2)

<br>
<br>

# 3. Hands-on

## 3.1. Pre-requisite

1. Install Rosetta

```bash
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```


<br>

2. Install vagrant

```bash
brew install vagrant
vagrant -v
vagrant global-status
```

<br>

3. Install hypervisor

```bash
brew install --cask vmware-fusion
ln -s /Applications/VMWare\ Fusion\ Tech\ Preview.app /Applications/VMWare\ Fusion.app
```

<br>

4. Install vagrant vmware utility

```bash
brew install vagrant-vmware-utility
sudo /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility api -debug
sudo lsof -i -P | grep LISTEN | grep 'vagrant-v'
sudo launchctl unload -w /Library/LaunchDaemons/com.vagrant.vagrant-vmware-utility.plist
sudo launchctl load -w /Library/LaunchDaemons/com.vagrant.vagrant-vmware-utility.plist
sudo launchctl list | grep vagrant
```

<br>

5. Install vagrant vmware plugin
```bash
vagrant plugin install vagrant-vmware-desktop
```

<br>
<br>

## 3.2. Provision your Kubernetes environment

***Folder Structure***
<br>
. <br>
├── Vagrantfile <br> 
├── bootstrap.sh <br>
├── bootstrap_master.sh <br>
└── bootstrap_node.sh <br>
<br>
***Type below command to provision k8s.***
<br>
```bash
vagrant up --provider vmware_desktop
```



<br>
