
QEMU = /usr/bin/qemu-system-arm
CC = /usr/bin/arm-linux-gnueabi-gcc
LD = /usr/bin/arm-linux-gnueabi-ld
OBJCOPY = /usr/bin/arm-linux-gnueabi-objcopy
OBJDUMP = /usr/bin/arm-linux-gnueabi-objdump
RM = /bin/rm -fr

# Comamnd and Option for QEMU #
QEMU = /usr/bin/qemu-system-arm
QEMU_MACHINE = versatilepb
QEMU_CPU = arm1176
QEMU_MEMORY = 256
QEMU_SERIAL = stdio
QEMU_OPT = -nographic -m $(QEMU_MEMORY) -M $(QEMU_MACHINE) -cpu $(QEMU_CPU) -serial $(QEMU_SERIAL)
PRJ_NAME = rasp_emu_hello_world
ELF = $(PRJ_NAME).elf
IMG = $(PRJ_NAME).img
DMP = $(PRJ_NAME).dmp

CSRCS = main.c uart.c
STARTUP = crt0.S

OBJS = $(STARTUP:.S=.o)
OBJS += $(CSRCS:.c=.o)

CFLAGS = -O2 -Wall -nostdinc -fno-builtin
INC = -Iinclude

all: $(IMG) $(DMP)

run: $(IMG)
	$(QEMU) $(QEMU_OPT) -kernel $^

$(ELF): $(OBJS)
	$(LD) -static -nostdlib -T rasp_emu_hello_world.ld $^ -o $@

$(DMP): $(ELF)
	$(OBJDUMP) -D $^ > $@

.SUFFIXES: .elf .img

.elf.img: $(ELF)
	$(OBJCOPY) -O binary $< $@

.S.o: 
	$(CC) $(CFLAGS) -mcpu=arm926ej-s -c -marm $< -o $@ 

.c.o: 
	$(CC) $(CFLAGS) $(INC) -mcpu=arm926ej-s -c -marm $< -o $@ 

.PHONY: clean

clean:
	$(RM) $(OBJS) $(ELF) $(IMG) $(DMP)
