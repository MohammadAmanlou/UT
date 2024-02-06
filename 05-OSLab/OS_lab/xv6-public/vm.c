#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"

#include "shm.h"
#include "ipc.h"
#include "spinlock.h"

extern char data[];  // defined by kernel.ld
pde_t *kpgdir;  // for use in scheduler()

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
  struct cpu *c;

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
}

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}

// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
//
// setupkvm() and exec() set up every page table like this:
//
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.
static struct kmap {
  void *virt;
  uint phys_start;
  uint phys_end;
  int perm;
} kmap[] = {
 { (void*)KERNBASE, 0,             EXTMEM,    PTE_W}, // I/O space
 { (void*)KERNLINK, V2P(KERNLINK), V2P(data), 0},     // kern text+rodata
 { (void*)data,     V2P(data),     PHYSTOP,   PTE_W}, // kern data+memory
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *mem;
  uint a;

  if(newsz >= HEAPLIMIT) // prev value: KERBASE
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  // deallocuvm(pgdir, KERNBASE, 0);
  deallocuvm(pgdir, HEAPLIMIT, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
}

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
  *pte &= ~PTE_U;
}

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
      goto bad;
    }
  }
  return d;

bad:
  freevm(d);
  return 0;
}

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}

// ### Shared memory ### //

// structure of single shared memory region
struct shmRegion {
  uint key, size; // key = region key; size = number of pages, e.g. requested size = 4096 (PGSIZE), then size = 1
  int shmid;  // shmid
  int toBeDeleted;  // flag to check if the region is marked for deletion or not. 1 = marked for deletion, 0 = not marked (default)
  void *physicalAddr[SHAREDREGIONS];  // store V2P of pages
  struct shmid_ds buffer; // kernel shmid_ds data structure associated with a region
};

// shared memory table
struct shmTable {
  // lock for table
  struct spinlock lock;
  // total shared memory regions
  struct shmRegion allRegions[SHAREDREGIONS];
} shmTable;


/*
  Creates a shared memory region with given key,
  and size depending upon flag provided
*/
int
shmget(uint key, uint size, int shmflag) {
  // as Xv6 has only single user, else lower 9 bits would be considered
  int lowerBits = shmflag & 7, permission = -1;

  acquire(&shmTable.lock);
  
  // separate correct permissions and shmflag
  if(lowerBits == (int)READ_SHM) {
    permission = READ_SHM;
    shmflag ^= READ_SHM;
  }
  else if(lowerBits == (int)RW_SHM) {
    permission = RW_SHM;
    shmflag ^= RW_SHM;
  } else {
    if(!((shmflag == 0) && (key != IPC_PRIVATE))) {
      release(&shmTable.lock);
      return -1;
    }
  }
  // check for requested size
  if(size <= 0) {
    release(&shmTable.lock);
    return -1;
  }
  // calculate no of requested pages, from entered size
  int noOfPages = (size / PGSIZE) + 1;
  // check if no of pages is more than decided limit
  if(noOfPages > SHAREDREGIONS) {
    release(&shmTable.lock);
    return -1;
  }
  int index = -1;
  // check if key already exists
  for(int i = 0; i < SHAREDREGIONS; i++) {
    if(shmTable.allRegions[i].key == key) {
      // if wrong size is requested with existing region
      if(shmTable.allRegions[i].size != noOfPages) {
        release(&shmTable.lock);
        return -1;
      }
      // IPC_CREAT | IPC_EXCL, for region that exists
      if(shmflag == (IPC_CREAT | IPC_EXCL)) {
        release(&shmTable.lock);
        return -1;
      }
      // get region permissions
      int checkPerm = shmTable.allRegions[i].buffer.shm_perm.mode;
      if(checkPerm == READ_SHM || checkPerm == RW_SHM) {
        // condition for IPC_PRIVATE, with existing region
        if((shmflag == 0) && (key != IPC_PRIVATE)) {
          release(&shmTable.lock);
          return shmTable.allRegions[i].shmid;
        }
        if(shmflag == IPC_CREAT) {
          release(&shmTable.lock);
          return shmTable.allRegions[i].shmid;
        }
      }
      release(&shmTable.lock);
      return -1;
    }
  }
  // check for first valid shared memory region, that can be allocated
  for(int i = 0; i < SHAREDREGIONS; i++) {
    if(shmTable.allRegions[i].key == -1) {
      index = i;
      break;
    }
  }
  // memory regions are exhausted
  if(index == -1) {
    release(&shmTable.lock);
    return -1;
  }
  if((key == IPC_PRIVATE) || (shmflag == IPC_CREAT) || (shmflag == (IPC_CREAT | IPC_EXCL))) {
    // try to allocate requested size, rounded to page size
    for(int i = 0; i < noOfPages; i++) {
      char *newPage = kalloc();
      if(newPage == 0){
        cprintf("shmget: failed to allocate a page (out of memory)\n");
        release(&shmTable.lock);
        return -1;
      }
      // zero out
      memset(newPage, 0, PGSIZE);
      shmTable.allRegions[index].physicalAddr[i] = (void *)V2P(newPage);
    }
    // mark rest of the fields in structure
    shmTable.allRegions[index].size = noOfPages;
    shmTable.allRegions[index].key = key;

    // store data for shmid_ds data structure
    shmTable.allRegions[index].buffer.shm_segsz = size;
    shmTable.allRegions[index].buffer.shm_perm.__key = key;
    shmTable.allRegions[index].buffer.shm_perm.mode = permission;

    // store creator pid
    shmTable.allRegions[index].buffer.shm_cpid = myproc()->pid;
    
    // store shmid in not yet shared region
    shmTable.allRegions[index].shmid = index;

    release(&shmTable.lock);
    return index; // valid shmid
  } else {
    release(&shmTable.lock);
    return -1;
  }  
}

