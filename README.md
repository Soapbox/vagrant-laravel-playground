# Vagrant/Laravel Playground
===============================================================================

[Vagrant](http://www.vagrantup.com/) is a way to quickly set up a virtualized development environment. This repo showcases how Vagrant can be used to set up a full LAMP server for [Laravel](http://laravel.com/) projects. Clone this repo to gain access to your very own Vagrant-powered development machine!

## Getting started

Make sure you have the required dependencies installed

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)

Clone this repository to your local machine and start up Vagrant in the terminal.

```
git clone https://github.com/SoapBox/vagrant-laravel-playground.git
```


Then navigate to the repo's folder and run

```
vagrant up
```

The `vagrant up` command will do a few things

1. Download the VM Box specified in the Vagrantfile (in this case, the standard `hashicorp/precise64` box).
2. Boots up an instance of the VM, with a shared folder from the current local directory to the VM's `/var/www/` directory.
3. Provisions the VM with the included `bootstrap.sh` script.
 - Installs Apache, MySQL, PHP, HHVM, and configures each one.

You are now able to log in to your virtual machine from the terminal using

```
vagrant ssh
```


You can then `cd` into the `/var/www/` folder and have full access to the Laravel project

```
cd /var/www/
composer install
php artisan migrate
```

## Useful tools

* [PuPHPet](https://puphpet.com/) - Web-based configuration
* [Simon](https://github.com/SoapBox/simon) - Development interface we use at SoapBox to help us with Vagrant and our other development tools

