Vagrant.configure(2) do |config|
   config.vm.define :web do |vmconfig|
    vmconfig.vm.box = "ubuntu/vivid64"
    vmconfig.vm.network "private_network", ip: "192.168.33.100"
    vmconfig.vm.network "forwarded_port", guest: 80, host: 8080
    vmconfig.vm.hostname = "web"
    vmconfig.vm.provision "puppet"
  end
  
  2.times do |i|
    config.vm.define "node#{i + 1}".to_sym do |vmconfig|
      vmconfig.vm.box = "ubuntu/vivid64"
      vmconfig.vm.hostname = "node%d" % (i + 1)
      vmconfig.vm.network "private_network", ip: "192.168.33.%d" % (101 + i)
      vmconfig.vm.provision "puppet"
    end
  end
end
