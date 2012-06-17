OBJS=triangle.o
BIN=ahrs

CFLAGS+=-DSTANDALONE -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS
CFLAGS+=-DTARGET_POSIX -D_LINUX -fPIC -DPIC -D_REENTRANT -D_LARGEFILE64_SOURCE
CFLAGS+=-D_FILE_OFFSET_BITS=64 -U_FORTIFY_SOURCE
CFLAGS+=-Wall -g
CFLAGS+=-DHAVE_LIBOPENMAX=2 -DOMX -DOMX_SKIP64BIT
CFLAGS+=-ftree-vectorize -pipe -DUSE_EXTERNAL_OMX
CFLAGS+=-DHAVE_LIBBCM_HOST -DUSE_EXTERNAL_LIBBCM_HOST -DUSE_VCHIQ_ARM -Wno-psabi

LDFLAGS+=-L/opt/vc/lib/ -lGLESv2 -lEGL -lopenmaxil -lbcm_host -lvcos -lvchiq_arm
LDFLAGS+=/opt/vc/src/hello_pi/libs/ilclient/libilclient.a

INCLUDES+=-I/opt/vc/include/ -I/opt/vc/include/interface/vcos/pthreads
INCLUDES+=-I/opt/vc/src/hello_pi/libs/ilclient -I/opt/vc/src/hello_pi/libs/ilclient/libs/vgfont

all: $(BIN) $(LIB)

%.o: %.c
	@rm -f $@ 
	$(CC) $(CFLAGS) $(INCLUDES) -g -c $< -o $@ -Wno-deprecated-declarations

$(BIN): $(OBJS)
	$(CC) -o $@ -Wl,--whole-archive $(OBJS) $(LDFLAGS) -Wl,--no-whole-archive -rdynamic

clean:
	@rm -fv $(BIN) $(LIB) $(OBJS)


