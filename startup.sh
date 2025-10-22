#!/bin/bash

#echo "pw${USER}111" | sudo -S service ssh start
echo "${USER_PWD}" | sudo -S service ssh start
daemon-app

exit 0
