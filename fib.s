	.file	"fib.c"
	.text
	.globl	a
	.bss
	.align 4
	.type	a, @object
	.size	a, 4
a:
	.zero	4
	.globl	c
	.align 4
	.type	c, @object
	.size	c, 4
c:
	.zero	4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1
	.globl	fib_counter
	.bss
	.align 4
	.type	fib_counter, @object
	.size	fib_counter, 4
fib_counter:
	.zero	4
	.globl	fib_target
	.data
	.align 4
	.type	fib_target, @object
	.size	fib_target, 4
fib_target:
	.long	5
	.globl	entry_str
	.section	.rodata
.LC0:
	.string	"Fibonacci"
	.data
	.align 8
	.type	entry_str, @object
	.size	entry_str, 8
entry_str:
	.quad	.LC0
	.globl	entry_str_len
	.align 4
	.type	entry_str_len, @object
	.size	entry_str_len, 4
entry_str_len:
	.long	9
	.globl	done_str
	.section	.rodata
.LC1:
	.string	"Done"
	.data
	.align 8
	.type	done_str, @object
	.size	done_str, 8
done_str:
	.quad	.LC1
	.globl	done_str_len
	.align 4
	.type	done_str_len, @object
	.size	done_str_len, 4
done_str_len:
	.long	4
	.globl	newLine
	.section	.rodata
.LC2:
	.string	"\n"
	.data
	.align 8
	.type	newLine, @object
	.size	newLine, 8
newLine:
	.quad	.LC2
	.text
	.globl	print_new_line
	.type	print_new_line, @function
print_new_line:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	newLine(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	print_new_line, .-print_new_line
	.globl	print_fibonacci_str
	.type	print_fibonacci_str, @function
print_fibonacci_str:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	entry_str(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	print_new_line
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	print_fibonacci_str, .-print_fibonacci_str
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	call	print_fibonacci_str
	movl	$0, %eax
	call	print_new_line
.L4:
	movl	$0, %eax
	call	print_fibonacci_str
	movl	a(%rip), %eax
	movl	%eax, c(%rip)
	movl	b(%rip), %eax
	movl	%eax, a(%rip)
	movl	c(%rip), %edx
	movl	b(%rip), %eax
	addl	%edx, %eax
	movl	%eax, b(%rip)
	movl	fib_counter(%rip), %eax
	addl	$1, %eax
	movl	%eax, fib_counter(%rip)
	movl	fib_counter(%rip), %edx
	movl	fib_target(%rip), %eax
	cmpl	%eax, %edx
	je	.L9
	jmp	.L4
.L9:
	nop
.L6:
	movl	$0, %eax
	call	print_new_line
	movq	done_str(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	print_new_line
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 13.2.1 20231205 (Red Hat 13.2.1-6)"
	.section	.note.GNU-stack,"",@progbits