// finds the least starting address of a segment greater than curr_va which is attached 
// to the virtual address space of the current process. Returns the index from the pages  
// array corresponding to this address if found; -1 otherwise
int 
getLeastvaidx(void* curr_va, struct proc *process) {
  
  //maximum virtual address available in range
  void* leastva = (void*)(KERNBASE - 1);

  int idx = -1;
  for(int i = 0; i < SHAREDREGIONS; i++) {
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr >= (uint)curr_va && (uint)leastva >= (uint)process->pages[i].virtualAddr) {  
      // store address if greater than curr_va and smaller than the existing least_va.
      leastva = process->pages[i].virtualAddr;

      idx = i;
    }
  }  
  return idx;
}

// detaches the shared memory segment starting at shmaddr from virtual address space of the process
// returns 0 if successful and -1 in case of a failure
int 
shmdt(void* shmaddr) {
  acquire(&shmTable.lock);
  struct proc *process = myproc();
  void* va = (void*)0;
  uint size;
  int index,shmid;
  for(int i = 0; i < SHAREDREGIONS; i++) {
    // find the index from pages array which is attached at the provided shmaddr
    if(process->pages[i].key != -1 && process->pages[i].virtualAddr == shmaddr) {
        va =  process->pages[i].virtualAddr;
        index = i;
        shmid = process->pages[i].shmid;
        size = process->pages[index].size;
        break;
    }
  }
  if(va) {
    for(int i = 0; i < size; i++) {
      pte_t* pte = walkpgdir(process->pgdir, (void*)((uint)va + i*PGSIZE), 0);
      if(pte == 0) {
        release(&shmTable.lock);
        return -1;
      }
		  *pte = 0;
    }
    process->pages[index].shmid = -1;  
    process->pages[index].key = -1;
    process->pages[index].size =  0;
    process->pages[index].virtualAddr = (void*)0;
    if(shmTable.allRegions[shmid].buffer.shm_nattch > 0) {
      // decrement attaches
      shmTable.allRegions[shmid].buffer.shm_nattch -= 1;
    } 
    if(shmTable.allRegions[shmid].buffer.shm_nattch == 0 && shmTable.allRegions[shmid].toBeDeleted == 1) {
      // remove the segments
      for(int i = 0; i < shmTable.allRegions[index].size; i++) {
        char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
        kfree(addr);
        shmTable.allRegions[index].physicalAddr[i] = (void *)0;
      }
      shmTable.allRegions[index].size = 0;
      shmTable.allRegions[index].key = shmTable.allRegions[index].shmid = -1;
      shmTable.allRegions[index].toBeDeleted = 0;
      shmTable.allRegions[index].buffer.shm_nattch = 0;
      shmTable.allRegions[index].buffer.shm_segsz = 0;
      shmTable.allRegions[index].buffer.shm_perm.__key = -1;
      shmTable.allRegions[index].buffer.shm_perm.mode = 0;
      shmTable.allRegions[index].buffer.shm_cpid = -1;
      shmTable.allRegions[index].buffer.shm_lpid = -1;
    }
    shmTable.allRegions[shmid].buffer.shm_lpid = process->pid;
    release(&shmTable.lock);
    return 0;
  } else {
    release(&shmTable.lock);
    return -1;
  }
  
}

