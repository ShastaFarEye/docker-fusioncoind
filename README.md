docker-fusioncoind
================

Builds a docker with fusioncoind build env and builds fusioncoind
This will produce you a ready-to-run fusioncoind


*** Installation ***

As simple as git clone & make!!
<code>
git clone https://github.com/fusionclub/docker-fusioncoind 
cd docker-fusioncoind
make
<code>

*** RUN ***

To simply run a basic fusioncoind all you need is:

<code> docker run -d -p XXX:12832 -p XXX:12835 fusionclub/fusioncoind /sbin/my_init <code>

This comes with an ssh server running to simplify you manangement. You can either enter with nsenter, or ssh

Run the docker with ssh available:
<code> docker run -d -p XXX:22 -p XXX:12832 -p XXX:12835 fusionclub/fusioncoind /sbin/my_init --enable-insecure-key<code>


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

Datadir is /root/.fusioncoin - symlinked to /.fusioncoin to handle various docker dun styles.
A basic fusioncoin.conf is provided, with seed nodes, and a random rpcpassword set, and RPC allowed in from the docker. 

*** WALLET SECURITY ***

We haven't tested this in a production payment processing fusioncoind. 

At this time, if you run in a production payment system, you may wish to run the docker with the wallet.dat located on the host filesystem. This may ease recovery, or speed recovery time in the event of a docker failure.

<code>docker run -d -p XXX:12832 -p XXX:12835 -v /var/fusioncoin/wallets/wallet.dat:/root/.fusioncoin/wallet.dat fusionclub/fusioncoind /sbin/my_init</code>



