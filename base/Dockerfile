FROM ubuntu:16.10
RUN apt-get update && \
	apt-get install -y \
	software-properties-common \
	libminiupnpc-dev \
	libzmq3-dev \
	libqt5gui5 \
	libqt5core5a \
	libqt5dbus5 \
	qttools5-dev \
	qttools5-dev-tools \
	libprotobuf-dev \
	protobuf-compiler
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update && \
	apt-get install -y \
	build-essential \
	libtool \
	autotools-dev \
	automake \
	pkg-config \
	libssl-dev \
	libevent-dev \
	bsdmainutils \
	libboost-system-dev \
	libboost-filesystem-dev \
	libboost-chrono-dev \
	libboost-program-options-dev \
	libboost-test-dev \
	libboost-thread-dev \
	libqrencode-dev \
	libdb4.8-dev \
	libdb4.8++-dev
RUN mkdir ~/.bitcoin
RUN echo "rpcuser=test\nrpcpassword=test\n" > ~/.bitcoin/bitcoin.conf
RUN echo "alias rt='bitcoin-cli -regtest'" >> ~/.bashrc
CMD bash


