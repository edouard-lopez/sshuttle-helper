## Description

`sshuttle-helper` simplify the use of `sshuttle` by adding a LSB service to your system called `proxy-ssh`.

So you can connect to a proxy socks into another server and escape from local network limitation or simply **encrypt all your communication** (only between you and the _proxy_ server).

There is no need to configure each application anymore as all your connexions now go through the proxy.

### Advantages

1. **zero server's configuration** (well, of course you need `ssh` installed) ;
2. **zero client's configuration**.

## Requirements

You will need to install `sshuttle` through package manager :

    sudo apt-get install sshuttle

Or from sources (on [Github](https://github.com/apenwarr/sshuttle)):

    git clone https://github.com/apenwarr/sshuttle.git
    cd sshuttle
    ./sshuttle -r [...]

## The automatic installer… (do you trust me?)

You can install this via the command line with either `curl` or `wget`.
### via `curl`

    curl -L https://raw.github.com/edouard-lopez/sshuttle-helper/master/install.sh | sh

### via `wget`

    wget --no-check-certificate https://raw.github.com/edouard-lopez/sshuttle-helper/master/install.sh -O - | sh

## The manual way

1. Clone the repository

    git clone git://github.com/edouard-lopez/sshuttle-helper.git

2. Copy the `proxy-ssh` file into `/etc/init.d/` :

    cp ./proxy-ssh /etc/init.d/

3. add the script to your System-V style init script

    update-rc.d proxy-ssh defaults


You will need to add this script's directory to your `$PATH` (in your `~/.bashrc` or `~/.zshrc`) as follows:

    PATH="$PATH":/path/to/sshuttle-helper-dir

Make it available as root

    sudo ln -s /path/to/sshuttle-helper-dir/proxy-ssh /usr/local/sbin/

## Usage

Quite simple :

    sudo proxy-ssh start username@server[:port]
    # default port is 22

**Done**.

# Test

    alias myip="wget http://checkip.dyndns.org -O - -o /dev/null | cut -d : -f 2 | cut -d \< -f 1"
    myip
    # xx.xx.xx.xx

Ainsi il suffit d'un...

    proxy-ssh start
    # Starting 'proxy-ssh'...Connected.
    # OK

...pour faire passer tout le trafic par le proxy-ssh.

    myip
    # yy.yy.yy.yy

