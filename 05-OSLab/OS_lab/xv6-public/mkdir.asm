
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	bf 01 00 00 00       	mov    $0x1,%edi
  17:	56                   	push   %esi
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 08             	sub    $0x8,%esp
  1d:	8b 59 04             	mov    0x4(%ecx),%ebx
  20:	8b 31                	mov    (%ecx),%esi
  22:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  25:	83 fe 01             	cmp    $0x1,%esi
  28:	7e 3a                	jle    64 <main+0x64>
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 11 03 00 00       	call   34b <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 93 02 00 00       	call   2e3 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 df 07 00 00       	push   $0x7df
  58:	6a 02                	push   $0x2
  5a:	e8 01 04 00 00       	call   460 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 c8 07 00 00       	push   $0x7c8
  6b:	6a 02                	push   $0x2
  6d:	e8 ee 03 00 00       	call   460 <printf>
    exit();
  72:	e8 6c 02 00 00       	call   2e3 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	f3 0f 1e fb          	endbr32 
  84:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  85:	31 c0                	xor    %eax,%eax
{
  87:	89 e5                	mov    %esp,%ebp
  89:	53                   	push   %ebx
  8a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	89 c8                	mov    %ecx,%eax
  a0:	5b                   	pop    %ebx
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	53                   	push   %ebx
  b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  be:	0f b6 01             	movzbl (%ecx),%eax
  c1:	0f b6 1a             	movzbl (%edx),%ebx
  c4:	84 c0                	test   %al,%al
  c6:	75 19                	jne    e1 <strcmp+0x31>
  c8:	eb 26                	jmp    f0 <strcmp+0x40>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  d4:	83 c1 01             	add    $0x1,%ecx
  d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  da:	0f b6 1a             	movzbl (%edx),%ebx
  dd:	84 c0                	test   %al,%al
  df:	74 0f                	je     f0 <strcmp+0x40>
  e1:	38 d8                	cmp    %bl,%al
  e3:	74 eb                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e5:	29 d8                	sub    %ebx,%eax
}
  e7:	5b                   	pop    %ebx
  e8:	5d                   	pop    %ebp
  e9:	c3                   	ret    
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fe:	66 90                	xchg   %ax,%ax

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	f3 0f 1e fb          	endbr32 
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 10a:	80 3a 00             	cmpb   $0x0,(%edx)
 10d:	74 21                	je     130 <strlen+0x30>
 10f:	31 c0                	xor    %eax,%eax
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 118:	83 c0 01             	add    $0x1,%eax
 11b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 11f:	89 c1                	mov    %eax,%ecx
 121:	75 f5                	jne    118 <strlen+0x18>
    ;
  return n;
}
 123:	89 c8                	mov    %ecx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 130:	31 c9                	xor    %ecx,%ecx
}
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	57                   	push   %edi
 148:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 14b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	89 d7                	mov    %edx,%edi
 153:	fc                   	cld    
 154:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 156:	89 d0                	mov    %edx,%eax
 158:	5f                   	pop    %edi
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 15f:	90                   	nop

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16e:	0f b6 10             	movzbl (%eax),%edx
 171:	84 d2                	test   %dl,%dl
 173:	75 16                	jne    18b <strchr+0x2b>
 175:	eb 21                	jmp    198 <strchr+0x38>
 177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17e:	66 90                	xchg   %ax,%ax
 180:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 184:	83 c0 01             	add    $0x1,%eax
 187:	84 d2                	test   %dl,%dl
 189:	74 0d                	je     198 <strchr+0x38>
    if(*s == c)
 18b:	38 d1                	cmp    %dl,%cl
 18d:	75 f1                	jne    180 <strchr+0x20>
      return (char*)s;
  return 0;
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 198:	31 c0                	xor    %eax,%eax
}
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret    
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	57                   	push   %edi
 1a8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a9:	31 f6                	xor    %esi,%esi
{
 1ab:	53                   	push   %ebx
 1ac:	89 f3                	mov    %esi,%ebx
 1ae:	83 ec 1c             	sub    $0x1c,%esp
 1b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1b4:	eb 33                	jmp    1e9 <gets+0x49>
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1c6:	6a 01                	push   $0x1
 1c8:	50                   	push   %eax
 1c9:	6a 00                	push   $0x0
 1cb:	e8 2b 01 00 00       	call   2fb <read>
    if(cc < 1)
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	85 c0                	test   %eax,%eax
 1d5:	7e 1c                	jle    1f3 <gets+0x53>
      break;
    buf[i++] = c;
 1d7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1db:	83 c7 01             	add    $0x1,%edi
 1de:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1e1:	3c 0a                	cmp    $0xa,%al
 1e3:	74 23                	je     208 <gets+0x68>
 1e5:	3c 0d                	cmp    $0xd,%al
 1e7:	74 1f                	je     208 <gets+0x68>
  for(i=0; i+1 < max; ){
 1e9:	83 c3 01             	add    $0x1,%ebx
 1ec:	89 fe                	mov    %edi,%esi
 1ee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1f1:	7c cd                	jl     1c0 <gets+0x20>
 1f3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1f8:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fe:	5b                   	pop    %ebx
 1ff:	5e                   	pop    %esi
 200:	5f                   	pop    %edi
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 207:	90                   	nop
 208:	8b 75 08             	mov    0x8(%ebp),%esi
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	01 de                	add    %ebx,%esi
 210:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 212:	c6 03 00             	movb   $0x0,(%ebx)
}
 215:	8d 65 f4             	lea    -0xc(%ebp),%esp
 218:	5b                   	pop    %ebx
 219:	5e                   	pop    %esi
 21a:	5f                   	pop    %edi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	56                   	push   %esi
 228:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	6a 00                	push   $0x0
 22e:	ff 75 08             	pushl  0x8(%ebp)
 231:	e8 ed 00 00 00       	call   323 <open>
  if(fd < 0)
 236:	83 c4 10             	add    $0x10,%esp
 239:	85 c0                	test   %eax,%eax
 23b:	78 2b                	js     268 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 23d:	83 ec 08             	sub    $0x8,%esp
 240:	ff 75 0c             	pushl  0xc(%ebp)
 243:	89 c3                	mov    %eax,%ebx
 245:	50                   	push   %eax
 246:	e8 f0 00 00 00       	call   33b <fstat>
  close(fd);
 24b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 24e:	89 c6                	mov    %eax,%esi
  close(fd);
 250:	e8 b6 00 00 00       	call   30b <close>
  return r;
 255:	83 c4 10             	add    $0x10,%esp
}
 258:	8d 65 f8             	lea    -0x8(%ebp),%esp
 25b:	89 f0                	mov    %esi,%eax
 25d:	5b                   	pop    %ebx
 25e:	5e                   	pop    %esi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 268:	be ff ff ff ff       	mov    $0xffffffff,%esi
 26d:	eb e9                	jmp    258 <stat+0x38>
 26f:	90                   	nop

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	53                   	push   %ebx
 278:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27b:	0f be 02             	movsbl (%edx),%eax
 27e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 281:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 284:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 289:	77 1a                	ja     2a5 <atoi+0x35>
 28b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 28f:	90                   	nop
    n = n*10 + *s++ - '0';
 290:	83 c2 01             	add    $0x1,%edx
 293:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 296:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 29a:	0f be 02             	movsbl (%edx),%eax
 29d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	89 c8                	mov    %ecx,%eax
 2a7:	5b                   	pop    %ebx
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	57                   	push   %edi
 2b8:	8b 45 10             	mov    0x10(%ebp),%eax
 2bb:	8b 55 08             	mov    0x8(%ebp),%edx
 2be:	56                   	push   %esi
 2bf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c2:	85 c0                	test   %eax,%eax
 2c4:	7e 0f                	jle    2d5 <memmove+0x25>
 2c6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2c8:	89 d7                	mov    %edx,%edi
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2d1:	39 f8                	cmp    %edi,%eax
 2d3:	75 fb                	jne    2d0 <memmove+0x20>
  return vdst;
}
 2d5:	5e                   	pop    %esi
 2d6:	89 d0                	mov    %edx,%eax
 2d8:	5f                   	pop    %edi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    

