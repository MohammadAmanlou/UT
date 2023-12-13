
_get_process_lifetime_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
	int pid = fork();
  13:	e8 03 03 00 00       	call   31b <fork>
  18:	89 c3                	mov    %eax,%ebx
	printf(1, "pid is %d \n", getpid());
  1a:	e8 84 03 00 00       	call   3a3 <getpid>
  1f:	83 ec 04             	sub    $0x4,%esp
  22:	50                   	push   %eax
  23:	68 28 08 00 00       	push   $0x828
  28:	6a 01                	push   $0x1
  2a:	e8 91 04 00 00       	call   4c0 <printf>
	if(pid < 0){
  2f:	83 c4 10             	add    $0x10,%esp
  32:	85 db                	test   %ebx,%ebx
  34:	78 60                	js     96 <main+0x96>
	   printf(1, "Fork failed.\n");
	  }
	 else if(pid == 0){
  36:	74 3a                	je     72 <main+0x72>
		printf(1, "pid of child is %d \n", getpid());
	   sleep(1000);
	   exit();
	 }
	 else{
	   wait();
  38:	e8 ee 02 00 00       	call   32b <wait>
	   
	     int lifetime = get_process_lifetime();
  3d:	e8 89 03 00 00       	call   3cb <get_process_lifetime>
	     if(lifetime >= 0){
  42:	85 c0                	test   %eax,%eax
  44:	78 63                	js     a9 <main+0xa9>
	       printf(1, "child process lifetime: %d ticks\n", lifetime);
  46:	53                   	push   %ebx
  47:	50                   	push   %eax
  48:	68 70 08 00 00       	push   $0x870
  4d:	6a 01                	push   $0x1
  4f:	e8 6c 04 00 00       	call   4c0 <printf>
  54:	83 c4 10             	add    $0x10,%esp
	     }
	     else{
	       printf(1, "error getting process lifetime.\n");
	   }

	 	int parent_lifetime = get_process_lifetime();
  57:	e8 6f 03 00 00       	call   3cb <get_process_lifetime>
		printf(1 , "parent lifetime is %d \n", parent_lifetime );
  5c:	52                   	push   %edx
  5d:	50                   	push   %eax
  5e:	68 57 08 00 00       	push   $0x857
  63:	6a 01                	push   $0x1
  65:	e8 56 04 00 00       	call   4c0 <printf>
  6a:	83 c4 10             	add    $0x10,%esp
	 }
	
	exit();
  6d:	e8 b1 02 00 00       	call   323 <exit>
		printf(1, "pid of child is %d \n", getpid());
  72:	e8 2c 03 00 00       	call   3a3 <getpid>
  77:	52                   	push   %edx
  78:	50                   	push   %eax
  79:	68 42 08 00 00       	push   $0x842
  7e:	6a 01                	push   $0x1
  80:	e8 3b 04 00 00       	call   4c0 <printf>
	   sleep(1000);
  85:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
  8c:	e8 22 03 00 00       	call   3b3 <sleep>
	   exit();
  91:	e8 8d 02 00 00       	call   323 <exit>
	   printf(1, "Fork failed.\n");
  96:	51                   	push   %ecx
  97:	51                   	push   %ecx
  98:	68 34 08 00 00       	push   $0x834
  9d:	6a 01                	push   $0x1
  9f:	e8 1c 04 00 00       	call   4c0 <printf>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	eb c4                	jmp    6d <main+0x6d>
	       printf(1, "error getting process lifetime.\n");
  a9:	51                   	push   %ecx
  aa:	51                   	push   %ecx
  ab:	68 94 08 00 00       	push   $0x894
  b0:	6a 01                	push   $0x1
  b2:	e8 09 04 00 00       	call   4c0 <printf>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	eb 9b                	jmp    57 <main+0x57>
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c5:	31 c0                	xor    %eax,%eax
{
  c7:	89 e5                	mov    %esp,%ebp
  c9:	53                   	push   %ebx
  ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  cd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	83 c0 01             	add    $0x1,%eax
  da:	84 d2                	test   %dl,%dl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
    ;
  return os;
}
  de:	89 c8                	mov    %ecx,%eax
  e0:	5b                   	pop    %ebx
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  fe:	0f b6 01             	movzbl (%ecx),%eax
 101:	0f b6 1a             	movzbl (%edx),%ebx
 104:	84 c0                	test   %al,%al
 106:	75 19                	jne    121 <strcmp+0x31>
 108:	eb 26                	jmp    130 <strcmp+0x40>
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 110:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 114:	83 c1 01             	add    $0x1,%ecx
 117:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 11a:	0f b6 1a             	movzbl (%edx),%ebx
 11d:	84 c0                	test   %al,%al
 11f:	74 0f                	je     130 <strcmp+0x40>
 121:	38 d8                	cmp    %bl,%al
 123:	74 eb                	je     110 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 125:	29 d8                	sub    %ebx,%eax
}
 127:	5b                   	pop    %ebx
 128:	5d                   	pop    %ebp
 129:	c3                   	ret    
 12a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 130:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 132:	29 d8                	sub    %ebx,%eax
}
 134:	5b                   	pop    %ebx
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13e:	66 90                	xchg   %ax,%ax

