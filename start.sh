#!/bin/bash
# Installation of Docker
apt-get update
apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install -y docker-ce


# Installation of docker-compose
curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Installation of supervisor
apt-get install -y supervisor

supervisorPort=${SUPERVISOR_PORT:-9001}
supervisorUsername=${SUPERVISOR_USERNAME:-"root"}
supervisorShaPwd=($(echo -n $SUPERVISOR_PWD | sha1sum))


cat > /etc/supervisor/conf.d/inet_http_server.conf << EOL
[inet_http_server]
port=*:$supervisorPort
username=$supervisorUsername
password={SHA}$supervisorShaPwd
EOL

service supervisor restart





wget -q -c -nc https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip

unzip -qq -n ngrok-stable-linux-amd64.zip

./ngrok authtoken  1eJ879JFo0Lde3KB9Z3E7R0q8vN_7CF88NU5Q1epjY9k5Nomr
./ngrok tcp 22  
done
