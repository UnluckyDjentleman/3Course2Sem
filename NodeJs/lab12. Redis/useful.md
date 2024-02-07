# How to start a work with Redis?
1. ## WSL Installation

First of all, you need to install and configure WSL. It's neccessary to look if the component's checkbox __"Windows Subsystem for Linux"__ is checked. It's doing through `Control Panel->Programs->Turn On/Turn Off Windows Components`.

After that you should install "WSL" from Microsoft Store (*it has an image of penguin*). When it's installed, open PowerShell and input:

```
wsl --set-default-version 1
```

Restart the system.

Then go to Microsoft Store one more time and install Ubuntu (*because it is the latest version*). After installation you need to install environment

```
sudo apt update; sudo apt -y install ruby ruby-dev gcc make g++ curl; curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -; sudo apt -y install nodejs; sudo npm i -g gulp rimraf npm-check-updates; npm config set package-lock false; sudo gem i bundler jekyll jekyll-paginate-v2;
```

__P.S. To open Linux Teminal ``Shift+RightClick`->Open Linux Terminal` in any path__

2. ## Redis

First of all, you need package with stable versions from `packages.redis.io`, then add repo to the `apt` index, update it and install

```
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

sudo apt-get update
sudo apt-get install redis
```

To start the server:

```
sudo service redis-server start
```

Connection Control:

```
redis-cli
```

## GOOD LUCK!!!