00000140 <strlen>:

uint
strlen(const char *s)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 14a:	80 3a 00             	cmpb   $0x0,(%edx)
 14d:	74 21                	je     170 <strlen+0x30>
 14f:	31 c0                	xor    %eax,%eax
 151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 158:	83 c0 01             	add    $0x1,%eax
 15b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 15f:	89 c1                	mov    %eax,%ecx
 161:	75 f5                	jne    158 <strlen+0x18>
    ;
  return n;
}
 163:	89 c8                	mov    %ecx,%eax
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 170:	31 c9                	xor    %ecx,%ecx
}
 172:	5d                   	pop    %ebp
 173:	89 c8                	mov    %ecx,%eax
 175:	c3                   	ret    
 176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17d:	8d 76 00             	lea    0x0(%esi),%esi

00000180 <memset>:

void*
memset(void *dst, int c, uint n)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 18e:	8b 45 0c             	mov    0xc(%ebp),%eax
 191:	89 d7                	mov    %edx,%edi
 193:	fc                   	cld    
 194:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 196:	89 d0                	mov    %edx,%eax
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ae:	0f b6 10             	movzbl (%eax),%edx
 1b1:	84 d2                	test   %dl,%dl
 1b3:	75 16                	jne    1cb <strchr+0x2b>
 1b5:	eb 21                	jmp    1d8 <strchr+0x38>
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax
 1c0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1c4:	83 c0 01             	add    $0x1,%eax
 1c7:	84 d2                	test   %dl,%dl
 1c9:	74 0d                	je     1d8 <strchr+0x38>
    if(*s == c)
 1cb:	38 d1                	cmp    %dl,%cl
 1cd:	75 f1                	jne    1c0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1d8:	31 c0                	xor    %eax,%eax
}
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	f3 0f 1e fb          	endbr32 
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	31 f6                	xor    %esi,%esi
{
 1eb:	53                   	push   %ebx
 1ec:	89 f3                	mov    %esi,%ebx
 1ee:	83 ec 1c             	sub    $0x1c,%esp
 1f1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1f4:	eb 33                	jmp    229 <gets+0x49>
 1f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	8d 45 e7             	lea    -0x19(%ebp),%eax
 206:	6a 01                	push   $0x1
 208:	50                   	push   %eax
 209:	6a 00                	push   $0x0
 20b:	e8 2b 01 00 00       	call   33b <read>
    if(cc < 1)
 210:	83 c4 10             	add    $0x10,%esp
 213:	85 c0                	test   %eax,%eax
 215:	7e 1c                	jle    233 <gets+0x53>
      break;
    buf[i++] = c;
 217:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 21b:	83 c7 01             	add    $0x1,%edi
 21e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 221:	3c 0a                	cmp    $0xa,%al
 223:	74 23                	je     248 <gets+0x68>
 225:	3c 0d                	cmp    $0xd,%al
 227:	74 1f                	je     248 <gets+0x68>
  for(i=0; i+1 < max; ){
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	89 fe                	mov    %edi,%esi
 22e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 231:	7c cd                	jl     200 <gets+0x20>
 233:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 235:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 238:	c6 03 00             	movb   $0x0,(%ebx)
}
 23b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23e:	5b                   	pop    %ebx
 23f:	5e                   	pop    %esi
 240:	5f                   	pop    %edi
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 247:	90                   	nop
 248:	8b 75 08             	mov    0x8(%ebp),%esi
 24b:	8b 45 08             	mov    0x8(%ebp),%eax
 24e:	01 de                	add    %ebx,%esi
 250:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 252:	c6 03 00             	movb   $0x0,(%ebx)
}
 255:	8d 65 f4             	lea    -0xc(%ebp),%esp
 258:	5b                   	pop    %ebx
 259:	5e                   	pop    %esi
 25a:	5f                   	pop    %edi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	56                   	push   %esi
 268:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	6a 00                	push   $0x0
 26e:	ff 75 08             	pushl  0x8(%ebp)
 271:	e8 ed 00 00 00       	call   363 <open>
  if(fd < 0)
 276:	83 c4 10             	add    $0x10,%esp
 279:	85 c0                	test   %eax,%eax
 27b:	78 2b                	js     2a8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 27d:	83 ec 08             	sub    $0x8,%esp
 280:	ff 75 0c             	pushl  0xc(%ebp)
 283:	89 c3                	mov    %eax,%ebx
 285:	50                   	push   %eax
 286:	e8 f0 00 00 00       	call   37b <fstat>
  close(fd);
 28b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 28e:	89 c6                	mov    %eax,%esi
  close(fd);
 290:	e8 b6 00 00 00       	call   34b <close>
  return r;
 295:	83 c4 10             	add    $0x10,%esp
}
 298:	8d 65 f8             	lea    -0x8(%ebp),%esp
 29b:	89 f0                	mov    %esi,%eax
 29d:	5b                   	pop    %ebx
 29e:	5e                   	pop    %esi
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2ad:	eb e9                	jmp    298 <stat+0x38>
 2af:	90                   	nop

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	53                   	push   %ebx
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bb:	0f be 02             	movsbl (%edx),%eax
 2be:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2c1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2c4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2c9:	77 1a                	ja     2e5 <atoi+0x35>
 2cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2cf:	90                   	nop
    n = n*10 + *s++ - '0';
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2da:	0f be 02             	movsbl (%edx),%eax
 2dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2e0:	80 fb 09             	cmp    $0x9,%bl
 2e3:	76 eb                	jbe    2d0 <atoi+0x20>
  return n;
}
 2e5:	89 c8                	mov    %ecx,%eax
 2e7:	5b                   	pop    %ebx
 2e8:	5d                   	pop    %ebp
 2e9:	c3                   	ret    
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	57                   	push   %edi
 2f8:	8b 45 10             	mov    0x10(%ebp),%eax
 2fb:	8b 55 08             	mov    0x8(%ebp),%edx
 2fe:	56                   	push   %esi
 2ff:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 302:	85 c0                	test   %eax,%eax
 304:	7e 0f                	jle    315 <memmove+0x25>
 306:	01 d0                	add    %edx,%eax
  dst = vdst;
 308:	89 d7                	mov    %edx,%edi
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 310:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 311:	39 f8                	cmp    %edi,%eax
 313:	75 fb                	jne    310 <memmove+0x20>
  return vdst;
}
 315:	5e                   	pop    %esi
 316:	89 d0                	mov    %edx,%eax
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    

