	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	_print_new_line                 ; -- Begin function print_new_line
	.p2align	2
_print_new_line:                        ; @print_new_line
	.cfi_startproc
; %bb.0:
Lloh0:
	adrp	x8, _newLine@PAGE
Lloh1:
	ldr	x0, [x8, _newLine@PAGEOFF]
	b	_printf
	.loh AdrpLdr	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.globl	_print_fibonacci_str            ; -- Begin function print_fibonacci_str
	.p2align	2
_print_fibonacci_str:                   ; @print_fibonacci_str
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh2:
	adrp	x8, _entry_str@PAGE
Lloh3:
	ldr	x0, [x8, _entry_str@PAGEOFF]
	bl	_printf
Lloh4:
	adrp	x8, _newLine@PAGE
Lloh5:
	ldr	x0, [x8, _newLine@PAGEOFF]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_printf
	.loh AdrpLdr	Lloh4, Lloh5
	.loh AdrpLdr	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	adrp	x21, _entry_str@PAGE
	ldr	x0, [x21, _entry_str@PAGEOFF]
	bl	_printf
	adrp	x19, _newLine@PAGE
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
	adrp	x20, _a@PAGE
	adrp	x22, _c@PAGE
	adrp	x23, _b@PAGE
	adrp	x24, _fib_counter@PAGE
	adrp	x25, _fib_target@PAGE
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x0, [x21, _entry_str@PAGEOFF]
	bl	_printf
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
	ldr	w8, [x20, _a@PAGEOFF]
	str	w8, [x22, _c@PAGEOFF]
	ldr	w9, [x23, _b@PAGEOFF]
	str	w9, [x20, _a@PAGEOFF]
	add	w8, w9, w8
	str	w8, [x23, _b@PAGEOFF]
	ldr	w8, [x24, _fib_counter@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x24, _fib_counter@PAGEOFF]
	ldr	w9, [x25, _fib_target@PAGEOFF]
	cmp	w8, w9
	b.ne	LBB2_1
; %bb.2:
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
Lloh6:
	adrp	x8, _done_str@PAGE
Lloh7:
	ldr	x0, [x8, _done_str@PAGEOFF]
	bl	_printf
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
	ldr	w8, [x20, _a@PAGEOFF]
	str	x8, [sp]
Lloh8:
	adrp	x0, l_.str.3@PAGE
Lloh9:
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	ldr	x0, [x19, _newLine@PAGEOFF]
	bl	_printf
	mov	w0, #0
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdr	Lloh6, Lloh7
	.cfi_endproc
                                        ; -- End function
	.globl	_a                              ; @a
.zerofill __DATA,__common,_a,4,2
	.globl	_c                              ; @c
.zerofill __DATA,__common,_c,4,2
	.section	__DATA,__data
	.globl	_b                              ; @b
	.p2align	2
_b:
	.long	1                               ; 0x1

	.globl	_fib_counter                    ; @fib_counter
.zerofill __DATA,__common,_fib_counter,4,2
	.globl	_fib_target                     ; @fib_target
	.p2align	2
_fib_target:
	.long	6                               ; 0x6

	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Fibonacci"

	.section	__DATA,__data
	.globl	_entry_str                      ; @entry_str
	.p2align	3
_entry_str:
	.quad	l_.str

	.globl	_entry_str_len                  ; @entry_str_len
	.p2align	2
_entry_str_len:
	.long	9                               ; 0x9

	.section	__TEXT,__cstring,cstring_literals
l_.str.1:                               ; @.str.1
	.asciz	"Done"

	.section	__DATA,__data
	.globl	_done_str                       ; @done_str
	.p2align	3
_done_str:
	.quad	l_.str.1

	.globl	_done_str_len                   ; @done_str_len
	.p2align	2
_done_str_len:
	.long	4                               ; 0x4

	.section	__TEXT,__cstring,cstring_literals
l_.str.2:                               ; @.str.2
	.asciz	"\n"

	.section	__DATA,__data
	.globl	_newLine                        ; @newLine
	.p2align	3
_newLine:
	.quad	l_.str.2

	.section	__TEXT,__cstring,cstring_literals
l_.str.3:                               ; @.str.3
	.asciz	"%d"

.subsections_via_symbols
