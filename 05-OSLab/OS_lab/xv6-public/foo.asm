
_foo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define PROCS_NUM 5

int main()
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	bb 05 00 00 00       	mov    $0x5,%ebx
  17:	51                   	push   %ecx
    for (int i = 0; i < PROCS_NUM; ++i)
    {
        int pid = fork();
  18:	e8 9e 02 00 00       	call   2bb <fork>
        if (pid == 0)
  1d:	85 c0                	test   %eax,%eax
  1f:	74 23                	je     44 <main+0x44>
    for (int i = 0; i < PROCS_NUM; ++i)
  21:	83 eb 01             	sub    $0x1,%ebx
  24:	75 f2                	jne    18 <main+0x18>
            }
            exit();
        }
    }
    for (int i = 0; i < PROCS_NUM; i++)
        wait();
  26:	e8 a0 02 00 00       	call   2cb <wait>
  2b:	e8 9b 02 00 00       	call   2cb <wait>
  30:	e8 96 02 00 00       	call   2cb <wait>
  35:	e8 91 02 00 00       	call   2cb <wait>
  3a:	e8 8c 02 00 00       	call   2cb <wait>
    exit();
  3f:	e8 7f 02 00 00       	call   2c3 <exit>
            sleep(5000);
  44:	83 ec 0c             	sub    $0xc,%esp
  47:	68 88 13 00 00       	push   $0x1388
  4c:	e8 02 03 00 00       	call   353 <sleep>
  51:	83 c4 10             	add    $0x10,%esp
                for (long k = 0; k < 10000000000000; ++k)
  54:	eb fe                	jmp    54 <main+0x54>
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  65:	31 c0                	xor    %eax,%eax
{
  67:	89 e5                	mov    %esp,%ebp
  69:	53                   	push   %ebx
  6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	89 c8                	mov    %ecx,%eax
  80:	5b                   	pop    %ebx
  81:	5d                   	pop    %ebp
  82:	c3                   	ret    
  83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	f3 0f 1e fb          	endbr32 
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	53                   	push   %ebx
  98:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9e:	0f b6 01             	movzbl (%ecx),%eax
  a1:	0f b6 1a             	movzbl (%edx),%ebx
  a4:	84 c0                	test   %al,%al
  a6:	75 19                	jne    c1 <strcmp+0x31>
  a8:	eb 26                	jmp    d0 <strcmp+0x40>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  b0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  b4:	83 c1 01             	add    $0x1,%ecx
  b7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  ba:	0f b6 1a             	movzbl (%edx),%ebx
  bd:	84 c0                	test   %al,%al
  bf:	74 0f                	je     d0 <strcmp+0x40>
  c1:	38 d8                	cmp    %bl,%al
  c3:	74 eb                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c5:	29 d8                	sub    %ebx,%eax
}
  c7:	5b                   	pop    %ebx
  c8:	5d                   	pop    %ebp
  c9:	c3                   	ret    
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	f3 0f 1e fb          	endbr32 
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ea:	80 3a 00             	cmpb   $0x0,(%edx)
  ed:	74 21                	je     110 <strlen+0x30>
  ef:	31 c0                	xor    %eax,%eax
  f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f8:	83 c0 01             	add    $0x1,%eax
  fb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  ff:	89 c1                	mov    %eax,%ecx
 101:	75 f5                	jne    f8 <strlen+0x18>
    ;
  return n;
}
 103:	89 c8                	mov    %ecx,%eax
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 110:	31 c9                	xor    %ecx,%ecx
}
 112:	5d                   	pop    %ebp
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret    
 116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	f3 0f 1e fb          	endbr32 
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	57                   	push   %edi
 128:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 12b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12e:	8b 45 0c             	mov    0xc(%ebp),%eax
 131:	89 d7                	mov    %edx,%edi
 133:	fc                   	cld    
 134:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 136:	89 d0                	mov    %edx,%eax
 138:	5f                   	pop    %edi
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
 13b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14e:	0f b6 10             	movzbl (%eax),%edx
 151:	84 d2                	test   %dl,%dl
 153:	75 16                	jne    16b <strchr+0x2b>
 155:	eb 21                	jmp    178 <strchr+0x38>
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax
 160:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 164:	83 c0 01             	add    $0x1,%eax
 167:	84 d2                	test   %dl,%dl
 169:	74 0d                	je     178 <strchr+0x38>
    if(*s == c)
 16b:	38 d1                	cmp    %dl,%cl
 16d:	75 f1                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
}
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 178:	31 c0                	xor    %eax,%eax
}
 17a:	5d                   	pop    %ebp
 17b:	c3                   	ret    
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 189:	31 f6                	xor    %esi,%esi
{
 18b:	53                   	push   %ebx
 18c:	89 f3                	mov    %esi,%ebx
 18e:	83 ec 1c             	sub    $0x1c,%esp
 191:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 194:	eb 33                	jmp    1c9 <gets+0x49>
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a0:	83 ec 04             	sub    $0x4,%esp
 1a3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1a6:	6a 01                	push   $0x1
 1a8:	50                   	push   %eax
 1a9:	6a 00                	push   $0x0
 1ab:	e8 2b 01 00 00       	call   2db <read>
    if(cc < 1)
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	85 c0                	test   %eax,%eax
 1b5:	7e 1c                	jle    1d3 <gets+0x53>
      break;
    buf[i++] = c;
 1b7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1bb:	83 c7 01             	add    $0x1,%edi
 1be:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c1:	3c 0a                	cmp    $0xa,%al
 1c3:	74 23                	je     1e8 <gets+0x68>
 1c5:	3c 0d                	cmp    $0xd,%al
 1c7:	74 1f                	je     1e8 <gets+0x68>
  for(i=0; i+1 < max; ){
 1c9:	83 c3 01             	add    $0x1,%ebx
 1cc:	89 fe                	mov    %edi,%esi
 1ce:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d1:	7c cd                	jl     1a0 <gets+0x20>
 1d3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1d8:	c6 03 00             	movb   $0x0,(%ebx)
}
 1db:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1de:	5b                   	pop    %ebx
 1df:	5e                   	pop    %esi
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e7:	90                   	nop
 1e8:	8b 75 08             	mov    0x8(%ebp),%esi
 1eb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ee:	01 de                	add    %ebx,%esi
 1f0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1f2:	c6 03 00             	movb   $0x0,(%ebx)
}
 1f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f8:	5b                   	pop    %ebx
 1f9:	5e                   	pop    %esi
 1fa:	5f                   	pop    %edi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	f3 0f 1e fb          	endbr32 
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	56                   	push   %esi
 208:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	6a 00                	push   $0x0
 20e:	ff 75 08             	pushl  0x8(%ebp)
 211:	e8 ed 00 00 00       	call   303 <open>
  if(fd < 0)
 216:	83 c4 10             	add    $0x10,%esp
 219:	85 c0                	test   %eax,%eax
 21b:	78 2b                	js     248 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 21d:	83 ec 08             	sub    $0x8,%esp
 220:	ff 75 0c             	pushl  0xc(%ebp)
 223:	89 c3                	mov    %eax,%ebx
 225:	50                   	push   %eax
 226:	e8 f0 00 00 00       	call   31b <fstat>
  close(fd);
 22b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22e:	89 c6                	mov    %eax,%esi
  close(fd);
 230:	e8 b6 00 00 00       	call   2eb <close>
  return r;
 235:	83 c4 10             	add    $0x10,%esp
}
 238:	8d 65 f8             	lea    -0x8(%ebp),%esp
 23b:	89 f0                	mov    %esi,%eax
 23d:	5b                   	pop    %ebx
 23e:	5e                   	pop    %esi
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret    
 241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 248:	be ff ff ff ff       	mov    $0xffffffff,%esi
 24d:	eb e9                	jmp    238 <stat+0x38>
 24f:	90                   	nop

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	53                   	push   %ebx
 258:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25b:	0f be 02             	movsbl (%edx),%eax
 25e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 261:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 264:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 269:	77 1a                	ja     285 <atoi+0x35>
 26b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop
    n = n*10 + *s++ - '0';
 270:	83 c2 01             	add    $0x1,%edx
 273:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 276:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 27a:	0f be 02             	movsbl (%edx),%eax
 27d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	89 c8                	mov    %ecx,%eax
 287:	5b                   	pop    %ebx
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	8b 45 10             	mov    0x10(%ebp),%eax
 29b:	8b 55 08             	mov    0x8(%ebp),%edx
 29e:	56                   	push   %esi
 29f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a2:	85 c0                	test   %eax,%eax
 2a4:	7e 0f                	jle    2b5 <memmove+0x25>
 2a6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a8:	89 d7                	mov    %edx,%edi
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
  return vdst;
}
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret    

