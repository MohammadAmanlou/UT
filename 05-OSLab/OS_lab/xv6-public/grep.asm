
_grep:     file format elf32-i386


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
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 18             	sub    $0x18,%esp
  18:	8b 01                	mov    (%ecx),%eax
  1a:	8b 59 04             	mov    0x4(%ecx),%ebx
  1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  20:	83 f8 01             	cmp    $0x1,%eax
  23:	7e 6b                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  25:	8b 43 04             	mov    0x4(%ebx),%eax
  28:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  2b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2f:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  34:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  37:	75 29                	jne    62 <main+0x62>
  39:	eb 68                	jmp    a3 <main+0xa3>
  3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  3f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  40:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  43:	83 c6 01             	add    $0x1,%esi
  46:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  49:	50                   	push   %eax
  4a:	ff 75 e0             	pushl  -0x20(%ebp)
  4d:	e8 de 01 00 00       	call   230 <grep>
    close(fd);
  52:	89 3c 24             	mov    %edi,(%esp)
  55:	e8 71 05 00 00       	call   5cb <close>
  for(i = 2; i < argc; i++){
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  60:	7e 29                	jle    8b <main+0x8b>
    if((fd = open(argv[i], 0)) < 0){
  62:	83 ec 08             	sub    $0x8,%esp
  65:	6a 00                	push   $0x0
  67:	ff 33                	pushl  (%ebx)
  69:	e8 75 05 00 00       	call   5e3 <open>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c7                	mov    %eax,%edi
  73:	85 c0                	test   %eax,%eax
  75:	79 c9                	jns    40 <main+0x40>
      printf(1, "grep: cannot open %s\n", argv[i]);
  77:	50                   	push   %eax
  78:	ff 33                	pushl  (%ebx)
  7a:	68 a8 0a 00 00       	push   $0xaa8
  7f:	6a 01                	push   $0x1
  81:	e8 9a 06 00 00       	call   720 <printf>
      exit();
  86:	e8 18 05 00 00       	call   5a3 <exit>
  }
  exit();
  8b:	e8 13 05 00 00       	call   5a3 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 88 0a 00 00       	push   $0xa88
  97:	6a 02                	push   $0x2
  99:	e8 82 06 00 00       	call   720 <printf>
    exit();
  9e:	e8 00 05 00 00       	call   5a3 <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 83 01 00 00       	call   230 <grep>
    exit();
  ad:	e8 f1 04 00 00       	call   5a3 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  c7:	57                   	push   %edi
  c8:	56                   	push   %esi
  c9:	53                   	push   %ebx
  ca:	83 ec 0c             	sub    $0xc,%esp
  cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  d0:	8b 75 0c             	mov    0xc(%ebp),%esi
  d3:	8b 7d 10             	mov    0x10(%ebp),%edi
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	57                   	push   %edi
  e4:	56                   	push   %esi
  e5:	e8 36 00 00 00       	call   120 <matchhere>
  ea:	83 c4 10             	add    $0x10,%esp
  ed:	85 c0                	test   %eax,%eax
  ef:	75 1f                	jne    110 <matchstar+0x50>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  f1:	0f be 17             	movsbl (%edi),%edx
  f4:	84 d2                	test   %dl,%dl
  f6:	74 0c                	je     104 <matchstar+0x44>
  f8:	83 c7 01             	add    $0x1,%edi
  fb:	39 da                	cmp    %ebx,%edx
  fd:	74 e1                	je     e0 <matchstar+0x20>
  ff:	83 fb 2e             	cmp    $0x2e,%ebx
 102:	74 dc                	je     e0 <matchstar+0x20>
  return 0;
}
 104:	8d 65 f4             	lea    -0xc(%ebp),%esp
 107:	5b                   	pop    %ebx
 108:	5e                   	pop    %esi
 109:	5f                   	pop    %edi
 10a:	5d                   	pop    %ebp
 10b:	c3                   	ret    
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
 113:	b8 01 00 00 00       	mov    $0x1,%eax
}
 118:	5b                   	pop    %ebx
 119:	5e                   	pop    %esi
 11a:	5f                   	pop    %edi
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <matchhere>:
{
 120:	f3 0f 1e fb          	endbr32 
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	57                   	push   %edi
 128:	56                   	push   %esi
 129:	53                   	push   %ebx
 12a:	83 ec 0c             	sub    $0xc,%esp
 12d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 130:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 133:	0f b6 01             	movzbl (%ecx),%eax
 136:	84 c0                	test   %al,%al
 138:	75 2b                	jne    165 <matchhere+0x45>
 13a:	eb 64                	jmp    1a0 <matchhere+0x80>
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(re[0] == '$' && re[1] == '\0')
 140:	0f b6 37             	movzbl (%edi),%esi
 143:	80 fa 24             	cmp    $0x24,%dl
 146:	75 04                	jne    14c <matchhere+0x2c>
 148:	84 c0                	test   %al,%al
 14a:	74 61                	je     1ad <matchhere+0x8d>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14c:	89 f3                	mov    %esi,%ebx
 14e:	84 db                	test   %bl,%bl
 150:	74 3e                	je     190 <matchhere+0x70>
 152:	80 fa 2e             	cmp    $0x2e,%dl
 155:	74 04                	je     15b <matchhere+0x3b>
 157:	38 d3                	cmp    %dl,%bl
 159:	75 35                	jne    190 <matchhere+0x70>
    return matchhere(re+1, text+1);
 15b:	83 c7 01             	add    $0x1,%edi
 15e:	83 c1 01             	add    $0x1,%ecx
  if(re[0] == '\0')
 161:	84 c0                	test   %al,%al
 163:	74 3b                	je     1a0 <matchhere+0x80>
  if(re[1] == '*')
 165:	0f be d0             	movsbl %al,%edx
 168:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 16c:	3c 2a                	cmp    $0x2a,%al
 16e:	75 d0                	jne    140 <matchhere+0x20>
    return matchstar(re[0], re+2, text);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	83 c1 02             	add    $0x2,%ecx
 176:	57                   	push   %edi
 177:	51                   	push   %ecx
 178:	52                   	push   %edx
 179:	e8 42 ff ff ff       	call   c0 <matchstar>
 17e:	83 c4 10             	add    $0x10,%esp
}
 181:	8d 65 f4             	lea    -0xc(%ebp),%esp
 184:	5b                   	pop    %ebx
 185:	5e                   	pop    %esi
 186:	5f                   	pop    %edi
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 193:	31 c0                	xor    %eax,%eax
}
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
 1a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5f                   	pop    %edi
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
    return *text == '\0';
 1ad:	89 f0                	mov    %esi,%eax
 1af:	84 c0                	test   %al,%al
 1b1:	0f 94 c0             	sete   %al
 1b4:	0f b6 c0             	movzbl %al,%eax
 1b7:	eb c8                	jmp    181 <matchhere+0x61>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <match>:
{
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	56                   	push   %esi
 1c8:	53                   	push   %ebx
 1c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 1cf:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1d2:	75 15                	jne    1e9 <match+0x29>
 1d4:	eb 3a                	jmp    210 <match+0x50>
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1e0:	83 c6 01             	add    $0x1,%esi
 1e3:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1e7:	74 16                	je     1ff <match+0x3f>
    if(matchhere(re, text))
 1e9:	83 ec 08             	sub    $0x8,%esp
 1ec:	56                   	push   %esi
 1ed:	53                   	push   %ebx
 1ee:	e8 2d ff ff ff       	call   120 <matchhere>
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	85 c0                	test   %eax,%eax
 1f8:	74 e6                	je     1e0 <match+0x20>
      return 1;
 1fa:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
 202:	5b                   	pop    %ebx
 203:	5e                   	pop    %esi
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
 206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 210:	83 c3 01             	add    $0x1,%ebx
 213:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 216:	8d 65 f8             	lea    -0x8(%ebp),%esp
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 21c:	e9 ff fe ff ff       	jmp    120 <matchhere>
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <grep>:
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	56                   	push   %esi
 239:	53                   	push   %ebx
 23a:	83 ec 1c             	sub    $0x1c,%esp
  m = 0;
 23d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
{
 244:	8b 75 08             	mov    0x8(%ebp),%esi
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 250:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 253:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 258:	83 ec 04             	sub    $0x4,%esp
 25b:	29 c8                	sub    %ecx,%eax
 25d:	50                   	push   %eax
 25e:	8d 81 a0 0e 00 00    	lea    0xea0(%ecx),%eax
 264:	50                   	push   %eax
 265:	ff 75 0c             	pushl  0xc(%ebp)
 268:	e8 4e 03 00 00       	call   5bb <read>
 26d:	83 c4 10             	add    $0x10,%esp
 270:	85 c0                	test   %eax,%eax
 272:	0f 8e b8 00 00 00    	jle    330 <grep+0x100>
    m += n;
 278:	01 45 e4             	add    %eax,-0x1c(%ebp)
 27b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p = buf;
 27e:	bb a0 0e 00 00       	mov    $0xea0,%ebx
    buf[m] = '\0';
 283:	c6 81 a0 0e 00 00 00 	movb   $0x0,0xea0(%ecx)
    while((q = strchr(p, '\n')) != 0){
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 290:	83 ec 08             	sub    $0x8,%esp
 293:	6a 0a                	push   $0xa
 295:	53                   	push   %ebx
 296:	e8 85 01 00 00       	call   420 <strchr>
 29b:	83 c4 10             	add    $0x10,%esp
 29e:	89 c7                	mov    %eax,%edi
 2a0:	85 c0                	test   %eax,%eax
 2a2:	74 3c                	je     2e0 <grep+0xb0>
      if(match(pattern, p)){
 2a4:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 2a7:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 2aa:	53                   	push   %ebx
 2ab:	56                   	push   %esi
 2ac:	e8 0f ff ff ff       	call   1c0 <match>
 2b1:	83 c4 10             	add    $0x10,%esp
 2b4:	8d 57 01             	lea    0x1(%edi),%edx
 2b7:	85 c0                	test   %eax,%eax
 2b9:	75 05                	jne    2c0 <grep+0x90>
      p = q+1;
 2bb:	89 d3                	mov    %edx,%ebx
 2bd:	eb d1                	jmp    290 <grep+0x60>
 2bf:	90                   	nop
        write(1, p, q+1 - p);
 2c0:	89 d0                	mov    %edx,%eax
 2c2:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2c5:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2c8:	29 d8                	sub    %ebx,%eax
 2ca:	89 55 e0             	mov    %edx,-0x20(%ebp)
 2cd:	50                   	push   %eax
 2ce:	53                   	push   %ebx
 2cf:	6a 01                	push   $0x1
 2d1:	e8 ed 02 00 00       	call   5c3 <write>
 2d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
 2d9:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 2dc:	89 d3                	mov    %edx,%ebx
 2de:	eb b0                	jmp    290 <grep+0x60>
    if(p == buf)
 2e0:	81 fb a0 0e 00 00    	cmp    $0xea0,%ebx
 2e6:	74 38                	je     320 <grep+0xf0>
    if(m > 0){
 2e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 2eb:	85 c9                	test   %ecx,%ecx
 2ed:	0f 8e 5d ff ff ff    	jle    250 <grep+0x20>
      m -= p - buf;
 2f3:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2f5:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2f8:	2d a0 0e 00 00       	sub    $0xea0,%eax
 2fd:	29 c1                	sub    %eax,%ecx
      memmove(buf, p, m);
 2ff:	51                   	push   %ecx
 300:	53                   	push   %ebx
 301:	68 a0 0e 00 00       	push   $0xea0
      m -= p - buf;
 306:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
 309:	e8 62 02 00 00       	call   570 <memmove>
 30e:	83 c4 10             	add    $0x10,%esp
 311:	e9 3a ff ff ff       	jmp    250 <grep+0x20>
 316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 0;
 320:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 327:	e9 24 ff ff ff       	jmp    250 <grep+0x20>
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
 330:	8d 65 f4             	lea    -0xc(%ebp),%esp
 333:	5b                   	pop    %ebx
 334:	5e                   	pop    %esi
 335:	5f                   	pop    %edi
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	66 90                	xchg   %ax,%ax
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 345:	31 c0                	xor    %eax,%eax
{
 347:	89 e5                	mov    %esp,%ebp
 349:	53                   	push   %ebx
 34a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 34d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 350:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 354:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 357:	83 c0 01             	add    $0x1,%eax
 35a:	84 d2                	test   %dl,%dl
 35c:	75 f2                	jne    350 <strcpy+0x10>
    ;
  return os;
}
 35e:	89 c8                	mov    %ecx,%eax
 360:	5b                   	pop    %ebx
 361:	5d                   	pop    %ebp
 362:	c3                   	ret    
 363:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	53                   	push   %ebx
 378:	8b 4d 08             	mov    0x8(%ebp),%ecx
 37b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 37e:	0f b6 01             	movzbl (%ecx),%eax
 381:	0f b6 1a             	movzbl (%edx),%ebx
 384:	84 c0                	test   %al,%al
 386:	75 19                	jne    3a1 <strcmp+0x31>
 388:	eb 26                	jmp    3b0 <strcmp+0x40>
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 390:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 394:	83 c1 01             	add    $0x1,%ecx
 397:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 39a:	0f b6 1a             	movzbl (%edx),%ebx
 39d:	84 c0                	test   %al,%al
 39f:	74 0f                	je     3b0 <strcmp+0x40>
 3a1:	38 d8                	cmp    %bl,%al
 3a3:	74 eb                	je     390 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 3a5:	29 d8                	sub    %ebx,%eax
}
 3a7:	5b                   	pop    %ebx
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3b2:	29 d8                	sub    %ebx,%eax
}
 3b4:	5b                   	pop    %ebx
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
 3b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3be:	66 90                	xchg   %ax,%ax

000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	f3 0f 1e fb          	endbr32 
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3ca:	80 3a 00             	cmpb   $0x0,(%edx)
 3cd:	74 21                	je     3f0 <strlen+0x30>
 3cf:	31 c0                	xor    %eax,%eax
 3d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3d8:	83 c0 01             	add    $0x1,%eax
 3db:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3df:	89 c1                	mov    %eax,%ecx
 3e1:	75 f5                	jne    3d8 <strlen+0x18>
    ;
  return n;
}
 3e3:	89 c8                	mov    %ecx,%eax
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ee:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 3f0:	31 c9                	xor    %ecx,%ecx
}
 3f2:	5d                   	pop    %ebp
 3f3:	89 c8                	mov    %ecx,%eax
 3f5:	c3                   	ret    
 3f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi

00000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	f3 0f 1e fb          	endbr32 
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	57                   	push   %edi
 408:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 40b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40e:	8b 45 0c             	mov    0xc(%ebp),%eax
 411:	89 d7                	mov    %edx,%edi
 413:	fc                   	cld    
 414:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 416:	89 d0                	mov    %edx,%eax
 418:	5f                   	pop    %edi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret    
 41b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 41f:	90                   	nop

00000420 <strchr>:

char*
strchr(const char *s, char c)
{
 420:	f3 0f 1e fb          	endbr32 
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 42e:	0f b6 10             	movzbl (%eax),%edx
 431:	84 d2                	test   %dl,%dl
 433:	75 16                	jne    44b <strchr+0x2b>
 435:	eb 21                	jmp    458 <strchr+0x38>
 437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43e:	66 90                	xchg   %ax,%ax
 440:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 444:	83 c0 01             	add    $0x1,%eax
 447:	84 d2                	test   %dl,%dl
 449:	74 0d                	je     458 <strchr+0x38>
    if(*s == c)
 44b:	38 d1                	cmp    %dl,%cl
 44d:	75 f1                	jne    440 <strchr+0x20>
      return (char*)s;
  return 0;
}
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 458:	31 c0                	xor    %eax,%eax
}
 45a:	5d                   	pop    %ebp
 45b:	c3                   	ret    
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <gets>:

