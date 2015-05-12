# Add the Docker repository key to your local keychain
sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
# Add the Docker repository to your apt sources list.
sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

# Update your sources
apt-get -y update

# Install docker
apt-get -y install lxc-docker

usermod -a -G docker vagrant

sed -i "s~^.*/usr/bin/docker -d~  /usr/bin/docker -d -r -H 'unix:///var/run/docker.sock' -H 'tcp://0.0.0.0:4243' -api-enable-cors~" /etc/init/docker.conf
service docker restart