0000031b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31b:	b8 01 00 00 00       	mov    $0x1,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <exit>:
SYSCALL(exit)
 323:	b8 02 00 00 00       	mov    $0x2,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <wait>:
SYSCALL(wait)
 32b:	b8 03 00 00 00       	mov    $0x3,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <pipe>:
SYSCALL(pipe)
 333:	b8 04 00 00 00       	mov    $0x4,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <read>:
SYSCALL(read)
 33b:	b8 05 00 00 00       	mov    $0x5,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <write>:
SYSCALL(write)
 343:	b8 10 00 00 00       	mov    $0x10,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <close>:
SYSCALL(close)
 34b:	b8 15 00 00 00       	mov    $0x15,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <kill>:
SYSCALL(kill)
 353:	b8 06 00 00 00       	mov    $0x6,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <exec>:
SYSCALL(exec)
 35b:	b8 07 00 00 00       	mov    $0x7,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <open>:
SYSCALL(open)
 363:	b8 0f 00 00 00       	mov    $0xf,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <mknod>:
SYSCALL(mknod)
 36b:	b8 11 00 00 00       	mov    $0x11,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <unlink>:
SYSCALL(unlink)
 373:	b8 12 00 00 00       	mov    $0x12,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <fstat>:
SYSCALL(fstat)
 37b:	b8 08 00 00 00       	mov    $0x8,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <link>:
