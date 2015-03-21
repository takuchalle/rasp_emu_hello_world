
QEMU = /usr/bin/qemu-system-arm
CC = /usr/bin/arm-linux-gnueabi-gcc
LD = /usr/bin/arm-linux-gnueabi-ld
OBJCOPY = /usr/bin/arm-linux-gnueabi-objcopy
RM = /bin/rm -fr

ELF = rasp_emu_hello_world.elf
IMG = rasp_emu_hello_world.img
STARTUP = crt0.S

OBJS = $(STARTUP:.S=.o)

CFLAGS = -O2 -Wall -nostdinc -fno-builtin

all: $(IMG)

$(ELF): $(OBJS)
	$(LD) -static -nostdlib -T rasp_emu_hello_world.ld $^ -o $@

.SUFFIXES: .elf .img

.elf.img: $(ELF)
	$(OBJCOPY) -O binary $< $@

.S.o: 
	$(CC) $(CFLAGS) -mcpu=arm926ej-s -c -marm $< -o $@ 

.PHONY: clean

clean:
	$(RM) $(OBJS)
