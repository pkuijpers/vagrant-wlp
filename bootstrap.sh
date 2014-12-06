#!/usr/bin/env bash

apt-get update

# Inspiration: https://registry.hub.docker.com/u/wasdev/websphere-liberty/dockerfile/

# Install Java 7
wget --no-check-certificate https://github.com/aglover/ubuntu-equip/raw/master/equip_java7_64.sh && bash equip_java7_64.sh

# Install Websphere Liberty Profile
export LIBERTY_VERSION=8.5.5.3
export LIBERTY_URL=`wget -q -O - http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/index.yml | sed -n '/'$LIBERTY_VERSION'/{n;p}' | sed -n 's/\s*uri:\s//p'`
wget $LIBERTY_URL -O wlp-developers-runtime.jar
java -jar wlp-developers-runtime.jar --acceptLicense /home/vagrant
rm wlp-developers-runtime.jar
/home/vagrant/wlp/bin/server create liberty-server

# Start server
/home/vagrant/wlp/bin/server start liberty-server
