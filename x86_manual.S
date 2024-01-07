# Run cmd:
# as x86_manual.S -o fib.o && ld fib.o -o fib && ./fib

.data
# init variables for fibonacci 
# (https://en.wikipedia.org/wiki/Fibonacci_number)
a: .long 0
b: .long 1
c: .long 0
fib_counter: .long 0
fib_target: .long 10
# Example from wikipedia,
# https://en.wikipedia.org/wiki/X86_assembly_language
str: .ascii "Fibonacci!\n" # define a string of text containing "Hello, world!" and then a new line.
str_len = . - str             # get the length of str by subtracting its address
newline: .ascii "\n" # define a string of text containing "Hello, world!" and then a new line.

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

_start:
        # Print enty message
        movl $4, %eax
        movl $1, %ebx
        movl $str, %ecx
        movl $str_len, %edx
        int $0x80

        call _print_new_line

        .loop:
        movl $a, c
        movl $b, a
        movl $c, b
        addl $c, b
        addl $1, fib_counter
        test $fib_counter, $fib_target
        jz .done
        ja .loop

        .done:
        call _print_new_line
        # Print nth fibonacci number
        movl $4, %eax
        movl $1, %ebx
        movl $a, %ecx
        movl $1, %edx
        int $0x80

        # exit
        movl $1, %eax
        movl $0, %ebx
        int $0x80
