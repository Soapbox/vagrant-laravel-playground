# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "hashicorp/precise64"
	config.vm.box_url = "https://vagrantcloud.com/hashicorp/precise64/version/2/provider/virtualbox.box"
	config.vm.network "private_network", ip: "192.168.50.5"
	config.vm.provision :shell, :path => "bootstrap.sh"
	config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777","fmode=666"]
end
