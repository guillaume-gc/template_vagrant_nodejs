# template_vagrant_nodejs
Template project with vagrant and nodeJS.

# How to use

- Clone the directory.
- Install Vagrant, if necessary. See detailed guide for more information.
- Install project Vagrant recommanded plugins, if necessary. See detaield guide for more information.
- (optional) Modify files for your needs. See important files for more information.
- Start vagrant.

The project should use the following URL by default:
```
http://nodejs.local
```
or the following IP:
```
http://192.168.42.42
```

# Important files

## bootstrap.sh

Bash script used by Vagrant to modify the VM.
Variables can be changed for your needs. 

Warning: changing project or top domain names will modify project URL.

## public/app.js

Template Node JS web application. Make sure the domain name is the same as the one used by the project.

## Vagrantfile

Vagrant box configuration file. Make sure to remove unused plugins. Demain name and IP should be the same as the ones used by the project. 

# Detailed guide
## Vagrant

Install the [lastest version of Vagrant](https://www.vagrantup.com/downloads.html).

Be sure to install a VM supervisor such as VirtualBox. 

### Recommanded Plugins

If any of those plugins are not used, make sure to modify the Vagrantfile accordically. All commands below should be used in the project root directory.

#### vagrant-host manager

Automatically modify host files. See its [GitHub page](https://github.com/devopsgroup-io/vagrant-hostmanager) for more info.

```
vagrant plugin install vagrant-hostmanager
```

### Start VM 

All commands below should be used in the project root directory.

To start vagrant:
```
vagrant up
```

A virtual machine hosting the web application will be created. Vagrant will ask for admin rights, in order to modify the local host file.

The vagrant box (VM) can be deleted with the following command:
```
vagrant destroy
```

The vagrfant box can be stopped with the following command:
```
vagrant halt
```

For any other information related to Vagrant, please look at its [documentation](https://www.vagrantup.com/docs/index.html).

# Toubleshooting

## `This site can’t be reached` (chrome), `Hmm. We’re having trouble finding that site.` (firefox) and equivalent
Make sure your local host file has the right IP and the right domain name, and they're not commented. It seems vagrant-hostmanager sometime does not modify this file correctly.

## `connection refused` and requivalent
Make sure nginx is running correctly, and the server blocks are okay. Use `sudo ngnix -t` to check configuration files.

## `502 bad gateway`
Make sure the Node JS server is running correctly.
