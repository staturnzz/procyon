SRC := ./src/common.js ./src/util.js ./src/memory.js ./src/system.js ./src/dyld.js ./src/exploit.js ./src/patches.js ./src/main.js

all: $(SRC)
	@cat $^ > ./untether.js
	@chmod 0777 ./untether.js
	@chown 501:20 ./untether.js
#eslint ./untether.js

clean:
	@rm -rf ./untether.js
