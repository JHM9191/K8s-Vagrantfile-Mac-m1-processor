# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "master.k8s" do |node|
  
    node.vm.box = "spox/ubuntu-arm"
    node.vm.box_version = "1.0.0"
    node.vm.box_check_update = false
    node.vm.hostname = "master.k8s"
    node.vm.network :private_network, ip: "192.168.0.10"
  
    node.vm.provider :vmware_desktop do |v|
      v.memory = 2048
      v.cpus = 2
      v.vmx["ethernet0.virtualdev"] = "vmxnet3"
      v.allowlist_verified = true
      v.ssh_info_public = true
      v.linked_clone = false
      v.gui = true
    end

    node.vm.provision "shell", path: "bootstrap_master.sh"
  
  end


  # Kubernetes Worker Nodes
  NodeCount = 2

  (1..NodeCount).each do |i|

    config.vm.define "node#{i}.k8s" do |node|

      node.vm.box = "spox/ubuntu-arm"
      node.vm.box_version = "1.0.0"
      node.vm.box_check_update = false
      node.vm.hostname = "node#{i}.k8s"
      node.vm.network :private_network, ip: "192.168.0.1#{i}"

      node.vm.provider :vmware_desktop do |v|
        v.memory = 2048
        v.cpus = 2
        v.vmx["ethernet0.virtualdev"] = "vmxnet3"
        v.allowlist_verified = true
        v.ssh_info_public = true
        v.linked_clone = false
        v.gui = true
      end

      node.vm.provision "shell", path: "bootstrap_node.sh"

    end

  end

end
