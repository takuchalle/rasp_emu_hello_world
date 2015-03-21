	.text
	.code 32
	.global _start

_start:
	ldr	r0, =0x000000d3
	msr	cpsr, r0
	ldr	sp, =0x06400000

//	bl	main
	bl	_clear_bss
	
	// infinit loop
	b	.

_clear_bss:
	mov	r0,	#0x00
	ldr	r1,	=_bss_start
	ldr	r2,	=_bss_end
_keeep_clearing:	
	str	r0,	[r1, #0x00]
	add	r1,	#0x04
	cmp	r1,	r2
	bne	_keep_clearing
	bx	lr