char*
gets(char *buf, int max)
{
 460:	f3 0f 1e fb          	endbr32 
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	57                   	push   %edi
 468:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 469:	31 f6                	xor    %esi,%esi
{
 46b:	53                   	push   %ebx
 46c:	89 f3                	mov    %esi,%ebx
 46e:	83 ec 1c             	sub    $0x1c,%esp
 471:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 474:	eb 33                	jmp    4a9 <gets+0x49>
 476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 480:	83 ec 04             	sub    $0x4,%esp
 483:	8d 45 e7             	lea    -0x19(%ebp),%eax
 486:	6a 01                	push   $0x1
 488:	50                   	push   %eax
 489:	6a 00                	push   $0x0
 48b:	e8 2b 01 00 00       	call   5bb <read>
    if(cc < 1)
 490:	83 c4 10             	add    $0x10,%esp
 493:	85 c0                	test   %eax,%eax
 495:	7e 1c                	jle    4b3 <gets+0x53>
      break;
    buf[i++] = c;
 497:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 49b:	83 c7 01             	add    $0x1,%edi
 49e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 4a1:	3c 0a                	cmp    $0xa,%al
 4a3:	74 23                	je     4c8 <gets+0x68>
 4a5:	3c 0d                	cmp    $0xd,%al
 4a7:	74 1f                	je     4c8 <gets+0x68>
  for(i=0; i+1 < max; ){
 4a9:	83 c3 01             	add    $0x1,%ebx
 4ac:	89 fe                	mov    %edi,%esi
 4ae:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4b1:	7c cd                	jl     480 <gets+0x20>
 4b3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 4b8:	c6 03 00             	movb   $0x0,(%ebx)
}
 4bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4be:	5b                   	pop    %ebx
 4bf:	5e                   	pop    %esi
 4c0:	5f                   	pop    %edi
 4c1:	5d                   	pop    %ebp
 4c2:	c3                   	ret    
 4c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4c7:	90                   	nop
 4c8:	8b 75 08             	mov    0x8(%ebp),%esi
 4cb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ce:	01 de                	add    %ebx,%esi
 4d0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4d2:	c6 03 00             	movb   $0x0,(%ebx)
}
 4d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d8:	5b                   	pop    %ebx
 4d9:	5e                   	pop    %esi
 4da:	5f                   	pop    %edi
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret    
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	f3 0f 1e fb          	endbr32 
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	56                   	push   %esi
 4e8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e9:	83 ec 08             	sub    $0x8,%esp
 4ec:	6a 00                	push   $0x0
 4ee:	ff 75 08             	pushl  0x8(%ebp)
 4f1:	e8 ed 00 00 00       	call   5e3 <open>
  if(fd < 0)
 4f6:	83 c4 10             	add    $0x10,%esp
 4f9:	85 c0                	test   %eax,%eax
 4fb:	78 2b                	js     528 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 4fd:	83 ec 08             	sub    $0x8,%esp
 500:	ff 75 0c             	pushl  0xc(%ebp)
 503:	89 c3                	mov    %eax,%ebx
 505:	50                   	push   %eax
 506:	e8 f0 00 00 00       	call   5fb <fstat>
  close(fd);
 50b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 50e:	89 c6                	mov    %eax,%esi
  close(fd);
 510:	e8 b6 00 00 00       	call   5cb <close>
  return r;
 515:	83 c4 10             	add    $0x10,%esp
}
 518:	8d 65 f8             	lea    -0x8(%ebp),%esp
 51b:	89 f0                	mov    %esi,%eax
 51d:	5b                   	pop    %ebx
 51e:	5e                   	pop    %esi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret    
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 528:	be ff ff ff ff       	mov    $0xffffffff,%esi
 52d:	eb e9                	jmp    518 <stat+0x38>
 52f:	90                   	nop

