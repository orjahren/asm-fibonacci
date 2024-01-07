# Run cmd:
# as x86_manual.S -o fib.o && ld fib.o -o fib && ./fib

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
        call _print_fibonacci_str
        movl $a, c
        movl $b, a
        movl $c, b
        addl $a, b

        # increment fib counter
        #addl $1, fib_counter
        movl $fib_counter, %ebx   # Load the value of fib_counter into EBX register
        addl $1, %ebx            # Add immediate value 1 to the contents of EBX register
        movl %ebx, fib_counter   # Store the result back into fib_counter

        # compare with target
        movl $fib_counter, %eax
        movl $fib_target, %ebx
        cmp %eax, %ebx

        # If not equal, loop
        je .done
        ja .loop

        .done:
        call _print_new_line

        movl $4, %eax
        movl $1, %ebx
        movl $done_str, %ecx
        movl $done_str_len, %edx
        int $0x80

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
