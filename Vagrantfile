# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"

    config.vm.provision :shell, path: "bootstrap.sh"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.define 'nodejs-box' do |node|
        node.vm.hostname = 'template.local'
        node.vm.network :private_network, ip: '192.168.42.42'
    end
end
