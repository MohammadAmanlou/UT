
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  12:	56                   	push   %esi
  13:	be 01 00 00 00       	mov    $0x1,%esi
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 18             	sub    $0x18,%esp
  1d:	8b 01                	mov    (%ecx),%eax
  1f:	8b 59 04             	mov    0x4(%ecx),%ebx
  22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  25:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  28:	83 f8 01             	cmp    $0x1,%eax
  2b:	7e 50                	jle    7d <main+0x7d>
  2d:	8d 76 00             	lea    0x0(%esi),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 77 03 00 00       	call   3b3 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 c7                	mov    %eax,%edi
  41:	85 c0                	test   %eax,%eax
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 3f 03 00 00       	call   39b <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 0a 03 00 00       	call   373 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 7b 08 00 00       	push   $0x87b
  71:	6a 01                	push   $0x1
  73:	e8 78 04 00 00       	call   4f0 <printf>
      exit();
  78:	e8 f6 02 00 00       	call   373 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 e7 02 00 00       	call   373 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	f3 0f 1e fb          	endbr32 
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	56                   	push   %esi
  98:	8b 75 08             	mov    0x8(%ebp),%esi
  9b:	53                   	push   %ebx
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  9c:	eb 19                	jmp    b7 <cat+0x27>
  9e:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 a0 0b 00 00       	push   $0xba0
  a9:	6a 01                	push   $0x1
  ab:	e8 e3 02 00 00       	call   393 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 a0 0b 00 00       	push   $0xba0
  c4:	56                   	push   %esi
  c5:	e8 c1 02 00 00       	call   38b <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 58 08 00 00       	push   $0x858
  e4:	6a 01                	push   $0x1
  e6:	e8 05 04 00 00       	call   4f0 <printf>
      exit();
  eb:	e8 83 02 00 00       	call   373 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 6a 08 00 00       	push   $0x86a
  f7:	6a 01                	push   $0x1
  f9:	e8 f2 03 00 00       	call   4f0 <printf>
    exit();
  fe:	e8 70 02 00 00       	call   373 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 115:	31 c0                	xor    %eax,%eax
{
 117:	89 e5                	mov    %esp,%ebp
 119:	53                   	push   %ebx
 11a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 127:	83 c0 01             	add    $0x1,%eax
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	89 c8                	mov    %ecx,%eax
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	53                   	push   %ebx
 148:	8b 4d 08             	mov    0x8(%ebp),%ecx
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 14e:	0f b6 01             	movzbl (%ecx),%eax
 151:	0f b6 1a             	movzbl (%edx),%ebx
 154:	84 c0                	test   %al,%al
 156:	75 19                	jne    171 <strcmp+0x31>
 158:	eb 26                	jmp    180 <strcmp+0x40>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 160:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 164:	83 c1 01             	add    $0x1,%ecx
 167:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 16a:	0f b6 1a             	movzbl (%edx),%ebx
 16d:	84 c0                	test   %al,%al
 16f:	74 0f                	je     180 <strcmp+0x40>
 171:	38 d8                	cmp    %bl,%al
 173:	74 eb                	je     160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 175:	29 d8                	sub    %ebx,%eax
}
 177:	5b                   	pop    %ebx
 178:	5d                   	pop    %ebp
 179:	c3                   	ret    
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 182:	29 d8                	sub    %ebx,%eax
}
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 19a:	80 3a 00             	cmpb   $0x0,(%edx)
 19d:	74 21                	je     1c0 <strlen+0x30>
 19f:	31 c0                	xor    %eax,%eax
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a8:	83 c0 01             	add    $0x1,%eax
 1ab:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1af:	89 c1                	mov    %eax,%ecx
 1b1:	75 f5                	jne    1a8 <strlen+0x18>
    ;
  return n;
}
 1b3:	89 c8                	mov    %ecx,%eax
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1db:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	89 d7                	mov    %edx,%edi
 1e3:	fc                   	cld    
 1e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e6:	89 d0                	mov    %edx,%eax
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fe:	0f b6 10             	movzbl (%eax),%edx
 201:	84 d2                	test   %dl,%dl
 203:	75 16                	jne    21b <strchr+0x2b>
 205:	eb 21                	jmp    228 <strchr+0x38>
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax
 210:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 214:	83 c0 01             	add    $0x1,%eax
 217:	84 d2                	test   %dl,%dl
 219:	74 0d                	je     228 <strchr+0x38>
    if(*s == c)
 21b:	38 d1                	cmp    %dl,%cl
 21d:	75 f1                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 228:	31 c0                	xor    %eax,%eax
}
 22a:	5d                   	pop    %ebp
 22b:	c3                   	ret    
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 239:	31 f6                	xor    %esi,%esi
{
 23b:	53                   	push   %ebx
 23c:	89 f3                	mov    %esi,%ebx
 23e:	83 ec 1c             	sub    $0x1c,%esp
 241:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 244:	eb 33                	jmp    279 <gets+0x49>
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	8d 45 e7             	lea    -0x19(%ebp),%eax
 256:	6a 01                	push   $0x1
 258:	50                   	push   %eax
 259:	6a 00                	push   $0x0
 25b:	e8 2b 01 00 00       	call   38b <read>
    if(cc < 1)
 260:	83 c4 10             	add    $0x10,%esp
 263:	85 c0                	test   %eax,%eax
 265:	7e 1c                	jle    283 <gets+0x53>
      break;
    buf[i++] = c;
 267:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 26b:	83 c7 01             	add    $0x1,%edi
 26e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 271:	3c 0a                	cmp    $0xa,%al
 273:	74 23                	je     298 <gets+0x68>
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 1f                	je     298 <gets+0x68>
  for(i=0; i+1 < max; ){
 279:	83 c3 01             	add    $0x1,%ebx
 27c:	89 fe                	mov    %edi,%esi
 27e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 281:	7c cd                	jl     250 <gets+0x20>
 283:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 285:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 288:	c6 03 00             	movb   $0x0,(%ebx)
}
 28b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28e:	5b                   	pop    %ebx
 28f:	5e                   	pop    %esi
 290:	5f                   	pop    %edi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 297:	90                   	nop
 298:	8b 75 08             	mov    0x8(%ebp),%esi
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	01 de                	add    %ebx,%esi
 2a0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2a2:	c6 03 00             	movb   $0x0,(%ebx)
}
 2a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a8:	5b                   	pop    %ebx
 2a9:	5e                   	pop    %esi
 2aa:	5f                   	pop    %edi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	6a 00                	push   $0x0
 2be:	ff 75 08             	pushl  0x8(%ebp)
 2c1:	e8 ed 00 00 00       	call   3b3 <open>
  if(fd < 0)
 2c6:	83 c4 10             	add    $0x10,%esp
 2c9:	85 c0                	test   %eax,%eax
 2cb:	78 2b                	js     2f8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2cd:	83 ec 08             	sub    $0x8,%esp
 2d0:	ff 75 0c             	pushl  0xc(%ebp)
 2d3:	89 c3                	mov    %eax,%ebx
 2d5:	50                   	push   %eax
 2d6:	e8 f0 00 00 00       	call   3cb <fstat>
  close(fd);
 2db:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2de:	89 c6                	mov    %eax,%esi
  close(fd);
 2e0:	e8 b6 00 00 00       	call   39b <close>
  return r;
 2e5:	83 c4 10             	add    $0x10,%esp
}
 2e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2eb:	89 f0                	mov    %esi,%eax
 2ed:	5b                   	pop    %ebx
 2ee:	5e                   	pop    %esi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2fd:	eb e9                	jmp    2e8 <stat+0x38>
 2ff:	90                   	nop

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	53                   	push   %ebx
 308:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30b:	0f be 02             	movsbl (%edx),%eax
 30e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 311:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 314:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 319:	77 1a                	ja     335 <atoi+0x35>
 31b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 31f:	90                   	nop
    n = n*10 + *s++ - '0';
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	89 c8                	mov    %ecx,%eax
 337:	5b                   	pop    %ebx
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	57                   	push   %edi
 348:	8b 45 10             	mov    0x10(%ebp),%eax
 34b:	8b 55 08             	mov    0x8(%ebp),%edx
 34e:	56                   	push   %esi
 34f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 352:	85 c0                	test   %eax,%eax
 354:	7e 0f                	jle    365 <memmove+0x25>
 356:	01 d0                	add    %edx,%eax
  dst = vdst;
 358:	89 d7                	mov    %edx,%edi
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <find_digital_root>:
SYSCALL(find_digital_root)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <get_process_lifetime>:
SYSCALL(get_process_lifetime)
 41b:	b8 17 00 00 00       	mov    $0x17,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <copy_file>:
SYSCALL(copy_file)
 423:	b8 18 00 00 00       	mov    $0x18,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <get_uncle_count>:
SYSCALL(get_uncle_count)
 42b:	b8 19 00 00 00       	mov    $0x19,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    
 433:	66 90                	xchg   %ax,%ax
 435:	66 90                	xchg   %ax,%ax
 437:	66 90                	xchg   %ax,%ax
 439:	66 90                	xchg   %ax,%ax
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 3c             	sub    $0x3c,%esp
 449:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 44c:	89 d1                	mov    %edx,%ecx
{
 44e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 451:	85 d2                	test   %edx,%edx
 453:	0f 89 7f 00 00 00    	jns    4d8 <printint+0x98>
 459:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 45d:	74 79                	je     4d8 <printint+0x98>
    neg = 1;
 45f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 466:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 468:	31 db                	xor    %ebx,%ebx
 46a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 470:	89 c8                	mov    %ecx,%eax
 472:	31 d2                	xor    %edx,%edx
 474:	89 cf                	mov    %ecx,%edi
 476:	f7 75 c4             	divl   -0x3c(%ebp)
 479:	0f b6 92 98 08 00 00 	movzbl 0x898(%edx),%edx
 480:	89 45 c0             	mov    %eax,-0x40(%ebp)
 483:	89 d8                	mov    %ebx,%eax
 485:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 488:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 48b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 48e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 491:	76 dd                	jbe    470 <printint+0x30>
  if(neg)
 493:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 496:	85 c9                	test   %ecx,%ecx
 498:	74 0c                	je     4a6 <printint+0x66>
    buf[i++] = '-';
 49a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 49f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4ad:	eb 07                	jmp    4b6 <printint+0x76>
 4af:	90                   	nop
 4b0:	0f b6 13             	movzbl (%ebx),%edx
 4b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4b6:	83 ec 04             	sub    $0x4,%esp
 4b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	56                   	push   %esi
 4bf:	57                   	push   %edi
 4c0:	e8 ce fe ff ff       	call   393 <write>
  while(--i >= 0)
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	39 de                	cmp    %ebx,%esi
 4ca:	75 e4                	jne    4b0 <printint+0x70>
    putc(fd, buf[i]);
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4df:	eb 87                	jmp    468 <printint+0x28>
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	f3 0f 1e fb          	endbr32 
 4f4:	55                   	push   %ebp
 4f5:	89 e5                	mov    %esp,%ebp
 4f7:	57                   	push   %edi
 4f8:	56                   	push   %esi
 4f9:	53                   	push   %ebx
 4fa:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4fd:	8b 75 0c             	mov    0xc(%ebp),%esi
 500:	0f b6 1e             	movzbl (%esi),%ebx
 503:	84 db                	test   %bl,%bl
 505:	0f 84 b4 00 00 00    	je     5bf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 50b:	8d 45 10             	lea    0x10(%ebp),%eax
 50e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 511:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 514:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 516:	89 45 d0             	mov    %eax,-0x30(%ebp)
 519:	eb 33                	jmp    54e <printf+0x5e>
 51b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop
 520:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 523:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	74 17                	je     544 <printf+0x54>
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	88 5d e7             	mov    %bl,-0x19(%ebp)
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 55 fe ff ff       	call   393 <write>
 53e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 541:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 544:	0f b6 1e             	movzbl (%esi),%ebx
 547:	83 c6 01             	add    $0x1,%esi
 54a:	84 db                	test   %bl,%bl
 54c:	74 71                	je     5bf <printf+0xcf>
    c = fmt[i] & 0xff;
 54e:	0f be cb             	movsbl %bl,%ecx
 551:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 554:	85 d2                	test   %edx,%edx
 556:	74 c8                	je     520 <printf+0x30>
      }
    } else if(state == '%'){
 558:	83 fa 25             	cmp    $0x25,%edx
 55b:	75 e7                	jne    544 <printf+0x54>
      if(c == 'd'){
 55d:	83 f8 64             	cmp    $0x64,%eax
 560:	0f 84 9a 00 00 00    	je     600 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 566:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 56c:	83 f9 70             	cmp    $0x70,%ecx
 56f:	74 5f                	je     5d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 571:	83 f8 73             	cmp    $0x73,%eax
 574:	0f 84 d6 00 00 00    	je     650 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57a:	83 f8 63             	cmp    $0x63,%eax
 57d:	0f 84 8d 00 00 00    	je     610 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 583:	83 f8 25             	cmp    $0x25,%eax
 586:	0f 84 b4 00 00 00    	je     640 <printf+0x150>
  write(fd, &c, 1);
 58c:	83 ec 04             	sub    $0x4,%esp
 58f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 593:	6a 01                	push   $0x1
 595:	57                   	push   %edi
 596:	ff 75 08             	pushl  0x8(%ebp)
 599:	e8 f5 fd ff ff       	call   393 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 59e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a1:	83 c4 0c             	add    $0xc,%esp
 5a4:	6a 01                	push   $0x1
 5a6:	83 c6 01             	add    $0x1,%esi
 5a9:	57                   	push   %edi
 5aa:	ff 75 08             	pushl  0x8(%ebp)
 5ad:	e8 e1 fd ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 5b2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5b6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5bb:	84 db                	test   %bl,%bl
 5bd:	75 8f                	jne    54e <printf+0x5e>
    }
  }
}
 5bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret    
 5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d8:	6a 00                	push   $0x0
 5da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	8b 13                	mov    (%ebx),%edx
 5e2:	e8 59 fe ff ff       	call   440 <printint>
        ap++;
 5e7:	89 d8                	mov    %ebx,%eax
 5e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ec:	31 d2                	xor    %edx,%edx
        ap++;
 5ee:	83 c0 04             	add    $0x4,%eax
 5f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f4:	e9 4b ff ff ff       	jmp    544 <printf+0x54>
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 0a 00 00 00       	mov    $0xa,%ecx
 608:	6a 01                	push   $0x1
 60a:	eb ce                	jmp    5da <printf+0xea>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 616:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 618:	6a 01                	push   $0x1
        ap++;
 61a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 61d:	57                   	push   %edi
 61e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 621:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 624:	e8 6a fd ff ff       	call   393 <write>
        ap++;
 629:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 62c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 0e ff ff ff       	jmp    544 <printf+0x54>
 636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 640:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
 646:	e9 59 ff ff ff       	jmp    5a4 <printf+0xb4>
 64b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
        s = (char*)*ap;
 650:	8b 45 d0             	mov    -0x30(%ebp),%eax
 653:	8b 18                	mov    (%eax),%ebx
        ap++;
 655:	83 c0 04             	add    $0x4,%eax
 658:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 65b:	85 db                	test   %ebx,%ebx
 65d:	74 17                	je     676 <printf+0x186>
        while(*s != 0){
 65f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 662:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 664:	84 c0                	test   %al,%al
 666:	0f 84 d8 fe ff ff    	je     544 <printf+0x54>
 66c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 66f:	89 de                	mov    %ebx,%esi
 671:	8b 5d 08             	mov    0x8(%ebp),%ebx
 674:	eb 1a                	jmp    690 <printf+0x1a0>
          s = "(null)";
 676:	bb 90 08 00 00       	mov    $0x890,%ebx
        while(*s != 0){
 67b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 67e:	b8 28 00 00 00       	mov    $0x28,%eax
 683:	89 de                	mov    %ebx,%esi
 685:	8b 5d 08             	mov    0x8(%ebp),%ebx
 688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
          s++;
 693:	83 c6 01             	add    $0x1,%esi
 696:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 699:	6a 01                	push   $0x1
 69b:	57                   	push   %edi
 69c:	53                   	push   %ebx
 69d:	e8 f1 fc ff ff       	call   393 <write>
        while(*s != 0){
 6a2:	0f b6 06             	movzbl (%esi),%eax
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	84 c0                	test   %al,%al
 6aa:	75 e4                	jne    690 <printf+0x1a0>
 6ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 8e fe ff ff       	jmp    544 <printf+0x54>
 6b6:	66 90                	xchg   %ax,%ax
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	f3 0f 1e fb          	endbr32 
 6c4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c5:	a1 80 0b 00 00       	mov    0xb80,%eax
{
 6ca:	89 e5                	mov    %esp,%ebp
 6cc:	57                   	push   %edi
 6cd:	56                   	push   %esi
 6ce:	53                   	push   %ebx
 6cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6d2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6d4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d7:	39 c8                	cmp    %ecx,%eax
 6d9:	73 15                	jae    6f0 <free+0x30>
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
 6e0:	39 d1                	cmp    %edx,%ecx
 6e2:	72 14                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 d0                	cmp    %edx,%eax
 6e6:	73 10                	jae    6f8 <free+0x38>
{
 6e8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	8b 10                	mov    (%eax),%edx
 6ec:	39 c8                	cmp    %ecx,%eax
 6ee:	72 f0                	jb     6e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 f4                	jb     6e8 <free+0x28>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	73 f0                	jae    6e8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 fa                	cmp    %edi,%edx
 700:	74 1e                	je     720 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 f1                	cmp    %esi,%ecx
 70d:	74 28                	je     737 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 711:	5b                   	pop    %ebx
  freep = p;
 712:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 720:	03 72 04             	add    0x4(%edx),%esi
 723:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	8b 10                	mov    (%eax),%edx
 728:	8b 12                	mov    (%edx),%edx
 72a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72d:	8b 50 04             	mov    0x4(%eax),%edx
 730:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 733:	39 f1                	cmp    %esi,%ecx
 735:	75 d8                	jne    70f <free+0x4f>
    p->s.size += bp->s.size;
 737:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 73a:	a3 80 0b 00 00       	mov    %eax,0xb80
    p->s.size += bp->s.size;
 73f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 742:	8b 53 f8             	mov    -0x8(%ebx),%edx
 745:	89 10                	mov    %edx,(%eax)
}
 747:	5b                   	pop    %ebx
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret    
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	f3 0f 1e fb          	endbr32 
 754:	55                   	push   %ebp
 755:	89 e5                	mov    %esp,%ebp
 757:	57                   	push   %edi
 758:	56                   	push   %esi
 759:	53                   	push   %ebx
 75a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 760:	8b 3d 80 0b 00 00    	mov    0xb80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 766:	8d 70 07             	lea    0x7(%eax),%esi
 769:	c1 ee 03             	shr    $0x3,%esi
 76c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 76f:	85 ff                	test   %edi,%edi
 771:	0f 84 a9 00 00 00    	je     820 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 777:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 779:	8b 48 04             	mov    0x4(%eax),%ecx
 77c:	39 f1                	cmp    %esi,%ecx
 77e:	73 6d                	jae    7ed <malloc+0x9d>
 780:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 786:	bb 00 10 00 00       	mov    $0x1000,%ebx
 78b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 78e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 795:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 798:	eb 17                	jmp    7b1 <malloc+0x61>
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7a2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	73 4f                	jae    7f8 <malloc+0xa8>
 7a9:	8b 3d 80 0b 00 00    	mov    0xb80,%edi
 7af:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 c7                	cmp    %eax,%edi
 7b3:	75 eb                	jne    7a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7b5:	83 ec 0c             	sub    $0xc,%esp
 7b8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7bb:	e8 3b fc ff ff       	call   3fb <sbrk>
  if(p == (char*)-1)
 7c0:	83 c4 10             	add    $0x10,%esp
 7c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c6:	74 1b                	je     7e3 <malloc+0x93>
  hp->s.size = nu;
 7c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	83 c0 08             	add    $0x8,%eax
 7d1:	50                   	push   %eax
 7d2:	e8 e9 fe ff ff       	call   6c0 <free>
  return freep;
 7d7:	a1 80 0b 00 00       	mov    0xb80,%eax
      if((p = morecore(nunits)) == 0)
 7dc:	83 c4 10             	add    $0x10,%esp
 7df:	85 c0                	test   %eax,%eax
 7e1:	75 bd                	jne    7a0 <malloc+0x50>
        return 0;
  }
}
 7e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e6:	31 c0                	xor    %eax,%eax
}
 7e8:	5b                   	pop    %ebx
 7e9:	5e                   	pop    %esi
 7ea:	5f                   	pop    %edi
 7eb:	5d                   	pop    %ebp
 7ec:	c3                   	ret    
    if(p->s.size >= nunits){
 7ed:	89 c2                	mov    %eax,%edx
 7ef:	89 f8                	mov    %edi,%eax
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7f8:	39 ce                	cmp    %ecx,%esi
 7fa:	74 54                	je     850 <malloc+0x100>
        p->s.size -= nunits;
 7fc:	29 f1                	sub    %esi,%ecx
 7fe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 801:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 804:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 807:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 80c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 80f:	8d 42 08             	lea    0x8(%edx),%eax
}
 812:	5b                   	pop    %ebx
 813:	5e                   	pop    %esi
 814:	5f                   	pop    %edi
 815:	5d                   	pop    %ebp
 816:	c3                   	ret    
 817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 820:	c7 05 80 0b 00 00 84 	movl   $0xb84,0xb80
 827:	0b 00 00 
    base.s.size = 0;
 82a:	bf 84 0b 00 00       	mov    $0xb84,%edi
    base.s.ptr = freep = prevp = &base;
 82f:	c7 05 84 0b 00 00 84 	movl   $0xb84,0xb84
 836:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 839:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 83b:	c7 05 88 0b 00 00 00 	movl   $0x0,0xb88
 842:	00 00 00 
    if(p->s.size >= nunits){
 845:	e9 36 ff ff ff       	jmp    780 <malloc+0x30>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 850:	8b 0a                	mov    (%edx),%ecx
 852:	89 08                	mov    %ecx,(%eax)
 854:	eb b1                	jmp    807 <malloc+0xb7>