// attaches shared memory segment identified by shmid to the virtual address shmaddr 
// if provided; otherwise attach at the first fitting address 
void*
shmat(int shmid, void* shmaddr, int shmflag) {
  if(shmid < 0 || shmid > 64) {
    return (void*)-1;
  }
  acquire(&shmTable.lock);
  int index = -1,idx, permflag;
  uint segment,size = 0;
  void *va = (void*)HEAPLIMIT, *least_va;
  struct proc *process = myproc();
  index = shmTable.allRegions[shmid].shmid;
  if(index == -1) {
    // shmid not found
    release(&shmTable.lock);
    return (void*)-1;
  }
  if(shmaddr) {
    if((uint)shmaddr >= KERNBASE || (uint)shmaddr < HEAPLIMIT) {
      release(&shmTable.lock);
      return (void*)-1;
    }
    // round down to nearest multiple of SHMLBA
    uint rounded = ((uint)shmaddr & ~(SHMLBA-1));  

    if(shmflag & SHM_RND) {
      if(!rounded) {
        release(&shmTable.lock);
        return (void*)-1;
      }
      va = (void*)rounded;
    } else {

      // page aligned address
      if(rounded == (uint)shmaddr) {  
        va = shmaddr;    
      }
    }
      
  } else {    
    for(int i = 0; i < SHAREDREGIONS; i++) {
      idx = getLeastvaidx(va,process);
      if(idx != -1) {
        least_va = process->pages[idx].virtualAddr;
        if((uint)va + shmTable.allRegions[index].size*PGSIZE <=  (uint)least_va)        
          break;
        else
          va = (void*)((uint)least_va + process->pages[idx].size*PGSIZE);
      } else 
        break;
    }
  }
  if((uint)va + shmTable.allRegions[index].size*PGSIZE >= KERNBASE) {
    // size exceeded
    release(&shmTable.lock);
    return (void*)-1;
  }
  idx = -1;
  for(int i = 0; i < SHAREDREGIONS; i++) {
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr + process->pages[i].size*PGSIZE > (uint)va && (uint)va >= (uint)process->pages[i].virtualAddr)  {
      idx = i;
      break;
    }
  }
  if(idx != -1) {
    if(shmflag & SHM_REMAP) {
      segment = (uint)process->pages[idx].virtualAddr;
      // repeat till all conflicting mappings are removed
      while(segment < (uint)va + shmTable.allRegions[index].size*PGSIZE) { 
        size = process->pages[idx].size;
        release(&shmTable.lock);
        if(shmdt((void*)segment) == -1) {
          return (void*)-1;
        }
        acquire(&shmTable.lock);        
        idx = getLeastvaidx((void*)(segment + size*PGSIZE),process);
        if(idx == -1)
          break;
        segment = (uint)process->pages[idx].virtualAddr;
      }
    } else {
      release(&shmTable.lock);
      return (void*)-1;
    }

  }
  if((shmflag & SHM_RDONLY) || (shmTable.allRegions[index].buffer.shm_perm.mode == READ_SHM)){
    permflag = PTE_U;
  }
  else if (shmTable.allRegions[index].buffer.shm_perm.mode == RW_SHM) {
    permflag = PTE_W | PTE_U;
  } else {
    //permission mismatch between get and attach
    release(&shmTable.lock);
    return (void*)-1;
  }
  for (int k = 0; k < shmTable.allRegions[index].size; k++) {
		if(mappages(process->pgdir, (void*)((uint)va + (k*PGSIZE)), PGSIZE, (uint)shmTable.allRegions[index].physicalAddr[k], permflag) < 0) {
      deallocuvm(process->pgdir,(uint)va,(uint)(va + shmTable.allRegions[index].size));
      release(&shmTable.lock);
      return (void*)-1;
    }
	}
  idx = -1;
  for(int i = 0; i < SHAREDREGIONS; i++) {
    if(process->pages[i].key == -1) {
      idx = i;
      break;
    }
  }
  if(idx != -1) {
    process->pages[idx].shmid = shmid;  
    process->pages[idx].virtualAddr = va;
    process->pages[idx].key = shmTable.allRegions[index].key;
    process->pages[idx].size = shmTable.allRegions[index].size;
    process->pages[idx].perm = permflag;
    shmTable.allRegions[index].buffer.shm_nattch += 1;
    shmTable.allRegions[index].buffer.shm_lpid = process->pid;
  } else {
    release(&shmTable.lock);
    return (void*)-1; // all page regions exhausted
  }
  release(&shmTable.lock);
  return va;
}

