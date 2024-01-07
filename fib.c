#include <stdio.h>
int a = 0;
int c = 0;
int b = 1;
int fib_counter = 0;
int fib_target = 5;
char *entry_str = "Fibonacci";
int entry_str_len = 9;
char *done_str = "Done";
int done_str_len = 4;
char *newLine = "\n";
void print_new_line()
{
    printf(newLine);
}
void print_fibonacci_str()
{
    printf(entry_str);
    print_new_line();
}
int main()
{
    print_fibonacci_str();
    print_new_line();
}