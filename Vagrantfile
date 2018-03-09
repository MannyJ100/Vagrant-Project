# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 3096]
  end

  config.vm.define "app" do |app|
      app.vm.box = "ubuntu/xenial64"
      app.vm.network "private_network", ip: "192.168.10.100"
      app.vm.network "forwarded_port", guest: 9200, host: 9200
      app.vm.network "forwarded_port", guest: 5601, host: 5601
      app.hostsupdater.aliases = ["dev.local"]

    #Synced app folder
      # app.vm.synced_folder "app", "/home/ubuntu/app"
      app.vm.provision "chef_solo" do |chef|
          chef.add_recipe "apt::default"
          chef.add_recipe "logstash::default"
          chef.add_recipe "elasticsearch::default"
          chef.add_recipe "kibana::default"
      end
      # app.vm.synced_folder "./environment/app/templates", "/home/ubuntu/templates"
      # app.vm.provision "shell", path: "environment/app/provision.sh"
  end
  config.vm.define "test" do |testing|
    testing.vm.box = "ubuntu/xenial64"
    testing.vm.network "private_network", ip: "192.168.10.10"
    testing.hostsupdater.aliases = ["test.local"]
  end
end
