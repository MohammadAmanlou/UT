
_strdiff:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
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
  15:	83 ec 28             	sub    $0x28,%esp
    if(argc != 3){
  18:	83 39 03             	cmpl   $0x3,(%ecx)
{
  1b:	8b 41 04             	mov    0x4(%ecx),%eax
    if(argc != 3){
  1e:	74 13                	je     33 <main+0x33>
        printf(2, "Usage: strdiff <string1> <string2>\n");
  20:	51                   	push   %ecx
  21:	51                   	push   %ecx
  22:	68 88 08 00 00       	push   $0x888
  27:	6a 02                	push   $0x2
  29:	e8 f2 04 00 00       	call   520 <printf>
        exit();
  2e:	e8 90 03 00 00       	call   3c3 <exit>
    }
    char *str1 = argv[1];
    char *str2 = argv[2];
    
    int i = 0;
    unlink("strdiff_result.txt");
  33:	83 ec 0c             	sub    $0xc,%esp
    char *str1 = argv[1];
  36:	8b 70 04             	mov    0x4(%eax),%esi
    char *str2 = argv[2];
  39:	8b 78 08             	mov    0x8(%eax),%edi
    unlink("strdiff_result.txt");
  3c:	68 dc 08 00 00       	push   $0x8dc
    char *str1 = argv[1];
  41:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    unlink("strdiff_result.txt");
  44:	e8 ca 03 00 00       	call   413 <unlink>
    int fd = open("strdiff_result.txt", O_CREATE | O_RDWR);
  49:	58                   	pop    %eax
  4a:	5a                   	pop    %edx
  4b:	68 02 02 00 00       	push   $0x202
  50:	68 dc 08 00 00       	push   $0x8dc
  55:	e8 a9 03 00 00       	call   403 <open>
    if(fd < 0){
  5a:	83 c4 10             	add    $0x10,%esp
    int fd = open("strdiff_result.txt", O_CREATE | O_RDWR);
  5d:	89 c3                	mov    %eax,%ebx
    if(fd < 0){
  5f:	85 c0                	test   %eax,%eax
  61:	0f 88 dc 00 00 00    	js     143 <main+0x143>
        printf(2, "strdiff: cannot open/create strdiff_result.txt\n");
        exit();
    }
    while(str1[i] != '\0' && str2[i] != '\0'){
  67:	0f b6 06             	movzbl (%esi),%eax
    int i = 0;
  6a:	31 d2                	xor    %edx,%edx
  6c:	8d 75 e6             	lea    -0x1a(%ebp),%esi
    while(str1[i] != '\0' && str2[i] != '\0'){
  6f:	31 c9                	xor    %ecx,%ecx
  71:	84 c0                	test   %al,%al
  73:	0f 84 8b 00 00 00    	je     104 <main+0x104>
  79:	89 5d d0             	mov    %ebx,-0x30(%ebp)
  7c:	89 d3                	mov    %edx,%ebx
  7e:	eb 32                	jmp    b2 <main+0xb2>
         if(str1[i] != str2[i]){
  80:	38 c1                	cmp    %al,%cl
  82:	74 1e                	je     a2 <main+0xa2>
             char diff[2];
             if(((int)str1[i]) < ((int)str2[i])){
                 diff[0] = '1';
             }
             else{
                 diff[0] = '0';
  84:	0f 9f c0             	setg   %al
             }
             diff[1] = '\0';
             write(fd, diff, 1);
  87:	83 ec 04             	sub    $0x4,%esp
             diff[1] = '\0';
  8a:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
             write(fd, diff, 1);
  8e:	6a 01                	push   $0x1
                 diff[0] = '0';
  90:	83 c0 30             	add    $0x30,%eax
             write(fd, diff, 1);
  93:	56                   	push   %esi
  94:	ff 75 d0             	pushl  -0x30(%ebp)
  97:	88 45 e6             	mov    %al,-0x1a(%ebp)
  9a:	e8 44 03 00 00       	call   3e3 <write>
  9f:	83 c4 10             	add    $0x10,%esp
    while(str1[i] != '\0' && str2[i] != '\0'){
  a2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
         }
         i++;
  a5:	83 c3 01             	add    $0x1,%ebx
    while(str1[i] != '\0' && str2[i] != '\0'){
  a8:	89 d9                	mov    %ebx,%ecx
  aa:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
  ae:	84 c0                	test   %al,%al
  b0:	74 4d                	je     ff <main+0xff>
  b2:	0f b6 0c 1f          	movzbl (%edi,%ebx,1),%ecx
  b6:	84 c9                	test   %cl,%cl
  b8:	75 c6                	jne    80 <main+0x80>
  ba:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  bd:	89 da                	mov    %ebx,%edx
  bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  c2:	01 d7                	add    %edx,%edi
  c4:	eb 13                	jmp    d9 <main+0xd9>
        while(str1[i] != '\0'){
            //printf(1, "%d", 0);
            char diff[2];
            diff[0] = '0';
            diff[1] = '\0';
            write(fd, diff, 1);
  c6:	50                   	push   %eax
  c7:	6a 01                	push   $0x1
  c9:	56                   	push   %esi
  ca:	53                   	push   %ebx
            diff[0] = '0';
  cb:	66 c7 45 e6 30 00    	movw   $0x30,-0x1a(%ebp)
            write(fd, diff, 1);
  d1:	e8 0d 03 00 00       	call   3e3 <write>
            i++;
  d6:	83 c4 10             	add    $0x10,%esp
        while(str1[i] != '\0'){
  d9:	83 c7 01             	add    $0x1,%edi
  dc:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
  e0:	75 e4                	jne    c6 <main+0xc6>
        }
    }
    char diff[2];
    diff[0] = '\n';
    diff[1] = '\0';
    write(fd, diff, 1);
  e2:	52                   	push   %edx
  e3:	6a 01                	push   $0x1
  e5:	56                   	push   %esi
  e6:	53                   	push   %ebx
    diff[0] = '\n';
  e7:	66 c7 45 e6 0a 00    	movw   $0xa,-0x1a(%ebp)
    write(fd, diff, 1);
  ed:	e8 f1 02 00 00       	call   3e3 <write>
    close(fd);
  f2:	89 1c 24             	mov    %ebx,(%esp)
  f5:	e8 f1 02 00 00       	call   3eb <close>
    exit();
  fa:	e8 c4 02 00 00       	call   3c3 <exit>
  ff:	89 da                	mov    %ebx,%edx
 101:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    if(str2[i] != '\0'){
 104:	80 3c 0f 00          	cmpb   $0x0,(%edi,%ecx,1)
 108:	74 d8                	je     e2 <main+0xe2>
        while(str2[i] != '\0'){
 10a:	80 3c 17 00          	cmpb   $0x0,(%edi,%edx,1)
 10e:	8d 4c 17 01          	lea    0x1(%edi,%edx,1),%ecx
 112:	74 ce                	je     e2 <main+0xe2>
 114:	89 cf                	mov    %ecx,%edi
 116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11d:	8d 76 00             	lea    0x0(%esi),%esi
            write(fd, diff, 1);
 120:	83 ec 04             	sub    $0x4,%esp
            diff[0] = '1';
 123:	b9 31 00 00 00       	mov    $0x31,%ecx
 128:	83 c7 01             	add    $0x1,%edi
            write(fd, diff, 1);
 12b:	6a 01                	push   $0x1
 12d:	56                   	push   %esi
 12e:	53                   	push   %ebx
            diff[0] = '1';
 12f:	66 89 4d e6          	mov    %cx,-0x1a(%ebp)
            write(fd, diff, 1);
 133:	e8 ab 02 00 00       	call   3e3 <write>
        while(str2[i] != '\0'){
 138:	83 c4 10             	add    $0x10,%esp
 13b:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 13f:	75 df                	jne    120 <main+0x120>
 141:	eb 9f                	jmp    e2 <main+0xe2>
        printf(2, "strdiff: cannot open/create strdiff_result.txt\n");
 143:	53                   	push   %ebx
 144:	53                   	push   %ebx
 145:	68 ac 08 00 00       	push   $0x8ac
 14a:	6a 02                	push   $0x2
 14c:	e8 cf 03 00 00       	call   520 <printf>
        exit();
 151:	e8 6d 02 00 00       	call   3c3 <exit>
 156:	66 90                	xchg   %ax,%ax
 158:	66 90                	xchg   %ax,%ax
 15a:	66 90                	xchg   %ax,%ax
 15c:	66 90                	xchg   %ax,%ax
 15e:	66 90                	xchg   %ax,%ax

00000160 <strcpy>:
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	31 c0                	xor    %eax,%eax
 167:	89 e5                	mov    %esp,%ebp
 169:	53                   	push   %ebx
 16a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 16d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
 17e:	89 c8                	mov    %ecx,%eax
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <strcmp>:
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	53                   	push   %ebx
 198:	8b 4d 08             	mov    0x8(%ebp),%ecx
 19b:	8b 55 0c             	mov    0xc(%ebp),%edx
 19e:	0f b6 01             	movzbl (%ecx),%eax
 1a1:	0f b6 1a             	movzbl (%edx),%ebx
 1a4:	84 c0                	test   %al,%al
 1a6:	75 19                	jne    1c1 <strcmp+0x31>
 1a8:	eb 26                	jmp    1d0 <strcmp+0x40>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1b0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 1b4:	83 c1 01             	add    $0x1,%ecx
 1b7:	83 c2 01             	add    $0x1,%edx
 1ba:	0f b6 1a             	movzbl (%edx),%ebx
 1bd:	84 c0                	test   %al,%al
 1bf:	74 0f                	je     1d0 <strcmp+0x40>
 1c1:	38 d8                	cmp    %bl,%al
 1c3:	74 eb                	je     1b0 <strcmp+0x20>
 1c5:	29 d8                	sub    %ebx,%eax
 1c7:	5b                   	pop    %ebx
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	31 c0                	xor    %eax,%eax
 1d2:	29 d8                	sub    %ebx,%eax
 1d4:	5b                   	pop    %ebx
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strlen>:
 1e0:	f3 0f 1e fb          	endbr32 
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	8b 55 08             	mov    0x8(%ebp),%edx
 1ea:	80 3a 00             	cmpb   $0x0,(%edx)
 1ed:	74 21                	je     210 <strlen+0x30>
 1ef:	31 c0                	xor    %eax,%eax
 1f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1ff:	89 c1                	mov    %eax,%ecx
 201:	75 f5                	jne    1f8 <strlen+0x18>
 203:	89 c8                	mov    %ecx,%eax
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax
 210:	31 c9                	xor    %ecx,%ecx
 212:	5d                   	pop    %ebp
 213:	89 c8                	mov    %ecx,%eax
 215:	c3                   	ret    
 216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <memset>:
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	57                   	push   %edi
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	89 d7                	mov    %edx,%edi
 233:	fc                   	cld    
 234:	f3 aa                	rep stos %al,%es:(%edi)
 236:	89 d0                	mov    %edx,%eax
 238:	5f                   	pop    %edi
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop

00000240 <strchr>:
 240:	f3 0f 1e fb          	endbr32 
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 24e:	0f b6 10             	movzbl (%eax),%edx
 251:	84 d2                	test   %dl,%dl
 253:	75 16                	jne    26b <strchr+0x2b>
 255:	eb 21                	jmp    278 <strchr+0x38>
 257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25e:	66 90                	xchg   %ax,%ax
 260:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 264:	83 c0 01             	add    $0x1,%eax
 267:	84 d2                	test   %dl,%dl
 269:	74 0d                	je     278 <strchr+0x38>
 26b:	38 d1                	cmp    %dl,%cl
 26d:	75 f1                	jne    260 <strchr+0x20>
 26f:	5d                   	pop    %ebp
 270:	c3                   	ret    
 271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 278:	31 c0                	xor    %eax,%eax
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <gets>:
 280:	f3 0f 1e fb          	endbr32 
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	57                   	push   %edi
 288:	56                   	push   %esi
 289:	31 f6                	xor    %esi,%esi
 28b:	53                   	push   %ebx
 28c:	89 f3                	mov    %esi,%ebx
 28e:	83 ec 1c             	sub    $0x1c,%esp
 291:	8b 7d 08             	mov    0x8(%ebp),%edi
 294:	eb 33                	jmp    2c9 <gets+0x49>
 296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29d:	8d 76 00             	lea    0x0(%esi),%esi
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2a6:	6a 01                	push   $0x1
 2a8:	50                   	push   %eax
 2a9:	6a 00                	push   $0x0
 2ab:	e8 2b 01 00 00       	call   3db <read>
 2b0:	83 c4 10             	add    $0x10,%esp
 2b3:	85 c0                	test   %eax,%eax
 2b5:	7e 1c                	jle    2d3 <gets+0x53>
 2b7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2bb:	83 c7 01             	add    $0x1,%edi
 2be:	88 47 ff             	mov    %al,-0x1(%edi)
 2c1:	3c 0a                	cmp    $0xa,%al
 2c3:	74 23                	je     2e8 <gets+0x68>
 2c5:	3c 0d                	cmp    $0xd,%al
 2c7:	74 1f                	je     2e8 <gets+0x68>
 2c9:	83 c3 01             	add    $0x1,%ebx
 2cc:	89 fe                	mov    %edi,%esi
 2ce:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d1:	7c cd                	jl     2a0 <gets+0x20>
 2d3:	89 f3                	mov    %esi,%ebx
 2d5:	8b 45 08             	mov    0x8(%ebp),%eax
 2d8:	c6 03 00             	movb   $0x0,(%ebx)
 2db:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2de:	5b                   	pop    %ebx
 2df:	5e                   	pop    %esi
 2e0:	5f                   	pop    %edi
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e7:	90                   	nop
 2e8:	8b 75 08             	mov    0x8(%ebp),%esi
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	01 de                	add    %ebx,%esi
 2f0:	89 f3                	mov    %esi,%ebx
 2f2:	c6 03 00             	movb   $0x0,(%ebx)
 2f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f8:	5b                   	pop    %ebx
 2f9:	5e                   	pop    %esi
 2fa:	5f                   	pop    %edi
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
 2fd:	8d 76 00             	lea    0x0(%esi),%esi

00000300 <stat>:
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	56                   	push   %esi
 308:	53                   	push   %ebx
 309:	83 ec 08             	sub    $0x8,%esp
 30c:	6a 00                	push   $0x0
 30e:	ff 75 08             	pushl  0x8(%ebp)
 311:	e8 ed 00 00 00       	call   403 <open>
 316:	83 c4 10             	add    $0x10,%esp
 319:	85 c0                	test   %eax,%eax
 31b:	78 2b                	js     348 <stat+0x48>
 31d:	83 ec 08             	sub    $0x8,%esp
 320:	ff 75 0c             	pushl  0xc(%ebp)
 323:	89 c3                	mov    %eax,%ebx
 325:	50                   	push   %eax
 326:	e8 f0 00 00 00       	call   41b <fstat>
 32b:	89 1c 24             	mov    %ebx,(%esp)
 32e:	89 c6                	mov    %eax,%esi
 330:	e8 b6 00 00 00       	call   3eb <close>
 335:	83 c4 10             	add    $0x10,%esp
 338:	8d 65 f8             	lea    -0x8(%ebp),%esp
 33b:	89 f0                	mov    %esi,%eax
 33d:	5b                   	pop    %ebx
 33e:	5e                   	pop    %esi
 33f:	5d                   	pop    %ebp
 340:	c3                   	ret    
 341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 348:	be ff ff ff ff       	mov    $0xffffffff,%esi
 34d:	eb e9                	jmp    338 <stat+0x38>
 34f:	90                   	nop

00000350 <atoi>:
 350:	f3 0f 1e fb          	endbr32 
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	53                   	push   %ebx
 358:	8b 55 08             	mov    0x8(%ebp),%edx
 35b:	0f be 02             	movsbl (%edx),%eax
 35e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 361:	80 f9 09             	cmp    $0x9,%cl
 364:	b9 00 00 00 00       	mov    $0x0,%ecx
 369:	77 1a                	ja     385 <atoi+0x35>
 36b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 36f:	90                   	nop
 370:	83 c2 01             	add    $0x1,%edx
 373:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 376:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 37a:	0f be 02             	movsbl (%edx),%eax
 37d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
 385:	89 c8                	mov    %ecx,%eax
 387:	5b                   	pop    %ebx
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <memmove>:
 390:	f3 0f 1e fb          	endbr32 
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
 397:	57                   	push   %edi
 398:	8b 45 10             	mov    0x10(%ebp),%eax
 39b:	8b 55 08             	mov    0x8(%ebp),%edx
 39e:	56                   	push   %esi
 39f:	8b 75 0c             	mov    0xc(%ebp),%esi
 3a2:	85 c0                	test   %eax,%eax
 3a4:	7e 0f                	jle    3b5 <memmove+0x25>
 3a6:	01 d0                	add    %edx,%eax
 3a8:	89 d7                	mov    %edx,%edi
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 3b1:	39 f8                	cmp    %edi,%eax
 3b3:	75 fb                	jne    3b0 <memmove+0x20>
 3b5:	5e                   	pop    %esi
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret    

000003bb <fork>:
 3bb:	b8 01 00 00 00       	mov    $0x1,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <exit>:
 3c3:	b8 02 00 00 00       	mov    $0x2,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <wait>:
 3cb:	b8 03 00 00 00       	mov    $0x3,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <pipe>:
 3d3:	b8 04 00 00 00       	mov    $0x4,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <read>:
 3db:	b8 05 00 00 00       	mov    $0x5,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <write>:
 3e3:	b8 10 00 00 00       	mov    $0x10,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <close>:
 3eb:	b8 15 00 00 00       	mov    $0x15,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <kill>:
 3f3:	b8 06 00 00 00       	mov    $0x6,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <exec>:
 3fb:	b8 07 00 00 00       	mov    $0x7,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <open>:
 403:	b8 0f 00 00 00       	mov    $0xf,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <mknod>:
 40b:	b8 11 00 00 00       	mov    $0x11,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <unlink>:
 413:	b8 12 00 00 00       	mov    $0x12,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <fstat>:
 41b:	b8 08 00 00 00       	mov    $0x8,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <link>:
 423:	b8 13 00 00 00       	mov    $0x13,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <mkdir>:
 42b:	b8 14 00 00 00       	mov    $0x14,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <chdir>:
 433:	b8 09 00 00 00       	mov    $0x9,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <dup>:
 43b:	b8 0a 00 00 00       	mov    $0xa,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <getpid>:
 443:	b8 0b 00 00 00       	mov    $0xb,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <sbrk>:
 44b:	b8 0c 00 00 00       	mov    $0xc,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <sleep>:
 453:	b8 0d 00 00 00       	mov    $0xd,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <uptime>:
 45b:	b8 0e 00 00 00       	mov    $0xe,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    
 463:	66 90                	xchg   %ax,%ax
 465:	66 90                	xchg   %ax,%ax
 467:	66 90                	xchg   %ax,%ax
 469:	66 90                	xchg   %ax,%ax
 46b:	66 90                	xchg   %ax,%ax
 46d:	66 90                	xchg   %ax,%ax
 46f:	90                   	nop

00000470 <printint>:
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
 476:	83 ec 3c             	sub    $0x3c,%esp
 479:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 47c:	89 d1                	mov    %edx,%ecx
 47e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 481:	85 d2                	test   %edx,%edx
 483:	0f 89 7f 00 00 00    	jns    508 <printint+0x98>
 489:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 48d:	74 79                	je     508 <printint+0x98>
 48f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 496:	f7 d9                	neg    %ecx
 498:	31 db                	xor    %ebx,%ebx
 49a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	89 cf                	mov    %ecx,%edi
 4a6:	f7 75 c4             	divl   -0x3c(%ebp)
 4a9:	0f b6 92 f8 08 00 00 	movzbl 0x8f8(%edx),%edx
 4b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4b3:	89 d8                	mov    %ebx,%eax
 4b5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 4b8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4bb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 4be:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4c1:	76 dd                	jbe    4a0 <printint+0x30>
 4c3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4c6:	85 c9                	test   %ecx,%ecx
 4c8:	74 0c                	je     4d6 <printint+0x66>
 4ca:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 4cf:	89 d8                	mov    %ebx,%eax
 4d1:	ba 2d 00 00 00       	mov    $0x2d,%edx
 4d6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4d9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4dd:	eb 07                	jmp    4e6 <printint+0x76>
 4df:	90                   	nop
 4e0:	0f b6 13             	movzbl (%ebx),%edx
 4e3:	83 eb 01             	sub    $0x1,%ebx
 4e6:	83 ec 04             	sub    $0x4,%esp
 4e9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4ec:	6a 01                	push   $0x1
 4ee:	56                   	push   %esi
 4ef:	57                   	push   %edi
 4f0:	e8 ee fe ff ff       	call   3e3 <write>
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	39 de                	cmp    %ebx,%esi
 4fa:	75 e4                	jne    4e0 <printint+0x70>
 4fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ff:	5b                   	pop    %ebx
 500:	5e                   	pop    %esi
 501:	5f                   	pop    %edi
 502:	5d                   	pop    %ebp
 503:	c3                   	ret    
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 508:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 50f:	eb 87                	jmp    498 <printint+0x28>
 511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop

00000520 <printf>:
 520:	f3 0f 1e fb          	endbr32 
 524:	55                   	push   %ebp
 525:	89 e5                	mov    %esp,%ebp
 527:	57                   	push   %edi
 528:	56                   	push   %esi
 529:	53                   	push   %ebx
 52a:	83 ec 2c             	sub    $0x2c,%esp
 52d:	8b 75 0c             	mov    0xc(%ebp),%esi
 530:	0f b6 1e             	movzbl (%esi),%ebx
 533:	84 db                	test   %bl,%bl
 535:	0f 84 b4 00 00 00    	je     5ef <printf+0xcf>
 53b:	8d 45 10             	lea    0x10(%ebp),%eax
 53e:	83 c6 01             	add    $0x1,%esi
 541:	8d 7d e7             	lea    -0x19(%ebp),%edi
 544:	31 d2                	xor    %edx,%edx
 546:	89 45 d0             	mov    %eax,-0x30(%ebp)
 549:	eb 33                	jmp    57e <printf+0x5e>
 54b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
 550:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 553:	ba 25 00 00 00       	mov    $0x25,%edx
 558:	83 f8 25             	cmp    $0x25,%eax
 55b:	74 17                	je     574 <printf+0x54>
 55d:	83 ec 04             	sub    $0x4,%esp
 560:	88 5d e7             	mov    %bl,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	57                   	push   %edi
 566:	ff 75 08             	pushl  0x8(%ebp)
 569:	e8 75 fe ff ff       	call   3e3 <write>
 56e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 571:	83 c4 10             	add    $0x10,%esp
 574:	0f b6 1e             	movzbl (%esi),%ebx
 577:	83 c6 01             	add    $0x1,%esi
 57a:	84 db                	test   %bl,%bl
 57c:	74 71                	je     5ef <printf+0xcf>
 57e:	0f be cb             	movsbl %bl,%ecx
 581:	0f b6 c3             	movzbl %bl,%eax
 584:	85 d2                	test   %edx,%edx
 586:	74 c8                	je     550 <printf+0x30>
 588:	83 fa 25             	cmp    $0x25,%edx
 58b:	75 e7                	jne    574 <printf+0x54>
 58d:	83 f8 64             	cmp    $0x64,%eax
 590:	0f 84 9a 00 00 00    	je     630 <printf+0x110>
 596:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 59c:	83 f9 70             	cmp    $0x70,%ecx
 59f:	74 5f                	je     600 <printf+0xe0>
 5a1:	83 f8 73             	cmp    $0x73,%eax
 5a4:	0f 84 d6 00 00 00    	je     680 <printf+0x160>
 5aa:	83 f8 63             	cmp    $0x63,%eax
 5ad:	0f 84 8d 00 00 00    	je     640 <printf+0x120>
 5b3:	83 f8 25             	cmp    $0x25,%eax
 5b6:	0f 84 b4 00 00 00    	je     670 <printf+0x150>
 5bc:	83 ec 04             	sub    $0x4,%esp
 5bf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5c3:	6a 01                	push   $0x1
 5c5:	57                   	push   %edi
 5c6:	ff 75 08             	pushl  0x8(%ebp)
 5c9:	e8 15 fe ff ff       	call   3e3 <write>
 5ce:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5d1:	83 c4 0c             	add    $0xc,%esp
 5d4:	6a 01                	push   $0x1
 5d6:	83 c6 01             	add    $0x1,%esi
 5d9:	57                   	push   %edi
 5da:	ff 75 08             	pushl  0x8(%ebp)
 5dd:	e8 01 fe ff ff       	call   3e3 <write>
 5e2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5e6:	83 c4 10             	add    $0x10,%esp
 5e9:	31 d2                	xor    %edx,%edx
 5eb:	84 db                	test   %bl,%bl
 5ed:	75 8f                	jne    57e <printf+0x5e>
 5ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f2:	5b                   	pop    %ebx
 5f3:	5e                   	pop    %esi
 5f4:	5f                   	pop    %edi
 5f5:	5d                   	pop    %ebp
 5f6:	c3                   	ret    
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	6a 00                	push   $0x0
 60a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
 610:	8b 13                	mov    (%ebx),%edx
 612:	e8 59 fe ff ff       	call   470 <printint>
 617:	89 d8                	mov    %ebx,%eax
 619:	83 c4 10             	add    $0x10,%esp
 61c:	31 d2                	xor    %edx,%edx
 61e:	83 c0 04             	add    $0x4,%eax
 621:	89 45 d0             	mov    %eax,-0x30(%ebp)
 624:	e9 4b ff ff ff       	jmp    574 <printf+0x54>
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 630:	83 ec 0c             	sub    $0xc,%esp
 633:	b9 0a 00 00 00       	mov    $0xa,%ecx
 638:	6a 01                	push   $0x1
 63a:	eb ce                	jmp    60a <printf+0xea>
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 643:	83 ec 04             	sub    $0x4,%esp
 646:	8b 03                	mov    (%ebx),%eax
 648:	6a 01                	push   $0x1
 64a:	83 c3 04             	add    $0x4,%ebx
 64d:	57                   	push   %edi
 64e:	ff 75 08             	pushl  0x8(%ebp)
 651:	88 45 e7             	mov    %al,-0x19(%ebp)
 654:	e8 8a fd ff ff       	call   3e3 <write>
 659:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 65c:	83 c4 10             	add    $0x10,%esp
 65f:	31 d2                	xor    %edx,%edx
 661:	e9 0e ff ff ff       	jmp    574 <printf+0x54>
 666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
 670:	88 5d e7             	mov    %bl,-0x19(%ebp)
 673:	83 ec 04             	sub    $0x4,%esp
 676:	e9 59 ff ff ff       	jmp    5d4 <printf+0xb4>
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
 680:	8b 45 d0             	mov    -0x30(%ebp),%eax
 683:	8b 18                	mov    (%eax),%ebx
 685:	83 c0 04             	add    $0x4,%eax
 688:	89 45 d0             	mov    %eax,-0x30(%ebp)
 68b:	85 db                	test   %ebx,%ebx
 68d:	74 17                	je     6a6 <printf+0x186>
 68f:	0f b6 03             	movzbl (%ebx),%eax
 692:	31 d2                	xor    %edx,%edx
 694:	84 c0                	test   %al,%al
 696:	0f 84 d8 fe ff ff    	je     574 <printf+0x54>
 69c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 69f:	89 de                	mov    %ebx,%esi
 6a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a4:	eb 1a                	jmp    6c0 <printf+0x1a0>
 6a6:	bb ef 08 00 00       	mov    $0x8ef,%ebx
 6ab:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ae:	b8 28 00 00 00       	mov    $0x28,%eax
 6b3:	89 de                	mov    %ebx,%esi
 6b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	83 c6 01             	add    $0x1,%esi
 6c6:	88 45 e7             	mov    %al,-0x19(%ebp)
 6c9:	6a 01                	push   $0x1
 6cb:	57                   	push   %edi
 6cc:	53                   	push   %ebx
 6cd:	e8 11 fd ff ff       	call   3e3 <write>
 6d2:	0f b6 06             	movzbl (%esi),%eax
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	84 c0                	test   %al,%al
 6da:	75 e4                	jne    6c0 <printf+0x1a0>
 6dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6df:	31 d2                	xor    %edx,%edx
 6e1:	e9 8e fe ff ff       	jmp    574 <printf+0x54>
 6e6:	66 90                	xchg   %ax,%ax
 6e8:	66 90                	xchg   %ax,%ax
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <free>:
 6f0:	f3 0f 1e fb          	endbr32 
 6f4:	55                   	push   %ebp
 6f5:	a1 ac 0b 00 00       	mov    0xbac,%eax
 6fa:	89 e5                	mov    %esp,%ebp
 6fc:	57                   	push   %edi
 6fd:	56                   	push   %esi
 6fe:	53                   	push   %ebx
 6ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
 702:	8b 10                	mov    (%eax),%edx
 704:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 707:	39 c8                	cmp    %ecx,%eax
 709:	73 15                	jae    720 <free+0x30>
 70b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop
 710:	39 d1                	cmp    %edx,%ecx
 712:	72 14                	jb     728 <free+0x38>
 714:	39 d0                	cmp    %edx,%eax
 716:	73 10                	jae    728 <free+0x38>
 718:	89 d0                	mov    %edx,%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	39 c8                	cmp    %ecx,%eax
 71e:	72 f0                	jb     710 <free+0x20>
 720:	39 d0                	cmp    %edx,%eax
 722:	72 f4                	jb     718 <free+0x28>
 724:	39 d1                	cmp    %edx,%ecx
 726:	73 f0                	jae    718 <free+0x28>
 728:	8b 73 fc             	mov    -0x4(%ebx),%esi
 72b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72e:	39 fa                	cmp    %edi,%edx
 730:	74 1e                	je     750 <free+0x60>
 732:	89 53 f8             	mov    %edx,-0x8(%ebx)
 735:	8b 50 04             	mov    0x4(%eax),%edx
 738:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	74 28                	je     767 <free+0x77>
 73f:	89 08                	mov    %ecx,(%eax)
 741:	5b                   	pop    %ebx
 742:	a3 ac 0b 00 00       	mov    %eax,0xbac
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
 750:	03 72 04             	add    0x4(%edx),%esi
 753:	89 73 fc             	mov    %esi,-0x4(%ebx)
 756:	8b 10                	mov    (%eax),%edx
 758:	8b 12                	mov    (%edx),%edx
 75a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 75d:	8b 50 04             	mov    0x4(%eax),%edx
 760:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 763:	39 f1                	cmp    %esi,%ecx
 765:	75 d8                	jne    73f <free+0x4f>
 767:	03 53 fc             	add    -0x4(%ebx),%edx
 76a:	a3 ac 0b 00 00       	mov    %eax,0xbac
 76f:	89 50 04             	mov    %edx,0x4(%eax)
 772:	8b 53 f8             	mov    -0x8(%ebx),%edx
 775:	89 10                	mov    %edx,(%eax)
 777:	5b                   	pop    %ebx
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000780 <malloc>:
 780:	f3 0f 1e fb          	endbr32 
 784:	55                   	push   %ebp
 785:	89 e5                	mov    %esp,%ebp
 787:	57                   	push   %edi
 788:	56                   	push   %esi
 789:	53                   	push   %ebx
 78a:	83 ec 1c             	sub    $0x1c,%esp
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
 796:	8d 70 07             	lea    0x7(%eax),%esi
 799:	c1 ee 03             	shr    $0x3,%esi
 79c:	83 c6 01             	add    $0x1,%esi
 79f:	85 ff                	test   %edi,%edi
 7a1:	0f 84 a9 00 00 00    	je     850 <malloc+0xd0>
 7a7:	8b 07                	mov    (%edi),%eax
 7a9:	8b 48 04             	mov    0x4(%eax),%ecx
 7ac:	39 f1                	cmp    %esi,%ecx
 7ae:	73 6d                	jae    81d <malloc+0x9d>
 7b0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7b6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7bb:	0f 43 de             	cmovae %esi,%ebx
 7be:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7c8:	eb 17                	jmp    7e1 <malloc+0x61>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7d0:	8b 10                	mov    (%eax),%edx
 7d2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7d5:	39 f1                	cmp    %esi,%ecx
 7d7:	73 4f                	jae    828 <malloc+0xa8>
 7d9:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
 7df:	89 d0                	mov    %edx,%eax
 7e1:	39 c7                	cmp    %eax,%edi
 7e3:	75 eb                	jne    7d0 <malloc+0x50>
 7e5:	83 ec 0c             	sub    $0xc,%esp
 7e8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7eb:	e8 5b fc ff ff       	call   44b <sbrk>
 7f0:	83 c4 10             	add    $0x10,%esp
 7f3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f6:	74 1b                	je     813 <malloc+0x93>
 7f8:	89 58 04             	mov    %ebx,0x4(%eax)
 7fb:	83 ec 0c             	sub    $0xc,%esp
 7fe:	83 c0 08             	add    $0x8,%eax
 801:	50                   	push   %eax
 802:	e8 e9 fe ff ff       	call   6f0 <free>
 807:	a1 ac 0b 00 00       	mov    0xbac,%eax
 80c:	83 c4 10             	add    $0x10,%esp
 80f:	85 c0                	test   %eax,%eax
 811:	75 bd                	jne    7d0 <malloc+0x50>
 813:	8d 65 f4             	lea    -0xc(%ebp),%esp
 816:	31 c0                	xor    %eax,%eax
 818:	5b                   	pop    %ebx
 819:	5e                   	pop    %esi
 81a:	5f                   	pop    %edi
 81b:	5d                   	pop    %ebp
 81c:	c3                   	ret    
 81d:	89 c2                	mov    %eax,%edx
 81f:	89 f8                	mov    %edi,%eax
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 828:	39 ce                	cmp    %ecx,%esi
 82a:	74 54                	je     880 <malloc+0x100>
 82c:	29 f1                	sub    %esi,%ecx
 82e:	89 4a 04             	mov    %ecx,0x4(%edx)
 831:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 834:	89 72 04             	mov    %esi,0x4(%edx)
 837:	a3 ac 0b 00 00       	mov    %eax,0xbac
 83c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 83f:	8d 42 08             	lea    0x8(%edx),%eax
 842:	5b                   	pop    %ebx
 843:	5e                   	pop    %esi
 844:	5f                   	pop    %edi
 845:	5d                   	pop    %ebp
 846:	c3                   	ret    
 847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84e:	66 90                	xchg   %ax,%ax
 850:	c7 05 ac 0b 00 00 b0 	movl   $0xbb0,0xbac
 857:	0b 00 00 
 85a:	bf b0 0b 00 00       	mov    $0xbb0,%edi
 85f:	c7 05 b0 0b 00 00 b0 	movl   $0xbb0,0xbb0
 866:	0b 00 00 
 869:	89 f8                	mov    %edi,%eax
 86b:	c7 05 b4 0b 00 00 00 	movl   $0x0,0xbb4
 872:	00 00 00 
 875:	e9 36 ff ff ff       	jmp    7b0 <malloc+0x30>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 880:	8b 0a                	mov    (%edx),%ecx
 882:	89 08                	mov    %ecx,(%eax)
 884:	eb b1                	jmp    837 <malloc+0xb7>
