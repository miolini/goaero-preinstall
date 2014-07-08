all: init clean build
OS=$(shell uname)
ARCH=$(shell uname -m)

init:
	@echo Info: OS $(OS), ARCH $(ARCH)
ifeq ($(OS),Linux)
	sudo apt-get install libc6-dev libssl-dev liblua5.1-dev autoconf automake libtool g++
endif
ifeq ($(OS),Darwin)
	sudo brew install lua
endif
	git submodule update --init --recursive

build:
	CPATH=$(CPATH):/usr/include/lua5.1 $(MAKE) -C aerospike-client-c

clean:
	$(MAKE) -C aerospike-client-c clean

install:
	cp -r aerospike-client-c/target/*/include/* /usr/local/include
	cp aerospike-client-c/target/*/lib/* /usr/local/lib