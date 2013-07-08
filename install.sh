#!/usr/bin/env sh
# DESCRIPTION
#   Install sshuttle-helper as an init-script
#
# USAGE
#   curl -L https://github.com/edouard-lopez/sshuttle-helper/raw/master/install.sh | sh
#
# AUTHOR
#   Édouard Lopez

# clone
echo "\033[0;34mCloning SSHuttle-helper...\033[0m"
hash git >/dev/null && /usr/bin/env git clone git://github.com/edouard-lopez/sshuttle-helper.git || {
  echo "git not installed"
  exit
}
initDir=/etc/init.d

# copy to System-V style init script directory
cd sshuttle-helper
if [ -e "$initDir/proxy-ssh" ]; then
  echo "Adding init script..."
  sudo cp ./proxy-ssh /etc/init.d/
fi
