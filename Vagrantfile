Vagrant.configure('2') do |config|
  config.vm.box = 'azure'

  config.ssh.private_key_path = '~/.ssh/id_rsa'
# config.vm.network "public_network" 
# config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.provider :azure do |azure, override|

    # each of the below values will default to use the env vars named as below if not specified explicitly
    azure.tenant_id = ENV['AZURE_TENANT_ID']
    azure.client_id = ENV['AZURE_CLIENT_ID']
    azure.client_secret = ENV['AZURE_CLIENT_SECRET']
    azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
    azure.vm_size = 'Standard_A1'
  end

    # configuration of ansible
    config.vm.provision :ansible do |ansible|
      ansible.playbook = "provision/playbook.yml"
  end

end