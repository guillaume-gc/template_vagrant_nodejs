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
Variables can be change for your needs. 

Warning: changing project or top domain names will change the project URL.

## public/app.js

Template Node JS web application. Make sure the domain name is the same as the one used by the project.

## Vagrantfile

Vagrant box configuration file. Make sure to remove unused plugins, and the demain name and IP should be the same as the ones used by the project. 

# Detailed guide
## Vagrant

Install the [lastest version of Vagrant](https://www.vagrantup.com/downloads.html).

Be sure to install a VM supervisor such as VirtualBox. 

### Required Plugins

After Vagrant is installed, open a command prompt and type the following commands, this will install the required plugins for Vagrant.

```
vagrant plugin install vagrant-hostmanager
```

### Start VM 

Move to the project root directory from a command prompt.

Type the following command:
```
vagrant up
```

A virtual machine which host the web application will be created. Vagrant will ask for admin rights. Those are required to modify the local host file.

The VM can be removed with the following command:
```
vagrant destroy
```

The VM can be stop with the following command:
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

