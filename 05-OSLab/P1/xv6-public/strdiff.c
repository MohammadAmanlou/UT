#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if(argc != 3){
        printf(2, "Usage: strdiff <string1> <string2>\n");
        exit();
    }
    char *str1 = argv[1];
    char *str2 = argv[2];
    
    int i = 0;
    unlink("strdiff_result.txt");
    int fd = open("strdiff_result.txt", O_CREATE | O_RDWR);
    if(fd < 0){
        printf(2, "strdiff: cannot open/create strdiff_result.txt\n");
        exit();
    }
    while(str1[i] != '\0' && str2[i] != '\0'){
         if(str1[i] != str2[i]){
             //printf(1, "%d", (((int)str1[i]) < ((int)str2[i])));
             char diff[2];
             if(((int)str1[i]) < ((int)str2[i])){
                 diff[0] = '1';
             }
             else{
                 diff[0] = '0';
             }
             diff[1] = '\0';
             write(fd, diff, 1);
         }
         i++;
    }
    if(str2[i] != '\0'){
        while(str2[i] != '\0'){
            //printf(1, "%d" , 1);
            char diff[2];
            diff[0] = '1';
            diff[1] = '\0';
            write(fd, diff, 1);
            i++;
        }
    }
    else if(str1[i] != '\0'){
        while(str1[i] != '\0'){
            //printf(1, "%d", 0);
            char diff[2];
            diff[0] = '0';
            diff[1] = '\0';
            write(fd, diff, 1);
            i++;
        }
    }
    char diff[2];
    diff[0] = '\n';
    diff[1] = '\0';
    write(fd, diff, 1);
    close(fd);
    exit();
}
