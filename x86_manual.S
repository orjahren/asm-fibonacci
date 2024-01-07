# Run cmd:
# as x86_manual.S -o fib.o && ld fib.o -o fib && ./fib
# gcc -Wall -static -nostdlib x86_manual.S && ./a.out

# https://stackoverflow.com/a/45851398 , modified for 32-bit
// building with  gcc foo.S  will use CPP before GAS so we can use headers
#include <asm/unistd.h>    // This is a standard Linux / glibc header file
      // includes unistd_64.h or unistd_32.h depending on current mode
      // Contains only #define constants (no C prototypes) so we can include it from asm without syntax errors.

.p2align 4
.globl print_integer            #void print_uint64(uint64_t value)
print_uint64:
    lea   -1(%esp), %esi        # We use the 128B red-zone as a buffer to hold the string
                                # a 64-bit integer is at most 20 digits long in base 10, so it fits.

    movb  $'\n', (%esi)         # store the trailing newline byte.  (Right below the return address).
    # If you need a null-terminated string, leave an extra byte of room and store '\n\0'.  Or  push $'\n'

    mov    $10, %ecx            # same as  mov $10, %rcx  but 2 bytes shorter
    # note that newline (\n) has ASCII code 10, so we could actually have stored the newline with  movb %cl, (%rsi) to save code size.

    mov    %edi, %eax           # function arg arrives in RDI; we need it in RAX for div
.Ltoascii_digit:                # do{
    xor    %edx, %edx
    div    %ecx                  #  rax = rdx:rax / 10.  rdx = remainder

                                 # store digits in MSD-first printing order, working backwards from the end of the string
    add    $'0', %edx            # integer to ASCII.  %dl would work, too, since we know this is 0-9
    dec    %esi
    mov    %dl, (%esi)           # *--p = (value%10) + '0';

    test   %eax, %eax
    jnz  .Ltoascii_digit        # } while(value != 0)
    # If we used a loop-counter to print a fixed number of digits, we would get leading zeros
    # The do{}while() loop structure means the loop runs at least once, so we get "0\n" for input=0

    # Then print the whole string with one system call
    mov   $__NR_write, %eax     # call number from asm/unistd_64.h
    mov   $1, %edi              # fd=1
    # %rsi = start of the buffer
    mov   %esp, %edx
    sub   %esi, %edx            # length = one_past_end - start
    int $0x80                   # write(fd=1 /*rdi*/, buf /*rsi*/, length /*rdx*/); 64-bit ABI
    # rax = return value (or -errno)
    # rcx and r11 = garbage (destroyed by syscall/sysret)
    # all other registers = unmodified (saved/restored by the kernel)

    # we don't need to restore any registers, and we didn't modify RSP.
    ret
###

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