00000530 <atoi>:

int
atoi(const char *s)
{
 530:	f3 0f 1e fb          	endbr32 
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	53                   	push   %ebx
 538:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 53b:	0f be 02             	movsbl (%edx),%eax
 53e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 541:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 544:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 549:	77 1a                	ja     565 <atoi+0x35>
 54b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
    n = n*10 + *s++ - '0';
 550:	83 c2 01             	add    $0x1,%edx
 553:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 556:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 55a:	0f be 02             	movsbl (%edx),%eax
 55d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 560:	80 fb 09             	cmp    $0x9,%bl
 563:	76 eb                	jbe    550 <atoi+0x20>
  return n;
}
 565:	89 c8                	mov    %ecx,%eax
 567:	5b                   	pop    %ebx
 568:	5d                   	pop    %ebp
 569:	c3                   	ret    
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000570 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 570:	f3 0f 1e fb          	endbr32 
 574:	55                   	push   %ebp
 575:	89 e5                	mov    %esp,%ebp
 577:	57                   	push   %edi
 578:	8b 45 10             	mov    0x10(%ebp),%eax
 57b:	8b 55 08             	mov    0x8(%ebp),%edx
 57e:	56                   	push   %esi
 57f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 582:	85 c0                	test   %eax,%eax
 584:	7e 0f                	jle    595 <memmove+0x25>
 586:	01 d0                	add    %edx,%eax
  dst = vdst;
 588:	89 d7                	mov    %edx,%edi
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 590:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 591:	39 f8                	cmp    %edi,%eax
 593:	75 fb                	jne    590 <memmove+0x20>
  return vdst;
}
 595:	5e                   	pop    %esi
 596:	89 d0                	mov    %edx,%eax
 598:	5f                   	pop    %edi
 599:	5d                   	pop    %ebp
 59a:	c3                   	ret    

