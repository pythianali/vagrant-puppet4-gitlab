nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#  config.vm.box = "centos/7"
  
  # Enable hostmanager ('vagrant plugin install vagrant-hostmanager')
  config.hostmanager.enabled = true

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node

    config.vm.define node_name do |config|    
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest'],
          id:    port[':id']
      end

      config.vm.hostname = node_name
      
      if node_name.include? "puppet"
        config.vm.synced_folder "code", "/etc/puppetlabs/code"
      end

      config.vm.network :private_network, ip: node_values[':ip']

      config.vm.provider :virtualbox do |vb,override|
        override.vm.box = node_values[':box']
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
      end

      config.vm.provision "shell", path: "puppetprovision.sh"
      config.vm.provision "shell", inline: "service puppet restart"

    end
  end
end