/*
  Controls the shared memory regions corresponding to shmid,
  depending upon the cmd (command) provided and buf parameter,
  which is user equivalent of shmid_ds data structure
*/
int
shmctl(int shmid, int cmd, void *buf) {
  // check shmid bound
  if(shmid < 0 || shmid > 64){
    return -1;
  }

  acquire(&shmTable.lock);

  struct shmid_ds *buffer = (struct shmid_ds *)buf;

  int index = -1;
  index = shmTable.allRegions[shmid].shmid;
  // check for valid shmid
  if(index == -1) {
    release(&shmTable.lock);
    return -1;
  } else {
    // get permissions on region with provided shmid
    int checkPerm = shmTable.allRegions[index].buffer.shm_perm.mode;
    switch(cmd) {
      // handle IPC_SET flag, to set values from user data structure to kernel data structure
      case IPC_SET:
        if(buffer) {
          if((buffer->shm_perm.mode == READ_SHM) || (buffer->shm_perm.mode == RW_SHM)) {
            shmTable.allRegions[index].buffer.shm_perm.mode = buffer->shm_perm.mode;
            release(&shmTable.lock);
            return 0;
          } else {
            release(&shmTable.lock);
            return -1;
          }
        } else {
          release(&shmTable.lock);
          return -1;
        }
        break;
      /* 
        handle SHM_STAT and IPC_STAT flag,
        both will have same check on xv6 as there is only a single user
      */
      case SHM_STAT:
      case IPC_STAT:
        // check valid permissions
        if(buffer && (checkPerm == READ_SHM || checkPerm == RW_SHM)) {
          buffer->shm_nattch = shmTable.allRegions[index].buffer.shm_nattch;
          buffer->shm_segsz = shmTable.allRegions[index].buffer.shm_segsz;
          buffer->shm_perm.__key = shmTable.allRegions[index].buffer.shm_perm.__key;
          buffer->shm_perm.mode = checkPerm;
          buffer->shm_cpid = shmTable.allRegions[index].buffer.shm_cpid;
          buffer->shm_lpid = shmTable.allRegions[index].buffer.shm_lpid;
          release(&shmTable.lock);
          return 0;
        } else {
          release(&shmTable.lock);
          return -1;
        }
        break;
      // handle IPC_RMID flag, to remove shared memory region associated with give shmid
      case IPC_RMID:
        if(shmTable.allRegions[index].buffer.shm_nattch == 0) {
          for(int i = 0; i < shmTable.allRegions[index].size; i++) {
            char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
            kfree(addr);
            shmTable.allRegions[index].physicalAddr[i] = (void *)0;
          }
          // reinitialize other values to default values
          shmTable.allRegions[index].size = 0;
          shmTable.allRegions[index].key = shmTable.allRegions[index].shmid = -1;
          shmTable.allRegions[index].toBeDeleted = 0;
          shmTable.allRegions[index].buffer.shm_nattch = 0;
          shmTable.allRegions[index].buffer.shm_segsz = 0;
          shmTable.allRegions[index].buffer.shm_perm.__key = -1;
          shmTable.allRegions[index].buffer.shm_perm.mode = 0;
          shmTable.allRegions[index].buffer.shm_cpid = -1;
          shmTable.allRegions[index].buffer.shm_lpid = -1;
        } else {
          // mark the segment to be destroyed
          shmTable.allRegions[index].toBeDeleted = 1;
        }
        release(&shmTable.lock);
        return 0;
        break;
      // handle other cases
      default:
        release(&shmTable.lock);
        return -1;
        break;
    }
  } 
}

// to initialize shared memory table
void
sharedMemoryInit(void) {
  // initialize shmtable lock
  initlock(&shmTable.lock, "Shared Memory");
  acquire(&shmTable.lock);
  // initialize all shmtable values
  for(int i = 0; i < SHAREDREGIONS; i++) {
    shmTable.allRegions[i].key = shmTable.allRegions[i].shmid = -1;
    shmTable.allRegions[i].size = 0;
    shmTable.allRegions[i].toBeDeleted = 0;
    shmTable.allRegions[i].buffer.shm_nattch = 0;
    shmTable.allRegions[i].buffer.shm_segsz = 0;
    shmTable.allRegions[i].buffer.shm_perm.__key = -1;
    shmTable.allRegions[i].buffer.shm_perm.mode = 0;
    shmTable.allRegions[i].buffer.shm_cpid = -1;
    shmTable.allRegions[i].buffer.shm_lpid = -1;
    for(int j = 0; j < SHAREDREGIONS; j++) {
      shmTable.allRegions[i].physicalAddr[j] = (void *)0;
    }
  }
  release(&shmTable.lock);
}

// to return shmid index from shmtable
int
getShmidIndex(int shmid) {
  if(shmid < 0 || shmid > 64) {
    return -1;
  }
  return shmTable.allRegions[shmid].shmid;
}

void mappagesWrapper(struct proc *process, int shmIndex, int index) {
  for(int i = 0; i < process->pages[index].size; i++) {
    uint va = (uint)process->pages[index].virtualAddr;
    if(mappages(process->pgdir, (void*)(va + (i * PGSIZE)), PGSIZE, (uint)shmTable.allRegions[shmIndex].physicalAddr[i], process->pages[index].perm) < 0) {
      deallocuvm(process->pgdir, va, (uint)(va + shmTable.allRegions[shmIndex].size));
      return;
    }
  }
}

void shmdtWrapper(void *addr) {
  // call shmdt
  shmdt(addr);
}

//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.

