BUILD_DIR=./build
FLAGS=-m32
LD_FLAGS=-Wl,-rpath=\$$ORIGIN -Wl,-rpath=\$$ORIGIN/../lib

all: $(BUILD_DIR)/ex1 

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/libex2.so: $(BUILD_DIR)/ex2.o | $(BUILD_DIR)
	gcc $(FLAGS) -fpic -shared $< -o $@

$(BUILD_DIR)/ex1: $(BUILD_DIR)/libex2.so | $(BUILD_DIR) 
	gcc $(FLAGS) -m32 -I. -L $(BUILD_DIR) $(LD_FLAGS) ex1.c -lex2 -o $(BUILD_DIR)/ex1

$(BUILD_DIR)/%.o : %.c | $(BUILD_DIR)
	gcc $(FLAGS) -c -I. $< -o $@

install:
	mkdir -p $(PREFIX)/usr/bin $(PREFIX)/usr/lib
	cp $(BUILD_DIR)/ex1 $(PREFIX)/usr/bin/
	cp $(BUILD_DIR)/libex2.so $(PREFIX)/usr/lib/

uninstall:
	rm -f $(PREFIX)/usr/bin/ex1
	rm -f $(PREFIX)/usr/lib/libex2.so

clean:
	rm -rf ./build
