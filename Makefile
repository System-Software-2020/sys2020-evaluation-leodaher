BUILD_DIR=./build
FLAGS=-m32
LD_FLAGS=-Wl,-rpath=\$$ORIGIN -Wl,-rpath=\$$ORIGIN/../lib

all: ex1

build_dir:
	mkdir -p $(BUILD_DIR)

libex2.so: build_dir
	gcc $(FLAGS) -c -I. ex2.c -o $(BUILD_DIR)/ex2.o
	gcc $(FLAGS) -fpic -shared $(BUILD_DIR)/ex2.o -o $(BUILD_DIR)/libex2.so

ex1: libex2.so
	gcc $(FLAGS) -m32 -I. -L$(BUILD_DIR) $(LD_FLAGS) ex1.c -lex2 -o $(BUILD_DIR)/ex1

install:
	mkdir -p $(PREFIX)/usr/bin $(PREFIX)/usr/lib
	cp $(BUILD_DIR)/ex1 $(PREFIX)/usr/bin/
	cp $(BUILD_DIR)/libex2.so $(PREFIX)/usr/lib/

uninstall:
	rm $(PREFIX)/usr/bin/ex1
	rm $(PREFIX)/usr/lib/libex2.so

clean:
	rm -rf ./build
