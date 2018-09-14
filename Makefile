TARGET=$(shell basename $(PWD))

all: $(TARGET) $(TARGET)-static

$(TARGET): libfoo.so
	gcc -Wall -L. -o $@ main.c -lfoo

$(TARGET)-static: libfoo.a
	gcc -Wall -o $@ main.c $^ -lpthread

libfoo.so:
	go build -a -buildmode=c-shared -o $@ foo/foo.go

libfoo.a:
	go build -a -buildmode=c-archive -o $@ foo/foo.go

clean:
	$(RM) libfoo.* $(TARGET) $(TARGET)-static
