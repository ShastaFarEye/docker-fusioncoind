#! /usr/bin/env bash
set -e


# Config


# https://gist.github.com/dergachev/8441335
# If host is running squid-deb-proxy on port 8000, populate /etc/apt/apt.conf.d/30proxy
# By default, squid-deb-proxy 403s unknown sources, so apt shouldn't proxy ppa.launchpad.net
route -n | awk '/^0.0.0.0/ {print $2}' > /tmp/host_ip.txt
echo "HEAD /" | nc `cat /tmp/host_ip.txt` 8000 | grep squid-deb-proxy \
	&& (echo "Acquire::http::Proxy \"http://$(cat /tmp/host_ip.txt):8000\";" > /etc/apt/apt.conf.d/30proxy) \
	&& (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> /etc/apt/apt.conf.d/30proxy) \
	|| echo "No squid-deb-proxy detected on docker host"


# Ensure package list is up to date.
apt-get update

# Install runtime dependencies.
#apt-get install -y  

# Install build dependencies.
apt-get install -y wget makepasswd libqrencode-dev libcurl4-openssl-dev automake make libdb5.1++-dev ntp git build-essential libssl-dev libdb5.1-dev libboost-all-dev 

# Prepare building
mkdir -p /src


mkdir /root/.fusioncoin
touch /root/.fusioncoin/.firstrun
mkdir /etc/service/fusioncoind
# Download, compile and install fusioncoind.
cd /src
git clone https://github.com/fusionCoin/fusionCoin fusioncoin
cd "fusioncoin/src"
sed -i 's/USE_UPNP:=0/USE_UPNP:=-/g' makefile.unix
ln -s /root/.fusioncoin /
make -f makefile.unix  && cp -a fusioncoind /usr/local/bin && make -f makefile.unix clean


# Clean up
#apt-get remove -y wget
apt-get autoremove -y
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
