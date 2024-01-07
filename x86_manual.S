# Run cmd:
# as x86_manual.S -o fib.o && ld fib.o -o fib && ./fib
# gcc -Wall -static -nostdlib x86_manual.S && ./a.out

.data
a: .long 0
b: .long 1
c: .long 0
fib_counter: .long 0
fib_target: .long 6
entry_str: .ascii "Fibonacci!"
entry_str_len = . - entry_str
done_str: .ascii "Done!"
done_str_len = . - done_str
newline: .ascii "\n"

.text
.globl _start 
# TODO: Should maintain registers? Caller/callee shenanigans?
_print_new_line:
        movl $4, %eax
        movl $1, %ebx
        movl $newline, %ecx
        movl $1, %edx
        int $0x80
        ret
_print_fibonacci_str:
        # Print enty message
        movl $4, %eax
        movl $1, %ebx
        movl $entry_str, %ecx
        movl $entry_str_len, %edx
        int $0x80
        call _print_new_line
        ret
_start:

        call _print_fibonacci_str
        call _print_new_line

        .loop:
        movl	$0, %eax
        call	_print_fibonacci_str
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
        je	.done
        jmp	.loop

        .done:
        call _print_new_line

        movl $4, %eax
        movl $1, %ebx
        movl $done_str, %ecx
        movl $done_str_len, %edx
        int $0x80

        call _print_new_line

        # Print nth fibonacci number
        addl $'0', a(%rip)
        movl $4, %eax
        movl $1, %ebx
        movl $a, %ecx
        movl $1, %edx
        int $0x80


        call _print_new_line

        # exit
        movl $1, %eax
        movl $0, %ebx
        int $0x80
