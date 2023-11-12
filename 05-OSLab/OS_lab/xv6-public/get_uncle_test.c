//this is a comment
#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
	int c1, c2, c3;
	int grandchild;
	c1 = fork();
	if(c1 == 0){
		printf(1, "c1 forked. \n");
		sleep(100);
		grandchild = fork();
		if(grandchild == 0){
			printf(1,"grandparent forked\n");
			int pid = getpid();
			int uncles = get_uncle_count(pid);
			printf(1, "uncles of c1: %d\n", uncles);
			exit();
		}
		wait();
		exit();
	}

	c2 = fork();
	if(c2 == 0){
		printf(1, "c2 forked. \n");
		sleep(200);
		exit();
	}

	c3 = fork();
	if(c3 == 0){
		printf(1, "c3 forked. \n");
		sleep(300);
		exit();
	}
	wait();
	wait();
	wait();
	exit();
}
