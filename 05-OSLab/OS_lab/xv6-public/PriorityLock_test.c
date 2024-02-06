#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "stat.h"



int main(){
	for (int i = 0 ; i < 3 ; i ++){
		int pid = fork();
		if(pid == 0){
			priorityLock_test();
			exit();
		}
	}
	for(int i = 0 ; i < 3 ; i++){
		wait();
	}
	exit();
}