0000059b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 59b:	b8 01 00 00 00       	mov    $0x1,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <exit>:
SYSCALL(exit)
 5a3:	b8 02 00 00 00       	mov    $0x2,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <wait>:
SYSCALL(wait)
 5ab:	b8 03 00 00 00       	mov    $0x3,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <pipe>:
SYSCALL(pipe)
 5b3:	b8 04 00 00 00       	mov    $0x4,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <read>:
SYSCALL(read)
 5bb:	b8 05 00 00 00       	mov    $0x5,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <write>:
SYSCALL(write)
 5c3:	b8 10 00 00 00       	mov    $0x10,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <close>:
SYSCALL(close)
 5cb:	b8 15 00 00 00       	mov    $0x15,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <kill>:
SYSCALL(kill)
 5d3:	b8 06 00 00 00       	mov    $0x6,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <exec>:
SYSCALL(exec)
 5db:	b8 07 00 00 00       	mov    $0x7,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <open>:
SYSCALL(open)
 5e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <mknod>:
SYSCALL(mknod)
 5eb:	b8 11 00 00 00       	mov    $0x11,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <unlink>:
SYSCALL(unlink)
 5f3:	b8 12 00 00 00       	mov    $0x12,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <fstat>:
SYSCALL(fstat)
 5fb:	b8 08 00 00 00       	mov    $0x8,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <link>:
