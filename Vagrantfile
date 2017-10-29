Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'

  config.berkshelf.enabled = true

  config.berkshelf.berksfile_path = './cookbooks/baseball_api/Berksfile'

  config.vm.network 'forwarded_port', guest: 80, host: 9090
  config.vm.network 'forwarded_port', guest: 9200, host: 9200
  config.vm.network 'forwarded_port', guest: 8080, host: 8080

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'baseball_api'
  end
end
