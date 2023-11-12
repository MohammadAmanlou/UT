#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
  if(argc != 2)
    {
        if(argc < 2)
        printf(2, "Error: you didn't enter the number!\n");
        else if(argc > 2)
            printf(2, "Error: Too many arguments!\n");
    exit();
  }
    else
    {

    int last_ebx_value;
    int number = atoi(argv[1]);
    
    asm volatile(
      "movl %%ebx, %0;" // last_ebx_value = ebx
      "movl %1, %%ebx;" // ebx = number
      : "=r" (last_ebx_value)
      : "r"(number)
    );
    printf(1, "USER: find_digital_root() is called for n = %d\n" , number);
        int answer = find_digital_root();
    printf(1, "digital root of number %d is: %d\n" , number , answer);

    asm("movl %0, %%ebx"
             : 
             : "r"(last_ebx_value)
        );   
    }
    exit();
}