struct stat;
struct rtcdate;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int find_digital_root(void);
int get_process_lifetime(void);
int copy_file(const char*, const char*);
int get_uncle_count(int);
int change_sched_Q(int , int);
void show_process_info(void);
int set_proc_bjf_params(int, float, float, float,float);
int set_system_bjf_params(float, float, float,float);

// shared memory
int shmget(uint, uint, int);
int shmat(int, void*, int);
int shmdt(void*);
int shmctl(int, int, void*);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
void priorityLock_test(void);
void syscalls_count(void);