000002db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2db:	b8 01 00 00 00       	mov    $0x1,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <exit>:
SYSCALL(exit)
 2e3:	b8 02 00 00 00       	mov    $0x2,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <wait>:
SYSCALL(wait)
 2eb:	b8 03 00 00 00       	mov    $0x3,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <pipe>:
SYSCALL(pipe)
 2f3:	b8 04 00 00 00       	mov    $0x4,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <read>:
SYSCALL(read)
 2fb:	b8 05 00 00 00       	mov    $0x5,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <write>:
SYSCALL(write)
 303:	b8 10 00 00 00       	mov    $0x10,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <close>:
SYSCALL(close)
 30b:	b8 15 00 00 00       	mov    $0x15,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <kill>:
SYSCALL(kill)
 313:	b8 06 00 00 00       	mov    $0x6,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <exec>:
SYSCALL(exec)
 31b:	b8 07 00 00 00       	mov    $0x7,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <open>:
SYSCALL(open)
 323:	b8 0f 00 00 00       	mov    $0xf,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mknod>:
SYSCALL(mknod)
 32b:	b8 11 00 00 00       	mov    $0x11,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <unlink>:
SYSCALL(unlink)
 333:	b8 12 00 00 00       	mov    $0x12,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <fstat>:
SYSCALL(fstat)
 33b:	b8 08 00 00 00       	mov    $0x8,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <link>:
