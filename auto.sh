#!/usr/bin/env bash
# DESCRIPTION
#   Automatic proxy opening based on sshuttle
#
# USAGE
#	  proxy start username server port
#
# AUTHOR
# 	Credit for the original script go to Salem Harrache's article:
#	    http://salem.harrache.info/proxy-socks-partout.html

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
