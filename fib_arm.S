	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	_print_new_line                 ; -- Begin function print_new_line
	.p2align	2
_print_new_line:                        ; @print_new_line
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _newLine@PAGE
	ldr	x0, [x8, _newLine@PAGEOFF]
	bl	_printf
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
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
	adrp	x8, _entry_str@PAGE
	ldr	x0, [x8, _entry_str@PAGEOFF]
	bl	_printf
	bl	_print_new_line
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	wzr, [x29, #-4]
	bl	_print_fibonacci_str
	bl	_print_new_line
	b	LBB2_1
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	bl	_print_fibonacci_str
	adrp	x11, _a@PAGE
	ldr	w9, [x11, _a@PAGEOFF]
	adrp	x8, _c@PAGE
	str	w9, [x8, _c@PAGEOFF]
	adrp	x9, _b@PAGE
	ldr	w10, [x9, _b@PAGEOFF]
	str	w10, [x11, _a@PAGEOFF]
	ldr	w8, [x8, _c@PAGEOFF]
	ldr	w10, [x9, _b@PAGEOFF]
	add	w8, w8, w10
	str	w8, [x9, _b@PAGEOFF]
	adrp	x8, _fib_counter@PAGE
	ldr	w9, [x8, _fib_counter@PAGEOFF]
	add	w9, w9, #1
	str	w9, [x8, _fib_counter@PAGEOFF]
	ldr	w8, [x8, _fib_counter@PAGEOFF]
	adrp	x9, _fib_target@PAGE
	ldr	w9, [x9, _fib_target@PAGEOFF]
	subs	w8, w8, w9
	cset	w8, ne
	tbnz	w8, #0, LBB2_3
	b	LBB2_2
LBB2_2:
	b	LBB2_4
LBB2_3:                                 ;   in Loop: Header=BB2_1 Depth=1
	b	LBB2_1
LBB2_4:
	bl	_print_new_line
	adrp	x8, _done_str@PAGE
	ldr	x0, [x8, _done_str@PAGEOFF]
	bl	_printf
	bl	_print_new_line
	adrp	x8, _a@PAGE
	ldr	w9, [x8, _a@PAGEOFF]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.3@PAGE
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	bl	_print_new_line
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
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
