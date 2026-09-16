CC = $(shell xcrun --sdk iphoneos --find clang)
SDK = $(shell xcrun --sdk iphoneos --show-sdk-path)
LDID = $(shell which ldid)

CFLAGS := -I./include -isysroot $(SDK) -arch armv7 -miphoneos-version-min=10.0 -fno-objc-arc
LDFLAGS := -L$(SDK)/usr/lib -lSystem -lc -framework CoreFoundation \
	-Wl,-sectcreate,__DATA,__stage3,../untether/untether.js \
	-Wl,-sectcreate,__DATA,__disabled,../resources/disabled.plist

SRC = $(wildcard src/*.c)

all: $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -o procyon $^
	$(LDID) -S../resources/ents.xml procyon

clean:
	@rm -rf procyon
