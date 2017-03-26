# bitcoin-dev
Setup a BitCoin development environment using Docker

This project is based on the following blog:  https://geraldkaszuba.com/creating-your-own-experimental-bitcoin-network/

I have adapted the Docker image and scripts to:

- add all the BitCoin dev dependencies to the Docker image
- use the Docker image to compile the BitCoin codebase and then deploy the compiled image
- use the Docker image to run the BitCoin unit tests
- run a local BitCoin network using the compiled images (as per the blog referenced above

Note that you will need Docker installed, you can get Docker here,along with instructions to install on your platform.

Note also that I run my development environment in a Ubuntu 16.04 VM (VirtualBox), this is the platform that the following has been tested on.

You will need to clone the Git repositories for the BitCoin codebase and this repo:

## I keep all my code under ~/Projects
cd ~
mkdir Projects
cd Projects
git clone https://github.com/bitcoin/bitcoin.git
git clone https://github.com/ianco/bitcoin-dev.git

Now cd into the bitcoin-dev directory and create the Docker image:

## Run make to build the Docker image (see Dockerfile for all the dependencies)
make build-base
docker images

Once the image is built you can run it, and use the image to compile the BitCoin code.  Note that the BitCoin code is on the host, but the Docker image is used to compile - all of the development dependencies are installed on the docker image and the host is clean.

## run the Docker base image
make run-base
docker ps

## compile BitCoin
make autogen-base
make configure-base
make compile-base

Once you've compiled the code you can run the unit tests to make sure everything is running smoothly

## test BitCoin
make test-base

If everything is ok, install bitcoind into your image and then "commit" your image so you have a saved image with BitCoin installed.  You will use this later to run your local "test" network.

## install bitcoind and then save the image
make install-base
make commit-base
make stop-base
docker ps
docker images

Now you are ready to setup your test network.  You will run two versions of the bitcoind image, configured to run bitcoind on two different ports, with two different host names ("bob" and "alice").  These will run as background processes and you will use docker to run the Bitcoin client on each container.

## build and run "bob" and "alice" containers
make alice_shell
make alice_daemon
make bob_shell
make bob_daemon
docker ps

You are now setup to send commands to your bitcoin clients!

make bob_cmd bccmd="..."

or 

make alice_cmd bccmd="..."

Echoing the sequence of commands from the blog referenced above, try the following:

## inspect each container (note the IP address of each)
docker inspect alice
docker inspect bob

## get info for each of the bitcoind containers
make alice_cmd bccmd=getinfo
make alice_cmd bccmd="getblockhash 0"
make bob_cmd bccmd=getinfo
make bob_cmd bccmd="getblockhash 0"

## add alice as a node to bob (get the <alice ip> IP address from the "docker inspect" command above)
make bob_cmd bccmd="addnode <alice ip> onetry"

## generate some blocks
make alice_cmd bccmd=""
make alice_cmd bccmd=""

## check the balance for each container
make alice_cmd bccmd=""
make bob_cmd bccmd=""

## generate a bc address for bob, and pay some funds from alice to bob
make bob_cmd bccmd=""
make alice_cmd bccmd=""

## generate some more blocks, and then check each container's balance again
make alice_cmd bccmd=""
make alice_cmd bccmd=""
make bob_cmd bccmd=""








