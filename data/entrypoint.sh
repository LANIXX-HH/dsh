#!/bin/bash

test -f /home/user/.lanixx && ( echo "..."

  _UID=$(ls -ldn /home/user/.lanixx | awk '{print $3}')
  _GID=$(ls -ldn /home/user/.lanixx | awk '{print $4}')

  if (test $_UID -gt 33); then 
    echo change user uid to $_UID ...
    usermod -u $_UID user &
  else
    echo change user uid to 1000 ...
    usermod -u 1000 user &
  fi
  sleep 1

  if (test $_GID -gt 33 || test $_GID -lt 33 ); then
    echo change gid $_GID ...
    set -x
    groupmod -o -g $_GID user &
    set +x
  else
    echo change gid 1000 ...
    groupmod -o -g 1000 user &
  fi
  sleep 1

)

chmod 666 /var/run/docker.sock

test -f /home/user/.bash_it/install.sh || ( git clone --depth=1 https://github.com/Bash-it/bash-it.git /home/user/.bash_it )
chown -R user:user /home/user/.bash_it

sudo su -c "test -f /home/user/.bash_it/install.sh && /home/user/.bash_it/install.sh -s" user
sudo su -c "eval $(ssh-agent) && ssh-add -K ~/.ssh/id_rsa" user

while sleep 3600; do :; done