SYSCALL(link)
 343:	b8 13 00 00 00       	mov    $0x13,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mkdir>:
SYSCALL(mkdir)
 34b:	b8 14 00 00 00       	mov    $0x14,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <chdir>:
SYSCALL(chdir)
 353:	b8 09 00 00 00       	mov    $0x9,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <dup>:
SYSCALL(dup)
 35b:	b8 0a 00 00 00       	mov    $0xa,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getpid>:
SYSCALL(getpid)
 363:	b8 0b 00 00 00       	mov    $0xb,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <sbrk>:
SYSCALL(sbrk)
 36b:	b8 0c 00 00 00       	mov    $0xc,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <sleep>:
SYSCALL(sleep)
 373:	b8 0d 00 00 00       	mov    $0xd,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <uptime>:
SYSCALL(uptime)
 37b:	b8 0e 00 00 00       	mov    $0xe,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <find_digital_root>:
SYSCALL(find_digital_root)
 383:	b8 16 00 00 00       	mov    $0x16,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <get_process_lifetime>:
SYSCALL(get_process_lifetime)
 38b:	b8 17 00 00 00       	mov    $0x17,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <copy_file>:
SYSCALL(copy_file)
 393:	b8 18 00 00 00       	mov    $0x18,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <get_uncle_count>:
