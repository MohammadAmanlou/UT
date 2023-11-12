#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
	int pid = fork();
	printf(1, "pid is %d \n", getpid());
	if(pid < 0){
	   printf(1, "Fork failed.\n");
	  }
	 else if(pid == 0){
		printf(1, "pid of child is %d \n", getpid());
	   sleep(1000);
	   exit();
	 }
	 else{
	   wait();
	   
	     int lifetime = get_process_lifetime();
	     if(lifetime >= 0){
	       printf(1, "child process lifetime: %d ticks\n", lifetime);
	     }
	     else{
	       printf(1, "error getting process lifetime.\n");
	   }

	 	int parent_lifetime = get_process_lifetime();
		printf(1 , "parent lifetime is %d \n", parent_lifetime );
	 }
	
	exit();
}
