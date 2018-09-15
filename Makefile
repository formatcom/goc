# Vinicio Valbuena
# REF: https://gcc.gnu.org/onlinedocs/gcc/Option-Index.html
# VERSION STATIC WITH glibc-static

# the build target executable
TARGET=$(shell basename $(PWD))

# the compiler: gcc for C program, define as g++ for C++
CC=gcc

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS=-fPIC -m64 -fmessage-length=0 -g -O2 -Wall

# define any directories containing header files
INCLUDES=-I.

# define library paths in addition
LFLAGS=-L.

# define any libraries to link into executable
LIBS=-lfoo -lpthread

# define the C source files
SRCS=main.c

# define the C object files
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
OBJS = $(SRCS:.c=.o)

all: $(TARGET) $(TARGET)-static

$(TARGET): libfoo.so $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) \
		-o $@ $(LFLAGS) $(OBJS) $(LIBS)

$(TARGET)-static: libfoo.a $(OBJS)
	$(CC) -static $(CFLAGS) $(INCLUDES) \
		-o $@ $(LFLAGS) $(OBJS) $(LIBS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file)
# (see the gnu make manual section about automatic variables)
.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

libfoo.so:
	CC=$(CC) go build -buildmode=c-shared -o $@ foo/foo.go

libfoo.a:
	CC=$(CC) go build -buildmode=c-archive -o $@ foo/foo.go

.PHONY: clean

clean:
	rm -rf $(TARGET) $(TARGET)-static \
		_obj *.o *.so *.a *.h
