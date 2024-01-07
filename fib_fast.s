	.file	"fib.c"
	.text
	.p2align 4
	.globl	print_new_line
	.type	print_new_line, @function
print_new_line:
.LFB11:
	.cfi_startproc
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	jmp	printf
	.cfi_endproc
.LFE11:
	.size	print_new_line, .-print_new_line
	.p2align 4
	.globl	print_fibonacci_str
	.type	print_fibonacci_str, @function
print_fibonacci_str:
.LFB12:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	entry_str(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	printf
	.cfi_endproc
.LFE12:
	.size	print_fibonacci_str, .-print_fibonacci_str
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB13:
	.cfi_startproc
	xorl	%eax, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	print_fibonacci_str
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	.p2align 4,,10
	.p2align 3
.L6:
	movq	entry_str(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movl	a(%rip), %eax
	movl	b(%rip), %edx
	movl	%eax, c(%rip)
	addl	%edx, %eax
	movl	%eax, b(%rip)
	movl	fib_counter(%rip), %eax
	movl	%edx, a(%rip)
	addl	$1, %eax
	cmpl	fib_target(%rip), %eax
	movl	%eax, fib_counter(%rip)
	jne	.L6
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movq	done_str(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	movl	a(%rip), %esi
	movl	$.LC0, %edi
	xorl	%eax, %eax
	call	printf
	movq	newLine(%rip), %rdi
	xorl	%eax, %eax
	call	printf
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.globl	newLine
	.section	.rodata.str1.1
.LC1:
	.string	"\n"
	.data
	.align 8
	.type	newLine, @object
	.size	newLine, 8
newLine:
	.quad	.LC1
	.globl	done_str_len
	.align 4
	.type	done_str_len, @object
	.size	done_str_len, 4
done_str_len:
	.long	4
	.globl	done_str
	.section	.rodata.str1.1
.LC2:
	.string	"Done"
	.data
	.align 8
	.type	done_str, @object
	.size	done_str, 8
done_str:
	.quad	.LC2
	.globl	entry_str_len
	.align 4
	.type	entry_str_len, @object
	.size	entry_str_len, 4
entry_str_len:
	.long	9
	.globl	entry_str
	.section	.rodata.str1.1
.LC3:
	.string	"Fibonacci"
	.data
	.align 8
	.type	entry_str, @object
	.size	entry_str, 8
entry_str:
	.quad	.LC3
	.globl	fib_target
	.align 4
	.type	fib_target, @object
	.size	fib_target, 4
fib_target:
	.long	6
	.globl	fib_counter
	.bss
	.align 4
	.type	fib_counter, @object
	.size	fib_counter, 4
fib_counter:
	.zero	4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1
	.globl	c
	.bss
	.align 4
	.type	c, @object
	.size	c, 4
c:
	.zero	4
	.globl	a
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.zero	4
	.ident	"GCC: (GNU) 13.2.1 20231205 (Red Hat 13.2.1-6)"
	.section	.note.GNU-stack,"",@progbits
