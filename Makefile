DOCKER_RUN=docker run -d -it
DOCKER_ALICE=$(DOCKER_RUN) -p 18444:18444 -p 18332:18332 --name=alice --hostname=alice
DOCKER_BOB  =$(DOCKER_RUN) -p 19444:18444 -p 19332:18332 --name=bob --hostname=bob

BITCOIN_SRC=/home/osboxes/Projects/bitcoin

BASE_IMG=anon-sol/bitcoin-dev-base
RUN_BASE_IMG=run-bitcoin-dev-base
IMG=anon-sol/bitcoin-dev

RUN_DAEMON=bitcoind -regtest -daemon -printtoconsole
RUN_SHELL=bash

build-base:
	docker build -t $(BASE_IMG) base

run-base:
	docker run -d -it -v $(BITCOIN_SRC):$(BITCOIN_SRC) -w $(BITCOIN_SRC) --name $(RUN_BASE_IMG) $(BASE_IMG) bash

stop-base:
	docker stop $(RUN_BASE_IMG)

autogen-base:
	docker exec $(RUN_BASE_IMG) ./autogen.sh

configure-base:
	docker exec $(RUN_BASE_IMG) ./configure

compile-base:
	docker exec $(RUN_BASE_IMG) make

test-base:
	docker exec $(RUN_BASE_IMG) make check

install-base:
	docker exec $(RUN_BASE_IMG) make install

commit-base:
	docker commit $(RUN_BASE_IMG) $(IMG)

alice_rm:
	-docker rm -f alice

bob_rm:
	-docker rm -f bob

alice_shell: alice_rm
	$(DOCKER_ALICE) -it $(IMG) $(RUN_SHELL)

bob_shell: bob_rm
	$(DOCKER_BOB) -it $(IMG) $(RUN_SHELL)

bob_daemon: 
	docker exec bob $(RUN_DAEMON)

bob_cmd:
	docker exec bob bitcoin-cli -regtest $(bccmd)

alice_daemon: 
	docker exec alice $(RUN_DAEMON)

alice_cmd:
	docker exec alice bitcoin-cli -regtest $(bccmd)


