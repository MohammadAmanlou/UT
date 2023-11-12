
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(int argc, char *argv[]) 
{
    

    if(argc != 3)
    {
        if(argc < 3)
        printf(2, "Error: you didn't enter 2 files!\n");
        else if(argc > 3)
            printf(2,"Error: Too many arguments!\n");
    exit();
    }

 
    int a = copy_file(argv[1],argv[2]);
	if (a== -1){
		printf(2,"Error: File already exists!\n");
	}
   
    exit();
} 