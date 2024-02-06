#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "fcntl.h"
#include "fs.h"
#include "spinlock.h"
//#include "file.h"
#include "sleeplock.h"
#include "stat.h"
#include "mp.h"



/*int sys_get_process_lifetime(void){
  int pid;
  
  if(argint(0, &pid) < 0)
    return -1;
  //cprintf("sysproc.h %d", pid);
  return get_process_lifetime(pid);
}*/

int sys_get_process_lifetime(void){
  return get_process_lifetime();
}

int sys_get_uncle_count(void){
  int pid;
  if(argint(0, &pid) < 0){
    return -1;
  }
  return get_uncle_count(pid);
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
int
sys_change_sched_Q(void)
{
  int queue_number, pid;
  if(argint(0, &pid) < 0 || argint(1, &queue_number) < 0)
    return -1;

  if(queue_number < ROUND_ROBIN || queue_number > BJF)
    return -1;

  return change_Q(pid, queue_number);
}

void sys_show_process_info(void) {
  show_process_info();
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_find_digital_root(void)
{
  int n = myproc()->tf->ebx;
  cprintf("KERNEL: sys_find_digital_root(%d)\n", n);
  return find_digital_root(n);

}


void
sys_priorityLock_test(void){
  priorityLock_test();
}


// int sys_copy_file(void) {
//   char* src_path
//   char* dst_path;
//   struct file* f_dst;
//   struct file* f_src;
//   struct inode* ip_dst;
//   struct inode* ip_src;

//   if (argstr(0, &src_path) < 0 || argstr(1, &dst_path) < 0)
//     return -1;
//   begin_op();
//   if ((ip_src = namei(src_path)) == 0) { // Check if source file exists
//     end_op();
//     return -1;
//   }
//   ilock(ip_src);
//   ip_dst = namei(dst_path);
//   if (ip_dst) { // Check if destination file already exists
//     // Release destination file's resources
//     iunlockput(ip_dst);
//     end_op();
//     return -1;
//   }
//   ilock(ip_dst);

//   // Open source and destination files
//   if ((f_src = filealloc()) == 0 || (f_dst = filealloc()) == 0) {
//     end_op();
//     return -1;
//   }
//   fileref(f_src);
//   fileref(f_dst);
//   f_src->type = FD_INODE;
//   f_dst->type = FD_INODE;
//   f_src->ip = ip_src;
//   f_dst->ip = create(dst_path, T_FILE, 0, 0); // Create destination file

//   // Copy file contents from source to destination
//   filecopy(f_src, f_dst);

//   // Unlock and release resources
//   iunlockput(ip_src);
//   iunlockput(f_dst->ip);
//   end_op();

//   return 0;
// }

int
sys_set_proc_bjf_params(void)
{
  int pid;
  float priority_ratio, arrival_time_ratio, executed_cycle_ratio, process_size_ratio;
  if(argint(0, &pid) < 0 ||
     argfloat(1, &priority_ratio) < 0 ||
     argfloat(2, &arrival_time_ratio) < 0 ||
     argfloat(3, &executed_cycle_ratio) < 0||
     argfloat(4, &process_size_ratio)<0 ){
    return -1;
  }

  return set_proc_bjf_params(pid, priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio);
}

int
sys_set_system_bjf_params(void)
{
  float priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio;
  if(argfloat(0, &priority_ratio) < 0 ||
     argfloat(1, &arrival_time_ratio) < 0 ||
     argfloat(2, &executed_cycle_ratio) < 0||
     argfloat(3,&process_size_ratio)<0){
    return -1;
  }

  set_system_bjf_params(priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio);
  return 0;
}

int sys_init_queue_test(void) {
  init_queue_test();
  return 0;
}

int sys_syscalls_count(void) {
  int total_syscalls_count = 0;
  for(int i = 0 ; i < ncpu ; ++i) {
    int syscalls_count = 0;
    syscalls_count += cpus[i].syscalls_count;
    total_syscalls_count += syscalls_count;
    cprintf("cpus[%d].syscalls_count = %d\n", i, syscalls_count);
  }
  cprintf("total_syscalls_count = %d\n", total_syscalls_count);
  cprintf("Shared syscalls count = %d\n", count_shared_syscalls);
  return total_syscalls_count;
}


// Shared memory

extern int shmget(uint, uint, int);
extern int shmdt(void*);
extern void * shmat(int, void*, int);
extern int shmctl(int, int, void*);

// system call handler for shmget
int
sys_shmget(void)
{
  int key, size, shmflag;
  // check for valid arguments
  if(argint(0, &key) < 0)
    return -1;
  if(argint(1, &size) < 0)
    return -1;
  if(argint(2, &shmflag) < 0)
    return -1;
  return shmget((uint)key, (uint)size, shmflag);
}

// system call handler for shmdt
int sys_shmdt(void)
{
  int i;
  // check for valid argument
  if(argint(0,&i)<0)
    return 0;
  return shmdt((void*)i);
}

// system call handler for shmat
void*
sys_shmat(void)
{
  int shmid, shmflag;
  int i;
  // check for valid arguments
  if(argint(0, &shmid) < 0)
    return (void*)0;
  if(argint(1,&i)<0)
    return (void*)0;
  if(argint(2, &shmflag) < 0)
    return (void*)0;
  return shmat(shmid, (void*)i, shmflag);
}

// system call handler for shmctl
int
sys_shmctl(void)
{
  int shmid, cmd, buf;
  // check for valid arguments
  if(argint(0, &shmid) < 0)
    return -1;
  if(argint(1, &cmd) < 0)
    return -1;
  if(argint(2, &buf) < 0)
    return -1;
  return shmctl(shmid, cmd, (void*)buf);
}