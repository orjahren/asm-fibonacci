# Run cmd:
# as x86_manual.S -o hw.o && ld hw.o -hw && ./a.out

.data
# Example from wikipedia,
# https://en.wikipedia.org/wiki/X86_assembly_language
str: .ascii "Fibonacci!\n" # define a string of text containing "Hello, world!" and then a new line.
str_len = . - str             # get the length of str by subtracting its address
.text
.globl _start 
_start:
        movl $4, %eax
        movl $1, %ebx
        movl $str, %ecx
        movl $str_len, %edx
        int $0x80

        movl $1, %eax
        movl $0, %ebx
        int $0x80