SYSCALL(get_uncle_count)
 39b:	b8 19 00 00 00       	mov    $0x19,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    
 3a3:	66 90                	xchg   %ax,%ax
 3a5:	66 90                	xchg   %ax,%ax
 3a7:	66 90                	xchg   %ax,%ax
 3a9:	66 90                	xchg   %ax,%ax
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 3c             	sub    $0x3c,%esp
 3b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3bc:	89 d1                	mov    %edx,%ecx
{
 3be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3c1:	85 d2                	test   %edx,%edx
 3c3:	0f 89 7f 00 00 00    	jns    448 <printint+0x98>
 3c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3cd:	74 79                	je     448 <printint+0x98>
    neg = 1;
 3cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3d8:	31 db                	xor    %ebx,%ebx
 3da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	89 cf                	mov    %ecx,%edi
 3e6:	f7 75 c4             	divl   -0x3c(%ebp)
 3e9:	0f b6 92 04 08 00 00 	movzbl 0x804(%edx),%edx
 3f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3f3:	89 d8                	mov    %ebx,%eax
 3f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 3f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 3fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 401:	76 dd                	jbe    3e0 <printint+0x30>
  if(neg)
 403:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 406:	85 c9                	test   %ecx,%ecx
 408:	74 0c                	je     416 <printint+0x66>
    buf[i++] = '-';
 40a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 40f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 411:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 416:	8b 7d b8             	mov    -0x48(%ebp),%edi
 419:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 41d:	eb 07                	jmp    426 <printint+0x76>
 41f:	90                   	nop
 420:	0f b6 13             	movzbl (%ebx),%edx
 423:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 426:	83 ec 04             	sub    $0x4,%esp
 429:	88 55 d7             	mov    %dl,-0x29(%ebp)
 42c:	6a 01                	push   $0x1
 42e:	56                   	push   %esi
 42f:	57                   	push   %edi
 430:	e8 ce fe ff ff       	call   303 <write>
  while(--i >= 0)
 435:	83 c4 10             	add    $0x10,%esp
 438:	39 de                	cmp    %ebx,%esi
 43a:	75 e4                	jne    420 <printint+0x70>
    putc(fd, buf[i]);
}
 43c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43f:	5b                   	pop    %ebx
 440:	5e                   	pop    %esi
 441:	5f                   	pop    %edi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 448:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 44f:	eb 87                	jmp    3d8 <printint+0x28>
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	f3 0f 1e fb          	endbr32 
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	57                   	push   %edi
 468:	56                   	push   %esi
 469:	53                   	push   %ebx
 46a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 46d:	8b 75 0c             	mov    0xc(%ebp),%esi
 470:	0f b6 1e             	movzbl (%esi),%ebx
 473:	84 db                	test   %bl,%bl
 475:	0f 84 b4 00 00 00    	je     52f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 47b:	8d 45 10             	lea    0x10(%ebp),%eax
 47e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 481:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 484:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 486:	89 45 d0             	mov    %eax,-0x30(%ebp)
 489:	eb 33                	jmp    4be <printf+0x5e>
 48b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop
 490:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 493:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	74 17                	je     4b4 <printf+0x54>
  write(fd, &c, 1);
 49d:	83 ec 04             	sub    $0x4,%esp
 4a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4a3:	6a 01                	push   $0x1
 4a5:	57                   	push   %edi
 4a6:	ff 75 08             	pushl  0x8(%ebp)
 4a9:	e8 55 fe ff ff       	call   303 <write>
 4ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4b4:	0f b6 1e             	movzbl (%esi),%ebx
 4b7:	83 c6 01             	add    $0x1,%esi
 4ba:	84 db                	test   %bl,%bl
 4bc:	74 71                	je     52f <printf+0xcf>
    c = fmt[i] & 0xff;
 4be:	0f be cb             	movsbl %bl,%ecx
 4c1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4c4:	85 d2                	test   %edx,%edx
 4c6:	74 c8                	je     490 <printf+0x30>
      }
    } else if(state == '%'){
 4c8:	83 fa 25             	cmp    $0x25,%edx
 4cb:	75 e7                	jne    4b4 <printf+0x54>
      if(c == 'd'){
 4cd:	83 f8 64             	cmp    $0x64,%eax
 4d0:	0f 84 9a 00 00 00    	je     570 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4d6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4dc:	83 f9 70             	cmp    $0x70,%ecx
 4df:	74 5f                	je     540 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4e1:	83 f8 73             	cmp    $0x73,%eax
 4e4:	0f 84 d6 00 00 00    	je     5c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ea:	83 f8 63             	cmp    $0x63,%eax
 4ed:	0f 84 8d 00 00 00    	je     580 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4f3:	83 f8 25             	cmp    $0x25,%eax
 4f6:	0f 84 b4 00 00 00    	je     5b0 <printf+0x150>
  write(fd, &c, 1);
 4fc:	83 ec 04             	sub    $0x4,%esp
 4ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	57                   	push   %edi
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 f5 fd ff ff       	call   303 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 50e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 511:	83 c4 0c             	add    $0xc,%esp
 514:	6a 01                	push   $0x1
 516:	83 c6 01             	add    $0x1,%esi
 519:	57                   	push   %edi
 51a:	ff 75 08             	pushl  0x8(%ebp)
 51d:	e8 e1 fd ff ff       	call   303 <write>
  for(i = 0; fmt[i]; i++){
 522:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 526:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 529:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 52b:	84 db                	test   %bl,%bl
 52d:	75 8f                	jne    4be <printf+0x5e>
    }
  }
}
 52f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 532:	5b                   	pop    %ebx
 533:	5e                   	pop    %esi
 534:	5f                   	pop    %edi
 535:	5d                   	pop    %ebp
 536:	c3                   	ret    
 537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	b9 10 00 00 00       	mov    $0x10,%ecx
 548:	6a 00                	push   $0x0
 54a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 54d:	8b 45 08             	mov    0x8(%ebp),%eax
 550:	8b 13                	mov    (%ebx),%edx
 552:	e8 59 fe ff ff       	call   3b0 <printint>
        ap++;
 557:	89 d8                	mov    %ebx,%eax
 559:	83 c4 10             	add    $0x10,%esp
      state = 0;
 55c:	31 d2                	xor    %edx,%edx
        ap++;
 55e:	83 c0 04             	add    $0x4,%eax
 561:	89 45 d0             	mov    %eax,-0x30(%ebp)
 564:	e9 4b ff ff ff       	jmp    4b4 <printf+0x54>
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
 578:	6a 01                	push   $0x1
 57a:	eb ce                	jmp    54a <printf+0xea>
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 580:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 583:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 586:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 588:	6a 01                	push   $0x1
        ap++;
 58a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 58d:	57                   	push   %edi
 58e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 591:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 594:	e8 6a fd ff ff       	call   303 <write>
        ap++;
 599:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 59c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59f:	31 d2                	xor    %edx,%edx
 5a1:	e9 0e ff ff ff       	jmp    4b4 <printf+0x54>
 5a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5b3:	83 ec 04             	sub    $0x4,%esp
 5b6:	e9 59 ff ff ff       	jmp    514 <printf+0xb4>
 5bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop
        s = (char*)*ap;
 5c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5c5:	83 c0 04             	add    $0x4,%eax
 5c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5cb:	85 db                	test   %ebx,%ebx
 5cd:	74 17                	je     5e6 <printf+0x186>
        while(*s != 0){
 5cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5d4:	84 c0                	test   %al,%al
 5d6:	0f 84 d8 fe ff ff    	je     4b4 <printf+0x54>
 5dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5df:	89 de                	mov    %ebx,%esi
 5e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5e4:	eb 1a                	jmp    600 <printf+0x1a0>
          s = "(null)";
 5e6:	bb fb 07 00 00       	mov    $0x7fb,%ebx
        while(*s != 0){
 5eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5ee:	b8 28 00 00 00       	mov    $0x28,%eax
 5f3:	89 de                	mov    %ebx,%esi
 5f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
          s++;
 603:	83 c6 01             	add    $0x1,%esi
 606:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 609:	6a 01                	push   $0x1
 60b:	57                   	push   %edi
 60c:	53                   	push   %ebx
 60d:	e8 f1 fc ff ff       	call   303 <write>
        while(*s != 0){
 612:	0f b6 06             	movzbl (%esi),%eax
 615:	83 c4 10             	add    $0x10,%esp
 618:	84 c0                	test   %al,%al
 61a:	75 e4                	jne    600 <printf+0x1a0>
 61c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 61f:	31 d2                	xor    %edx,%edx
 621:	e9 8e fe ff ff       	jmp    4b4 <printf+0x54>
 626:	66 90                	xchg   %ax,%ax
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	f3 0f 1e fb          	endbr32 
 634:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 635:	a1 bc 0a 00 00       	mov    0xabc,%eax
{
 63a:	89 e5                	mov    %esp,%ebp
 63c:	57                   	push   %edi
 63d:	56                   	push   %esi
 63e:	53                   	push   %ebx
 63f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 642:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 644:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 647:	39 c8                	cmp    %ecx,%eax
 649:	73 15                	jae    660 <free+0x30>
 64b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
 650:	39 d1                	cmp    %edx,%ecx
 652:	72 14                	jb     668 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	39 d0                	cmp    %edx,%eax
 656:	73 10                	jae    668 <free+0x38>
{
 658:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65a:	8b 10                	mov    (%eax),%edx
 65c:	39 c8                	cmp    %ecx,%eax
 65e:	72 f0                	jb     650 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 f4                	jb     658 <free+0x28>
 664:	39 d1                	cmp    %edx,%ecx
 666:	73 f0                	jae    658 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 668:	8b 73 fc             	mov    -0x4(%ebx),%esi
 66b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 66e:	39 fa                	cmp    %edi,%edx
 670:	74 1e                	je     690 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 672:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 675:	8b 50 04             	mov    0x4(%eax),%edx
 678:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 67b:	39 f1                	cmp    %esi,%ecx
 67d:	74 28                	je     6a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 67f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 681:	5b                   	pop    %ebx
  freep = p;
 682:	a3 bc 0a 00 00       	mov    %eax,0xabc
}
 687:	5e                   	pop    %esi
 688:	5f                   	pop    %edi
 689:	5d                   	pop    %ebp
 68a:	c3                   	ret    
 68b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 690:	03 72 04             	add    0x4(%edx),%esi
 693:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 696:	8b 10                	mov    (%eax),%edx
 698:	8b 12                	mov    (%edx),%edx
 69a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	75 d8                	jne    67f <free+0x4f>
    p->s.size += bp->s.size;
 6a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6aa:	a3 bc 0a 00 00       	mov    %eax,0xabc
    p->s.size += bp->s.size;
 6af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b5:	89 10                	mov    %edx,(%eax)
}
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	f3 0f 1e fb          	endbr32 
 6c4:	55                   	push   %ebp
 6c5:	89 e5                	mov    %esp,%ebp
 6c7:	57                   	push   %edi
 6c8:	56                   	push   %esi
 6c9:	53                   	push   %ebx
 6ca:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6d0:	8b 3d bc 0a 00 00    	mov    0xabc,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d6:	8d 70 07             	lea    0x7(%eax),%esi
 6d9:	c1 ee 03             	shr    $0x3,%esi
 6dc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6df:	85 ff                	test   %edi,%edi
 6e1:	0f 84 a9 00 00 00    	je     790 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 6e9:	8b 48 04             	mov    0x4(%eax),%ecx
 6ec:	39 f1                	cmp    %esi,%ecx
 6ee:	73 6d                	jae    75d <malloc+0x9d>
 6f0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6f6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6fb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6fe:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 705:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 708:	eb 17                	jmp    721 <malloc+0x61>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 712:	8b 4a 04             	mov    0x4(%edx),%ecx
 715:	39 f1                	cmp    %esi,%ecx
 717:	73 4f                	jae    768 <malloc+0xa8>
 719:	8b 3d bc 0a 00 00    	mov    0xabc,%edi
 71f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 721:	39 c7                	cmp    %eax,%edi
 723:	75 eb                	jne    710 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 725:	83 ec 0c             	sub    $0xc,%esp
 728:	ff 75 e4             	pushl  -0x1c(%ebp)
 72b:	e8 3b fc ff ff       	call   36b <sbrk>
  if(p == (char*)-1)
 730:	83 c4 10             	add    $0x10,%esp
 733:	83 f8 ff             	cmp    $0xffffffff,%eax
 736:	74 1b                	je     753 <malloc+0x93>
  hp->s.size = nu;
 738:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 73b:	83 ec 0c             	sub    $0xc,%esp
 73e:	83 c0 08             	add    $0x8,%eax
 741:	50                   	push   %eax
 742:	e8 e9 fe ff ff       	call   630 <free>
  return freep;
 747:	a1 bc 0a 00 00       	mov    0xabc,%eax
      if((p = morecore(nunits)) == 0)
 74c:	83 c4 10             	add    $0x10,%esp
 74f:	85 c0                	test   %eax,%eax
 751:	75 bd                	jne    710 <malloc+0x50>
        return 0;
  }
}
 753:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 756:	31 c0                	xor    %eax,%eax
}
 758:	5b                   	pop    %ebx
 759:	5e                   	pop    %esi
 75a:	5f                   	pop    %edi
 75b:	5d                   	pop    %ebp
 75c:	c3                   	ret    
    if(p->s.size >= nunits){
 75d:	89 c2                	mov    %eax,%edx
 75f:	89 f8                	mov    %edi,%eax
 761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 768:	39 ce                	cmp    %ecx,%esi
 76a:	74 54                	je     7c0 <malloc+0x100>
        p->s.size -= nunits;
 76c:	29 f1                	sub    %esi,%ecx
 76e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 771:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 774:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 777:	a3 bc 0a 00 00       	mov    %eax,0xabc
}
 77c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 77f:	8d 42 08             	lea    0x8(%edx),%eax
}
 782:	5b                   	pop    %ebx
 783:	5e                   	pop    %esi
 784:	5f                   	pop    %edi
 785:	5d                   	pop    %ebp
 786:	c3                   	ret    
 787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 790:	c7 05 bc 0a 00 00 c0 	movl   $0xac0,0xabc
 797:	0a 00 00 
    base.s.size = 0;
 79a:	bf c0 0a 00 00       	mov    $0xac0,%edi
    base.s.ptr = freep = prevp = &base;
 79f:	c7 05 c0 0a 00 00 c0 	movl   $0xac0,0xac0
 7a6:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7ab:	c7 05 c4 0a 00 00 00 	movl   $0x0,0xac4
 7b2:	00 00 00 
    if(p->s.size >= nunits){
 7b5:	e9 36 ff ff ff       	jmp    6f0 <malloc+0x30>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7c0:	8b 0a                	mov    (%edx),%ecx
 7c2:	89 08                	mov    %ecx,(%eax)
 7c4:	eb b1                	jmp    777 <malloc+0xb7>
