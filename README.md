## Description

`sshuttle-helper` is a script to simplify the run of `sshuttle` proxying.

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

# Setup

You will need to add this script's directory to your `$PATH` (in your `~/.bashrc` or `~/.zshrc`) as follows:

    PATH="$PATH":/path/to/sshuttle-helper-dir

Make it available as root

    sudo ln -s /path/to/sshuttle-helper-dir/proxy /usr/local/sbin/

## Usage

Quite simple :

    sudo proxy start username@server[:port]
    # default port is 22

**Done**.

# Test

    alias myip="wget http://checkip.dyndns.org -O - -o /dev/null | cut -d : -f 2 | cut -d \< -f 1"
    myip
    # xx.xx.xx.xx

Ainsi il suffit d'un...

    proxy start
    # Starting 'proxy'...Connected.
    # OK

...pour faire passer tout le trafic par le proxy.

    myip
    # yy.yy.yy.yy

# Conclusion

Oui..je sais, c'est un peu comme un VPN mon truc là, mais OpenVPN ça n'a jamais marché chez moi, là c'est une seule commande et ça marche du premier coup.