SYSCALL(link)
 603:	b8 13 00 00 00       	mov    $0x13,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <mkdir>:
SYSCALL(mkdir)
 60b:	b8 14 00 00 00       	mov    $0x14,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <chdir>:
SYSCALL(chdir)
 613:	b8 09 00 00 00       	mov    $0x9,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <dup>:
SYSCALL(dup)
 61b:	b8 0a 00 00 00       	mov    $0xa,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <getpid>:
SYSCALL(getpid)
 623:	b8 0b 00 00 00       	mov    $0xb,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <sbrk>:
SYSCALL(sbrk)
 62b:	b8 0c 00 00 00       	mov    $0xc,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <sleep>:
SYSCALL(sleep)
 633:	b8 0d 00 00 00       	mov    $0xd,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <uptime>:
SYSCALL(uptime)
 63b:	b8 0e 00 00 00       	mov    $0xe,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <find_digital_root>:
SYSCALL(find_digital_root)
 643:	b8 16 00 00 00       	mov    $0x16,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <get_process_lifetime>:
SYSCALL(get_process_lifetime)
 64b:	b8 17 00 00 00       	mov    $0x17,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <copy_file>:
SYSCALL(copy_file)
 653:	b8 18 00 00 00       	mov    $0x18,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <get_uncle_count>:
SYSCALL(get_uncle_count)
 65b:	b8 19 00 00 00       	mov    $0x19,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    
 663:	66 90                	xchg   %ax,%ax
 665:	66 90                	xchg   %ax,%ax
 667:	66 90                	xchg   %ax,%ax
 669:	66 90                	xchg   %ax,%ax
 66b:	66 90                	xchg   %ax,%ax
 66d:	66 90                	xchg   %ax,%ax
 66f:	90                   	nop

00000670 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 3c             	sub    $0x3c,%esp
 679:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 67c:	89 d1                	mov    %edx,%ecx
{
 67e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 681:	85 d2                	test   %edx,%edx
 683:	0f 89 7f 00 00 00    	jns    708 <printint+0x98>
 689:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 68d:	74 79                	je     708 <printint+0x98>
    neg = 1;
 68f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 696:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 698:	31 db                	xor    %ebx,%ebx
 69a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6a0:	89 c8                	mov    %ecx,%eax
 6a2:	31 d2                	xor    %edx,%edx
 6a4:	89 cf                	mov    %ecx,%edi
 6a6:	f7 75 c4             	divl   -0x3c(%ebp)
 6a9:	0f b6 92 c8 0a 00 00 	movzbl 0xac8(%edx),%edx
 6b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6b3:	89 d8                	mov    %ebx,%eax
 6b5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 6b8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 6bb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 6be:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 6c1:	76 dd                	jbe    6a0 <printint+0x30>
  if(neg)
 6c3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 6c6:	85 c9                	test   %ecx,%ecx
 6c8:	74 0c                	je     6d6 <printint+0x66>
    buf[i++] = '-';
 6ca:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 6cf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 6d1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 6d6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 6d9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 6dd:	eb 07                	jmp    6e6 <printint+0x76>
 6df:	90                   	nop
 6e0:	0f b6 13             	movzbl (%ebx),%edx
 6e3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 6e6:	83 ec 04             	sub    $0x4,%esp
 6e9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 6ec:	6a 01                	push   $0x1
 6ee:	56                   	push   %esi
 6ef:	57                   	push   %edi
 6f0:	e8 ce fe ff ff       	call   5c3 <write>
  while(--i >= 0)
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	39 de                	cmp    %ebx,%esi
 6fa:	75 e4                	jne    6e0 <printint+0x70>
    putc(fd, buf[i]);
}
 6fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ff:	5b                   	pop    %ebx
 700:	5e                   	pop    %esi
 701:	5f                   	pop    %edi
 702:	5d                   	pop    %ebp
 703:	c3                   	ret    
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 708:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 70f:	eb 87                	jmp    698 <printint+0x28>
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop

