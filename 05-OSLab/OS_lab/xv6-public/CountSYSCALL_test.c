#include "types.h"
#include "user.h"
#include "stat.h"
#include "fcntl.h"


int main(int argc, char* argv[]){
	char* write_data = "Hi everyone. This is MMD.\n";
    int fd=open("file.txt",O_CREATE|O_WRONLY);
    for (int i = 0; i < 3; i++){
        int pid = fork();
        if (pid == 0){
			volatile long long int temp = 0;
            while ((open("lockfile", O_CREATE  | O_WRONLY)) < 0){
				temp ++ ;
			} // acquiring user
			write(fd,write_data,strlen(write_data));
			unlink("lockfile"); // releasing user
            exit();

        }
    }
    while (wait() != -1);
    close(fd);
    syscalls_count();
    exit();
}