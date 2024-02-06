#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(find_digital_root)
SYSCALL(get_process_lifetime)
SYSCALL(copy_file)
SYSCALL(get_uncle_count)
SYSCALL(change_sched_Q)
SYSCALL(show_process_info)
SYSCALL(set_proc_bjf_params)
SYSCALL(set_system_bjf_params)
SYSCALL(priorityLock_test)
SYSCALL(syscalls_count)

SYSCALL(shmget)
SYSCALL(shmat)
SYSCALL(shmdt)
SYSCALL(shmctl)

