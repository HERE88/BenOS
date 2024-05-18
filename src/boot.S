#include "mm.h"

.section ".text.boot"

.globl _start
_start:

	adr x0, my_test_data
	ldxr x5, [x0]

	ldr x1, [x0]

	adrp x2, my_test_data
	ldr x3, [x2]

	ldr x4, =my_test_data
	ldr x5, [x4]





	mrs	x0, mpidr_el1		
	and	x0, x0,#0xFF		// Check processor id
	cbz	x0, master		// Hang for all non-primary CPU
	b	proc_hang

proc_hang: 
	b 	proc_hang

master:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0
	bl 	memzero

	mov	sp, #LOW_MEMORY 
	bl	kernel_main
	b 	proc_hang		// should never come here

.align 3
.global my_test_data
my_test_data:
	.dword 0x12345678abcdefef

