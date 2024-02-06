


struct PriorityLock{
	struct spinlock lock;
	uint is_lock;
	int pid;



};