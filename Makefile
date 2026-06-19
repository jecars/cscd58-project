UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	OPENSSL_PREFIX := $(shell brew --prefix openssl@3)
	CFLAGS := -g -Wno-deprecated-declarations -I$(OPENSSL_PREFIX)/include
	LDFLAGS := -L$(OPENSSL_PREFIX)/lib
else
	CFLAGS := -g -Wno-deprecated-declarations
	LDFLAGS :=
endif

LDLIBS := -lssl -lcrypto -pthread

all: server client

server: server.c netutils.c common.c encrypt.c
	gcc ./common.c ./netutils.c ./encrypt.c ./server.c $(CFLAGS) -o server $(LDFLAGS) $(LDLIBS)

client: client.c encrypt.c netutils.c common.c
	gcc ./common.c ./netutils.c ./encrypt.c ./client.c $(CFLAGS) -o client $(LDFLAGS) $(LDLIBS)

clean:
	rm -f client
	rm -f server