000002bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bb:	b8 01 00 00 00       	mov    $0x1,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exit>:
SYSCALL(exit)
 2c3:	b8 02 00 00 00       	mov    $0x2,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <wait>:
SYSCALL(wait)
 2cb:	b8 03 00 00 00       	mov    $0x3,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <pipe>:
SYSCALL(pipe)
 2d3:	b8 04 00 00 00       	mov    $0x4,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <read>:
SYSCALL(read)
 2db:	b8 05 00 00 00       	mov    $0x5,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <write>:
SYSCALL(write)
 2e3:	b8 10 00 00 00       	mov    $0x10,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <close>:
SYSCALL(close)
 2eb:	b8 15 00 00 00       	mov    $0x15,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <kill>:
SYSCALL(kill)
 2f3:	b8 06 00 00 00       	mov    $0x6,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <exec>:
SYSCALL(exec)
 2fb:	b8 07 00 00 00       	mov    $0x7,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <open>:
SYSCALL(open)
 303:	b8 0f 00 00 00       	mov    $0xf,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mknod>:
SYSCALL(mknod)
 30b:	b8 11 00 00 00       	mov    $0x11,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <unlink>:
SYSCALL(unlink)
 313:	b8 12 00 00 00       	mov    $0x12,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <fstat>:
SYSCALL(fstat)
 31b:	b8 08 00 00 00       	mov    $0x8,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <link>:
