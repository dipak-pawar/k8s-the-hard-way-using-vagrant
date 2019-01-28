# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
cat <<EOF | sudo tee -a /etc/hosts
192.168.33.11 c1
192.168.33.12 c2
192.168.33.21 w1
192.168.33.22 w2
EOF
SCRIPT


Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
  end

  # must be at the top
  config.vm.define "lb" do |c|
      c.vm.hostname = "lb"
      c.vm.network "private_network", ip: "192.168.33.30"

      c.vm.provision :shell, :path => "scripts/setup_haproxy.sh"

      c.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
  end

  (1..2).each do |i|
    config.vm.define "c#{i}" do |node|
      node.vm.hostname = "c#{i}"
      node.vm.network "private_network", ip: "192.168.33.1#{i}"
    end
  end

  (1..2).each do |i|
    config.vm.define "w#{i}" do |node|
      node.vm.hostname = "w#{i}"
      node.vm.network "private_network", ip: "192.168.33.2#{i}"

      node.vm.provision :shell, :path => "scripts/setup_routes_for_pods.sh"
    end
  end
  
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", 
    inline: "sudo yum -y update && sudo yum -y install wget"
end
