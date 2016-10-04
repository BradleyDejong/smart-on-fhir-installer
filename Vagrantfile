Vagrant.configure(2) do |config|
  config.vm.box = "ericmann/trusty64"

  config.vm.hostname = "smart-on-fhir"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provider "hyperv" do |hv|
    hv.memory = 1024
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.network :forwarded_port, guest: 9080, host: 9080
  config.vm.network :forwarded_port, guest: 9085, host: 9085
  config.vm.network :forwarded_port, guest: 9090, host: 9090
  config.vm.network :forwarded_port, guest: 9095, host: 9095
  config.vm.network :forwarded_port, guest: 389, host: 1389
#  config.vm.network :forwarded_port, guest: 9999, host: 9999
  config.vm.network "private_network", ip: "192.168.50.4"
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y vim
    sudo apt-get install -y git
    sudo apt-get install -y curl python-pycurl python-pip python-yaml python-paramiko python-jinja2
    sudo pip install ansible==1.8.2
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    set -e
    # setting up dotfiles
    ln -s /vagrant/vim/vimrc ~/.vimrc
    (cd /vagrant/vim && ./setup-vim.sh)
    ln -s /vagrant/git/gitconfig ~/.gitconfig
    echo "Finished with dotfiles setup"
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    (cd /vagrant/tmux && ./setup-tmux.sh)
    ln -s /vagrant/tmux/tmux.conf ~/.tmux.conf
    echo "export TERM=xterm-256color" >> ~/.bashrc
    echo "Finished tmux setup"
  SHELL

  #config.vm.provision "shell", privileged: false, inline: <<-SHELL
    #cp -r /vagrant/provisioning ~/provisioning
    #(cd ~/provisioning && sudo ansible-playbook -c local -i 'localhost,' -vvvv smart-on-fhir-servers.yml)
    #echo "Set up smart-on-fhir servers"
  #SHELL

end

