# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 3000, 3000

  # Puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "config/puppet/manifests"
    puppet.manifest_file = "vagrant.pp"
    puppet.module_path = "config/puppet/modules"
    puppet.options = ["--templatedir","/vagrant/config/puppet/templates"]
  end

end