SYSCALL(link)
 323:	b8 13 00 00 00       	mov    $0x13,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mkdir>:
SYSCALL(mkdir)
 32b:	b8 14 00 00 00       	mov    $0x14,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <chdir>:
SYSCALL(chdir)
 333:	b8 09 00 00 00       	mov    $0x9,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <dup>:
SYSCALL(dup)
 33b:	b8 0a 00 00 00       	mov    $0xa,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <getpid>:
SYSCALL(getpid)
 343:	b8 0b 00 00 00       	mov    $0xb,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sbrk>:
SYSCALL(sbrk)
 34b:	b8 0c 00 00 00       	mov    $0xc,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <sleep>:
SYSCALL(sleep)
 353:	b8 0d 00 00 00       	mov    $0xd,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <uptime>:
SYSCALL(uptime)
 35b:	b8 0e 00 00 00       	mov    $0xe,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <find_digital_root>:
SYSCALL(find_digital_root)
 363:	b8 16 00 00 00       	mov    $0x16,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <get_process_lifetime>:
SYSCALL(get_process_lifetime)
 36b:	b8 17 00 00 00       	mov    $0x17,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <copy_file>:
SYSCALL(copy_file)
 373:	b8 18 00 00 00       	mov    $0x18,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <get_uncle_count>:
SYSCALL(get_uncle_count)
 37b:	b8 19 00 00 00       	mov    $0x19,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <change_sched_Q>:
SYSCALL(change_sched_Q)
 383:	b8 1b 00 00 00       	mov    $0x1b,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <show_process_info>:
SYSCALL(show_process_info)
 38b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <set_proc_bjf_params>:
