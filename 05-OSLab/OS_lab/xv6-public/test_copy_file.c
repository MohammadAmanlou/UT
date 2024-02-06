#include "types.h"
#include "stat.h"
#include "user.h"
#include "ipc.h"
#include "shm.h"
#include "memlayout.h"

#define SHM_KEY 1000
#define NUM_CHILD_PROCESSES 6

int main(int argc, char *argv[]) {
    int shmid = shmget(SHM_KEY, sizeof(int), 0);
    if (shmid < 0) {
        shmid = shmget(SHM_KEY, sizeof(int), 06 | IPC_CREAT);
        if (shmid < 0) {
            printf(1, "Failed to create shared memory segment\n");
            exit();
        }
        int *ptr = (int *)shmat(shmid, 0, 0);
        if ((int)ptr < 0) {
            printf(1, "Failed to attach shared memory segment\n");
            exit();
        }
        *ptr = 0;
        shmdt(ptr);
    }

    for (int i = 0; i < NUM_CHILD_PROCESSES; i++) {
        int pid = fork();
        if (pid < 0) {
            printf(1, "Fork failed\n");
            exit();
        } else if (pid == 0) {
            int childShmid = shmget(SHM_KEY, sizeof(int), 0);
            if (childShmid < 0) {
                printf(1, "Failed to get shared memory segment\n");
                exit();
            }
            int *childPtr = (int *)shmat(childShmid, 0, 0);
            if ((int)childPtr < 0) {
                printf(1, "Failed to attach shared memory segment\n");
                exit();
            }
            *childPtr = *childPtr + 1;
            shmdt(childPtr);
            exit();
        }
    }

    for (int i = 0; i < NUM_CHILD_PROCESSES; i++) {
        wait();
    }

    // Report the amount of memory
    int *parentPtr = (int *)shmat(shmid, 0, 0);
    if ((int)parentPtr < 0) {
        printf(1, "Failed to attach shared memory segment\n");
        exit();
    }
    printf(1, "Total amount of memory: %d\n", *parentPtr);
    shmdt(parentPtr);

    // Remove shared memory segment
    shmctl(shmid, IPC_RMID, 0);

    exit();
}
