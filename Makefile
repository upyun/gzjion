SYS := $(shell gcc -dumpmachine)
ifneq (, $(findstring apple-darwin, $(SYS)))
LRT = ""
else
LRT = -lrt -lm
endif

OUT= -o gzjion
OUTD = 

all: gzjion

gzjion: main.o
	gcc -g -ggdb *.o -lpthread $(LRT) zlib-1.2.8/libz.a $(OUT)

main.o:
	[ -f zlib-1.2.8/libz.a ] || (cd zlib-1.2.8 && ./configure && rm configure.log && make);
	gcc -g -ggdb -fPIC -c *.c -I./zlib-1.2.8/ $(OUTD)

clean:
	cd zlib-1.2.8 && make clean;
	rm *.o;
	rm gzjion;