SYSCALL(set_proc_bjf_params)
 393:	b8 1d 00 00 00       	mov    $0x1d,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <set_system_bjf_params>:
SYSCALL(set_system_bjf_params)
 39b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <priorityLock_test>:
SYSCALL(priorityLock_test)
 3a3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <syscalls_count>:
SYSCALL(syscalls_count)
 3ab:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <shmget>:

SYSCALL(shmget)
 3b3:	b8 20 00 00 00       	mov    $0x20,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <shmat>:
SYSCALL(shmat)
 3bb:	b8 21 00 00 00       	mov    $0x21,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <shmdt>:
SYSCALL(shmdt)
 3c3:	b8 22 00 00 00       	mov    $0x22,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <shmctl>:
SYSCALL(shmctl)
 3cb:	b8 23 00 00 00       	mov    $0x23,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    
 3d3:	66 90                	xchg   %ax,%ax
 3d5:	66 90                	xchg   %ax,%ax
 3d7:	66 90                	xchg   %ax,%ax
 3d9:	66 90                	xchg   %ax,%ax
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
 3e9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ec:	89 d1                	mov    %edx,%ecx
{
 3ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3f1:	85 d2                	test   %edx,%edx
 3f3:	0f 89 7f 00 00 00    	jns    478 <printint+0x98>
 3f9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fd:	74 79                	je     478 <printint+0x98>
    neg = 1;
 3ff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 406:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 408:	31 db                	xor    %ebx,%ebx
 40a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 c8                	mov    %ecx,%eax
 412:	31 d2                	xor    %edx,%edx
 414:	89 cf                	mov    %ecx,%edi
 416:	f7 75 c4             	divl   -0x3c(%ebp)
 419:	0f b6 92 00 08 00 00 	movzbl 0x800(%edx),%edx
 420:	89 45 c0             	mov    %eax,-0x40(%ebp)
 423:	89 d8                	mov    %ebx,%eax
 425:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 428:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 42b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 42e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 431:	76 dd                	jbe    410 <printint+0x30>
  if(neg)
 433:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 436:	85 c9                	test   %ecx,%ecx
 438:	74 0c                	je     446 <printint+0x66>
    buf[i++] = '-';
 43a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 43f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 441:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 446:	8b 7d b8             	mov    -0x48(%ebp),%edi
 449:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 44d:	eb 07                	jmp    456 <printint+0x76>
 44f:	90                   	nop
 450:	0f b6 13             	movzbl (%ebx),%edx
 453:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 456:	83 ec 04             	sub    $0x4,%esp
 459:	88 55 d7             	mov    %dl,-0x29(%ebp)
 45c:	6a 01                	push   $0x1
 45e:	56                   	push   %esi
 45f:	57                   	push   %edi
 460:	e8 7e fe ff ff       	call   2e3 <write>
  while(--i >= 0)
 465:	83 c4 10             	add    $0x10,%esp
 468:	39 de                	cmp    %ebx,%esi
 46a:	75 e4                	jne    450 <printint+0x70>
    putc(fd, buf[i]);
}
 46c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46f:	5b                   	pop    %ebx
 470:	5e                   	pop    %esi
 471:	5f                   	pop    %edi
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 478:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 47f:	eb 87                	jmp    408 <printint+0x28>
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	f3 0f 1e fb          	endbr32 
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	57                   	push   %edi
 498:	56                   	push   %esi
 499:	53                   	push   %ebx
 49a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 49d:	8b 75 0c             	mov    0xc(%ebp),%esi
 4a0:	0f b6 1e             	movzbl (%esi),%ebx
 4a3:	84 db                	test   %bl,%bl
 4a5:	0f 84 b4 00 00 00    	je     55f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4ab:	8d 45 10             	lea    0x10(%ebp),%eax
 4ae:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4b1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4b4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4b6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b9:	eb 33                	jmp    4ee <printf+0x5e>
 4bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop
 4c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	74 17                	je     4e4 <printf+0x54>
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	ff 75 08             	pushl  0x8(%ebp)
 4d9:	e8 05 fe ff ff       	call   2e3 <write>
 4de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4e1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4e4:	0f b6 1e             	movzbl (%esi),%ebx
 4e7:	83 c6 01             	add    $0x1,%esi
 4ea:	84 db                	test   %bl,%bl
 4ec:	74 71                	je     55f <printf+0xcf>
    c = fmt[i] & 0xff;
 4ee:	0f be cb             	movsbl %bl,%ecx
 4f1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4f4:	85 d2                	test   %edx,%edx
 4f6:	74 c8                	je     4c0 <printf+0x30>
      }
    } else if(state == '%'){
 4f8:	83 fa 25             	cmp    $0x25,%edx
 4fb:	75 e7                	jne    4e4 <printf+0x54>
      if(c == 'd'){
 4fd:	83 f8 64             	cmp    $0x64,%eax
 500:	0f 84 9a 00 00 00    	je     5a0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 506:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 50c:	83 f9 70             	cmp    $0x70,%ecx
 50f:	74 5f                	je     570 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 511:	83 f8 73             	cmp    $0x73,%eax
 514:	0f 84 d6 00 00 00    	je     5f0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51a:	83 f8 63             	cmp    $0x63,%eax
 51d:	0f 84 8d 00 00 00    	je     5b0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 523:	83 f8 25             	cmp    $0x25,%eax
 526:	0f 84 b4 00 00 00    	je     5e0 <printf+0x150>
  write(fd, &c, 1);
 52c:	83 ec 04             	sub    $0x4,%esp
 52f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 a5 fd ff ff       	call   2e3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 53e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 541:	83 c4 0c             	add    $0xc,%esp
 544:	6a 01                	push   $0x1
 546:	83 c6 01             	add    $0x1,%esi
 549:	57                   	push   %edi
 54a:	ff 75 08             	pushl  0x8(%ebp)
 54d:	e8 91 fd ff ff       	call   2e3 <write>
  for(i = 0; fmt[i]; i++){
 552:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 556:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 559:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 55b:	84 db                	test   %bl,%bl
 55d:	75 8f                	jne    4ee <printf+0x5e>
    }
  }
}
 55f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret    
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	b9 10 00 00 00       	mov    $0x10,%ecx
 578:	6a 00                	push   $0x0
 57a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 57d:	8b 45 08             	mov    0x8(%ebp),%eax
 580:	8b 13                	mov    (%ebx),%edx
 582:	e8 59 fe ff ff       	call   3e0 <printint>
        ap++;
 587:	89 d8                	mov    %ebx,%eax
 589:	83 c4 10             	add    $0x10,%esp
      state = 0;
 58c:	31 d2                	xor    %edx,%edx
        ap++;
 58e:	83 c0 04             	add    $0x4,%eax
 591:	89 45 d0             	mov    %eax,-0x30(%ebp)
 594:	e9 4b ff ff ff       	jmp    4e4 <printf+0x54>
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5a8:	6a 01                	push   $0x1
 5aa:	eb ce                	jmp    57a <printf+0xea>
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5b6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5b8:	6a 01                	push   $0x1
        ap++;
 5ba:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5bd:	57                   	push   %edi
 5be:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5c1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5c4:	e8 1a fd ff ff       	call   2e3 <write>
        ap++;
 5c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cf:	31 d2                	xor    %edx,%edx
 5d1:	e9 0e ff ff ff       	jmp    4e4 <printf+0x54>
 5d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
 5e6:	e9 59 ff ff ff       	jmp    544 <printf+0xb4>
 5eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
        s = (char*)*ap;
 5f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5f5:	83 c0 04             	add    $0x4,%eax
 5f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5fb:	85 db                	test   %ebx,%ebx
 5fd:	74 17                	je     616 <printf+0x186>
        while(*s != 0){
 5ff:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 602:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 604:	84 c0                	test   %al,%al
 606:	0f 84 d8 fe ff ff    	je     4e4 <printf+0x54>
 60c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 60f:	89 de                	mov    %ebx,%esi
 611:	8b 5d 08             	mov    0x8(%ebp),%ebx
 614:	eb 1a                	jmp    630 <printf+0x1a0>
          s = "(null)";
 616:	bb f8 07 00 00       	mov    $0x7f8,%ebx
        while(*s != 0){
 61b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 61e:	b8 28 00 00 00       	mov    $0x28,%eax
 623:	89 de                	mov    %ebx,%esi
 625:	8b 5d 08             	mov    0x8(%ebp),%ebx
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop
  write(fd, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
          s++;
 633:	83 c6 01             	add    $0x1,%esi
 636:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 639:	6a 01                	push   $0x1
 63b:	57                   	push   %edi
 63c:	53                   	push   %ebx
 63d:	e8 a1 fc ff ff       	call   2e3 <write>
        while(*s != 0){
 642:	0f b6 06             	movzbl (%esi),%eax
 645:	83 c4 10             	add    $0x10,%esp
 648:	84 c0                	test   %al,%al
 64a:	75 e4                	jne    630 <printf+0x1a0>
 64c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 8e fe ff ff       	jmp    4e4 <printf+0x54>
 656:	66 90                	xchg   %ax,%ax
 658:	66 90                	xchg   %ax,%ax
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	f3 0f 1e fb          	endbr32 
 664:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 665:	a1 ac 0a 00 00       	mov    0xaac,%eax
{
 66a:	89 e5                	mov    %esp,%ebp
 66c:	57                   	push   %edi
 66d:	56                   	push   %esi
 66e:	53                   	push   %ebx
 66f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 672:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 674:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 677:	39 c8                	cmp    %ecx,%eax
 679:	73 15                	jae    690 <free+0x30>
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
 680:	39 d1                	cmp    %edx,%ecx
 682:	72 14                	jb     698 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	39 d0                	cmp    %edx,%eax
 686:	73 10                	jae    698 <free+0x38>
{
 688:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68a:	8b 10                	mov    (%eax),%edx
 68c:	39 c8                	cmp    %ecx,%eax
 68e:	72 f0                	jb     680 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	39 d0                	cmp    %edx,%eax
 692:	72 f4                	jb     688 <free+0x28>
 694:	39 d1                	cmp    %edx,%ecx
 696:	73 f0                	jae    688 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 698:	8b 73 fc             	mov    -0x4(%ebx),%esi
 69b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69e:	39 fa                	cmp    %edi,%edx
 6a0:	74 1e                	je     6c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6a2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6a5:	8b 50 04             	mov    0x4(%eax),%edx
 6a8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6ab:	39 f1                	cmp    %esi,%ecx
 6ad:	74 28                	je     6d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6af:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6b1:	5b                   	pop    %ebx
  freep = p;
 6b2:	a3 ac 0a 00 00       	mov    %eax,0xaac
}
 6b7:	5e                   	pop    %esi
 6b8:	5f                   	pop    %edi
 6b9:	5d                   	pop    %ebp
 6ba:	c3                   	ret    
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6c0:	03 72 04             	add    0x4(%edx),%esi
 6c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c6:	8b 10                	mov    (%eax),%edx
 6c8:	8b 12                	mov    (%edx),%edx
 6ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	75 d8                	jne    6af <free+0x4f>
    p->s.size += bp->s.size;
 6d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6da:	a3 ac 0a 00 00       	mov    %eax,0xaac
    p->s.size += bp->s.size;
 6df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6e5:	89 10                	mov    %edx,(%eax)
}
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret    
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	f3 0f 1e fb          	endbr32 
 6f4:	55                   	push   %ebp
 6f5:	89 e5                	mov    %esp,%ebp
 6f7:	57                   	push   %edi
 6f8:	56                   	push   %esi
 6f9:	53                   	push   %ebx
 6fa:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 700:	8b 3d ac 0a 00 00    	mov    0xaac,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 706:	8d 70 07             	lea    0x7(%eax),%esi
 709:	c1 ee 03             	shr    $0x3,%esi
 70c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 70f:	85 ff                	test   %edi,%edi
 711:	0f 84 a9 00 00 00    	je     7c0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 717:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 719:	8b 48 04             	mov    0x4(%eax),%ecx
 71c:	39 f1                	cmp    %esi,%ecx
 71e:	73 6d                	jae    78d <malloc+0x9d>
 720:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 726:	bb 00 10 00 00       	mov    $0x1000,%ebx
 72b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 72e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 735:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 738:	eb 17                	jmp    751 <malloc+0x61>
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 742:	8b 4a 04             	mov    0x4(%edx),%ecx
 745:	39 f1                	cmp    %esi,%ecx
 747:	73 4f                	jae    798 <malloc+0xa8>
 749:	8b 3d ac 0a 00 00    	mov    0xaac,%edi
 74f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 751:	39 c7                	cmp    %eax,%edi
 753:	75 eb                	jne    740 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 755:	83 ec 0c             	sub    $0xc,%esp
 758:	ff 75 e4             	pushl  -0x1c(%ebp)
 75b:	e8 eb fb ff ff       	call   34b <sbrk>
  if(p == (char*)-1)
 760:	83 c4 10             	add    $0x10,%esp
 763:	83 f8 ff             	cmp    $0xffffffff,%eax
 766:	74 1b                	je     783 <malloc+0x93>
  hp->s.size = nu;
 768:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 76b:	83 ec 0c             	sub    $0xc,%esp
 76e:	83 c0 08             	add    $0x8,%eax
 771:	50                   	push   %eax
 772:	e8 e9 fe ff ff       	call   660 <free>
  return freep;
 777:	a1 ac 0a 00 00       	mov    0xaac,%eax
      if((p = morecore(nunits)) == 0)
 77c:	83 c4 10             	add    $0x10,%esp
 77f:	85 c0                	test   %eax,%eax
 781:	75 bd                	jne    740 <malloc+0x50>
        return 0;
  }
}
 783:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 786:	31 c0                	xor    %eax,%eax
}
 788:	5b                   	pop    %ebx
 789:	5e                   	pop    %esi
 78a:	5f                   	pop    %edi
 78b:	5d                   	pop    %ebp
 78c:	c3                   	ret    
    if(p->s.size >= nunits){
 78d:	89 c2                	mov    %eax,%edx
 78f:	89 f8                	mov    %edi,%eax
 791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 798:	39 ce                	cmp    %ecx,%esi
 79a:	74 54                	je     7f0 <malloc+0x100>
        p->s.size -= nunits;
 79c:	29 f1                	sub    %esi,%ecx
 79e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7a1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7a4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7a7:	a3 ac 0a 00 00       	mov    %eax,0xaac
}
 7ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7af:	8d 42 08             	lea    0x8(%edx),%eax
}
 7b2:	5b                   	pop    %ebx
 7b3:	5e                   	pop    %esi
 7b4:	5f                   	pop    %edi
 7b5:	5d                   	pop    %ebp
 7b6:	c3                   	ret    
 7b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7be:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7c0:	c7 05 ac 0a 00 00 b0 	movl   $0xab0,0xaac
 7c7:	0a 00 00 
    base.s.size = 0;
 7ca:	bf b0 0a 00 00       	mov    $0xab0,%edi
    base.s.ptr = freep = prevp = &base;
 7cf:	c7 05 b0 0a 00 00 b0 	movl   $0xab0,0xab0
 7d6:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7db:	c7 05 b4 0a 00 00 00 	movl   $0x0,0xab4
 7e2:	00 00 00 
    if(p->s.size >= nunits){
 7e5:	e9 36 ff ff ff       	jmp    720 <malloc+0x30>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 0a                	mov    (%edx),%ecx
 7f2:	89 08                	mov    %ecx,(%eax)
 7f4:	eb b1                	jmp    7a7 <malloc+0xb7>
