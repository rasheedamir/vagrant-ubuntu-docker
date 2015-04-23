# vagrant-ubuntu-docker

# Install Ruby

First of all, install the prerequisite libraries:

```sh
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

Then install rbenv, which is used to install Ruby:

```sh
cd
git clone git@github.com:sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git@github.com:sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone git@github.com:sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.1
rbenv global 2.2.1
ruby -v
```

Then (optional) tell Rubygems to not install local documentation:

```sh
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
```

# Install Virtualbox:

## Option 1

`$ sudo apt-get install virtualbox`

The `VBox` version must be `4.3.10`

Note: If the version of `VBox` is different then the `Vagrantfile` must be updated to install the matching `VBox Guest Additions`.

To find the `VBox` version run this command: `vboxmanage --version`

## Option 2

Alternatively install from [Oracle Debian Repository](https://www.virtualbox.org/wiki/Linux_Downloads)

```sh
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list'
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-4.3
```

# Install Vagrant:

## Option 1

`$ sudo apt-get install vagrant`

*Note* this usually doesn't install the latest version unfortunately! Please run the following command and verify the version. Make sure it matches the latest available version otherwise please look option 2 below.

To verify the version run: `vagrant -v`

Install plugin:

`vagrant plugin install vagrant-vbguest`

List of installed vagrant plugins: `vagrant plugin list`

## Option 2

*Note* ensure the latest version of Vagrant has been installed (1.5+). You can always download and install latest version from [here](http://www.vagrantup.com/downloads.html)

Move to the directory where you have downloaded the vagrant e.g. `Downloads` and run following commmand. Please change file name as appropriate.

`sudo dpkg -i vagrant_1.7.2_x86_64.deb`

# Install dkms package:

Install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the Linux kernel version changes during the next apt-get upgrade.

`$ sudo apt-get install virtualbox-dkms`

# Install Veewee & Bundler

Veewee is a tool for easily (and repeatedly) building custom Vagrant base boxes, KVMs, and virtual machine images.

```sh
gem install bundler
gem install veewee
```

# Create Box!

move into `vagrant-ubuntu-docker` project folder and run following:

```sh
bundle install
bundle install --path vendor
chmod 700 vagrant_insecure.key
bundle exec rake virtualbox:ubuntu-14.04-amd64:all
```