SYSCALL(link)
 383:	b8 13 00 00 00       	mov    $0x13,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <mkdir>:
SYSCALL(mkdir)
 38b:	b8 14 00 00 00       	mov    $0x14,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <chdir>:
SYSCALL(chdir)
 393:	b8 09 00 00 00       	mov    $0x9,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <dup>:
SYSCALL(dup)
 39b:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <getpid>:
SYSCALL(getpid)
 3a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <sbrk>:
SYSCALL(sbrk)
 3ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <sleep>:
SYSCALL(sleep)
 3b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <uptime>:
SYSCALL(uptime)
 3bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <find_digital_root>:
SYSCALL(find_digital_root)
 3c3:	b8 16 00 00 00       	mov    $0x16,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <get_process_lifetime>:
SYSCALL(get_process_lifetime)
 3cb:	b8 17 00 00 00       	mov    $0x17,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <copy_file>:
SYSCALL(copy_file)
 3d3:	b8 18 00 00 00       	mov    $0x18,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <get_uncle_count>:
SYSCALL(get_uncle_count)
 3db:	b8 19 00 00 00       	mov    $0x19,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <change_sched_Q>:
SYSCALL(change_sched_Q)
 3e3:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <show_process_info>:
SYSCALL(show_process_info)
 3eb:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <set_proc_bjf_params>:
SYSCALL(set_proc_bjf_params)
 3f3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <set_system_bjf_params>:
