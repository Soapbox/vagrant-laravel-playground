Vagrant/Laravel Playground
===============================================================================

[Vagrant](http://www.vagrantup.com/) is a way to quickly set up a virtualized development environment. This repo showcases how Vagrant can be used to set up a full LAMP server for [Laravel](http://laravel.com/) projects. Clone this repo to gain access to your very own Vagrant-powered development machine!

## Getting started

Make sure you have the required dependencies installed

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)

Clone this repository to your local machine

```
git clone https://github.com/SoapBox/vagrant-laravel-playground.git
```

Then navigate to the repo's folder and start up Vagrant

```
vagrant up
```

This command does a few things

1. Downloads the VM Box specified in the Vagrantfile (in this case, the standard `hashicorp/precise64` box).
2. Boots up an instance of the VM, with a shared folder from the current local directory to the VM's `/var/www/` directory.
3. Provisions the VM with the included `bootstrap.sh` script.
 - Installs Apache, MySQL, PHP, HHVM, and configures each one.

You are now able to log in to your virtual machine from the terminal using

```
vagrant ssh
```


Then `cd` into the `/var/www/` shared folder to get full access to your Laravel project

```
cd /var/www/
composer install
php artisan migrate
```

Because `/var/www/` is shared between the VM and your local machine, any change you make while the VM is running will appear in either environment.

You're now ready to view the site in your browser. Visit
```
http://192.168.50.5/
```

in your browser. If you want a nicer `.dev` URL, you can add this entry to your hosts file

```
192.168.50.5    vlplayground.dev
```

And visit `http://vlplayground.dev/` instead.

For more about Vagrant and its options, run 

```
vagrant --help
```

from your terminal.

## Customising your Vagrant box (Advanced)

The Vagrantfile in this repo uses Vagrant's default Ubuntu 12.04 64bit box, which may not exactly match your development environment. Use this section to help you set up your required development environment.

### Changing the Vagrant Box

The name of the box and its location is specified in the Vagrantfile

```rb
config.vm.box = "hashicorp/precise64"
config.vm.box_url = "https://vagrantcloud.com/hashicorp/precise64/version/2/provider/virtualbox.box"
```

You can find additional boxes at https://vagrantcloud.com/discover/

#### Notes
* If you want to use a different Box provider such as VMWare, you'll have to do some [additional configuration in the Vagrantfile](https://docs.vagrantup.com/v2/providers/configuration.html).
* The `bootstrap.sh` file will look radically different for different Linux distributions. It's up to you to write the best shell configuration for your environment.
    - You can use [PuPHPet](https://puphpet.com/) for common distros.

### Configuring the Laravel app

There's a small amount of configuration you'll need to do for your Laravel app if you're planning on changing the default Vagrant configuration.

* `bootstrap/start.php` sets up two different environments, `local` and `vagrant`

```php
$env = $app->detectEnvironment(array(
  'local' => array('*.local'), // Optional
  'vagrant' => array('precise64') // Change this if you change the default VM
));
```

The `local` environment gives you the option to run Artisan without having to SSH into the VM. `vagrant` will be the environment used while the app is running in the browser. Change the detection string for this to your new box's hostname, which you can find using this command

```
vagrant ssh -c hostname
```

* If you change the IP, sitename, or database settings update the configuration at `app/config/local` and `app/config/vagrant`.

## Some useful tools

* [PuPHPet](https://puphpet.com/) - Web-based Vagrant configuration
* [Simon](https://github.com/SoapBox/simon) - Development interface we use at SoapBox to help us with Vagrant and our other development tools

## Contributing

Find a bug or an enhancement? Fork us and submit a pull request with your fix!

***

Copyright © 2014 SoapBox Innovations Inc.
