
QEMU = /usr/bin/qemu-system-arm
CC = /usr/bin/arm-linux-gnueabi-gcc
LD = /usr/bin/arm-linux-gnueabi-ld
OBJCOPY = /usr/bin/arm-linux-gnueabi-objcopy
OBJDUMP = /usr/bin/arm-linux-gnueabi-objdump
RM = /bin/rm -fr

PRJ_NAME = rasp_emu_hello_world
ELF = $(PRJ_NAME).elf
IMG = $(PRJ_NAME).img
DMP = $(PRJ_NAME).dmp
STARTUP = crt0.S

OBJS = $(STARTUP:.S=.o)

CFLAGS = -O2 -Wall -nostdinc -fno-builtin

all: $(IMG) $(DMP)

$(ELF): $(OBJS)
	$(LD) -static -nostdlib -T rasp_emu_hello_world.ld $^ -o $@

$(DMP): $(ELF)
	$(OBJDUMP) -D $^ > $@

.SUFFIXES: .elf .img

.elf.img: $(ELF)
	$(OBJCOPY) -O binary $< $@

.S.o: 
	$(CC) $(CFLAGS) -mcpu=arm926ej-s -c -marm $< -o $@ 

.PHONY: clean

clean:
	$(RM) $(OBJS) $(ELF) $(IMG)
