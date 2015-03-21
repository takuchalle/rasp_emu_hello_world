OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	/* Raspberry PI Start this Address */
	/* . = 0x0008000 */
	. = 0x0010000;

	_text_start = .;
	.text : {
	      *(.text*)
	}
	_text_end = .;
	. = ALIGN(4)

	_rodata_start = .;
	.rodata : {
	      *(.rodata*)
	}
	_rodata_end = .;
	. = ALIGN(4)

	_data_start = .;
	.data : {
	      *(.data*)
	}
	_data_end = .;
	. = ALIGN(4)

	_bss_start = .;
	.bss : {
	      *(.bss*)
	}
	_data_end = .;
	. = ALIGN(4)
}
