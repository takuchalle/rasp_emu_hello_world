
QEMU = /usr/bin/qemu-system-arm
CC = /usr/bin/arm-linux-gnueabi-gcc
OBJCOPY = /usr/bin/arm-linux-gnueabi-objcopy
RM = /bin/rm

STARTUP = crt0.S

OBJS = $(STARTUP:.S=.o)

all: $(OBJS) 

.S.o: 
	$(CC) -mcpu=arm926ej-s -c -marm $< -o $@ 

.PHONY: clean

clean:
	$(RM) $(OBJS)
