#define	SHM_RDONLY	010000	/* read-only access */
#define	SHM_RND		020000	/* round attach address to SHMLBA boundary */
#define	SHM_REMAP	040000	/* take-over region on attach */
#define	SHM_EXEC	0100000	/* execution access */

// flag for shmctl
#define SHM_STAT 13

#define	SHMLBA	(1 * PGSIZE) /* multiple of PGSIZE */

// read, write
#define READ_SHM 04
#define RW_SHM 06

struct ipc_perm {
  uint __key; // key supplied to shmget
  int mode; // READ - WRITE permissions. READ_SHM / RW_SHM
  // mode = 0, while init, i.e. no permissions set
};

struct shmid_ds {
  struct ipc_perm shm_perm;
  uint shm_segsz; // size of segment in bytes
  int shm_nattch; // current attaches
  int shm_cpid; // region's creator pid
  int shm_lpid; // last attach / detach
};