
#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "priorityLock.h"

void acquirePriorityLock(struct PriorityLock *lock)
{
	acquire(&lock->lock);
	while(lock->is_lock){
		sleep(lock, &lock->lock);
	}
	lock->is_lock = 1;
	lock->pid = myproc()->pid;	
	release(&lock->lock);

}


void releasePriorityLock(struct PriorityLock *lock)
{
	acquire(&lock->lock);
	lock->is_lock = 0;
	lock->pid = 0;
	priority_wakeup(lock);
	release(&lock->lock);
}

void initPriorityLock(struct PriorityLock * lock){
	initlock(&lock->lock , "priority lock");
	lock->is_lock = 0;
	lock->pid = 0;

}

int
holdingPriorityLock(struct PriorityLock * lock)
{
	int ret = 0;
	acquire(&lock->lock);
	ret = (lock->pid == myproc()->pid)&& lock->is_lock;
	release(&lock->lock);
	return ret;
}