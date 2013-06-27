J'ai longtemps cherché cette solution et je l'ai enfin trouvée !!

Le besoin est très simple : je veux me connecter derrière un proxy socks et ainsi outrepasser certaines limitations du réseau (réseau de la fac par exemple) ou encore chiffrer simplement mes communications sur internet.

Sauf qu'il faut configurer une à une les applications (firefox, pidgin etc.) pour profiter de cette encapsulation du trafic, et bien-sur enlever le paramètre des qu'on souhaite revenir à un fonctionnement normal.

Mais c’était sans compter sur cette application (python) magique : sshuttle

Sshuttle permet d'appliquer le proxy socks à tout le système. Rien que ça !

Avantages :

    Aucune configuration à faire coté serveur
    Aucune configuration des applications coté client
    Putain que c'est simple !

Installation

Pour l'installer un simple apt-get devrait suffir :

sudo apt-get install sshuttle

Ou alors récupérer les sources depuis github:

$ git clone https://github.com/apenwarr/sshuttle.git
$ cd sshuttle
$ ./sshuttle -r [...]

La commande magique

TaDammmm !

./sshuttle -r username@sshserver 0.0.0.0/0 -vv

Voilà...c'est fini, il n'y a plus rien à voir ^^

Bon, peut-être que vous voulez automatiser le lancement du proxy via un petit script ? pourquoi pas !

Je vous fais partager mon script (à placer où vous voulez tant que c'est dans le PATH)

#! /bin/bash

name=proxy

port=myport
user=username
host=sshserver

pid_file=~/.local/var/run/$name
mkdir -p $(dirname $pid_file)

# Arrêt du service
function stop {
  if [ -f $pid_file ] ; then
    echo -n "Arrêt de $name..."
    sudo kill -9 $(cat $pid_file)
    sudo rm $pid_file
    echo "OK"
  fi
}

# Démarrage du service
function start {
  echo -n "Démarrage de $name..."
  sudo sshuttle -r $user@$host:$port 0/0 --dns -D --pidfile $pid_file
  echo "OK"
}

# commandes
case $1 in
    start)
    start
    ;;
    stop)
    stop
    ;;
    restart)
    stop
    start
    ;;
    *)
    echo "usage: $(basename $0) start|stop"
    exit 1
esac

l'option --dns permet d'encapsuler également les requêtes DNS, ce qui est plus que recommandé.
Test

$ alias myip="wget http://checkip.dyndns.org -O - -o /dev/null | cut -d : -f 2 | cut -d \< -f 1"
$ myip
 82.224.*.*

Ainsi il suffit d'un...

$ proxy start
Démarrage de proxy...Connected.
OK

...pour faire passer tout le trafic par le proxy.

$ myip
 94.23.*.*

Conclusion

Oui..je sais, c'est un peu comme un VPN mon truc là, mais OpenVPN ça n'a jamais marché chez moi, là c'est une seule commande et ça marche du premier coup.
