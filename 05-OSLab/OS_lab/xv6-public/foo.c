#include "types.h"
#include "user.h"

#define PROCS_NUM 5

int main()
{
    for (int i = 0; i < PROCS_NUM; ++i)
    {
        int pid = fork();
        if (pid == 0)
        {
            sleep(5000);
            for (int j = 0; j < 100000000000; ++j)
            {
                int x = 1;
                for (long k = 0; k < 10000000000000; ++k)
                    x++;
            }
            exit();
        }
    }
    for (int i = 0; i < PROCS_NUM; i++)
        wait();
    exit();
}