00000720 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 720:	f3 0f 1e fb          	endbr32 
 724:	55                   	push   %ebp
 725:	89 e5                	mov    %esp,%ebp
 727:	57                   	push   %edi
 728:	56                   	push   %esi
 729:	53                   	push   %ebx
 72a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72d:	8b 75 0c             	mov    0xc(%ebp),%esi
 730:	0f b6 1e             	movzbl (%esi),%ebx
 733:	84 db                	test   %bl,%bl
 735:	0f 84 b4 00 00 00    	je     7ef <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 73b:	8d 45 10             	lea    0x10(%ebp),%eax
 73e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 741:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 744:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 746:	89 45 d0             	mov    %eax,-0x30(%ebp)
 749:	eb 33                	jmp    77e <printf+0x5e>
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
 750:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 753:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 758:	83 f8 25             	cmp    $0x25,%eax
 75b:	74 17                	je     774 <printf+0x54>
  write(fd, &c, 1);
 75d:	83 ec 04             	sub    $0x4,%esp
 760:	88 5d e7             	mov    %bl,-0x19(%ebp)
 763:	6a 01                	push   $0x1
 765:	57                   	push   %edi
 766:	ff 75 08             	pushl  0x8(%ebp)
 769:	e8 55 fe ff ff       	call   5c3 <write>
 76e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 771:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 774:	0f b6 1e             	movzbl (%esi),%ebx
 777:	83 c6 01             	add    $0x1,%esi
 77a:	84 db                	test   %bl,%bl
 77c:	74 71                	je     7ef <printf+0xcf>
    c = fmt[i] & 0xff;
 77e:	0f be cb             	movsbl %bl,%ecx
 781:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 784:	85 d2                	test   %edx,%edx
 786:	74 c8                	je     750 <printf+0x30>
      }
    } else if(state == '%'){
 788:	83 fa 25             	cmp    $0x25,%edx
 78b:	75 e7                	jne    774 <printf+0x54>
      if(c == 'd'){
 78d:	83 f8 64             	cmp    $0x64,%eax
 790:	0f 84 9a 00 00 00    	je     830 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 796:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 79c:	83 f9 70             	cmp    $0x70,%ecx
 79f:	74 5f                	je     800 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7a1:	83 f8 73             	cmp    $0x73,%eax
 7a4:	0f 84 d6 00 00 00    	je     880 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7aa:	83 f8 63             	cmp    $0x63,%eax
 7ad:	0f 84 8d 00 00 00    	je     840 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7b3:	83 f8 25             	cmp    $0x25,%eax
 7b6:	0f 84 b4 00 00 00    	je     870 <printf+0x150>
  write(fd, &c, 1);
 7bc:	83 ec 04             	sub    $0x4,%esp
 7bf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7c3:	6a 01                	push   $0x1
 7c5:	57                   	push   %edi
 7c6:	ff 75 08             	pushl  0x8(%ebp)
 7c9:	e8 f5 fd ff ff       	call   5c3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7ce:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 7d1:	83 c4 0c             	add    $0xc,%esp
 7d4:	6a 01                	push   $0x1
 7d6:	83 c6 01             	add    $0x1,%esi
 7d9:	57                   	push   %edi
 7da:	ff 75 08             	pushl  0x8(%ebp)
 7dd:	e8 e1 fd ff ff       	call   5c3 <write>
  for(i = 0; fmt[i]; i++){
 7e2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 7e6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7e9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 7eb:	84 db                	test   %bl,%bl
 7ed:	75 8f                	jne    77e <printf+0x5e>
    }
  }
}
 7ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7f2:	5b                   	pop    %ebx
 7f3:	5e                   	pop    %esi
 7f4:	5f                   	pop    %edi
 7f5:	5d                   	pop    %ebp
 7f6:	c3                   	ret    
 7f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 800:	83 ec 0c             	sub    $0xc,%esp
 803:	b9 10 00 00 00       	mov    $0x10,%ecx
 808:	6a 00                	push   $0x0
 80a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
 810:	8b 13                	mov    (%ebx),%edx
 812:	e8 59 fe ff ff       	call   670 <printint>
        ap++;
 817:	89 d8                	mov    %ebx,%eax
 819:	83 c4 10             	add    $0x10,%esp
      state = 0;
 81c:	31 d2                	xor    %edx,%edx
        ap++;
 81e:	83 c0 04             	add    $0x4,%eax
 821:	89 45 d0             	mov    %eax,-0x30(%ebp)
 824:	e9 4b ff ff ff       	jmp    774 <printf+0x54>
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 830:	83 ec 0c             	sub    $0xc,%esp
 833:	b9 0a 00 00 00       	mov    $0xa,%ecx
 838:	6a 01                	push   $0x1
 83a:	eb ce                	jmp    80a <printf+0xea>
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 840:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 843:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 846:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 848:	6a 01                	push   $0x1
        ap++;
 84a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 84d:	57                   	push   %edi
 84e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 851:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 854:	e8 6a fd ff ff       	call   5c3 <write>
        ap++;
 859:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 85c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 85f:	31 d2                	xor    %edx,%edx
 861:	e9 0e ff ff ff       	jmp    774 <printf+0x54>
 866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 870:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 873:	83 ec 04             	sub    $0x4,%esp
 876:	e9 59 ff ff ff       	jmp    7d4 <printf+0xb4>
 87b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 87f:	90                   	nop
        s = (char*)*ap;
 880:	8b 45 d0             	mov    -0x30(%ebp),%eax
 883:	8b 18                	mov    (%eax),%ebx
        ap++;
 885:	83 c0 04             	add    $0x4,%eax
 888:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 88b:	85 db                	test   %ebx,%ebx
 88d:	74 17                	je     8a6 <printf+0x186>
        while(*s != 0){
 88f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 892:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 894:	84 c0                	test   %al,%al
 896:	0f 84 d8 fe ff ff    	je     774 <printf+0x54>
 89c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 89f:	89 de                	mov    %ebx,%esi
 8a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8a4:	eb 1a                	jmp    8c0 <printf+0x1a0>
          s = "(null)";
 8a6:	bb be 0a 00 00       	mov    $0xabe,%ebx
        while(*s != 0){
 8ab:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8ae:	b8 28 00 00 00       	mov    $0x28,%eax
 8b3:	89 de                	mov    %ebx,%esi
 8b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop
  write(fd, &c, 1);
 8c0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8c3:	83 c6 01             	add    $0x1,%esi
 8c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8c9:	6a 01                	push   $0x1
 8cb:	57                   	push   %edi
 8cc:	53                   	push   %ebx
 8cd:	e8 f1 fc ff ff       	call   5c3 <write>
        while(*s != 0){
 8d2:	0f b6 06             	movzbl (%esi),%eax
 8d5:	83 c4 10             	add    $0x10,%esp
 8d8:	84 c0                	test   %al,%al
 8da:	75 e4                	jne    8c0 <printf+0x1a0>
 8dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 8df:	31 d2                	xor    %edx,%edx
 8e1:	e9 8e fe ff ff       	jmp    774 <printf+0x54>
 8e6:	66 90                	xchg   %ax,%ax
 8e8:	66 90                	xchg   %ax,%ax
 8ea:	66 90                	xchg   %ax,%ax
 8ec:	66 90                	xchg   %ax,%ax
 8ee:	66 90                	xchg   %ax,%ax

000008f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f0:	f3 0f 1e fb          	endbr32 
 8f4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f5:	a1 80 0e 00 00       	mov    0xe80,%eax
{
 8fa:	89 e5                	mov    %esp,%ebp
 8fc:	57                   	push   %edi
 8fd:	56                   	push   %esi
 8fe:	53                   	push   %ebx
 8ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
 902:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 904:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 907:	39 c8                	cmp    %ecx,%eax
 909:	73 15                	jae    920 <free+0x30>
 90b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 90f:	90                   	nop
 910:	39 d1                	cmp    %edx,%ecx
 912:	72 14                	jb     928 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 914:	39 d0                	cmp    %edx,%eax
 916:	73 10                	jae    928 <free+0x38>
{
 918:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91a:	8b 10                	mov    (%eax),%edx
 91c:	39 c8                	cmp    %ecx,%eax
 91e:	72 f0                	jb     910 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 920:	39 d0                	cmp    %edx,%eax
 922:	72 f4                	jb     918 <free+0x28>
 924:	39 d1                	cmp    %edx,%ecx
 926:	73 f0                	jae    918 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	8b 73 fc             	mov    -0x4(%ebx),%esi
 92b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 92e:	39 fa                	cmp    %edi,%edx
 930:	74 1e                	je     950 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 932:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 935:	8b 50 04             	mov    0x4(%eax),%edx
 938:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 93b:	39 f1                	cmp    %esi,%ecx
 93d:	74 28                	je     967 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 93f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 941:	5b                   	pop    %ebx
  freep = p;
 942:	a3 80 0e 00 00       	mov    %eax,0xe80
}
 947:	5e                   	pop    %esi
 948:	5f                   	pop    %edi
 949:	5d                   	pop    %ebp
 94a:	c3                   	ret    
 94b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 94f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 950:	03 72 04             	add    0x4(%edx),%esi
 953:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 956:	8b 10                	mov    (%eax),%edx
 958:	8b 12                	mov    (%edx),%edx
 95a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 95d:	8b 50 04             	mov    0x4(%eax),%edx
 960:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 963:	39 f1                	cmp    %esi,%ecx
 965:	75 d8                	jne    93f <free+0x4f>
    p->s.size += bp->s.size;
 967:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 96a:	a3 80 0e 00 00       	mov    %eax,0xe80
    p->s.size += bp->s.size;
 96f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 972:	8b 53 f8             	mov    -0x8(%ebx),%edx
 975:	89 10                	mov    %edx,(%eax)
}
 977:	5b                   	pop    %ebx
 978:	5e                   	pop    %esi
 979:	5f                   	pop    %edi
 97a:	5d                   	pop    %ebp
 97b:	c3                   	ret    
 97c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000980 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 980:	f3 0f 1e fb          	endbr32 
 984:	55                   	push   %ebp
 985:	89 e5                	mov    %esp,%ebp
 987:	57                   	push   %edi
 988:	56                   	push   %esi
 989:	53                   	push   %ebx
 98a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 98d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 990:	8b 3d 80 0e 00 00    	mov    0xe80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 996:	8d 70 07             	lea    0x7(%eax),%esi
 999:	c1 ee 03             	shr    $0x3,%esi
 99c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 99f:	85 ff                	test   %edi,%edi
 9a1:	0f 84 a9 00 00 00    	je     a50 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 9a9:	8b 48 04             	mov    0x4(%eax),%ecx
 9ac:	39 f1                	cmp    %esi,%ecx
 9ae:	73 6d                	jae    a1d <malloc+0x9d>
 9b0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 9b6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9bb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 9be:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 9c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 9c8:	eb 17                	jmp    9e1 <malloc+0x61>
 9ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 9d2:	8b 4a 04             	mov    0x4(%edx),%ecx
 9d5:	39 f1                	cmp    %esi,%ecx
 9d7:	73 4f                	jae    a28 <malloc+0xa8>
 9d9:	8b 3d 80 0e 00 00    	mov    0xe80,%edi
 9df:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e1:	39 c7                	cmp    %eax,%edi
 9e3:	75 eb                	jne    9d0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 9e5:	83 ec 0c             	sub    $0xc,%esp
 9e8:	ff 75 e4             	pushl  -0x1c(%ebp)
 9eb:	e8 3b fc ff ff       	call   62b <sbrk>
  if(p == (char*)-1)
 9f0:	83 c4 10             	add    $0x10,%esp
 9f3:	83 f8 ff             	cmp    $0xffffffff,%eax
 9f6:	74 1b                	je     a13 <malloc+0x93>
  hp->s.size = nu;
 9f8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 9fb:	83 ec 0c             	sub    $0xc,%esp
 9fe:	83 c0 08             	add    $0x8,%eax
 a01:	50                   	push   %eax
 a02:	e8 e9 fe ff ff       	call   8f0 <free>
  return freep;
 a07:	a1 80 0e 00 00       	mov    0xe80,%eax
      if((p = morecore(nunits)) == 0)
 a0c:	83 c4 10             	add    $0x10,%esp
 a0f:	85 c0                	test   %eax,%eax
 a11:	75 bd                	jne    9d0 <malloc+0x50>
        return 0;
  }
}
 a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a16:	31 c0                	xor    %eax,%eax
}
 a18:	5b                   	pop    %ebx
 a19:	5e                   	pop    %esi
 a1a:	5f                   	pop    %edi
 a1b:	5d                   	pop    %ebp
 a1c:	c3                   	ret    
    if(p->s.size >= nunits){
 a1d:	89 c2                	mov    %eax,%edx
 a1f:	89 f8                	mov    %edi,%eax
 a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 a28:	39 ce                	cmp    %ecx,%esi
 a2a:	74 54                	je     a80 <malloc+0x100>
        p->s.size -= nunits;
 a2c:	29 f1                	sub    %esi,%ecx
 a2e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a31:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a34:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 a37:	a3 80 0e 00 00       	mov    %eax,0xe80
}
 a3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a3f:	8d 42 08             	lea    0x8(%edx),%eax
}
 a42:	5b                   	pop    %ebx
 a43:	5e                   	pop    %esi
 a44:	5f                   	pop    %edi
 a45:	5d                   	pop    %ebp
 a46:	c3                   	ret    
 a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a4e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 a50:	c7 05 80 0e 00 00 84 	movl   $0xe84,0xe80
 a57:	0e 00 00 
    base.s.size = 0;
 a5a:	bf 84 0e 00 00       	mov    $0xe84,%edi
    base.s.ptr = freep = prevp = &base;
 a5f:	c7 05 84 0e 00 00 84 	movl   $0xe84,0xe84
 a66:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a69:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 a6b:	c7 05 88 0e 00 00 00 	movl   $0x0,0xe88
 a72:	00 00 00 
    if(p->s.size >= nunits){
 a75:	e9 36 ff ff ff       	jmp    9b0 <malloc+0x30>
 a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a80:	8b 0a                	mov    (%edx),%ecx
 a82:	89 08                	mov    %ecx,(%eax)
 a84:	eb b1                	jmp    a37 <malloc+0xb7>