SYSCALL(set_system_bjf_params)
 3fb:	b8 1c 00 00 00       	mov    $0x1c,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    
 403:	66 90                	xchg   %ax,%ax
 405:	66 90                	xchg   %ax,%ax
 407:	66 90                	xchg   %ax,%ax
 409:	66 90                	xchg   %ax,%ax
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
 419:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41c:	89 d1                	mov    %edx,%ecx
{
 41e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 421:	85 d2                	test   %edx,%edx
 423:	0f 89 7f 00 00 00    	jns    4a8 <printint+0x98>
 429:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 42d:	74 79                	je     4a8 <printint+0x98>
    neg = 1;
 42f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 436:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 438:	31 db                	xor    %ebx,%ebx
 43a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 cf                	mov    %ecx,%edi
 446:	f7 75 c4             	divl   -0x3c(%ebp)
 449:	0f b6 92 bc 08 00 00 	movzbl 0x8bc(%edx),%edx
 450:	89 45 c0             	mov    %eax,-0x40(%ebp)
 453:	89 d8                	mov    %ebx,%eax
 455:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 458:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 45b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 45e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 461:	76 dd                	jbe    440 <printint+0x30>
  if(neg)
 463:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 466:	85 c9                	test   %ecx,%ecx
 468:	74 0c                	je     476 <printint+0x66>
    buf[i++] = '-';
 46a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 46f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 471:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 476:	8b 7d b8             	mov    -0x48(%ebp),%edi
 479:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 47d:	eb 07                	jmp    486 <printint+0x76>
 47f:	90                   	nop
 480:	0f b6 13             	movzbl (%ebx),%edx
 483:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 486:	83 ec 04             	sub    $0x4,%esp
 489:	88 55 d7             	mov    %dl,-0x29(%ebp)
 48c:	6a 01                	push   $0x1
 48e:	56                   	push   %esi
 48f:	57                   	push   %edi
 490:	e8 ae fe ff ff       	call   343 <write>
  while(--i >= 0)
 495:	83 c4 10             	add    $0x10,%esp
 498:	39 de                	cmp    %ebx,%esi
 49a:	75 e4                	jne    480 <printint+0x70>
    putc(fd, buf[i]);
}
 49c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4af:	eb 87                	jmp    438 <printint+0x28>
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4c0:	f3 0f 1e fb          	endbr32 
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	57                   	push   %edi
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
 4ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 4d0:	0f b6 1e             	movzbl (%esi),%ebx
 4d3:	84 db                	test   %bl,%bl
 4d5:	0f 84 b4 00 00 00    	je     58f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4db:	8d 45 10             	lea    0x10(%ebp),%eax
 4de:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4e4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4e6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e9:	eb 33                	jmp    51e <printf+0x5e>
 4eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop
 4f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	74 17                	je     514 <printf+0x54>
  write(fd, &c, 1);
 4fd:	83 ec 04             	sub    $0x4,%esp
 500:	88 5d e7             	mov    %bl,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	57                   	push   %edi
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 35 fe ff ff       	call   343 <write>
 50e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 511:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 514:	0f b6 1e             	movzbl (%esi),%ebx
 517:	83 c6 01             	add    $0x1,%esi
 51a:	84 db                	test   %bl,%bl
 51c:	74 71                	je     58f <printf+0xcf>
    c = fmt[i] & 0xff;
 51e:	0f be cb             	movsbl %bl,%ecx
 521:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 524:	85 d2                	test   %edx,%edx
 526:	74 c8                	je     4f0 <printf+0x30>
      }
    } else if(state == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	75 e7                	jne    514 <printf+0x54>
      if(c == 'd'){
 52d:	83 f8 64             	cmp    $0x64,%eax
 530:	0f 84 9a 00 00 00    	je     5d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 536:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 53c:	83 f9 70             	cmp    $0x70,%ecx
 53f:	74 5f                	je     5a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 541:	83 f8 73             	cmp    $0x73,%eax
 544:	0f 84 d6 00 00 00    	je     620 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54a:	83 f8 63             	cmp    $0x63,%eax
 54d:	0f 84 8d 00 00 00    	je     5e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 553:	83 f8 25             	cmp    $0x25,%eax
 556:	0f 84 b4 00 00 00    	je     610 <printf+0x150>
  write(fd, &c, 1);
 55c:	83 ec 04             	sub    $0x4,%esp
 55f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	57                   	push   %edi
 566:	ff 75 08             	pushl  0x8(%ebp)
 569:	e8 d5 fd ff ff       	call   343 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 56e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 571:	83 c4 0c             	add    $0xc,%esp
 574:	6a 01                	push   $0x1
 576:	83 c6 01             	add    $0x1,%esi
 579:	57                   	push   %edi
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 c1 fd ff ff       	call   343 <write>
  for(i = 0; fmt[i]; i++){
 582:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 586:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 589:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 58b:	84 db                	test   %bl,%bl
 58d:	75 8f                	jne    51e <printf+0x5e>
    }
  }
}
 58f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 592:	5b                   	pop    %ebx
 593:	5e                   	pop    %esi
 594:	5f                   	pop    %edi
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a8:	6a 00                	push   $0x0
 5aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	8b 13                	mov    (%ebx),%edx
 5b2:	e8 59 fe ff ff       	call   410 <printint>
        ap++;
 5b7:	89 d8                	mov    %ebx,%eax
 5b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bc:	31 d2                	xor    %edx,%edx
        ap++;
 5be:	83 c0 04             	add    $0x4,%eax
 5c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c4:	e9 4b ff ff ff       	jmp    514 <printf+0x54>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	eb ce                	jmp    5aa <printf+0xea>
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
        ap++;
 5ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5ed:	57                   	push   %edi
 5ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f4:	e8 4a fd ff ff       	call   343 <write>
        ap++;
 5f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 0e ff ff ff       	jmp    514 <printf+0x54>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 610:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
 616:	e9 59 ff ff ff       	jmp    574 <printf+0xb4>
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 18                	mov    (%eax),%ebx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 db                	test   %ebx,%ebx
 62d:	74 17                	je     646 <printf+0x186>
        while(*s != 0){
 62f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 632:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 634:	84 c0                	test   %al,%al
 636:	0f 84 d8 fe ff ff    	je     514 <printf+0x54>
 63c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63f:	89 de                	mov    %ebx,%esi
 641:	8b 5d 08             	mov    0x8(%ebp),%ebx
 644:	eb 1a                	jmp    660 <printf+0x1a0>
          s = "(null)";
 646:	bb b5 08 00 00       	mov    $0x8b5,%ebx
        while(*s != 0){
 64b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64e:	b8 28 00 00 00       	mov    $0x28,%eax
 653:	89 de                	mov    %ebx,%esi
 655:	8b 5d 08             	mov    0x8(%ebp),%ebx
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
          s++;
 663:	83 c6 01             	add    $0x1,%esi
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	57                   	push   %edi
 66c:	53                   	push   %ebx
 66d:	e8 d1 fc ff ff       	call   343 <write>
        while(*s != 0){
 672:	0f b6 06             	movzbl (%esi),%eax
 675:	83 c4 10             	add    $0x10,%esp
 678:	84 c0                	test   %al,%al
 67a:	75 e4                	jne    660 <printf+0x1a0>
 67c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 8e fe ff ff       	jmp    514 <printf+0x54>
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	f3 0f 1e fb          	endbr32 
 694:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 695:	a1 68 0b 00 00       	mov    0xb68,%eax
{
 69a:	89 e5                	mov    %esp,%ebp
 69c:	57                   	push   %edi
 69d:	56                   	push   %esi
 69e:	53                   	push   %ebx
 69f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6a4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a7:	39 c8                	cmp    %ecx,%eax
 6a9:	73 15                	jae    6c0 <free+0x30>
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
 6b0:	39 d1                	cmp    %edx,%ecx
 6b2:	72 14                	jb     6c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 d0                	cmp    %edx,%eax
 6b6:	73 10                	jae    6c8 <free+0x38>
{
 6b8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	39 c8                	cmp    %ecx,%eax
 6be:	72 f0                	jb     6b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 d0                	cmp    %edx,%eax
 6c2:	72 f4                	jb     6b8 <free+0x28>
 6c4:	39 d1                	cmp    %edx,%ecx
 6c6:	73 f0                	jae    6b8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 fa                	cmp    %edi,%edx
 6d0:	74 1e                	je     6f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 28                	je     707 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6df:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6e1:	5b                   	pop    %ebx
  freep = p;
 6e2:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 72 04             	add    0x4(%edx),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 d8                	jne    6df <free+0x4f>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 70a:	a3 68 0b 00 00       	mov    %eax,0xb68
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	5d                   	pop    %ebp
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	f3 0f 1e fb          	endbr32 
 724:	55                   	push   %ebp
 725:	89 e5                	mov    %esp,%ebp
 727:	57                   	push   %edi
 728:	56                   	push   %esi
 729:	53                   	push   %ebx
 72a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 730:	8b 3d 68 0b 00 00    	mov    0xb68,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 736:	8d 70 07             	lea    0x7(%eax),%esi
 739:	c1 ee 03             	shr    $0x3,%esi
 73c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 73f:	85 ff                	test   %edi,%edi
 741:	0f 84 a9 00 00 00    	je     7f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 747:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 749:	8b 48 04             	mov    0x4(%eax),%ecx
 74c:	39 f1                	cmp    %esi,%ecx
 74e:	73 6d                	jae    7bd <malloc+0x9d>
 750:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 756:	bb 00 10 00 00       	mov    $0x1000,%ebx
 75b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 75e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 765:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 768:	eb 17                	jmp    781 <malloc+0x61>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 772:	8b 4a 04             	mov    0x4(%edx),%ecx
 775:	39 f1                	cmp    %esi,%ecx
 777:	73 4f                	jae    7c8 <malloc+0xa8>
 779:	8b 3d 68 0b 00 00    	mov    0xb68,%edi
 77f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 781:	39 c7                	cmp    %eax,%edi
 783:	75 eb                	jne    770 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 785:	83 ec 0c             	sub    $0xc,%esp
 788:	ff 75 e4             	pushl  -0x1c(%ebp)
 78b:	e8 1b fc ff ff       	call   3ab <sbrk>
  if(p == (char*)-1)
 790:	83 c4 10             	add    $0x10,%esp
 793:	83 f8 ff             	cmp    $0xffffffff,%eax
 796:	74 1b                	je     7b3 <malloc+0x93>
  hp->s.size = nu;
 798:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	83 c0 08             	add    $0x8,%eax
 7a1:	50                   	push   %eax
 7a2:	e8 e9 fe ff ff       	call   690 <free>
  return freep;
 7a7:	a1 68 0b 00 00       	mov    0xb68,%eax
      if((p = morecore(nunits)) == 0)
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	85 c0                	test   %eax,%eax
 7b1:	75 bd                	jne    770 <malloc+0x50>
        return 0;
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b6:	31 c0                	xor    %eax,%eax
}
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret    
    if(p->s.size >= nunits){
 7bd:	89 c2                	mov    %eax,%edx
 7bf:	89 f8                	mov    %edi,%eax
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7c8:	39 ce                	cmp    %ecx,%esi
 7ca:	74 54                	je     820 <malloc+0x100>
        p->s.size -= nunits;
 7cc:	29 f1                	sub    %esi,%ecx
 7ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7d7:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7df:	8d 42 08             	lea    0x8(%edx),%eax
}
 7e2:	5b                   	pop    %ebx
 7e3:	5e                   	pop    %esi
 7e4:	5f                   	pop    %edi
 7e5:	5d                   	pop    %ebp
 7e6:	c3                   	ret    
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 68 0b 00 00 6c 	movl   $0xb6c,0xb68
 7f7:	0b 00 00 
    base.s.size = 0;
 7fa:	bf 6c 0b 00 00       	mov    $0xb6c,%edi
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 6c 0b 00 00 6c 	movl   $0xb6c,0xb6c
 806:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 80b:	c7 05 70 0b 00 00 00 	movl   $0x0,0xb70
 812:	00 00 00 
    if(p->s.size >= nunits){
 815:	e9 36 ff ff ff       	jmp    750 <malloc+0x30>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 820:	8b 0a                	mov    (%edx),%ecx
 822:	89 08                	mov    %ecx,(%eax)
 824:	eb b1                	jmp    7d7 <malloc+0xb7>
