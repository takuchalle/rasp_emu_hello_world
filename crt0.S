	.text
	.code 32
	.global _start

_start:
	ldr	r0, =0x000000d3
	msr	cpsr, r0
	ldr	sp, =0x06400000

	ldr	r1,	=_bss_start
	ldr	r2,	=_bss_end
	mov	r3,	#0x00
_clear_bss:
	cmp	r1,r2
	strne 	r3,[r1],#+4
	bne 	_clear_bss
	
	bl	main

	// infinit loop
	b	.

