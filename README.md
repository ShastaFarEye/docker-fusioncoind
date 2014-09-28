docker-mazacoind
================

Builds a docker with mazacoind build env and builds mazacoind
This will produce you a ready-to-run mazacoind


*** Installation ***

As simple as git clone & make!!
<code>
git clone https://github.com/mazaclub/docker-mazacoind 
cd docker-mazacoind
make
<code>

*** RUN ***

To simply run a basic mazacoind all you need is:

<code> docker run -d -p XXX:12832 -p XXX:12835 mazaclub/mazacoind /sbin/my_init <code>

This comes with an ssh server running to simplify you manangement. You can either enter with nsenter, or ssh

Run the docker with ssh available:
<code> docker run -d -p XXX:22 -p XXX:12832 -p XXX:12835 mazaclub/mazacoind /sbin/my_init --enable-insecure-key<code>


To use the include insecure SSH key, 

<code>
# Download the insecure private key
curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
chmod 600 insecure_key

# Login to the container
ssh -i insecure_key root@localhost

# Running a command inside the container
ssh -i insecure_key root@<IP address> echo hello world
<code>

*** CONFIGURATION ***

Datadir is /root/.mazacoin - symlinked to /.mazacoin to handle various docker dun styles.
A basic mazacoin.conf is provided, with seed nodes, and a random rpcpassword set, and RPC allowed in from the docker. 

*** WALLET SECURITY ***

We haven't tested this in a production payment processing mazacoind. 

At this time, if you run in a production payment system, you may wish to run the docker with the wallet.dat located on the host filesystem. This may ease recovery, or speed recovery time in the event of a docker failure.

<code>docker run -d -p XXX:12832 -p XXX:12835 -v /var/mazacoin/wallets/wallet.dat:/root/.mazacoin/wallet.dat mazaclub/mazacoind /sbin/my_init</code>



