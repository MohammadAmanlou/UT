
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp
8010002d:	b8 30 35 10 80       	mov    $0x80103530,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx
80100048:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
8010004d:	83 ec 0c             	sub    $0xc,%esp
80100050:	68 e0 75 10 80       	push   $0x801075e0
80100055:	68 c0 c5 10 80       	push   $0x8010c5c0
8010005a:	e8 71 48 00 00       	call   801048d0 <initlock>
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 bc 0c 11 80       	mov    $0x80110cbc,%eax
80100067:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
8010006e:	0c 11 80 
80100071:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
80100078:	0c 11 80 
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
80100092:	68 e7 75 10 80       	push   $0x801075e7
80100097:	50                   	push   %eax
80100098:	e8 f3 46 00 00       	call   80104790 <initsleeplock>
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
801000b6:	81 fb 60 0a 11 80    	cmp    $0x80110a60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801000e3:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e8:	e8 63 49 00 00       	call   80104a50 <acquire>
801000ed:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 a9 49 00 00       	call   80104b10 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 46 00 00       	call   801047d0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 df 25 00 00       	call   80102770 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ee 75 10 80       	push   $0x801075ee
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 a9 46 00 00       	call   80104870 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
801001d8:	e9 93 25 00 00       	jmp    80102770 <iderw>
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 ff 75 10 80       	push   $0x801075ff
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 68 46 00 00       	call   80104870 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 18 46 00 00       	call   80104830 <releasesleep>
80100218:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010021f:	e8 2c 48 00 00       	call   80104a50 <acquire>
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100227:	83 c4 10             	add    $0x10,%esp
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
80100246:	a1 10 0d 11 80       	mov    0x80110d10,%eax
8010024b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
80100255:	a1 10 0d 11 80       	mov    0x80110d10,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
8010025d:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
80100263:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
80100270:	e9 9b 48 00 00       	jmp    80104b10 <release>
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 06 76 10 80       	push   $0x80107606
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
8010029d:	ff 75 08             	pushl  0x8(%ebp)
{
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
801002a3:	89 de                	mov    %ebx,%esi
  iunlock(ip);
801002a5:	e8 86 1a 00 00       	call   80101d30 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002b1:	e8 9a 47 00 00       	call   80104a50 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002bc:	01 df                	add    %ebx,%edi
  while(n > 0){
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
    while(input.r == input.w){
801002c6:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002cb:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 20 b5 10 80       	push   $0x8010b520
801002e0:	68 a0 0f 11 80       	push   $0x80110fa0
801002e5:	e8 26 41 00 00       	call   80104410 <sleep>
    while(input.r == input.w){
801002ea:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 51 3b 00 00       	call   80103e50 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 b5 10 80       	push   $0x8010b520
8010030e:	e8 fd 47 00 00       	call   80104b10 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 34 19 00 00       	call   80101c50 <ilock>
        return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 20 0f 11 80 	movsbl -0x7feef0e0(%edx),%ecx
    if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
    *dst++ = c;
8010034a:	89 d8                	mov    %ebx,%eax
    --n;
8010034c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
  release(&cons.lock);
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 20 b5 10 80       	push   $0x8010b520
80100365:	e8 a6 47 00 00       	call   80104b10 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 dd 18 00 00       	call   80101c50 <ilock>
  return target - n;
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
}
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037b:	29 d8                	sub    %ebx,%eax
}
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
      if(n < target){
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
        input.r--;
80100386:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
  cons.locking = 0;
8010039d:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 de 29 00 00       	call   80102d90 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 0d 76 10 80       	push   $0x8010760d
801003bb:	e8 00 05 00 00       	call   801008c0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 f7 04 00 00       	call   801008c0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 97 7f 10 80 	movl   $0x80107f97,(%esp)
801003d0:	e8 eb 04 00 00       	call   801008c0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 0f 45 00 00       	call   801048f0 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 21 76 10 80       	push   $0x80107621
801003f1:	e8 ca 04 00 00       	call   801008c0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 5c b5 10 80 01 	movl   $0x1,0x8010b55c
80100404:	00 00 00 
  for(;;)
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c) // Important function 
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	89 c6                	mov    %eax,%esi
80100417:	53                   	push   %ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 62 01 00 00    	je     80100588 <consputc.part.0+0x178>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 a1 5d 00 00       	call   801061d0 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c3                	mov    %eax,%ebx
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 d8                	or     %ebx,%eax
  if(c == '\n'){
8010045f:	83 fe 0a             	cmp    $0xa,%esi
80100462:	0f 84 f8 00 00 00    	je     80100560 <consputc.part.0+0x150>
  else if(c == BACKSPACE){
80100468:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
8010046e:	8d 0c 38             	lea    (%eax,%edi,1),%ecx
80100471:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100477:	0f 84 a3 00 00 00    	je     80100520 <consputc.part.0+0x110>
  for (int i = pos + backs; i > pos; i--)
8010047d:	39 c8                	cmp    %ecx,%eax
8010047f:	7d 1d                	jge    8010049e <consputc.part.0+0x8e>
80100481:	8d 94 09 fe 7f 0b 80 	lea    -0x7ff48002(%ecx,%ecx,1),%edx
80100488:	8d 9c 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%ebx
8010048f:	90                   	nop
    crt[i] = crt[i - 1];
80100490:	0f b7 0a             	movzwl (%edx),%ecx
80100493:	83 ea 02             	sub    $0x2,%edx
80100496:	66 89 4a 04          	mov    %cx,0x4(%edx)
  for (int i = pos + backs; i > pos; i--)
8010049a:	39 d3                	cmp    %edx,%ebx
8010049c:	75 f2                	jne    80100490 <consputc.part.0+0x80>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010049e:	89 f1                	mov    %esi,%ecx
801004a0:	8d 58 01             	lea    0x1(%eax),%ebx
801004a3:	0f b6 f1             	movzbl %cl,%esi
801004a6:	66 81 ce 00 07       	or     $0x700,%si
801004ab:	66 89 b4 00 00 80 0b 	mov    %si,-0x7ff48000(%eax,%eax,1)
801004b2:	80 
  if(pos < 0 || pos > 25*80)
801004b3:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004b9:	0f 8f 45 01 00 00    	jg     80100604 <consputc.part.0+0x1f4>
  if((pos/80) >= 24){  // Scroll up.
801004bf:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004c5:	0f 8f ed 00 00 00    	jg     801005b8 <consputc.part.0+0x1a8>
801004cb:	0f b6 c7             	movzbl %bh,%eax
801004ce:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
801004d4:	89 de                	mov    %ebx,%esi
801004d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801004d9:	01 df                	add    %ebx,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004db:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004e0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004e5:	89 da                	mov    %ebx,%edx
801004e7:	ee                   	out    %al,(%dx)
801004e8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ed:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801004f1:	89 ca                	mov    %ecx,%edx
801004f3:	ee                   	out    %al,(%dx)
801004f4:	b8 0f 00 00 00       	mov    $0xf,%eax
801004f9:	89 da                	mov    %ebx,%edx
801004fb:	ee                   	out    %al,(%dx)
801004fc:	89 f0                	mov    %esi,%eax
801004fe:	89 ca                	mov    %ecx,%edx
80100500:	ee                   	out    %al,(%dx)
  crt[pos + backs] = ' ' | 0x0700; //
80100501:	b8 20 07 00 00       	mov    $0x720,%eax
80100506:	66 89 84 3f 00 80 0b 	mov    %ax,-0x7ff48000(%edi,%edi,1)
8010050d:	80 
}
8010050e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100511:	5b                   	pop    %ebx
80100512:	5e                   	pop    %esi
80100513:	5f                   	pop    %edi
80100514:	5d                   	pop    %ebp
80100515:	c3                   	ret    
80100516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010051d:	8d 76 00             	lea    0x0(%esi),%esi
  for (int i = pos - 1; i < pos + backs; i++)
80100520:	8d 58 ff             	lea    -0x1(%eax),%ebx
80100523:	8d 94 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%edx
8010052a:	89 de                	mov    %ebx,%esi
8010052c:	85 ff                	test   %edi,%edi
8010052e:	78 1c                	js     8010054c <consputc.part.0+0x13c>
80100530:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100537:	90                   	nop
      crt[i] = crt[i + 1];
80100538:	0f b7 02             	movzwl (%edx),%eax
  for (int i = pos - 1; i < pos + backs; i++)
8010053b:	83 c6 01             	add    $0x1,%esi
8010053e:	83 c2 02             	add    $0x2,%edx
      crt[i] = crt[i + 1];
80100541:	66 89 42 fc          	mov    %ax,-0x4(%edx)
  for (int i = pos - 1; i < pos + backs; i++)
80100545:	39 ce                	cmp    %ecx,%esi
80100547:	7c ef                	jl     80100538 <consputc.part.0+0x128>
80100549:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(pos > 0) --pos;
8010054c:	85 c0                	test   %eax,%eax
8010054e:	0f 85 5f ff ff ff    	jne    801004b3 <consputc.part.0+0xa3>
80100554:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
80100558:	31 f6                	xor    %esi,%esi
8010055a:	e9 7c ff ff ff       	jmp    801004db <consputc.part.0+0xcb>
8010055f:	90                   	nop
    backs = 0;
80100560:	c7 05 58 b5 10 80 00 	movl   $0x0,0x8010b558
80100567:	00 00 00 
    pos += 80 - pos%80;
8010056a:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010056f:	f7 e2                	mul    %edx
80100571:	c1 ea 06             	shr    $0x6,%edx
80100574:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100577:	c1 e0 04             	shl    $0x4,%eax
8010057a:	8d 58 50             	lea    0x50(%eax),%ebx
    backs = 0;
8010057d:	e9 31 ff ff ff       	jmp    801004b3 <consputc.part.0+0xa3>
80100582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');      
80100588:	83 ec 0c             	sub    $0xc,%esp
8010058b:	6a 08                	push   $0x8
8010058d:	e8 3e 5c 00 00       	call   801061d0 <uartputc>
80100592:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100599:	e8 32 5c 00 00       	call   801061d0 <uartputc>
8010059e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005a5:	e8 26 5c 00 00       	call   801061d0 <uartputc>
801005aa:	83 c4 10             	add    $0x10,%esp
801005ad:	e9 80 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
801005b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005b8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801005bb:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801005be:	68 60 0e 00 00       	push   $0xe60
801005c3:	89 de                	mov    %ebx,%esi
801005c5:	68 a0 80 0b 80       	push   $0x800b80a0
801005ca:	68 00 80 0b 80       	push   $0x800b8000
801005cf:	e8 2c 46 00 00       	call   80104c00 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005d4:	b8 80 07 00 00       	mov    $0x780,%eax
801005d9:	83 c4 0c             	add    $0xc,%esp
801005dc:	29 d8                	sub    %ebx,%eax
801005de:	01 c0                	add    %eax,%eax
801005e0:	50                   	push   %eax
801005e1:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801005e8:	6a 00                	push   $0x0
801005ea:	50                   	push   %eax
801005eb:	e8 70 45 00 00       	call   80104b60 <memset>
801005f0:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
801005f6:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
801005fa:	83 c4 10             	add    $0x10,%esp
801005fd:	01 df                	add    %ebx,%edi
801005ff:	e9 d7 fe ff ff       	jmp    801004db <consputc.part.0+0xcb>
    panic("pos under/overflow");
80100604:	83 ec 0c             	sub    $0xc,%esp
80100607:	68 25 76 10 80       	push   $0x80107625
8010060c:	e8 7f fd ff ff       	call   80100390 <panic>
80100611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010061f:	90                   	nop

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	83 ec 2c             	sub    $0x2c,%esp
80100629:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010062c:	85 c9                	test   %ecx,%ecx
8010062e:	74 04                	je     80100634 <printint+0x14>
80100630:	85 c0                	test   %eax,%eax
80100632:	78 6d                	js     801006a1 <printint+0x81>
    x = xx;
80100634:	89 c1                	mov    %eax,%ecx
80100636:	31 f6                	xor    %esi,%esi
  i = 0;
80100638:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010063b:	31 db                	xor    %ebx,%ebx
8010063d:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 ce                	mov    %ecx,%esi
80100646:	f7 75 d4             	divl   -0x2c(%ebp)
80100649:	0f b6 92 a8 76 10 80 	movzbl -0x7fef8958(%edx),%edx
80100650:	89 45 d0             	mov    %eax,-0x30(%ebp)
80100653:	89 d8                	mov    %ebx,%eax
80100655:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
80100658:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010065b:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
8010065e:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
80100661:	8b 75 d4             	mov    -0x2c(%ebp),%esi
80100664:	39 75 d0             	cmp    %esi,-0x30(%ebp)
80100667:	73 d7                	jae    80100640 <printint+0x20>
80100669:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
8010066c:	85 f6                	test   %esi,%esi
8010066e:	74 0c                	je     8010067c <printint+0x5c>
    buf[i++] = '-';
80100670:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100675:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
80100677:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010067c:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100680:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100683:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100689:	85 d2                	test   %edx,%edx
8010068b:	74 03                	je     80100690 <printint+0x70>
  asm volatile("cli");
8010068d:	fa                   	cli    
    for(;;)
8010068e:	eb fe                	jmp    8010068e <printint+0x6e>
80100690:	e8 7b fd ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
80100695:	39 fb                	cmp    %edi,%ebx
80100697:	74 10                	je     801006a9 <printint+0x89>
80100699:	0f be 03             	movsbl (%ebx),%eax
8010069c:	83 eb 01             	sub    $0x1,%ebx
8010069f:	eb e2                	jmp    80100683 <printint+0x63>
    x = -xx;
801006a1:	f7 d8                	neg    %eax
801006a3:	89 ce                	mov    %ecx,%esi
801006a5:	89 c1                	mov    %eax,%ecx
801006a7:	eb 8f                	jmp    80100638 <printint+0x18>
}
801006a9:	83 c4 2c             	add    $0x2c,%esp
801006ac:	5b                   	pop    %ebx
801006ad:	5e                   	pop    %esi
801006ae:	5f                   	pop    %edi
801006af:	5d                   	pop    %ebp
801006b0:	c3                   	ret    
801006b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006bf:	90                   	nop

801006c0 <arrow>:
static void arrow(enum Arrow arr){
801006c0:	55                   	push   %ebp
801006c1:	89 e5                	mov    %esp,%ebp
801006c3:	57                   	push   %edi
801006c4:	56                   	push   %esi
801006c5:	53                   	push   %ebx
801006c6:	83 ec 1c             	sub    $0x1c,%esp
801006c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for (int i= 0 ; i < backs ; i ++){
801006cc:	a1 58 b5 10 80       	mov    0x8010b558,%eax
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	85 c0                	test   %eax,%eax
801006d6:	7e 57                	jle    8010072f <arrow+0x6f>
801006d8:	31 ff                	xor    %edi,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801006da:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801006df:	b8 0e 00 00 00       	mov    $0xe,%eax
801006e4:	89 da                	mov    %ebx,%edx
801006e6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801006e7:	be d5 03 00 00       	mov    $0x3d5,%esi
801006ec:	89 f2                	mov    %esi,%edx
801006ee:	ec                   	in     (%dx),%al
801006ef:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801006f2:	89 da                	mov    %ebx,%edx
801006f4:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT + 1) << 8;
801006f9:	c1 e1 08             	shl    $0x8,%ecx
801006fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801006fd:	89 f2                	mov    %esi,%edx
801006ff:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT + 1);
80100700:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100703:	89 da                	mov    %ebx,%edx
80100705:	09 c1                	or     %eax,%ecx
80100707:	b8 0e 00 00 00       	mov    $0xe,%eax
    pos++;
8010070c:	83 c1 01             	add    $0x1,%ecx
8010070f:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, pos >> 8);
80100710:	89 ca                	mov    %ecx,%edx
80100712:	c1 fa 08             	sar    $0x8,%edx
80100715:	89 d0                	mov    %edx,%eax
80100717:	89 f2                	mov    %esi,%edx
80100719:	ee                   	out    %al,(%dx)
8010071a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010071f:	89 da                	mov    %ebx,%edx
80100721:	ee                   	out    %al,(%dx)
80100722:	89 c8                	mov    %ecx,%eax
80100724:	89 f2                	mov    %esi,%edx
80100726:	ee                   	out    %al,(%dx)
  for (int i= 0 ; i < backs ; i ++){
80100727:	83 c7 01             	add    $0x1,%edi
8010072a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
8010072d:	75 b0                	jne    801006df <arrow+0x1f>
  backs = 0;
8010072f:	c7 05 58 b5 10 80 00 	movl   $0x0,0x8010b558
80100736:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){
80100739:	8b 1d a8 0f 11 80    	mov    0x80110fa8,%ebx
8010073f:	3b 1d a4 0f 11 80    	cmp    0x80110fa4,%ebx
80100745:	76 2b                	jbe    80100772 <arrow+0xb2>
    if (input.buf[i - 1] != '\n'){
80100747:	83 eb 01             	sub    $0x1,%ebx
8010074a:	80 bb 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%ebx)
80100751:	74 17                	je     8010076a <arrow+0xaa>
  if(panicked){
80100753:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100759:	85 d2                	test   %edx,%edx
8010075b:	74 03                	je     80100760 <arrow+0xa0>
  asm volatile("cli");
8010075d:	fa                   	cli    
    for(;;)
8010075e:	eb fe                	jmp    8010075e <arrow+0x9e>
80100760:	b8 00 01 00 00       	mov    $0x100,%eax
80100765:	e8 a6 fc ff ff       	call   80100410 <consputc.part.0>
  for ( int i = input.e ; i > input.w ; i-- ){
8010076a:	39 1d a4 0f 11 80    	cmp    %ebx,0x80110fa4
80100770:	72 d5                	jb     80100747 <arrow+0x87>
  if (arr == UP){
80100772:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100775:	a1 38 15 11 80       	mov    0x80111538,%eax
8010077a:	85 c9                	test   %ecx,%ecx
8010077c:	74 50                	je     801007ce <arrow+0x10e>
  if ((arr == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
8010077e:	83 f8 08             	cmp    $0x8,%eax
80100781:	0f 8f b8 00 00 00    	jg     8010083f <arrow+0x17f>
80100787:	8d 50 01             	lea    0x1(%eax),%edx
8010078a:	3b 15 40 15 11 80    	cmp    0x80111540,%edx
80100790:	0f 8d a9 00 00 00    	jge    8010083f <arrow+0x17f>
    input = history.hist[history.index + 2 ];
80100796:	8d 70 02             	lea    0x2(%eax),%esi
80100799:	bf 20 0f 11 80       	mov    $0x80110f20,%edi
8010079e:	b9 23 00 00 00       	mov    $0x23,%ecx
    history.index ++ ;
801007a3:	89 15 38 15 11 80    	mov    %edx,0x80111538
    input = history.hist[history.index + 2 ];
801007a9:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
801007af:	81 c6 c0 0f 11 80    	add    $0x80110fc0,%esi
801007b5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.e -- ;
801007b7:	8b 15 a8 0f 11 80    	mov    0x80110fa8,%edx
801007bd:	8d 42 ff             	lea    -0x1(%edx),%eax
    input.buf[input.e] = '\0';
801007c0:	c6 82 1f 0f 11 80 00 	movb   $0x0,-0x7feef0e1(%edx)
    input.e -- ;
801007c7:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
    input.buf[input.e] = '\0';
801007cc:	eb 35                	jmp    80100803 <arrow+0x143>
    input = history.hist[history.index ];
801007ce:	69 f0 8c 00 00 00    	imul   $0x8c,%eax,%esi
801007d4:	bf 20 0f 11 80       	mov    $0x80110f20,%edi
801007d9:	b9 23 00 00 00       	mov    $0x23,%ecx
    history.index -- ;
801007de:	83 e8 01             	sub    $0x1,%eax
801007e1:	a3 38 15 11 80       	mov    %eax,0x80111538
    input = history.hist[history.index ];
801007e6:	81 c6 c0 0f 11 80    	add    $0x80110fc0,%esi
801007ec:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.e -- ;
801007ee:	8b 15 a8 0f 11 80    	mov    0x80110fa8,%edx
801007f4:	8d 42 ff             	lea    -0x1(%edx),%eax
    input.buf[input.e] = '\0';
801007f7:	c6 82 1f 0f 11 80 00 	movb   $0x0,-0x7feef0e1(%edx)
    input.e -- ;
801007fe:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
  for (int i = input.w ; i < input.e; i++)
80100803:	8b 1d a4 0f 11 80    	mov    0x80110fa4,%ebx
80100809:	39 d8                	cmp    %ebx,%eax
8010080b:	76 2a                	jbe    80100837 <arrow+0x177>
  if(panicked){
8010080d:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
80100812:	85 c0                	test   %eax,%eax
80100814:	74 0a                	je     80100820 <arrow+0x160>
80100816:	fa                   	cli    
    for(;;)
80100817:	eb fe                	jmp    80100817 <arrow+0x157>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(input.buf[i]);
80100820:	0f be 83 20 0f 11 80 	movsbl -0x7feef0e0(%ebx),%eax
  for (int i = input.w ; i < input.e; i++)
80100827:	83 c3 01             	add    $0x1,%ebx
8010082a:	e8 e1 fb ff ff       	call   80100410 <consputc.part.0>
8010082f:	39 1d a8 0f 11 80    	cmp    %ebx,0x80110fa8
80100835:	77 d6                	ja     8010080d <arrow+0x14d>
}
80100837:	83 c4 1c             	add    $0x1c,%esp
8010083a:	5b                   	pop    %ebx
8010083b:	5e                   	pop    %esi
8010083c:	5f                   	pop    %edi
8010083d:	5d                   	pop    %ebp
8010083e:	c3                   	ret    
8010083f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100844:	eb bd                	jmp    80100803 <arrow+0x143>
80100846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010084d:	8d 76 00             	lea    0x0(%esi),%esi

80100850 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100850:	f3 0f 1e fb          	endbr32 
80100854:	55                   	push   %ebp
80100855:	89 e5                	mov    %esp,%ebp
80100857:	57                   	push   %edi
80100858:	56                   	push   %esi
80100859:	53                   	push   %ebx
8010085a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010085d:	ff 75 08             	pushl  0x8(%ebp)
{
80100860:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100863:	e8 c8 14 00 00       	call   80101d30 <iunlock>
  acquire(&cons.lock);
80100868:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010086f:	e8 dc 41 00 00       	call   80104a50 <acquire>
  for(i = 0; i < n; i++)
80100874:	83 c4 10             	add    $0x10,%esp
80100877:	85 db                	test   %ebx,%ebx
80100879:	7e 24                	jle    8010089f <consolewrite+0x4f>
8010087b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010087e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100881:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100887:	85 d2                	test   %edx,%edx
80100889:	74 05                	je     80100890 <consolewrite+0x40>
8010088b:	fa                   	cli    
    for(;;)
8010088c:	eb fe                	jmp    8010088c <consolewrite+0x3c>
8010088e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100890:	0f b6 07             	movzbl (%edi),%eax
80100893:	83 c7 01             	add    $0x1,%edi
80100896:	e8 75 fb ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
8010089b:	39 fe                	cmp    %edi,%esi
8010089d:	75 e2                	jne    80100881 <consolewrite+0x31>
  release(&cons.lock);
8010089f:	83 ec 0c             	sub    $0xc,%esp
801008a2:	68 20 b5 10 80       	push   $0x8010b520
801008a7:	e8 64 42 00 00       	call   80104b10 <release>
  ilock(ip);
801008ac:	58                   	pop    %eax
801008ad:	ff 75 08             	pushl  0x8(%ebp)
801008b0:	e8 9b 13 00 00       	call   80101c50 <ilock>

  return n;
}
801008b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008b8:	89 d8                	mov    %ebx,%eax
801008ba:	5b                   	pop    %ebx
801008bb:	5e                   	pop    %esi
801008bc:	5f                   	pop    %edi
801008bd:	5d                   	pop    %ebp
801008be:	c3                   	ret    
801008bf:	90                   	nop

801008c0 <cprintf>:
{
801008c0:	f3 0f 1e fb          	endbr32 
801008c4:	55                   	push   %ebp
801008c5:	89 e5                	mov    %esp,%ebp
801008c7:	57                   	push   %edi
801008c8:	56                   	push   %esi
801008c9:	53                   	push   %ebx
801008ca:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801008cd:	a1 54 b5 10 80       	mov    0x8010b554,%eax
801008d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801008d5:	85 c0                	test   %eax,%eax
801008d7:	0f 85 e8 00 00 00    	jne    801009c5 <cprintf+0x105>
  if (fmt == 0)
801008dd:	8b 45 08             	mov    0x8(%ebp),%eax
801008e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801008e3:	85 c0                	test   %eax,%eax
801008e5:	0f 84 5a 01 00 00    	je     80100a45 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008eb:	0f b6 00             	movzbl (%eax),%eax
801008ee:	85 c0                	test   %eax,%eax
801008f0:	74 36                	je     80100928 <cprintf+0x68>
  argp = (uint*)(void*)(&fmt + 1);
801008f2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008f5:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801008f7:	83 f8 25             	cmp    $0x25,%eax
801008fa:	74 44                	je     80100940 <cprintf+0x80>
  if(panicked){
801008fc:	8b 0d 5c b5 10 80    	mov    0x8010b55c,%ecx
80100902:	85 c9                	test   %ecx,%ecx
80100904:	74 0f                	je     80100915 <cprintf+0x55>
80100906:	fa                   	cli    
    for(;;)
80100907:	eb fe                	jmp    80100907 <cprintf+0x47>
80100909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100910:	b8 25 00 00 00       	mov    $0x25,%eax
80100915:	e8 f6 fa ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010091a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010091d:	83 c6 01             	add    $0x1,%esi
80100920:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100924:	85 c0                	test   %eax,%eax
80100926:	75 cf                	jne    801008f7 <cprintf+0x37>
  if(locking)
80100928:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010092b:	85 c0                	test   %eax,%eax
8010092d:	0f 85 fd 00 00 00    	jne    80100a30 <cprintf+0x170>
}
80100933:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100936:	5b                   	pop    %ebx
80100937:	5e                   	pop    %esi
80100938:	5f                   	pop    %edi
80100939:	5d                   	pop    %ebp
8010093a:	c3                   	ret    
8010093b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010093f:	90                   	nop
    c = fmt[++i] & 0xff;
80100940:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100943:	83 c6 01             	add    $0x1,%esi
80100946:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
8010094a:	85 ff                	test   %edi,%edi
8010094c:	74 da                	je     80100928 <cprintf+0x68>
    switch(c){
8010094e:	83 ff 70             	cmp    $0x70,%edi
80100951:	74 5a                	je     801009ad <cprintf+0xed>
80100953:	7f 2a                	jg     8010097f <cprintf+0xbf>
80100955:	83 ff 25             	cmp    $0x25,%edi
80100958:	0f 84 92 00 00 00    	je     801009f0 <cprintf+0x130>
8010095e:	83 ff 64             	cmp    $0x64,%edi
80100961:	0f 85 a1 00 00 00    	jne    80100a08 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100967:	8b 03                	mov    (%ebx),%eax
80100969:	8d 7b 04             	lea    0x4(%ebx),%edi
8010096c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100971:	ba 0a 00 00 00       	mov    $0xa,%edx
80100976:	89 fb                	mov    %edi,%ebx
80100978:	e8 a3 fc ff ff       	call   80100620 <printint>
      break;
8010097d:	eb 9b                	jmp    8010091a <cprintf+0x5a>
    switch(c){
8010097f:	83 ff 73             	cmp    $0x73,%edi
80100982:	75 24                	jne    801009a8 <cprintf+0xe8>
      if((s = (char*)*argp++) == 0)
80100984:	8d 7b 04             	lea    0x4(%ebx),%edi
80100987:	8b 1b                	mov    (%ebx),%ebx
80100989:	85 db                	test   %ebx,%ebx
8010098b:	75 55                	jne    801009e2 <cprintf+0x122>
        s = "(null)";
8010098d:	bb 38 76 10 80       	mov    $0x80107638,%ebx
      for(; *s; s++)
80100992:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100997:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
8010099d:	85 d2                	test   %edx,%edx
8010099f:	74 39                	je     801009da <cprintf+0x11a>
801009a1:	fa                   	cli    
    for(;;)
801009a2:	eb fe                	jmp    801009a2 <cprintf+0xe2>
801009a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801009a8:	83 ff 78             	cmp    $0x78,%edi
801009ab:	75 5b                	jne    80100a08 <cprintf+0x148>
      printint(*argp++, 16, 0);
801009ad:	8b 03                	mov    (%ebx),%eax
801009af:	8d 7b 04             	lea    0x4(%ebx),%edi
801009b2:	31 c9                	xor    %ecx,%ecx
801009b4:	ba 10 00 00 00       	mov    $0x10,%edx
801009b9:	89 fb                	mov    %edi,%ebx
801009bb:	e8 60 fc ff ff       	call   80100620 <printint>
      break;
801009c0:	e9 55 ff ff ff       	jmp    8010091a <cprintf+0x5a>
    acquire(&cons.lock);
801009c5:	83 ec 0c             	sub    $0xc,%esp
801009c8:	68 20 b5 10 80       	push   $0x8010b520
801009cd:	e8 7e 40 00 00       	call   80104a50 <acquire>
801009d2:	83 c4 10             	add    $0x10,%esp
801009d5:	e9 03 ff ff ff       	jmp    801008dd <cprintf+0x1d>
801009da:	e8 31 fa ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801009df:	83 c3 01             	add    $0x1,%ebx
801009e2:	0f be 03             	movsbl (%ebx),%eax
801009e5:	84 c0                	test   %al,%al
801009e7:	75 ae                	jne    80100997 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
801009e9:	89 fb                	mov    %edi,%ebx
801009eb:	e9 2a ff ff ff       	jmp    8010091a <cprintf+0x5a>
  if(panicked){
801009f0:	8b 3d 5c b5 10 80    	mov    0x8010b55c,%edi
801009f6:	85 ff                	test   %edi,%edi
801009f8:	0f 84 12 ff ff ff    	je     80100910 <cprintf+0x50>
801009fe:	fa                   	cli    
    for(;;)
801009ff:	eb fe                	jmp    801009ff <cprintf+0x13f>
80100a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100a08:	8b 0d 5c b5 10 80    	mov    0x8010b55c,%ecx
80100a0e:	85 c9                	test   %ecx,%ecx
80100a10:	74 06                	je     80100a18 <cprintf+0x158>
80100a12:	fa                   	cli    
    for(;;)
80100a13:	eb fe                	jmp    80100a13 <cprintf+0x153>
80100a15:	8d 76 00             	lea    0x0(%esi),%esi
80100a18:	b8 25 00 00 00       	mov    $0x25,%eax
80100a1d:	e8 ee f9 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100a22:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100a28:	85 d2                	test   %edx,%edx
80100a2a:	74 2c                	je     80100a58 <cprintf+0x198>
80100a2c:	fa                   	cli    
    for(;;)
80100a2d:	eb fe                	jmp    80100a2d <cprintf+0x16d>
80100a2f:	90                   	nop
    release(&cons.lock);
80100a30:	83 ec 0c             	sub    $0xc,%esp
80100a33:	68 20 b5 10 80       	push   $0x8010b520
80100a38:	e8 d3 40 00 00       	call   80104b10 <release>
80100a3d:	83 c4 10             	add    $0x10,%esp
}
80100a40:	e9 ee fe ff ff       	jmp    80100933 <cprintf+0x73>
    panic("null fmt");
80100a45:	83 ec 0c             	sub    $0xc,%esp
80100a48:	68 3f 76 10 80       	push   $0x8010763f
80100a4d:	e8 3e f9 ff ff       	call   80100390 <panic>
80100a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100a58:	89 f8                	mov    %edi,%eax
80100a5a:	e8 b1 f9 ff ff       	call   80100410 <consputc.part.0>
80100a5f:	e9 b6 fe ff ff       	jmp    8010091a <cprintf+0x5a>
80100a64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a6f:	90                   	nop

80100a70 <consoleintr>:
{
80100a70:	f3 0f 1e fb          	endbr32 
80100a74:	55                   	push   %ebp
80100a75:	89 e5                	mov    %esp,%ebp
80100a77:	57                   	push   %edi
80100a78:	56                   	push   %esi
80100a79:	53                   	push   %ebx
  int c, doprocdump = 0;
80100a7a:	31 db                	xor    %ebx,%ebx
{
80100a7c:	83 ec 28             	sub    $0x28,%esp
80100a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
80100a82:	68 20 b5 10 80       	push   $0x8010b520
{
80100a87:	89 45 dc             	mov    %eax,-0x24(%ebp)
  acquire(&cons.lock);
80100a8a:	e8 c1 3f 00 00       	call   80104a50 <acquire>
  while((c = getc()) >= 0){
80100a8f:	83 c4 10             	add    $0x10,%esp
80100a92:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100a95:	ff d0                	call   *%eax
80100a97:	89 c6                	mov    %eax,%esi
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	0f 88 bc 02 00 00    	js     80100d5d <consoleintr+0x2ed>
    switch(c){
80100aa1:	83 fe 15             	cmp    $0x15,%esi
80100aa4:	7f 5a                	jg     80100b00 <consoleintr+0x90>
80100aa6:	83 fe 01             	cmp    $0x1,%esi
80100aa9:	0f 8e b1 01 00 00    	jle    80100c60 <consoleintr+0x1f0>
80100aaf:	83 fe 15             	cmp    $0x15,%esi
80100ab2:	0f 87 a8 01 00 00    	ja     80100c60 <consoleintr+0x1f0>
80100ab8:	3e ff 24 b5 50 76 10 	notrack jmp *-0x7fef89b0(,%esi,4)
80100abf:	80 
80100ac0:	bb 01 00 00 00       	mov    $0x1,%ebx
80100ac5:	eb cb                	jmp    80100a92 <consoleintr+0x22>
80100ac7:	b8 00 01 00 00       	mov    $0x100,%eax
80100acc:	e8 3f f9 ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100ad1:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100ad6:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
80100adc:	74 b4                	je     80100a92 <consoleintr+0x22>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100ade:	83 e8 01             	sub    $0x1,%eax
80100ae1:	89 c2                	mov    %eax,%edx
80100ae3:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100ae6:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
80100aed:	74 a3                	je     80100a92 <consoleintr+0x22>
        input.e--;
80100aef:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
  if(panicked){
80100af4:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
80100af9:	85 c0                	test   %eax,%eax
80100afb:	74 ca                	je     80100ac7 <consoleintr+0x57>
80100afd:	fa                   	cli    
    for(;;)
80100afe:	eb fe                	jmp    80100afe <consoleintr+0x8e>
    switch(c){
80100b00:	81 fe e2 00 00 00    	cmp    $0xe2,%esi
80100b06:	0f 84 24 02 00 00    	je     80100d30 <consoleintr+0x2c0>
80100b0c:	81 fe e3 00 00 00    	cmp    $0xe3,%esi
80100b12:	75 34                	jne    80100b48 <consoleintr+0xd8>
      if ((history.count != 0 ) && (history.last - history.index > 0))
80100b14:	a1 3c 15 11 80       	mov    0x8011153c,%eax
80100b19:	85 c0                	test   %eax,%eax
80100b1b:	0f 84 71 ff ff ff    	je     80100a92 <consoleintr+0x22>
80100b21:	a1 40 15 11 80       	mov    0x80111540,%eax
80100b26:	2b 05 38 15 11 80    	sub    0x80111538,%eax
80100b2c:	85 c0                	test   %eax,%eax
80100b2e:	0f 8e 5e ff ff ff    	jle    80100a92 <consoleintr+0x22>
        arrow(DOWN);
80100b34:	b8 01 00 00 00       	mov    $0x1,%eax
80100b39:	e8 82 fb ff ff       	call   801006c0 <arrow>
80100b3e:	e9 4f ff ff ff       	jmp    80100a92 <consoleintr+0x22>
80100b43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b47:	90                   	nop
    switch(c){
80100b48:	83 fe 7f             	cmp    $0x7f,%esi
80100b4b:	0f 85 17 01 00 00    	jne    80100c68 <consoleintr+0x1f8>
      if(input.e != input.w){
80100b51:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100b56:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
80100b5c:	0f 84 30 ff ff ff    	je     80100a92 <consoleintr+0x22>
        input.e--;  
80100b62:	83 e8 01             	sub    $0x1,%eax
80100b65:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
  if(panicked){
80100b6a:	a1 5c b5 10 80       	mov    0x8010b55c,%eax
80100b6f:	85 c0                	test   %eax,%eax
80100b71:	0f 84 06 02 00 00    	je     80100d7d <consoleintr+0x30d>
80100b77:	fa                   	cli    
    for(;;)
80100b78:	eb fe                	jmp    80100b78 <consoleintr+0x108>
      if (backs > 0) {
80100b7a:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100b7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100b82:	85 c0                	test   %eax,%eax
80100b84:	0f 8e 08 ff ff ff    	jle    80100a92 <consoleintr+0x22>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b8a:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b8f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b94:	89 fa                	mov    %edi,%edx
80100b96:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b97:	be d5 03 00 00       	mov    $0x3d5,%esi
80100b9c:	89 f2                	mov    %esi,%edx
80100b9e:	ec                   	in     (%dx),%al
80100b9f:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ba2:	89 fa                	mov    %edi,%edx
80100ba4:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT + 1) << 8;
80100ba9:	c1 e1 08             	shl    $0x8,%ecx
80100bac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100bad:	89 f2                	mov    %esi,%edx
80100baf:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT + 1);
80100bb0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100bb3:	89 fa                	mov    %edi,%edx
80100bb5:	09 c1                	or     %eax,%ecx
80100bb7:	b8 0e 00 00 00       	mov    $0xe,%eax
    pos++;
80100bbc:	83 c1 01             	add    $0x1,%ecx
80100bbf:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, pos >> 8);
80100bc0:	89 ca                	mov    %ecx,%edx
80100bc2:	c1 fa 08             	sar    $0x8,%edx
80100bc5:	89 d0                	mov    %edx,%eax
80100bc7:	89 f2                	mov    %esi,%edx
80100bc9:	ee                   	out    %al,(%dx)
80100bca:	b8 0f 00 00 00       	mov    $0xf,%eax
80100bcf:	89 fa                	mov    %edi,%edx
80100bd1:	ee                   	out    %al,(%dx)
80100bd2:	89 c8                	mov    %ecx,%eax
80100bd4:	89 f2                	mov    %esi,%edx
80100bd6:	ee                   	out    %al,(%dx)
        backs--;
80100bd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100bda:	83 e8 01             	sub    $0x1,%eax
80100bdd:	a3 58 b5 10 80       	mov    %eax,0x8010b558
80100be2:	e9 ab fe ff ff       	jmp    80100a92 <consoleintr+0x22>
      if ((input.e - backs) > input.w)
80100be7:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100bec:	8b 3d a8 0f 11 80    	mov    0x80110fa8,%edi
80100bf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100bf5:	29 c7                	sub    %eax,%edi
80100bf7:	3b 3d a4 0f 11 80    	cmp    0x80110fa4,%edi
80100bfd:	0f 86 8f fe ff ff    	jbe    80100a92 <consoleintr+0x22>
80100c03:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100c08:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c0d:	89 fa                	mov    %edi,%edx
80100c0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c10:	be d5 03 00 00       	mov    $0x3d5,%esi
80100c15:	89 f2                	mov    %esi,%edx
80100c17:	ec                   	in     (%dx),%al
80100c18:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c1b:	89 fa                	mov    %edi,%edx
80100c1d:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT + 1) << 8;
80100c22:	c1 e1 08             	shl    $0x8,%ecx
80100c25:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c26:	89 f2                	mov    %esi,%edx
80100c28:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT + 1);
80100c29:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c2c:	89 fa                	mov    %edi,%edx
80100c2e:	09 c1                	or     %eax,%ecx
80100c30:	b8 0e 00 00 00       	mov    $0xe,%eax
    pos--;
80100c35:	83 e9 01             	sub    $0x1,%ecx
80100c38:	ee                   	out    %al,(%dx)
  outb(CRTPORT + 1, pos >> 8);
80100c39:	89 ca                	mov    %ecx,%edx
80100c3b:	c1 fa 08             	sar    $0x8,%edx
80100c3e:	89 d0                	mov    %edx,%eax
80100c40:	89 f2                	mov    %esi,%edx
80100c42:	ee                   	out    %al,(%dx)
80100c43:	b8 0f 00 00 00       	mov    $0xf,%eax
80100c48:	89 fa                	mov    %edi,%edx
80100c4a:	ee                   	out    %al,(%dx)
80100c4b:	89 c8                	mov    %ecx,%eax
80100c4d:	89 f2                	mov    %esi,%edx
80100c4f:	ee                   	out    %al,(%dx)
        backs++;
80100c50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c53:	83 c0 01             	add    $0x1,%eax
80100c56:	a3 58 b5 10 80       	mov    %eax,0x8010b558
80100c5b:	e9 32 fe ff ff       	jmp    80100a92 <consoleintr+0x22>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100c60:	85 f6                	test   %esi,%esi
80100c62:	0f 84 2a fe ff ff    	je     80100a92 <consoleintr+0x22>
80100c68:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100c6d:	89 c2                	mov    %eax,%edx
80100c6f:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
80100c75:	83 fa 7f             	cmp    $0x7f,%edx
80100c78:	0f 87 14 fe ff ff    	ja     80100a92 <consoleintr+0x22>
        c = (c == '\r') ? '\n' : c;
80100c7e:	8d 48 01             	lea    0x1(%eax),%ecx
80100c81:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100c87:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
80100c8a:	89 0d a8 0f 11 80    	mov    %ecx,0x80110fa8
        c = (c == '\r') ? '\n' : c;
80100c90:	83 fe 0d             	cmp    $0xd,%esi
80100c93:	0f 84 f3 00 00 00    	je     80100d8c <consoleintr+0x31c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100c99:	89 f1                	mov    %esi,%ecx
80100c9b:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
  if(panicked){
80100ca1:	85 d2                	test   %edx,%edx
80100ca3:	0f 84 d7 01 00 00    	je     80100e80 <consoleintr+0x410>
  asm volatile("cli");
80100ca9:	fa                   	cli    
    for(;;)
80100caa:	eb fe                	jmp    80100caa <consoleintr+0x23a>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cac:	be d4 03 00 00       	mov    $0x3d4,%esi
80100cb1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cb6:	89 f2                	mov    %esi,%edx
80100cb8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cb9:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100cbe:	89 ca                	mov    %ecx,%edx
80100cc0:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cc1:	b8 0f 00 00 00       	mov    $0xf,%eax
80100cc6:	89 f2                	mov    %esi,%edx
80100cc8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cc9:	89 ca                	mov    %ecx,%edx
80100ccb:	ec                   	in     (%dx),%al
80100ccc:	be d0 07 00 00       	mov    $0x7d0,%esi
  if(panicked){
80100cd1:	8b 3d 5c b5 10 80    	mov    0x8010b55c,%edi
80100cd7:	85 ff                	test   %edi,%edi
80100cd9:	74 05                	je     80100ce0 <consoleintr+0x270>
  asm volatile("cli");
80100cdb:	fa                   	cli    
    for(;;)
80100cdc:	eb fe                	jmp    80100cdc <consoleintr+0x26c>
80100cde:	66 90                	xchg   %ax,%ax
80100ce0:	b8 00 01 00 00       	mov    $0x100,%eax
80100ce5:	e8 26 f7 ff ff       	call   80100410 <consputc.part.0>
  for (int pos = 0; pos < SCREEN_SIZE ; pos++){
80100cea:	83 ee 01             	sub    $0x1,%esi
80100ced:	75 e2                	jne    80100cd1 <consoleintr+0x261>
  if(panicked){
80100cef:	8b 0d 5c b5 10 80    	mov    0x8010b55c,%ecx
  backs = 0;
80100cf5:	c7 05 58 b5 10 80 00 	movl   $0x0,0x8010b558
80100cfc:	00 00 00 
  input.e = input.w = input.r = 0;
80100cff:	c7 05 a0 0f 11 80 00 	movl   $0x0,0x80110fa0
80100d06:	00 00 00 
80100d09:	c7 05 a4 0f 11 80 00 	movl   $0x0,0x80110fa4
80100d10:	00 00 00 
80100d13:	c7 05 a8 0f 11 80 00 	movl   $0x0,0x80110fa8
80100d1a:	00 00 00 
  if(panicked){
80100d1d:	85 c9                	test   %ecx,%ecx
80100d1f:	0f 84 fb 00 00 00    	je     80100e20 <consoleintr+0x3b0>
80100d25:	fa                   	cli    
    for(;;)
80100d26:	eb fe                	jmp    80100d26 <consoleintr+0x2b6>
80100d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d2f:	90                   	nop
      if ((history.count != 0)  && (history.last - history.index < history.count))
80100d30:	8b 15 3c 15 11 80    	mov    0x8011153c,%edx
80100d36:	85 d2                	test   %edx,%edx
80100d38:	0f 84 54 fd ff ff    	je     80100a92 <consoleintr+0x22>
80100d3e:	a1 40 15 11 80       	mov    0x80111540,%eax
80100d43:	2b 05 38 15 11 80    	sub    0x80111538,%eax
80100d49:	39 c2                	cmp    %eax,%edx
80100d4b:	0f 8e 41 fd ff ff    	jle    80100a92 <consoleintr+0x22>
        arrow(UP);
80100d51:	31 c0                	xor    %eax,%eax
80100d53:	e8 68 f9 ff ff       	call   801006c0 <arrow>
80100d58:	e9 35 fd ff ff       	jmp    80100a92 <consoleintr+0x22>
  release(&cons.lock);
80100d5d:	83 ec 0c             	sub    $0xc,%esp
80100d60:	68 20 b5 10 80       	push   $0x8010b520
80100d65:	e8 a6 3d 00 00       	call   80104b10 <release>
  if(doprocdump) {
80100d6a:	83 c4 10             	add    $0x10,%esp
80100d6d:	85 db                	test   %ebx,%ebx
80100d6f:	0f 85 40 01 00 00    	jne    80100eb5 <consoleintr+0x445>
}
80100d75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d78:	5b                   	pop    %ebx
80100d79:	5e                   	pop    %esi
80100d7a:	5f                   	pop    %edi
80100d7b:	5d                   	pop    %ebp
80100d7c:	c3                   	ret    
80100d7d:	b8 00 01 00 00       	mov    $0x100,%eax
80100d82:	e8 89 f6 ff ff       	call   80100410 <consputc.part.0>
80100d87:	e9 06 fd ff ff       	jmp    80100a92 <consoleintr+0x22>
        input.buf[input.e++ % INPUT_BUF] = c;
80100d8c:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
  if(panicked){
80100d93:	85 d2                	test   %edx,%edx
80100d95:	0f 85 0e ff ff ff    	jne    80100ca9 <consoleintr+0x239>
80100d9b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100da0:	e8 6b f6 ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100da5:	8b 15 a8 0f 11 80    	mov    0x80110fa8,%edx
          if (history.count < 9){
80100dab:	a1 3c 15 11 80       	mov    0x8011153c,%eax
80100db0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100db3:	83 f8 08             	cmp    $0x8,%eax
80100db6:	0f 8f 05 01 00 00    	jg     80100ec1 <consoleintr+0x451>
            history.hist[history.last + 1] = input;
80100dbc:	8b 3d 40 15 11 80    	mov    0x80111540,%edi
80100dc2:	b9 23 00 00 00       	mov    $0x23,%ecx
80100dc7:	be 20 0f 11 80       	mov    $0x80110f20,%esi
80100dcc:	83 c7 01             	add    $0x1,%edi
80100dcf:	69 c7 8c 00 00 00    	imul   $0x8c,%edi,%eax
80100dd5:	89 7d e0             	mov    %edi,-0x20(%ebp)
80100dd8:	05 c0 0f 11 80       	add    $0x80110fc0,%eax
80100ddd:	89 c7                	mov    %eax,%edi
            history.count ++ ;
80100ddf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
            history.hist[history.last + 1] = input;
80100de2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            history.last ++ ;
80100de4:	8b 7d e0             	mov    -0x20(%ebp),%edi
            history.count ++ ;
80100de7:	83 c0 01             	add    $0x1,%eax
            history.last ++ ;
80100dea:	89 3d 40 15 11 80    	mov    %edi,0x80111540
            history.index = history.last;
80100df0:	89 3d 38 15 11 80    	mov    %edi,0x80111538
            history.count ++ ;
80100df6:	a3 3c 15 11 80       	mov    %eax,0x8011153c
          wakeup(&input.r);
80100dfb:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100dfe:	89 15 a4 0f 11 80    	mov    %edx,0x80110fa4
          wakeup(&input.r);
80100e04:	68 a0 0f 11 80       	push   $0x80110fa0
          backs = 0;
80100e09:	c7 05 58 b5 10 80 00 	movl   $0x0,0x8010b558
80100e10:	00 00 00 
          wakeup(&input.r);
80100e13:	e8 b8 37 00 00       	call   801045d0 <wakeup>
80100e18:	83 c4 10             	add    $0x10,%esp
80100e1b:	e9 72 fc ff ff       	jmp    80100a92 <consoleintr+0x22>
80100e20:	b8 24 00 00 00       	mov    $0x24,%eax
80100e25:	e8 e6 f5 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100e2a:	8b 15 5c b5 10 80    	mov    0x8010b55c,%edx
80100e30:	85 d2                	test   %edx,%edx
80100e32:	74 0c                	je     80100e40 <consoleintr+0x3d0>
80100e34:	fa                   	cli    
    for(;;)
80100e35:	eb fe                	jmp    80100e35 <consoleintr+0x3c5>
80100e37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e3e:	66 90                	xchg   %ax,%ax
80100e40:	b8 20 00 00 00       	mov    $0x20,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100e45:	be d4 03 00 00       	mov    $0x3d4,%esi
80100e4a:	e8 c1 f5 ff ff       	call   80100410 <consputc.part.0>
80100e4f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100e54:	89 f2                	mov    %esi,%edx
80100e56:	ee                   	out    %al,(%dx)
80100e57:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100e5c:	31 c0                	xor    %eax,%eax
80100e5e:	89 ca                	mov    %ecx,%edx
80100e60:	ee                   	out    %al,(%dx)
80100e61:	b8 0f 00 00 00       	mov    $0xf,%eax
80100e66:	89 f2                	mov    %esi,%edx
80100e68:	ee                   	out    %al,(%dx)
80100e69:	b8 02 00 00 00       	mov    $0x2,%eax
80100e6e:	89 ca                	mov    %ecx,%edx
80100e70:	ee                   	out    %al,(%dx)
}
80100e71:	e9 1c fc ff ff       	jmp    80100a92 <consoleintr+0x22>
80100e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e7d:	8d 76 00             	lea    0x0(%esi),%esi
80100e80:	89 f0                	mov    %esi,%eax
80100e82:	e8 89 f5 ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100e87:	83 fe 0a             	cmp    $0xa,%esi
80100e8a:	0f 84 15 ff ff ff    	je     80100da5 <consoleintr+0x335>
80100e90:	83 fe 04             	cmp    $0x4,%esi
80100e93:	0f 84 0c ff ff ff    	je     80100da5 <consoleintr+0x335>
80100e99:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
80100e9e:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
80100ea4:	39 15 a8 0f 11 80    	cmp    %edx,0x80110fa8
80100eaa:	0f 85 e2 fb ff ff    	jne    80100a92 <consoleintr+0x22>
80100eb0:	e9 f6 fe ff ff       	jmp    80100dab <consoleintr+0x33b>
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100ebc:	e9 ff 37 00 00       	jmp    801046c0 <procdump>
80100ec1:	b8 c0 0f 11 80       	mov    $0x80110fc0,%eax
              history.hist[h] = history.hist[h+1]; 
80100ec6:	8d b0 8c 00 00 00    	lea    0x8c(%eax),%esi
80100ecc:	89 c7                	mov    %eax,%edi
80100ece:	b9 23 00 00 00       	mov    $0x23,%ecx
80100ed3:	05 8c 00 00 00       	add    $0x8c,%eax
80100ed8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            for (int h = 0; h < 9; h++) {
80100eda:	bf ac 14 11 80       	mov    $0x801114ac,%edi
80100edf:	39 c7                	cmp    %eax,%edi
80100ee1:	75 e3                	jne    80100ec6 <consoleintr+0x456>
            history.hist[9] = input;
80100ee3:	b9 23 00 00 00       	mov    $0x23,%ecx
80100ee8:	be 20 0f 11 80       	mov    $0x80110f20,%esi
            history.index = 9;
80100eed:	c7 05 38 15 11 80 09 	movl   $0x9,0x80111538
80100ef4:	00 00 00 
            history.hist[9] = input;
80100ef7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            history.last = 9;
80100ef9:	c7 05 40 15 11 80 09 	movl   $0x9,0x80111540
80100f00:	00 00 00 
            history.count = 10;
80100f03:	c7 05 3c 15 11 80 0a 	movl   $0xa,0x8011153c
80100f0a:	00 00 00 
80100f0d:	e9 e9 fe ff ff       	jmp    80100dfb <consoleintr+0x38b>
80100f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f20 <consoleinit>:

void
consoleinit(void)
{
80100f20:	f3 0f 1e fb          	endbr32 
80100f24:	55                   	push   %ebp
80100f25:	89 e5                	mov    %esp,%ebp
80100f27:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100f2a:	68 48 76 10 80       	push   $0x80107648
80100f2f:	68 20 b5 10 80       	push   $0x8010b520
80100f34:	e8 97 39 00 00       	call   801048d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100f39:	58                   	pop    %eax
80100f3a:	5a                   	pop    %edx
80100f3b:	6a 00                	push   $0x0
80100f3d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100f3f:	c7 05 0c 1f 11 80 50 	movl   $0x80100850,0x80111f0c
80100f46:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80100f49:	c7 05 08 1f 11 80 90 	movl   $0x80100290,0x80111f08
80100f50:	02 10 80 
  cons.locking = 1;
80100f53:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
80100f5a:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100f5d:	e8 be 19 00 00       	call   80102920 <ioapicenable>
}
80100f62:	83 c4 10             	add    $0x10,%esp
80100f65:	c9                   	leave  
80100f66:	c3                   	ret    
80100f67:	66 90                	xchg   %ax,%ax
80100f69:	66 90                	xchg   %ax,%ax
80100f6b:	66 90                	xchg   %ax,%ax
80100f6d:	66 90                	xchg   %ax,%ax
80100f6f:	90                   	nop

80100f70 <exec>:
80100f70:	f3 0f 1e fb          	endbr32 
80100f74:	55                   	push   %ebp
80100f75:	89 e5                	mov    %esp,%ebp
80100f77:	57                   	push   %edi
80100f78:	56                   	push   %esi
80100f79:	53                   	push   %ebx
80100f7a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
80100f80:	e8 cb 2e 00 00       	call   80103e50 <myproc>
80100f85:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100f8b:	e8 90 22 00 00       	call   80103220 <begin_op>
80100f90:	83 ec 0c             	sub    $0xc,%esp
80100f93:	ff 75 08             	pushl  0x8(%ebp)
80100f96:	e8 85 15 00 00       	call   80102520 <namei>
80100f9b:	83 c4 10             	add    $0x10,%esp
80100f9e:	85 c0                	test   %eax,%eax
80100fa0:	0f 84 fe 02 00 00    	je     801012a4 <exec+0x334>
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	89 c3                	mov    %eax,%ebx
80100fab:	50                   	push   %eax
80100fac:	e8 9f 0c 00 00       	call   80101c50 <ilock>
80100fb1:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100fb7:	6a 34                	push   $0x34
80100fb9:	6a 00                	push   $0x0
80100fbb:	50                   	push   %eax
80100fbc:	53                   	push   %ebx
80100fbd:	e8 8e 0f 00 00       	call   80101f50 <readi>
80100fc2:	83 c4 20             	add    $0x20,%esp
80100fc5:	83 f8 34             	cmp    $0x34,%eax
80100fc8:	74 26                	je     80100ff0 <exec+0x80>
80100fca:	83 ec 0c             	sub    $0xc,%esp
80100fcd:	53                   	push   %ebx
80100fce:	e8 1d 0f 00 00       	call   80101ef0 <iunlockput>
80100fd3:	e8 b8 22 00 00       	call   80103290 <end_op>
80100fd8:	83 c4 10             	add    $0x10,%esp
80100fdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe3:	5b                   	pop    %ebx
80100fe4:	5e                   	pop    %esi
80100fe5:	5f                   	pop    %edi
80100fe6:	5d                   	pop    %ebp
80100fe7:	c3                   	ret    
80100fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fef:	90                   	nop
80100ff0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ff7:	45 4c 46 
80100ffa:	75 ce                	jne    80100fca <exec+0x5a>
80100ffc:	e8 3f 63 00 00       	call   80107340 <setupkvm>
80101001:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101007:	85 c0                	test   %eax,%eax
80101009:	74 bf                	je     80100fca <exec+0x5a>
8010100b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101012:	00 
80101013:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101019:	0f 84 a4 02 00 00    	je     801012c3 <exec+0x353>
8010101f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101026:	00 00 00 
80101029:	31 ff                	xor    %edi,%edi
8010102b:	e9 86 00 00 00       	jmp    801010b6 <exec+0x146>
80101030:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101037:	75 6c                	jne    801010a5 <exec+0x135>
80101039:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010103f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101045:	0f 82 87 00 00 00    	jb     801010d2 <exec+0x162>
8010104b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101051:	72 7f                	jb     801010d2 <exec+0x162>
80101053:	83 ec 04             	sub    $0x4,%esp
80101056:	50                   	push   %eax
80101057:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010105d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101063:	e8 f8 60 00 00       	call   80107160 <allocuvm>
80101068:	83 c4 10             	add    $0x10,%esp
8010106b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101071:	85 c0                	test   %eax,%eax
80101073:	74 5d                	je     801010d2 <exec+0x162>
80101075:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010107b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101080:	75 50                	jne    801010d2 <exec+0x162>
80101082:	83 ec 0c             	sub    $0xc,%esp
80101085:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
8010108b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101091:	53                   	push   %ebx
80101092:	50                   	push   %eax
80101093:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101099:	e8 f2 5f 00 00       	call   80107090 <loaduvm>
8010109e:	83 c4 20             	add    $0x20,%esp
801010a1:	85 c0                	test   %eax,%eax
801010a3:	78 2d                	js     801010d2 <exec+0x162>
801010a5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801010ac:	83 c7 01             	add    $0x1,%edi
801010af:	83 c6 20             	add    $0x20,%esi
801010b2:	39 f8                	cmp    %edi,%eax
801010b4:	7e 3a                	jle    801010f0 <exec+0x180>
801010b6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801010bc:	6a 20                	push   $0x20
801010be:	56                   	push   %esi
801010bf:	50                   	push   %eax
801010c0:	53                   	push   %ebx
801010c1:	e8 8a 0e 00 00       	call   80101f50 <readi>
801010c6:	83 c4 10             	add    $0x10,%esp
801010c9:	83 f8 20             	cmp    $0x20,%eax
801010cc:	0f 84 5e ff ff ff    	je     80101030 <exec+0xc0>
801010d2:	83 ec 0c             	sub    $0xc,%esp
801010d5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010db:	e8 e0 61 00 00       	call   801072c0 <freevm>
801010e0:	83 c4 10             	add    $0x10,%esp
801010e3:	e9 e2 fe ff ff       	jmp    80100fca <exec+0x5a>
801010e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ef:	90                   	nop
801010f0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801010f6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801010fc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80101102:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
80101108:	83 ec 0c             	sub    $0xc,%esp
8010110b:	53                   	push   %ebx
8010110c:	e8 df 0d 00 00       	call   80101ef0 <iunlockput>
80101111:	e8 7a 21 00 00       	call   80103290 <end_op>
80101116:	83 c4 0c             	add    $0xc,%esp
80101119:	56                   	push   %esi
8010111a:	57                   	push   %edi
8010111b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101121:	57                   	push   %edi
80101122:	e8 39 60 00 00       	call   80107160 <allocuvm>
80101127:	83 c4 10             	add    $0x10,%esp
8010112a:	89 c6                	mov    %eax,%esi
8010112c:	85 c0                	test   %eax,%eax
8010112e:	0f 84 94 00 00 00    	je     801011c8 <exec+0x258>
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
8010113d:	89 f3                	mov    %esi,%ebx
8010113f:	50                   	push   %eax
80101140:	57                   	push   %edi
80101141:	31 ff                	xor    %edi,%edi
80101143:	e8 98 62 00 00       	call   801073e0 <clearpteu>
80101148:	8b 45 0c             	mov    0xc(%ebp),%eax
8010114b:	83 c4 10             	add    $0x10,%esp
8010114e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101154:	8b 00                	mov    (%eax),%eax
80101156:	85 c0                	test   %eax,%eax
80101158:	0f 84 8b 00 00 00    	je     801011e9 <exec+0x279>
8010115e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101164:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010116a:	eb 23                	jmp    8010118f <exec+0x21f>
8010116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101170:	8b 45 0c             	mov    0xc(%ebp),%eax
80101173:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
8010117a:	83 c7 01             	add    $0x1,%edi
8010117d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101183:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101186:	85 c0                	test   %eax,%eax
80101188:	74 59                	je     801011e3 <exec+0x273>
8010118a:	83 ff 20             	cmp    $0x20,%edi
8010118d:	74 39                	je     801011c8 <exec+0x258>
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	50                   	push   %eax
80101193:	e8 c8 3b 00 00       	call   80104d60 <strlen>
80101198:	f7 d0                	not    %eax
8010119a:	01 c3                	add    %eax,%ebx
8010119c:	58                   	pop    %eax
8010119d:	8b 45 0c             	mov    0xc(%ebp),%eax
801011a0:	83 e3 fc             	and    $0xfffffffc,%ebx
801011a3:	ff 34 b8             	pushl  (%eax,%edi,4)
801011a6:	e8 b5 3b 00 00       	call   80104d60 <strlen>
801011ab:	83 c0 01             	add    $0x1,%eax
801011ae:	50                   	push   %eax
801011af:	8b 45 0c             	mov    0xc(%ebp),%eax
801011b2:	ff 34 b8             	pushl  (%eax,%edi,4)
801011b5:	53                   	push   %ebx
801011b6:	56                   	push   %esi
801011b7:	e8 84 63 00 00       	call   80107540 <copyout>
801011bc:	83 c4 20             	add    $0x20,%esp
801011bf:	85 c0                	test   %eax,%eax
801011c1:	79 ad                	jns    80101170 <exec+0x200>
801011c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011c7:	90                   	nop
801011c8:	83 ec 0c             	sub    $0xc,%esp
801011cb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011d1:	e8 ea 60 00 00       	call   801072c0 <freevm>
801011d6:	83 c4 10             	add    $0x10,%esp
801011d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011de:	e9 fd fd ff ff       	jmp    80100fe0 <exec+0x70>
801011e3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801011e9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801011f0:	89 d9                	mov    %ebx,%ecx
801011f2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801011f9:	00 00 00 00 
801011fd:	29 c1                	sub    %eax,%ecx
801011ff:	83 c0 0c             	add    $0xc,%eax
80101202:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
80101208:	29 c3                	sub    %eax,%ebx
8010120a:	50                   	push   %eax
8010120b:	52                   	push   %edx
8010120c:	53                   	push   %ebx
8010120d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101213:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010121a:	ff ff ff 
8010121d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
80101223:	e8 18 63 00 00       	call   80107540 <copyout>
80101228:	83 c4 10             	add    $0x10,%esp
8010122b:	85 c0                	test   %eax,%eax
8010122d:	78 99                	js     801011c8 <exec+0x258>
8010122f:	8b 45 08             	mov    0x8(%ebp),%eax
80101232:	8b 55 08             	mov    0x8(%ebp),%edx
80101235:	0f b6 00             	movzbl (%eax),%eax
80101238:	84 c0                	test   %al,%al
8010123a:	74 13                	je     8010124f <exec+0x2df>
8010123c:	89 d1                	mov    %edx,%ecx
8010123e:	66 90                	xchg   %ax,%ax
80101240:	83 c1 01             	add    $0x1,%ecx
80101243:	3c 2f                	cmp    $0x2f,%al
80101245:	0f b6 01             	movzbl (%ecx),%eax
80101248:	0f 44 d1             	cmove  %ecx,%edx
8010124b:	84 c0                	test   %al,%al
8010124d:	75 f1                	jne    80101240 <exec+0x2d0>
8010124f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101255:	83 ec 04             	sub    $0x4,%esp
80101258:	6a 10                	push   $0x10
8010125a:	89 f8                	mov    %edi,%eax
8010125c:	52                   	push   %edx
8010125d:	83 c0 6c             	add    $0x6c,%eax
80101260:	50                   	push   %eax
80101261:	e8 ba 3a 00 00       	call   80104d20 <safestrcpy>
80101266:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
8010126c:	89 f8                	mov    %edi,%eax
8010126e:	8b 7f 04             	mov    0x4(%edi),%edi
80101271:	89 30                	mov    %esi,(%eax)
80101273:	89 48 04             	mov    %ecx,0x4(%eax)
80101276:	89 c1                	mov    %eax,%ecx
80101278:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010127e:	8b 40 18             	mov    0x18(%eax),%eax
80101281:	89 50 38             	mov    %edx,0x38(%eax)
80101284:	8b 41 18             	mov    0x18(%ecx),%eax
80101287:	89 58 44             	mov    %ebx,0x44(%eax)
8010128a:	89 0c 24             	mov    %ecx,(%esp)
8010128d:	e8 6e 5c 00 00       	call   80106f00 <switchuvm>
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 26 60 00 00       	call   801072c0 <freevm>
8010129a:	83 c4 10             	add    $0x10,%esp
8010129d:	31 c0                	xor    %eax,%eax
8010129f:	e9 3c fd ff ff       	jmp    80100fe0 <exec+0x70>
801012a4:	e8 e7 1f 00 00       	call   80103290 <end_op>
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 b9 76 10 80       	push   $0x801076b9
801012b1:	e8 0a f6 ff ff       	call   801008c0 <cprintf>
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012be:	e9 1d fd ff ff       	jmp    80100fe0 <exec+0x70>
801012c3:	31 ff                	xor    %edi,%edi
801012c5:	be 00 20 00 00       	mov    $0x2000,%esi
801012ca:	e9 39 fe ff ff       	jmp    80101108 <exec+0x198>
801012cf:	90                   	nop

801012d0 <fileinit>:
801012d0:	f3 0f 1e fb          	endbr32 
801012d4:	55                   	push   %ebp
801012d5:	89 e5                	mov    %esp,%ebp
801012d7:	83 ec 10             	sub    $0x10,%esp
801012da:	68 c5 76 10 80       	push   $0x801076c5
801012df:	68 60 15 11 80       	push   $0x80111560
801012e4:	e8 e7 35 00 00       	call   801048d0 <initlock>
801012e9:	83 c4 10             	add    $0x10,%esp
801012ec:	c9                   	leave  
801012ed:	c3                   	ret    
801012ee:	66 90                	xchg   %ax,%ax

801012f0 <filealloc>:
801012f0:	f3 0f 1e fb          	endbr32 
801012f4:	55                   	push   %ebp
801012f5:	89 e5                	mov    %esp,%ebp
801012f7:	53                   	push   %ebx
801012f8:	bb 94 15 11 80       	mov    $0x80111594,%ebx
801012fd:	83 ec 10             	sub    $0x10,%esp
80101300:	68 60 15 11 80       	push   $0x80111560
80101305:	e8 46 37 00 00       	call   80104a50 <acquire>
8010130a:	83 c4 10             	add    $0x10,%esp
8010130d:	eb 0c                	jmp    8010131b <filealloc+0x2b>
8010130f:	90                   	nop
80101310:	83 c3 18             	add    $0x18,%ebx
80101313:	81 fb f4 1e 11 80    	cmp    $0x80111ef4,%ebx
80101319:	74 25                	je     80101340 <filealloc+0x50>
8010131b:	8b 43 04             	mov    0x4(%ebx),%eax
8010131e:	85 c0                	test   %eax,%eax
80101320:	75 ee                	jne    80101310 <filealloc+0x20>
80101322:	83 ec 0c             	sub    $0xc,%esp
80101325:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
8010132c:	68 60 15 11 80       	push   $0x80111560
80101331:	e8 da 37 00 00       	call   80104b10 <release>
80101336:	89 d8                	mov    %ebx,%eax
80101338:	83 c4 10             	add    $0x10,%esp
8010133b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010133e:	c9                   	leave  
8010133f:	c3                   	ret    
80101340:	83 ec 0c             	sub    $0xc,%esp
80101343:	31 db                	xor    %ebx,%ebx
80101345:	68 60 15 11 80       	push   $0x80111560
8010134a:	e8 c1 37 00 00       	call   80104b10 <release>
8010134f:	89 d8                	mov    %ebx,%eax
80101351:	83 c4 10             	add    $0x10,%esp
80101354:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101357:	c9                   	leave  
80101358:	c3                   	ret    
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <filedup>:
80101360:	f3 0f 1e fb          	endbr32 
80101364:	55                   	push   %ebp
80101365:	89 e5                	mov    %esp,%ebp
80101367:	53                   	push   %ebx
80101368:	83 ec 10             	sub    $0x10,%esp
8010136b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010136e:	68 60 15 11 80       	push   $0x80111560
80101373:	e8 d8 36 00 00       	call   80104a50 <acquire>
80101378:	8b 43 04             	mov    0x4(%ebx),%eax
8010137b:	83 c4 10             	add    $0x10,%esp
8010137e:	85 c0                	test   %eax,%eax
80101380:	7e 1a                	jle    8010139c <filedup+0x3c>
80101382:	83 c0 01             	add    $0x1,%eax
80101385:	83 ec 0c             	sub    $0xc,%esp
80101388:	89 43 04             	mov    %eax,0x4(%ebx)
8010138b:	68 60 15 11 80       	push   $0x80111560
80101390:	e8 7b 37 00 00       	call   80104b10 <release>
80101395:	89 d8                	mov    %ebx,%eax
80101397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010139a:	c9                   	leave  
8010139b:	c3                   	ret    
8010139c:	83 ec 0c             	sub    $0xc,%esp
8010139f:	68 cc 76 10 80       	push   $0x801076cc
801013a4:	e8 e7 ef ff ff       	call   80100390 <panic>
801013a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013b0 <fileclose>:
801013b0:	f3 0f 1e fb          	endbr32 
801013b4:	55                   	push   %ebp
801013b5:	89 e5                	mov    %esp,%ebp
801013b7:	57                   	push   %edi
801013b8:	56                   	push   %esi
801013b9:	53                   	push   %ebx
801013ba:	83 ec 28             	sub    $0x28,%esp
801013bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801013c0:	68 60 15 11 80       	push   $0x80111560
801013c5:	e8 86 36 00 00       	call   80104a50 <acquire>
801013ca:	8b 53 04             	mov    0x4(%ebx),%edx
801013cd:	83 c4 10             	add    $0x10,%esp
801013d0:	85 d2                	test   %edx,%edx
801013d2:	0f 8e a1 00 00 00    	jle    80101479 <fileclose+0xc9>
801013d8:	83 ea 01             	sub    $0x1,%edx
801013db:	89 53 04             	mov    %edx,0x4(%ebx)
801013de:	75 40                	jne    80101420 <fileclose+0x70>
801013e0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801013e4:	83 ec 0c             	sub    $0xc,%esp
801013e7:	8b 3b                	mov    (%ebx),%edi
801013e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801013ef:	8b 73 0c             	mov    0xc(%ebx),%esi
801013f2:	88 45 e7             	mov    %al,-0x19(%ebp)
801013f5:	8b 43 10             	mov    0x10(%ebx),%eax
801013f8:	68 60 15 11 80       	push   $0x80111560
801013fd:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101400:	e8 0b 37 00 00       	call   80104b10 <release>
80101405:	83 c4 10             	add    $0x10,%esp
80101408:	83 ff 01             	cmp    $0x1,%edi
8010140b:	74 53                	je     80101460 <fileclose+0xb0>
8010140d:	83 ff 02             	cmp    $0x2,%edi
80101410:	74 26                	je     80101438 <fileclose+0x88>
80101412:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101415:	5b                   	pop    %ebx
80101416:	5e                   	pop    %esi
80101417:	5f                   	pop    %edi
80101418:	5d                   	pop    %ebp
80101419:	c3                   	ret    
8010141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101420:	c7 45 08 60 15 11 80 	movl   $0x80111560,0x8(%ebp)
80101427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142a:	5b                   	pop    %ebx
8010142b:	5e                   	pop    %esi
8010142c:	5f                   	pop    %edi
8010142d:	5d                   	pop    %ebp
8010142e:	e9 dd 36 00 00       	jmp    80104b10 <release>
80101433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101437:	90                   	nop
80101438:	e8 e3 1d 00 00       	call   80103220 <begin_op>
8010143d:	83 ec 0c             	sub    $0xc,%esp
80101440:	ff 75 e0             	pushl  -0x20(%ebp)
80101443:	e8 38 09 00 00       	call   80101d80 <iput>
80101448:	83 c4 10             	add    $0x10,%esp
8010144b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144e:	5b                   	pop    %ebx
8010144f:	5e                   	pop    %esi
80101450:	5f                   	pop    %edi
80101451:	5d                   	pop    %ebp
80101452:	e9 39 1e 00 00       	jmp    80103290 <end_op>
80101457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145e:	66 90                	xchg   %ax,%ax
80101460:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101464:	83 ec 08             	sub    $0x8,%esp
80101467:	53                   	push   %ebx
80101468:	56                   	push   %esi
80101469:	e8 82 25 00 00       	call   801039f0 <pipeclose>
8010146e:	83 c4 10             	add    $0x10,%esp
80101471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101474:	5b                   	pop    %ebx
80101475:	5e                   	pop    %esi
80101476:	5f                   	pop    %edi
80101477:	5d                   	pop    %ebp
80101478:	c3                   	ret    
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 d4 76 10 80       	push   $0x801076d4
80101481:	e8 0a ef ff ff       	call   80100390 <panic>
80101486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148d:	8d 76 00             	lea    0x0(%esi),%esi

80101490 <filestat>:
80101490:	f3 0f 1e fb          	endbr32 
80101494:	55                   	push   %ebp
80101495:	89 e5                	mov    %esp,%ebp
80101497:	53                   	push   %ebx
80101498:	83 ec 04             	sub    $0x4,%esp
8010149b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010149e:	83 3b 02             	cmpl   $0x2,(%ebx)
801014a1:	75 2d                	jne    801014d0 <filestat+0x40>
801014a3:	83 ec 0c             	sub    $0xc,%esp
801014a6:	ff 73 10             	pushl  0x10(%ebx)
801014a9:	e8 a2 07 00 00       	call   80101c50 <ilock>
801014ae:	58                   	pop    %eax
801014af:	5a                   	pop    %edx
801014b0:	ff 75 0c             	pushl  0xc(%ebp)
801014b3:	ff 73 10             	pushl  0x10(%ebx)
801014b6:	e8 65 0a 00 00       	call   80101f20 <stati>
801014bb:	59                   	pop    %ecx
801014bc:	ff 73 10             	pushl  0x10(%ebx)
801014bf:	e8 6c 08 00 00       	call   80101d30 <iunlock>
801014c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014c7:	83 c4 10             	add    $0x10,%esp
801014ca:	31 c0                	xor    %eax,%eax
801014cc:	c9                   	leave  
801014cd:	c3                   	ret    
801014ce:	66 90                	xchg   %ax,%ax
801014d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014d8:	c9                   	leave  
801014d9:	c3                   	ret    
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014e0 <fileread>:
801014e0:	f3 0f 1e fb          	endbr32 
801014e4:	55                   	push   %ebp
801014e5:	89 e5                	mov    %esp,%ebp
801014e7:	57                   	push   %edi
801014e8:	56                   	push   %esi
801014e9:	53                   	push   %ebx
801014ea:	83 ec 0c             	sub    $0xc,%esp
801014ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
801014f0:	8b 75 0c             	mov    0xc(%ebp),%esi
801014f3:	8b 7d 10             	mov    0x10(%ebp),%edi
801014f6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801014fa:	74 64                	je     80101560 <fileread+0x80>
801014fc:	8b 03                	mov    (%ebx),%eax
801014fe:	83 f8 01             	cmp    $0x1,%eax
80101501:	74 45                	je     80101548 <fileread+0x68>
80101503:	83 f8 02             	cmp    $0x2,%eax
80101506:	75 5f                	jne    80101567 <fileread+0x87>
80101508:	83 ec 0c             	sub    $0xc,%esp
8010150b:	ff 73 10             	pushl  0x10(%ebx)
8010150e:	e8 3d 07 00 00       	call   80101c50 <ilock>
80101513:	57                   	push   %edi
80101514:	ff 73 14             	pushl  0x14(%ebx)
80101517:	56                   	push   %esi
80101518:	ff 73 10             	pushl  0x10(%ebx)
8010151b:	e8 30 0a 00 00       	call   80101f50 <readi>
80101520:	83 c4 20             	add    $0x20,%esp
80101523:	89 c6                	mov    %eax,%esi
80101525:	85 c0                	test   %eax,%eax
80101527:	7e 03                	jle    8010152c <fileread+0x4c>
80101529:	01 43 14             	add    %eax,0x14(%ebx)
8010152c:	83 ec 0c             	sub    $0xc,%esp
8010152f:	ff 73 10             	pushl  0x10(%ebx)
80101532:	e8 f9 07 00 00       	call   80101d30 <iunlock>
80101537:	83 c4 10             	add    $0x10,%esp
8010153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010153d:	89 f0                	mov    %esi,%eax
8010153f:	5b                   	pop    %ebx
80101540:	5e                   	pop    %esi
80101541:	5f                   	pop    %edi
80101542:	5d                   	pop    %ebp
80101543:	c3                   	ret    
80101544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101548:	8b 43 0c             	mov    0xc(%ebx),%eax
8010154b:	89 45 08             	mov    %eax,0x8(%ebp)
8010154e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101551:	5b                   	pop    %ebx
80101552:	5e                   	pop    %esi
80101553:	5f                   	pop    %edi
80101554:	5d                   	pop    %ebp
80101555:	e9 36 26 00 00       	jmp    80103b90 <piperead>
8010155a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101560:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101565:	eb d3                	jmp    8010153a <fileread+0x5a>
80101567:	83 ec 0c             	sub    $0xc,%esp
8010156a:	68 de 76 10 80       	push   $0x801076de
8010156f:	e8 1c ee ff ff       	call   80100390 <panic>
80101574:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010157b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010157f:	90                   	nop

80101580 <filewrite>:
80101580:	f3 0f 1e fb          	endbr32 
80101584:	55                   	push   %ebp
80101585:	89 e5                	mov    %esp,%ebp
80101587:	57                   	push   %edi
80101588:	56                   	push   %esi
80101589:	53                   	push   %ebx
8010158a:	83 ec 1c             	sub    $0x1c,%esp
8010158d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101590:	8b 75 08             	mov    0x8(%ebp),%esi
80101593:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101596:	8b 45 10             	mov    0x10(%ebp),%eax
80101599:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
8010159d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015a0:	0f 84 c1 00 00 00    	je     80101667 <filewrite+0xe7>
801015a6:	8b 06                	mov    (%esi),%eax
801015a8:	83 f8 01             	cmp    $0x1,%eax
801015ab:	0f 84 c3 00 00 00    	je     80101674 <filewrite+0xf4>
801015b1:	83 f8 02             	cmp    $0x2,%eax
801015b4:	0f 85 cc 00 00 00    	jne    80101686 <filewrite+0x106>
801015ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015bd:	31 ff                	xor    %edi,%edi
801015bf:	85 c0                	test   %eax,%eax
801015c1:	7f 34                	jg     801015f7 <filewrite+0x77>
801015c3:	e9 98 00 00 00       	jmp    80101660 <filewrite+0xe0>
801015c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015cf:	90                   	nop
801015d0:	01 46 14             	add    %eax,0x14(%esi)
801015d3:	83 ec 0c             	sub    $0xc,%esp
801015d6:	ff 76 10             	pushl  0x10(%esi)
801015d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801015dc:	e8 4f 07 00 00       	call   80101d30 <iunlock>
801015e1:	e8 aa 1c 00 00       	call   80103290 <end_op>
801015e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015e9:	83 c4 10             	add    $0x10,%esp
801015ec:	39 c3                	cmp    %eax,%ebx
801015ee:	75 60                	jne    80101650 <filewrite+0xd0>
801015f0:	01 df                	add    %ebx,%edi
801015f2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801015f5:	7e 69                	jle    80101660 <filewrite+0xe0>
801015f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801015fa:	b8 00 06 00 00       	mov    $0x600,%eax
801015ff:	29 fb                	sub    %edi,%ebx
80101601:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101607:	0f 4f d8             	cmovg  %eax,%ebx
8010160a:	e8 11 1c 00 00       	call   80103220 <begin_op>
8010160f:	83 ec 0c             	sub    $0xc,%esp
80101612:	ff 76 10             	pushl  0x10(%esi)
80101615:	e8 36 06 00 00       	call   80101c50 <ilock>
8010161a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010161d:	53                   	push   %ebx
8010161e:	ff 76 14             	pushl  0x14(%esi)
80101621:	01 f8                	add    %edi,%eax
80101623:	50                   	push   %eax
80101624:	ff 76 10             	pushl  0x10(%esi)
80101627:	e8 24 0a 00 00       	call   80102050 <writei>
8010162c:	83 c4 20             	add    $0x20,%esp
8010162f:	85 c0                	test   %eax,%eax
80101631:	7f 9d                	jg     801015d0 <filewrite+0x50>
80101633:	83 ec 0c             	sub    $0xc,%esp
80101636:	ff 76 10             	pushl  0x10(%esi)
80101639:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010163c:	e8 ef 06 00 00       	call   80101d30 <iunlock>
80101641:	e8 4a 1c 00 00       	call   80103290 <end_op>
80101646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101649:	83 c4 10             	add    $0x10,%esp
8010164c:	85 c0                	test   %eax,%eax
8010164e:	75 17                	jne    80101667 <filewrite+0xe7>
80101650:	83 ec 0c             	sub    $0xc,%esp
80101653:	68 e7 76 10 80       	push   $0x801076e7
80101658:	e8 33 ed ff ff       	call   80100390 <panic>
8010165d:	8d 76 00             	lea    0x0(%esi),%esi
80101660:	89 f8                	mov    %edi,%eax
80101662:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101665:	74 05                	je     8010166c <filewrite+0xec>
80101667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010166c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5f                   	pop    %edi
80101672:	5d                   	pop    %ebp
80101673:	c3                   	ret    
80101674:	8b 46 0c             	mov    0xc(%esi),%eax
80101677:	89 45 08             	mov    %eax,0x8(%ebp)
8010167a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010167d:	5b                   	pop    %ebx
8010167e:	5e                   	pop    %esi
8010167f:	5f                   	pop    %edi
80101680:	5d                   	pop    %ebp
80101681:	e9 0a 24 00 00       	jmp    80103a90 <pipewrite>
80101686:	83 ec 0c             	sub    $0xc,%esp
80101689:	68 ed 76 10 80       	push   $0x801076ed
8010168e:	e8 fd ec ff ff       	call   80100390 <panic>
80101693:	66 90                	xchg   %ax,%ax
80101695:	66 90                	xchg   %ax,%ax
80101697:	66 90                	xchg   %ax,%ax
80101699:	66 90                	xchg   %ax,%ax
8010169b:	66 90                	xchg   %ax,%ax
8010169d:	66 90                	xchg   %ax,%ax
8010169f:	90                   	nop

801016a0 <bfree>:
801016a0:	55                   	push   %ebp
801016a1:	89 c1                	mov    %eax,%ecx
801016a3:	89 d0                	mov    %edx,%eax
801016a5:	c1 e8 0c             	shr    $0xc,%eax
801016a8:	03 05 78 1f 11 80    	add    0x80111f78,%eax
801016ae:	89 e5                	mov    %esp,%ebp
801016b0:	56                   	push   %esi
801016b1:	53                   	push   %ebx
801016b2:	89 d3                	mov    %edx,%ebx
801016b4:	83 ec 08             	sub    $0x8,%esp
801016b7:	50                   	push   %eax
801016b8:	51                   	push   %ecx
801016b9:	e8 12 ea ff ff       	call   801000d0 <bread>
801016be:	89 d9                	mov    %ebx,%ecx
801016c0:	c1 fb 03             	sar    $0x3,%ebx
801016c3:	ba 01 00 00 00       	mov    $0x1,%edx
801016c8:	83 e1 07             	and    $0x7,%ecx
801016cb:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801016d1:	83 c4 10             	add    $0x10,%esp
801016d4:	d3 e2                	shl    %cl,%edx
801016d6:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801016db:	85 d1                	test   %edx,%ecx
801016dd:	74 25                	je     80101704 <bfree+0x64>
801016df:	f7 d2                	not    %edx
801016e1:	83 ec 0c             	sub    $0xc,%esp
801016e4:	89 c6                	mov    %eax,%esi
801016e6:	21 ca                	and    %ecx,%edx
801016e8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
801016ec:	50                   	push   %eax
801016ed:	e8 0e 1d 00 00       	call   80103400 <log_write>
801016f2:	89 34 24             	mov    %esi,(%esp)
801016f5:	e8 f6 ea ff ff       	call   801001f0 <brelse>
801016fa:	83 c4 10             	add    $0x10,%esp
801016fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101700:	5b                   	pop    %ebx
80101701:	5e                   	pop    %esi
80101702:	5d                   	pop    %ebp
80101703:	c3                   	ret    
80101704:	83 ec 0c             	sub    $0xc,%esp
80101707:	68 f7 76 10 80       	push   $0x801076f7
8010170c:	e8 7f ec ff ff       	call   80100390 <panic>
80101711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop

80101720 <balloc>:
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	57                   	push   %edi
80101724:	56                   	push   %esi
80101725:	53                   	push   %ebx
80101726:	83 ec 1c             	sub    $0x1c,%esp
80101729:	8b 0d 60 1f 11 80    	mov    0x80111f60,%ecx
8010172f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101732:	85 c9                	test   %ecx,%ecx
80101734:	0f 84 87 00 00 00    	je     801017c1 <balloc+0xa1>
8010173a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80101741:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101744:	83 ec 08             	sub    $0x8,%esp
80101747:	89 f0                	mov    %esi,%eax
80101749:	c1 f8 0c             	sar    $0xc,%eax
8010174c:	03 05 78 1f 11 80    	add    0x80111f78,%eax
80101752:	50                   	push   %eax
80101753:	ff 75 d8             	pushl  -0x28(%ebp)
80101756:	e8 75 e9 ff ff       	call   801000d0 <bread>
8010175b:	83 c4 10             	add    $0x10,%esp
8010175e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101761:	a1 60 1f 11 80       	mov    0x80111f60,%eax
80101766:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101769:	31 c0                	xor    %eax,%eax
8010176b:	eb 2f                	jmp    8010179c <balloc+0x7c>
8010176d:	8d 76 00             	lea    0x0(%esi),%esi
80101770:	89 c1                	mov    %eax,%ecx
80101772:	bb 01 00 00 00       	mov    $0x1,%ebx
80101777:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010177a:	83 e1 07             	and    $0x7,%ecx
8010177d:	d3 e3                	shl    %cl,%ebx
8010177f:	89 c1                	mov    %eax,%ecx
80101781:	c1 f9 03             	sar    $0x3,%ecx
80101784:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101789:	89 fa                	mov    %edi,%edx
8010178b:	85 df                	test   %ebx,%edi
8010178d:	74 41                	je     801017d0 <balloc+0xb0>
8010178f:	83 c0 01             	add    $0x1,%eax
80101792:	83 c6 01             	add    $0x1,%esi
80101795:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010179a:	74 05                	je     801017a1 <balloc+0x81>
8010179c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010179f:	77 cf                	ja     80101770 <balloc+0x50>
801017a1:	83 ec 0c             	sub    $0xc,%esp
801017a4:	ff 75 e4             	pushl  -0x1c(%ebp)
801017a7:	e8 44 ea ff ff       	call   801001f0 <brelse>
801017ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801017b3:	83 c4 10             	add    $0x10,%esp
801017b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801017b9:	39 05 60 1f 11 80    	cmp    %eax,0x80111f60
801017bf:	77 80                	ja     80101741 <balloc+0x21>
801017c1:	83 ec 0c             	sub    $0xc,%esp
801017c4:	68 0a 77 10 80       	push   $0x8010770a
801017c9:	e8 c2 eb ff ff       	call   80100390 <panic>
801017ce:	66 90                	xchg   %ax,%ax
801017d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801017d3:	83 ec 0c             	sub    $0xc,%esp
801017d6:	09 da                	or     %ebx,%edx
801017d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801017dc:	57                   	push   %edi
801017dd:	e8 1e 1c 00 00       	call   80103400 <log_write>
801017e2:	89 3c 24             	mov    %edi,(%esp)
801017e5:	e8 06 ea ff ff       	call   801001f0 <brelse>
801017ea:	58                   	pop    %eax
801017eb:	5a                   	pop    %edx
801017ec:	56                   	push   %esi
801017ed:	ff 75 d8             	pushl  -0x28(%ebp)
801017f0:	e8 db e8 ff ff       	call   801000d0 <bread>
801017f5:	83 c4 0c             	add    $0xc,%esp
801017f8:	89 c3                	mov    %eax,%ebx
801017fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801017fd:	68 00 02 00 00       	push   $0x200
80101802:	6a 00                	push   $0x0
80101804:	50                   	push   %eax
80101805:	e8 56 33 00 00       	call   80104b60 <memset>
8010180a:	89 1c 24             	mov    %ebx,(%esp)
8010180d:	e8 ee 1b 00 00       	call   80103400 <log_write>
80101812:	89 1c 24             	mov    %ebx,(%esp)
80101815:	e8 d6 e9 ff ff       	call   801001f0 <brelse>
8010181a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010181d:	89 f0                	mov    %esi,%eax
8010181f:	5b                   	pop    %ebx
80101820:	5e                   	pop    %esi
80101821:	5f                   	pop    %edi
80101822:	5d                   	pop    %ebp
80101823:	c3                   	ret    
80101824:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010182b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010182f:	90                   	nop

80101830 <iget>:
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	57                   	push   %edi
80101834:	89 c7                	mov    %eax,%edi
80101836:	56                   	push   %esi
80101837:	31 f6                	xor    %esi,%esi
80101839:	53                   	push   %ebx
8010183a:	bb b4 1f 11 80       	mov    $0x80111fb4,%ebx
8010183f:	83 ec 28             	sub    $0x28,%esp
80101842:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101845:	68 80 1f 11 80       	push   $0x80111f80
8010184a:	e8 01 32 00 00       	call   80104a50 <acquire>
8010184f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101852:	83 c4 10             	add    $0x10,%esp
80101855:	eb 1b                	jmp    80101872 <iget+0x42>
80101857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185e:	66 90                	xchg   %ax,%ax
80101860:	39 3b                	cmp    %edi,(%ebx)
80101862:	74 6c                	je     801018d0 <iget+0xa0>
80101864:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010186a:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
80101870:	73 26                	jae    80101898 <iget+0x68>
80101872:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101875:	85 c9                	test   %ecx,%ecx
80101877:	7f e7                	jg     80101860 <iget+0x30>
80101879:	85 f6                	test   %esi,%esi
8010187b:	75 e7                	jne    80101864 <iget+0x34>
8010187d:	89 d8                	mov    %ebx,%eax
8010187f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101885:	85 c9                	test   %ecx,%ecx
80101887:	75 6e                	jne    801018f7 <iget+0xc7>
80101889:	89 c6                	mov    %eax,%esi
8010188b:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
80101891:	72 df                	jb     80101872 <iget+0x42>
80101893:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101897:	90                   	nop
80101898:	85 f6                	test   %esi,%esi
8010189a:	74 73                	je     8010190f <iget+0xdf>
8010189c:	83 ec 0c             	sub    $0xc,%esp
8010189f:	89 3e                	mov    %edi,(%esi)
801018a1:	89 56 04             	mov    %edx,0x4(%esi)
801018a4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
801018ab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018b2:	68 80 1f 11 80       	push   $0x80111f80
801018b7:	e8 54 32 00 00       	call   80104b10 <release>
801018bc:	83 c4 10             	add    $0x10,%esp
801018bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018c2:	89 f0                	mov    %esi,%eax
801018c4:	5b                   	pop    %ebx
801018c5:	5e                   	pop    %esi
801018c6:	5f                   	pop    %edi
801018c7:	5d                   	pop    %ebp
801018c8:	c3                   	ret    
801018c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801018d3:	75 8f                	jne    80101864 <iget+0x34>
801018d5:	83 ec 0c             	sub    $0xc,%esp
801018d8:	83 c1 01             	add    $0x1,%ecx
801018db:	89 de                	mov    %ebx,%esi
801018dd:	68 80 1f 11 80       	push   $0x80111f80
801018e2:	89 4b 08             	mov    %ecx,0x8(%ebx)
801018e5:	e8 26 32 00 00       	call   80104b10 <release>
801018ea:	83 c4 10             	add    $0x10,%esp
801018ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018f0:	89 f0                	mov    %esi,%eax
801018f2:	5b                   	pop    %ebx
801018f3:	5e                   	pop    %esi
801018f4:	5f                   	pop    %edi
801018f5:	5d                   	pop    %ebp
801018f6:	c3                   	ret    
801018f7:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
801018fd:	73 10                	jae    8010190f <iget+0xdf>
801018ff:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101902:	85 c9                	test   %ecx,%ecx
80101904:	0f 8f 56 ff ff ff    	jg     80101860 <iget+0x30>
8010190a:	e9 6e ff ff ff       	jmp    8010187d <iget+0x4d>
8010190f:	83 ec 0c             	sub    $0xc,%esp
80101912:	68 20 77 10 80       	push   $0x80107720
80101917:	e8 74 ea ff ff       	call   80100390 <panic>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <bmap>:
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	89 c6                	mov    %eax,%esi
80101927:	53                   	push   %ebx
80101928:	83 ec 1c             	sub    $0x1c,%esp
8010192b:	83 fa 0b             	cmp    $0xb,%edx
8010192e:	0f 86 84 00 00 00    	jbe    801019b8 <bmap+0x98>
80101934:	8d 5a f4             	lea    -0xc(%edx),%ebx
80101937:	83 fb 7f             	cmp    $0x7f,%ebx
8010193a:	0f 87 98 00 00 00    	ja     801019d8 <bmap+0xb8>
80101940:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101946:	8b 16                	mov    (%esi),%edx
80101948:	85 c0                	test   %eax,%eax
8010194a:	74 54                	je     801019a0 <bmap+0x80>
8010194c:	83 ec 08             	sub    $0x8,%esp
8010194f:	50                   	push   %eax
80101950:	52                   	push   %edx
80101951:	e8 7a e7 ff ff       	call   801000d0 <bread>
80101956:	83 c4 10             	add    $0x10,%esp
80101959:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010195d:	89 c7                	mov    %eax,%edi
8010195f:	8b 1a                	mov    (%edx),%ebx
80101961:	85 db                	test   %ebx,%ebx
80101963:	74 1b                	je     80101980 <bmap+0x60>
80101965:	83 ec 0c             	sub    $0xc,%esp
80101968:	57                   	push   %edi
80101969:	e8 82 e8 ff ff       	call   801001f0 <brelse>
8010196e:	83 c4 10             	add    $0x10,%esp
80101971:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101974:	89 d8                	mov    %ebx,%eax
80101976:	5b                   	pop    %ebx
80101977:	5e                   	pop    %esi
80101978:	5f                   	pop    %edi
80101979:	5d                   	pop    %ebp
8010197a:	c3                   	ret    
8010197b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010197f:	90                   	nop
80101980:	8b 06                	mov    (%esi),%eax
80101982:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101985:	e8 96 fd ff ff       	call   80101720 <balloc>
8010198a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010198d:	83 ec 0c             	sub    $0xc,%esp
80101990:	89 c3                	mov    %eax,%ebx
80101992:	89 02                	mov    %eax,(%edx)
80101994:	57                   	push   %edi
80101995:	e8 66 1a 00 00       	call   80103400 <log_write>
8010199a:	83 c4 10             	add    $0x10,%esp
8010199d:	eb c6                	jmp    80101965 <bmap+0x45>
8010199f:	90                   	nop
801019a0:	89 d0                	mov    %edx,%eax
801019a2:	e8 79 fd ff ff       	call   80101720 <balloc>
801019a7:	8b 16                	mov    (%esi),%edx
801019a9:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801019af:	eb 9b                	jmp    8010194c <bmap+0x2c>
801019b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019b8:	8d 3c 90             	lea    (%eax,%edx,4),%edi
801019bb:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801019be:	85 db                	test   %ebx,%ebx
801019c0:	75 af                	jne    80101971 <bmap+0x51>
801019c2:	8b 00                	mov    (%eax),%eax
801019c4:	e8 57 fd ff ff       	call   80101720 <balloc>
801019c9:	89 47 5c             	mov    %eax,0x5c(%edi)
801019cc:	89 c3                	mov    %eax,%ebx
801019ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019d1:	89 d8                	mov    %ebx,%eax
801019d3:	5b                   	pop    %ebx
801019d4:	5e                   	pop    %esi
801019d5:	5f                   	pop    %edi
801019d6:	5d                   	pop    %ebp
801019d7:	c3                   	ret    
801019d8:	83 ec 0c             	sub    $0xc,%esp
801019db:	68 30 77 10 80       	push   $0x80107730
801019e0:	e8 ab e9 ff ff       	call   80100390 <panic>
801019e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <readsb>:
801019f0:	f3 0f 1e fb          	endbr32 
801019f4:	55                   	push   %ebp
801019f5:	89 e5                	mov    %esp,%ebp
801019f7:	56                   	push   %esi
801019f8:	53                   	push   %ebx
801019f9:	8b 75 0c             	mov    0xc(%ebp),%esi
801019fc:	83 ec 08             	sub    $0x8,%esp
801019ff:	6a 01                	push   $0x1
80101a01:	ff 75 08             	pushl  0x8(%ebp)
80101a04:	e8 c7 e6 ff ff       	call   801000d0 <bread>
80101a09:	83 c4 0c             	add    $0xc,%esp
80101a0c:	89 c3                	mov    %eax,%ebx
80101a0e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101a11:	6a 1c                	push   $0x1c
80101a13:	50                   	push   %eax
80101a14:	56                   	push   %esi
80101a15:	e8 e6 31 00 00       	call   80104c00 <memmove>
80101a1a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a1d:	83 c4 10             	add    $0x10,%esp
80101a20:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a23:	5b                   	pop    %ebx
80101a24:	5e                   	pop    %esi
80101a25:	5d                   	pop    %ebp
80101a26:	e9 c5 e7 ff ff       	jmp    801001f0 <brelse>
80101a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a2f:	90                   	nop

80101a30 <iinit>:
80101a30:	f3 0f 1e fb          	endbr32 
80101a34:	55                   	push   %ebp
80101a35:	89 e5                	mov    %esp,%ebp
80101a37:	53                   	push   %ebx
80101a38:	bb c0 1f 11 80       	mov    $0x80111fc0,%ebx
80101a3d:	83 ec 0c             	sub    $0xc,%esp
80101a40:	68 43 77 10 80       	push   $0x80107743
80101a45:	68 80 1f 11 80       	push   $0x80111f80
80101a4a:	e8 81 2e 00 00       	call   801048d0 <initlock>
80101a4f:	83 c4 10             	add    $0x10,%esp
80101a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a58:	83 ec 08             	sub    $0x8,%esp
80101a5b:	68 4a 77 10 80       	push   $0x8010774a
80101a60:	53                   	push   %ebx
80101a61:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a67:	e8 24 2d 00 00       	call   80104790 <initsleeplock>
80101a6c:	83 c4 10             	add    $0x10,%esp
80101a6f:	81 fb e0 3b 11 80    	cmp    $0x80113be0,%ebx
80101a75:	75 e1                	jne    80101a58 <iinit+0x28>
80101a77:	83 ec 08             	sub    $0x8,%esp
80101a7a:	68 60 1f 11 80       	push   $0x80111f60
80101a7f:	ff 75 08             	pushl  0x8(%ebp)
80101a82:	e8 69 ff ff ff       	call   801019f0 <readsb>
80101a87:	ff 35 78 1f 11 80    	pushl  0x80111f78
80101a8d:	ff 35 74 1f 11 80    	pushl  0x80111f74
80101a93:	ff 35 70 1f 11 80    	pushl  0x80111f70
80101a99:	ff 35 6c 1f 11 80    	pushl  0x80111f6c
80101a9f:	ff 35 68 1f 11 80    	pushl  0x80111f68
80101aa5:	ff 35 64 1f 11 80    	pushl  0x80111f64
80101aab:	ff 35 60 1f 11 80    	pushl  0x80111f60
80101ab1:	68 b0 77 10 80       	push   $0x801077b0
80101ab6:	e8 05 ee ff ff       	call   801008c0 <cprintf>
80101abb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101abe:	83 c4 30             	add    $0x30,%esp
80101ac1:	c9                   	leave  
80101ac2:	c3                   	ret    
80101ac3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ad0 <ialloc>:
80101ad0:	f3 0f 1e fb          	endbr32 
80101ad4:	55                   	push   %ebp
80101ad5:	89 e5                	mov    %esp,%ebp
80101ad7:	57                   	push   %edi
80101ad8:	56                   	push   %esi
80101ad9:	53                   	push   %ebx
80101ada:	83 ec 1c             	sub    $0x1c,%esp
80101add:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ae0:	83 3d 68 1f 11 80 01 	cmpl   $0x1,0x80111f68
80101ae7:	8b 75 08             	mov    0x8(%ebp),%esi
80101aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101aed:	0f 86 8d 00 00 00    	jbe    80101b80 <ialloc+0xb0>
80101af3:	bf 01 00 00 00       	mov    $0x1,%edi
80101af8:	eb 1d                	jmp    80101b17 <ialloc+0x47>
80101afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b00:	83 ec 0c             	sub    $0xc,%esp
80101b03:	83 c7 01             	add    $0x1,%edi
80101b06:	53                   	push   %ebx
80101b07:	e8 e4 e6 ff ff       	call   801001f0 <brelse>
80101b0c:	83 c4 10             	add    $0x10,%esp
80101b0f:	3b 3d 68 1f 11 80    	cmp    0x80111f68,%edi
80101b15:	73 69                	jae    80101b80 <ialloc+0xb0>
80101b17:	89 f8                	mov    %edi,%eax
80101b19:	83 ec 08             	sub    $0x8,%esp
80101b1c:	c1 e8 03             	shr    $0x3,%eax
80101b1f:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101b25:	50                   	push   %eax
80101b26:	56                   	push   %esi
80101b27:	e8 a4 e5 ff ff       	call   801000d0 <bread>
80101b2c:	83 c4 10             	add    $0x10,%esp
80101b2f:	89 c3                	mov    %eax,%ebx
80101b31:	89 f8                	mov    %edi,%eax
80101b33:	83 e0 07             	and    $0x7,%eax
80101b36:	c1 e0 06             	shl    $0x6,%eax
80101b39:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
80101b3d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101b41:	75 bd                	jne    80101b00 <ialloc+0x30>
80101b43:	83 ec 04             	sub    $0x4,%esp
80101b46:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b49:	6a 40                	push   $0x40
80101b4b:	6a 00                	push   $0x0
80101b4d:	51                   	push   %ecx
80101b4e:	e8 0d 30 00 00       	call   80104b60 <memset>
80101b53:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b57:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b5a:	66 89 01             	mov    %ax,(%ecx)
80101b5d:	89 1c 24             	mov    %ebx,(%esp)
80101b60:	e8 9b 18 00 00       	call   80103400 <log_write>
80101b65:	89 1c 24             	mov    %ebx,(%esp)
80101b68:	e8 83 e6 ff ff       	call   801001f0 <brelse>
80101b6d:	83 c4 10             	add    $0x10,%esp
80101b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b73:	89 fa                	mov    %edi,%edx
80101b75:	5b                   	pop    %ebx
80101b76:	89 f0                	mov    %esi,%eax
80101b78:	5e                   	pop    %esi
80101b79:	5f                   	pop    %edi
80101b7a:	5d                   	pop    %ebp
80101b7b:	e9 b0 fc ff ff       	jmp    80101830 <iget>
80101b80:	83 ec 0c             	sub    $0xc,%esp
80101b83:	68 50 77 10 80       	push   $0x80107750
80101b88:	e8 03 e8 ff ff       	call   80100390 <panic>
80101b8d:	8d 76 00             	lea    0x0(%esi),%esi

80101b90 <iupdate>:
80101b90:	f3 0f 1e fb          	endbr32 
80101b94:	55                   	push   %ebp
80101b95:	89 e5                	mov    %esp,%ebp
80101b97:	56                   	push   %esi
80101b98:	53                   	push   %ebx
80101b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101b9c:	8b 43 04             	mov    0x4(%ebx),%eax
80101b9f:	83 c3 5c             	add    $0x5c,%ebx
80101ba2:	83 ec 08             	sub    $0x8,%esp
80101ba5:	c1 e8 03             	shr    $0x3,%eax
80101ba8:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101bae:	50                   	push   %eax
80101baf:	ff 73 a4             	pushl  -0x5c(%ebx)
80101bb2:	e8 19 e5 ff ff       	call   801000d0 <bread>
80101bb7:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80101bbb:	83 c4 0c             	add    $0xc,%esp
80101bbe:	89 c6                	mov    %eax,%esi
80101bc0:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101bc3:	83 e0 07             	and    $0x7,%eax
80101bc6:	c1 e0 06             	shl    $0x6,%eax
80101bc9:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101bcd:	66 89 10             	mov    %dx,(%eax)
80101bd0:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101bd4:	83 c0 0c             	add    $0xc,%eax
80101bd7:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101bdb:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101bdf:	66 89 50 f8          	mov    %dx,-0x8(%eax)
80101be3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101be7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101beb:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101bee:	89 50 fc             	mov    %edx,-0x4(%eax)
80101bf1:	6a 34                	push   $0x34
80101bf3:	53                   	push   %ebx
80101bf4:	50                   	push   %eax
80101bf5:	e8 06 30 00 00       	call   80104c00 <memmove>
80101bfa:	89 34 24             	mov    %esi,(%esp)
80101bfd:	e8 fe 17 00 00       	call   80103400 <log_write>
80101c02:	89 75 08             	mov    %esi,0x8(%ebp)
80101c05:	83 c4 10             	add    $0x10,%esp
80101c08:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c0b:	5b                   	pop    %ebx
80101c0c:	5e                   	pop    %esi
80101c0d:	5d                   	pop    %ebp
80101c0e:	e9 dd e5 ff ff       	jmp    801001f0 <brelse>
80101c13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c20 <idup>:
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	53                   	push   %ebx
80101c28:	83 ec 10             	sub    $0x10,%esp
80101c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c2e:	68 80 1f 11 80       	push   $0x80111f80
80101c33:	e8 18 2e 00 00       	call   80104a50 <acquire>
80101c38:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101c3c:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101c43:	e8 c8 2e 00 00       	call   80104b10 <release>
80101c48:	89 d8                	mov    %ebx,%eax
80101c4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c4d:	c9                   	leave  
80101c4e:	c3                   	ret    
80101c4f:	90                   	nop

80101c50 <ilock>:
80101c50:	f3 0f 1e fb          	endbr32 
80101c54:	55                   	push   %ebp
80101c55:	89 e5                	mov    %esp,%ebp
80101c57:	56                   	push   %esi
80101c58:	53                   	push   %ebx
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c5c:	85 db                	test   %ebx,%ebx
80101c5e:	0f 84 b3 00 00 00    	je     80101d17 <ilock+0xc7>
80101c64:	8b 53 08             	mov    0x8(%ebx),%edx
80101c67:	85 d2                	test   %edx,%edx
80101c69:	0f 8e a8 00 00 00    	jle    80101d17 <ilock+0xc7>
80101c6f:	83 ec 0c             	sub    $0xc,%esp
80101c72:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c75:	50                   	push   %eax
80101c76:	e8 55 2b 00 00       	call   801047d0 <acquiresleep>
80101c7b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101c7e:	83 c4 10             	add    $0x10,%esp
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 0b                	je     80101c90 <ilock+0x40>
80101c85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c88:	5b                   	pop    %ebx
80101c89:	5e                   	pop    %esi
80101c8a:	5d                   	pop    %ebp
80101c8b:	c3                   	ret    
80101c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c90:	8b 43 04             	mov    0x4(%ebx),%eax
80101c93:	83 ec 08             	sub    $0x8,%esp
80101c96:	c1 e8 03             	shr    $0x3,%eax
80101c99:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101c9f:	50                   	push   %eax
80101ca0:	ff 33                	pushl  (%ebx)
80101ca2:	e8 29 e4 ff ff       	call   801000d0 <bread>
80101ca7:	83 c4 0c             	add    $0xc,%esp
80101caa:	89 c6                	mov    %eax,%esi
80101cac:	8b 43 04             	mov    0x4(%ebx),%eax
80101caf:	83 e0 07             	and    $0x7,%eax
80101cb2:	c1 e0 06             	shl    $0x6,%eax
80101cb5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101cb9:	0f b7 10             	movzwl (%eax),%edx
80101cbc:	83 c0 0c             	add    $0xc,%eax
80101cbf:	66 89 53 50          	mov    %dx,0x50(%ebx)
80101cc3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101cc7:	66 89 53 52          	mov    %dx,0x52(%ebx)
80101ccb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101ccf:	66 89 53 54          	mov    %dx,0x54(%ebx)
80101cd3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101cd7:	66 89 53 56          	mov    %dx,0x56(%ebx)
80101cdb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101cde:	89 53 58             	mov    %edx,0x58(%ebx)
80101ce1:	6a 34                	push   $0x34
80101ce3:	50                   	push   %eax
80101ce4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101ce7:	50                   	push   %eax
80101ce8:	e8 13 2f 00 00       	call   80104c00 <memmove>
80101ced:	89 34 24             	mov    %esi,(%esp)
80101cf0:	e8 fb e4 ff ff       	call   801001f0 <brelse>
80101cf5:	83 c4 10             	add    $0x10,%esp
80101cf8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101cfd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101d04:	0f 85 7b ff ff ff    	jne    80101c85 <ilock+0x35>
80101d0a:	83 ec 0c             	sub    $0xc,%esp
80101d0d:	68 68 77 10 80       	push   $0x80107768
80101d12:	e8 79 e6 ff ff       	call   80100390 <panic>
80101d17:	83 ec 0c             	sub    $0xc,%esp
80101d1a:	68 62 77 10 80       	push   $0x80107762
80101d1f:	e8 6c e6 ff ff       	call   80100390 <panic>
80101d24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d2f:	90                   	nop

80101d30 <iunlock>:
80101d30:	f3 0f 1e fb          	endbr32 
80101d34:	55                   	push   %ebp
80101d35:	89 e5                	mov    %esp,%ebp
80101d37:	56                   	push   %esi
80101d38:	53                   	push   %ebx
80101d39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d3c:	85 db                	test   %ebx,%ebx
80101d3e:	74 28                	je     80101d68 <iunlock+0x38>
80101d40:	83 ec 0c             	sub    $0xc,%esp
80101d43:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d46:	56                   	push   %esi
80101d47:	e8 24 2b 00 00       	call   80104870 <holdingsleep>
80101d4c:	83 c4 10             	add    $0x10,%esp
80101d4f:	85 c0                	test   %eax,%eax
80101d51:	74 15                	je     80101d68 <iunlock+0x38>
80101d53:	8b 43 08             	mov    0x8(%ebx),%eax
80101d56:	85 c0                	test   %eax,%eax
80101d58:	7e 0e                	jle    80101d68 <iunlock+0x38>
80101d5a:	89 75 08             	mov    %esi,0x8(%ebp)
80101d5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d60:	5b                   	pop    %ebx
80101d61:	5e                   	pop    %esi
80101d62:	5d                   	pop    %ebp
80101d63:	e9 c8 2a 00 00       	jmp    80104830 <releasesleep>
80101d68:	83 ec 0c             	sub    $0xc,%esp
80101d6b:	68 77 77 10 80       	push   $0x80107777
80101d70:	e8 1b e6 ff ff       	call   80100390 <panic>
80101d75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d80 <iput>:
80101d80:	f3 0f 1e fb          	endbr32 
80101d84:	55                   	push   %ebp
80101d85:	89 e5                	mov    %esp,%ebp
80101d87:	57                   	push   %edi
80101d88:	56                   	push   %esi
80101d89:	53                   	push   %ebx
80101d8a:	83 ec 28             	sub    $0x28,%esp
80101d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d90:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101d93:	57                   	push   %edi
80101d94:	e8 37 2a 00 00       	call   801047d0 <acquiresleep>
80101d99:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101d9c:	83 c4 10             	add    $0x10,%esp
80101d9f:	85 d2                	test   %edx,%edx
80101da1:	74 07                	je     80101daa <iput+0x2a>
80101da3:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101da8:	74 36                	je     80101de0 <iput+0x60>
80101daa:	83 ec 0c             	sub    $0xc,%esp
80101dad:	57                   	push   %edi
80101dae:	e8 7d 2a 00 00       	call   80104830 <releasesleep>
80101db3:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101dba:	e8 91 2c 00 00       	call   80104a50 <acquire>
80101dbf:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
80101dc3:	83 c4 10             	add    $0x10,%esp
80101dc6:	c7 45 08 80 1f 11 80 	movl   $0x80111f80,0x8(%ebp)
80101dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd0:	5b                   	pop    %ebx
80101dd1:	5e                   	pop    %esi
80101dd2:	5f                   	pop    %edi
80101dd3:	5d                   	pop    %ebp
80101dd4:	e9 37 2d 00 00       	jmp    80104b10 <release>
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	68 80 1f 11 80       	push   $0x80111f80
80101de8:	e8 63 2c 00 00       	call   80104a50 <acquire>
80101ded:	8b 73 08             	mov    0x8(%ebx),%esi
80101df0:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101df7:	e8 14 2d 00 00       	call   80104b10 <release>
80101dfc:	83 c4 10             	add    $0x10,%esp
80101dff:	83 fe 01             	cmp    $0x1,%esi
80101e02:	75 a6                	jne    80101daa <iput+0x2a>
80101e04:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101e0a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101e0d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101e10:	89 cf                	mov    %ecx,%edi
80101e12:	eb 0b                	jmp    80101e1f <iput+0x9f>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e18:	83 c6 04             	add    $0x4,%esi
80101e1b:	39 fe                	cmp    %edi,%esi
80101e1d:	74 19                	je     80101e38 <iput+0xb8>
80101e1f:	8b 16                	mov    (%esi),%edx
80101e21:	85 d2                	test   %edx,%edx
80101e23:	74 f3                	je     80101e18 <iput+0x98>
80101e25:	8b 03                	mov    (%ebx),%eax
80101e27:	e8 74 f8 ff ff       	call   801016a0 <bfree>
80101e2c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101e32:	eb e4                	jmp    80101e18 <iput+0x98>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e38:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101e3e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e41:	85 c0                	test   %eax,%eax
80101e43:	75 33                	jne    80101e78 <iput+0xf8>
80101e45:	83 ec 0c             	sub    $0xc,%esp
80101e48:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80101e4f:	53                   	push   %ebx
80101e50:	e8 3b fd ff ff       	call   80101b90 <iupdate>
80101e55:	31 c0                	xor    %eax,%eax
80101e57:	66 89 43 50          	mov    %ax,0x50(%ebx)
80101e5b:	89 1c 24             	mov    %ebx,(%esp)
80101e5e:	e8 2d fd ff ff       	call   80101b90 <iupdate>
80101e63:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101e6a:	83 c4 10             	add    $0x10,%esp
80101e6d:	e9 38 ff ff ff       	jmp    80101daa <iput+0x2a>
80101e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e78:	83 ec 08             	sub    $0x8,%esp
80101e7b:	50                   	push   %eax
80101e7c:	ff 33                	pushl  (%ebx)
80101e7e:	e8 4d e2 ff ff       	call   801000d0 <bread>
80101e83:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e86:	83 c4 10             	add    $0x10,%esp
80101e89:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e92:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e95:	89 cf                	mov    %ecx,%edi
80101e97:	eb 0e                	jmp    80101ea7 <iput+0x127>
80101e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea0:	83 c6 04             	add    $0x4,%esi
80101ea3:	39 f7                	cmp    %esi,%edi
80101ea5:	74 19                	je     80101ec0 <iput+0x140>
80101ea7:	8b 16                	mov    (%esi),%edx
80101ea9:	85 d2                	test   %edx,%edx
80101eab:	74 f3                	je     80101ea0 <iput+0x120>
80101ead:	8b 03                	mov    (%ebx),%eax
80101eaf:	e8 ec f7 ff ff       	call   801016a0 <bfree>
80101eb4:	eb ea                	jmp    80101ea0 <iput+0x120>
80101eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ebd:	8d 76 00             	lea    0x0(%esi),%esi
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ec6:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ec9:	e8 22 e3 ff ff       	call   801001f0 <brelse>
80101ece:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101ed4:	8b 03                	mov    (%ebx),%eax
80101ed6:	e8 c5 f7 ff ff       	call   801016a0 <bfree>
80101edb:	83 c4 10             	add    $0x10,%esp
80101ede:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101ee5:	00 00 00 
80101ee8:	e9 58 ff ff ff       	jmp    80101e45 <iput+0xc5>
80101eed:	8d 76 00             	lea    0x0(%esi),%esi

80101ef0 <iunlockput>:
80101ef0:	f3 0f 1e fb          	endbr32 
80101ef4:	55                   	push   %ebp
80101ef5:	89 e5                	mov    %esp,%ebp
80101ef7:	53                   	push   %ebx
80101ef8:	83 ec 10             	sub    $0x10,%esp
80101efb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101efe:	53                   	push   %ebx
80101eff:	e8 2c fe ff ff       	call   80101d30 <iunlock>
80101f04:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101f07:	83 c4 10             	add    $0x10,%esp
80101f0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f0d:	c9                   	leave  
80101f0e:	e9 6d fe ff ff       	jmp    80101d80 <iput>
80101f13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f20 <stati>:
80101f20:	f3 0f 1e fb          	endbr32 
80101f24:	55                   	push   %ebp
80101f25:	89 e5                	mov    %esp,%ebp
80101f27:	8b 55 08             	mov    0x8(%ebp),%edx
80101f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f2d:	8b 0a                	mov    (%edx),%ecx
80101f2f:	89 48 04             	mov    %ecx,0x4(%eax)
80101f32:	8b 4a 04             	mov    0x4(%edx),%ecx
80101f35:	89 48 08             	mov    %ecx,0x8(%eax)
80101f38:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101f3c:	66 89 08             	mov    %cx,(%eax)
80101f3f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101f43:	66 89 48 0c          	mov    %cx,0xc(%eax)
80101f47:	8b 52 58             	mov    0x58(%edx),%edx
80101f4a:	89 50 10             	mov    %edx,0x10(%eax)
80101f4d:	5d                   	pop    %ebp
80101f4e:	c3                   	ret    
80101f4f:	90                   	nop

80101f50 <readi>:
80101f50:	f3 0f 1e fb          	endbr32 
80101f54:	55                   	push   %ebp
80101f55:	89 e5                	mov    %esp,%ebp
80101f57:	57                   	push   %edi
80101f58:	56                   	push   %esi
80101f59:	53                   	push   %ebx
80101f5a:	83 ec 1c             	sub    $0x1c,%esp
80101f5d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101f60:	8b 45 08             	mov    0x8(%ebp),%eax
80101f63:	8b 75 10             	mov    0x10(%ebp),%esi
80101f66:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101f69:	8b 7d 14             	mov    0x14(%ebp),%edi
80101f6c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101f71:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f74:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101f77:	0f 84 a3 00 00 00    	je     80102020 <readi+0xd0>
80101f7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f80:	8b 40 58             	mov    0x58(%eax),%eax
80101f83:	39 c6                	cmp    %eax,%esi
80101f85:	0f 87 b6 00 00 00    	ja     80102041 <readi+0xf1>
80101f8b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f8e:	31 c9                	xor    %ecx,%ecx
80101f90:	89 da                	mov    %ebx,%edx
80101f92:	01 f2                	add    %esi,%edx
80101f94:	0f 92 c1             	setb   %cl
80101f97:	89 cf                	mov    %ecx,%edi
80101f99:	0f 82 a2 00 00 00    	jb     80102041 <readi+0xf1>
80101f9f:	89 c1                	mov    %eax,%ecx
80101fa1:	29 f1                	sub    %esi,%ecx
80101fa3:	39 d0                	cmp    %edx,%eax
80101fa5:	0f 43 cb             	cmovae %ebx,%ecx
80101fa8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101fab:	85 c9                	test   %ecx,%ecx
80101fad:	74 63                	je     80102012 <readi+0xc2>
80101faf:	90                   	nop
80101fb0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101fb3:	89 f2                	mov    %esi,%edx
80101fb5:	c1 ea 09             	shr    $0x9,%edx
80101fb8:	89 d8                	mov    %ebx,%eax
80101fba:	e8 61 f9 ff ff       	call   80101920 <bmap>
80101fbf:	83 ec 08             	sub    $0x8,%esp
80101fc2:	50                   	push   %eax
80101fc3:	ff 33                	pushl  (%ebx)
80101fc5:	e8 06 e1 ff ff       	call   801000d0 <bread>
80101fca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101fcd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101fd2:	83 c4 0c             	add    $0xc,%esp
80101fd5:	89 c2                	mov    %eax,%edx
80101fd7:	89 f0                	mov    %esi,%eax
80101fd9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fde:	29 fb                	sub    %edi,%ebx
80101fe0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101fe3:	29 c1                	sub    %eax,%ecx
80101fe5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101fe9:	39 d9                	cmp    %ebx,%ecx
80101feb:	0f 46 d9             	cmovbe %ecx,%ebx
80101fee:	53                   	push   %ebx
80101fef:	01 df                	add    %ebx,%edi
80101ff1:	01 de                	add    %ebx,%esi
80101ff3:	50                   	push   %eax
80101ff4:	ff 75 e0             	pushl  -0x20(%ebp)
80101ff7:	e8 04 2c 00 00       	call   80104c00 <memmove>
80101ffc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fff:	89 14 24             	mov    %edx,(%esp)
80102002:	e8 e9 e1 ff ff       	call   801001f0 <brelse>
80102007:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010200a:	83 c4 10             	add    $0x10,%esp
8010200d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102010:	77 9e                	ja     80101fb0 <readi+0x60>
80102012:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102018:	5b                   	pop    %ebx
80102019:	5e                   	pop    %esi
8010201a:	5f                   	pop    %edi
8010201b:	5d                   	pop    %ebp
8010201c:	c3                   	ret    
8010201d:	8d 76 00             	lea    0x0(%esi),%esi
80102020:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102024:	66 83 f8 09          	cmp    $0x9,%ax
80102028:	77 17                	ja     80102041 <readi+0xf1>
8010202a:	8b 04 c5 00 1f 11 80 	mov    -0x7feee100(,%eax,8),%eax
80102031:	85 c0                	test   %eax,%eax
80102033:	74 0c                	je     80102041 <readi+0xf1>
80102035:	89 7d 10             	mov    %edi,0x10(%ebp)
80102038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010203b:	5b                   	pop    %ebx
8010203c:	5e                   	pop    %esi
8010203d:	5f                   	pop    %edi
8010203e:	5d                   	pop    %ebp
8010203f:	ff e0                	jmp    *%eax
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	eb cd                	jmp    80102015 <readi+0xc5>
80102048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010204f:	90                   	nop

80102050 <writei>:
80102050:	f3 0f 1e fb          	endbr32 
80102054:	55                   	push   %ebp
80102055:	89 e5                	mov    %esp,%ebp
80102057:	57                   	push   %edi
80102058:	56                   	push   %esi
80102059:	53                   	push   %ebx
8010205a:	83 ec 1c             	sub    $0x1c,%esp
8010205d:	8b 45 08             	mov    0x8(%ebp),%eax
80102060:	8b 75 0c             	mov    0xc(%ebp),%esi
80102063:	8b 7d 14             	mov    0x14(%ebp),%edi
80102066:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
8010206b:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010206e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102071:	8b 75 10             	mov    0x10(%ebp),%esi
80102074:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102077:	0f 84 b3 00 00 00    	je     80102130 <writei+0xe0>
8010207d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102080:	39 70 58             	cmp    %esi,0x58(%eax)
80102083:	0f 82 e3 00 00 00    	jb     8010216c <writei+0x11c>
80102089:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010208c:	89 f8                	mov    %edi,%eax
8010208e:	01 f0                	add    %esi,%eax
80102090:	0f 82 d6 00 00 00    	jb     8010216c <writei+0x11c>
80102096:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010209b:	0f 87 cb 00 00 00    	ja     8010216c <writei+0x11c>
801020a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801020a8:	85 ff                	test   %edi,%edi
801020aa:	74 75                	je     80102121 <writei+0xd1>
801020ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020b0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801020b3:	89 f2                	mov    %esi,%edx
801020b5:	c1 ea 09             	shr    $0x9,%edx
801020b8:	89 f8                	mov    %edi,%eax
801020ba:	e8 61 f8 ff ff       	call   80101920 <bmap>
801020bf:	83 ec 08             	sub    $0x8,%esp
801020c2:	50                   	push   %eax
801020c3:	ff 37                	pushl  (%edi)
801020c5:	e8 06 e0 ff ff       	call   801000d0 <bread>
801020ca:	b9 00 02 00 00       	mov    $0x200,%ecx
801020cf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020d2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
801020d5:	89 c7                	mov    %eax,%edi
801020d7:	89 f0                	mov    %esi,%eax
801020d9:	83 c4 0c             	add    $0xc,%esp
801020dc:	25 ff 01 00 00       	and    $0x1ff,%eax
801020e1:	29 c1                	sub    %eax,%ecx
801020e3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
801020e7:	39 d9                	cmp    %ebx,%ecx
801020e9:	0f 46 d9             	cmovbe %ecx,%ebx
801020ec:	53                   	push   %ebx
801020ed:	01 de                	add    %ebx,%esi
801020ef:	ff 75 dc             	pushl  -0x24(%ebp)
801020f2:	50                   	push   %eax
801020f3:	e8 08 2b 00 00       	call   80104c00 <memmove>
801020f8:	89 3c 24             	mov    %edi,(%esp)
801020fb:	e8 00 13 00 00       	call   80103400 <log_write>
80102100:	89 3c 24             	mov    %edi,(%esp)
80102103:	e8 e8 e0 ff ff       	call   801001f0 <brelse>
80102108:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102111:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102114:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102117:	77 97                	ja     801020b0 <writei+0x60>
80102119:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010211c:	3b 70 58             	cmp    0x58(%eax),%esi
8010211f:	77 37                	ja     80102158 <writei+0x108>
80102121:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102130:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102134:	66 83 f8 09          	cmp    $0x9,%ax
80102138:	77 32                	ja     8010216c <writei+0x11c>
8010213a:	8b 04 c5 04 1f 11 80 	mov    -0x7feee0fc(,%eax,8),%eax
80102141:	85 c0                	test   %eax,%eax
80102143:	74 27                	je     8010216c <writei+0x11c>
80102145:	89 7d 10             	mov    %edi,0x10(%ebp)
80102148:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214b:	5b                   	pop    %ebx
8010214c:	5e                   	pop    %esi
8010214d:	5f                   	pop    %edi
8010214e:	5d                   	pop    %ebp
8010214f:	ff e0                	jmp    *%eax
80102151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102158:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010215b:	83 ec 0c             	sub    $0xc,%esp
8010215e:	89 70 58             	mov    %esi,0x58(%eax)
80102161:	50                   	push   %eax
80102162:	e8 29 fa ff ff       	call   80101b90 <iupdate>
80102167:	83 c4 10             	add    $0x10,%esp
8010216a:	eb b5                	jmp    80102121 <writei+0xd1>
8010216c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102171:	eb b1                	jmp    80102124 <writei+0xd4>
80102173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102180 <namecmp>:
80102180:	f3 0f 1e fb          	endbr32 
80102184:	55                   	push   %ebp
80102185:	89 e5                	mov    %esp,%ebp
80102187:	83 ec 0c             	sub    $0xc,%esp
8010218a:	6a 0e                	push   $0xe
8010218c:	ff 75 0c             	pushl  0xc(%ebp)
8010218f:	ff 75 08             	pushl  0x8(%ebp)
80102192:	e8 d9 2a 00 00       	call   80104c70 <strncmp>
80102197:	c9                   	leave  
80102198:	c3                   	ret    
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021a0 <dirlookup>:
801021a0:	f3 0f 1e fb          	endbr32 
801021a4:	55                   	push   %ebp
801021a5:	89 e5                	mov    %esp,%ebp
801021a7:	57                   	push   %edi
801021a8:	56                   	push   %esi
801021a9:	53                   	push   %ebx
801021aa:	83 ec 1c             	sub    $0x1c,%esp
801021ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
801021b0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021b5:	0f 85 89 00 00 00    	jne    80102244 <dirlookup+0xa4>
801021bb:	8b 53 58             	mov    0x58(%ebx),%edx
801021be:	31 ff                	xor    %edi,%edi
801021c0:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021c3:	85 d2                	test   %edx,%edx
801021c5:	74 42                	je     80102209 <dirlookup+0x69>
801021c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ce:	66 90                	xchg   %ax,%ax
801021d0:	6a 10                	push   $0x10
801021d2:	57                   	push   %edi
801021d3:	56                   	push   %esi
801021d4:	53                   	push   %ebx
801021d5:	e8 76 fd ff ff       	call   80101f50 <readi>
801021da:	83 c4 10             	add    $0x10,%esp
801021dd:	83 f8 10             	cmp    $0x10,%eax
801021e0:	75 55                	jne    80102237 <dirlookup+0x97>
801021e2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021e7:	74 18                	je     80102201 <dirlookup+0x61>
801021e9:	83 ec 04             	sub    $0x4,%esp
801021ec:	8d 45 da             	lea    -0x26(%ebp),%eax
801021ef:	6a 0e                	push   $0xe
801021f1:	50                   	push   %eax
801021f2:	ff 75 0c             	pushl  0xc(%ebp)
801021f5:	e8 76 2a 00 00       	call   80104c70 <strncmp>
801021fa:	83 c4 10             	add    $0x10,%esp
801021fd:	85 c0                	test   %eax,%eax
801021ff:	74 17                	je     80102218 <dirlookup+0x78>
80102201:	83 c7 10             	add    $0x10,%edi
80102204:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102207:	72 c7                	jb     801021d0 <dirlookup+0x30>
80102209:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010220c:	31 c0                	xor    %eax,%eax
8010220e:	5b                   	pop    %ebx
8010220f:	5e                   	pop    %esi
80102210:	5f                   	pop    %edi
80102211:	5d                   	pop    %ebp
80102212:	c3                   	ret    
80102213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102217:	90                   	nop
80102218:	8b 45 10             	mov    0x10(%ebp),%eax
8010221b:	85 c0                	test   %eax,%eax
8010221d:	74 05                	je     80102224 <dirlookup+0x84>
8010221f:	8b 45 10             	mov    0x10(%ebp),%eax
80102222:	89 38                	mov    %edi,(%eax)
80102224:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80102228:	8b 03                	mov    (%ebx),%eax
8010222a:	e8 01 f6 ff ff       	call   80101830 <iget>
8010222f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102232:	5b                   	pop    %ebx
80102233:	5e                   	pop    %esi
80102234:	5f                   	pop    %edi
80102235:	5d                   	pop    %ebp
80102236:	c3                   	ret    
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 91 77 10 80       	push   $0x80107791
8010223f:	e8 4c e1 ff ff       	call   80100390 <panic>
80102244:	83 ec 0c             	sub    $0xc,%esp
80102247:	68 7f 77 10 80       	push   $0x8010777f
8010224c:	e8 3f e1 ff ff       	call   80100390 <panic>
80102251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102258:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010225f:	90                   	nop

80102260 <namex>:
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	57                   	push   %edi
80102264:	56                   	push   %esi
80102265:	53                   	push   %ebx
80102266:	89 c3                	mov    %eax,%ebx
80102268:	83 ec 1c             	sub    $0x1c,%esp
8010226b:	80 38 2f             	cmpb   $0x2f,(%eax)
8010226e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102271:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102274:	0f 84 86 01 00 00    	je     80102400 <namex+0x1a0>
8010227a:	e8 d1 1b 00 00       	call   80103e50 <myproc>
8010227f:	83 ec 0c             	sub    $0xc,%esp
80102282:	89 df                	mov    %ebx,%edi
80102284:	8b 70 68             	mov    0x68(%eax),%esi
80102287:	68 80 1f 11 80       	push   $0x80111f80
8010228c:	e8 bf 27 00 00       	call   80104a50 <acquire>
80102291:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102295:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
8010229c:	e8 6f 28 00 00       	call   80104b10 <release>
801022a1:	83 c4 10             	add    $0x10,%esp
801022a4:	eb 0d                	jmp    801022b3 <namex+0x53>
801022a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ad:	8d 76 00             	lea    0x0(%esi),%esi
801022b0:	83 c7 01             	add    $0x1,%edi
801022b3:	0f b6 07             	movzbl (%edi),%eax
801022b6:	3c 2f                	cmp    $0x2f,%al
801022b8:	74 f6                	je     801022b0 <namex+0x50>
801022ba:	84 c0                	test   %al,%al
801022bc:	0f 84 ee 00 00 00    	je     801023b0 <namex+0x150>
801022c2:	0f b6 07             	movzbl (%edi),%eax
801022c5:	84 c0                	test   %al,%al
801022c7:	0f 84 fb 00 00 00    	je     801023c8 <namex+0x168>
801022cd:	89 fb                	mov    %edi,%ebx
801022cf:	3c 2f                	cmp    $0x2f,%al
801022d1:	0f 84 f1 00 00 00    	je     801023c8 <namex+0x168>
801022d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022de:	66 90                	xchg   %ax,%ax
801022e0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
801022e4:	83 c3 01             	add    $0x1,%ebx
801022e7:	3c 2f                	cmp    $0x2f,%al
801022e9:	74 04                	je     801022ef <namex+0x8f>
801022eb:	84 c0                	test   %al,%al
801022ed:	75 f1                	jne    801022e0 <namex+0x80>
801022ef:	89 d8                	mov    %ebx,%eax
801022f1:	29 f8                	sub    %edi,%eax
801022f3:	83 f8 0d             	cmp    $0xd,%eax
801022f6:	0f 8e 84 00 00 00    	jle    80102380 <namex+0x120>
801022fc:	83 ec 04             	sub    $0x4,%esp
801022ff:	6a 0e                	push   $0xe
80102301:	57                   	push   %edi
80102302:	89 df                	mov    %ebx,%edi
80102304:	ff 75 e4             	pushl  -0x1c(%ebp)
80102307:	e8 f4 28 00 00       	call   80104c00 <memmove>
8010230c:	83 c4 10             	add    $0x10,%esp
8010230f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102312:	75 0c                	jne    80102320 <namex+0xc0>
80102314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102318:	83 c7 01             	add    $0x1,%edi
8010231b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010231e:	74 f8                	je     80102318 <namex+0xb8>
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	56                   	push   %esi
80102324:	e8 27 f9 ff ff       	call   80101c50 <ilock>
80102329:	83 c4 10             	add    $0x10,%esp
8010232c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102331:	0f 85 a1 00 00 00    	jne    801023d8 <namex+0x178>
80102337:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010233a:	85 d2                	test   %edx,%edx
8010233c:	74 09                	je     80102347 <namex+0xe7>
8010233e:	80 3f 00             	cmpb   $0x0,(%edi)
80102341:	0f 84 d9 00 00 00    	je     80102420 <namex+0x1c0>
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	6a 00                	push   $0x0
8010234c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010234f:	56                   	push   %esi
80102350:	e8 4b fe ff ff       	call   801021a0 <dirlookup>
80102355:	83 c4 10             	add    $0x10,%esp
80102358:	89 c3                	mov    %eax,%ebx
8010235a:	85 c0                	test   %eax,%eax
8010235c:	74 7a                	je     801023d8 <namex+0x178>
8010235e:	83 ec 0c             	sub    $0xc,%esp
80102361:	56                   	push   %esi
80102362:	e8 c9 f9 ff ff       	call   80101d30 <iunlock>
80102367:	89 34 24             	mov    %esi,(%esp)
8010236a:	89 de                	mov    %ebx,%esi
8010236c:	e8 0f fa ff ff       	call   80101d80 <iput>
80102371:	83 c4 10             	add    $0x10,%esp
80102374:	e9 3a ff ff ff       	jmp    801022b3 <namex+0x53>
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102380:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102383:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102386:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80102389:	83 ec 04             	sub    $0x4,%esp
8010238c:	50                   	push   %eax
8010238d:	57                   	push   %edi
8010238e:	89 df                	mov    %ebx,%edi
80102390:	ff 75 e4             	pushl  -0x1c(%ebp)
80102393:	e8 68 28 00 00       	call   80104c00 <memmove>
80102398:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010239b:	83 c4 10             	add    $0x10,%esp
8010239e:	c6 00 00             	movb   $0x0,(%eax)
801023a1:	e9 69 ff ff ff       	jmp    8010230f <namex+0xaf>
801023a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ad:	8d 76 00             	lea    0x0(%esi),%esi
801023b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801023b3:	85 c0                	test   %eax,%eax
801023b5:	0f 85 85 00 00 00    	jne    80102440 <namex+0x1e0>
801023bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023be:	89 f0                	mov    %esi,%eax
801023c0:	5b                   	pop    %ebx
801023c1:	5e                   	pop    %esi
801023c2:	5f                   	pop    %edi
801023c3:	5d                   	pop    %ebp
801023c4:	c3                   	ret    
801023c5:	8d 76 00             	lea    0x0(%esi),%esi
801023c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801023cb:	89 fb                	mov    %edi,%ebx
801023cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801023d0:	31 c0                	xor    %eax,%eax
801023d2:	eb b5                	jmp    80102389 <namex+0x129>
801023d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023d8:	83 ec 0c             	sub    $0xc,%esp
801023db:	56                   	push   %esi
801023dc:	e8 4f f9 ff ff       	call   80101d30 <iunlock>
801023e1:	89 34 24             	mov    %esi,(%esp)
801023e4:	31 f6                	xor    %esi,%esi
801023e6:	e8 95 f9 ff ff       	call   80101d80 <iput>
801023eb:	83 c4 10             	add    $0x10,%esp
801023ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f1:	89 f0                	mov    %esi,%eax
801023f3:	5b                   	pop    %ebx
801023f4:	5e                   	pop    %esi
801023f5:	5f                   	pop    %edi
801023f6:	5d                   	pop    %ebp
801023f7:	c3                   	ret    
801023f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ff:	90                   	nop
80102400:	ba 01 00 00 00       	mov    $0x1,%edx
80102405:	b8 01 00 00 00       	mov    $0x1,%eax
8010240a:	89 df                	mov    %ebx,%edi
8010240c:	e8 1f f4 ff ff       	call   80101830 <iget>
80102411:	89 c6                	mov    %eax,%esi
80102413:	e9 9b fe ff ff       	jmp    801022b3 <namex+0x53>
80102418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
80102420:	83 ec 0c             	sub    $0xc,%esp
80102423:	56                   	push   %esi
80102424:	e8 07 f9 ff ff       	call   80101d30 <iunlock>
80102429:	83 c4 10             	add    $0x10,%esp
8010242c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010242f:	89 f0                	mov    %esi,%eax
80102431:	5b                   	pop    %ebx
80102432:	5e                   	pop    %esi
80102433:	5f                   	pop    %edi
80102434:	5d                   	pop    %ebp
80102435:	c3                   	ret    
80102436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010243d:	8d 76 00             	lea    0x0(%esi),%esi
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	56                   	push   %esi
80102444:	31 f6                	xor    %esi,%esi
80102446:	e8 35 f9 ff ff       	call   80101d80 <iput>
8010244b:	83 c4 10             	add    $0x10,%esp
8010244e:	e9 68 ff ff ff       	jmp    801023bb <namex+0x15b>
80102453:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010245a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102460 <dirlink>:
80102460:	f3 0f 1e fb          	endbr32 
80102464:	55                   	push   %ebp
80102465:	89 e5                	mov    %esp,%ebp
80102467:	57                   	push   %edi
80102468:	56                   	push   %esi
80102469:	53                   	push   %ebx
8010246a:	83 ec 20             	sub    $0x20,%esp
8010246d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102470:	6a 00                	push   $0x0
80102472:	ff 75 0c             	pushl  0xc(%ebp)
80102475:	53                   	push   %ebx
80102476:	e8 25 fd ff ff       	call   801021a0 <dirlookup>
8010247b:	83 c4 10             	add    $0x10,%esp
8010247e:	85 c0                	test   %eax,%eax
80102480:	75 6b                	jne    801024ed <dirlink+0x8d>
80102482:	8b 7b 58             	mov    0x58(%ebx),%edi
80102485:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102488:	85 ff                	test   %edi,%edi
8010248a:	74 2d                	je     801024b9 <dirlink+0x59>
8010248c:	31 ff                	xor    %edi,%edi
8010248e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102491:	eb 0d                	jmp    801024a0 <dirlink+0x40>
80102493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102497:	90                   	nop
80102498:	83 c7 10             	add    $0x10,%edi
8010249b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010249e:	73 19                	jae    801024b9 <dirlink+0x59>
801024a0:	6a 10                	push   $0x10
801024a2:	57                   	push   %edi
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	e8 a6 fa ff ff       	call   80101f50 <readi>
801024aa:	83 c4 10             	add    $0x10,%esp
801024ad:	83 f8 10             	cmp    $0x10,%eax
801024b0:	75 4e                	jne    80102500 <dirlink+0xa0>
801024b2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801024b7:	75 df                	jne    80102498 <dirlink+0x38>
801024b9:	83 ec 04             	sub    $0x4,%esp
801024bc:	8d 45 da             	lea    -0x26(%ebp),%eax
801024bf:	6a 0e                	push   $0xe
801024c1:	ff 75 0c             	pushl  0xc(%ebp)
801024c4:	50                   	push   %eax
801024c5:	e8 f6 27 00 00       	call   80104cc0 <strncpy>
801024ca:	6a 10                	push   $0x10
801024cc:	8b 45 10             	mov    0x10(%ebp),%eax
801024cf:	57                   	push   %edi
801024d0:	56                   	push   %esi
801024d1:	53                   	push   %ebx
801024d2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
801024d6:	e8 75 fb ff ff       	call   80102050 <writei>
801024db:	83 c4 20             	add    $0x20,%esp
801024de:	83 f8 10             	cmp    $0x10,%eax
801024e1:	75 2a                	jne    8010250d <dirlink+0xad>
801024e3:	31 c0                	xor    %eax,%eax
801024e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024e8:	5b                   	pop    %ebx
801024e9:	5e                   	pop    %esi
801024ea:	5f                   	pop    %edi
801024eb:	5d                   	pop    %ebp
801024ec:	c3                   	ret    
801024ed:	83 ec 0c             	sub    $0xc,%esp
801024f0:	50                   	push   %eax
801024f1:	e8 8a f8 ff ff       	call   80101d80 <iput>
801024f6:	83 c4 10             	add    $0x10,%esp
801024f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024fe:	eb e5                	jmp    801024e5 <dirlink+0x85>
80102500:	83 ec 0c             	sub    $0xc,%esp
80102503:	68 a0 77 10 80       	push   $0x801077a0
80102508:	e8 83 de ff ff       	call   80100390 <panic>
8010250d:	83 ec 0c             	sub    $0xc,%esp
80102510:	68 7e 7d 10 80       	push   $0x80107d7e
80102515:	e8 76 de ff ff       	call   80100390 <panic>
8010251a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102520 <namei>:
80102520:	f3 0f 1e fb          	endbr32 
80102524:	55                   	push   %ebp
80102525:	31 d2                	xor    %edx,%edx
80102527:	89 e5                	mov    %esp,%ebp
80102529:	83 ec 18             	sub    $0x18,%esp
8010252c:	8b 45 08             	mov    0x8(%ebp),%eax
8010252f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102532:	e8 29 fd ff ff       	call   80102260 <namex>
80102537:	c9                   	leave  
80102538:	c3                   	ret    
80102539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102540 <nameiparent>:
80102540:	f3 0f 1e fb          	endbr32 
80102544:	55                   	push   %ebp
80102545:	ba 01 00 00 00       	mov    $0x1,%edx
8010254a:	89 e5                	mov    %esp,%ebp
8010254c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010254f:	8b 45 08             	mov    0x8(%ebp),%eax
80102552:	5d                   	pop    %ebp
80102553:	e9 08 fd ff ff       	jmp    80102260 <namex>
80102558:	66 90                	xchg   %ax,%ax
8010255a:	66 90                	xchg   %ax,%ax
8010255c:	66 90                	xchg   %ax,%ax
8010255e:	66 90                	xchg   %ax,%ax

80102560 <idestart>:
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	83 ec 0c             	sub    $0xc,%esp
80102569:	85 c0                	test   %eax,%eax
8010256b:	0f 84 b4 00 00 00    	je     80102625 <idestart+0xc5>
80102571:	8b 70 08             	mov    0x8(%eax),%esi
80102574:	89 c3                	mov    %eax,%ebx
80102576:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010257c:	0f 87 96 00 00 00    	ja     80102618 <idestart+0xb8>
80102582:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258e:	66 90                	xchg   %ax,%ax
80102590:	89 ca                	mov    %ecx,%edx
80102592:	ec                   	in     (%dx),%al
80102593:	83 e0 c0             	and    $0xffffffc0,%eax
80102596:	3c 40                	cmp    $0x40,%al
80102598:	75 f6                	jne    80102590 <idestart+0x30>
8010259a:	31 ff                	xor    %edi,%edi
8010259c:	ba f6 03 00 00       	mov    $0x3f6,%edx
801025a1:	89 f8                	mov    %edi,%eax
801025a3:	ee                   	out    %al,(%dx)
801025a4:	b8 01 00 00 00       	mov    $0x1,%eax
801025a9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801025ae:	ee                   	out    %al,(%dx)
801025af:	ba f3 01 00 00       	mov    $0x1f3,%edx
801025b4:	89 f0                	mov    %esi,%eax
801025b6:	ee                   	out    %al,(%dx)
801025b7:	89 f0                	mov    %esi,%eax
801025b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025be:	c1 f8 08             	sar    $0x8,%eax
801025c1:	ee                   	out    %al,(%dx)
801025c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025c7:	89 f8                	mov    %edi,%eax
801025c9:	ee                   	out    %al,(%dx)
801025ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801025ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025d3:	c1 e0 04             	shl    $0x4,%eax
801025d6:	83 e0 10             	and    $0x10,%eax
801025d9:	83 c8 e0             	or     $0xffffffe0,%eax
801025dc:	ee                   	out    %al,(%dx)
801025dd:	f6 03 04             	testb  $0x4,(%ebx)
801025e0:	75 16                	jne    801025f8 <idestart+0x98>
801025e2:	b8 20 00 00 00       	mov    $0x20,%eax
801025e7:	89 ca                	mov    %ecx,%edx
801025e9:	ee                   	out    %al,(%dx)
801025ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025ed:	5b                   	pop    %ebx
801025ee:	5e                   	pop    %esi
801025ef:	5f                   	pop    %edi
801025f0:	5d                   	pop    %ebp
801025f1:	c3                   	ret    
801025f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025f8:	b8 30 00 00 00       	mov    $0x30,%eax
801025fd:	89 ca                	mov    %ecx,%edx
801025ff:	ee                   	out    %al,(%dx)
80102600:	b9 80 00 00 00       	mov    $0x80,%ecx
80102605:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102608:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010260d:	fc                   	cld    
8010260e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102610:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102613:	5b                   	pop    %ebx
80102614:	5e                   	pop    %esi
80102615:	5f                   	pop    %edi
80102616:	5d                   	pop    %ebp
80102617:	c3                   	ret    
80102618:	83 ec 0c             	sub    $0xc,%esp
8010261b:	68 0c 78 10 80       	push   $0x8010780c
80102620:	e8 6b dd ff ff       	call   80100390 <panic>
80102625:	83 ec 0c             	sub    $0xc,%esp
80102628:	68 03 78 10 80       	push   $0x80107803
8010262d:	e8 5e dd ff ff       	call   80100390 <panic>
80102632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102640 <ideinit>:
80102640:	f3 0f 1e fb          	endbr32 
80102644:	55                   	push   %ebp
80102645:	89 e5                	mov    %esp,%ebp
80102647:	83 ec 10             	sub    $0x10,%esp
8010264a:	68 1e 78 10 80       	push   $0x8010781e
8010264f:	68 80 b5 10 80       	push   $0x8010b580
80102654:	e8 77 22 00 00       	call   801048d0 <initlock>
80102659:	58                   	pop    %eax
8010265a:	a1 a0 42 11 80       	mov    0x801142a0,%eax
8010265f:	5a                   	pop    %edx
80102660:	83 e8 01             	sub    $0x1,%eax
80102663:	50                   	push   %eax
80102664:	6a 0e                	push   $0xe
80102666:	e8 b5 02 00 00       	call   80102920 <ioapicenable>
8010266b:	83 c4 10             	add    $0x10,%esp
8010266e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102673:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102677:	90                   	nop
80102678:	ec                   	in     (%dx),%al
80102679:	83 e0 c0             	and    $0xffffffc0,%eax
8010267c:	3c 40                	cmp    $0x40,%al
8010267e:	75 f8                	jne    80102678 <ideinit+0x38>
80102680:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102685:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010268a:	ee                   	out    %al,(%dx)
8010268b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102690:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102695:	eb 0e                	jmp    801026a5 <ideinit+0x65>
80102697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010269e:	66 90                	xchg   %ax,%ax
801026a0:	83 e9 01             	sub    $0x1,%ecx
801026a3:	74 0f                	je     801026b4 <ideinit+0x74>
801026a5:	ec                   	in     (%dx),%al
801026a6:	84 c0                	test   %al,%al
801026a8:	74 f6                	je     801026a0 <ideinit+0x60>
801026aa:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801026b1:	00 00 00 
801026b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026be:	ee                   	out    %al,(%dx)
801026bf:	c9                   	leave  
801026c0:	c3                   	ret    
801026c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026cf:	90                   	nop

801026d0 <ideintr>:
801026d0:	f3 0f 1e fb          	endbr32 
801026d4:	55                   	push   %ebp
801026d5:	89 e5                	mov    %esp,%ebp
801026d7:	57                   	push   %edi
801026d8:	56                   	push   %esi
801026d9:	53                   	push   %ebx
801026da:	83 ec 18             	sub    $0x18,%esp
801026dd:	68 80 b5 10 80       	push   $0x8010b580
801026e2:	e8 69 23 00 00       	call   80104a50 <acquire>
801026e7:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801026ed:	83 c4 10             	add    $0x10,%esp
801026f0:	85 db                	test   %ebx,%ebx
801026f2:	74 5f                	je     80102753 <ideintr+0x83>
801026f4:	8b 43 58             	mov    0x58(%ebx),%eax
801026f7:	a3 64 b5 10 80       	mov    %eax,0x8010b564
801026fc:	8b 33                	mov    (%ebx),%esi
801026fe:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102704:	75 2b                	jne    80102731 <ideintr+0x61>
80102706:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010270b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop
80102710:	ec                   	in     (%dx),%al
80102711:	89 c1                	mov    %eax,%ecx
80102713:	83 e1 c0             	and    $0xffffffc0,%ecx
80102716:	80 f9 40             	cmp    $0x40,%cl
80102719:	75 f5                	jne    80102710 <ideintr+0x40>
8010271b:	a8 21                	test   $0x21,%al
8010271d:	75 12                	jne    80102731 <ideintr+0x61>
8010271f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102722:	b9 80 00 00 00       	mov    $0x80,%ecx
80102727:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010272c:	fc                   	cld    
8010272d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010272f:	8b 33                	mov    (%ebx),%esi
80102731:	83 e6 fb             	and    $0xfffffffb,%esi
80102734:	83 ec 0c             	sub    $0xc,%esp
80102737:	83 ce 02             	or     $0x2,%esi
8010273a:	89 33                	mov    %esi,(%ebx)
8010273c:	53                   	push   %ebx
8010273d:	e8 8e 1e 00 00       	call   801045d0 <wakeup>
80102742:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102747:	83 c4 10             	add    $0x10,%esp
8010274a:	85 c0                	test   %eax,%eax
8010274c:	74 05                	je     80102753 <ideintr+0x83>
8010274e:	e8 0d fe ff ff       	call   80102560 <idestart>
80102753:	83 ec 0c             	sub    $0xc,%esp
80102756:	68 80 b5 10 80       	push   $0x8010b580
8010275b:	e8 b0 23 00 00       	call   80104b10 <release>
80102760:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102763:	5b                   	pop    %ebx
80102764:	5e                   	pop    %esi
80102765:	5f                   	pop    %edi
80102766:	5d                   	pop    %ebp
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop

80102770 <iderw>:
80102770:	f3 0f 1e fb          	endbr32 
80102774:	55                   	push   %ebp
80102775:	89 e5                	mov    %esp,%ebp
80102777:	53                   	push   %ebx
80102778:	83 ec 10             	sub    $0x10,%esp
8010277b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010277e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102781:	50                   	push   %eax
80102782:	e8 e9 20 00 00       	call   80104870 <holdingsleep>
80102787:	83 c4 10             	add    $0x10,%esp
8010278a:	85 c0                	test   %eax,%eax
8010278c:	0f 84 cf 00 00 00    	je     80102861 <iderw+0xf1>
80102792:	8b 03                	mov    (%ebx),%eax
80102794:	83 e0 06             	and    $0x6,%eax
80102797:	83 f8 02             	cmp    $0x2,%eax
8010279a:	0f 84 b4 00 00 00    	je     80102854 <iderw+0xe4>
801027a0:	8b 53 04             	mov    0x4(%ebx),%edx
801027a3:	85 d2                	test   %edx,%edx
801027a5:	74 0d                	je     801027b4 <iderw+0x44>
801027a7:	a1 60 b5 10 80       	mov    0x8010b560,%eax
801027ac:	85 c0                	test   %eax,%eax
801027ae:	0f 84 93 00 00 00    	je     80102847 <iderw+0xd7>
801027b4:	83 ec 0c             	sub    $0xc,%esp
801027b7:	68 80 b5 10 80       	push   $0x8010b580
801027bc:	e8 8f 22 00 00       	call   80104a50 <acquire>
801027c1:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801027c6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
801027cd:	83 c4 10             	add    $0x10,%esp
801027d0:	85 c0                	test   %eax,%eax
801027d2:	74 6c                	je     80102840 <iderw+0xd0>
801027d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027d8:	89 c2                	mov    %eax,%edx
801027da:	8b 40 58             	mov    0x58(%eax),%eax
801027dd:	85 c0                	test   %eax,%eax
801027df:	75 f7                	jne    801027d8 <iderw+0x68>
801027e1:	83 c2 58             	add    $0x58,%edx
801027e4:	89 1a                	mov    %ebx,(%edx)
801027e6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
801027ec:	74 42                	je     80102830 <iderw+0xc0>
801027ee:	8b 03                	mov    (%ebx),%eax
801027f0:	83 e0 06             	and    $0x6,%eax
801027f3:	83 f8 02             	cmp    $0x2,%eax
801027f6:	74 23                	je     8010281b <iderw+0xab>
801027f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ff:	90                   	nop
80102800:	83 ec 08             	sub    $0x8,%esp
80102803:	68 80 b5 10 80       	push   $0x8010b580
80102808:	53                   	push   %ebx
80102809:	e8 02 1c 00 00       	call   80104410 <sleep>
8010280e:	8b 03                	mov    (%ebx),%eax
80102810:	83 c4 10             	add    $0x10,%esp
80102813:	83 e0 06             	and    $0x6,%eax
80102816:	83 f8 02             	cmp    $0x2,%eax
80102819:	75 e5                	jne    80102800 <iderw+0x90>
8010281b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
80102822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102825:	c9                   	leave  
80102826:	e9 e5 22 00 00       	jmp    80104b10 <release>
8010282b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010282f:	90                   	nop
80102830:	89 d8                	mov    %ebx,%eax
80102832:	e8 29 fd ff ff       	call   80102560 <idestart>
80102837:	eb b5                	jmp    801027ee <iderw+0x7e>
80102839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102840:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102845:	eb 9d                	jmp    801027e4 <iderw+0x74>
80102847:	83 ec 0c             	sub    $0xc,%esp
8010284a:	68 4d 78 10 80       	push   $0x8010784d
8010284f:	e8 3c db ff ff       	call   80100390 <panic>
80102854:	83 ec 0c             	sub    $0xc,%esp
80102857:	68 38 78 10 80       	push   $0x80107838
8010285c:	e8 2f db ff ff       	call   80100390 <panic>
80102861:	83 ec 0c             	sub    $0xc,%esp
80102864:	68 22 78 10 80       	push   $0x80107822
80102869:	e8 22 db ff ff       	call   80100390 <panic>
8010286e:	66 90                	xchg   %ax,%ax

80102870 <ioapicinit>:
80102870:	f3 0f 1e fb          	endbr32 
80102874:	55                   	push   %ebp
80102875:	c7 05 d4 3b 11 80 00 	movl   $0xfec00000,0x80113bd4
8010287c:	00 c0 fe 
8010287f:	89 e5                	mov    %esp,%ebp
80102881:	56                   	push   %esi
80102882:	53                   	push   %ebx
80102883:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010288a:	00 00 00 
8010288d:	8b 15 d4 3b 11 80    	mov    0x80113bd4,%edx
80102893:	8b 72 10             	mov    0x10(%edx),%esi
80102896:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
8010289c:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
801028a2:	0f b6 15 00 3d 11 80 	movzbl 0x80113d00,%edx
801028a9:	c1 ee 10             	shr    $0x10,%esi
801028ac:	89 f0                	mov    %esi,%eax
801028ae:	0f b6 f0             	movzbl %al,%esi
801028b1:	8b 41 10             	mov    0x10(%ecx),%eax
801028b4:	c1 e8 18             	shr    $0x18,%eax
801028b7:	39 c2                	cmp    %eax,%edx
801028b9:	74 16                	je     801028d1 <ioapicinit+0x61>
801028bb:	83 ec 0c             	sub    $0xc,%esp
801028be:	68 6c 78 10 80       	push   $0x8010786c
801028c3:	e8 f8 df ff ff       	call   801008c0 <cprintf>
801028c8:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
801028ce:	83 c4 10             	add    $0x10,%esp
801028d1:	83 c6 21             	add    $0x21,%esi
801028d4:	ba 10 00 00 00       	mov    $0x10,%edx
801028d9:	b8 20 00 00 00       	mov    $0x20,%eax
801028de:	66 90                	xchg   %ax,%ax
801028e0:	89 11                	mov    %edx,(%ecx)
801028e2:	89 c3                	mov    %eax,%ebx
801028e4:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
801028ea:	83 c0 01             	add    $0x1,%eax
801028ed:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801028f3:	89 59 10             	mov    %ebx,0x10(%ecx)
801028f6:	8d 5a 01             	lea    0x1(%edx),%ebx
801028f9:	83 c2 02             	add    $0x2,%edx
801028fc:	89 19                	mov    %ebx,(%ecx)
801028fe:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
80102904:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
8010290b:	39 f0                	cmp    %esi,%eax
8010290d:	75 d1                	jne    801028e0 <ioapicinit+0x70>
8010290f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102912:	5b                   	pop    %ebx
80102913:	5e                   	pop    %esi
80102914:	5d                   	pop    %ebp
80102915:	c3                   	ret    
80102916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291d:	8d 76 00             	lea    0x0(%esi),%esi

80102920 <ioapicenable>:
80102920:	f3 0f 1e fb          	endbr32 
80102924:	55                   	push   %ebp
80102925:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
8010292b:	89 e5                	mov    %esp,%ebp
8010292d:	8b 45 08             	mov    0x8(%ebp),%eax
80102930:	8d 50 20             	lea    0x20(%eax),%edx
80102933:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102937:	89 01                	mov    %eax,(%ecx)
80102939:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
8010293f:	83 c0 01             	add    $0x1,%eax
80102942:	89 51 10             	mov    %edx,0x10(%ecx)
80102945:	8b 55 0c             	mov    0xc(%ebp),%edx
80102948:	89 01                	mov    %eax,(%ecx)
8010294a:	a1 d4 3b 11 80       	mov    0x80113bd4,%eax
8010294f:	c1 e2 18             	shl    $0x18,%edx
80102952:	89 50 10             	mov    %edx,0x10(%eax)
80102955:	5d                   	pop    %ebp
80102956:	c3                   	ret    
80102957:	66 90                	xchg   %ax,%ax
80102959:	66 90                	xchg   %ax,%ax
8010295b:	66 90                	xchg   %ax,%ax
8010295d:	66 90                	xchg   %ax,%ax
8010295f:	90                   	nop

80102960 <kfree>:
80102960:	f3 0f 1e fb          	endbr32 
80102964:	55                   	push   %ebp
80102965:	89 e5                	mov    %esp,%ebp
80102967:	53                   	push   %ebx
80102968:	83 ec 04             	sub    $0x4,%esp
8010296b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010296e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102974:	75 7a                	jne    801029f0 <kfree+0x90>
80102976:	81 fb 48 6a 11 80    	cmp    $0x80116a48,%ebx
8010297c:	72 72                	jb     801029f0 <kfree+0x90>
8010297e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102984:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102989:	77 65                	ja     801029f0 <kfree+0x90>
8010298b:	83 ec 04             	sub    $0x4,%esp
8010298e:	68 00 10 00 00       	push   $0x1000
80102993:	6a 01                	push   $0x1
80102995:	53                   	push   %ebx
80102996:	e8 c5 21 00 00       	call   80104b60 <memset>
8010299b:	8b 15 14 3c 11 80    	mov    0x80113c14,%edx
801029a1:	83 c4 10             	add    $0x10,%esp
801029a4:	85 d2                	test   %edx,%edx
801029a6:	75 20                	jne    801029c8 <kfree+0x68>
801029a8:	a1 18 3c 11 80       	mov    0x80113c18,%eax
801029ad:	89 03                	mov    %eax,(%ebx)
801029af:	a1 14 3c 11 80       	mov    0x80113c14,%eax
801029b4:	89 1d 18 3c 11 80    	mov    %ebx,0x80113c18
801029ba:	85 c0                	test   %eax,%eax
801029bc:	75 22                	jne    801029e0 <kfree+0x80>
801029be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029c1:	c9                   	leave  
801029c2:	c3                   	ret    
801029c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029c7:	90                   	nop
801029c8:	83 ec 0c             	sub    $0xc,%esp
801029cb:	68 e0 3b 11 80       	push   $0x80113be0
801029d0:	e8 7b 20 00 00       	call   80104a50 <acquire>
801029d5:	83 c4 10             	add    $0x10,%esp
801029d8:	eb ce                	jmp    801029a8 <kfree+0x48>
801029da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029e0:	c7 45 08 e0 3b 11 80 	movl   $0x80113be0,0x8(%ebp)
801029e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ea:	c9                   	leave  
801029eb:	e9 20 21 00 00       	jmp    80104b10 <release>
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	68 9e 78 10 80       	push   $0x8010789e
801029f8:	e8 93 d9 ff ff       	call   80100390 <panic>
801029fd:	8d 76 00             	lea    0x0(%esi),%esi

80102a00 <freerange>:
80102a00:	f3 0f 1e fb          	endbr32 
80102a04:	55                   	push   %ebp
80102a05:	89 e5                	mov    %esp,%ebp
80102a07:	56                   	push   %esi
80102a08:	8b 45 08             	mov    0x8(%ebp),%eax
80102a0b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a0e:	53                   	push   %ebx
80102a0f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a15:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102a1b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a21:	39 de                	cmp    %ebx,%esi
80102a23:	72 1f                	jb     80102a44 <freerange+0x44>
80102a25:	8d 76 00             	lea    0x0(%esi),%esi
80102a28:	83 ec 0c             	sub    $0xc,%esp
80102a2b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a31:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a37:	50                   	push   %eax
80102a38:	e8 23 ff ff ff       	call   80102960 <kfree>
80102a3d:	83 c4 10             	add    $0x10,%esp
80102a40:	39 f3                	cmp    %esi,%ebx
80102a42:	76 e4                	jbe    80102a28 <freerange+0x28>
80102a44:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a47:	5b                   	pop    %ebx
80102a48:	5e                   	pop    %esi
80102a49:	5d                   	pop    %ebp
80102a4a:	c3                   	ret    
80102a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a4f:	90                   	nop

80102a50 <kinit1>:
80102a50:	f3 0f 1e fb          	endbr32 
80102a54:	55                   	push   %ebp
80102a55:	89 e5                	mov    %esp,%ebp
80102a57:	56                   	push   %esi
80102a58:	53                   	push   %ebx
80102a59:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a5c:	83 ec 08             	sub    $0x8,%esp
80102a5f:	68 a4 78 10 80       	push   $0x801078a4
80102a64:	68 e0 3b 11 80       	push   $0x80113be0
80102a69:	e8 62 1e 00 00       	call   801048d0 <initlock>
80102a6e:	8b 45 08             	mov    0x8(%ebp),%eax
80102a71:	83 c4 10             	add    $0x10,%esp
80102a74:	c7 05 14 3c 11 80 00 	movl   $0x0,0x80113c14
80102a7b:	00 00 00 
80102a7e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a84:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102a8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a90:	39 de                	cmp    %ebx,%esi
80102a92:	72 20                	jb     80102ab4 <kinit1+0x64>
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a98:	83 ec 0c             	sub    $0xc,%esp
80102a9b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102aa1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102aa7:	50                   	push   %eax
80102aa8:	e8 b3 fe ff ff       	call   80102960 <kfree>
80102aad:	83 c4 10             	add    $0x10,%esp
80102ab0:	39 de                	cmp    %ebx,%esi
80102ab2:	73 e4                	jae    80102a98 <kinit1+0x48>
80102ab4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ab7:	5b                   	pop    %ebx
80102ab8:	5e                   	pop    %esi
80102ab9:	5d                   	pop    %ebp
80102aba:	c3                   	ret    
80102abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102abf:	90                   	nop

80102ac0 <kinit2>:
80102ac0:	f3 0f 1e fb          	endbr32 
80102ac4:	55                   	push   %ebp
80102ac5:	89 e5                	mov    %esp,%ebp
80102ac7:	56                   	push   %esi
80102ac8:	8b 45 08             	mov    0x8(%ebp),%eax
80102acb:	8b 75 0c             	mov    0xc(%ebp),%esi
80102ace:	53                   	push   %ebx
80102acf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ad5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102adb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ae1:	39 de                	cmp    %ebx,%esi
80102ae3:	72 1f                	jb     80102b04 <kinit2+0x44>
80102ae5:	8d 76 00             	lea    0x0(%esi),%esi
80102ae8:	83 ec 0c             	sub    $0xc,%esp
80102aeb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102af1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102af7:	50                   	push   %eax
80102af8:	e8 63 fe ff ff       	call   80102960 <kfree>
80102afd:	83 c4 10             	add    $0x10,%esp
80102b00:	39 de                	cmp    %ebx,%esi
80102b02:	73 e4                	jae    80102ae8 <kinit2+0x28>
80102b04:	c7 05 14 3c 11 80 01 	movl   $0x1,0x80113c14
80102b0b:	00 00 00 
80102b0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b11:	5b                   	pop    %ebx
80102b12:	5e                   	pop    %esi
80102b13:	5d                   	pop    %ebp
80102b14:	c3                   	ret    
80102b15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <kalloc>:
80102b20:	f3 0f 1e fb          	endbr32 
80102b24:	a1 14 3c 11 80       	mov    0x80113c14,%eax
80102b29:	85 c0                	test   %eax,%eax
80102b2b:	75 1b                	jne    80102b48 <kalloc+0x28>
80102b2d:	a1 18 3c 11 80       	mov    0x80113c18,%eax
80102b32:	85 c0                	test   %eax,%eax
80102b34:	74 0a                	je     80102b40 <kalloc+0x20>
80102b36:	8b 10                	mov    (%eax),%edx
80102b38:	89 15 18 3c 11 80    	mov    %edx,0x80113c18
80102b3e:	c3                   	ret    
80102b3f:	90                   	nop
80102b40:	c3                   	ret    
80102b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b48:	55                   	push   %ebp
80102b49:	89 e5                	mov    %esp,%ebp
80102b4b:	83 ec 24             	sub    $0x24,%esp
80102b4e:	68 e0 3b 11 80       	push   $0x80113be0
80102b53:	e8 f8 1e 00 00       	call   80104a50 <acquire>
80102b58:	a1 18 3c 11 80       	mov    0x80113c18,%eax
80102b5d:	8b 15 14 3c 11 80    	mov    0x80113c14,%edx
80102b63:	83 c4 10             	add    $0x10,%esp
80102b66:	85 c0                	test   %eax,%eax
80102b68:	74 08                	je     80102b72 <kalloc+0x52>
80102b6a:	8b 08                	mov    (%eax),%ecx
80102b6c:	89 0d 18 3c 11 80    	mov    %ecx,0x80113c18
80102b72:	85 d2                	test   %edx,%edx
80102b74:	74 16                	je     80102b8c <kalloc+0x6c>
80102b76:	83 ec 0c             	sub    $0xc,%esp
80102b79:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b7c:	68 e0 3b 11 80       	push   $0x80113be0
80102b81:	e8 8a 1f 00 00       	call   80104b10 <release>
80102b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b89:	83 c4 10             	add    $0x10,%esp
80102b8c:	c9                   	leave  
80102b8d:	c3                   	ret    
80102b8e:	66 90                	xchg   %ax,%ax

80102b90 <kbdgetc>:
80102b90:	f3 0f 1e fb          	endbr32 
80102b94:	ba 64 00 00 00       	mov    $0x64,%edx
80102b99:	ec                   	in     (%dx),%al
80102b9a:	a8 01                	test   $0x1,%al
80102b9c:	0f 84 be 00 00 00    	je     80102c60 <kbdgetc+0xd0>
80102ba2:	55                   	push   %ebp
80102ba3:	ba 60 00 00 00       	mov    $0x60,%edx
80102ba8:	89 e5                	mov    %esp,%ebp
80102baa:	53                   	push   %ebx
80102bab:	ec                   	in     (%dx),%al
80102bac:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx
80102bb2:	0f b6 d0             	movzbl %al,%edx
80102bb5:	3c e0                	cmp    $0xe0,%al
80102bb7:	74 57                	je     80102c10 <kbdgetc+0x80>
80102bb9:	89 d9                	mov    %ebx,%ecx
80102bbb:	83 e1 40             	and    $0x40,%ecx
80102bbe:	84 c0                	test   %al,%al
80102bc0:	78 5e                	js     80102c20 <kbdgetc+0x90>
80102bc2:	85 c9                	test   %ecx,%ecx
80102bc4:	74 09                	je     80102bcf <kbdgetc+0x3f>
80102bc6:	83 c8 80             	or     $0xffffff80,%eax
80102bc9:	83 e3 bf             	and    $0xffffffbf,%ebx
80102bcc:	0f b6 d0             	movzbl %al,%edx
80102bcf:	0f b6 8a e0 79 10 80 	movzbl -0x7fef8620(%edx),%ecx
80102bd6:	0f b6 82 e0 78 10 80 	movzbl -0x7fef8720(%edx),%eax
80102bdd:	09 d9                	or     %ebx,%ecx
80102bdf:	31 c1                	xor    %eax,%ecx
80102be1:	89 c8                	mov    %ecx,%eax
80102be3:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
80102be9:	83 e0 03             	and    $0x3,%eax
80102bec:	83 e1 08             	and    $0x8,%ecx
80102bef:	8b 04 85 c0 78 10 80 	mov    -0x7fef8740(,%eax,4),%eax
80102bf6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
80102bfa:	74 0b                	je     80102c07 <kbdgetc+0x77>
80102bfc:	8d 50 9f             	lea    -0x61(%eax),%edx
80102bff:	83 fa 19             	cmp    $0x19,%edx
80102c02:	77 44                	ja     80102c48 <kbdgetc+0xb8>
80102c04:	83 e8 20             	sub    $0x20,%eax
80102c07:	5b                   	pop    %ebx
80102c08:	5d                   	pop    %ebp
80102c09:	c3                   	ret    
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c10:	83 cb 40             	or     $0x40,%ebx
80102c13:	31 c0                	xor    %eax,%eax
80102c15:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
80102c1b:	5b                   	pop    %ebx
80102c1c:	5d                   	pop    %ebp
80102c1d:	c3                   	ret    
80102c1e:	66 90                	xchg   %ax,%ax
80102c20:	83 e0 7f             	and    $0x7f,%eax
80102c23:	85 c9                	test   %ecx,%ecx
80102c25:	0f 44 d0             	cmove  %eax,%edx
80102c28:	31 c0                	xor    %eax,%eax
80102c2a:	0f b6 8a e0 79 10 80 	movzbl -0x7fef8620(%edx),%ecx
80102c31:	83 c9 40             	or     $0x40,%ecx
80102c34:	0f b6 c9             	movzbl %cl,%ecx
80102c37:	f7 d1                	not    %ecx
80102c39:	21 d9                	and    %ebx,%ecx
80102c3b:	5b                   	pop    %ebx
80102c3c:	5d                   	pop    %ebp
80102c3d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
80102c43:	c3                   	ret    
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c48:	8d 48 bf             	lea    -0x41(%eax),%ecx
80102c4b:	8d 50 20             	lea    0x20(%eax),%edx
80102c4e:	5b                   	pop    %ebx
80102c4f:	5d                   	pop    %ebp
80102c50:	83 f9 1a             	cmp    $0x1a,%ecx
80102c53:	0f 42 c2             	cmovb  %edx,%eax
80102c56:	c3                   	ret    
80102c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c5e:	66 90                	xchg   %ax,%ax
80102c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c65:	c3                   	ret    
80102c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6d:	8d 76 00             	lea    0x0(%esi),%esi

80102c70 <kbdintr>:
80102c70:	f3 0f 1e fb          	endbr32 
80102c74:	55                   	push   %ebp
80102c75:	89 e5                	mov    %esp,%ebp
80102c77:	83 ec 14             	sub    $0x14,%esp
80102c7a:	68 90 2b 10 80       	push   $0x80102b90
80102c7f:	e8 ec dd ff ff       	call   80100a70 <consoleintr>
80102c84:	83 c4 10             	add    $0x10,%esp
80102c87:	c9                   	leave  
80102c88:	c3                   	ret    
80102c89:	66 90                	xchg   %ax,%ax
80102c8b:	66 90                	xchg   %ax,%ax
80102c8d:	66 90                	xchg   %ax,%ax
80102c8f:	90                   	nop

80102c90 <lapicinit>:
80102c90:	f3 0f 1e fb          	endbr32 
80102c94:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102c99:	85 c0                	test   %eax,%eax
80102c9b:	0f 84 c7 00 00 00    	je     80102d68 <lapicinit+0xd8>
80102ca1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102ca8:	01 00 00 
80102cab:	8b 50 20             	mov    0x20(%eax),%edx
80102cae:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102cb5:	00 00 00 
80102cb8:	8b 50 20             	mov    0x20(%eax),%edx
80102cbb:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102cc2:	00 02 00 
80102cc5:	8b 50 20             	mov    0x20(%eax),%edx
80102cc8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102ccf:	96 98 00 
80102cd2:	8b 50 20             	mov    0x20(%eax),%edx
80102cd5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102cdc:	00 01 00 
80102cdf:	8b 50 20             	mov    0x20(%eax),%edx
80102ce2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102ce9:	00 01 00 
80102cec:	8b 50 20             	mov    0x20(%eax),%edx
80102cef:	8b 50 30             	mov    0x30(%eax),%edx
80102cf2:	c1 ea 10             	shr    $0x10,%edx
80102cf5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102cfb:	75 73                	jne    80102d70 <lapicinit+0xe0>
80102cfd:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d04:	00 00 00 
80102d07:	8b 50 20             	mov    0x20(%eax),%edx
80102d0a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d11:	00 00 00 
80102d14:	8b 50 20             	mov    0x20(%eax),%edx
80102d17:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d1e:	00 00 00 
80102d21:	8b 50 20             	mov    0x20(%eax),%edx
80102d24:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d2b:	00 00 00 
80102d2e:	8b 50 20             	mov    0x20(%eax),%edx
80102d31:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d38:	00 00 00 
80102d3b:	8b 50 20             	mov    0x20(%eax),%edx
80102d3e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d45:	85 08 00 
80102d48:	8b 50 20             	mov    0x20(%eax),%edx
80102d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d4f:	90                   	nop
80102d50:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d56:	80 e6 10             	and    $0x10,%dh
80102d59:	75 f5                	jne    80102d50 <lapicinit+0xc0>
80102d5b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d62:	00 00 00 
80102d65:	8b 40 20             	mov    0x20(%eax),%eax
80102d68:	c3                   	ret    
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d70:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102d77:	00 01 00 
80102d7a:	8b 50 20             	mov    0x20(%eax),%edx
80102d7d:	e9 7b ff ff ff       	jmp    80102cfd <lapicinit+0x6d>
80102d82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <lapicid>:
80102d90:	f3 0f 1e fb          	endbr32 
80102d94:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102d99:	85 c0                	test   %eax,%eax
80102d9b:	74 0b                	je     80102da8 <lapicid+0x18>
80102d9d:	8b 40 20             	mov    0x20(%eax),%eax
80102da0:	c1 e8 18             	shr    $0x18,%eax
80102da3:	c3                   	ret    
80102da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102da8:	31 c0                	xor    %eax,%eax
80102daa:	c3                   	ret    
80102dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102daf:	90                   	nop

80102db0 <lapiceoi>:
80102db0:	f3 0f 1e fb          	endbr32 
80102db4:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102db9:	85 c0                	test   %eax,%eax
80102dbb:	74 0d                	je     80102dca <lapiceoi+0x1a>
80102dbd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102dc4:	00 00 00 
80102dc7:	8b 40 20             	mov    0x20(%eax),%eax
80102dca:	c3                   	ret    
80102dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dcf:	90                   	nop

80102dd0 <microdelay>:
80102dd0:	f3 0f 1e fb          	endbr32 
80102dd4:	c3                   	ret    
80102dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102de0 <lapicstartap>:
80102de0:	f3 0f 1e fb          	endbr32 
80102de4:	55                   	push   %ebp
80102de5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102dea:	ba 70 00 00 00       	mov    $0x70,%edx
80102def:	89 e5                	mov    %esp,%ebp
80102df1:	53                   	push   %ebx
80102df2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102df5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102df8:	ee                   	out    %al,(%dx)
80102df9:	b8 0a 00 00 00       	mov    $0xa,%eax
80102dfe:	ba 71 00 00 00       	mov    $0x71,%edx
80102e03:	ee                   	out    %al,(%dx)
80102e04:	31 c0                	xor    %eax,%eax
80102e06:	c1 e3 18             	shl    $0x18,%ebx
80102e09:	66 a3 67 04 00 80    	mov    %ax,0x80000467
80102e0f:	89 c8                	mov    %ecx,%eax
80102e11:	c1 e9 0c             	shr    $0xc,%ecx
80102e14:	89 da                	mov    %ebx,%edx
80102e16:	c1 e8 04             	shr    $0x4,%eax
80102e19:	80 cd 06             	or     $0x6,%ch
80102e1c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
80102e22:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102e27:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102e2d:	8b 58 20             	mov    0x20(%eax),%ebx
80102e30:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e37:	c5 00 00 
80102e3a:	8b 58 20             	mov    0x20(%eax),%ebx
80102e3d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e44:	85 00 00 
80102e47:	8b 58 20             	mov    0x20(%eax),%ebx
80102e4a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102e50:	8b 58 20             	mov    0x20(%eax),%ebx
80102e53:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102e59:	8b 58 20             	mov    0x20(%eax),%ebx
80102e5c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102e62:	8b 50 20             	mov    0x20(%eax),%edx
80102e65:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102e6b:	5b                   	pop    %ebx
80102e6c:	8b 40 20             	mov    0x20(%eax),%eax
80102e6f:	5d                   	pop    %ebp
80102e70:	c3                   	ret    
80102e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7f:	90                   	nop

80102e80 <cmostime>:
80102e80:	f3 0f 1e fb          	endbr32 
80102e84:	55                   	push   %ebp
80102e85:	b8 0b 00 00 00       	mov    $0xb,%eax
80102e8a:	ba 70 00 00 00       	mov    $0x70,%edx
80102e8f:	89 e5                	mov    %esp,%ebp
80102e91:	57                   	push   %edi
80102e92:	56                   	push   %esi
80102e93:	53                   	push   %ebx
80102e94:	83 ec 4c             	sub    $0x4c,%esp
80102e97:	ee                   	out    %al,(%dx)
80102e98:	ba 71 00 00 00       	mov    $0x71,%edx
80102e9d:	ec                   	in     (%dx),%al
80102e9e:	83 e0 04             	and    $0x4,%eax
80102ea1:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ea6:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eb0:	31 c0                	xor    %eax,%eax
80102eb2:	89 da                	mov    %ebx,%edx
80102eb4:	ee                   	out    %al,(%dx)
80102eb5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102eba:	89 ca                	mov    %ecx,%edx
80102ebc:	ec                   	in     (%dx),%al
80102ebd:	88 45 b7             	mov    %al,-0x49(%ebp)
80102ec0:	89 da                	mov    %ebx,%edx
80102ec2:	b8 02 00 00 00       	mov    $0x2,%eax
80102ec7:	ee                   	out    %al,(%dx)
80102ec8:	89 ca                	mov    %ecx,%edx
80102eca:	ec                   	in     (%dx),%al
80102ecb:	88 45 b6             	mov    %al,-0x4a(%ebp)
80102ece:	89 da                	mov    %ebx,%edx
80102ed0:	b8 04 00 00 00       	mov    $0x4,%eax
80102ed5:	ee                   	out    %al,(%dx)
80102ed6:	89 ca                	mov    %ecx,%edx
80102ed8:	ec                   	in     (%dx),%al
80102ed9:	88 45 b5             	mov    %al,-0x4b(%ebp)
80102edc:	89 da                	mov    %ebx,%edx
80102ede:	b8 07 00 00 00       	mov    $0x7,%eax
80102ee3:	ee                   	out    %al,(%dx)
80102ee4:	89 ca                	mov    %ecx,%edx
80102ee6:	ec                   	in     (%dx),%al
80102ee7:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102eea:	89 da                	mov    %ebx,%edx
80102eec:	b8 08 00 00 00       	mov    $0x8,%eax
80102ef1:	ee                   	out    %al,(%dx)
80102ef2:	89 ca                	mov    %ecx,%edx
80102ef4:	ec                   	in     (%dx),%al
80102ef5:	89 c7                	mov    %eax,%edi
80102ef7:	89 da                	mov    %ebx,%edx
80102ef9:	b8 09 00 00 00       	mov    $0x9,%eax
80102efe:	ee                   	out    %al,(%dx)
80102eff:	89 ca                	mov    %ecx,%edx
80102f01:	ec                   	in     (%dx),%al
80102f02:	89 c6                	mov    %eax,%esi
80102f04:	89 da                	mov    %ebx,%edx
80102f06:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f0b:	ee                   	out    %al,(%dx)
80102f0c:	89 ca                	mov    %ecx,%edx
80102f0e:	ec                   	in     (%dx),%al
80102f0f:	84 c0                	test   %al,%al
80102f11:	78 9d                	js     80102eb0 <cmostime+0x30>
80102f13:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f17:	89 fa                	mov    %edi,%edx
80102f19:	0f b6 fa             	movzbl %dl,%edi
80102f1c:	89 f2                	mov    %esi,%edx
80102f1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f21:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f25:	0f b6 f2             	movzbl %dl,%esi
80102f28:	89 da                	mov    %ebx,%edx
80102f2a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102f2d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102f30:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102f34:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102f37:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102f3a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102f3e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102f41:	31 c0                	xor    %eax,%eax
80102f43:	ee                   	out    %al,(%dx)
80102f44:	89 ca                	mov    %ecx,%edx
80102f46:	ec                   	in     (%dx),%al
80102f47:	0f b6 c0             	movzbl %al,%eax
80102f4a:	89 da                	mov    %ebx,%edx
80102f4c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f4f:	b8 02 00 00 00       	mov    $0x2,%eax
80102f54:	ee                   	out    %al,(%dx)
80102f55:	89 ca                	mov    %ecx,%edx
80102f57:	ec                   	in     (%dx),%al
80102f58:	0f b6 c0             	movzbl %al,%eax
80102f5b:	89 da                	mov    %ebx,%edx
80102f5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102f60:	b8 04 00 00 00       	mov    $0x4,%eax
80102f65:	ee                   	out    %al,(%dx)
80102f66:	89 ca                	mov    %ecx,%edx
80102f68:	ec                   	in     (%dx),%al
80102f69:	0f b6 c0             	movzbl %al,%eax
80102f6c:	89 da                	mov    %ebx,%edx
80102f6e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f71:	b8 07 00 00 00       	mov    $0x7,%eax
80102f76:	ee                   	out    %al,(%dx)
80102f77:	89 ca                	mov    %ecx,%edx
80102f79:	ec                   	in     (%dx),%al
80102f7a:	0f b6 c0             	movzbl %al,%eax
80102f7d:	89 da                	mov    %ebx,%edx
80102f7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f82:	b8 08 00 00 00       	mov    $0x8,%eax
80102f87:	ee                   	out    %al,(%dx)
80102f88:	89 ca                	mov    %ecx,%edx
80102f8a:	ec                   	in     (%dx),%al
80102f8b:	0f b6 c0             	movzbl %al,%eax
80102f8e:	89 da                	mov    %ebx,%edx
80102f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102f93:	b8 09 00 00 00       	mov    $0x9,%eax
80102f98:	ee                   	out    %al,(%dx)
80102f99:	89 ca                	mov    %ecx,%edx
80102f9b:	ec                   	in     (%dx),%al
80102f9c:	0f b6 c0             	movzbl %al,%eax
80102f9f:	83 ec 04             	sub    $0x4,%esp
80102fa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102fa5:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102fa8:	6a 18                	push   $0x18
80102faa:	50                   	push   %eax
80102fab:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102fae:	50                   	push   %eax
80102faf:	e8 fc 1b 00 00       	call   80104bb0 <memcmp>
80102fb4:	83 c4 10             	add    $0x10,%esp
80102fb7:	85 c0                	test   %eax,%eax
80102fb9:	0f 85 f1 fe ff ff    	jne    80102eb0 <cmostime+0x30>
80102fbf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102fc3:	75 78                	jne    8010303d <cmostime+0x1bd>
80102fc5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fc8:	89 c2                	mov    %eax,%edx
80102fca:	83 e0 0f             	and    $0xf,%eax
80102fcd:	c1 ea 04             	shr    $0x4,%edx
80102fd0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fd3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fd6:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fd9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102fdc:	89 c2                	mov    %eax,%edx
80102fde:	83 e0 0f             	and    $0xf,%eax
80102fe1:	c1 ea 04             	shr    $0x4,%edx
80102fe4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fe7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fea:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102fed:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ff0:	89 c2                	mov    %eax,%edx
80102ff2:	83 e0 0f             	and    $0xf,%eax
80102ff5:	c1 ea 04             	shr    $0x4,%edx
80102ff8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ffb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ffe:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103001:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103004:	89 c2                	mov    %eax,%edx
80103006:	83 e0 0f             	and    $0xf,%eax
80103009:	c1 ea 04             	shr    $0x4,%edx
8010300c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010300f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103012:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103015:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103018:	89 c2                	mov    %eax,%edx
8010301a:	83 e0 0f             	and    $0xf,%eax
8010301d:	c1 ea 04             	shr    $0x4,%edx
80103020:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103023:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103026:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103029:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010302c:	89 c2                	mov    %eax,%edx
8010302e:	83 e0 0f             	and    $0xf,%eax
80103031:	c1 ea 04             	shr    $0x4,%edx
80103034:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103037:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010303a:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010303d:	8b 75 08             	mov    0x8(%ebp),%esi
80103040:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103043:	89 06                	mov    %eax,(%esi)
80103045:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103048:	89 46 04             	mov    %eax,0x4(%esi)
8010304b:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010304e:	89 46 08             	mov    %eax,0x8(%esi)
80103051:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103054:	89 46 0c             	mov    %eax,0xc(%esi)
80103057:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010305a:	89 46 10             	mov    %eax,0x10(%esi)
8010305d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103060:	89 46 14             	mov    %eax,0x14(%esi)
80103063:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
8010306a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010306d:	5b                   	pop    %ebx
8010306e:	5e                   	pop    %esi
8010306f:	5f                   	pop    %edi
80103070:	5d                   	pop    %ebp
80103071:	c3                   	ret    
80103072:	66 90                	xchg   %ax,%ax
80103074:	66 90                	xchg   %ax,%ax
80103076:	66 90                	xchg   %ax,%ax
80103078:	66 90                	xchg   %ax,%ax
8010307a:	66 90                	xchg   %ax,%ax
8010307c:	66 90                	xchg   %ax,%ax
8010307e:	66 90                	xchg   %ax,%ax

80103080 <install_trans>:
80103080:	8b 0d 68 3c 11 80    	mov    0x80113c68,%ecx
80103086:	85 c9                	test   %ecx,%ecx
80103088:	0f 8e 8a 00 00 00    	jle    80103118 <install_trans+0x98>
8010308e:	55                   	push   %ebp
8010308f:	89 e5                	mov    %esp,%ebp
80103091:	57                   	push   %edi
80103092:	31 ff                	xor    %edi,%edi
80103094:	56                   	push   %esi
80103095:	53                   	push   %ebx
80103096:	83 ec 0c             	sub    $0xc,%esp
80103099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030a0:	a1 54 3c 11 80       	mov    0x80113c54,%eax
801030a5:	83 ec 08             	sub    $0x8,%esp
801030a8:	01 f8                	add    %edi,%eax
801030aa:	83 c0 01             	add    $0x1,%eax
801030ad:	50                   	push   %eax
801030ae:	ff 35 64 3c 11 80    	pushl  0x80113c64
801030b4:	e8 17 d0 ff ff       	call   801000d0 <bread>
801030b9:	89 c6                	mov    %eax,%esi
801030bb:	58                   	pop    %eax
801030bc:	5a                   	pop    %edx
801030bd:	ff 34 bd 6c 3c 11 80 	pushl  -0x7feec394(,%edi,4)
801030c4:	ff 35 64 3c 11 80    	pushl  0x80113c64
801030ca:	83 c7 01             	add    $0x1,%edi
801030cd:	e8 fe cf ff ff       	call   801000d0 <bread>
801030d2:	83 c4 0c             	add    $0xc,%esp
801030d5:	89 c3                	mov    %eax,%ebx
801030d7:	8d 46 5c             	lea    0x5c(%esi),%eax
801030da:	68 00 02 00 00       	push   $0x200
801030df:	50                   	push   %eax
801030e0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801030e3:	50                   	push   %eax
801030e4:	e8 17 1b 00 00       	call   80104c00 <memmove>
801030e9:	89 1c 24             	mov    %ebx,(%esp)
801030ec:	e8 bf d0 ff ff       	call   801001b0 <bwrite>
801030f1:	89 34 24             	mov    %esi,(%esp)
801030f4:	e8 f7 d0 ff ff       	call   801001f0 <brelse>
801030f9:	89 1c 24             	mov    %ebx,(%esp)
801030fc:	e8 ef d0 ff ff       	call   801001f0 <brelse>
80103101:	83 c4 10             	add    $0x10,%esp
80103104:	39 3d 68 3c 11 80    	cmp    %edi,0x80113c68
8010310a:	7f 94                	jg     801030a0 <install_trans+0x20>
8010310c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310f:	5b                   	pop    %ebx
80103110:	5e                   	pop    %esi
80103111:	5f                   	pop    %edi
80103112:	5d                   	pop    %ebp
80103113:	c3                   	ret    
80103114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103118:	c3                   	ret    
80103119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103120 <write_head>:
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	53                   	push   %ebx
80103124:	83 ec 0c             	sub    $0xc,%esp
80103127:	ff 35 54 3c 11 80    	pushl  0x80113c54
8010312d:	ff 35 64 3c 11 80    	pushl  0x80113c64
80103133:	e8 98 cf ff ff       	call   801000d0 <bread>
80103138:	83 c4 10             	add    $0x10,%esp
8010313b:	89 c3                	mov    %eax,%ebx
8010313d:	a1 68 3c 11 80       	mov    0x80113c68,%eax
80103142:	89 43 5c             	mov    %eax,0x5c(%ebx)
80103145:	85 c0                	test   %eax,%eax
80103147:	7e 19                	jle    80103162 <write_head+0x42>
80103149:	31 d2                	xor    %edx,%edx
8010314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010314f:	90                   	nop
80103150:	8b 0c 95 6c 3c 11 80 	mov    -0x7feec394(,%edx,4),%ecx
80103157:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010315b:	83 c2 01             	add    $0x1,%edx
8010315e:	39 d0                	cmp    %edx,%eax
80103160:	75 ee                	jne    80103150 <write_head+0x30>
80103162:	83 ec 0c             	sub    $0xc,%esp
80103165:	53                   	push   %ebx
80103166:	e8 45 d0 ff ff       	call   801001b0 <bwrite>
8010316b:	89 1c 24             	mov    %ebx,(%esp)
8010316e:	e8 7d d0 ff ff       	call   801001f0 <brelse>
80103173:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103176:	83 c4 10             	add    $0x10,%esp
80103179:	c9                   	leave  
8010317a:	c3                   	ret    
8010317b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010317f:	90                   	nop

80103180 <initlog>:
80103180:	f3 0f 1e fb          	endbr32 
80103184:	55                   	push   %ebp
80103185:	89 e5                	mov    %esp,%ebp
80103187:	53                   	push   %ebx
80103188:	83 ec 2c             	sub    $0x2c,%esp
8010318b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010318e:	68 e0 7a 10 80       	push   $0x80107ae0
80103193:	68 20 3c 11 80       	push   $0x80113c20
80103198:	e8 33 17 00 00       	call   801048d0 <initlock>
8010319d:	58                   	pop    %eax
8010319e:	8d 45 dc             	lea    -0x24(%ebp),%eax
801031a1:	5a                   	pop    %edx
801031a2:	50                   	push   %eax
801031a3:	53                   	push   %ebx
801031a4:	e8 47 e8 ff ff       	call   801019f0 <readsb>
801031a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031ac:	59                   	pop    %ecx
801031ad:	89 1d 64 3c 11 80    	mov    %ebx,0x80113c64
801031b3:	8b 55 e8             	mov    -0x18(%ebp),%edx
801031b6:	a3 54 3c 11 80       	mov    %eax,0x80113c54
801031bb:	89 15 58 3c 11 80    	mov    %edx,0x80113c58
801031c1:	5a                   	pop    %edx
801031c2:	50                   	push   %eax
801031c3:	53                   	push   %ebx
801031c4:	e8 07 cf ff ff       	call   801000d0 <bread>
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801031cf:	89 0d 68 3c 11 80    	mov    %ecx,0x80113c68
801031d5:	85 c9                	test   %ecx,%ecx
801031d7:	7e 19                	jle    801031f2 <initlog+0x72>
801031d9:	31 d2                	xor    %edx,%edx
801031db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031df:	90                   	nop
801031e0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801031e4:	89 1c 95 6c 3c 11 80 	mov    %ebx,-0x7feec394(,%edx,4)
801031eb:	83 c2 01             	add    $0x1,%edx
801031ee:	39 d1                	cmp    %edx,%ecx
801031f0:	75 ee                	jne    801031e0 <initlog+0x60>
801031f2:	83 ec 0c             	sub    $0xc,%esp
801031f5:	50                   	push   %eax
801031f6:	e8 f5 cf ff ff       	call   801001f0 <brelse>
801031fb:	e8 80 fe ff ff       	call   80103080 <install_trans>
80103200:	c7 05 68 3c 11 80 00 	movl   $0x0,0x80113c68
80103207:	00 00 00 
8010320a:	e8 11 ff ff ff       	call   80103120 <write_head>
8010320f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103212:	83 c4 10             	add    $0x10,%esp
80103215:	c9                   	leave  
80103216:	c3                   	ret    
80103217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010321e:	66 90                	xchg   %ax,%ax

80103220 <begin_op>:
80103220:	f3 0f 1e fb          	endbr32 
80103224:	55                   	push   %ebp
80103225:	89 e5                	mov    %esp,%ebp
80103227:	83 ec 14             	sub    $0x14,%esp
8010322a:	68 20 3c 11 80       	push   $0x80113c20
8010322f:	e8 1c 18 00 00       	call   80104a50 <acquire>
80103234:	83 c4 10             	add    $0x10,%esp
80103237:	eb 1c                	jmp    80103255 <begin_op+0x35>
80103239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103240:	83 ec 08             	sub    $0x8,%esp
80103243:	68 20 3c 11 80       	push   $0x80113c20
80103248:	68 20 3c 11 80       	push   $0x80113c20
8010324d:	e8 be 11 00 00       	call   80104410 <sleep>
80103252:	83 c4 10             	add    $0x10,%esp
80103255:	a1 60 3c 11 80       	mov    0x80113c60,%eax
8010325a:	85 c0                	test   %eax,%eax
8010325c:	75 e2                	jne    80103240 <begin_op+0x20>
8010325e:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
80103263:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
80103269:	83 c0 01             	add    $0x1,%eax
8010326c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010326f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103272:	83 fa 1e             	cmp    $0x1e,%edx
80103275:	7f c9                	jg     80103240 <begin_op+0x20>
80103277:	83 ec 0c             	sub    $0xc,%esp
8010327a:	a3 5c 3c 11 80       	mov    %eax,0x80113c5c
8010327f:	68 20 3c 11 80       	push   $0x80113c20
80103284:	e8 87 18 00 00       	call   80104b10 <release>
80103289:	83 c4 10             	add    $0x10,%esp
8010328c:	c9                   	leave  
8010328d:	c3                   	ret    
8010328e:	66 90                	xchg   %ax,%ax

80103290 <end_op>:
80103290:	f3 0f 1e fb          	endbr32 
80103294:	55                   	push   %ebp
80103295:	89 e5                	mov    %esp,%ebp
80103297:	57                   	push   %edi
80103298:	56                   	push   %esi
80103299:	53                   	push   %ebx
8010329a:	83 ec 18             	sub    $0x18,%esp
8010329d:	68 20 3c 11 80       	push   $0x80113c20
801032a2:	e8 a9 17 00 00       	call   80104a50 <acquire>
801032a7:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
801032ac:	8b 35 60 3c 11 80    	mov    0x80113c60,%esi
801032b2:	83 c4 10             	add    $0x10,%esp
801032b5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032b8:	89 1d 5c 3c 11 80    	mov    %ebx,0x80113c5c
801032be:	85 f6                	test   %esi,%esi
801032c0:	0f 85 1e 01 00 00    	jne    801033e4 <end_op+0x154>
801032c6:	85 db                	test   %ebx,%ebx
801032c8:	0f 85 f2 00 00 00    	jne    801033c0 <end_op+0x130>
801032ce:	c7 05 60 3c 11 80 01 	movl   $0x1,0x80113c60
801032d5:	00 00 00 
801032d8:	83 ec 0c             	sub    $0xc,%esp
801032db:	68 20 3c 11 80       	push   $0x80113c20
801032e0:	e8 2b 18 00 00       	call   80104b10 <release>
801032e5:	8b 0d 68 3c 11 80    	mov    0x80113c68,%ecx
801032eb:	83 c4 10             	add    $0x10,%esp
801032ee:	85 c9                	test   %ecx,%ecx
801032f0:	7f 3e                	jg     80103330 <end_op+0xa0>
801032f2:	83 ec 0c             	sub    $0xc,%esp
801032f5:	68 20 3c 11 80       	push   $0x80113c20
801032fa:	e8 51 17 00 00       	call   80104a50 <acquire>
801032ff:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
80103306:	c7 05 60 3c 11 80 00 	movl   $0x0,0x80113c60
8010330d:	00 00 00 
80103310:	e8 bb 12 00 00       	call   801045d0 <wakeup>
80103315:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
8010331c:	e8 ef 17 00 00       	call   80104b10 <release>
80103321:	83 c4 10             	add    $0x10,%esp
80103324:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103327:	5b                   	pop    %ebx
80103328:	5e                   	pop    %esi
80103329:	5f                   	pop    %edi
8010332a:	5d                   	pop    %ebp
8010332b:	c3                   	ret    
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103330:	a1 54 3c 11 80       	mov    0x80113c54,%eax
80103335:	83 ec 08             	sub    $0x8,%esp
80103338:	01 d8                	add    %ebx,%eax
8010333a:	83 c0 01             	add    $0x1,%eax
8010333d:	50                   	push   %eax
8010333e:	ff 35 64 3c 11 80    	pushl  0x80113c64
80103344:	e8 87 cd ff ff       	call   801000d0 <bread>
80103349:	89 c6                	mov    %eax,%esi
8010334b:	58                   	pop    %eax
8010334c:	5a                   	pop    %edx
8010334d:	ff 34 9d 6c 3c 11 80 	pushl  -0x7feec394(,%ebx,4)
80103354:	ff 35 64 3c 11 80    	pushl  0x80113c64
8010335a:	83 c3 01             	add    $0x1,%ebx
8010335d:	e8 6e cd ff ff       	call   801000d0 <bread>
80103362:	83 c4 0c             	add    $0xc,%esp
80103365:	89 c7                	mov    %eax,%edi
80103367:	8d 40 5c             	lea    0x5c(%eax),%eax
8010336a:	68 00 02 00 00       	push   $0x200
8010336f:	50                   	push   %eax
80103370:	8d 46 5c             	lea    0x5c(%esi),%eax
80103373:	50                   	push   %eax
80103374:	e8 87 18 00 00       	call   80104c00 <memmove>
80103379:	89 34 24             	mov    %esi,(%esp)
8010337c:	e8 2f ce ff ff       	call   801001b0 <bwrite>
80103381:	89 3c 24             	mov    %edi,(%esp)
80103384:	e8 67 ce ff ff       	call   801001f0 <brelse>
80103389:	89 34 24             	mov    %esi,(%esp)
8010338c:	e8 5f ce ff ff       	call   801001f0 <brelse>
80103391:	83 c4 10             	add    $0x10,%esp
80103394:	3b 1d 68 3c 11 80    	cmp    0x80113c68,%ebx
8010339a:	7c 94                	jl     80103330 <end_op+0xa0>
8010339c:	e8 7f fd ff ff       	call   80103120 <write_head>
801033a1:	e8 da fc ff ff       	call   80103080 <install_trans>
801033a6:	c7 05 68 3c 11 80 00 	movl   $0x0,0x80113c68
801033ad:	00 00 00 
801033b0:	e8 6b fd ff ff       	call   80103120 <write_head>
801033b5:	e9 38 ff ff ff       	jmp    801032f2 <end_op+0x62>
801033ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	68 20 3c 11 80       	push   $0x80113c20
801033c8:	e8 03 12 00 00       	call   801045d0 <wakeup>
801033cd:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
801033d4:	e8 37 17 00 00       	call   80104b10 <release>
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033df:	5b                   	pop    %ebx
801033e0:	5e                   	pop    %esi
801033e1:	5f                   	pop    %edi
801033e2:	5d                   	pop    %ebp
801033e3:	c3                   	ret    
801033e4:	83 ec 0c             	sub    $0xc,%esp
801033e7:	68 e4 7a 10 80       	push   $0x80107ae4
801033ec:	e8 9f cf ff ff       	call   80100390 <panic>
801033f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ff:	90                   	nop

80103400 <log_write>:
80103400:	f3 0f 1e fb          	endbr32 
80103404:	55                   	push   %ebp
80103405:	89 e5                	mov    %esp,%ebp
80103407:	53                   	push   %ebx
80103408:	83 ec 04             	sub    $0x4,%esp
8010340b:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
80103411:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103414:	83 fa 1d             	cmp    $0x1d,%edx
80103417:	0f 8f 91 00 00 00    	jg     801034ae <log_write+0xae>
8010341d:	a1 58 3c 11 80       	mov    0x80113c58,%eax
80103422:	83 e8 01             	sub    $0x1,%eax
80103425:	39 c2                	cmp    %eax,%edx
80103427:	0f 8d 81 00 00 00    	jge    801034ae <log_write+0xae>
8010342d:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
80103432:	85 c0                	test   %eax,%eax
80103434:	0f 8e 81 00 00 00    	jle    801034bb <log_write+0xbb>
8010343a:	83 ec 0c             	sub    $0xc,%esp
8010343d:	68 20 3c 11 80       	push   $0x80113c20
80103442:	e8 09 16 00 00       	call   80104a50 <acquire>
80103447:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
8010344d:	83 c4 10             	add    $0x10,%esp
80103450:	85 d2                	test   %edx,%edx
80103452:	7e 4e                	jle    801034a2 <log_write+0xa2>
80103454:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103457:	31 c0                	xor    %eax,%eax
80103459:	eb 0c                	jmp    80103467 <log_write+0x67>
8010345b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010345f:	90                   	nop
80103460:	83 c0 01             	add    $0x1,%eax
80103463:	39 c2                	cmp    %eax,%edx
80103465:	74 29                	je     80103490 <log_write+0x90>
80103467:	39 0c 85 6c 3c 11 80 	cmp    %ecx,-0x7feec394(,%eax,4)
8010346e:	75 f0                	jne    80103460 <log_write+0x60>
80103470:	89 0c 85 6c 3c 11 80 	mov    %ecx,-0x7feec394(,%eax,4)
80103477:	83 0b 04             	orl    $0x4,(%ebx)
8010347a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010347d:	c7 45 08 20 3c 11 80 	movl   $0x80113c20,0x8(%ebp)
80103484:	c9                   	leave  
80103485:	e9 86 16 00 00       	jmp    80104b10 <release>
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103490:	89 0c 95 6c 3c 11 80 	mov    %ecx,-0x7feec394(,%edx,4)
80103497:	83 c2 01             	add    $0x1,%edx
8010349a:	89 15 68 3c 11 80    	mov    %edx,0x80113c68
801034a0:	eb d5                	jmp    80103477 <log_write+0x77>
801034a2:	8b 43 08             	mov    0x8(%ebx),%eax
801034a5:	a3 6c 3c 11 80       	mov    %eax,0x80113c6c
801034aa:	75 cb                	jne    80103477 <log_write+0x77>
801034ac:	eb e9                	jmp    80103497 <log_write+0x97>
801034ae:	83 ec 0c             	sub    $0xc,%esp
801034b1:	68 f3 7a 10 80       	push   $0x80107af3
801034b6:	e8 d5 ce ff ff       	call   80100390 <panic>
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	68 09 7b 10 80       	push   $0x80107b09
801034c3:	e8 c8 ce ff ff       	call   80100390 <panic>
801034c8:	66 90                	xchg   %ax,%ax
801034ca:	66 90                	xchg   %ax,%ax
801034cc:	66 90                	xchg   %ax,%ax
801034ce:	66 90                	xchg   %ax,%ax

801034d0 <mpmain>:
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	53                   	push   %ebx
801034d4:	83 ec 04             	sub    $0x4,%esp
801034d7:	e8 54 09 00 00       	call   80103e30 <cpuid>
801034dc:	89 c3                	mov    %eax,%ebx
801034de:	e8 4d 09 00 00       	call   80103e30 <cpuid>
801034e3:	83 ec 04             	sub    $0x4,%esp
801034e6:	53                   	push   %ebx
801034e7:	50                   	push   %eax
801034e8:	68 24 7b 10 80       	push   $0x80107b24
801034ed:	e8 ce d3 ff ff       	call   801008c0 <cprintf>
801034f2:	e8 19 29 00 00       	call   80105e10 <idtinit>
801034f7:	e8 c4 08 00 00       	call   80103dc0 <mycpu>
801034fc:	89 c2                	mov    %eax,%edx
801034fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103503:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
8010350a:	e8 11 0c 00 00       	call   80104120 <scheduler>
8010350f:	90                   	nop

80103510 <mpenter>:
80103510:	f3 0f 1e fb          	endbr32 
80103514:	55                   	push   %ebp
80103515:	89 e5                	mov    %esp,%ebp
80103517:	83 ec 08             	sub    $0x8,%esp
8010351a:	e8 c1 39 00 00       	call   80106ee0 <switchkvm>
8010351f:	e8 2c 39 00 00       	call   80106e50 <seginit>
80103524:	e8 67 f7 ff ff       	call   80102c90 <lapicinit>
80103529:	e8 a2 ff ff ff       	call   801034d0 <mpmain>
8010352e:	66 90                	xchg   %ax,%ax

80103530 <main>:
80103530:	f3 0f 1e fb          	endbr32 
80103534:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103538:	83 e4 f0             	and    $0xfffffff0,%esp
8010353b:	ff 71 fc             	pushl  -0x4(%ecx)
8010353e:	55                   	push   %ebp
8010353f:	89 e5                	mov    %esp,%ebp
80103541:	53                   	push   %ebx
80103542:	51                   	push   %ecx
80103543:	83 ec 08             	sub    $0x8,%esp
80103546:	68 00 00 40 80       	push   $0x80400000
8010354b:	68 48 6a 11 80       	push   $0x80116a48
80103550:	e8 fb f4 ff ff       	call   80102a50 <kinit1>
80103555:	e8 66 3e 00 00       	call   801073c0 <kvmalloc>
8010355a:	e8 81 01 00 00       	call   801036e0 <mpinit>
8010355f:	e8 2c f7 ff ff       	call   80102c90 <lapicinit>
80103564:	e8 e7 38 00 00       	call   80106e50 <seginit>
80103569:	e8 52 03 00 00       	call   801038c0 <picinit>
8010356e:	e8 fd f2 ff ff       	call   80102870 <ioapicinit>
80103573:	e8 a8 d9 ff ff       	call   80100f20 <consoleinit>
80103578:	e8 93 2b 00 00       	call   80106110 <uartinit>
8010357d:	e8 1e 08 00 00       	call   80103da0 <pinit>
80103582:	e8 09 28 00 00       	call   80105d90 <tvinit>
80103587:	e8 b4 ca ff ff       	call   80100040 <binit>
8010358c:	e8 3f dd ff ff       	call   801012d0 <fileinit>
80103591:	e8 aa f0 ff ff       	call   80102640 <ideinit>
80103596:	83 c4 0c             	add    $0xc,%esp
80103599:	68 8a 00 00 00       	push   $0x8a
8010359e:	68 8c b4 10 80       	push   $0x8010b48c
801035a3:	68 00 70 00 80       	push   $0x80007000
801035a8:	e8 53 16 00 00       	call   80104c00 <memmove>
801035ad:	83 c4 10             	add    $0x10,%esp
801035b0:	69 05 a0 42 11 80 b0 	imul   $0xb0,0x801142a0,%eax
801035b7:	00 00 00 
801035ba:	05 20 3d 11 80       	add    $0x80113d20,%eax
801035bf:	3d 20 3d 11 80       	cmp    $0x80113d20,%eax
801035c4:	76 7a                	jbe    80103640 <main+0x110>
801035c6:	bb 20 3d 11 80       	mov    $0x80113d20,%ebx
801035cb:	eb 1c                	jmp    801035e9 <main+0xb9>
801035cd:	8d 76 00             	lea    0x0(%esi),%esi
801035d0:	69 05 a0 42 11 80 b0 	imul   $0xb0,0x801142a0,%eax
801035d7:	00 00 00 
801035da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035e0:	05 20 3d 11 80       	add    $0x80113d20,%eax
801035e5:	39 c3                	cmp    %eax,%ebx
801035e7:	73 57                	jae    80103640 <main+0x110>
801035e9:	e8 d2 07 00 00       	call   80103dc0 <mycpu>
801035ee:	39 c3                	cmp    %eax,%ebx
801035f0:	74 de                	je     801035d0 <main+0xa0>
801035f2:	e8 29 f5 ff ff       	call   80102b20 <kalloc>
801035f7:	83 ec 08             	sub    $0x8,%esp
801035fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103510,0x80006ff8
80103601:	35 10 80 
80103604:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010360b:	a0 10 00 
8010360e:	05 00 10 00 00       	add    $0x1000,%eax
80103613:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80103618:	0f b6 03             	movzbl (%ebx),%eax
8010361b:	68 00 70 00 00       	push   $0x7000
80103620:	50                   	push   %eax
80103621:	e8 ba f7 ff ff       	call   80102de0 <lapicstartap>
80103626:	83 c4 10             	add    $0x10,%esp
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103630:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103636:	85 c0                	test   %eax,%eax
80103638:	74 f6                	je     80103630 <main+0x100>
8010363a:	eb 94                	jmp    801035d0 <main+0xa0>
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103640:	83 ec 08             	sub    $0x8,%esp
80103643:	68 00 00 00 8e       	push   $0x8e000000
80103648:	68 00 00 40 80       	push   $0x80400000
8010364d:	e8 6e f4 ff ff       	call   80102ac0 <kinit2>
80103652:	e8 29 08 00 00       	call   80103e80 <userinit>
80103657:	e8 74 fe ff ff       	call   801034d0 <mpmain>
8010365c:	66 90                	xchg   %ax,%ax
8010365e:	66 90                	xchg   %ax,%ax

80103660 <mpsearch1>:
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	57                   	push   %edi
80103664:	56                   	push   %esi
80103665:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010366b:	53                   	push   %ebx
8010366c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	39 de                	cmp    %ebx,%esi
80103674:	72 10                	jb     80103686 <mpsearch1+0x26>
80103676:	eb 50                	jmp    801036c8 <mpsearch1+0x68>
80103678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010367f:	90                   	nop
80103680:	89 fe                	mov    %edi,%esi
80103682:	39 fb                	cmp    %edi,%ebx
80103684:	76 42                	jbe    801036c8 <mpsearch1+0x68>
80103686:	83 ec 04             	sub    $0x4,%esp
80103689:	8d 7e 10             	lea    0x10(%esi),%edi
8010368c:	6a 04                	push   $0x4
8010368e:	68 38 7b 10 80       	push   $0x80107b38
80103693:	56                   	push   %esi
80103694:	e8 17 15 00 00       	call   80104bb0 <memcmp>
80103699:	83 c4 10             	add    $0x10,%esp
8010369c:	85 c0                	test   %eax,%eax
8010369e:	75 e0                	jne    80103680 <mpsearch1+0x20>
801036a0:	89 f2                	mov    %esi,%edx
801036a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036a8:	0f b6 0a             	movzbl (%edx),%ecx
801036ab:	83 c2 01             	add    $0x1,%edx
801036ae:	01 c8                	add    %ecx,%eax
801036b0:	39 fa                	cmp    %edi,%edx
801036b2:	75 f4                	jne    801036a8 <mpsearch1+0x48>
801036b4:	84 c0                	test   %al,%al
801036b6:	75 c8                	jne    80103680 <mpsearch1+0x20>
801036b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036bb:	89 f0                	mov    %esi,%eax
801036bd:	5b                   	pop    %ebx
801036be:	5e                   	pop    %esi
801036bf:	5f                   	pop    %edi
801036c0:	5d                   	pop    %ebp
801036c1:	c3                   	ret    
801036c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036cb:	31 f6                	xor    %esi,%esi
801036cd:	5b                   	pop    %ebx
801036ce:	89 f0                	mov    %esi,%eax
801036d0:	5e                   	pop    %esi
801036d1:	5f                   	pop    %edi
801036d2:	5d                   	pop    %ebp
801036d3:	c3                   	ret    
801036d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036df:	90                   	nop

801036e0 <mpinit>:
801036e0:	f3 0f 1e fb          	endbr32 
801036e4:	55                   	push   %ebp
801036e5:	89 e5                	mov    %esp,%ebp
801036e7:	57                   	push   %edi
801036e8:	56                   	push   %esi
801036e9:	53                   	push   %ebx
801036ea:	83 ec 1c             	sub    $0x1c,%esp
801036ed:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801036f4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801036fb:	c1 e0 08             	shl    $0x8,%eax
801036fe:	09 d0                	or     %edx,%eax
80103700:	c1 e0 04             	shl    $0x4,%eax
80103703:	75 1b                	jne    80103720 <mpinit+0x40>
80103705:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010370c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103713:	c1 e0 08             	shl    $0x8,%eax
80103716:	09 d0                	or     %edx,%eax
80103718:	c1 e0 0a             	shl    $0xa,%eax
8010371b:	2d 00 04 00 00       	sub    $0x400,%eax
80103720:	ba 00 04 00 00       	mov    $0x400,%edx
80103725:	e8 36 ff ff ff       	call   80103660 <mpsearch1>
8010372a:	89 c6                	mov    %eax,%esi
8010372c:	85 c0                	test   %eax,%eax
8010372e:	0f 84 4c 01 00 00    	je     80103880 <mpinit+0x1a0>
80103734:	8b 5e 04             	mov    0x4(%esi),%ebx
80103737:	85 db                	test   %ebx,%ebx
80103739:	0f 84 61 01 00 00    	je     801038a0 <mpinit+0x1c0>
8010373f:	83 ec 04             	sub    $0x4,%esp
80103742:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103748:	6a 04                	push   $0x4
8010374a:	68 3d 7b 10 80       	push   $0x80107b3d
8010374f:	50                   	push   %eax
80103750:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103753:	e8 58 14 00 00       	call   80104bb0 <memcmp>
80103758:	83 c4 10             	add    $0x10,%esp
8010375b:	85 c0                	test   %eax,%eax
8010375d:	0f 85 3d 01 00 00    	jne    801038a0 <mpinit+0x1c0>
80103763:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010376a:	3c 01                	cmp    $0x1,%al
8010376c:	74 08                	je     80103776 <mpinit+0x96>
8010376e:	3c 04                	cmp    $0x4,%al
80103770:	0f 85 2a 01 00 00    	jne    801038a0 <mpinit+0x1c0>
80103776:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010377d:	66 85 d2             	test   %dx,%dx
80103780:	74 26                	je     801037a8 <mpinit+0xc8>
80103782:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103785:	89 d8                	mov    %ebx,%eax
80103787:	31 d2                	xor    %edx,%edx
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103790:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103797:	83 c0 01             	add    $0x1,%eax
8010379a:	01 ca                	add    %ecx,%edx
8010379c:	39 f8                	cmp    %edi,%eax
8010379e:	75 f0                	jne    80103790 <mpinit+0xb0>
801037a0:	84 d2                	test   %dl,%dl
801037a2:	0f 85 f8 00 00 00    	jne    801038a0 <mpinit+0x1c0>
801037a8:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801037ae:	a3 1c 3c 11 80       	mov    %eax,0x80113c1c
801037b3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801037b9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801037c0:	bb 01 00 00 00       	mov    $0x1,%ebx
801037c5:	03 55 e4             	add    -0x1c(%ebp),%edx
801037c8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
801037d0:	39 c2                	cmp    %eax,%edx
801037d2:	76 15                	jbe    801037e9 <mpinit+0x109>
801037d4:	0f b6 08             	movzbl (%eax),%ecx
801037d7:	80 f9 02             	cmp    $0x2,%cl
801037da:	74 5c                	je     80103838 <mpinit+0x158>
801037dc:	77 42                	ja     80103820 <mpinit+0x140>
801037de:	84 c9                	test   %cl,%cl
801037e0:	74 6e                	je     80103850 <mpinit+0x170>
801037e2:	83 c0 08             	add    $0x8,%eax
801037e5:	39 c2                	cmp    %eax,%edx
801037e7:	77 eb                	ja     801037d4 <mpinit+0xf4>
801037e9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801037ec:	85 db                	test   %ebx,%ebx
801037ee:	0f 84 b9 00 00 00    	je     801038ad <mpinit+0x1cd>
801037f4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801037f8:	74 15                	je     8010380f <mpinit+0x12f>
801037fa:	b8 70 00 00 00       	mov    $0x70,%eax
801037ff:	ba 22 00 00 00       	mov    $0x22,%edx
80103804:	ee                   	out    %al,(%dx)
80103805:	ba 23 00 00 00       	mov    $0x23,%edx
8010380a:	ec                   	in     (%dx),%al
8010380b:	83 c8 01             	or     $0x1,%eax
8010380e:	ee                   	out    %al,(%dx)
8010380f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103812:	5b                   	pop    %ebx
80103813:	5e                   	pop    %esi
80103814:	5f                   	pop    %edi
80103815:	5d                   	pop    %ebp
80103816:	c3                   	ret    
80103817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010381e:	66 90                	xchg   %ax,%ax
80103820:	83 e9 03             	sub    $0x3,%ecx
80103823:	80 f9 01             	cmp    $0x1,%cl
80103826:	76 ba                	jbe    801037e2 <mpinit+0x102>
80103828:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010382f:	eb 9f                	jmp    801037d0 <mpinit+0xf0>
80103831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103838:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
8010383c:	83 c0 08             	add    $0x8,%eax
8010383f:	88 0d 00 3d 11 80    	mov    %cl,0x80113d00
80103845:	eb 89                	jmp    801037d0 <mpinit+0xf0>
80103847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010384e:	66 90                	xchg   %ax,%ax
80103850:	8b 0d a0 42 11 80    	mov    0x801142a0,%ecx
80103856:	83 f9 07             	cmp    $0x7,%ecx
80103859:	7f 19                	jg     80103874 <mpinit+0x194>
8010385b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103861:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103865:	83 c1 01             	add    $0x1,%ecx
80103868:	89 0d a0 42 11 80    	mov    %ecx,0x801142a0
8010386e:	88 9f 20 3d 11 80    	mov    %bl,-0x7feec2e0(%edi)
80103874:	83 c0 14             	add    $0x14,%eax
80103877:	e9 54 ff ff ff       	jmp    801037d0 <mpinit+0xf0>
8010387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103880:	ba 00 00 01 00       	mov    $0x10000,%edx
80103885:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010388a:	e8 d1 fd ff ff       	call   80103660 <mpsearch1>
8010388f:	89 c6                	mov    %eax,%esi
80103891:	85 c0                	test   %eax,%eax
80103893:	0f 85 9b fe ff ff    	jne    80103734 <mpinit+0x54>
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038a0:	83 ec 0c             	sub    $0xc,%esp
801038a3:	68 42 7b 10 80       	push   $0x80107b42
801038a8:	e8 e3 ca ff ff       	call   80100390 <panic>
801038ad:	83 ec 0c             	sub    $0xc,%esp
801038b0:	68 5c 7b 10 80       	push   $0x80107b5c
801038b5:	e8 d6 ca ff ff       	call   80100390 <panic>
801038ba:	66 90                	xchg   %ax,%ax
801038bc:	66 90                	xchg   %ax,%ax
801038be:	66 90                	xchg   %ax,%ax

801038c0 <picinit>:
801038c0:	f3 0f 1e fb          	endbr32 
801038c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038c9:	ba 21 00 00 00       	mov    $0x21,%edx
801038ce:	ee                   	out    %al,(%dx)
801038cf:	ba a1 00 00 00       	mov    $0xa1,%edx
801038d4:	ee                   	out    %al,(%dx)
801038d5:	c3                   	ret    
801038d6:	66 90                	xchg   %ax,%ax
801038d8:	66 90                	xchg   %ax,%ax
801038da:	66 90                	xchg   %ax,%ax
801038dc:	66 90                	xchg   %ax,%ax
801038de:	66 90                	xchg   %ax,%ax

801038e0 <pipealloc>:
801038e0:	f3 0f 1e fb          	endbr32 
801038e4:	55                   	push   %ebp
801038e5:	89 e5                	mov    %esp,%ebp
801038e7:	57                   	push   %edi
801038e8:	56                   	push   %esi
801038e9:	53                   	push   %ebx
801038ea:	83 ec 0c             	sub    $0xc,%esp
801038ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038f0:	8b 75 0c             	mov    0xc(%ebp),%esi
801038f3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038f9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801038ff:	e8 ec d9 ff ff       	call   801012f0 <filealloc>
80103904:	89 03                	mov    %eax,(%ebx)
80103906:	85 c0                	test   %eax,%eax
80103908:	0f 84 ac 00 00 00    	je     801039ba <pipealloc+0xda>
8010390e:	e8 dd d9 ff ff       	call   801012f0 <filealloc>
80103913:	89 06                	mov    %eax,(%esi)
80103915:	85 c0                	test   %eax,%eax
80103917:	0f 84 8b 00 00 00    	je     801039a8 <pipealloc+0xc8>
8010391d:	e8 fe f1 ff ff       	call   80102b20 <kalloc>
80103922:	89 c7                	mov    %eax,%edi
80103924:	85 c0                	test   %eax,%eax
80103926:	0f 84 b4 00 00 00    	je     801039e0 <pipealloc+0x100>
8010392c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103933:	00 00 00 
80103936:	83 ec 08             	sub    $0x8,%esp
80103939:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103940:	00 00 00 
80103943:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010394a:	00 00 00 
8010394d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103954:	00 00 00 
80103957:	68 7b 7b 10 80       	push   $0x80107b7b
8010395c:	50                   	push   %eax
8010395d:	e8 6e 0f 00 00       	call   801048d0 <initlock>
80103962:	8b 03                	mov    (%ebx),%eax
80103964:	83 c4 10             	add    $0x10,%esp
80103967:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
8010396d:	8b 03                	mov    (%ebx),%eax
8010396f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103973:	8b 03                	mov    (%ebx),%eax
80103975:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103979:	8b 03                	mov    (%ebx),%eax
8010397b:	89 78 0c             	mov    %edi,0xc(%eax)
8010397e:	8b 06                	mov    (%esi),%eax
80103980:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103986:	8b 06                	mov    (%esi),%eax
80103988:	c6 40 08 00          	movb   $0x0,0x8(%eax)
8010398c:	8b 06                	mov    (%esi),%eax
8010398e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103992:	8b 06                	mov    (%esi),%eax
80103994:	89 78 0c             	mov    %edi,0xc(%eax)
80103997:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010399a:	31 c0                	xor    %eax,%eax
8010399c:	5b                   	pop    %ebx
8010399d:	5e                   	pop    %esi
8010399e:	5f                   	pop    %edi
8010399f:	5d                   	pop    %ebp
801039a0:	c3                   	ret    
801039a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039a8:	8b 03                	mov    (%ebx),%eax
801039aa:	85 c0                	test   %eax,%eax
801039ac:	74 1e                	je     801039cc <pipealloc+0xec>
801039ae:	83 ec 0c             	sub    $0xc,%esp
801039b1:	50                   	push   %eax
801039b2:	e8 f9 d9 ff ff       	call   801013b0 <fileclose>
801039b7:	83 c4 10             	add    $0x10,%esp
801039ba:	8b 06                	mov    (%esi),%eax
801039bc:	85 c0                	test   %eax,%eax
801039be:	74 0c                	je     801039cc <pipealloc+0xec>
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	50                   	push   %eax
801039c4:	e8 e7 d9 ff ff       	call   801013b0 <fileclose>
801039c9:	83 c4 10             	add    $0x10,%esp
801039cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039d4:	5b                   	pop    %ebx
801039d5:	5e                   	pop    %esi
801039d6:	5f                   	pop    %edi
801039d7:	5d                   	pop    %ebp
801039d8:	c3                   	ret    
801039d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039e0:	8b 03                	mov    (%ebx),%eax
801039e2:	85 c0                	test   %eax,%eax
801039e4:	75 c8                	jne    801039ae <pipealloc+0xce>
801039e6:	eb d2                	jmp    801039ba <pipealloc+0xda>
801039e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039ef:	90                   	nop

801039f0 <pipeclose>:
801039f0:	f3 0f 1e fb          	endbr32 
801039f4:	55                   	push   %ebp
801039f5:	89 e5                	mov    %esp,%ebp
801039f7:	56                   	push   %esi
801039f8:	53                   	push   %ebx
801039f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039fc:	8b 75 0c             	mov    0xc(%ebp),%esi
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	53                   	push   %ebx
80103a03:	e8 48 10 00 00       	call   80104a50 <acquire>
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	85 f6                	test   %esi,%esi
80103a0d:	74 41                	je     80103a50 <pipeclose+0x60>
80103a0f:	83 ec 0c             	sub    $0xc,%esp
80103a12:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a18:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a1f:	00 00 00 
80103a22:	50                   	push   %eax
80103a23:	e8 a8 0b 00 00       	call   801045d0 <wakeup>
80103a28:	83 c4 10             	add    $0x10,%esp
80103a2b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a31:	85 d2                	test   %edx,%edx
80103a33:	75 0a                	jne    80103a3f <pipeclose+0x4f>
80103a35:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a3b:	85 c0                	test   %eax,%eax
80103a3d:	74 31                	je     80103a70 <pipeclose+0x80>
80103a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a45:	5b                   	pop    %ebx
80103a46:	5e                   	pop    %esi
80103a47:	5d                   	pop    %ebp
80103a48:	e9 c3 10 00 00       	jmp    80104b10 <release>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
80103a50:	83 ec 0c             	sub    $0xc,%esp
80103a53:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103a59:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a60:	00 00 00 
80103a63:	50                   	push   %eax
80103a64:	e8 67 0b 00 00       	call   801045d0 <wakeup>
80103a69:	83 c4 10             	add    $0x10,%esp
80103a6c:	eb bd                	jmp    80103a2b <pipeclose+0x3b>
80103a6e:	66 90                	xchg   %ax,%ax
80103a70:	83 ec 0c             	sub    $0xc,%esp
80103a73:	53                   	push   %ebx
80103a74:	e8 97 10 00 00       	call   80104b10 <release>
80103a79:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a7c:	83 c4 10             	add    $0x10,%esp
80103a7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a82:	5b                   	pop    %ebx
80103a83:	5e                   	pop    %esi
80103a84:	5d                   	pop    %ebp
80103a85:	e9 d6 ee ff ff       	jmp    80102960 <kfree>
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a90 <pipewrite>:
80103a90:	f3 0f 1e fb          	endbr32 
80103a94:	55                   	push   %ebp
80103a95:	89 e5                	mov    %esp,%ebp
80103a97:	57                   	push   %edi
80103a98:	56                   	push   %esi
80103a99:	53                   	push   %ebx
80103a9a:	83 ec 28             	sub    $0x28,%esp
80103a9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103aa0:	53                   	push   %ebx
80103aa1:	e8 aa 0f 00 00       	call   80104a50 <acquire>
80103aa6:	8b 45 10             	mov    0x10(%ebp),%eax
80103aa9:	83 c4 10             	add    $0x10,%esp
80103aac:	85 c0                	test   %eax,%eax
80103aae:	0f 8e bc 00 00 00    	jle    80103b70 <pipewrite+0xe0>
80103ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ab7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
80103abd:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103ac3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ac6:	03 45 10             	add    0x10(%ebp),%eax
80103ac9:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103acc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103ad2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103ad8:	89 ca                	mov    %ecx,%edx
80103ada:	05 00 02 00 00       	add    $0x200,%eax
80103adf:	39 c1                	cmp    %eax,%ecx
80103ae1:	74 3b                	je     80103b1e <pipewrite+0x8e>
80103ae3:	eb 63                	jmp    80103b48 <pipewrite+0xb8>
80103ae5:	8d 76 00             	lea    0x0(%esi),%esi
80103ae8:	e8 63 03 00 00       	call   80103e50 <myproc>
80103aed:	8b 48 24             	mov    0x24(%eax),%ecx
80103af0:	85 c9                	test   %ecx,%ecx
80103af2:	75 34                	jne    80103b28 <pipewrite+0x98>
80103af4:	83 ec 0c             	sub    $0xc,%esp
80103af7:	57                   	push   %edi
80103af8:	e8 d3 0a 00 00       	call   801045d0 <wakeup>
80103afd:	58                   	pop    %eax
80103afe:	5a                   	pop    %edx
80103aff:	53                   	push   %ebx
80103b00:	56                   	push   %esi
80103b01:	e8 0a 09 00 00       	call   80104410 <sleep>
80103b06:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b0c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b12:	83 c4 10             	add    $0x10,%esp
80103b15:	05 00 02 00 00       	add    $0x200,%eax
80103b1a:	39 c2                	cmp    %eax,%edx
80103b1c:	75 2a                	jne    80103b48 <pipewrite+0xb8>
80103b1e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b24:	85 c0                	test   %eax,%eax
80103b26:	75 c0                	jne    80103ae8 <pipewrite+0x58>
80103b28:	83 ec 0c             	sub    $0xc,%esp
80103b2b:	53                   	push   %ebx
80103b2c:	e8 df 0f 00 00       	call   80104b10 <release>
80103b31:	83 c4 10             	add    $0x10,%esp
80103b34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b3c:	5b                   	pop    %ebx
80103b3d:	5e                   	pop    %esi
80103b3e:	5f                   	pop    %edi
80103b3f:	5d                   	pop    %ebp
80103b40:	c3                   	ret    
80103b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b48:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b4b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b4e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b54:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103b5a:	0f b6 06             	movzbl (%esi),%eax
80103b5d:	83 c6 01             	add    $0x1,%esi
80103b60:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103b63:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80103b67:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b6a:	0f 85 5c ff ff ff    	jne    80103acc <pipewrite+0x3c>
80103b70:	83 ec 0c             	sub    $0xc,%esp
80103b73:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b79:	50                   	push   %eax
80103b7a:	e8 51 0a 00 00       	call   801045d0 <wakeup>
80103b7f:	89 1c 24             	mov    %ebx,(%esp)
80103b82:	e8 89 0f 00 00       	call   80104b10 <release>
80103b87:	8b 45 10             	mov    0x10(%ebp),%eax
80103b8a:	83 c4 10             	add    $0x10,%esp
80103b8d:	eb aa                	jmp    80103b39 <pipewrite+0xa9>
80103b8f:	90                   	nop

80103b90 <piperead>:
80103b90:	f3 0f 1e fb          	endbr32 
80103b94:	55                   	push   %ebp
80103b95:	89 e5                	mov    %esp,%ebp
80103b97:	57                   	push   %edi
80103b98:	56                   	push   %esi
80103b99:	53                   	push   %ebx
80103b9a:	83 ec 18             	sub    $0x18,%esp
80103b9d:	8b 75 08             	mov    0x8(%ebp),%esi
80103ba0:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103ba3:	56                   	push   %esi
80103ba4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103baa:	e8 a1 0e 00 00       	call   80104a50 <acquire>
80103baf:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103bb5:	83 c4 10             	add    $0x10,%esp
80103bb8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bbe:	74 33                	je     80103bf3 <piperead+0x63>
80103bc0:	eb 3b                	jmp    80103bfd <piperead+0x6d>
80103bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bc8:	e8 83 02 00 00       	call   80103e50 <myproc>
80103bcd:	8b 48 24             	mov    0x24(%eax),%ecx
80103bd0:	85 c9                	test   %ecx,%ecx
80103bd2:	0f 85 88 00 00 00    	jne    80103c60 <piperead+0xd0>
80103bd8:	83 ec 08             	sub    $0x8,%esp
80103bdb:	56                   	push   %esi
80103bdc:	53                   	push   %ebx
80103bdd:	e8 2e 08 00 00       	call   80104410 <sleep>
80103be2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103be8:	83 c4 10             	add    $0x10,%esp
80103beb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103bf1:	75 0a                	jne    80103bfd <piperead+0x6d>
80103bf3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103bf9:	85 c0                	test   %eax,%eax
80103bfb:	75 cb                	jne    80103bc8 <piperead+0x38>
80103bfd:	8b 55 10             	mov    0x10(%ebp),%edx
80103c00:	31 db                	xor    %ebx,%ebx
80103c02:	85 d2                	test   %edx,%edx
80103c04:	7f 28                	jg     80103c2e <piperead+0x9e>
80103c06:	eb 34                	jmp    80103c3c <piperead+0xac>
80103c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c0f:	90                   	nop
80103c10:	8d 48 01             	lea    0x1(%eax),%ecx
80103c13:	25 ff 01 00 00       	and    $0x1ff,%eax
80103c18:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103c1e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103c23:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103c26:	83 c3 01             	add    $0x1,%ebx
80103c29:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c2c:	74 0e                	je     80103c3c <piperead+0xac>
80103c2e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c34:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c3a:	75 d4                	jne    80103c10 <piperead+0x80>
80103c3c:	83 ec 0c             	sub    $0xc,%esp
80103c3f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c45:	50                   	push   %eax
80103c46:	e8 85 09 00 00       	call   801045d0 <wakeup>
80103c4b:	89 34 24             	mov    %esi,(%esp)
80103c4e:	e8 bd 0e 00 00       	call   80104b10 <release>
80103c53:	83 c4 10             	add    $0x10,%esp
80103c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c59:	89 d8                	mov    %ebx,%eax
80103c5b:	5b                   	pop    %ebx
80103c5c:	5e                   	pop    %esi
80103c5d:	5f                   	pop    %edi
80103c5e:	5d                   	pop    %ebp
80103c5f:	c3                   	ret    
80103c60:	83 ec 0c             	sub    $0xc,%esp
80103c63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c68:	56                   	push   %esi
80103c69:	e8 a2 0e 00 00       	call   80104b10 <release>
80103c6e:	83 c4 10             	add    $0x10,%esp
80103c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c74:	89 d8                	mov    %ebx,%eax
80103c76:	5b                   	pop    %ebx
80103c77:	5e                   	pop    %esi
80103c78:	5f                   	pop    %edi
80103c79:	5d                   	pop    %ebp
80103c7a:	c3                   	ret    
80103c7b:	66 90                	xchg   %ax,%ax
80103c7d:	66 90                	xchg   %ax,%ax
80103c7f:	90                   	nop

80103c80 <allocproc>:
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
80103c84:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
80103c89:	83 ec 10             	sub    $0x10,%esp
80103c8c:	68 c0 42 11 80       	push   $0x801142c0
80103c91:	e8 ba 0d 00 00       	call   80104a50 <acquire>
80103c96:	83 c4 10             	add    $0x10,%esp
80103c99:	eb 10                	jmp    80103cab <allocproc+0x2b>
80103c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop
80103ca0:	83 c3 7c             	add    $0x7c,%ebx
80103ca3:	81 fb f4 61 11 80    	cmp    $0x801161f4,%ebx
80103ca9:	74 75                	je     80103d20 <allocproc+0xa0>
80103cab:	8b 43 0c             	mov    0xc(%ebx),%eax
80103cae:	85 c0                	test   %eax,%eax
80103cb0:	75 ee                	jne    80103ca0 <allocproc+0x20>
80103cb2:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103cb7:	83 ec 0c             	sub    $0xc,%esp
80103cba:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80103cc1:	89 43 10             	mov    %eax,0x10(%ebx)
80103cc4:	8d 50 01             	lea    0x1(%eax),%edx
80103cc7:	68 c0 42 11 80       	push   $0x801142c0
80103ccc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80103cd2:	e8 39 0e 00 00       	call   80104b10 <release>
80103cd7:	e8 44 ee ff ff       	call   80102b20 <kalloc>
80103cdc:	83 c4 10             	add    $0x10,%esp
80103cdf:	89 43 08             	mov    %eax,0x8(%ebx)
80103ce2:	85 c0                	test   %eax,%eax
80103ce4:	74 53                	je     80103d39 <allocproc+0xb9>
80103ce6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103cec:	83 ec 04             	sub    $0x4,%esp
80103cef:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103cf4:	89 53 18             	mov    %edx,0x18(%ebx)
80103cf7:	c7 40 14 76 5d 10 80 	movl   $0x80105d76,0x14(%eax)
80103cfe:	89 43 1c             	mov    %eax,0x1c(%ebx)
80103d01:	6a 14                	push   $0x14
80103d03:	6a 00                	push   $0x0
80103d05:	50                   	push   %eax
80103d06:	e8 55 0e 00 00       	call   80104b60 <memset>
80103d0b:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103d0e:	83 c4 10             	add    $0x10,%esp
80103d11:	c7 40 10 50 3d 10 80 	movl   $0x80103d50,0x10(%eax)
80103d18:	89 d8                	mov    %ebx,%eax
80103d1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d1d:	c9                   	leave  
80103d1e:	c3                   	ret    
80103d1f:	90                   	nop
80103d20:	83 ec 0c             	sub    $0xc,%esp
80103d23:	31 db                	xor    %ebx,%ebx
80103d25:	68 c0 42 11 80       	push   $0x801142c0
80103d2a:	e8 e1 0d 00 00       	call   80104b10 <release>
80103d2f:	89 d8                	mov    %ebx,%eax
80103d31:	83 c4 10             	add    $0x10,%esp
80103d34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d37:	c9                   	leave  
80103d38:	c3                   	ret    
80103d39:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103d40:	31 db                	xor    %ebx,%ebx
80103d42:	89 d8                	mov    %ebx,%eax
80103d44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d47:	c9                   	leave  
80103d48:	c3                   	ret    
80103d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d50 <forkret>:
80103d50:	f3 0f 1e fb          	endbr32 
80103d54:	55                   	push   %ebp
80103d55:	89 e5                	mov    %esp,%ebp
80103d57:	83 ec 14             	sub    $0x14,%esp
80103d5a:	68 c0 42 11 80       	push   $0x801142c0
80103d5f:	e8 ac 0d 00 00       	call   80104b10 <release>
80103d64:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103d69:	83 c4 10             	add    $0x10,%esp
80103d6c:	85 c0                	test   %eax,%eax
80103d6e:	75 08                	jne    80103d78 <forkret+0x28>
80103d70:	c9                   	leave  
80103d71:	c3                   	ret    
80103d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d78:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103d7f:	00 00 00 
80103d82:	83 ec 0c             	sub    $0xc,%esp
80103d85:	6a 01                	push   $0x1
80103d87:	e8 a4 dc ff ff       	call   80101a30 <iinit>
80103d8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103d93:	e8 e8 f3 ff ff       	call   80103180 <initlog>
80103d98:	83 c4 10             	add    $0x10,%esp
80103d9b:	c9                   	leave  
80103d9c:	c3                   	ret    
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi

80103da0 <pinit>:
80103da0:	f3 0f 1e fb          	endbr32 
80103da4:	55                   	push   %ebp
80103da5:	89 e5                	mov    %esp,%ebp
80103da7:	83 ec 10             	sub    $0x10,%esp
80103daa:	68 80 7b 10 80       	push   $0x80107b80
80103daf:	68 c0 42 11 80       	push   $0x801142c0
80103db4:	e8 17 0b 00 00       	call   801048d0 <initlock>
80103db9:	83 c4 10             	add    $0x10,%esp
80103dbc:	c9                   	leave  
80103dbd:	c3                   	ret    
80103dbe:	66 90                	xchg   %ax,%ax

80103dc0 <mycpu>:
80103dc0:	f3 0f 1e fb          	endbr32 
80103dc4:	55                   	push   %ebp
80103dc5:	89 e5                	mov    %esp,%ebp
80103dc7:	56                   	push   %esi
80103dc8:	53                   	push   %ebx
80103dc9:	9c                   	pushf  
80103dca:	58                   	pop    %eax
80103dcb:	f6 c4 02             	test   $0x2,%ah
80103dce:	75 4a                	jne    80103e1a <mycpu+0x5a>
80103dd0:	e8 bb ef ff ff       	call   80102d90 <lapicid>
80103dd5:	8b 35 a0 42 11 80    	mov    0x801142a0,%esi
80103ddb:	89 c3                	mov    %eax,%ebx
80103ddd:	85 f6                	test   %esi,%esi
80103ddf:	7e 2c                	jle    80103e0d <mycpu+0x4d>
80103de1:	31 d2                	xor    %edx,%edx
80103de3:	eb 0a                	jmp    80103def <mycpu+0x2f>
80103de5:	8d 76 00             	lea    0x0(%esi),%esi
80103de8:	83 c2 01             	add    $0x1,%edx
80103deb:	39 f2                	cmp    %esi,%edx
80103ded:	74 1e                	je     80103e0d <mycpu+0x4d>
80103def:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103df5:	0f b6 81 20 3d 11 80 	movzbl -0x7feec2e0(%ecx),%eax
80103dfc:	39 d8                	cmp    %ebx,%eax
80103dfe:	75 e8                	jne    80103de8 <mycpu+0x28>
80103e00:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e03:	8d 81 20 3d 11 80    	lea    -0x7feec2e0(%ecx),%eax
80103e09:	5b                   	pop    %ebx
80103e0a:	5e                   	pop    %esi
80103e0b:	5d                   	pop    %ebp
80103e0c:	c3                   	ret    
80103e0d:	83 ec 0c             	sub    $0xc,%esp
80103e10:	68 87 7b 10 80       	push   $0x80107b87
80103e15:	e8 76 c5 ff ff       	call   80100390 <panic>
80103e1a:	83 ec 0c             	sub    $0xc,%esp
80103e1d:	68 64 7c 10 80       	push   $0x80107c64
80103e22:	e8 69 c5 ff ff       	call   80100390 <panic>
80103e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e2e:	66 90                	xchg   %ax,%ax

80103e30 <cpuid>:
80103e30:	f3 0f 1e fb          	endbr32 
80103e34:	55                   	push   %ebp
80103e35:	89 e5                	mov    %esp,%ebp
80103e37:	83 ec 08             	sub    $0x8,%esp
80103e3a:	e8 81 ff ff ff       	call   80103dc0 <mycpu>
80103e3f:	c9                   	leave  
80103e40:	2d 20 3d 11 80       	sub    $0x80113d20,%eax
80103e45:	c1 f8 04             	sar    $0x4,%eax
80103e48:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
80103e4e:	c3                   	ret    
80103e4f:	90                   	nop

80103e50 <myproc>:
80103e50:	f3 0f 1e fb          	endbr32 
80103e54:	55                   	push   %ebp
80103e55:	89 e5                	mov    %esp,%ebp
80103e57:	53                   	push   %ebx
80103e58:	83 ec 04             	sub    $0x4,%esp
80103e5b:	e8 f0 0a 00 00       	call   80104950 <pushcli>
80103e60:	e8 5b ff ff ff       	call   80103dc0 <mycpu>
80103e65:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103e6b:	e8 30 0b 00 00       	call   801049a0 <popcli>
80103e70:	83 c4 04             	add    $0x4,%esp
80103e73:	89 d8                	mov    %ebx,%eax
80103e75:	5b                   	pop    %ebx
80103e76:	5d                   	pop    %ebp
80103e77:	c3                   	ret    
80103e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e7f:	90                   	nop

80103e80 <userinit>:
80103e80:	f3 0f 1e fb          	endbr32 
80103e84:	55                   	push   %ebp
80103e85:	89 e5                	mov    %esp,%ebp
80103e87:	53                   	push   %ebx
80103e88:	83 ec 04             	sub    $0x4,%esp
80103e8b:	e8 f0 fd ff ff       	call   80103c80 <allocproc>
80103e90:	89 c3                	mov    %eax,%ebx
80103e92:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
80103e97:	e8 a4 34 00 00       	call   80107340 <setupkvm>
80103e9c:	89 43 04             	mov    %eax,0x4(%ebx)
80103e9f:	85 c0                	test   %eax,%eax
80103ea1:	0f 84 bd 00 00 00    	je     80103f64 <userinit+0xe4>
80103ea7:	83 ec 04             	sub    $0x4,%esp
80103eaa:	68 2c 00 00 00       	push   $0x2c
80103eaf:	68 60 b4 10 80       	push   $0x8010b460
80103eb4:	50                   	push   %eax
80103eb5:	e8 56 31 00 00       	call   80107010 <inituvm>
80103eba:	83 c4 0c             	add    $0xc,%esp
80103ebd:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
80103ec3:	6a 4c                	push   $0x4c
80103ec5:	6a 00                	push   $0x0
80103ec7:	ff 73 18             	pushl  0x18(%ebx)
80103eca:	e8 91 0c 00 00       	call   80104b60 <memset>
80103ecf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ed2:	ba 1b 00 00 00       	mov    $0x1b,%edx
80103ed7:	83 c4 0c             	add    $0xc,%esp
80103eda:	b9 23 00 00 00       	mov    $0x23,%ecx
80103edf:	66 89 50 3c          	mov    %dx,0x3c(%eax)
80103ee3:	8b 43 18             	mov    0x18(%ebx),%eax
80103ee6:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80103eea:	8b 43 18             	mov    0x18(%ebx),%eax
80103eed:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ef1:	66 89 50 28          	mov    %dx,0x28(%eax)
80103ef5:	8b 43 18             	mov    0x18(%ebx),%eax
80103ef8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103efc:	66 89 50 48          	mov    %dx,0x48(%eax)
80103f00:	8b 43 18             	mov    0x18(%ebx),%eax
80103f03:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
80103f0a:	8b 43 18             	mov    0x18(%ebx),%eax
80103f0d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
80103f14:	8b 43 18             	mov    0x18(%ebx),%eax
80103f17:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
80103f1e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103f21:	6a 10                	push   $0x10
80103f23:	68 b0 7b 10 80       	push   $0x80107bb0
80103f28:	50                   	push   %eax
80103f29:	e8 f2 0d 00 00       	call   80104d20 <safestrcpy>
80103f2e:	c7 04 24 b9 7b 10 80 	movl   $0x80107bb9,(%esp)
80103f35:	e8 e6 e5 ff ff       	call   80102520 <namei>
80103f3a:	89 43 68             	mov    %eax,0x68(%ebx)
80103f3d:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103f44:	e8 07 0b 00 00       	call   80104a50 <acquire>
80103f49:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80103f50:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103f57:	e8 b4 0b 00 00       	call   80104b10 <release>
80103f5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f5f:	83 c4 10             	add    $0x10,%esp
80103f62:	c9                   	leave  
80103f63:	c3                   	ret    
80103f64:	83 ec 0c             	sub    $0xc,%esp
80103f67:	68 97 7b 10 80       	push   $0x80107b97
80103f6c:	e8 1f c4 ff ff       	call   80100390 <panic>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f7f:	90                   	nop

80103f80 <growproc>:
80103f80:	f3 0f 1e fb          	endbr32 
80103f84:	55                   	push   %ebp
80103f85:	89 e5                	mov    %esp,%ebp
80103f87:	56                   	push   %esi
80103f88:	53                   	push   %ebx
80103f89:	8b 75 08             	mov    0x8(%ebp),%esi
80103f8c:	e8 bf 09 00 00       	call   80104950 <pushcli>
80103f91:	e8 2a fe ff ff       	call   80103dc0 <mycpu>
80103f96:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103f9c:	e8 ff 09 00 00       	call   801049a0 <popcli>
80103fa1:	8b 03                	mov    (%ebx),%eax
80103fa3:	85 f6                	test   %esi,%esi
80103fa5:	7f 19                	jg     80103fc0 <growproc+0x40>
80103fa7:	75 37                	jne    80103fe0 <growproc+0x60>
80103fa9:	83 ec 0c             	sub    $0xc,%esp
80103fac:	89 03                	mov    %eax,(%ebx)
80103fae:	53                   	push   %ebx
80103faf:	e8 4c 2f 00 00       	call   80106f00 <switchuvm>
80103fb4:	83 c4 10             	add    $0x10,%esp
80103fb7:	31 c0                	xor    %eax,%eax
80103fb9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fbc:	5b                   	pop    %ebx
80103fbd:	5e                   	pop    %esi
80103fbe:	5d                   	pop    %ebp
80103fbf:	c3                   	ret    
80103fc0:	83 ec 04             	sub    $0x4,%esp
80103fc3:	01 c6                	add    %eax,%esi
80103fc5:	56                   	push   %esi
80103fc6:	50                   	push   %eax
80103fc7:	ff 73 04             	pushl  0x4(%ebx)
80103fca:	e8 91 31 00 00       	call   80107160 <allocuvm>
80103fcf:	83 c4 10             	add    $0x10,%esp
80103fd2:	85 c0                	test   %eax,%eax
80103fd4:	75 d3                	jne    80103fa9 <growproc+0x29>
80103fd6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fdb:	eb dc                	jmp    80103fb9 <growproc+0x39>
80103fdd:	8d 76 00             	lea    0x0(%esi),%esi
80103fe0:	83 ec 04             	sub    $0x4,%esp
80103fe3:	01 c6                	add    %eax,%esi
80103fe5:	56                   	push   %esi
80103fe6:	50                   	push   %eax
80103fe7:	ff 73 04             	pushl  0x4(%ebx)
80103fea:	e8 a1 32 00 00       	call   80107290 <deallocuvm>
80103fef:	83 c4 10             	add    $0x10,%esp
80103ff2:	85 c0                	test   %eax,%eax
80103ff4:	75 b3                	jne    80103fa9 <growproc+0x29>
80103ff6:	eb de                	jmp    80103fd6 <growproc+0x56>
80103ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fff:	90                   	nop

80104000 <fork>:
80104000:	f3 0f 1e fb          	endbr32 
80104004:	55                   	push   %ebp
80104005:	89 e5                	mov    %esp,%ebp
80104007:	57                   	push   %edi
80104008:	56                   	push   %esi
80104009:	53                   	push   %ebx
8010400a:	83 ec 1c             	sub    $0x1c,%esp
8010400d:	e8 3e 09 00 00       	call   80104950 <pushcli>
80104012:	e8 a9 fd ff ff       	call   80103dc0 <mycpu>
80104017:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
8010401d:	e8 7e 09 00 00       	call   801049a0 <popcli>
80104022:	e8 59 fc ff ff       	call   80103c80 <allocproc>
80104027:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010402a:	85 c0                	test   %eax,%eax
8010402c:	0f 84 bb 00 00 00    	je     801040ed <fork+0xed>
80104032:	83 ec 08             	sub    $0x8,%esp
80104035:	ff 33                	pushl  (%ebx)
80104037:	89 c7                	mov    %eax,%edi
80104039:	ff 73 04             	pushl  0x4(%ebx)
8010403c:	e8 cf 33 00 00       	call   80107410 <copyuvm>
80104041:	83 c4 10             	add    $0x10,%esp
80104044:	89 47 04             	mov    %eax,0x4(%edi)
80104047:	85 c0                	test   %eax,%eax
80104049:	0f 84 a5 00 00 00    	je     801040f4 <fork+0xf4>
8010404f:	8b 03                	mov    (%ebx),%eax
80104051:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104054:	89 01                	mov    %eax,(%ecx)
80104056:	8b 79 18             	mov    0x18(%ecx),%edi
80104059:	89 c8                	mov    %ecx,%eax
8010405b:	89 59 14             	mov    %ebx,0x14(%ecx)
8010405e:	b9 13 00 00 00       	mov    $0x13,%ecx
80104063:	8b 73 18             	mov    0x18(%ebx),%esi
80104066:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80104068:	31 f6                	xor    %esi,%esi
8010406a:	8b 40 18             	mov    0x18(%eax),%eax
8010406d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104078:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010407c:	85 c0                	test   %eax,%eax
8010407e:	74 13                	je     80104093 <fork+0x93>
80104080:	83 ec 0c             	sub    $0xc,%esp
80104083:	50                   	push   %eax
80104084:	e8 d7 d2 ff ff       	call   80101360 <filedup>
80104089:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010408c:	83 c4 10             	add    $0x10,%esp
8010408f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
80104093:	83 c6 01             	add    $0x1,%esi
80104096:	83 fe 10             	cmp    $0x10,%esi
80104099:	75 dd                	jne    80104078 <fork+0x78>
8010409b:	83 ec 0c             	sub    $0xc,%esp
8010409e:	ff 73 68             	pushl  0x68(%ebx)
801040a1:	83 c3 6c             	add    $0x6c,%ebx
801040a4:	e8 77 db ff ff       	call   80101c20 <idup>
801040a9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801040ac:	83 c4 0c             	add    $0xc,%esp
801040af:	89 47 68             	mov    %eax,0x68(%edi)
801040b2:	8d 47 6c             	lea    0x6c(%edi),%eax
801040b5:	6a 10                	push   $0x10
801040b7:	53                   	push   %ebx
801040b8:	50                   	push   %eax
801040b9:	e8 62 0c 00 00       	call   80104d20 <safestrcpy>
801040be:	8b 5f 10             	mov    0x10(%edi),%ebx
801040c1:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801040c8:	e8 83 09 00 00       	call   80104a50 <acquire>
801040cd:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
801040d4:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801040db:	e8 30 0a 00 00       	call   80104b10 <release>
801040e0:	83 c4 10             	add    $0x10,%esp
801040e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040e6:	89 d8                	mov    %ebx,%eax
801040e8:	5b                   	pop    %ebx
801040e9:	5e                   	pop    %esi
801040ea:	5f                   	pop    %edi
801040eb:	5d                   	pop    %ebp
801040ec:	c3                   	ret    
801040ed:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801040f2:	eb ef                	jmp    801040e3 <fork+0xe3>
801040f4:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801040f7:	83 ec 0c             	sub    $0xc,%esp
801040fa:	ff 73 08             	pushl  0x8(%ebx)
801040fd:	e8 5e e8 ff ff       	call   80102960 <kfree>
80104102:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104109:	83 c4 10             	add    $0x10,%esp
8010410c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104113:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104118:	eb c9                	jmp    801040e3 <fork+0xe3>
8010411a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104120 <scheduler>:
80104120:	f3 0f 1e fb          	endbr32 
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	57                   	push   %edi
80104128:	56                   	push   %esi
80104129:	53                   	push   %ebx
8010412a:	83 ec 0c             	sub    $0xc,%esp
8010412d:	e8 8e fc ff ff       	call   80103dc0 <mycpu>
80104132:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104139:	00 00 00 
8010413c:	89 c6                	mov    %eax,%esi
8010413e:	8d 78 04             	lea    0x4(%eax),%edi
80104141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104148:	fb                   	sti    
80104149:	83 ec 0c             	sub    $0xc,%esp
8010414c:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
80104151:	68 c0 42 11 80       	push   $0x801142c0
80104156:	e8 f5 08 00 00       	call   80104a50 <acquire>
8010415b:	83 c4 10             	add    $0x10,%esp
8010415e:	66 90                	xchg   %ax,%ax
80104160:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104164:	75 33                	jne    80104199 <scheduler+0x79>
80104166:	83 ec 0c             	sub    $0xc,%esp
80104169:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010416f:	53                   	push   %ebx
80104170:	e8 8b 2d 00 00       	call   80106f00 <switchuvm>
80104175:	58                   	pop    %eax
80104176:	5a                   	pop    %edx
80104177:	ff 73 1c             	pushl  0x1c(%ebx)
8010417a:	57                   	push   %edi
8010417b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104182:	e8 fc 0b 00 00       	call   80104d83 <swtch>
80104187:	e8 54 2d 00 00       	call   80106ee0 <switchkvm>
8010418c:	83 c4 10             	add    $0x10,%esp
8010418f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104196:	00 00 00 
80104199:	83 c3 7c             	add    $0x7c,%ebx
8010419c:	81 fb f4 61 11 80    	cmp    $0x801161f4,%ebx
801041a2:	75 bc                	jne    80104160 <scheduler+0x40>
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	68 c0 42 11 80       	push   $0x801142c0
801041ac:	e8 5f 09 00 00       	call   80104b10 <release>
801041b1:	83 c4 10             	add    $0x10,%esp
801041b4:	eb 92                	jmp    80104148 <scheduler+0x28>
801041b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041bd:	8d 76 00             	lea    0x0(%esi),%esi

801041c0 <sched>:
801041c0:	f3 0f 1e fb          	endbr32 
801041c4:	55                   	push   %ebp
801041c5:	89 e5                	mov    %esp,%ebp
801041c7:	56                   	push   %esi
801041c8:	53                   	push   %ebx
801041c9:	e8 82 07 00 00       	call   80104950 <pushcli>
801041ce:	e8 ed fb ff ff       	call   80103dc0 <mycpu>
801041d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801041d9:	e8 c2 07 00 00       	call   801049a0 <popcli>
801041de:	83 ec 0c             	sub    $0xc,%esp
801041e1:	68 c0 42 11 80       	push   $0x801142c0
801041e6:	e8 15 08 00 00       	call   80104a00 <holding>
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	85 c0                	test   %eax,%eax
801041f0:	74 4f                	je     80104241 <sched+0x81>
801041f2:	e8 c9 fb ff ff       	call   80103dc0 <mycpu>
801041f7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801041fe:	75 68                	jne    80104268 <sched+0xa8>
80104200:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104204:	74 55                	je     8010425b <sched+0x9b>
80104206:	9c                   	pushf  
80104207:	58                   	pop    %eax
80104208:	f6 c4 02             	test   $0x2,%ah
8010420b:	75 41                	jne    8010424e <sched+0x8e>
8010420d:	e8 ae fb ff ff       	call   80103dc0 <mycpu>
80104212:	83 c3 1c             	add    $0x1c,%ebx
80104215:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
8010421b:	e8 a0 fb ff ff       	call   80103dc0 <mycpu>
80104220:	83 ec 08             	sub    $0x8,%esp
80104223:	ff 70 04             	pushl  0x4(%eax)
80104226:	53                   	push   %ebx
80104227:	e8 57 0b 00 00       	call   80104d83 <swtch>
8010422c:	e8 8f fb ff ff       	call   80103dc0 <mycpu>
80104231:	83 c4 10             	add    $0x10,%esp
80104234:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
8010423a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010423d:	5b                   	pop    %ebx
8010423e:	5e                   	pop    %esi
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	83 ec 0c             	sub    $0xc,%esp
80104244:	68 bb 7b 10 80       	push   $0x80107bbb
80104249:	e8 42 c1 ff ff       	call   80100390 <panic>
8010424e:	83 ec 0c             	sub    $0xc,%esp
80104251:	68 e7 7b 10 80       	push   $0x80107be7
80104256:	e8 35 c1 ff ff       	call   80100390 <panic>
8010425b:	83 ec 0c             	sub    $0xc,%esp
8010425e:	68 d9 7b 10 80       	push   $0x80107bd9
80104263:	e8 28 c1 ff ff       	call   80100390 <panic>
80104268:	83 ec 0c             	sub    $0xc,%esp
8010426b:	68 cd 7b 10 80       	push   $0x80107bcd
80104270:	e8 1b c1 ff ff       	call   80100390 <panic>
80104275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010427c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104280 <exit>:
80104280:	f3 0f 1e fb          	endbr32 
80104284:	55                   	push   %ebp
80104285:	89 e5                	mov    %esp,%ebp
80104287:	57                   	push   %edi
80104288:	56                   	push   %esi
80104289:	53                   	push   %ebx
8010428a:	83 ec 0c             	sub    $0xc,%esp
8010428d:	e8 be 06 00 00       	call   80104950 <pushcli>
80104292:	e8 29 fb ff ff       	call   80103dc0 <mycpu>
80104297:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
8010429d:	e8 fe 06 00 00       	call   801049a0 <popcli>
801042a2:	8d 5e 28             	lea    0x28(%esi),%ebx
801042a5:	8d 7e 68             	lea    0x68(%esi),%edi
801042a8:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
801042ae:	0f 84 f3 00 00 00    	je     801043a7 <exit+0x127>
801042b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042b8:	8b 03                	mov    (%ebx),%eax
801042ba:	85 c0                	test   %eax,%eax
801042bc:	74 12                	je     801042d0 <exit+0x50>
801042be:	83 ec 0c             	sub    $0xc,%esp
801042c1:	50                   	push   %eax
801042c2:	e8 e9 d0 ff ff       	call   801013b0 <fileclose>
801042c7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042cd:	83 c4 10             	add    $0x10,%esp
801042d0:	83 c3 04             	add    $0x4,%ebx
801042d3:	39 df                	cmp    %ebx,%edi
801042d5:	75 e1                	jne    801042b8 <exit+0x38>
801042d7:	e8 44 ef ff ff       	call   80103220 <begin_op>
801042dc:	83 ec 0c             	sub    $0xc,%esp
801042df:	ff 76 68             	pushl  0x68(%esi)
801042e2:	e8 99 da ff ff       	call   80101d80 <iput>
801042e7:	e8 a4 ef ff ff       	call   80103290 <end_op>
801042ec:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
801042f3:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801042fa:	e8 51 07 00 00       	call   80104a50 <acquire>
801042ff:	8b 56 14             	mov    0x14(%esi),%edx
80104302:	83 c4 10             	add    $0x10,%esp
80104305:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
8010430a:	eb 0e                	jmp    8010431a <exit+0x9a>
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104310:	83 c0 7c             	add    $0x7c,%eax
80104313:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
80104318:	74 1c                	je     80104336 <exit+0xb6>
8010431a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010431e:	75 f0                	jne    80104310 <exit+0x90>
80104320:	3b 50 20             	cmp    0x20(%eax),%edx
80104323:	75 eb                	jne    80104310 <exit+0x90>
80104325:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010432c:	83 c0 7c             	add    $0x7c,%eax
8010432f:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
80104334:	75 e4                	jne    8010431a <exit+0x9a>
80104336:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
8010433c:	ba f4 42 11 80       	mov    $0x801142f4,%edx
80104341:	eb 10                	jmp    80104353 <exit+0xd3>
80104343:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104347:	90                   	nop
80104348:	83 c2 7c             	add    $0x7c,%edx
8010434b:	81 fa f4 61 11 80    	cmp    $0x801161f4,%edx
80104351:	74 3b                	je     8010438e <exit+0x10e>
80104353:	39 72 14             	cmp    %esi,0x14(%edx)
80104356:	75 f0                	jne    80104348 <exit+0xc8>
80104358:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
8010435c:	89 4a 14             	mov    %ecx,0x14(%edx)
8010435f:	75 e7                	jne    80104348 <exit+0xc8>
80104361:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
80104366:	eb 12                	jmp    8010437a <exit+0xfa>
80104368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010436f:	90                   	nop
80104370:	83 c0 7c             	add    $0x7c,%eax
80104373:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
80104378:	74 ce                	je     80104348 <exit+0xc8>
8010437a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010437e:	75 f0                	jne    80104370 <exit+0xf0>
80104380:	3b 48 20             	cmp    0x20(%eax),%ecx
80104383:	75 eb                	jne    80104370 <exit+0xf0>
80104385:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010438c:	eb e2                	jmp    80104370 <exit+0xf0>
8010438e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
80104395:	e8 26 fe ff ff       	call   801041c0 <sched>
8010439a:	83 ec 0c             	sub    $0xc,%esp
8010439d:	68 08 7c 10 80       	push   $0x80107c08
801043a2:	e8 e9 bf ff ff       	call   80100390 <panic>
801043a7:	83 ec 0c             	sub    $0xc,%esp
801043aa:	68 fb 7b 10 80       	push   $0x80107bfb
801043af:	e8 dc bf ff ff       	call   80100390 <panic>
801043b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043bf:	90                   	nop

801043c0 <yield>:
801043c0:	f3 0f 1e fb          	endbr32 
801043c4:	55                   	push   %ebp
801043c5:	89 e5                	mov    %esp,%ebp
801043c7:	53                   	push   %ebx
801043c8:	83 ec 10             	sub    $0x10,%esp
801043cb:	68 c0 42 11 80       	push   $0x801142c0
801043d0:	e8 7b 06 00 00       	call   80104a50 <acquire>
801043d5:	e8 76 05 00 00       	call   80104950 <pushcli>
801043da:	e8 e1 f9 ff ff       	call   80103dc0 <mycpu>
801043df:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801043e5:	e8 b6 05 00 00       	call   801049a0 <popcli>
801043ea:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801043f1:	e8 ca fd ff ff       	call   801041c0 <sched>
801043f6:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801043fd:	e8 0e 07 00 00       	call   80104b10 <release>
80104402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104405:	83 c4 10             	add    $0x10,%esp
80104408:	c9                   	leave  
80104409:	c3                   	ret    
8010440a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104410 <sleep>:
80104410:	f3 0f 1e fb          	endbr32 
80104414:	55                   	push   %ebp
80104415:	89 e5                	mov    %esp,%ebp
80104417:	57                   	push   %edi
80104418:	56                   	push   %esi
80104419:	53                   	push   %ebx
8010441a:	83 ec 0c             	sub    $0xc,%esp
8010441d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104420:	8b 75 0c             	mov    0xc(%ebp),%esi
80104423:	e8 28 05 00 00       	call   80104950 <pushcli>
80104428:	e8 93 f9 ff ff       	call   80103dc0 <mycpu>
8010442d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104433:	e8 68 05 00 00       	call   801049a0 <popcli>
80104438:	85 db                	test   %ebx,%ebx
8010443a:	0f 84 83 00 00 00    	je     801044c3 <sleep+0xb3>
80104440:	85 f6                	test   %esi,%esi
80104442:	74 72                	je     801044b6 <sleep+0xa6>
80104444:	81 fe c0 42 11 80    	cmp    $0x801142c0,%esi
8010444a:	74 4c                	je     80104498 <sleep+0x88>
8010444c:	83 ec 0c             	sub    $0xc,%esp
8010444f:	68 c0 42 11 80       	push   $0x801142c0
80104454:	e8 f7 05 00 00       	call   80104a50 <acquire>
80104459:	89 34 24             	mov    %esi,(%esp)
8010445c:	e8 af 06 00 00       	call   80104b10 <release>
80104461:	89 7b 20             	mov    %edi,0x20(%ebx)
80104464:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
8010446b:	e8 50 fd ff ff       	call   801041c0 <sched>
80104470:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104477:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010447e:	e8 8d 06 00 00       	call   80104b10 <release>
80104483:	89 75 08             	mov    %esi,0x8(%ebp)
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010448c:	5b                   	pop    %ebx
8010448d:	5e                   	pop    %esi
8010448e:	5f                   	pop    %edi
8010448f:	5d                   	pop    %ebp
80104490:	e9 bb 05 00 00       	jmp    80104a50 <acquire>
80104495:	8d 76 00             	lea    0x0(%esi),%esi
80104498:	89 7b 20             	mov    %edi,0x20(%ebx)
8010449b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
801044a2:	e8 19 fd ff ff       	call   801041c0 <sched>
801044a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
801044ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044b1:	5b                   	pop    %ebx
801044b2:	5e                   	pop    %esi
801044b3:	5f                   	pop    %edi
801044b4:	5d                   	pop    %ebp
801044b5:	c3                   	ret    
801044b6:	83 ec 0c             	sub    $0xc,%esp
801044b9:	68 1a 7c 10 80       	push   $0x80107c1a
801044be:	e8 cd be ff ff       	call   80100390 <panic>
801044c3:	83 ec 0c             	sub    $0xc,%esp
801044c6:	68 14 7c 10 80       	push   $0x80107c14
801044cb:	e8 c0 be ff ff       	call   80100390 <panic>

801044d0 <wait>:
801044d0:	f3 0f 1e fb          	endbr32 
801044d4:	55                   	push   %ebp
801044d5:	89 e5                	mov    %esp,%ebp
801044d7:	56                   	push   %esi
801044d8:	53                   	push   %ebx
801044d9:	e8 72 04 00 00       	call   80104950 <pushcli>
801044de:	e8 dd f8 ff ff       	call   80103dc0 <mycpu>
801044e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
801044e9:	e8 b2 04 00 00       	call   801049a0 <popcli>
801044ee:	83 ec 0c             	sub    $0xc,%esp
801044f1:	68 c0 42 11 80       	push   $0x801142c0
801044f6:	e8 55 05 00 00       	call   80104a50 <acquire>
801044fb:	83 c4 10             	add    $0x10,%esp
801044fe:	31 c0                	xor    %eax,%eax
80104500:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
80104505:	eb 14                	jmp    8010451b <wait+0x4b>
80104507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450e:	66 90                	xchg   %ax,%ax
80104510:	83 c3 7c             	add    $0x7c,%ebx
80104513:	81 fb f4 61 11 80    	cmp    $0x801161f4,%ebx
80104519:	74 1b                	je     80104536 <wait+0x66>
8010451b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010451e:	75 f0                	jne    80104510 <wait+0x40>
80104520:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104524:	74 32                	je     80104558 <wait+0x88>
80104526:	83 c3 7c             	add    $0x7c,%ebx
80104529:	b8 01 00 00 00       	mov    $0x1,%eax
8010452e:	81 fb f4 61 11 80    	cmp    $0x801161f4,%ebx
80104534:	75 e5                	jne    8010451b <wait+0x4b>
80104536:	85 c0                	test   %eax,%eax
80104538:	74 74                	je     801045ae <wait+0xde>
8010453a:	8b 46 24             	mov    0x24(%esi),%eax
8010453d:	85 c0                	test   %eax,%eax
8010453f:	75 6d                	jne    801045ae <wait+0xde>
80104541:	83 ec 08             	sub    $0x8,%esp
80104544:	68 c0 42 11 80       	push   $0x801142c0
80104549:	56                   	push   %esi
8010454a:	e8 c1 fe ff ff       	call   80104410 <sleep>
8010454f:	83 c4 10             	add    $0x10,%esp
80104552:	eb aa                	jmp    801044fe <wait+0x2e>
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104558:	83 ec 0c             	sub    $0xc,%esp
8010455b:	ff 73 08             	pushl  0x8(%ebx)
8010455e:	8b 73 10             	mov    0x10(%ebx),%esi
80104561:	e8 fa e3 ff ff       	call   80102960 <kfree>
80104566:	5a                   	pop    %edx
80104567:	ff 73 04             	pushl  0x4(%ebx)
8010456a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104571:	e8 4a 2d 00 00       	call   801072c0 <freevm>
80104576:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010457d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104584:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
8010458b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
8010458f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104596:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010459d:	e8 6e 05 00 00       	call   80104b10 <release>
801045a2:	83 c4 10             	add    $0x10,%esp
801045a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a8:	89 f0                	mov    %esi,%eax
801045aa:	5b                   	pop    %ebx
801045ab:	5e                   	pop    %esi
801045ac:	5d                   	pop    %ebp
801045ad:	c3                   	ret    
801045ae:	83 ec 0c             	sub    $0xc,%esp
801045b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
801045b6:	68 c0 42 11 80       	push   $0x801142c0
801045bb:	e8 50 05 00 00       	call   80104b10 <release>
801045c0:	83 c4 10             	add    $0x10,%esp
801045c3:	eb e0                	jmp    801045a5 <wait+0xd5>
801045c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <wakeup>:
801045d0:	f3 0f 1e fb          	endbr32 
801045d4:	55                   	push   %ebp
801045d5:	89 e5                	mov    %esp,%ebp
801045d7:	53                   	push   %ebx
801045d8:	83 ec 10             	sub    $0x10,%esp
801045db:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045de:	68 c0 42 11 80       	push   $0x801142c0
801045e3:	e8 68 04 00 00       	call   80104a50 <acquire>
801045e8:	83 c4 10             	add    $0x10,%esp
801045eb:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
801045f0:	eb 10                	jmp    80104602 <wakeup+0x32>
801045f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045f8:	83 c0 7c             	add    $0x7c,%eax
801045fb:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
80104600:	74 1c                	je     8010461e <wakeup+0x4e>
80104602:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104606:	75 f0                	jne    801045f8 <wakeup+0x28>
80104608:	3b 58 20             	cmp    0x20(%eax),%ebx
8010460b:	75 eb                	jne    801045f8 <wakeup+0x28>
8010460d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104614:	83 c0 7c             	add    $0x7c,%eax
80104617:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
8010461c:	75 e4                	jne    80104602 <wakeup+0x32>
8010461e:	c7 45 08 c0 42 11 80 	movl   $0x801142c0,0x8(%ebp)
80104625:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104628:	c9                   	leave  
80104629:	e9 e2 04 00 00       	jmp    80104b10 <release>
8010462e:	66 90                	xchg   %ax,%ax

80104630 <kill>:
80104630:	f3 0f 1e fb          	endbr32 
80104634:	55                   	push   %ebp
80104635:	89 e5                	mov    %esp,%ebp
80104637:	53                   	push   %ebx
80104638:	83 ec 10             	sub    $0x10,%esp
8010463b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010463e:	68 c0 42 11 80       	push   $0x801142c0
80104643:	e8 08 04 00 00       	call   80104a50 <acquire>
80104648:	83 c4 10             	add    $0x10,%esp
8010464b:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
80104650:	eb 10                	jmp    80104662 <kill+0x32>
80104652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104658:	83 c0 7c             	add    $0x7c,%eax
8010465b:	3d f4 61 11 80       	cmp    $0x801161f4,%eax
80104660:	74 36                	je     80104698 <kill+0x68>
80104662:	39 58 10             	cmp    %ebx,0x10(%eax)
80104665:	75 f1                	jne    80104658 <kill+0x28>
80104667:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010466b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104672:	75 07                	jne    8010467b <kill+0x4b>
80104674:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010467b:	83 ec 0c             	sub    $0xc,%esp
8010467e:	68 c0 42 11 80       	push   $0x801142c0
80104683:	e8 88 04 00 00       	call   80104b10 <release>
80104688:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010468b:	83 c4 10             	add    $0x10,%esp
8010468e:	31 c0                	xor    %eax,%eax
80104690:	c9                   	leave  
80104691:	c3                   	ret    
80104692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104698:	83 ec 0c             	sub    $0xc,%esp
8010469b:	68 c0 42 11 80       	push   $0x801142c0
801046a0:	e8 6b 04 00 00       	call   80104b10 <release>
801046a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046a8:	83 c4 10             	add    $0x10,%esp
801046ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046b0:	c9                   	leave  
801046b1:	c3                   	ret    
801046b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046c0 <procdump>:
801046c0:	f3 0f 1e fb          	endbr32 
801046c4:	55                   	push   %ebp
801046c5:	89 e5                	mov    %esp,%ebp
801046c7:	57                   	push   %edi
801046c8:	56                   	push   %esi
801046c9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801046cc:	53                   	push   %ebx
801046cd:	bb 60 43 11 80       	mov    $0x80114360,%ebx
801046d2:	83 ec 3c             	sub    $0x3c,%esp
801046d5:	eb 28                	jmp    801046ff <procdump+0x3f>
801046d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046de:	66 90                	xchg   %ax,%ax
801046e0:	83 ec 0c             	sub    $0xc,%esp
801046e3:	68 97 7f 10 80       	push   $0x80107f97
801046e8:	e8 d3 c1 ff ff       	call   801008c0 <cprintf>
801046ed:	83 c4 10             	add    $0x10,%esp
801046f0:	83 c3 7c             	add    $0x7c,%ebx
801046f3:	81 fb 60 62 11 80    	cmp    $0x80116260,%ebx
801046f9:	0f 84 81 00 00 00    	je     80104780 <procdump+0xc0>
801046ff:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104702:	85 c0                	test   %eax,%eax
80104704:	74 ea                	je     801046f0 <procdump+0x30>
80104706:	ba 2b 7c 10 80       	mov    $0x80107c2b,%edx
8010470b:	83 f8 05             	cmp    $0x5,%eax
8010470e:	77 11                	ja     80104721 <procdump+0x61>
80104710:	8b 14 85 8c 7c 10 80 	mov    -0x7fef8374(,%eax,4),%edx
80104717:	b8 2b 7c 10 80       	mov    $0x80107c2b,%eax
8010471c:	85 d2                	test   %edx,%edx
8010471e:	0f 44 d0             	cmove  %eax,%edx
80104721:	53                   	push   %ebx
80104722:	52                   	push   %edx
80104723:	ff 73 a4             	pushl  -0x5c(%ebx)
80104726:	68 2f 7c 10 80       	push   $0x80107c2f
8010472b:	e8 90 c1 ff ff       	call   801008c0 <cprintf>
80104730:	83 c4 10             	add    $0x10,%esp
80104733:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104737:	75 a7                	jne    801046e0 <procdump+0x20>
80104739:	83 ec 08             	sub    $0x8,%esp
8010473c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010473f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104742:	50                   	push   %eax
80104743:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104746:	8b 40 0c             	mov    0xc(%eax),%eax
80104749:	83 c0 08             	add    $0x8,%eax
8010474c:	50                   	push   %eax
8010474d:	e8 9e 01 00 00       	call   801048f0 <getcallerpcs>
80104752:	83 c4 10             	add    $0x10,%esp
80104755:	8d 76 00             	lea    0x0(%esi),%esi
80104758:	8b 17                	mov    (%edi),%edx
8010475a:	85 d2                	test   %edx,%edx
8010475c:	74 82                	je     801046e0 <procdump+0x20>
8010475e:	83 ec 08             	sub    $0x8,%esp
80104761:	83 c7 04             	add    $0x4,%edi
80104764:	52                   	push   %edx
80104765:	68 21 76 10 80       	push   $0x80107621
8010476a:	e8 51 c1 ff ff       	call   801008c0 <cprintf>
8010476f:	83 c4 10             	add    $0x10,%esp
80104772:	39 fe                	cmp    %edi,%esi
80104774:	75 e2                	jne    80104758 <procdump+0x98>
80104776:	e9 65 ff ff ff       	jmp    801046e0 <procdump+0x20>
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop
80104780:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104783:	5b                   	pop    %ebx
80104784:	5e                   	pop    %esi
80104785:	5f                   	pop    %edi
80104786:	5d                   	pop    %ebp
80104787:	c3                   	ret    
80104788:	66 90                	xchg   %ax,%ax
8010478a:	66 90                	xchg   %ax,%ax
8010478c:	66 90                	xchg   %ax,%ax
8010478e:	66 90                	xchg   %ax,%ax

80104790 <initsleeplock>:
80104790:	f3 0f 1e fb          	endbr32 
80104794:	55                   	push   %ebp
80104795:	89 e5                	mov    %esp,%ebp
80104797:	53                   	push   %ebx
80104798:	83 ec 0c             	sub    $0xc,%esp
8010479b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010479e:	68 a4 7c 10 80       	push   $0x80107ca4
801047a3:	8d 43 04             	lea    0x4(%ebx),%eax
801047a6:	50                   	push   %eax
801047a7:	e8 24 01 00 00       	call   801048d0 <initlock>
801047ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801047af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801047b5:	83 c4 10             	add    $0x10,%esp
801047b8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
801047bf:	89 43 38             	mov    %eax,0x38(%ebx)
801047c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c5:	c9                   	leave  
801047c6:	c3                   	ret    
801047c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ce:	66 90                	xchg   %ax,%ax

801047d0 <acquiresleep>:
801047d0:	f3 0f 1e fb          	endbr32 
801047d4:	55                   	push   %ebp
801047d5:	89 e5                	mov    %esp,%ebp
801047d7:	56                   	push   %esi
801047d8:	53                   	push   %ebx
801047d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047dc:	8d 73 04             	lea    0x4(%ebx),%esi
801047df:	83 ec 0c             	sub    $0xc,%esp
801047e2:	56                   	push   %esi
801047e3:	e8 68 02 00 00       	call   80104a50 <acquire>
801047e8:	8b 13                	mov    (%ebx),%edx
801047ea:	83 c4 10             	add    $0x10,%esp
801047ed:	85 d2                	test   %edx,%edx
801047ef:	74 1a                	je     8010480b <acquiresleep+0x3b>
801047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f8:	83 ec 08             	sub    $0x8,%esp
801047fb:	56                   	push   %esi
801047fc:	53                   	push   %ebx
801047fd:	e8 0e fc ff ff       	call   80104410 <sleep>
80104802:	8b 03                	mov    (%ebx),%eax
80104804:	83 c4 10             	add    $0x10,%esp
80104807:	85 c0                	test   %eax,%eax
80104809:	75 ed                	jne    801047f8 <acquiresleep+0x28>
8010480b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104811:	e8 3a f6 ff ff       	call   80103e50 <myproc>
80104816:	8b 40 10             	mov    0x10(%eax),%eax
80104819:	89 43 3c             	mov    %eax,0x3c(%ebx)
8010481c:	89 75 08             	mov    %esi,0x8(%ebp)
8010481f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104822:	5b                   	pop    %ebx
80104823:	5e                   	pop    %esi
80104824:	5d                   	pop    %ebp
80104825:	e9 e6 02 00 00       	jmp    80104b10 <release>
8010482a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104830 <releasesleep>:
80104830:	f3 0f 1e fb          	endbr32 
80104834:	55                   	push   %ebp
80104835:	89 e5                	mov    %esp,%ebp
80104837:	56                   	push   %esi
80104838:	53                   	push   %ebx
80104839:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010483c:	8d 73 04             	lea    0x4(%ebx),%esi
8010483f:	83 ec 0c             	sub    $0xc,%esp
80104842:	56                   	push   %esi
80104843:	e8 08 02 00 00       	call   80104a50 <acquire>
80104848:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010484e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104855:	89 1c 24             	mov    %ebx,(%esp)
80104858:	e8 73 fd ff ff       	call   801045d0 <wakeup>
8010485d:	89 75 08             	mov    %esi,0x8(%ebp)
80104860:	83 c4 10             	add    $0x10,%esp
80104863:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104866:	5b                   	pop    %ebx
80104867:	5e                   	pop    %esi
80104868:	5d                   	pop    %ebp
80104869:	e9 a2 02 00 00       	jmp    80104b10 <release>
8010486e:	66 90                	xchg   %ax,%ax

80104870 <holdingsleep>:
80104870:	f3 0f 1e fb          	endbr32 
80104874:	55                   	push   %ebp
80104875:	89 e5                	mov    %esp,%ebp
80104877:	57                   	push   %edi
80104878:	31 ff                	xor    %edi,%edi
8010487a:	56                   	push   %esi
8010487b:	53                   	push   %ebx
8010487c:	83 ec 18             	sub    $0x18,%esp
8010487f:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104882:	8d 73 04             	lea    0x4(%ebx),%esi
80104885:	56                   	push   %esi
80104886:	e8 c5 01 00 00       	call   80104a50 <acquire>
8010488b:	8b 03                	mov    (%ebx),%eax
8010488d:	83 c4 10             	add    $0x10,%esp
80104890:	85 c0                	test   %eax,%eax
80104892:	75 1c                	jne    801048b0 <holdingsleep+0x40>
80104894:	83 ec 0c             	sub    $0xc,%esp
80104897:	56                   	push   %esi
80104898:	e8 73 02 00 00       	call   80104b10 <release>
8010489d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048a0:	89 f8                	mov    %edi,%eax
801048a2:	5b                   	pop    %ebx
801048a3:	5e                   	pop    %esi
801048a4:	5f                   	pop    %edi
801048a5:	5d                   	pop    %ebp
801048a6:	c3                   	ret    
801048a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ae:	66 90                	xchg   %ax,%ax
801048b0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801048b3:	e8 98 f5 ff ff       	call   80103e50 <myproc>
801048b8:	39 58 10             	cmp    %ebx,0x10(%eax)
801048bb:	0f 94 c0             	sete   %al
801048be:	0f b6 c0             	movzbl %al,%eax
801048c1:	89 c7                	mov    %eax,%edi
801048c3:	eb cf                	jmp    80104894 <holdingsleep+0x24>
801048c5:	66 90                	xchg   %ax,%ax
801048c7:	66 90                	xchg   %ax,%ax
801048c9:	66 90                	xchg   %ax,%ax
801048cb:	66 90                	xchg   %ax,%ax
801048cd:	66 90                	xchg   %ax,%ax
801048cf:	90                   	nop

801048d0 <initlock>:
801048d0:	f3 0f 1e fb          	endbr32 
801048d4:	55                   	push   %ebp
801048d5:	89 e5                	mov    %esp,%ebp
801048d7:	8b 45 08             	mov    0x8(%ebp),%eax
801048da:	8b 55 0c             	mov    0xc(%ebp),%edx
801048dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801048e3:	89 50 04             	mov    %edx,0x4(%eax)
801048e6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801048ed:	5d                   	pop    %ebp
801048ee:	c3                   	ret    
801048ef:	90                   	nop

801048f0 <getcallerpcs>:
801048f0:	f3 0f 1e fb          	endbr32 
801048f4:	55                   	push   %ebp
801048f5:	31 d2                	xor    %edx,%edx
801048f7:	89 e5                	mov    %esp,%ebp
801048f9:	53                   	push   %ebx
801048fa:	8b 45 08             	mov    0x8(%ebp),%eax
801048fd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104900:	83 e8 08             	sub    $0x8,%eax
80104903:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104907:	90                   	nop
80104908:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010490e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104914:	77 1a                	ja     80104930 <getcallerpcs+0x40>
80104916:	8b 58 04             	mov    0x4(%eax),%ebx
80104919:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
8010491c:	83 c2 01             	add    $0x1,%edx
8010491f:	8b 00                	mov    (%eax),%eax
80104921:	83 fa 0a             	cmp    $0xa,%edx
80104924:	75 e2                	jne    80104908 <getcallerpcs+0x18>
80104926:	5b                   	pop    %ebx
80104927:	5d                   	pop    %ebp
80104928:	c3                   	ret    
80104929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104930:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104933:	8d 51 28             	lea    0x28(%ecx),%edx
80104936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493d:	8d 76 00             	lea    0x0(%esi),%esi
80104940:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104946:	83 c0 04             	add    $0x4,%eax
80104949:	39 d0                	cmp    %edx,%eax
8010494b:	75 f3                	jne    80104940 <getcallerpcs+0x50>
8010494d:	5b                   	pop    %ebx
8010494e:	5d                   	pop    %ebp
8010494f:	c3                   	ret    

80104950 <pushcli>:
80104950:	f3 0f 1e fb          	endbr32 
80104954:	55                   	push   %ebp
80104955:	89 e5                	mov    %esp,%ebp
80104957:	53                   	push   %ebx
80104958:	83 ec 04             	sub    $0x4,%esp
8010495b:	9c                   	pushf  
8010495c:	5b                   	pop    %ebx
8010495d:	fa                   	cli    
8010495e:	e8 5d f4 ff ff       	call   80103dc0 <mycpu>
80104963:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104969:	85 c0                	test   %eax,%eax
8010496b:	74 13                	je     80104980 <pushcli+0x30>
8010496d:	e8 4e f4 ff ff       	call   80103dc0 <mycpu>
80104972:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104979:	83 c4 04             	add    $0x4,%esp
8010497c:	5b                   	pop    %ebx
8010497d:	5d                   	pop    %ebp
8010497e:	c3                   	ret    
8010497f:	90                   	nop
80104980:	e8 3b f4 ff ff       	call   80103dc0 <mycpu>
80104985:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010498b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104991:	eb da                	jmp    8010496d <pushcli+0x1d>
80104993:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010499a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049a0 <popcli>:
801049a0:	f3 0f 1e fb          	endbr32 
801049a4:	55                   	push   %ebp
801049a5:	89 e5                	mov    %esp,%ebp
801049a7:	83 ec 08             	sub    $0x8,%esp
801049aa:	9c                   	pushf  
801049ab:	58                   	pop    %eax
801049ac:	f6 c4 02             	test   $0x2,%ah
801049af:	75 31                	jne    801049e2 <popcli+0x42>
801049b1:	e8 0a f4 ff ff       	call   80103dc0 <mycpu>
801049b6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801049bd:	78 30                	js     801049ef <popcli+0x4f>
801049bf:	e8 fc f3 ff ff       	call   80103dc0 <mycpu>
801049c4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801049ca:	85 d2                	test   %edx,%edx
801049cc:	74 02                	je     801049d0 <popcli+0x30>
801049ce:	c9                   	leave  
801049cf:	c3                   	ret    
801049d0:	e8 eb f3 ff ff       	call   80103dc0 <mycpu>
801049d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801049db:	85 c0                	test   %eax,%eax
801049dd:	74 ef                	je     801049ce <popcli+0x2e>
801049df:	fb                   	sti    
801049e0:	c9                   	leave  
801049e1:	c3                   	ret    
801049e2:	83 ec 0c             	sub    $0xc,%esp
801049e5:	68 af 7c 10 80       	push   $0x80107caf
801049ea:	e8 a1 b9 ff ff       	call   80100390 <panic>
801049ef:	83 ec 0c             	sub    $0xc,%esp
801049f2:	68 c6 7c 10 80       	push   $0x80107cc6
801049f7:	e8 94 b9 ff ff       	call   80100390 <panic>
801049fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a00 <holding>:
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	89 e5                	mov    %esp,%ebp
80104a07:	56                   	push   %esi
80104a08:	53                   	push   %ebx
80104a09:	8b 75 08             	mov    0x8(%ebp),%esi
80104a0c:	31 db                	xor    %ebx,%ebx
80104a0e:	e8 3d ff ff ff       	call   80104950 <pushcli>
80104a13:	8b 06                	mov    (%esi),%eax
80104a15:	85 c0                	test   %eax,%eax
80104a17:	75 0f                	jne    80104a28 <holding+0x28>
80104a19:	e8 82 ff ff ff       	call   801049a0 <popcli>
80104a1e:	89 d8                	mov    %ebx,%eax
80104a20:	5b                   	pop    %ebx
80104a21:	5e                   	pop    %esi
80104a22:	5d                   	pop    %ebp
80104a23:	c3                   	ret    
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a28:	8b 5e 08             	mov    0x8(%esi),%ebx
80104a2b:	e8 90 f3 ff ff       	call   80103dc0 <mycpu>
80104a30:	39 c3                	cmp    %eax,%ebx
80104a32:	0f 94 c3             	sete   %bl
80104a35:	e8 66 ff ff ff       	call   801049a0 <popcli>
80104a3a:	0f b6 db             	movzbl %bl,%ebx
80104a3d:	89 d8                	mov    %ebx,%eax
80104a3f:	5b                   	pop    %ebx
80104a40:	5e                   	pop    %esi
80104a41:	5d                   	pop    %ebp
80104a42:	c3                   	ret    
80104a43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a50 <acquire>:
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
80104a55:	89 e5                	mov    %esp,%ebp
80104a57:	56                   	push   %esi
80104a58:	53                   	push   %ebx
80104a59:	e8 f2 fe ff ff       	call   80104950 <pushcli>
80104a5e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a61:	83 ec 0c             	sub    $0xc,%esp
80104a64:	53                   	push   %ebx
80104a65:	e8 96 ff ff ff       	call   80104a00 <holding>
80104a6a:	83 c4 10             	add    $0x10,%esp
80104a6d:	85 c0                	test   %eax,%eax
80104a6f:	0f 85 7f 00 00 00    	jne    80104af4 <acquire+0xa4>
80104a75:	89 c6                	mov    %eax,%esi
80104a77:	ba 01 00 00 00       	mov    $0x1,%edx
80104a7c:	eb 05                	jmp    80104a83 <acquire+0x33>
80104a7e:	66 90                	xchg   %ax,%ax
80104a80:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a83:	89 d0                	mov    %edx,%eax
80104a85:	f0 87 03             	lock xchg %eax,(%ebx)
80104a88:	85 c0                	test   %eax,%eax
80104a8a:	75 f4                	jne    80104a80 <acquire+0x30>
80104a8c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104a91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a94:	e8 27 f3 ff ff       	call   80103dc0 <mycpu>
80104a99:	89 43 08             	mov    %eax,0x8(%ebx)
80104a9c:	89 e8                	mov    %ebp,%eax
80104a9e:	66 90                	xchg   %ax,%ax
80104aa0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104aa6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104aac:	77 22                	ja     80104ad0 <acquire+0x80>
80104aae:	8b 50 04             	mov    0x4(%eax),%edx
80104ab1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
80104ab5:	83 c6 01             	add    $0x1,%esi
80104ab8:	8b 00                	mov    (%eax),%eax
80104aba:	83 fe 0a             	cmp    $0xa,%esi
80104abd:	75 e1                	jne    80104aa0 <acquire+0x50>
80104abf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ac2:	5b                   	pop    %ebx
80104ac3:	5e                   	pop    %esi
80104ac4:	5d                   	pop    %ebp
80104ac5:	c3                   	ret    
80104ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104acd:	8d 76 00             	lea    0x0(%esi),%esi
80104ad0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104ad4:	83 c3 34             	add    $0x34,%ebx
80104ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ade:	66 90                	xchg   %ax,%ax
80104ae0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ae6:	83 c0 04             	add    $0x4,%eax
80104ae9:	39 d8                	cmp    %ebx,%eax
80104aeb:	75 f3                	jne    80104ae0 <acquire+0x90>
80104aed:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104af0:	5b                   	pop    %ebx
80104af1:	5e                   	pop    %esi
80104af2:	5d                   	pop    %ebp
80104af3:	c3                   	ret    
80104af4:	83 ec 0c             	sub    $0xc,%esp
80104af7:	68 cd 7c 10 80       	push   $0x80107ccd
80104afc:	e8 8f b8 ff ff       	call   80100390 <panic>
80104b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0f:	90                   	nop

80104b10 <release>:
80104b10:	f3 0f 1e fb          	endbr32 
80104b14:	55                   	push   %ebp
80104b15:	89 e5                	mov    %esp,%ebp
80104b17:	53                   	push   %ebx
80104b18:	83 ec 10             	sub    $0x10,%esp
80104b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b1e:	53                   	push   %ebx
80104b1f:	e8 dc fe ff ff       	call   80104a00 <holding>
80104b24:	83 c4 10             	add    $0x10,%esp
80104b27:	85 c0                	test   %eax,%eax
80104b29:	74 22                	je     80104b4d <release+0x3d>
80104b2b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104b32:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104b39:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104b3e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104b44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b47:	c9                   	leave  
80104b48:	e9 53 fe ff ff       	jmp    801049a0 <popcli>
80104b4d:	83 ec 0c             	sub    $0xc,%esp
80104b50:	68 d5 7c 10 80       	push   $0x80107cd5
80104b55:	e8 36 b8 ff ff       	call   80100390 <panic>
80104b5a:	66 90                	xchg   %ax,%ax
80104b5c:	66 90                	xchg   %ax,%ax
80104b5e:	66 90                	xchg   %ax,%ax

80104b60 <memset>:
80104b60:	f3 0f 1e fb          	endbr32 
80104b64:	55                   	push   %ebp
80104b65:	89 e5                	mov    %esp,%ebp
80104b67:	57                   	push   %edi
80104b68:	8b 55 08             	mov    0x8(%ebp),%edx
80104b6b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b6e:	53                   	push   %ebx
80104b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b72:	89 d7                	mov    %edx,%edi
80104b74:	09 cf                	or     %ecx,%edi
80104b76:	83 e7 03             	and    $0x3,%edi
80104b79:	75 25                	jne    80104ba0 <memset+0x40>
80104b7b:	0f b6 f8             	movzbl %al,%edi
80104b7e:	c1 e0 18             	shl    $0x18,%eax
80104b81:	89 fb                	mov    %edi,%ebx
80104b83:	c1 e9 02             	shr    $0x2,%ecx
80104b86:	c1 e3 10             	shl    $0x10,%ebx
80104b89:	09 d8                	or     %ebx,%eax
80104b8b:	09 f8                	or     %edi,%eax
80104b8d:	c1 e7 08             	shl    $0x8,%edi
80104b90:	09 f8                	or     %edi,%eax
80104b92:	89 d7                	mov    %edx,%edi
80104b94:	fc                   	cld    
80104b95:	f3 ab                	rep stos %eax,%es:(%edi)
80104b97:	5b                   	pop    %ebx
80104b98:	89 d0                	mov    %edx,%eax
80104b9a:	5f                   	pop    %edi
80104b9b:	5d                   	pop    %ebp
80104b9c:	c3                   	ret    
80104b9d:	8d 76 00             	lea    0x0(%esi),%esi
80104ba0:	89 d7                	mov    %edx,%edi
80104ba2:	fc                   	cld    
80104ba3:	f3 aa                	rep stos %al,%es:(%edi)
80104ba5:	5b                   	pop    %ebx
80104ba6:	89 d0                	mov    %edx,%eax
80104ba8:	5f                   	pop    %edi
80104ba9:	5d                   	pop    %ebp
80104baa:	c3                   	ret    
80104bab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104baf:	90                   	nop

80104bb0 <memcmp>:
80104bb0:	f3 0f 1e fb          	endbr32 
80104bb4:	55                   	push   %ebp
80104bb5:	89 e5                	mov    %esp,%ebp
80104bb7:	56                   	push   %esi
80104bb8:	8b 75 10             	mov    0x10(%ebp),%esi
80104bbb:	8b 55 08             	mov    0x8(%ebp),%edx
80104bbe:	53                   	push   %ebx
80104bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bc2:	85 f6                	test   %esi,%esi
80104bc4:	74 2a                	je     80104bf0 <memcmp+0x40>
80104bc6:	01 c6                	add    %eax,%esi
80104bc8:	eb 10                	jmp    80104bda <memcmp+0x2a>
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bd0:	83 c0 01             	add    $0x1,%eax
80104bd3:	83 c2 01             	add    $0x1,%edx
80104bd6:	39 f0                	cmp    %esi,%eax
80104bd8:	74 16                	je     80104bf0 <memcmp+0x40>
80104bda:	0f b6 0a             	movzbl (%edx),%ecx
80104bdd:	0f b6 18             	movzbl (%eax),%ebx
80104be0:	38 d9                	cmp    %bl,%cl
80104be2:	74 ec                	je     80104bd0 <memcmp+0x20>
80104be4:	0f b6 c1             	movzbl %cl,%eax
80104be7:	29 d8                	sub    %ebx,%eax
80104be9:	5b                   	pop    %ebx
80104bea:	5e                   	pop    %esi
80104beb:	5d                   	pop    %ebp
80104bec:	c3                   	ret    
80104bed:	8d 76 00             	lea    0x0(%esi),%esi
80104bf0:	5b                   	pop    %ebx
80104bf1:	31 c0                	xor    %eax,%eax
80104bf3:	5e                   	pop    %esi
80104bf4:	5d                   	pop    %ebp
80104bf5:	c3                   	ret    
80104bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bfd:	8d 76 00             	lea    0x0(%esi),%esi

80104c00 <memmove>:
80104c00:	f3 0f 1e fb          	endbr32 
80104c04:	55                   	push   %ebp
80104c05:	89 e5                	mov    %esp,%ebp
80104c07:	57                   	push   %edi
80104c08:	8b 55 08             	mov    0x8(%ebp),%edx
80104c0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c0e:	56                   	push   %esi
80104c0f:	8b 75 0c             	mov    0xc(%ebp),%esi
80104c12:	39 d6                	cmp    %edx,%esi
80104c14:	73 2a                	jae    80104c40 <memmove+0x40>
80104c16:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104c19:	39 fa                	cmp    %edi,%edx
80104c1b:	73 23                	jae    80104c40 <memmove+0x40>
80104c1d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104c20:	85 c9                	test   %ecx,%ecx
80104c22:	74 13                	je     80104c37 <memmove+0x37>
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c28:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104c2c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104c2f:	83 e8 01             	sub    $0x1,%eax
80104c32:	83 f8 ff             	cmp    $0xffffffff,%eax
80104c35:	75 f1                	jne    80104c28 <memmove+0x28>
80104c37:	5e                   	pop    %esi
80104c38:	89 d0                	mov    %edx,%eax
80104c3a:	5f                   	pop    %edi
80104c3b:	5d                   	pop    %ebp
80104c3c:	c3                   	ret    
80104c3d:	8d 76 00             	lea    0x0(%esi),%esi
80104c40:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104c43:	89 d7                	mov    %edx,%edi
80104c45:	85 c9                	test   %ecx,%ecx
80104c47:	74 ee                	je     80104c37 <memmove+0x37>
80104c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c50:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104c51:	39 f0                	cmp    %esi,%eax
80104c53:	75 fb                	jne    80104c50 <memmove+0x50>
80104c55:	5e                   	pop    %esi
80104c56:	89 d0                	mov    %edx,%eax
80104c58:	5f                   	pop    %edi
80104c59:	5d                   	pop    %ebp
80104c5a:	c3                   	ret    
80104c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c5f:	90                   	nop

80104c60 <memcpy>:
80104c60:	f3 0f 1e fb          	endbr32 
80104c64:	eb 9a                	jmp    80104c00 <memmove>
80104c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6d:	8d 76 00             	lea    0x0(%esi),%esi

80104c70 <strncmp>:
80104c70:	f3 0f 1e fb          	endbr32 
80104c74:	55                   	push   %ebp
80104c75:	89 e5                	mov    %esp,%ebp
80104c77:	56                   	push   %esi
80104c78:	8b 75 10             	mov    0x10(%ebp),%esi
80104c7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104c7e:	53                   	push   %ebx
80104c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c82:	85 f6                	test   %esi,%esi
80104c84:	74 32                	je     80104cb8 <strncmp+0x48>
80104c86:	01 c6                	add    %eax,%esi
80104c88:	eb 14                	jmp    80104c9e <strncmp+0x2e>
80104c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c90:	38 da                	cmp    %bl,%dl
80104c92:	75 14                	jne    80104ca8 <strncmp+0x38>
80104c94:	83 c0 01             	add    $0x1,%eax
80104c97:	83 c1 01             	add    $0x1,%ecx
80104c9a:	39 f0                	cmp    %esi,%eax
80104c9c:	74 1a                	je     80104cb8 <strncmp+0x48>
80104c9e:	0f b6 11             	movzbl (%ecx),%edx
80104ca1:	0f b6 18             	movzbl (%eax),%ebx
80104ca4:	84 d2                	test   %dl,%dl
80104ca6:	75 e8                	jne    80104c90 <strncmp+0x20>
80104ca8:	0f b6 c2             	movzbl %dl,%eax
80104cab:	29 d8                	sub    %ebx,%eax
80104cad:	5b                   	pop    %ebx
80104cae:	5e                   	pop    %esi
80104caf:	5d                   	pop    %ebp
80104cb0:	c3                   	ret    
80104cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cb8:	5b                   	pop    %ebx
80104cb9:	31 c0                	xor    %eax,%eax
80104cbb:	5e                   	pop    %esi
80104cbc:	5d                   	pop    %ebp
80104cbd:	c3                   	ret    
80104cbe:	66 90                	xchg   %ax,%ax

80104cc0 <strncpy>:
80104cc0:	f3 0f 1e fb          	endbr32 
80104cc4:	55                   	push   %ebp
80104cc5:	89 e5                	mov    %esp,%ebp
80104cc7:	57                   	push   %edi
80104cc8:	56                   	push   %esi
80104cc9:	8b 75 08             	mov    0x8(%ebp),%esi
80104ccc:	53                   	push   %ebx
80104ccd:	8b 45 10             	mov    0x10(%ebp),%eax
80104cd0:	89 f2                	mov    %esi,%edx
80104cd2:	eb 1b                	jmp    80104cef <strncpy+0x2f>
80104cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cd8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104cdc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104cdf:	83 c2 01             	add    $0x1,%edx
80104ce2:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104ce6:	89 f9                	mov    %edi,%ecx
80104ce8:	88 4a ff             	mov    %cl,-0x1(%edx)
80104ceb:	84 c9                	test   %cl,%cl
80104ced:	74 09                	je     80104cf8 <strncpy+0x38>
80104cef:	89 c3                	mov    %eax,%ebx
80104cf1:	83 e8 01             	sub    $0x1,%eax
80104cf4:	85 db                	test   %ebx,%ebx
80104cf6:	7f e0                	jg     80104cd8 <strncpy+0x18>
80104cf8:	89 d1                	mov    %edx,%ecx
80104cfa:	85 c0                	test   %eax,%eax
80104cfc:	7e 15                	jle    80104d13 <strncpy+0x53>
80104cfe:	66 90                	xchg   %ax,%ax
80104d00:	83 c1 01             	add    $0x1,%ecx
80104d03:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80104d07:	89 c8                	mov    %ecx,%eax
80104d09:	f7 d0                	not    %eax
80104d0b:	01 d0                	add    %edx,%eax
80104d0d:	01 d8                	add    %ebx,%eax
80104d0f:	85 c0                	test   %eax,%eax
80104d11:	7f ed                	jg     80104d00 <strncpy+0x40>
80104d13:	5b                   	pop    %ebx
80104d14:	89 f0                	mov    %esi,%eax
80104d16:	5e                   	pop    %esi
80104d17:	5f                   	pop    %edi
80104d18:	5d                   	pop    %ebp
80104d19:	c3                   	ret    
80104d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d20 <safestrcpy>:
80104d20:	f3 0f 1e fb          	endbr32 
80104d24:	55                   	push   %ebp
80104d25:	89 e5                	mov    %esp,%ebp
80104d27:	56                   	push   %esi
80104d28:	8b 55 10             	mov    0x10(%ebp),%edx
80104d2b:	8b 75 08             	mov    0x8(%ebp),%esi
80104d2e:	53                   	push   %ebx
80104d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d32:	85 d2                	test   %edx,%edx
80104d34:	7e 21                	jle    80104d57 <safestrcpy+0x37>
80104d36:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104d3a:	89 f2                	mov    %esi,%edx
80104d3c:	eb 12                	jmp    80104d50 <safestrcpy+0x30>
80104d3e:	66 90                	xchg   %ax,%ax
80104d40:	0f b6 08             	movzbl (%eax),%ecx
80104d43:	83 c0 01             	add    $0x1,%eax
80104d46:	83 c2 01             	add    $0x1,%edx
80104d49:	88 4a ff             	mov    %cl,-0x1(%edx)
80104d4c:	84 c9                	test   %cl,%cl
80104d4e:	74 04                	je     80104d54 <safestrcpy+0x34>
80104d50:	39 d8                	cmp    %ebx,%eax
80104d52:	75 ec                	jne    80104d40 <safestrcpy+0x20>
80104d54:	c6 02 00             	movb   $0x0,(%edx)
80104d57:	89 f0                	mov    %esi,%eax
80104d59:	5b                   	pop    %ebx
80104d5a:	5e                   	pop    %esi
80104d5b:	5d                   	pop    %ebp
80104d5c:	c3                   	ret    
80104d5d:	8d 76 00             	lea    0x0(%esi),%esi

80104d60 <strlen>:
80104d60:	f3 0f 1e fb          	endbr32 
80104d64:	55                   	push   %ebp
80104d65:	31 c0                	xor    %eax,%eax
80104d67:	89 e5                	mov    %esp,%ebp
80104d69:	8b 55 08             	mov    0x8(%ebp),%edx
80104d6c:	80 3a 00             	cmpb   $0x0,(%edx)
80104d6f:	74 10                	je     80104d81 <strlen+0x21>
80104d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d78:	83 c0 01             	add    $0x1,%eax
80104d7b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104d7f:	75 f7                	jne    80104d78 <strlen+0x18>
80104d81:	5d                   	pop    %ebp
80104d82:	c3                   	ret    

80104d83 <swtch>:
80104d83:	8b 44 24 04          	mov    0x4(%esp),%eax
80104d87:	8b 54 24 08          	mov    0x8(%esp),%edx
80104d8b:	55                   	push   %ebp
80104d8c:	53                   	push   %ebx
80104d8d:	56                   	push   %esi
80104d8e:	57                   	push   %edi
80104d8f:	89 20                	mov    %esp,(%eax)
80104d91:	89 d4                	mov    %edx,%esp
80104d93:	5f                   	pop    %edi
80104d94:	5e                   	pop    %esi
80104d95:	5b                   	pop    %ebx
80104d96:	5d                   	pop    %ebp
80104d97:	c3                   	ret    
80104d98:	66 90                	xchg   %ax,%ax
80104d9a:	66 90                	xchg   %ax,%ax
80104d9c:	66 90                	xchg   %ax,%ax
80104d9e:	66 90                	xchg   %ax,%ax

80104da0 <fetchint>:
80104da0:	f3 0f 1e fb          	endbr32 
80104da4:	55                   	push   %ebp
80104da5:	89 e5                	mov    %esp,%ebp
80104da7:	53                   	push   %ebx
80104da8:	83 ec 04             	sub    $0x4,%esp
80104dab:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dae:	e8 9d f0 ff ff       	call   80103e50 <myproc>
80104db3:	8b 00                	mov    (%eax),%eax
80104db5:	39 d8                	cmp    %ebx,%eax
80104db7:	76 17                	jbe    80104dd0 <fetchint+0x30>
80104db9:	8d 53 04             	lea    0x4(%ebx),%edx
80104dbc:	39 d0                	cmp    %edx,%eax
80104dbe:	72 10                	jb     80104dd0 <fetchint+0x30>
80104dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dc3:	8b 13                	mov    (%ebx),%edx
80104dc5:	89 10                	mov    %edx,(%eax)
80104dc7:	31 c0                	xor    %eax,%eax
80104dc9:	83 c4 04             	add    $0x4,%esp
80104dcc:	5b                   	pop    %ebx
80104dcd:	5d                   	pop    %ebp
80104dce:	c3                   	ret    
80104dcf:	90                   	nop
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dd5:	eb f2                	jmp    80104dc9 <fetchint+0x29>
80104dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dde:	66 90                	xchg   %ax,%ax

80104de0 <fetchstr>:
80104de0:	f3 0f 1e fb          	endbr32 
80104de4:	55                   	push   %ebp
80104de5:	89 e5                	mov    %esp,%ebp
80104de7:	53                   	push   %ebx
80104de8:	83 ec 04             	sub    $0x4,%esp
80104deb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dee:	e8 5d f0 ff ff       	call   80103e50 <myproc>
80104df3:	39 18                	cmp    %ebx,(%eax)
80104df5:	76 31                	jbe    80104e28 <fetchstr+0x48>
80104df7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104dfa:	89 1a                	mov    %ebx,(%edx)
80104dfc:	8b 10                	mov    (%eax),%edx
80104dfe:	39 d3                	cmp    %edx,%ebx
80104e00:	73 26                	jae    80104e28 <fetchstr+0x48>
80104e02:	89 d8                	mov    %ebx,%eax
80104e04:	eb 11                	jmp    80104e17 <fetchstr+0x37>
80104e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0d:	8d 76 00             	lea    0x0(%esi),%esi
80104e10:	83 c0 01             	add    $0x1,%eax
80104e13:	39 c2                	cmp    %eax,%edx
80104e15:	76 11                	jbe    80104e28 <fetchstr+0x48>
80104e17:	80 38 00             	cmpb   $0x0,(%eax)
80104e1a:	75 f4                	jne    80104e10 <fetchstr+0x30>
80104e1c:	83 c4 04             	add    $0x4,%esp
80104e1f:	29 d8                	sub    %ebx,%eax
80104e21:	5b                   	pop    %ebx
80104e22:	5d                   	pop    %ebp
80104e23:	c3                   	ret    
80104e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e28:	83 c4 04             	add    $0x4,%esp
80104e2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e30:	5b                   	pop    %ebx
80104e31:	5d                   	pop    %ebp
80104e32:	c3                   	ret    
80104e33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e40 <argint>:
80104e40:	f3 0f 1e fb          	endbr32 
80104e44:	55                   	push   %ebp
80104e45:	89 e5                	mov    %esp,%ebp
80104e47:	56                   	push   %esi
80104e48:	53                   	push   %ebx
80104e49:	e8 02 f0 ff ff       	call   80103e50 <myproc>
80104e4e:	8b 55 08             	mov    0x8(%ebp),%edx
80104e51:	8b 40 18             	mov    0x18(%eax),%eax
80104e54:	8b 40 44             	mov    0x44(%eax),%eax
80104e57:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104e5a:	e8 f1 ef ff ff       	call   80103e50 <myproc>
80104e5f:	8d 73 04             	lea    0x4(%ebx),%esi
80104e62:	8b 00                	mov    (%eax),%eax
80104e64:	39 c6                	cmp    %eax,%esi
80104e66:	73 18                	jae    80104e80 <argint+0x40>
80104e68:	8d 53 08             	lea    0x8(%ebx),%edx
80104e6b:	39 d0                	cmp    %edx,%eax
80104e6d:	72 11                	jb     80104e80 <argint+0x40>
80104e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e72:	8b 53 04             	mov    0x4(%ebx),%edx
80104e75:	89 10                	mov    %edx,(%eax)
80104e77:	31 c0                	xor    %eax,%eax
80104e79:	5b                   	pop    %ebx
80104e7a:	5e                   	pop    %esi
80104e7b:	5d                   	pop    %ebp
80104e7c:	c3                   	ret    
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e85:	eb f2                	jmp    80104e79 <argint+0x39>
80104e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e8e:	66 90                	xchg   %ax,%ax

80104e90 <argptr>:
80104e90:	f3 0f 1e fb          	endbr32 
80104e94:	55                   	push   %ebp
80104e95:	89 e5                	mov    %esp,%ebp
80104e97:	56                   	push   %esi
80104e98:	53                   	push   %ebx
80104e99:	83 ec 10             	sub    $0x10,%esp
80104e9c:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104e9f:	e8 ac ef ff ff       	call   80103e50 <myproc>
80104ea4:	83 ec 08             	sub    $0x8,%esp
80104ea7:	89 c6                	mov    %eax,%esi
80104ea9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eac:	50                   	push   %eax
80104ead:	ff 75 08             	pushl  0x8(%ebp)
80104eb0:	e8 8b ff ff ff       	call   80104e40 <argint>
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	85 c0                	test   %eax,%eax
80104eba:	78 24                	js     80104ee0 <argptr+0x50>
80104ebc:	85 db                	test   %ebx,%ebx
80104ebe:	78 20                	js     80104ee0 <argptr+0x50>
80104ec0:	8b 16                	mov    (%esi),%edx
80104ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ec5:	39 c2                	cmp    %eax,%edx
80104ec7:	76 17                	jbe    80104ee0 <argptr+0x50>
80104ec9:	01 c3                	add    %eax,%ebx
80104ecb:	39 da                	cmp    %ebx,%edx
80104ecd:	72 11                	jb     80104ee0 <argptr+0x50>
80104ecf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ed2:	89 02                	mov    %eax,(%edx)
80104ed4:	31 c0                	xor    %eax,%eax
80104ed6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ed9:	5b                   	pop    %ebx
80104eda:	5e                   	pop    %esi
80104edb:	5d                   	pop    %ebp
80104edc:	c3                   	ret    
80104edd:	8d 76 00             	lea    0x0(%esi),%esi
80104ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ee5:	eb ef                	jmp    80104ed6 <argptr+0x46>
80104ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eee:	66 90                	xchg   %ax,%ax

80104ef0 <argstr>:
80104ef0:	f3 0f 1e fb          	endbr32 
80104ef4:	55                   	push   %ebp
80104ef5:	89 e5                	mov    %esp,%ebp
80104ef7:	83 ec 20             	sub    $0x20,%esp
80104efa:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104efd:	50                   	push   %eax
80104efe:	ff 75 08             	pushl  0x8(%ebp)
80104f01:	e8 3a ff ff ff       	call   80104e40 <argint>
80104f06:	83 c4 10             	add    $0x10,%esp
80104f09:	85 c0                	test   %eax,%eax
80104f0b:	78 13                	js     80104f20 <argstr+0x30>
80104f0d:	83 ec 08             	sub    $0x8,%esp
80104f10:	ff 75 0c             	pushl  0xc(%ebp)
80104f13:	ff 75 f4             	pushl  -0xc(%ebp)
80104f16:	e8 c5 fe ff ff       	call   80104de0 <fetchstr>
80104f1b:	83 c4 10             	add    $0x10,%esp
80104f1e:	c9                   	leave  
80104f1f:	c3                   	ret    
80104f20:	c9                   	leave  
80104f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f26:	c3                   	ret    
80104f27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2e:	66 90                	xchg   %ax,%ax

80104f30 <syscall>:
80104f30:	f3 0f 1e fb          	endbr32 
80104f34:	55                   	push   %ebp
80104f35:	89 e5                	mov    %esp,%ebp
80104f37:	53                   	push   %ebx
80104f38:	83 ec 04             	sub    $0x4,%esp
80104f3b:	e8 10 ef ff ff       	call   80103e50 <myproc>
80104f40:	89 c3                	mov    %eax,%ebx
80104f42:	8b 40 18             	mov    0x18(%eax),%eax
80104f45:	8b 40 1c             	mov    0x1c(%eax),%eax
80104f48:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f4b:	83 fa 14             	cmp    $0x14,%edx
80104f4e:	77 20                	ja     80104f70 <syscall+0x40>
80104f50:	8b 14 85 00 7d 10 80 	mov    -0x7fef8300(,%eax,4),%edx
80104f57:	85 d2                	test   %edx,%edx
80104f59:	74 15                	je     80104f70 <syscall+0x40>
80104f5b:	ff d2                	call   *%edx
80104f5d:	89 c2                	mov    %eax,%edx
80104f5f:	8b 43 18             	mov    0x18(%ebx),%eax
80104f62:	89 50 1c             	mov    %edx,0x1c(%eax)
80104f65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f68:	c9                   	leave  
80104f69:	c3                   	ret    
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f70:	50                   	push   %eax
80104f71:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104f74:	50                   	push   %eax
80104f75:	ff 73 10             	pushl  0x10(%ebx)
80104f78:	68 dd 7c 10 80       	push   $0x80107cdd
80104f7d:	e8 3e b9 ff ff       	call   801008c0 <cprintf>
80104f82:	8b 43 18             	mov    0x18(%ebx),%eax
80104f85:	83 c4 10             	add    $0x10,%esp
80104f88:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104f8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f92:	c9                   	leave  
80104f93:	c3                   	ret    
80104f94:	66 90                	xchg   %ax,%ax
80104f96:	66 90                	xchg   %ax,%ax
80104f98:	66 90                	xchg   %ax,%ax
80104f9a:	66 90                	xchg   %ax,%ax
80104f9c:	66 90                	xchg   %ax,%ax
80104f9e:	66 90                	xchg   %ax,%ax

80104fa0 <create>:
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	57                   	push   %edi
80104fa4:	56                   	push   %esi
80104fa5:	8d 7d da             	lea    -0x26(%ebp),%edi
80104fa8:	53                   	push   %ebx
80104fa9:	83 ec 34             	sub    $0x34,%esp
80104fac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104faf:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104fb2:	57                   	push   %edi
80104fb3:	50                   	push   %eax
80104fb4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104fb7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80104fba:	e8 81 d5 ff ff       	call   80102540 <nameiparent>
80104fbf:	83 c4 10             	add    $0x10,%esp
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	0f 84 46 01 00 00    	je     80105110 <create+0x170>
80104fca:	83 ec 0c             	sub    $0xc,%esp
80104fcd:	89 c3                	mov    %eax,%ebx
80104fcf:	50                   	push   %eax
80104fd0:	e8 7b cc ff ff       	call   80101c50 <ilock>
80104fd5:	83 c4 0c             	add    $0xc,%esp
80104fd8:	6a 00                	push   $0x0
80104fda:	57                   	push   %edi
80104fdb:	53                   	push   %ebx
80104fdc:	e8 bf d1 ff ff       	call   801021a0 <dirlookup>
80104fe1:	83 c4 10             	add    $0x10,%esp
80104fe4:	89 c6                	mov    %eax,%esi
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	74 56                	je     80105040 <create+0xa0>
80104fea:	83 ec 0c             	sub    $0xc,%esp
80104fed:	53                   	push   %ebx
80104fee:	e8 fd ce ff ff       	call   80101ef0 <iunlockput>
80104ff3:	89 34 24             	mov    %esi,(%esp)
80104ff6:	e8 55 cc ff ff       	call   80101c50 <ilock>
80104ffb:	83 c4 10             	add    $0x10,%esp
80104ffe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105003:	75 1b                	jne    80105020 <create+0x80>
80105005:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010500a:	75 14                	jne    80105020 <create+0x80>
8010500c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010500f:	89 f0                	mov    %esi,%eax
80105011:	5b                   	pop    %ebx
80105012:	5e                   	pop    %esi
80105013:	5f                   	pop    %edi
80105014:	5d                   	pop    %ebp
80105015:	c3                   	ret    
80105016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010501d:	8d 76 00             	lea    0x0(%esi),%esi
80105020:	83 ec 0c             	sub    $0xc,%esp
80105023:	56                   	push   %esi
80105024:	31 f6                	xor    %esi,%esi
80105026:	e8 c5 ce ff ff       	call   80101ef0 <iunlockput>
8010502b:	83 c4 10             	add    $0x10,%esp
8010502e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105031:	89 f0                	mov    %esi,%eax
80105033:	5b                   	pop    %ebx
80105034:	5e                   	pop    %esi
80105035:	5f                   	pop    %edi
80105036:	5d                   	pop    %ebp
80105037:	c3                   	ret    
80105038:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503f:	90                   	nop
80105040:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105044:	83 ec 08             	sub    $0x8,%esp
80105047:	50                   	push   %eax
80105048:	ff 33                	pushl  (%ebx)
8010504a:	e8 81 ca ff ff       	call   80101ad0 <ialloc>
8010504f:	83 c4 10             	add    $0x10,%esp
80105052:	89 c6                	mov    %eax,%esi
80105054:	85 c0                	test   %eax,%eax
80105056:	0f 84 cd 00 00 00    	je     80105129 <create+0x189>
8010505c:	83 ec 0c             	sub    $0xc,%esp
8010505f:	50                   	push   %eax
80105060:	e8 eb cb ff ff       	call   80101c50 <ilock>
80105065:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105069:	66 89 46 52          	mov    %ax,0x52(%esi)
8010506d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105071:	66 89 46 54          	mov    %ax,0x54(%esi)
80105075:	b8 01 00 00 00       	mov    $0x1,%eax
8010507a:	66 89 46 56          	mov    %ax,0x56(%esi)
8010507e:	89 34 24             	mov    %esi,(%esp)
80105081:	e8 0a cb ff ff       	call   80101b90 <iupdate>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010508e:	74 30                	je     801050c0 <create+0x120>
80105090:	83 ec 04             	sub    $0x4,%esp
80105093:	ff 76 04             	pushl  0x4(%esi)
80105096:	57                   	push   %edi
80105097:	53                   	push   %ebx
80105098:	e8 c3 d3 ff ff       	call   80102460 <dirlink>
8010509d:	83 c4 10             	add    $0x10,%esp
801050a0:	85 c0                	test   %eax,%eax
801050a2:	78 78                	js     8010511c <create+0x17c>
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	53                   	push   %ebx
801050a8:	e8 43 ce ff ff       	call   80101ef0 <iunlockput>
801050ad:	83 c4 10             	add    $0x10,%esp
801050b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050b3:	89 f0                	mov    %esi,%eax
801050b5:	5b                   	pop    %ebx
801050b6:	5e                   	pop    %esi
801050b7:	5f                   	pop    %edi
801050b8:	5d                   	pop    %ebp
801050b9:	c3                   	ret    
801050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050c0:	83 ec 0c             	sub    $0xc,%esp
801050c3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801050c8:	53                   	push   %ebx
801050c9:	e8 c2 ca ff ff       	call   80101b90 <iupdate>
801050ce:	83 c4 0c             	add    $0xc,%esp
801050d1:	ff 76 04             	pushl  0x4(%esi)
801050d4:	68 74 7d 10 80       	push   $0x80107d74
801050d9:	56                   	push   %esi
801050da:	e8 81 d3 ff ff       	call   80102460 <dirlink>
801050df:	83 c4 10             	add    $0x10,%esp
801050e2:	85 c0                	test   %eax,%eax
801050e4:	78 18                	js     801050fe <create+0x15e>
801050e6:	83 ec 04             	sub    $0x4,%esp
801050e9:	ff 73 04             	pushl  0x4(%ebx)
801050ec:	68 73 7d 10 80       	push   $0x80107d73
801050f1:	56                   	push   %esi
801050f2:	e8 69 d3 ff ff       	call   80102460 <dirlink>
801050f7:	83 c4 10             	add    $0x10,%esp
801050fa:	85 c0                	test   %eax,%eax
801050fc:	79 92                	jns    80105090 <create+0xf0>
801050fe:	83 ec 0c             	sub    $0xc,%esp
80105101:	68 67 7d 10 80       	push   $0x80107d67
80105106:	e8 85 b2 ff ff       	call   80100390 <panic>
8010510b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010510f:	90                   	nop
80105110:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105113:	31 f6                	xor    %esi,%esi
80105115:	5b                   	pop    %ebx
80105116:	89 f0                	mov    %esi,%eax
80105118:	5e                   	pop    %esi
80105119:	5f                   	pop    %edi
8010511a:	5d                   	pop    %ebp
8010511b:	c3                   	ret    
8010511c:	83 ec 0c             	sub    $0xc,%esp
8010511f:	68 76 7d 10 80       	push   $0x80107d76
80105124:	e8 67 b2 ff ff       	call   80100390 <panic>
80105129:	83 ec 0c             	sub    $0xc,%esp
8010512c:	68 58 7d 10 80       	push   $0x80107d58
80105131:	e8 5a b2 ff ff       	call   80100390 <panic>
80105136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513d:	8d 76 00             	lea    0x0(%esi),%esi

80105140 <argfd.constprop.0>:
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	56                   	push   %esi
80105144:	89 d6                	mov    %edx,%esi
80105146:	53                   	push   %ebx
80105147:	89 c3                	mov    %eax,%ebx
80105149:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010514c:	83 ec 18             	sub    $0x18,%esp
8010514f:	50                   	push   %eax
80105150:	6a 00                	push   $0x0
80105152:	e8 e9 fc ff ff       	call   80104e40 <argint>
80105157:	83 c4 10             	add    $0x10,%esp
8010515a:	85 c0                	test   %eax,%eax
8010515c:	78 2a                	js     80105188 <argfd.constprop.0+0x48>
8010515e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105162:	77 24                	ja     80105188 <argfd.constprop.0+0x48>
80105164:	e8 e7 ec ff ff       	call   80103e50 <myproc>
80105169:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010516c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105170:	85 c0                	test   %eax,%eax
80105172:	74 14                	je     80105188 <argfd.constprop.0+0x48>
80105174:	85 db                	test   %ebx,%ebx
80105176:	74 02                	je     8010517a <argfd.constprop.0+0x3a>
80105178:	89 13                	mov    %edx,(%ebx)
8010517a:	89 06                	mov    %eax,(%esi)
8010517c:	31 c0                	xor    %eax,%eax
8010517e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105181:	5b                   	pop    %ebx
80105182:	5e                   	pop    %esi
80105183:	5d                   	pop    %ebp
80105184:	c3                   	ret    
80105185:	8d 76 00             	lea    0x0(%esi),%esi
80105188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010518d:	eb ef                	jmp    8010517e <argfd.constprop.0+0x3e>
8010518f:	90                   	nop

80105190 <sys_dup>:
80105190:	f3 0f 1e fb          	endbr32 
80105194:	55                   	push   %ebp
80105195:	31 c0                	xor    %eax,%eax
80105197:	89 e5                	mov    %esp,%ebp
80105199:	56                   	push   %esi
8010519a:	53                   	push   %ebx
8010519b:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010519e:	83 ec 10             	sub    $0x10,%esp
801051a1:	e8 9a ff ff ff       	call   80105140 <argfd.constprop.0>
801051a6:	85 c0                	test   %eax,%eax
801051a8:	78 1e                	js     801051c8 <sys_dup+0x38>
801051aa:	8b 75 f4             	mov    -0xc(%ebp),%esi
801051ad:	31 db                	xor    %ebx,%ebx
801051af:	e8 9c ec ff ff       	call   80103e50 <myproc>
801051b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051b8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801051bc:	85 d2                	test   %edx,%edx
801051be:	74 20                	je     801051e0 <sys_dup+0x50>
801051c0:	83 c3 01             	add    $0x1,%ebx
801051c3:	83 fb 10             	cmp    $0x10,%ebx
801051c6:	75 f0                	jne    801051b8 <sys_dup+0x28>
801051c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051cb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051d0:	89 d8                	mov    %ebx,%eax
801051d2:	5b                   	pop    %ebx
801051d3:	5e                   	pop    %esi
801051d4:	5d                   	pop    %ebp
801051d5:	c3                   	ret    
801051d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051dd:	8d 76 00             	lea    0x0(%esi),%esi
801051e0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
801051e4:	83 ec 0c             	sub    $0xc,%esp
801051e7:	ff 75 f4             	pushl  -0xc(%ebp)
801051ea:	e8 71 c1 ff ff       	call   80101360 <filedup>
801051ef:	83 c4 10             	add    $0x10,%esp
801051f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051f5:	89 d8                	mov    %ebx,%eax
801051f7:	5b                   	pop    %ebx
801051f8:	5e                   	pop    %esi
801051f9:	5d                   	pop    %ebp
801051fa:	c3                   	ret    
801051fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051ff:	90                   	nop

80105200 <sys_read>:
80105200:	f3 0f 1e fb          	endbr32 
80105204:	55                   	push   %ebp
80105205:	31 c0                	xor    %eax,%eax
80105207:	89 e5                	mov    %esp,%ebp
80105209:	83 ec 18             	sub    $0x18,%esp
8010520c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010520f:	e8 2c ff ff ff       	call   80105140 <argfd.constprop.0>
80105214:	85 c0                	test   %eax,%eax
80105216:	78 48                	js     80105260 <sys_read+0x60>
80105218:	83 ec 08             	sub    $0x8,%esp
8010521b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010521e:	50                   	push   %eax
8010521f:	6a 02                	push   $0x2
80105221:	e8 1a fc ff ff       	call   80104e40 <argint>
80105226:	83 c4 10             	add    $0x10,%esp
80105229:	85 c0                	test   %eax,%eax
8010522b:	78 33                	js     80105260 <sys_read+0x60>
8010522d:	83 ec 04             	sub    $0x4,%esp
80105230:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105233:	ff 75 f0             	pushl  -0x10(%ebp)
80105236:	50                   	push   %eax
80105237:	6a 01                	push   $0x1
80105239:	e8 52 fc ff ff       	call   80104e90 <argptr>
8010523e:	83 c4 10             	add    $0x10,%esp
80105241:	85 c0                	test   %eax,%eax
80105243:	78 1b                	js     80105260 <sys_read+0x60>
80105245:	83 ec 04             	sub    $0x4,%esp
80105248:	ff 75 f0             	pushl  -0x10(%ebp)
8010524b:	ff 75 f4             	pushl  -0xc(%ebp)
8010524e:	ff 75 ec             	pushl  -0x14(%ebp)
80105251:	e8 8a c2 ff ff       	call   801014e0 <fileread>
80105256:	83 c4 10             	add    $0x10,%esp
80105259:	c9                   	leave  
8010525a:	c3                   	ret    
8010525b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010525f:	90                   	nop
80105260:	c9                   	leave  
80105261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105266:	c3                   	ret    
80105267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526e:	66 90                	xchg   %ax,%ax

80105270 <sys_write>:
80105270:	f3 0f 1e fb          	endbr32 
80105274:	55                   	push   %ebp
80105275:	31 c0                	xor    %eax,%eax
80105277:	89 e5                	mov    %esp,%ebp
80105279:	83 ec 18             	sub    $0x18,%esp
8010527c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010527f:	e8 bc fe ff ff       	call   80105140 <argfd.constprop.0>
80105284:	85 c0                	test   %eax,%eax
80105286:	78 48                	js     801052d0 <sys_write+0x60>
80105288:	83 ec 08             	sub    $0x8,%esp
8010528b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010528e:	50                   	push   %eax
8010528f:	6a 02                	push   $0x2
80105291:	e8 aa fb ff ff       	call   80104e40 <argint>
80105296:	83 c4 10             	add    $0x10,%esp
80105299:	85 c0                	test   %eax,%eax
8010529b:	78 33                	js     801052d0 <sys_write+0x60>
8010529d:	83 ec 04             	sub    $0x4,%esp
801052a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052a3:	ff 75 f0             	pushl  -0x10(%ebp)
801052a6:	50                   	push   %eax
801052a7:	6a 01                	push   $0x1
801052a9:	e8 e2 fb ff ff       	call   80104e90 <argptr>
801052ae:	83 c4 10             	add    $0x10,%esp
801052b1:	85 c0                	test   %eax,%eax
801052b3:	78 1b                	js     801052d0 <sys_write+0x60>
801052b5:	83 ec 04             	sub    $0x4,%esp
801052b8:	ff 75 f0             	pushl  -0x10(%ebp)
801052bb:	ff 75 f4             	pushl  -0xc(%ebp)
801052be:	ff 75 ec             	pushl  -0x14(%ebp)
801052c1:	e8 ba c2 ff ff       	call   80101580 <filewrite>
801052c6:	83 c4 10             	add    $0x10,%esp
801052c9:	c9                   	leave  
801052ca:	c3                   	ret    
801052cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052cf:	90                   	nop
801052d0:	c9                   	leave  
801052d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052d6:	c3                   	ret    
801052d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052de:	66 90                	xchg   %ax,%ax

801052e0 <sys_close>:
801052e0:	f3 0f 1e fb          	endbr32 
801052e4:	55                   	push   %ebp
801052e5:	89 e5                	mov    %esp,%ebp
801052e7:	83 ec 18             	sub    $0x18,%esp
801052ea:	8d 55 f4             	lea    -0xc(%ebp),%edx
801052ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052f0:	e8 4b fe ff ff       	call   80105140 <argfd.constprop.0>
801052f5:	85 c0                	test   %eax,%eax
801052f7:	78 27                	js     80105320 <sys_close+0x40>
801052f9:	e8 52 eb ff ff       	call   80103e50 <myproc>
801052fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105301:	83 ec 0c             	sub    $0xc,%esp
80105304:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010530b:	00 
8010530c:	ff 75 f4             	pushl  -0xc(%ebp)
8010530f:	e8 9c c0 ff ff       	call   801013b0 <fileclose>
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	31 c0                	xor    %eax,%eax
80105319:	c9                   	leave  
8010531a:	c3                   	ret    
8010531b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010531f:	90                   	nop
80105320:	c9                   	leave  
80105321:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105326:	c3                   	ret    
80105327:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010532e:	66 90                	xchg   %ax,%ax

80105330 <sys_fstat>:
80105330:	f3 0f 1e fb          	endbr32 
80105334:	55                   	push   %ebp
80105335:	31 c0                	xor    %eax,%eax
80105337:	89 e5                	mov    %esp,%ebp
80105339:	83 ec 18             	sub    $0x18,%esp
8010533c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010533f:	e8 fc fd ff ff       	call   80105140 <argfd.constprop.0>
80105344:	85 c0                	test   %eax,%eax
80105346:	78 30                	js     80105378 <sys_fstat+0x48>
80105348:	83 ec 04             	sub    $0x4,%esp
8010534b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010534e:	6a 14                	push   $0x14
80105350:	50                   	push   %eax
80105351:	6a 01                	push   $0x1
80105353:	e8 38 fb ff ff       	call   80104e90 <argptr>
80105358:	83 c4 10             	add    $0x10,%esp
8010535b:	85 c0                	test   %eax,%eax
8010535d:	78 19                	js     80105378 <sys_fstat+0x48>
8010535f:	83 ec 08             	sub    $0x8,%esp
80105362:	ff 75 f4             	pushl  -0xc(%ebp)
80105365:	ff 75 f0             	pushl  -0x10(%ebp)
80105368:	e8 23 c1 ff ff       	call   80101490 <filestat>
8010536d:	83 c4 10             	add    $0x10,%esp
80105370:	c9                   	leave  
80105371:	c3                   	ret    
80105372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105378:	c9                   	leave  
80105379:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537e:	c3                   	ret    
8010537f:	90                   	nop

80105380 <sys_link>:
80105380:	f3 0f 1e fb          	endbr32 
80105384:	55                   	push   %ebp
80105385:	89 e5                	mov    %esp,%ebp
80105387:	57                   	push   %edi
80105388:	56                   	push   %esi
80105389:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010538c:	53                   	push   %ebx
8010538d:	83 ec 34             	sub    $0x34,%esp
80105390:	50                   	push   %eax
80105391:	6a 00                	push   $0x0
80105393:	e8 58 fb ff ff       	call   80104ef0 <argstr>
80105398:	83 c4 10             	add    $0x10,%esp
8010539b:	85 c0                	test   %eax,%eax
8010539d:	0f 88 ff 00 00 00    	js     801054a2 <sys_link+0x122>
801053a3:	83 ec 08             	sub    $0x8,%esp
801053a6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801053a9:	50                   	push   %eax
801053aa:	6a 01                	push   $0x1
801053ac:	e8 3f fb ff ff       	call   80104ef0 <argstr>
801053b1:	83 c4 10             	add    $0x10,%esp
801053b4:	85 c0                	test   %eax,%eax
801053b6:	0f 88 e6 00 00 00    	js     801054a2 <sys_link+0x122>
801053bc:	e8 5f de ff ff       	call   80103220 <begin_op>
801053c1:	83 ec 0c             	sub    $0xc,%esp
801053c4:	ff 75 d4             	pushl  -0x2c(%ebp)
801053c7:	e8 54 d1 ff ff       	call   80102520 <namei>
801053cc:	83 c4 10             	add    $0x10,%esp
801053cf:	89 c3                	mov    %eax,%ebx
801053d1:	85 c0                	test   %eax,%eax
801053d3:	0f 84 e8 00 00 00    	je     801054c1 <sys_link+0x141>
801053d9:	83 ec 0c             	sub    $0xc,%esp
801053dc:	50                   	push   %eax
801053dd:	e8 6e c8 ff ff       	call   80101c50 <ilock>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053ea:	0f 84 b9 00 00 00    	je     801054a9 <sys_link+0x129>
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801053f8:	8d 7d da             	lea    -0x26(%ebp),%edi
801053fb:	53                   	push   %ebx
801053fc:	e8 8f c7 ff ff       	call   80101b90 <iupdate>
80105401:	89 1c 24             	mov    %ebx,(%esp)
80105404:	e8 27 c9 ff ff       	call   80101d30 <iunlock>
80105409:	58                   	pop    %eax
8010540a:	5a                   	pop    %edx
8010540b:	57                   	push   %edi
8010540c:	ff 75 d0             	pushl  -0x30(%ebp)
8010540f:	e8 2c d1 ff ff       	call   80102540 <nameiparent>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	89 c6                	mov    %eax,%esi
80105419:	85 c0                	test   %eax,%eax
8010541b:	74 5f                	je     8010547c <sys_link+0xfc>
8010541d:	83 ec 0c             	sub    $0xc,%esp
80105420:	50                   	push   %eax
80105421:	e8 2a c8 ff ff       	call   80101c50 <ilock>
80105426:	8b 03                	mov    (%ebx),%eax
80105428:	83 c4 10             	add    $0x10,%esp
8010542b:	39 06                	cmp    %eax,(%esi)
8010542d:	75 41                	jne    80105470 <sys_link+0xf0>
8010542f:	83 ec 04             	sub    $0x4,%esp
80105432:	ff 73 04             	pushl  0x4(%ebx)
80105435:	57                   	push   %edi
80105436:	56                   	push   %esi
80105437:	e8 24 d0 ff ff       	call   80102460 <dirlink>
8010543c:	83 c4 10             	add    $0x10,%esp
8010543f:	85 c0                	test   %eax,%eax
80105441:	78 2d                	js     80105470 <sys_link+0xf0>
80105443:	83 ec 0c             	sub    $0xc,%esp
80105446:	56                   	push   %esi
80105447:	e8 a4 ca ff ff       	call   80101ef0 <iunlockput>
8010544c:	89 1c 24             	mov    %ebx,(%esp)
8010544f:	e8 2c c9 ff ff       	call   80101d80 <iput>
80105454:	e8 37 de ff ff       	call   80103290 <end_op>
80105459:	83 c4 10             	add    $0x10,%esp
8010545c:	31 c0                	xor    %eax,%eax
8010545e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105461:	5b                   	pop    %ebx
80105462:	5e                   	pop    %esi
80105463:	5f                   	pop    %edi
80105464:	5d                   	pop    %ebp
80105465:	c3                   	ret    
80105466:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	56                   	push   %esi
80105474:	e8 77 ca ff ff       	call   80101ef0 <iunlockput>
80105479:	83 c4 10             	add    $0x10,%esp
8010547c:	83 ec 0c             	sub    $0xc,%esp
8010547f:	53                   	push   %ebx
80105480:	e8 cb c7 ff ff       	call   80101c50 <ilock>
80105485:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010548a:	89 1c 24             	mov    %ebx,(%esp)
8010548d:	e8 fe c6 ff ff       	call   80101b90 <iupdate>
80105492:	89 1c 24             	mov    %ebx,(%esp)
80105495:	e8 56 ca ff ff       	call   80101ef0 <iunlockput>
8010549a:	e8 f1 dd ff ff       	call   80103290 <end_op>
8010549f:	83 c4 10             	add    $0x10,%esp
801054a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a7:	eb b5                	jmp    8010545e <sys_link+0xde>
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	53                   	push   %ebx
801054ad:	e8 3e ca ff ff       	call   80101ef0 <iunlockput>
801054b2:	e8 d9 dd ff ff       	call   80103290 <end_op>
801054b7:	83 c4 10             	add    $0x10,%esp
801054ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054bf:	eb 9d                	jmp    8010545e <sys_link+0xde>
801054c1:	e8 ca dd ff ff       	call   80103290 <end_op>
801054c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054cb:	eb 91                	jmp    8010545e <sys_link+0xde>
801054cd:	8d 76 00             	lea    0x0(%esi),%esi

801054d0 <sys_unlink>:
801054d0:	f3 0f 1e fb          	endbr32 
801054d4:	55                   	push   %ebp
801054d5:	89 e5                	mov    %esp,%ebp
801054d7:	57                   	push   %edi
801054d8:	56                   	push   %esi
801054d9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801054dc:	53                   	push   %ebx
801054dd:	83 ec 54             	sub    $0x54,%esp
801054e0:	50                   	push   %eax
801054e1:	6a 00                	push   $0x0
801054e3:	e8 08 fa ff ff       	call   80104ef0 <argstr>
801054e8:	83 c4 10             	add    $0x10,%esp
801054eb:	85 c0                	test   %eax,%eax
801054ed:	0f 88 7d 01 00 00    	js     80105670 <sys_unlink+0x1a0>
801054f3:	e8 28 dd ff ff       	call   80103220 <begin_op>
801054f8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801054fb:	83 ec 08             	sub    $0x8,%esp
801054fe:	53                   	push   %ebx
801054ff:	ff 75 c0             	pushl  -0x40(%ebp)
80105502:	e8 39 d0 ff ff       	call   80102540 <nameiparent>
80105507:	83 c4 10             	add    $0x10,%esp
8010550a:	89 c6                	mov    %eax,%esi
8010550c:	85 c0                	test   %eax,%eax
8010550e:	0f 84 66 01 00 00    	je     8010567a <sys_unlink+0x1aa>
80105514:	83 ec 0c             	sub    $0xc,%esp
80105517:	50                   	push   %eax
80105518:	e8 33 c7 ff ff       	call   80101c50 <ilock>
8010551d:	58                   	pop    %eax
8010551e:	5a                   	pop    %edx
8010551f:	68 74 7d 10 80       	push   $0x80107d74
80105524:	53                   	push   %ebx
80105525:	e8 56 cc ff ff       	call   80102180 <namecmp>
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	85 c0                	test   %eax,%eax
8010552f:	0f 84 03 01 00 00    	je     80105638 <sys_unlink+0x168>
80105535:	83 ec 08             	sub    $0x8,%esp
80105538:	68 73 7d 10 80       	push   $0x80107d73
8010553d:	53                   	push   %ebx
8010553e:	e8 3d cc ff ff       	call   80102180 <namecmp>
80105543:	83 c4 10             	add    $0x10,%esp
80105546:	85 c0                	test   %eax,%eax
80105548:	0f 84 ea 00 00 00    	je     80105638 <sys_unlink+0x168>
8010554e:	83 ec 04             	sub    $0x4,%esp
80105551:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105554:	50                   	push   %eax
80105555:	53                   	push   %ebx
80105556:	56                   	push   %esi
80105557:	e8 44 cc ff ff       	call   801021a0 <dirlookup>
8010555c:	83 c4 10             	add    $0x10,%esp
8010555f:	89 c3                	mov    %eax,%ebx
80105561:	85 c0                	test   %eax,%eax
80105563:	0f 84 cf 00 00 00    	je     80105638 <sys_unlink+0x168>
80105569:	83 ec 0c             	sub    $0xc,%esp
8010556c:	50                   	push   %eax
8010556d:	e8 de c6 ff ff       	call   80101c50 <ilock>
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010557a:	0f 8e 23 01 00 00    	jle    801056a3 <sys_unlink+0x1d3>
80105580:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105585:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105588:	74 66                	je     801055f0 <sys_unlink+0x120>
8010558a:	83 ec 04             	sub    $0x4,%esp
8010558d:	6a 10                	push   $0x10
8010558f:	6a 00                	push   $0x0
80105591:	57                   	push   %edi
80105592:	e8 c9 f5 ff ff       	call   80104b60 <memset>
80105597:	6a 10                	push   $0x10
80105599:	ff 75 c4             	pushl  -0x3c(%ebp)
8010559c:	57                   	push   %edi
8010559d:	56                   	push   %esi
8010559e:	e8 ad ca ff ff       	call   80102050 <writei>
801055a3:	83 c4 20             	add    $0x20,%esp
801055a6:	83 f8 10             	cmp    $0x10,%eax
801055a9:	0f 85 e7 00 00 00    	jne    80105696 <sys_unlink+0x1c6>
801055af:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055b4:	0f 84 96 00 00 00    	je     80105650 <sys_unlink+0x180>
801055ba:	83 ec 0c             	sub    $0xc,%esp
801055bd:	56                   	push   %esi
801055be:	e8 2d c9 ff ff       	call   80101ef0 <iunlockput>
801055c3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
801055c8:	89 1c 24             	mov    %ebx,(%esp)
801055cb:	e8 c0 c5 ff ff       	call   80101b90 <iupdate>
801055d0:	89 1c 24             	mov    %ebx,(%esp)
801055d3:	e8 18 c9 ff ff       	call   80101ef0 <iunlockput>
801055d8:	e8 b3 dc ff ff       	call   80103290 <end_op>
801055dd:	83 c4 10             	add    $0x10,%esp
801055e0:	31 c0                	xor    %eax,%eax
801055e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055e5:	5b                   	pop    %ebx
801055e6:	5e                   	pop    %esi
801055e7:	5f                   	pop    %edi
801055e8:	5d                   	pop    %ebp
801055e9:	c3                   	ret    
801055ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801055f4:	76 94                	jbe    8010558a <sys_unlink+0xba>
801055f6:	ba 20 00 00 00       	mov    $0x20,%edx
801055fb:	eb 0b                	jmp    80105608 <sys_unlink+0x138>
801055fd:	8d 76 00             	lea    0x0(%esi),%esi
80105600:	83 c2 10             	add    $0x10,%edx
80105603:	39 53 58             	cmp    %edx,0x58(%ebx)
80105606:	76 82                	jbe    8010558a <sys_unlink+0xba>
80105608:	6a 10                	push   $0x10
8010560a:	52                   	push   %edx
8010560b:	57                   	push   %edi
8010560c:	53                   	push   %ebx
8010560d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105610:	e8 3b c9 ff ff       	call   80101f50 <readi>
80105615:	83 c4 10             	add    $0x10,%esp
80105618:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010561b:	83 f8 10             	cmp    $0x10,%eax
8010561e:	75 69                	jne    80105689 <sys_unlink+0x1b9>
80105620:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105625:	74 d9                	je     80105600 <sys_unlink+0x130>
80105627:	83 ec 0c             	sub    $0xc,%esp
8010562a:	53                   	push   %ebx
8010562b:	e8 c0 c8 ff ff       	call   80101ef0 <iunlockput>
80105630:	83 c4 10             	add    $0x10,%esp
80105633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105637:	90                   	nop
80105638:	83 ec 0c             	sub    $0xc,%esp
8010563b:	56                   	push   %esi
8010563c:	e8 af c8 ff ff       	call   80101ef0 <iunlockput>
80105641:	e8 4a dc ff ff       	call   80103290 <end_op>
80105646:	83 c4 10             	add    $0x10,%esp
80105649:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564e:	eb 92                	jmp    801055e2 <sys_unlink+0x112>
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
80105658:	56                   	push   %esi
80105659:	e8 32 c5 ff ff       	call   80101b90 <iupdate>
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	e9 54 ff ff ff       	jmp    801055ba <sys_unlink+0xea>
80105666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566d:	8d 76 00             	lea    0x0(%esi),%esi
80105670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105675:	e9 68 ff ff ff       	jmp    801055e2 <sys_unlink+0x112>
8010567a:	e8 11 dc ff ff       	call   80103290 <end_op>
8010567f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105684:	e9 59 ff ff ff       	jmp    801055e2 <sys_unlink+0x112>
80105689:	83 ec 0c             	sub    $0xc,%esp
8010568c:	68 98 7d 10 80       	push   $0x80107d98
80105691:	e8 fa ac ff ff       	call   80100390 <panic>
80105696:	83 ec 0c             	sub    $0xc,%esp
80105699:	68 aa 7d 10 80       	push   $0x80107daa
8010569e:	e8 ed ac ff ff       	call   80100390 <panic>
801056a3:	83 ec 0c             	sub    $0xc,%esp
801056a6:	68 86 7d 10 80       	push   $0x80107d86
801056ab:	e8 e0 ac ff ff       	call   80100390 <panic>

801056b0 <sys_open>:
801056b0:	f3 0f 1e fb          	endbr32 
801056b4:	55                   	push   %ebp
801056b5:	89 e5                	mov    %esp,%ebp
801056b7:	57                   	push   %edi
801056b8:	56                   	push   %esi
801056b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801056bc:	53                   	push   %ebx
801056bd:	83 ec 24             	sub    $0x24,%esp
801056c0:	50                   	push   %eax
801056c1:	6a 00                	push   $0x0
801056c3:	e8 28 f8 ff ff       	call   80104ef0 <argstr>
801056c8:	83 c4 10             	add    $0x10,%esp
801056cb:	85 c0                	test   %eax,%eax
801056cd:	0f 88 8a 00 00 00    	js     8010575d <sys_open+0xad>
801056d3:	83 ec 08             	sub    $0x8,%esp
801056d6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056d9:	50                   	push   %eax
801056da:	6a 01                	push   $0x1
801056dc:	e8 5f f7 ff ff       	call   80104e40 <argint>
801056e1:	83 c4 10             	add    $0x10,%esp
801056e4:	85 c0                	test   %eax,%eax
801056e6:	78 75                	js     8010575d <sys_open+0xad>
801056e8:	e8 33 db ff ff       	call   80103220 <begin_op>
801056ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801056f1:	75 75                	jne    80105768 <sys_open+0xb8>
801056f3:	83 ec 0c             	sub    $0xc,%esp
801056f6:	ff 75 e0             	pushl  -0x20(%ebp)
801056f9:	e8 22 ce ff ff       	call   80102520 <namei>
801056fe:	83 c4 10             	add    $0x10,%esp
80105701:	89 c6                	mov    %eax,%esi
80105703:	85 c0                	test   %eax,%eax
80105705:	74 7e                	je     80105785 <sys_open+0xd5>
80105707:	83 ec 0c             	sub    $0xc,%esp
8010570a:	50                   	push   %eax
8010570b:	e8 40 c5 ff ff       	call   80101c50 <ilock>
80105710:	83 c4 10             	add    $0x10,%esp
80105713:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105718:	0f 84 c2 00 00 00    	je     801057e0 <sys_open+0x130>
8010571e:	e8 cd bb ff ff       	call   801012f0 <filealloc>
80105723:	89 c7                	mov    %eax,%edi
80105725:	85 c0                	test   %eax,%eax
80105727:	74 23                	je     8010574c <sys_open+0x9c>
80105729:	e8 22 e7 ff ff       	call   80103e50 <myproc>
8010572e:	31 db                	xor    %ebx,%ebx
80105730:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105734:	85 d2                	test   %edx,%edx
80105736:	74 60                	je     80105798 <sys_open+0xe8>
80105738:	83 c3 01             	add    $0x1,%ebx
8010573b:	83 fb 10             	cmp    $0x10,%ebx
8010573e:	75 f0                	jne    80105730 <sys_open+0x80>
80105740:	83 ec 0c             	sub    $0xc,%esp
80105743:	57                   	push   %edi
80105744:	e8 67 bc ff ff       	call   801013b0 <fileclose>
80105749:	83 c4 10             	add    $0x10,%esp
8010574c:	83 ec 0c             	sub    $0xc,%esp
8010574f:	56                   	push   %esi
80105750:	e8 9b c7 ff ff       	call   80101ef0 <iunlockput>
80105755:	e8 36 db ff ff       	call   80103290 <end_op>
8010575a:	83 c4 10             	add    $0x10,%esp
8010575d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105762:	eb 6d                	jmp    801057d1 <sys_open+0x121>
80105764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105768:	83 ec 0c             	sub    $0xc,%esp
8010576b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010576e:	31 c9                	xor    %ecx,%ecx
80105770:	ba 02 00 00 00       	mov    $0x2,%edx
80105775:	6a 00                	push   $0x0
80105777:	e8 24 f8 ff ff       	call   80104fa0 <create>
8010577c:	83 c4 10             	add    $0x10,%esp
8010577f:	89 c6                	mov    %eax,%esi
80105781:	85 c0                	test   %eax,%eax
80105783:	75 99                	jne    8010571e <sys_open+0x6e>
80105785:	e8 06 db ff ff       	call   80103290 <end_op>
8010578a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010578f:	eb 40                	jmp    801057d1 <sys_open+0x121>
80105791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105798:	83 ec 0c             	sub    $0xc,%esp
8010579b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
8010579f:	56                   	push   %esi
801057a0:	e8 8b c5 ff ff       	call   80101d30 <iunlock>
801057a5:	e8 e6 da ff ff       	call   80103290 <end_op>
801057aa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
801057b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801057b3:	83 c4 10             	add    $0x10,%esp
801057b6:	89 77 10             	mov    %esi,0x10(%edi)
801057b9:	89 d0                	mov    %edx,%eax
801057bb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
801057c2:	f7 d0                	not    %eax
801057c4:	83 e0 01             	and    $0x1,%eax
801057c7:	83 e2 03             	and    $0x3,%edx
801057ca:	88 47 08             	mov    %al,0x8(%edi)
801057cd:	0f 95 47 09          	setne  0x9(%edi)
801057d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057d4:	89 d8                	mov    %ebx,%eax
801057d6:	5b                   	pop    %ebx
801057d7:	5e                   	pop    %esi
801057d8:	5f                   	pop    %edi
801057d9:	5d                   	pop    %ebp
801057da:	c3                   	ret    
801057db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057df:	90                   	nop
801057e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801057e3:	85 c9                	test   %ecx,%ecx
801057e5:	0f 84 33 ff ff ff    	je     8010571e <sys_open+0x6e>
801057eb:	e9 5c ff ff ff       	jmp    8010574c <sys_open+0x9c>

801057f0 <sys_mkdir>:
801057f0:	f3 0f 1e fb          	endbr32 
801057f4:	55                   	push   %ebp
801057f5:	89 e5                	mov    %esp,%ebp
801057f7:	83 ec 18             	sub    $0x18,%esp
801057fa:	e8 21 da ff ff       	call   80103220 <begin_op>
801057ff:	83 ec 08             	sub    $0x8,%esp
80105802:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105805:	50                   	push   %eax
80105806:	6a 00                	push   $0x0
80105808:	e8 e3 f6 ff ff       	call   80104ef0 <argstr>
8010580d:	83 c4 10             	add    $0x10,%esp
80105810:	85 c0                	test   %eax,%eax
80105812:	78 34                	js     80105848 <sys_mkdir+0x58>
80105814:	83 ec 0c             	sub    $0xc,%esp
80105817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010581a:	31 c9                	xor    %ecx,%ecx
8010581c:	ba 01 00 00 00       	mov    $0x1,%edx
80105821:	6a 00                	push   $0x0
80105823:	e8 78 f7 ff ff       	call   80104fa0 <create>
80105828:	83 c4 10             	add    $0x10,%esp
8010582b:	85 c0                	test   %eax,%eax
8010582d:	74 19                	je     80105848 <sys_mkdir+0x58>
8010582f:	83 ec 0c             	sub    $0xc,%esp
80105832:	50                   	push   %eax
80105833:	e8 b8 c6 ff ff       	call   80101ef0 <iunlockput>
80105838:	e8 53 da ff ff       	call   80103290 <end_op>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	31 c0                	xor    %eax,%eax
80105842:	c9                   	leave  
80105843:	c3                   	ret    
80105844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105848:	e8 43 da ff ff       	call   80103290 <end_op>
8010584d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105852:	c9                   	leave  
80105853:	c3                   	ret    
80105854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010585f:	90                   	nop

80105860 <sys_mknod>:
80105860:	f3 0f 1e fb          	endbr32 
80105864:	55                   	push   %ebp
80105865:	89 e5                	mov    %esp,%ebp
80105867:	83 ec 18             	sub    $0x18,%esp
8010586a:	e8 b1 d9 ff ff       	call   80103220 <begin_op>
8010586f:	83 ec 08             	sub    $0x8,%esp
80105872:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105875:	50                   	push   %eax
80105876:	6a 00                	push   $0x0
80105878:	e8 73 f6 ff ff       	call   80104ef0 <argstr>
8010587d:	83 c4 10             	add    $0x10,%esp
80105880:	85 c0                	test   %eax,%eax
80105882:	78 64                	js     801058e8 <sys_mknod+0x88>
80105884:	83 ec 08             	sub    $0x8,%esp
80105887:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010588a:	50                   	push   %eax
8010588b:	6a 01                	push   $0x1
8010588d:	e8 ae f5 ff ff       	call   80104e40 <argint>
80105892:	83 c4 10             	add    $0x10,%esp
80105895:	85 c0                	test   %eax,%eax
80105897:	78 4f                	js     801058e8 <sys_mknod+0x88>
80105899:	83 ec 08             	sub    $0x8,%esp
8010589c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010589f:	50                   	push   %eax
801058a0:	6a 02                	push   $0x2
801058a2:	e8 99 f5 ff ff       	call   80104e40 <argint>
801058a7:	83 c4 10             	add    $0x10,%esp
801058aa:	85 c0                	test   %eax,%eax
801058ac:	78 3a                	js     801058e8 <sys_mknod+0x88>
801058ae:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801058b2:	83 ec 0c             	sub    $0xc,%esp
801058b5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801058b9:	ba 03 00 00 00       	mov    $0x3,%edx
801058be:	50                   	push   %eax
801058bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801058c2:	e8 d9 f6 ff ff       	call   80104fa0 <create>
801058c7:	83 c4 10             	add    $0x10,%esp
801058ca:	85 c0                	test   %eax,%eax
801058cc:	74 1a                	je     801058e8 <sys_mknod+0x88>
801058ce:	83 ec 0c             	sub    $0xc,%esp
801058d1:	50                   	push   %eax
801058d2:	e8 19 c6 ff ff       	call   80101ef0 <iunlockput>
801058d7:	e8 b4 d9 ff ff       	call   80103290 <end_op>
801058dc:	83 c4 10             	add    $0x10,%esp
801058df:	31 c0                	xor    %eax,%eax
801058e1:	c9                   	leave  
801058e2:	c3                   	ret    
801058e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058e7:	90                   	nop
801058e8:	e8 a3 d9 ff ff       	call   80103290 <end_op>
801058ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f2:	c9                   	leave  
801058f3:	c3                   	ret    
801058f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058ff:	90                   	nop

80105900 <sys_chdir>:
80105900:	f3 0f 1e fb          	endbr32 
80105904:	55                   	push   %ebp
80105905:	89 e5                	mov    %esp,%ebp
80105907:	56                   	push   %esi
80105908:	53                   	push   %ebx
80105909:	83 ec 10             	sub    $0x10,%esp
8010590c:	e8 3f e5 ff ff       	call   80103e50 <myproc>
80105911:	89 c6                	mov    %eax,%esi
80105913:	e8 08 d9 ff ff       	call   80103220 <begin_op>
80105918:	83 ec 08             	sub    $0x8,%esp
8010591b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010591e:	50                   	push   %eax
8010591f:	6a 00                	push   $0x0
80105921:	e8 ca f5 ff ff       	call   80104ef0 <argstr>
80105926:	83 c4 10             	add    $0x10,%esp
80105929:	85 c0                	test   %eax,%eax
8010592b:	78 73                	js     801059a0 <sys_chdir+0xa0>
8010592d:	83 ec 0c             	sub    $0xc,%esp
80105930:	ff 75 f4             	pushl  -0xc(%ebp)
80105933:	e8 e8 cb ff ff       	call   80102520 <namei>
80105938:	83 c4 10             	add    $0x10,%esp
8010593b:	89 c3                	mov    %eax,%ebx
8010593d:	85 c0                	test   %eax,%eax
8010593f:	74 5f                	je     801059a0 <sys_chdir+0xa0>
80105941:	83 ec 0c             	sub    $0xc,%esp
80105944:	50                   	push   %eax
80105945:	e8 06 c3 ff ff       	call   80101c50 <ilock>
8010594a:	83 c4 10             	add    $0x10,%esp
8010594d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105952:	75 2c                	jne    80105980 <sys_chdir+0x80>
80105954:	83 ec 0c             	sub    $0xc,%esp
80105957:	53                   	push   %ebx
80105958:	e8 d3 c3 ff ff       	call   80101d30 <iunlock>
8010595d:	58                   	pop    %eax
8010595e:	ff 76 68             	pushl  0x68(%esi)
80105961:	e8 1a c4 ff ff       	call   80101d80 <iput>
80105966:	e8 25 d9 ff ff       	call   80103290 <end_op>
8010596b:	89 5e 68             	mov    %ebx,0x68(%esi)
8010596e:	83 c4 10             	add    $0x10,%esp
80105971:	31 c0                	xor    %eax,%eax
80105973:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105976:	5b                   	pop    %ebx
80105977:	5e                   	pop    %esi
80105978:	5d                   	pop    %ebp
80105979:	c3                   	ret    
8010597a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	53                   	push   %ebx
80105984:	e8 67 c5 ff ff       	call   80101ef0 <iunlockput>
80105989:	e8 02 d9 ff ff       	call   80103290 <end_op>
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105996:	eb db                	jmp    80105973 <sys_chdir+0x73>
80105998:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010599f:	90                   	nop
801059a0:	e8 eb d8 ff ff       	call   80103290 <end_op>
801059a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059aa:	eb c7                	jmp    80105973 <sys_chdir+0x73>
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059b0 <sys_exec>:
801059b0:	f3 0f 1e fb          	endbr32 
801059b4:	55                   	push   %ebp
801059b5:	89 e5                	mov    %esp,%ebp
801059b7:	57                   	push   %edi
801059b8:	56                   	push   %esi
801059b9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801059bf:	53                   	push   %ebx
801059c0:	81 ec a4 00 00 00    	sub    $0xa4,%esp
801059c6:	50                   	push   %eax
801059c7:	6a 00                	push   $0x0
801059c9:	e8 22 f5 ff ff       	call   80104ef0 <argstr>
801059ce:	83 c4 10             	add    $0x10,%esp
801059d1:	85 c0                	test   %eax,%eax
801059d3:	0f 88 8b 00 00 00    	js     80105a64 <sys_exec+0xb4>
801059d9:	83 ec 08             	sub    $0x8,%esp
801059dc:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801059e2:	50                   	push   %eax
801059e3:	6a 01                	push   $0x1
801059e5:	e8 56 f4 ff ff       	call   80104e40 <argint>
801059ea:	83 c4 10             	add    $0x10,%esp
801059ed:	85 c0                	test   %eax,%eax
801059ef:	78 73                	js     80105a64 <sys_exec+0xb4>
801059f1:	83 ec 04             	sub    $0x4,%esp
801059f4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801059fa:	31 db                	xor    %ebx,%ebx
801059fc:	68 80 00 00 00       	push   $0x80
80105a01:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105a07:	6a 00                	push   $0x0
80105a09:	50                   	push   %eax
80105a0a:	e8 51 f1 ff ff       	call   80104b60 <memset>
80105a0f:	83 c4 10             	add    $0x10,%esp
80105a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a18:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105a1e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105a25:	83 ec 08             	sub    $0x8,%esp
80105a28:	57                   	push   %edi
80105a29:	01 f0                	add    %esi,%eax
80105a2b:	50                   	push   %eax
80105a2c:	e8 6f f3 ff ff       	call   80104da0 <fetchint>
80105a31:	83 c4 10             	add    $0x10,%esp
80105a34:	85 c0                	test   %eax,%eax
80105a36:	78 2c                	js     80105a64 <sys_exec+0xb4>
80105a38:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105a3e:	85 c0                	test   %eax,%eax
80105a40:	74 36                	je     80105a78 <sys_exec+0xc8>
80105a42:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105a48:	83 ec 08             	sub    $0x8,%esp
80105a4b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105a4e:	52                   	push   %edx
80105a4f:	50                   	push   %eax
80105a50:	e8 8b f3 ff ff       	call   80104de0 <fetchstr>
80105a55:	83 c4 10             	add    $0x10,%esp
80105a58:	85 c0                	test   %eax,%eax
80105a5a:	78 08                	js     80105a64 <sys_exec+0xb4>
80105a5c:	83 c3 01             	add    $0x1,%ebx
80105a5f:	83 fb 20             	cmp    $0x20,%ebx
80105a62:	75 b4                	jne    80105a18 <sys_exec+0x68>
80105a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a6c:	5b                   	pop    %ebx
80105a6d:	5e                   	pop    %esi
80105a6e:	5f                   	pop    %edi
80105a6f:	5d                   	pop    %ebp
80105a70:	c3                   	ret    
80105a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a78:	83 ec 08             	sub    $0x8,%esp
80105a7b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a81:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105a88:	00 00 00 00 
80105a8c:	50                   	push   %eax
80105a8d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105a93:	e8 d8 b4 ff ff       	call   80100f70 <exec>
80105a98:	83 c4 10             	add    $0x10,%esp
80105a9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a9e:	5b                   	pop    %ebx
80105a9f:	5e                   	pop    %esi
80105aa0:	5f                   	pop    %edi
80105aa1:	5d                   	pop    %ebp
80105aa2:	c3                   	ret    
80105aa3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ab0 <sys_pipe>:
80105ab0:	f3 0f 1e fb          	endbr32 
80105ab4:	55                   	push   %ebp
80105ab5:	89 e5                	mov    %esp,%ebp
80105ab7:	57                   	push   %edi
80105ab8:	56                   	push   %esi
80105ab9:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105abc:	53                   	push   %ebx
80105abd:	83 ec 20             	sub    $0x20,%esp
80105ac0:	6a 08                	push   $0x8
80105ac2:	50                   	push   %eax
80105ac3:	6a 00                	push   $0x0
80105ac5:	e8 c6 f3 ff ff       	call   80104e90 <argptr>
80105aca:	83 c4 10             	add    $0x10,%esp
80105acd:	85 c0                	test   %eax,%eax
80105acf:	78 4e                	js     80105b1f <sys_pipe+0x6f>
80105ad1:	83 ec 08             	sub    $0x8,%esp
80105ad4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ad7:	50                   	push   %eax
80105ad8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105adb:	50                   	push   %eax
80105adc:	e8 ff dd ff ff       	call   801038e0 <pipealloc>
80105ae1:	83 c4 10             	add    $0x10,%esp
80105ae4:	85 c0                	test   %eax,%eax
80105ae6:	78 37                	js     80105b1f <sys_pipe+0x6f>
80105ae8:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105aeb:	31 db                	xor    %ebx,%ebx
80105aed:	e8 5e e3 ff ff       	call   80103e50 <myproc>
80105af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105af8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105afc:	85 f6                	test   %esi,%esi
80105afe:	74 30                	je     80105b30 <sys_pipe+0x80>
80105b00:	83 c3 01             	add    $0x1,%ebx
80105b03:	83 fb 10             	cmp    $0x10,%ebx
80105b06:	75 f0                	jne    80105af8 <sys_pipe+0x48>
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	ff 75 e0             	pushl  -0x20(%ebp)
80105b0e:	e8 9d b8 ff ff       	call   801013b0 <fileclose>
80105b13:	58                   	pop    %eax
80105b14:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b17:	e8 94 b8 ff ff       	call   801013b0 <fileclose>
80105b1c:	83 c4 10             	add    $0x10,%esp
80105b1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b24:	eb 5b                	jmp    80105b81 <sys_pipe+0xd1>
80105b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b2d:	8d 76 00             	lea    0x0(%esi),%esi
80105b30:	8d 73 08             	lea    0x8(%ebx),%esi
80105b33:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80105b37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105b3a:	e8 11 e3 ff ff       	call   80103e50 <myproc>
80105b3f:	31 d2                	xor    %edx,%edx
80105b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b48:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105b4c:	85 c9                	test   %ecx,%ecx
80105b4e:	74 20                	je     80105b70 <sys_pipe+0xc0>
80105b50:	83 c2 01             	add    $0x1,%edx
80105b53:	83 fa 10             	cmp    $0x10,%edx
80105b56:	75 f0                	jne    80105b48 <sys_pipe+0x98>
80105b58:	e8 f3 e2 ff ff       	call   80103e50 <myproc>
80105b5d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105b64:	00 
80105b65:	eb a1                	jmp    80105b08 <sys_pipe+0x58>
80105b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6e:	66 90                	xchg   %ax,%ax
80105b70:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105b74:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b77:	89 18                	mov    %ebx,(%eax)
80105b79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b7c:	89 50 04             	mov    %edx,0x4(%eax)
80105b7f:	31 c0                	xor    %eax,%eax
80105b81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b84:	5b                   	pop    %ebx
80105b85:	5e                   	pop    %esi
80105b86:	5f                   	pop    %edi
80105b87:	5d                   	pop    %ebp
80105b88:	c3                   	ret    
80105b89:	66 90                	xchg   %ax,%ax
80105b8b:	66 90                	xchg   %ax,%ax
80105b8d:	66 90                	xchg   %ax,%ax
80105b8f:	90                   	nop

80105b90 <sys_fork>:
80105b90:	f3 0f 1e fb          	endbr32 
80105b94:	e9 67 e4 ff ff       	jmp    80104000 <fork>
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ba0 <sys_exit>:
80105ba0:	f3 0f 1e fb          	endbr32 
80105ba4:	55                   	push   %ebp
80105ba5:	89 e5                	mov    %esp,%ebp
80105ba7:	83 ec 08             	sub    $0x8,%esp
80105baa:	e8 d1 e6 ff ff       	call   80104280 <exit>
80105baf:	31 c0                	xor    %eax,%eax
80105bb1:	c9                   	leave  
80105bb2:	c3                   	ret    
80105bb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105bc0 <sys_wait>:
80105bc0:	f3 0f 1e fb          	endbr32 
80105bc4:	e9 07 e9 ff ff       	jmp    801044d0 <wait>
80105bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bd0 <sys_kill>:
80105bd0:	f3 0f 1e fb          	endbr32 
80105bd4:	55                   	push   %ebp
80105bd5:	89 e5                	mov    %esp,%ebp
80105bd7:	83 ec 20             	sub    $0x20,%esp
80105bda:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bdd:	50                   	push   %eax
80105bde:	6a 00                	push   $0x0
80105be0:	e8 5b f2 ff ff       	call   80104e40 <argint>
80105be5:	83 c4 10             	add    $0x10,%esp
80105be8:	85 c0                	test   %eax,%eax
80105bea:	78 14                	js     80105c00 <sys_kill+0x30>
80105bec:	83 ec 0c             	sub    $0xc,%esp
80105bef:	ff 75 f4             	pushl  -0xc(%ebp)
80105bf2:	e8 39 ea ff ff       	call   80104630 <kill>
80105bf7:	83 c4 10             	add    $0x10,%esp
80105bfa:	c9                   	leave  
80105bfb:	c3                   	ret    
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c00:	c9                   	leave  
80105c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c06:	c3                   	ret    
80105c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0e:	66 90                	xchg   %ax,%ax

80105c10 <sys_getpid>:
80105c10:	f3 0f 1e fb          	endbr32 
80105c14:	55                   	push   %ebp
80105c15:	89 e5                	mov    %esp,%ebp
80105c17:	83 ec 08             	sub    $0x8,%esp
80105c1a:	e8 31 e2 ff ff       	call   80103e50 <myproc>
80105c1f:	8b 40 10             	mov    0x10(%eax),%eax
80105c22:	c9                   	leave  
80105c23:	c3                   	ret    
80105c24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c2f:	90                   	nop

80105c30 <sys_sbrk>:
80105c30:	f3 0f 1e fb          	endbr32 
80105c34:	55                   	push   %ebp
80105c35:	89 e5                	mov    %esp,%ebp
80105c37:	53                   	push   %ebx
80105c38:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c3b:	83 ec 1c             	sub    $0x1c,%esp
80105c3e:	50                   	push   %eax
80105c3f:	6a 00                	push   $0x0
80105c41:	e8 fa f1 ff ff       	call   80104e40 <argint>
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	78 23                	js     80105c70 <sys_sbrk+0x40>
80105c4d:	e8 fe e1 ff ff       	call   80103e50 <myproc>
80105c52:	83 ec 0c             	sub    $0xc,%esp
80105c55:	8b 18                	mov    (%eax),%ebx
80105c57:	ff 75 f4             	pushl  -0xc(%ebp)
80105c5a:	e8 21 e3 ff ff       	call   80103f80 <growproc>
80105c5f:	83 c4 10             	add    $0x10,%esp
80105c62:	85 c0                	test   %eax,%eax
80105c64:	78 0a                	js     80105c70 <sys_sbrk+0x40>
80105c66:	89 d8                	mov    %ebx,%eax
80105c68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c6b:	c9                   	leave  
80105c6c:	c3                   	ret    
80105c6d:	8d 76 00             	lea    0x0(%esi),%esi
80105c70:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c75:	eb ef                	jmp    80105c66 <sys_sbrk+0x36>
80105c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7e:	66 90                	xchg   %ax,%ax

80105c80 <sys_sleep>:
80105c80:	f3 0f 1e fb          	endbr32 
80105c84:	55                   	push   %ebp
80105c85:	89 e5                	mov    %esp,%ebp
80105c87:	53                   	push   %ebx
80105c88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c8b:	83 ec 1c             	sub    $0x1c,%esp
80105c8e:	50                   	push   %eax
80105c8f:	6a 00                	push   $0x0
80105c91:	e8 aa f1 ff ff       	call   80104e40 <argint>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	0f 88 86 00 00 00    	js     80105d27 <sys_sleep+0xa7>
80105ca1:	83 ec 0c             	sub    $0xc,%esp
80105ca4:	68 00 62 11 80       	push   $0x80116200
80105ca9:	e8 a2 ed ff ff       	call   80104a50 <acquire>
80105cae:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105cb1:	8b 1d 40 6a 11 80    	mov    0x80116a40,%ebx
80105cb7:	83 c4 10             	add    $0x10,%esp
80105cba:	85 d2                	test   %edx,%edx
80105cbc:	75 23                	jne    80105ce1 <sys_sleep+0x61>
80105cbe:	eb 50                	jmp    80105d10 <sys_sleep+0x90>
80105cc0:	83 ec 08             	sub    $0x8,%esp
80105cc3:	68 00 62 11 80       	push   $0x80116200
80105cc8:	68 40 6a 11 80       	push   $0x80116a40
80105ccd:	e8 3e e7 ff ff       	call   80104410 <sleep>
80105cd2:	a1 40 6a 11 80       	mov    0x80116a40,%eax
80105cd7:	83 c4 10             	add    $0x10,%esp
80105cda:	29 d8                	sub    %ebx,%eax
80105cdc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105cdf:	73 2f                	jae    80105d10 <sys_sleep+0x90>
80105ce1:	e8 6a e1 ff ff       	call   80103e50 <myproc>
80105ce6:	8b 40 24             	mov    0x24(%eax),%eax
80105ce9:	85 c0                	test   %eax,%eax
80105ceb:	74 d3                	je     80105cc0 <sys_sleep+0x40>
80105ced:	83 ec 0c             	sub    $0xc,%esp
80105cf0:	68 00 62 11 80       	push   $0x80116200
80105cf5:	e8 16 ee ff ff       	call   80104b10 <release>
80105cfa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d05:	c9                   	leave  
80105d06:	c3                   	ret    
80105d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d0e:	66 90                	xchg   %ax,%ax
80105d10:	83 ec 0c             	sub    $0xc,%esp
80105d13:	68 00 62 11 80       	push   $0x80116200
80105d18:	e8 f3 ed ff ff       	call   80104b10 <release>
80105d1d:	83 c4 10             	add    $0x10,%esp
80105d20:	31 c0                	xor    %eax,%eax
80105d22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d25:	c9                   	leave  
80105d26:	c3                   	ret    
80105d27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d2c:	eb f4                	jmp    80105d22 <sys_sleep+0xa2>
80105d2e:	66 90                	xchg   %ax,%ax

80105d30 <sys_uptime>:
80105d30:	f3 0f 1e fb          	endbr32 
80105d34:	55                   	push   %ebp
80105d35:	89 e5                	mov    %esp,%ebp
80105d37:	53                   	push   %ebx
80105d38:	83 ec 10             	sub    $0x10,%esp
80105d3b:	68 00 62 11 80       	push   $0x80116200
80105d40:	e8 0b ed ff ff       	call   80104a50 <acquire>
80105d45:	8b 1d 40 6a 11 80    	mov    0x80116a40,%ebx
80105d4b:	c7 04 24 00 62 11 80 	movl   $0x80116200,(%esp)
80105d52:	e8 b9 ed ff ff       	call   80104b10 <release>
80105d57:	89 d8                	mov    %ebx,%eax
80105d59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d5c:	c9                   	leave  
80105d5d:	c3                   	ret    

80105d5e <alltraps>:
80105d5e:	1e                   	push   %ds
80105d5f:	06                   	push   %es
80105d60:	0f a0                	push   %fs
80105d62:	0f a8                	push   %gs
80105d64:	60                   	pusha  
80105d65:	66 b8 10 00          	mov    $0x10,%ax
80105d69:	8e d8                	mov    %eax,%ds
80105d6b:	8e c0                	mov    %eax,%es
80105d6d:	54                   	push   %esp
80105d6e:	e8 cd 00 00 00       	call   80105e40 <trap>
80105d73:	83 c4 04             	add    $0x4,%esp

80105d76 <trapret>:
80105d76:	61                   	popa   
80105d77:	0f a9                	pop    %gs
80105d79:	0f a1                	pop    %fs
80105d7b:	07                   	pop    %es
80105d7c:	1f                   	pop    %ds
80105d7d:	83 c4 08             	add    $0x8,%esp
80105d80:	cf                   	iret   
80105d81:	66 90                	xchg   %ax,%ax
80105d83:	66 90                	xchg   %ax,%ax
80105d85:	66 90                	xchg   %ax,%ax
80105d87:	66 90                	xchg   %ax,%ax
80105d89:	66 90                	xchg   %ax,%ax
80105d8b:	66 90                	xchg   %ax,%ax
80105d8d:	66 90                	xchg   %ax,%ax
80105d8f:	90                   	nop

80105d90 <tvinit>:
80105d90:	f3 0f 1e fb          	endbr32 
80105d94:	55                   	push   %ebp
80105d95:	31 c0                	xor    %eax,%eax
80105d97:	89 e5                	mov    %esp,%ebp
80105d99:	83 ec 08             	sub    $0x8,%esp
80105d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105da0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105da7:	c7 04 c5 42 62 11 80 	movl   $0x8e000008,-0x7fee9dbe(,%eax,8)
80105dae:	08 00 00 8e 
80105db2:	66 89 14 c5 40 62 11 	mov    %dx,-0x7fee9dc0(,%eax,8)
80105db9:	80 
80105dba:	c1 ea 10             	shr    $0x10,%edx
80105dbd:	66 89 14 c5 46 62 11 	mov    %dx,-0x7fee9dba(,%eax,8)
80105dc4:	80 
80105dc5:	83 c0 01             	add    $0x1,%eax
80105dc8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105dcd:	75 d1                	jne    80105da0 <tvinit+0x10>
80105dcf:	83 ec 08             	sub    $0x8,%esp
80105dd2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105dd7:	c7 05 42 64 11 80 08 	movl   $0xef000008,0x80116442
80105dde:	00 00 ef 
80105de1:	68 b9 7d 10 80       	push   $0x80107db9
80105de6:	68 00 62 11 80       	push   $0x80116200
80105deb:	66 a3 40 64 11 80    	mov    %ax,0x80116440
80105df1:	c1 e8 10             	shr    $0x10,%eax
80105df4:	66 a3 46 64 11 80    	mov    %ax,0x80116446
80105dfa:	e8 d1 ea ff ff       	call   801048d0 <initlock>
80105dff:	83 c4 10             	add    $0x10,%esp
80105e02:	c9                   	leave  
80105e03:	c3                   	ret    
80105e04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e0f:	90                   	nop

80105e10 <idtinit>:
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e1a:	89 e5                	mov    %esp,%ebp
80105e1c:	83 ec 10             	sub    $0x10,%esp
80105e1f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80105e23:	b8 40 62 11 80       	mov    $0x80116240,%eax
80105e28:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80105e2c:	c1 e8 10             	shr    $0x10,%eax
80105e2f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80105e33:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105e36:	0f 01 18             	lidtl  (%eax)
80105e39:	c9                   	leave  
80105e3a:	c3                   	ret    
80105e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e3f:	90                   	nop

80105e40 <trap>:
80105e40:	f3 0f 1e fb          	endbr32 
80105e44:	55                   	push   %ebp
80105e45:	89 e5                	mov    %esp,%ebp
80105e47:	57                   	push   %edi
80105e48:	56                   	push   %esi
80105e49:	53                   	push   %ebx
80105e4a:	83 ec 1c             	sub    $0x1c,%esp
80105e4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105e50:	8b 43 30             	mov    0x30(%ebx),%eax
80105e53:	83 f8 40             	cmp    $0x40,%eax
80105e56:	0f 84 bc 01 00 00    	je     80106018 <trap+0x1d8>
80105e5c:	83 e8 20             	sub    $0x20,%eax
80105e5f:	83 f8 1f             	cmp    $0x1f,%eax
80105e62:	77 08                	ja     80105e6c <trap+0x2c>
80105e64:	3e ff 24 85 60 7e 10 	notrack jmp *-0x7fef81a0(,%eax,4)
80105e6b:	80 
80105e6c:	e8 df df ff ff       	call   80103e50 <myproc>
80105e71:	8b 7b 38             	mov    0x38(%ebx),%edi
80105e74:	85 c0                	test   %eax,%eax
80105e76:	0f 84 eb 01 00 00    	je     80106067 <trap+0x227>
80105e7c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105e80:	0f 84 e1 01 00 00    	je     80106067 <trap+0x227>
80105e86:	0f 20 d1             	mov    %cr2,%ecx
80105e89:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105e8c:	e8 9f df ff ff       	call   80103e30 <cpuid>
80105e91:	8b 73 30             	mov    0x30(%ebx),%esi
80105e94:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105e97:	8b 43 34             	mov    0x34(%ebx),%eax
80105e9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105e9d:	e8 ae df ff ff       	call   80103e50 <myproc>
80105ea2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ea5:	e8 a6 df ff ff       	call   80103e50 <myproc>
80105eaa:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ead:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105eb0:	51                   	push   %ecx
80105eb1:	57                   	push   %edi
80105eb2:	52                   	push   %edx
80105eb3:	ff 75 e4             	pushl  -0x1c(%ebp)
80105eb6:	56                   	push   %esi
80105eb7:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105eba:	83 c6 6c             	add    $0x6c,%esi
80105ebd:	56                   	push   %esi
80105ebe:	ff 70 10             	pushl  0x10(%eax)
80105ec1:	68 1c 7e 10 80       	push   $0x80107e1c
80105ec6:	e8 f5 a9 ff ff       	call   801008c0 <cprintf>
80105ecb:	83 c4 20             	add    $0x20,%esp
80105ece:	e8 7d df ff ff       	call   80103e50 <myproc>
80105ed3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105eda:	e8 71 df ff ff       	call   80103e50 <myproc>
80105edf:	85 c0                	test   %eax,%eax
80105ee1:	74 1d                	je     80105f00 <trap+0xc0>
80105ee3:	e8 68 df ff ff       	call   80103e50 <myproc>
80105ee8:	8b 50 24             	mov    0x24(%eax),%edx
80105eeb:	85 d2                	test   %edx,%edx
80105eed:	74 11                	je     80105f00 <trap+0xc0>
80105eef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105ef3:	83 e0 03             	and    $0x3,%eax
80105ef6:	66 83 f8 03          	cmp    $0x3,%ax
80105efa:	0f 84 50 01 00 00    	je     80106050 <trap+0x210>
80105f00:	e8 4b df ff ff       	call   80103e50 <myproc>
80105f05:	85 c0                	test   %eax,%eax
80105f07:	74 0f                	je     80105f18 <trap+0xd8>
80105f09:	e8 42 df ff ff       	call   80103e50 <myproc>
80105f0e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105f12:	0f 84 e8 00 00 00    	je     80106000 <trap+0x1c0>
80105f18:	e8 33 df ff ff       	call   80103e50 <myproc>
80105f1d:	85 c0                	test   %eax,%eax
80105f1f:	74 1d                	je     80105f3e <trap+0xfe>
80105f21:	e8 2a df ff ff       	call   80103e50 <myproc>
80105f26:	8b 40 24             	mov    0x24(%eax),%eax
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	74 11                	je     80105f3e <trap+0xfe>
80105f2d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105f31:	83 e0 03             	and    $0x3,%eax
80105f34:	66 83 f8 03          	cmp    $0x3,%ax
80105f38:	0f 84 03 01 00 00    	je     80106041 <trap+0x201>
80105f3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f41:	5b                   	pop    %ebx
80105f42:	5e                   	pop    %esi
80105f43:	5f                   	pop    %edi
80105f44:	5d                   	pop    %ebp
80105f45:	c3                   	ret    
80105f46:	e8 85 c7 ff ff       	call   801026d0 <ideintr>
80105f4b:	e8 60 ce ff ff       	call   80102db0 <lapiceoi>
80105f50:	e8 fb de ff ff       	call   80103e50 <myproc>
80105f55:	85 c0                	test   %eax,%eax
80105f57:	75 8a                	jne    80105ee3 <trap+0xa3>
80105f59:	eb a5                	jmp    80105f00 <trap+0xc0>
80105f5b:	e8 d0 de ff ff       	call   80103e30 <cpuid>
80105f60:	85 c0                	test   %eax,%eax
80105f62:	75 e7                	jne    80105f4b <trap+0x10b>
80105f64:	83 ec 0c             	sub    $0xc,%esp
80105f67:	68 00 62 11 80       	push   $0x80116200
80105f6c:	e8 df ea ff ff       	call   80104a50 <acquire>
80105f71:	c7 04 24 40 6a 11 80 	movl   $0x80116a40,(%esp)
80105f78:	83 05 40 6a 11 80 01 	addl   $0x1,0x80116a40
80105f7f:	e8 4c e6 ff ff       	call   801045d0 <wakeup>
80105f84:	c7 04 24 00 62 11 80 	movl   $0x80116200,(%esp)
80105f8b:	e8 80 eb ff ff       	call   80104b10 <release>
80105f90:	83 c4 10             	add    $0x10,%esp
80105f93:	eb b6                	jmp    80105f4b <trap+0x10b>
80105f95:	e8 d6 cc ff ff       	call   80102c70 <kbdintr>
80105f9a:	e8 11 ce ff ff       	call   80102db0 <lapiceoi>
80105f9f:	e8 ac de ff ff       	call   80103e50 <myproc>
80105fa4:	85 c0                	test   %eax,%eax
80105fa6:	0f 85 37 ff ff ff    	jne    80105ee3 <trap+0xa3>
80105fac:	e9 4f ff ff ff       	jmp    80105f00 <trap+0xc0>
80105fb1:	e8 4a 02 00 00       	call   80106200 <uartintr>
80105fb6:	e8 f5 cd ff ff       	call   80102db0 <lapiceoi>
80105fbb:	e8 90 de ff ff       	call   80103e50 <myproc>
80105fc0:	85 c0                	test   %eax,%eax
80105fc2:	0f 85 1b ff ff ff    	jne    80105ee3 <trap+0xa3>
80105fc8:	e9 33 ff ff ff       	jmp    80105f00 <trap+0xc0>
80105fcd:	8b 7b 38             	mov    0x38(%ebx),%edi
80105fd0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105fd4:	e8 57 de ff ff       	call   80103e30 <cpuid>
80105fd9:	57                   	push   %edi
80105fda:	56                   	push   %esi
80105fdb:	50                   	push   %eax
80105fdc:	68 c4 7d 10 80       	push   $0x80107dc4
80105fe1:	e8 da a8 ff ff       	call   801008c0 <cprintf>
80105fe6:	e8 c5 cd ff ff       	call   80102db0 <lapiceoi>
80105feb:	83 c4 10             	add    $0x10,%esp
80105fee:	e8 5d de ff ff       	call   80103e50 <myproc>
80105ff3:	85 c0                	test   %eax,%eax
80105ff5:	0f 85 e8 fe ff ff    	jne    80105ee3 <trap+0xa3>
80105ffb:	e9 00 ff ff ff       	jmp    80105f00 <trap+0xc0>
80106000:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106004:	0f 85 0e ff ff ff    	jne    80105f18 <trap+0xd8>
8010600a:	e8 b1 e3 ff ff       	call   801043c0 <yield>
8010600f:	e9 04 ff ff ff       	jmp    80105f18 <trap+0xd8>
80106014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106018:	e8 33 de ff ff       	call   80103e50 <myproc>
8010601d:	8b 70 24             	mov    0x24(%eax),%esi
80106020:	85 f6                	test   %esi,%esi
80106022:	75 3c                	jne    80106060 <trap+0x220>
80106024:	e8 27 de ff ff       	call   80103e50 <myproc>
80106029:	89 58 18             	mov    %ebx,0x18(%eax)
8010602c:	e8 ff ee ff ff       	call   80104f30 <syscall>
80106031:	e8 1a de ff ff       	call   80103e50 <myproc>
80106036:	8b 48 24             	mov    0x24(%eax),%ecx
80106039:	85 c9                	test   %ecx,%ecx
8010603b:	0f 84 fd fe ff ff    	je     80105f3e <trap+0xfe>
80106041:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106044:	5b                   	pop    %ebx
80106045:	5e                   	pop    %esi
80106046:	5f                   	pop    %edi
80106047:	5d                   	pop    %ebp
80106048:	e9 33 e2 ff ff       	jmp    80104280 <exit>
8010604d:	8d 76 00             	lea    0x0(%esi),%esi
80106050:	e8 2b e2 ff ff       	call   80104280 <exit>
80106055:	e9 a6 fe ff ff       	jmp    80105f00 <trap+0xc0>
8010605a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106060:	e8 1b e2 ff ff       	call   80104280 <exit>
80106065:	eb bd                	jmp    80106024 <trap+0x1e4>
80106067:	0f 20 d6             	mov    %cr2,%esi
8010606a:	e8 c1 dd ff ff       	call   80103e30 <cpuid>
8010606f:	83 ec 0c             	sub    $0xc,%esp
80106072:	56                   	push   %esi
80106073:	57                   	push   %edi
80106074:	50                   	push   %eax
80106075:	ff 73 30             	pushl  0x30(%ebx)
80106078:	68 e8 7d 10 80       	push   $0x80107de8
8010607d:	e8 3e a8 ff ff       	call   801008c0 <cprintf>
80106082:	83 c4 14             	add    $0x14,%esp
80106085:	68 be 7d 10 80       	push   $0x80107dbe
8010608a:	e8 01 a3 ff ff       	call   80100390 <panic>
8010608f:	90                   	nop

80106090 <uartgetc>:
80106090:	f3 0f 1e fb          	endbr32 
80106094:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
80106099:	85 c0                	test   %eax,%eax
8010609b:	74 1b                	je     801060b8 <uartgetc+0x28>
8010609d:	ba fd 03 00 00       	mov    $0x3fd,%edx
801060a2:	ec                   	in     (%dx),%al
801060a3:	a8 01                	test   $0x1,%al
801060a5:	74 11                	je     801060b8 <uartgetc+0x28>
801060a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ac:	ec                   	in     (%dx),%al
801060ad:	0f b6 c0             	movzbl %al,%eax
801060b0:	c3                   	ret    
801060b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060bd:	c3                   	ret    
801060be:	66 90                	xchg   %ax,%ax

801060c0 <uartputc.part.0>:
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	57                   	push   %edi
801060c4:	89 c7                	mov    %eax,%edi
801060c6:	56                   	push   %esi
801060c7:	be fd 03 00 00       	mov    $0x3fd,%esi
801060cc:	53                   	push   %ebx
801060cd:	bb 80 00 00 00       	mov    $0x80,%ebx
801060d2:	83 ec 0c             	sub    $0xc,%esp
801060d5:	eb 1b                	jmp    801060f2 <uartputc.part.0+0x32>
801060d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060de:	66 90                	xchg   %ax,%ax
801060e0:	83 ec 0c             	sub    $0xc,%esp
801060e3:	6a 0a                	push   $0xa
801060e5:	e8 e6 cc ff ff       	call   80102dd0 <microdelay>
801060ea:	83 c4 10             	add    $0x10,%esp
801060ed:	83 eb 01             	sub    $0x1,%ebx
801060f0:	74 07                	je     801060f9 <uartputc.part.0+0x39>
801060f2:	89 f2                	mov    %esi,%edx
801060f4:	ec                   	in     (%dx),%al
801060f5:	a8 20                	test   $0x20,%al
801060f7:	74 e7                	je     801060e0 <uartputc.part.0+0x20>
801060f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060fe:	89 f8                	mov    %edi,%eax
80106100:	ee                   	out    %al,(%dx)
80106101:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106104:	5b                   	pop    %ebx
80106105:	5e                   	pop    %esi
80106106:	5f                   	pop    %edi
80106107:	5d                   	pop    %ebp
80106108:	c3                   	ret    
80106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106110 <uartinit>:
80106110:	f3 0f 1e fb          	endbr32 
80106114:	55                   	push   %ebp
80106115:	31 c9                	xor    %ecx,%ecx
80106117:	89 c8                	mov    %ecx,%eax
80106119:	89 e5                	mov    %esp,%ebp
8010611b:	57                   	push   %edi
8010611c:	56                   	push   %esi
8010611d:	53                   	push   %ebx
8010611e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106123:	89 da                	mov    %ebx,%edx
80106125:	83 ec 0c             	sub    $0xc,%esp
80106128:	ee                   	out    %al,(%dx)
80106129:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010612e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106133:	89 fa                	mov    %edi,%edx
80106135:	ee                   	out    %al,(%dx)
80106136:	b8 0c 00 00 00       	mov    $0xc,%eax
8010613b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106140:	ee                   	out    %al,(%dx)
80106141:	be f9 03 00 00       	mov    $0x3f9,%esi
80106146:	89 c8                	mov    %ecx,%eax
80106148:	89 f2                	mov    %esi,%edx
8010614a:	ee                   	out    %al,(%dx)
8010614b:	b8 03 00 00 00       	mov    $0x3,%eax
80106150:	89 fa                	mov    %edi,%edx
80106152:	ee                   	out    %al,(%dx)
80106153:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106158:	89 c8                	mov    %ecx,%eax
8010615a:	ee                   	out    %al,(%dx)
8010615b:	b8 01 00 00 00       	mov    $0x1,%eax
80106160:	89 f2                	mov    %esi,%edx
80106162:	ee                   	out    %al,(%dx)
80106163:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106168:	ec                   	in     (%dx),%al
80106169:	3c ff                	cmp    $0xff,%al
8010616b:	74 52                	je     801061bf <uartinit+0xaf>
8010616d:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106174:	00 00 00 
80106177:	89 da                	mov    %ebx,%edx
80106179:	ec                   	in     (%dx),%al
8010617a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010617f:	ec                   	in     (%dx),%al
80106180:	83 ec 08             	sub    $0x8,%esp
80106183:	be 76 00 00 00       	mov    $0x76,%esi
80106188:	bb e0 7e 10 80       	mov    $0x80107ee0,%ebx
8010618d:	6a 00                	push   $0x0
8010618f:	6a 04                	push   $0x4
80106191:	e8 8a c7 ff ff       	call   80102920 <ioapicenable>
80106196:	83 c4 10             	add    $0x10,%esp
80106199:	b8 78 00 00 00       	mov    $0x78,%eax
8010619e:	eb 04                	jmp    801061a4 <uartinit+0x94>
801061a0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
801061a4:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801061aa:	85 d2                	test   %edx,%edx
801061ac:	74 08                	je     801061b6 <uartinit+0xa6>
801061ae:	0f be c0             	movsbl %al,%eax
801061b1:	e8 0a ff ff ff       	call   801060c0 <uartputc.part.0>
801061b6:	89 f0                	mov    %esi,%eax
801061b8:	83 c3 01             	add    $0x1,%ebx
801061bb:	84 c0                	test   %al,%al
801061bd:	75 e1                	jne    801061a0 <uartinit+0x90>
801061bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061c2:	5b                   	pop    %ebx
801061c3:	5e                   	pop    %esi
801061c4:	5f                   	pop    %edi
801061c5:	5d                   	pop    %ebp
801061c6:	c3                   	ret    
801061c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ce:	66 90                	xchg   %ax,%ax

801061d0 <uartputc>:
801061d0:	f3 0f 1e fb          	endbr32 
801061d4:	55                   	push   %ebp
801061d5:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801061db:	89 e5                	mov    %esp,%ebp
801061dd:	8b 45 08             	mov    0x8(%ebp),%eax
801061e0:	85 d2                	test   %edx,%edx
801061e2:	74 0c                	je     801061f0 <uartputc+0x20>
801061e4:	5d                   	pop    %ebp
801061e5:	e9 d6 fe ff ff       	jmp    801060c0 <uartputc.part.0>
801061ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801061f0:	5d                   	pop    %ebp
801061f1:	c3                   	ret    
801061f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106200 <uartintr>:
80106200:	f3 0f 1e fb          	endbr32 
80106204:	55                   	push   %ebp
80106205:	89 e5                	mov    %esp,%ebp
80106207:	83 ec 14             	sub    $0x14,%esp
8010620a:	68 90 60 10 80       	push   $0x80106090
8010620f:	e8 5c a8 ff ff       	call   80100a70 <consoleintr>
80106214:	83 c4 10             	add    $0x10,%esp
80106217:	c9                   	leave  
80106218:	c3                   	ret    

80106219 <vector0>:
80106219:	6a 00                	push   $0x0
8010621b:	6a 00                	push   $0x0
8010621d:	e9 3c fb ff ff       	jmp    80105d5e <alltraps>

80106222 <vector1>:
80106222:	6a 00                	push   $0x0
80106224:	6a 01                	push   $0x1
80106226:	e9 33 fb ff ff       	jmp    80105d5e <alltraps>

8010622b <vector2>:
8010622b:	6a 00                	push   $0x0
8010622d:	6a 02                	push   $0x2
8010622f:	e9 2a fb ff ff       	jmp    80105d5e <alltraps>

80106234 <vector3>:
80106234:	6a 00                	push   $0x0
80106236:	6a 03                	push   $0x3
80106238:	e9 21 fb ff ff       	jmp    80105d5e <alltraps>

8010623d <vector4>:
8010623d:	6a 00                	push   $0x0
8010623f:	6a 04                	push   $0x4
80106241:	e9 18 fb ff ff       	jmp    80105d5e <alltraps>

80106246 <vector5>:
80106246:	6a 00                	push   $0x0
80106248:	6a 05                	push   $0x5
8010624a:	e9 0f fb ff ff       	jmp    80105d5e <alltraps>

8010624f <vector6>:
8010624f:	6a 00                	push   $0x0
80106251:	6a 06                	push   $0x6
80106253:	e9 06 fb ff ff       	jmp    80105d5e <alltraps>

80106258 <vector7>:
80106258:	6a 00                	push   $0x0
8010625a:	6a 07                	push   $0x7
8010625c:	e9 fd fa ff ff       	jmp    80105d5e <alltraps>

80106261 <vector8>:
80106261:	6a 08                	push   $0x8
80106263:	e9 f6 fa ff ff       	jmp    80105d5e <alltraps>

80106268 <vector9>:
80106268:	6a 00                	push   $0x0
8010626a:	6a 09                	push   $0x9
8010626c:	e9 ed fa ff ff       	jmp    80105d5e <alltraps>

80106271 <vector10>:
80106271:	6a 0a                	push   $0xa
80106273:	e9 e6 fa ff ff       	jmp    80105d5e <alltraps>

80106278 <vector11>:
80106278:	6a 0b                	push   $0xb
8010627a:	e9 df fa ff ff       	jmp    80105d5e <alltraps>

8010627f <vector12>:
8010627f:	6a 0c                	push   $0xc
80106281:	e9 d8 fa ff ff       	jmp    80105d5e <alltraps>

80106286 <vector13>:
80106286:	6a 0d                	push   $0xd
80106288:	e9 d1 fa ff ff       	jmp    80105d5e <alltraps>

8010628d <vector14>:
8010628d:	6a 0e                	push   $0xe
8010628f:	e9 ca fa ff ff       	jmp    80105d5e <alltraps>

80106294 <vector15>:
80106294:	6a 00                	push   $0x0
80106296:	6a 0f                	push   $0xf
80106298:	e9 c1 fa ff ff       	jmp    80105d5e <alltraps>

8010629d <vector16>:
8010629d:	6a 00                	push   $0x0
8010629f:	6a 10                	push   $0x10
801062a1:	e9 b8 fa ff ff       	jmp    80105d5e <alltraps>

801062a6 <vector17>:
801062a6:	6a 11                	push   $0x11
801062a8:	e9 b1 fa ff ff       	jmp    80105d5e <alltraps>

801062ad <vector18>:
801062ad:	6a 00                	push   $0x0
801062af:	6a 12                	push   $0x12
801062b1:	e9 a8 fa ff ff       	jmp    80105d5e <alltraps>

801062b6 <vector19>:
801062b6:	6a 00                	push   $0x0
801062b8:	6a 13                	push   $0x13
801062ba:	e9 9f fa ff ff       	jmp    80105d5e <alltraps>

801062bf <vector20>:
801062bf:	6a 00                	push   $0x0
801062c1:	6a 14                	push   $0x14
801062c3:	e9 96 fa ff ff       	jmp    80105d5e <alltraps>

801062c8 <vector21>:
801062c8:	6a 00                	push   $0x0
801062ca:	6a 15                	push   $0x15
801062cc:	e9 8d fa ff ff       	jmp    80105d5e <alltraps>

801062d1 <vector22>:
801062d1:	6a 00                	push   $0x0
801062d3:	6a 16                	push   $0x16
801062d5:	e9 84 fa ff ff       	jmp    80105d5e <alltraps>

801062da <vector23>:
801062da:	6a 00                	push   $0x0
801062dc:	6a 17                	push   $0x17
801062de:	e9 7b fa ff ff       	jmp    80105d5e <alltraps>

801062e3 <vector24>:
801062e3:	6a 00                	push   $0x0
801062e5:	6a 18                	push   $0x18
801062e7:	e9 72 fa ff ff       	jmp    80105d5e <alltraps>

801062ec <vector25>:
801062ec:	6a 00                	push   $0x0
801062ee:	6a 19                	push   $0x19
801062f0:	e9 69 fa ff ff       	jmp    80105d5e <alltraps>

801062f5 <vector26>:
801062f5:	6a 00                	push   $0x0
801062f7:	6a 1a                	push   $0x1a
801062f9:	e9 60 fa ff ff       	jmp    80105d5e <alltraps>

801062fe <vector27>:
801062fe:	6a 00                	push   $0x0
80106300:	6a 1b                	push   $0x1b
80106302:	e9 57 fa ff ff       	jmp    80105d5e <alltraps>

80106307 <vector28>:
80106307:	6a 00                	push   $0x0
80106309:	6a 1c                	push   $0x1c
8010630b:	e9 4e fa ff ff       	jmp    80105d5e <alltraps>

80106310 <vector29>:
80106310:	6a 00                	push   $0x0
80106312:	6a 1d                	push   $0x1d
80106314:	e9 45 fa ff ff       	jmp    80105d5e <alltraps>

80106319 <vector30>:
80106319:	6a 00                	push   $0x0
8010631b:	6a 1e                	push   $0x1e
8010631d:	e9 3c fa ff ff       	jmp    80105d5e <alltraps>

80106322 <vector31>:
80106322:	6a 00                	push   $0x0
80106324:	6a 1f                	push   $0x1f
80106326:	e9 33 fa ff ff       	jmp    80105d5e <alltraps>

8010632b <vector32>:
8010632b:	6a 00                	push   $0x0
8010632d:	6a 20                	push   $0x20
8010632f:	e9 2a fa ff ff       	jmp    80105d5e <alltraps>

80106334 <vector33>:
80106334:	6a 00                	push   $0x0
80106336:	6a 21                	push   $0x21
80106338:	e9 21 fa ff ff       	jmp    80105d5e <alltraps>

8010633d <vector34>:
8010633d:	6a 00                	push   $0x0
8010633f:	6a 22                	push   $0x22
80106341:	e9 18 fa ff ff       	jmp    80105d5e <alltraps>

80106346 <vector35>:
80106346:	6a 00                	push   $0x0
80106348:	6a 23                	push   $0x23
8010634a:	e9 0f fa ff ff       	jmp    80105d5e <alltraps>

8010634f <vector36>:
8010634f:	6a 00                	push   $0x0
80106351:	6a 24                	push   $0x24
80106353:	e9 06 fa ff ff       	jmp    80105d5e <alltraps>

80106358 <vector37>:
80106358:	6a 00                	push   $0x0
8010635a:	6a 25                	push   $0x25
8010635c:	e9 fd f9 ff ff       	jmp    80105d5e <alltraps>

80106361 <vector38>:
80106361:	6a 00                	push   $0x0
80106363:	6a 26                	push   $0x26
80106365:	e9 f4 f9 ff ff       	jmp    80105d5e <alltraps>

8010636a <vector39>:
8010636a:	6a 00                	push   $0x0
8010636c:	6a 27                	push   $0x27
8010636e:	e9 eb f9 ff ff       	jmp    80105d5e <alltraps>

80106373 <vector40>:
80106373:	6a 00                	push   $0x0
80106375:	6a 28                	push   $0x28
80106377:	e9 e2 f9 ff ff       	jmp    80105d5e <alltraps>

8010637c <vector41>:
8010637c:	6a 00                	push   $0x0
8010637e:	6a 29                	push   $0x29
80106380:	e9 d9 f9 ff ff       	jmp    80105d5e <alltraps>

80106385 <vector42>:
80106385:	6a 00                	push   $0x0
80106387:	6a 2a                	push   $0x2a
80106389:	e9 d0 f9 ff ff       	jmp    80105d5e <alltraps>

8010638e <vector43>:
8010638e:	6a 00                	push   $0x0
80106390:	6a 2b                	push   $0x2b
80106392:	e9 c7 f9 ff ff       	jmp    80105d5e <alltraps>

80106397 <vector44>:
80106397:	6a 00                	push   $0x0
80106399:	6a 2c                	push   $0x2c
8010639b:	e9 be f9 ff ff       	jmp    80105d5e <alltraps>

801063a0 <vector45>:
801063a0:	6a 00                	push   $0x0
801063a2:	6a 2d                	push   $0x2d
801063a4:	e9 b5 f9 ff ff       	jmp    80105d5e <alltraps>

801063a9 <vector46>:
801063a9:	6a 00                	push   $0x0
801063ab:	6a 2e                	push   $0x2e
801063ad:	e9 ac f9 ff ff       	jmp    80105d5e <alltraps>

801063b2 <vector47>:
801063b2:	6a 00                	push   $0x0
801063b4:	6a 2f                	push   $0x2f
801063b6:	e9 a3 f9 ff ff       	jmp    80105d5e <alltraps>

801063bb <vector48>:
801063bb:	6a 00                	push   $0x0
801063bd:	6a 30                	push   $0x30
801063bf:	e9 9a f9 ff ff       	jmp    80105d5e <alltraps>

801063c4 <vector49>:
801063c4:	6a 00                	push   $0x0
801063c6:	6a 31                	push   $0x31
801063c8:	e9 91 f9 ff ff       	jmp    80105d5e <alltraps>

801063cd <vector50>:
801063cd:	6a 00                	push   $0x0
801063cf:	6a 32                	push   $0x32
801063d1:	e9 88 f9 ff ff       	jmp    80105d5e <alltraps>

801063d6 <vector51>:
801063d6:	6a 00                	push   $0x0
801063d8:	6a 33                	push   $0x33
801063da:	e9 7f f9 ff ff       	jmp    80105d5e <alltraps>

801063df <vector52>:
801063df:	6a 00                	push   $0x0
801063e1:	6a 34                	push   $0x34
801063e3:	e9 76 f9 ff ff       	jmp    80105d5e <alltraps>

801063e8 <vector53>:
801063e8:	6a 00                	push   $0x0
801063ea:	6a 35                	push   $0x35
801063ec:	e9 6d f9 ff ff       	jmp    80105d5e <alltraps>

801063f1 <vector54>:
801063f1:	6a 00                	push   $0x0
801063f3:	6a 36                	push   $0x36
801063f5:	e9 64 f9 ff ff       	jmp    80105d5e <alltraps>

801063fa <vector55>:
801063fa:	6a 00                	push   $0x0
801063fc:	6a 37                	push   $0x37
801063fe:	e9 5b f9 ff ff       	jmp    80105d5e <alltraps>

80106403 <vector56>:
80106403:	6a 00                	push   $0x0
80106405:	6a 38                	push   $0x38
80106407:	e9 52 f9 ff ff       	jmp    80105d5e <alltraps>

8010640c <vector57>:
8010640c:	6a 00                	push   $0x0
8010640e:	6a 39                	push   $0x39
80106410:	e9 49 f9 ff ff       	jmp    80105d5e <alltraps>

80106415 <vector58>:
80106415:	6a 00                	push   $0x0
80106417:	6a 3a                	push   $0x3a
80106419:	e9 40 f9 ff ff       	jmp    80105d5e <alltraps>

8010641e <vector59>:
8010641e:	6a 00                	push   $0x0
80106420:	6a 3b                	push   $0x3b
80106422:	e9 37 f9 ff ff       	jmp    80105d5e <alltraps>

80106427 <vector60>:
80106427:	6a 00                	push   $0x0
80106429:	6a 3c                	push   $0x3c
8010642b:	e9 2e f9 ff ff       	jmp    80105d5e <alltraps>

80106430 <vector61>:
80106430:	6a 00                	push   $0x0
80106432:	6a 3d                	push   $0x3d
80106434:	e9 25 f9 ff ff       	jmp    80105d5e <alltraps>

80106439 <vector62>:
80106439:	6a 00                	push   $0x0
8010643b:	6a 3e                	push   $0x3e
8010643d:	e9 1c f9 ff ff       	jmp    80105d5e <alltraps>

80106442 <vector63>:
80106442:	6a 00                	push   $0x0
80106444:	6a 3f                	push   $0x3f
80106446:	e9 13 f9 ff ff       	jmp    80105d5e <alltraps>

8010644b <vector64>:
8010644b:	6a 00                	push   $0x0
8010644d:	6a 40                	push   $0x40
8010644f:	e9 0a f9 ff ff       	jmp    80105d5e <alltraps>

80106454 <vector65>:
80106454:	6a 00                	push   $0x0
80106456:	6a 41                	push   $0x41
80106458:	e9 01 f9 ff ff       	jmp    80105d5e <alltraps>

8010645d <vector66>:
8010645d:	6a 00                	push   $0x0
8010645f:	6a 42                	push   $0x42
80106461:	e9 f8 f8 ff ff       	jmp    80105d5e <alltraps>

80106466 <vector67>:
80106466:	6a 00                	push   $0x0
80106468:	6a 43                	push   $0x43
8010646a:	e9 ef f8 ff ff       	jmp    80105d5e <alltraps>

8010646f <vector68>:
8010646f:	6a 00                	push   $0x0
80106471:	6a 44                	push   $0x44
80106473:	e9 e6 f8 ff ff       	jmp    80105d5e <alltraps>

80106478 <vector69>:
80106478:	6a 00                	push   $0x0
8010647a:	6a 45                	push   $0x45
8010647c:	e9 dd f8 ff ff       	jmp    80105d5e <alltraps>

80106481 <vector70>:
80106481:	6a 00                	push   $0x0
80106483:	6a 46                	push   $0x46
80106485:	e9 d4 f8 ff ff       	jmp    80105d5e <alltraps>

8010648a <vector71>:
8010648a:	6a 00                	push   $0x0
8010648c:	6a 47                	push   $0x47
8010648e:	e9 cb f8 ff ff       	jmp    80105d5e <alltraps>

80106493 <vector72>:
80106493:	6a 00                	push   $0x0
80106495:	6a 48                	push   $0x48
80106497:	e9 c2 f8 ff ff       	jmp    80105d5e <alltraps>

8010649c <vector73>:
8010649c:	6a 00                	push   $0x0
8010649e:	6a 49                	push   $0x49
801064a0:	e9 b9 f8 ff ff       	jmp    80105d5e <alltraps>

801064a5 <vector74>:
801064a5:	6a 00                	push   $0x0
801064a7:	6a 4a                	push   $0x4a
801064a9:	e9 b0 f8 ff ff       	jmp    80105d5e <alltraps>

801064ae <vector75>:
801064ae:	6a 00                	push   $0x0
801064b0:	6a 4b                	push   $0x4b
801064b2:	e9 a7 f8 ff ff       	jmp    80105d5e <alltraps>

801064b7 <vector76>:
801064b7:	6a 00                	push   $0x0
801064b9:	6a 4c                	push   $0x4c
801064bb:	e9 9e f8 ff ff       	jmp    80105d5e <alltraps>

801064c0 <vector77>:
801064c0:	6a 00                	push   $0x0
801064c2:	6a 4d                	push   $0x4d
801064c4:	e9 95 f8 ff ff       	jmp    80105d5e <alltraps>

801064c9 <vector78>:
801064c9:	6a 00                	push   $0x0
801064cb:	6a 4e                	push   $0x4e
801064cd:	e9 8c f8 ff ff       	jmp    80105d5e <alltraps>

801064d2 <vector79>:
801064d2:	6a 00                	push   $0x0
801064d4:	6a 4f                	push   $0x4f
801064d6:	e9 83 f8 ff ff       	jmp    80105d5e <alltraps>

801064db <vector80>:
801064db:	6a 00                	push   $0x0
801064dd:	6a 50                	push   $0x50
801064df:	e9 7a f8 ff ff       	jmp    80105d5e <alltraps>

801064e4 <vector81>:
801064e4:	6a 00                	push   $0x0
801064e6:	6a 51                	push   $0x51
801064e8:	e9 71 f8 ff ff       	jmp    80105d5e <alltraps>

801064ed <vector82>:
801064ed:	6a 00                	push   $0x0
801064ef:	6a 52                	push   $0x52
801064f1:	e9 68 f8 ff ff       	jmp    80105d5e <alltraps>

801064f6 <vector83>:
801064f6:	6a 00                	push   $0x0
801064f8:	6a 53                	push   $0x53
801064fa:	e9 5f f8 ff ff       	jmp    80105d5e <alltraps>

801064ff <vector84>:
801064ff:	6a 00                	push   $0x0
80106501:	6a 54                	push   $0x54
80106503:	e9 56 f8 ff ff       	jmp    80105d5e <alltraps>

80106508 <vector85>:
80106508:	6a 00                	push   $0x0
8010650a:	6a 55                	push   $0x55
8010650c:	e9 4d f8 ff ff       	jmp    80105d5e <alltraps>

80106511 <vector86>:
80106511:	6a 00                	push   $0x0
80106513:	6a 56                	push   $0x56
80106515:	e9 44 f8 ff ff       	jmp    80105d5e <alltraps>

8010651a <vector87>:
8010651a:	6a 00                	push   $0x0
8010651c:	6a 57                	push   $0x57
8010651e:	e9 3b f8 ff ff       	jmp    80105d5e <alltraps>

80106523 <vector88>:
80106523:	6a 00                	push   $0x0
80106525:	6a 58                	push   $0x58
80106527:	e9 32 f8 ff ff       	jmp    80105d5e <alltraps>

8010652c <vector89>:
8010652c:	6a 00                	push   $0x0
8010652e:	6a 59                	push   $0x59
80106530:	e9 29 f8 ff ff       	jmp    80105d5e <alltraps>

80106535 <vector90>:
80106535:	6a 00                	push   $0x0
80106537:	6a 5a                	push   $0x5a
80106539:	e9 20 f8 ff ff       	jmp    80105d5e <alltraps>

8010653e <vector91>:
8010653e:	6a 00                	push   $0x0
80106540:	6a 5b                	push   $0x5b
80106542:	e9 17 f8 ff ff       	jmp    80105d5e <alltraps>

80106547 <vector92>:
80106547:	6a 00                	push   $0x0
80106549:	6a 5c                	push   $0x5c
8010654b:	e9 0e f8 ff ff       	jmp    80105d5e <alltraps>

80106550 <vector93>:
80106550:	6a 00                	push   $0x0
80106552:	6a 5d                	push   $0x5d
80106554:	e9 05 f8 ff ff       	jmp    80105d5e <alltraps>

80106559 <vector94>:
80106559:	6a 00                	push   $0x0
8010655b:	6a 5e                	push   $0x5e
8010655d:	e9 fc f7 ff ff       	jmp    80105d5e <alltraps>

80106562 <vector95>:
80106562:	6a 00                	push   $0x0
80106564:	6a 5f                	push   $0x5f
80106566:	e9 f3 f7 ff ff       	jmp    80105d5e <alltraps>

8010656b <vector96>:
8010656b:	6a 00                	push   $0x0
8010656d:	6a 60                	push   $0x60
8010656f:	e9 ea f7 ff ff       	jmp    80105d5e <alltraps>

80106574 <vector97>:
80106574:	6a 00                	push   $0x0
80106576:	6a 61                	push   $0x61
80106578:	e9 e1 f7 ff ff       	jmp    80105d5e <alltraps>

8010657d <vector98>:
8010657d:	6a 00                	push   $0x0
8010657f:	6a 62                	push   $0x62
80106581:	e9 d8 f7 ff ff       	jmp    80105d5e <alltraps>

80106586 <vector99>:
80106586:	6a 00                	push   $0x0
80106588:	6a 63                	push   $0x63
8010658a:	e9 cf f7 ff ff       	jmp    80105d5e <alltraps>

8010658f <vector100>:
8010658f:	6a 00                	push   $0x0
80106591:	6a 64                	push   $0x64
80106593:	e9 c6 f7 ff ff       	jmp    80105d5e <alltraps>

80106598 <vector101>:
80106598:	6a 00                	push   $0x0
8010659a:	6a 65                	push   $0x65
8010659c:	e9 bd f7 ff ff       	jmp    80105d5e <alltraps>

801065a1 <vector102>:
801065a1:	6a 00                	push   $0x0
801065a3:	6a 66                	push   $0x66
801065a5:	e9 b4 f7 ff ff       	jmp    80105d5e <alltraps>

801065aa <vector103>:
801065aa:	6a 00                	push   $0x0
801065ac:	6a 67                	push   $0x67
801065ae:	e9 ab f7 ff ff       	jmp    80105d5e <alltraps>

801065b3 <vector104>:
801065b3:	6a 00                	push   $0x0
801065b5:	6a 68                	push   $0x68
801065b7:	e9 a2 f7 ff ff       	jmp    80105d5e <alltraps>

801065bc <vector105>:
801065bc:	6a 00                	push   $0x0
801065be:	6a 69                	push   $0x69
801065c0:	e9 99 f7 ff ff       	jmp    80105d5e <alltraps>

801065c5 <vector106>:
801065c5:	6a 00                	push   $0x0
801065c7:	6a 6a                	push   $0x6a
801065c9:	e9 90 f7 ff ff       	jmp    80105d5e <alltraps>

801065ce <vector107>:
801065ce:	6a 00                	push   $0x0
801065d0:	6a 6b                	push   $0x6b
801065d2:	e9 87 f7 ff ff       	jmp    80105d5e <alltraps>

801065d7 <vector108>:
801065d7:	6a 00                	push   $0x0
801065d9:	6a 6c                	push   $0x6c
801065db:	e9 7e f7 ff ff       	jmp    80105d5e <alltraps>

801065e0 <vector109>:
801065e0:	6a 00                	push   $0x0
801065e2:	6a 6d                	push   $0x6d
801065e4:	e9 75 f7 ff ff       	jmp    80105d5e <alltraps>

801065e9 <vector110>:
801065e9:	6a 00                	push   $0x0
801065eb:	6a 6e                	push   $0x6e
801065ed:	e9 6c f7 ff ff       	jmp    80105d5e <alltraps>

801065f2 <vector111>:
801065f2:	6a 00                	push   $0x0
801065f4:	6a 6f                	push   $0x6f
801065f6:	e9 63 f7 ff ff       	jmp    80105d5e <alltraps>

801065fb <vector112>:
801065fb:	6a 00                	push   $0x0
801065fd:	6a 70                	push   $0x70
801065ff:	e9 5a f7 ff ff       	jmp    80105d5e <alltraps>

80106604 <vector113>:
80106604:	6a 00                	push   $0x0
80106606:	6a 71                	push   $0x71
80106608:	e9 51 f7 ff ff       	jmp    80105d5e <alltraps>

8010660d <vector114>:
8010660d:	6a 00                	push   $0x0
8010660f:	6a 72                	push   $0x72
80106611:	e9 48 f7 ff ff       	jmp    80105d5e <alltraps>

80106616 <vector115>:
80106616:	6a 00                	push   $0x0
80106618:	6a 73                	push   $0x73
8010661a:	e9 3f f7 ff ff       	jmp    80105d5e <alltraps>

8010661f <vector116>:
8010661f:	6a 00                	push   $0x0
80106621:	6a 74                	push   $0x74
80106623:	e9 36 f7 ff ff       	jmp    80105d5e <alltraps>

80106628 <vector117>:
80106628:	6a 00                	push   $0x0
8010662a:	6a 75                	push   $0x75
8010662c:	e9 2d f7 ff ff       	jmp    80105d5e <alltraps>

80106631 <vector118>:
80106631:	6a 00                	push   $0x0
80106633:	6a 76                	push   $0x76
80106635:	e9 24 f7 ff ff       	jmp    80105d5e <alltraps>

8010663a <vector119>:
8010663a:	6a 00                	push   $0x0
8010663c:	6a 77                	push   $0x77
8010663e:	e9 1b f7 ff ff       	jmp    80105d5e <alltraps>

80106643 <vector120>:
80106643:	6a 00                	push   $0x0
80106645:	6a 78                	push   $0x78
80106647:	e9 12 f7 ff ff       	jmp    80105d5e <alltraps>

8010664c <vector121>:
8010664c:	6a 00                	push   $0x0
8010664e:	6a 79                	push   $0x79
80106650:	e9 09 f7 ff ff       	jmp    80105d5e <alltraps>

80106655 <vector122>:
80106655:	6a 00                	push   $0x0
80106657:	6a 7a                	push   $0x7a
80106659:	e9 00 f7 ff ff       	jmp    80105d5e <alltraps>

8010665e <vector123>:
8010665e:	6a 00                	push   $0x0
80106660:	6a 7b                	push   $0x7b
80106662:	e9 f7 f6 ff ff       	jmp    80105d5e <alltraps>

80106667 <vector124>:
80106667:	6a 00                	push   $0x0
80106669:	6a 7c                	push   $0x7c
8010666b:	e9 ee f6 ff ff       	jmp    80105d5e <alltraps>

80106670 <vector125>:
80106670:	6a 00                	push   $0x0
80106672:	6a 7d                	push   $0x7d
80106674:	e9 e5 f6 ff ff       	jmp    80105d5e <alltraps>

80106679 <vector126>:
80106679:	6a 00                	push   $0x0
8010667b:	6a 7e                	push   $0x7e
8010667d:	e9 dc f6 ff ff       	jmp    80105d5e <alltraps>

80106682 <vector127>:
80106682:	6a 00                	push   $0x0
80106684:	6a 7f                	push   $0x7f
80106686:	e9 d3 f6 ff ff       	jmp    80105d5e <alltraps>

8010668b <vector128>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 80 00 00 00       	push   $0x80
80106692:	e9 c7 f6 ff ff       	jmp    80105d5e <alltraps>

80106697 <vector129>:
80106697:	6a 00                	push   $0x0
80106699:	68 81 00 00 00       	push   $0x81
8010669e:	e9 bb f6 ff ff       	jmp    80105d5e <alltraps>

801066a3 <vector130>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 82 00 00 00       	push   $0x82
801066aa:	e9 af f6 ff ff       	jmp    80105d5e <alltraps>

801066af <vector131>:
801066af:	6a 00                	push   $0x0
801066b1:	68 83 00 00 00       	push   $0x83
801066b6:	e9 a3 f6 ff ff       	jmp    80105d5e <alltraps>

801066bb <vector132>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 84 00 00 00       	push   $0x84
801066c2:	e9 97 f6 ff ff       	jmp    80105d5e <alltraps>

801066c7 <vector133>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 85 00 00 00       	push   $0x85
801066ce:	e9 8b f6 ff ff       	jmp    80105d5e <alltraps>

801066d3 <vector134>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 86 00 00 00       	push   $0x86
801066da:	e9 7f f6 ff ff       	jmp    80105d5e <alltraps>

801066df <vector135>:
801066df:	6a 00                	push   $0x0
801066e1:	68 87 00 00 00       	push   $0x87
801066e6:	e9 73 f6 ff ff       	jmp    80105d5e <alltraps>

801066eb <vector136>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 88 00 00 00       	push   $0x88
801066f2:	e9 67 f6 ff ff       	jmp    80105d5e <alltraps>

801066f7 <vector137>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 89 00 00 00       	push   $0x89
801066fe:	e9 5b f6 ff ff       	jmp    80105d5e <alltraps>

80106703 <vector138>:
80106703:	6a 00                	push   $0x0
80106705:	68 8a 00 00 00       	push   $0x8a
8010670a:	e9 4f f6 ff ff       	jmp    80105d5e <alltraps>

8010670f <vector139>:
8010670f:	6a 00                	push   $0x0
80106711:	68 8b 00 00 00       	push   $0x8b
80106716:	e9 43 f6 ff ff       	jmp    80105d5e <alltraps>

8010671b <vector140>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 8c 00 00 00       	push   $0x8c
80106722:	e9 37 f6 ff ff       	jmp    80105d5e <alltraps>

80106727 <vector141>:
80106727:	6a 00                	push   $0x0
80106729:	68 8d 00 00 00       	push   $0x8d
8010672e:	e9 2b f6 ff ff       	jmp    80105d5e <alltraps>

80106733 <vector142>:
80106733:	6a 00                	push   $0x0
80106735:	68 8e 00 00 00       	push   $0x8e
8010673a:	e9 1f f6 ff ff       	jmp    80105d5e <alltraps>

8010673f <vector143>:
8010673f:	6a 00                	push   $0x0
80106741:	68 8f 00 00 00       	push   $0x8f
80106746:	e9 13 f6 ff ff       	jmp    80105d5e <alltraps>

8010674b <vector144>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 90 00 00 00       	push   $0x90
80106752:	e9 07 f6 ff ff       	jmp    80105d5e <alltraps>

80106757 <vector145>:
80106757:	6a 00                	push   $0x0
80106759:	68 91 00 00 00       	push   $0x91
8010675e:	e9 fb f5 ff ff       	jmp    80105d5e <alltraps>

80106763 <vector146>:
80106763:	6a 00                	push   $0x0
80106765:	68 92 00 00 00       	push   $0x92
8010676a:	e9 ef f5 ff ff       	jmp    80105d5e <alltraps>

8010676f <vector147>:
8010676f:	6a 00                	push   $0x0
80106771:	68 93 00 00 00       	push   $0x93
80106776:	e9 e3 f5 ff ff       	jmp    80105d5e <alltraps>

8010677b <vector148>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 94 00 00 00       	push   $0x94
80106782:	e9 d7 f5 ff ff       	jmp    80105d5e <alltraps>

80106787 <vector149>:
80106787:	6a 00                	push   $0x0
80106789:	68 95 00 00 00       	push   $0x95
8010678e:	e9 cb f5 ff ff       	jmp    80105d5e <alltraps>

80106793 <vector150>:
80106793:	6a 00                	push   $0x0
80106795:	68 96 00 00 00       	push   $0x96
8010679a:	e9 bf f5 ff ff       	jmp    80105d5e <alltraps>

8010679f <vector151>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 97 00 00 00       	push   $0x97
801067a6:	e9 b3 f5 ff ff       	jmp    80105d5e <alltraps>

801067ab <vector152>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 98 00 00 00       	push   $0x98
801067b2:	e9 a7 f5 ff ff       	jmp    80105d5e <alltraps>

801067b7 <vector153>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 99 00 00 00       	push   $0x99
801067be:	e9 9b f5 ff ff       	jmp    80105d5e <alltraps>

801067c3 <vector154>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 9a 00 00 00       	push   $0x9a
801067ca:	e9 8f f5 ff ff       	jmp    80105d5e <alltraps>

801067cf <vector155>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 9b 00 00 00       	push   $0x9b
801067d6:	e9 83 f5 ff ff       	jmp    80105d5e <alltraps>

801067db <vector156>:
801067db:	6a 00                	push   $0x0
801067dd:	68 9c 00 00 00       	push   $0x9c
801067e2:	e9 77 f5 ff ff       	jmp    80105d5e <alltraps>

801067e7 <vector157>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 9d 00 00 00       	push   $0x9d
801067ee:	e9 6b f5 ff ff       	jmp    80105d5e <alltraps>

801067f3 <vector158>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 9e 00 00 00       	push   $0x9e
801067fa:	e9 5f f5 ff ff       	jmp    80105d5e <alltraps>

801067ff <vector159>:
801067ff:	6a 00                	push   $0x0
80106801:	68 9f 00 00 00       	push   $0x9f
80106806:	e9 53 f5 ff ff       	jmp    80105d5e <alltraps>

8010680b <vector160>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 a0 00 00 00       	push   $0xa0
80106812:	e9 47 f5 ff ff       	jmp    80105d5e <alltraps>

80106817 <vector161>:
80106817:	6a 00                	push   $0x0
80106819:	68 a1 00 00 00       	push   $0xa1
8010681e:	e9 3b f5 ff ff       	jmp    80105d5e <alltraps>

80106823 <vector162>:
80106823:	6a 00                	push   $0x0
80106825:	68 a2 00 00 00       	push   $0xa2
8010682a:	e9 2f f5 ff ff       	jmp    80105d5e <alltraps>

8010682f <vector163>:
8010682f:	6a 00                	push   $0x0
80106831:	68 a3 00 00 00       	push   $0xa3
80106836:	e9 23 f5 ff ff       	jmp    80105d5e <alltraps>

8010683b <vector164>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 a4 00 00 00       	push   $0xa4
80106842:	e9 17 f5 ff ff       	jmp    80105d5e <alltraps>

80106847 <vector165>:
80106847:	6a 00                	push   $0x0
80106849:	68 a5 00 00 00       	push   $0xa5
8010684e:	e9 0b f5 ff ff       	jmp    80105d5e <alltraps>

80106853 <vector166>:
80106853:	6a 00                	push   $0x0
80106855:	68 a6 00 00 00       	push   $0xa6
8010685a:	e9 ff f4 ff ff       	jmp    80105d5e <alltraps>

8010685f <vector167>:
8010685f:	6a 00                	push   $0x0
80106861:	68 a7 00 00 00       	push   $0xa7
80106866:	e9 f3 f4 ff ff       	jmp    80105d5e <alltraps>

8010686b <vector168>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 a8 00 00 00       	push   $0xa8
80106872:	e9 e7 f4 ff ff       	jmp    80105d5e <alltraps>

80106877 <vector169>:
80106877:	6a 00                	push   $0x0
80106879:	68 a9 00 00 00       	push   $0xa9
8010687e:	e9 db f4 ff ff       	jmp    80105d5e <alltraps>

80106883 <vector170>:
80106883:	6a 00                	push   $0x0
80106885:	68 aa 00 00 00       	push   $0xaa
8010688a:	e9 cf f4 ff ff       	jmp    80105d5e <alltraps>

8010688f <vector171>:
8010688f:	6a 00                	push   $0x0
80106891:	68 ab 00 00 00       	push   $0xab
80106896:	e9 c3 f4 ff ff       	jmp    80105d5e <alltraps>

8010689b <vector172>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 ac 00 00 00       	push   $0xac
801068a2:	e9 b7 f4 ff ff       	jmp    80105d5e <alltraps>

801068a7 <vector173>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 ad 00 00 00       	push   $0xad
801068ae:	e9 ab f4 ff ff       	jmp    80105d5e <alltraps>

801068b3 <vector174>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 ae 00 00 00       	push   $0xae
801068ba:	e9 9f f4 ff ff       	jmp    80105d5e <alltraps>

801068bf <vector175>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 af 00 00 00       	push   $0xaf
801068c6:	e9 93 f4 ff ff       	jmp    80105d5e <alltraps>

801068cb <vector176>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 b0 00 00 00       	push   $0xb0
801068d2:	e9 87 f4 ff ff       	jmp    80105d5e <alltraps>

801068d7 <vector177>:
801068d7:	6a 00                	push   $0x0
801068d9:	68 b1 00 00 00       	push   $0xb1
801068de:	e9 7b f4 ff ff       	jmp    80105d5e <alltraps>

801068e3 <vector178>:
801068e3:	6a 00                	push   $0x0
801068e5:	68 b2 00 00 00       	push   $0xb2
801068ea:	e9 6f f4 ff ff       	jmp    80105d5e <alltraps>

801068ef <vector179>:
801068ef:	6a 00                	push   $0x0
801068f1:	68 b3 00 00 00       	push   $0xb3
801068f6:	e9 63 f4 ff ff       	jmp    80105d5e <alltraps>

801068fb <vector180>:
801068fb:	6a 00                	push   $0x0
801068fd:	68 b4 00 00 00       	push   $0xb4
80106902:	e9 57 f4 ff ff       	jmp    80105d5e <alltraps>

80106907 <vector181>:
80106907:	6a 00                	push   $0x0
80106909:	68 b5 00 00 00       	push   $0xb5
8010690e:	e9 4b f4 ff ff       	jmp    80105d5e <alltraps>

80106913 <vector182>:
80106913:	6a 00                	push   $0x0
80106915:	68 b6 00 00 00       	push   $0xb6
8010691a:	e9 3f f4 ff ff       	jmp    80105d5e <alltraps>

8010691f <vector183>:
8010691f:	6a 00                	push   $0x0
80106921:	68 b7 00 00 00       	push   $0xb7
80106926:	e9 33 f4 ff ff       	jmp    80105d5e <alltraps>

8010692b <vector184>:
8010692b:	6a 00                	push   $0x0
8010692d:	68 b8 00 00 00       	push   $0xb8
80106932:	e9 27 f4 ff ff       	jmp    80105d5e <alltraps>

80106937 <vector185>:
80106937:	6a 00                	push   $0x0
80106939:	68 b9 00 00 00       	push   $0xb9
8010693e:	e9 1b f4 ff ff       	jmp    80105d5e <alltraps>

80106943 <vector186>:
80106943:	6a 00                	push   $0x0
80106945:	68 ba 00 00 00       	push   $0xba
8010694a:	e9 0f f4 ff ff       	jmp    80105d5e <alltraps>

8010694f <vector187>:
8010694f:	6a 00                	push   $0x0
80106951:	68 bb 00 00 00       	push   $0xbb
80106956:	e9 03 f4 ff ff       	jmp    80105d5e <alltraps>

8010695b <vector188>:
8010695b:	6a 00                	push   $0x0
8010695d:	68 bc 00 00 00       	push   $0xbc
80106962:	e9 f7 f3 ff ff       	jmp    80105d5e <alltraps>

80106967 <vector189>:
80106967:	6a 00                	push   $0x0
80106969:	68 bd 00 00 00       	push   $0xbd
8010696e:	e9 eb f3 ff ff       	jmp    80105d5e <alltraps>

80106973 <vector190>:
80106973:	6a 00                	push   $0x0
80106975:	68 be 00 00 00       	push   $0xbe
8010697a:	e9 df f3 ff ff       	jmp    80105d5e <alltraps>

8010697f <vector191>:
8010697f:	6a 00                	push   $0x0
80106981:	68 bf 00 00 00       	push   $0xbf
80106986:	e9 d3 f3 ff ff       	jmp    80105d5e <alltraps>

8010698b <vector192>:
8010698b:	6a 00                	push   $0x0
8010698d:	68 c0 00 00 00       	push   $0xc0
80106992:	e9 c7 f3 ff ff       	jmp    80105d5e <alltraps>

80106997 <vector193>:
80106997:	6a 00                	push   $0x0
80106999:	68 c1 00 00 00       	push   $0xc1
8010699e:	e9 bb f3 ff ff       	jmp    80105d5e <alltraps>

801069a3 <vector194>:
801069a3:	6a 00                	push   $0x0
801069a5:	68 c2 00 00 00       	push   $0xc2
801069aa:	e9 af f3 ff ff       	jmp    80105d5e <alltraps>

801069af <vector195>:
801069af:	6a 00                	push   $0x0
801069b1:	68 c3 00 00 00       	push   $0xc3
801069b6:	e9 a3 f3 ff ff       	jmp    80105d5e <alltraps>

801069bb <vector196>:
801069bb:	6a 00                	push   $0x0
801069bd:	68 c4 00 00 00       	push   $0xc4
801069c2:	e9 97 f3 ff ff       	jmp    80105d5e <alltraps>

801069c7 <vector197>:
801069c7:	6a 00                	push   $0x0
801069c9:	68 c5 00 00 00       	push   $0xc5
801069ce:	e9 8b f3 ff ff       	jmp    80105d5e <alltraps>

801069d3 <vector198>:
801069d3:	6a 00                	push   $0x0
801069d5:	68 c6 00 00 00       	push   $0xc6
801069da:	e9 7f f3 ff ff       	jmp    80105d5e <alltraps>

801069df <vector199>:
801069df:	6a 00                	push   $0x0
801069e1:	68 c7 00 00 00       	push   $0xc7
801069e6:	e9 73 f3 ff ff       	jmp    80105d5e <alltraps>

801069eb <vector200>:
801069eb:	6a 00                	push   $0x0
801069ed:	68 c8 00 00 00       	push   $0xc8
801069f2:	e9 67 f3 ff ff       	jmp    80105d5e <alltraps>

801069f7 <vector201>:
801069f7:	6a 00                	push   $0x0
801069f9:	68 c9 00 00 00       	push   $0xc9
801069fe:	e9 5b f3 ff ff       	jmp    80105d5e <alltraps>

80106a03 <vector202>:
80106a03:	6a 00                	push   $0x0
80106a05:	68 ca 00 00 00       	push   $0xca
80106a0a:	e9 4f f3 ff ff       	jmp    80105d5e <alltraps>

80106a0f <vector203>:
80106a0f:	6a 00                	push   $0x0
80106a11:	68 cb 00 00 00       	push   $0xcb
80106a16:	e9 43 f3 ff ff       	jmp    80105d5e <alltraps>

80106a1b <vector204>:
80106a1b:	6a 00                	push   $0x0
80106a1d:	68 cc 00 00 00       	push   $0xcc
80106a22:	e9 37 f3 ff ff       	jmp    80105d5e <alltraps>

80106a27 <vector205>:
80106a27:	6a 00                	push   $0x0
80106a29:	68 cd 00 00 00       	push   $0xcd
80106a2e:	e9 2b f3 ff ff       	jmp    80105d5e <alltraps>

80106a33 <vector206>:
80106a33:	6a 00                	push   $0x0
80106a35:	68 ce 00 00 00       	push   $0xce
80106a3a:	e9 1f f3 ff ff       	jmp    80105d5e <alltraps>

80106a3f <vector207>:
80106a3f:	6a 00                	push   $0x0
80106a41:	68 cf 00 00 00       	push   $0xcf
80106a46:	e9 13 f3 ff ff       	jmp    80105d5e <alltraps>

80106a4b <vector208>:
80106a4b:	6a 00                	push   $0x0
80106a4d:	68 d0 00 00 00       	push   $0xd0
80106a52:	e9 07 f3 ff ff       	jmp    80105d5e <alltraps>

80106a57 <vector209>:
80106a57:	6a 00                	push   $0x0
80106a59:	68 d1 00 00 00       	push   $0xd1
80106a5e:	e9 fb f2 ff ff       	jmp    80105d5e <alltraps>

80106a63 <vector210>:
80106a63:	6a 00                	push   $0x0
80106a65:	68 d2 00 00 00       	push   $0xd2
80106a6a:	e9 ef f2 ff ff       	jmp    80105d5e <alltraps>

80106a6f <vector211>:
80106a6f:	6a 00                	push   $0x0
80106a71:	68 d3 00 00 00       	push   $0xd3
80106a76:	e9 e3 f2 ff ff       	jmp    80105d5e <alltraps>

80106a7b <vector212>:
80106a7b:	6a 00                	push   $0x0
80106a7d:	68 d4 00 00 00       	push   $0xd4
80106a82:	e9 d7 f2 ff ff       	jmp    80105d5e <alltraps>

80106a87 <vector213>:
80106a87:	6a 00                	push   $0x0
80106a89:	68 d5 00 00 00       	push   $0xd5
80106a8e:	e9 cb f2 ff ff       	jmp    80105d5e <alltraps>

80106a93 <vector214>:
80106a93:	6a 00                	push   $0x0
80106a95:	68 d6 00 00 00       	push   $0xd6
80106a9a:	e9 bf f2 ff ff       	jmp    80105d5e <alltraps>

80106a9f <vector215>:
80106a9f:	6a 00                	push   $0x0
80106aa1:	68 d7 00 00 00       	push   $0xd7
80106aa6:	e9 b3 f2 ff ff       	jmp    80105d5e <alltraps>

80106aab <vector216>:
80106aab:	6a 00                	push   $0x0
80106aad:	68 d8 00 00 00       	push   $0xd8
80106ab2:	e9 a7 f2 ff ff       	jmp    80105d5e <alltraps>

80106ab7 <vector217>:
80106ab7:	6a 00                	push   $0x0
80106ab9:	68 d9 00 00 00       	push   $0xd9
80106abe:	e9 9b f2 ff ff       	jmp    80105d5e <alltraps>

80106ac3 <vector218>:
80106ac3:	6a 00                	push   $0x0
80106ac5:	68 da 00 00 00       	push   $0xda
80106aca:	e9 8f f2 ff ff       	jmp    80105d5e <alltraps>

80106acf <vector219>:
80106acf:	6a 00                	push   $0x0
80106ad1:	68 db 00 00 00       	push   $0xdb
80106ad6:	e9 83 f2 ff ff       	jmp    80105d5e <alltraps>

80106adb <vector220>:
80106adb:	6a 00                	push   $0x0
80106add:	68 dc 00 00 00       	push   $0xdc
80106ae2:	e9 77 f2 ff ff       	jmp    80105d5e <alltraps>

80106ae7 <vector221>:
80106ae7:	6a 00                	push   $0x0
80106ae9:	68 dd 00 00 00       	push   $0xdd
80106aee:	e9 6b f2 ff ff       	jmp    80105d5e <alltraps>

80106af3 <vector222>:
80106af3:	6a 00                	push   $0x0
80106af5:	68 de 00 00 00       	push   $0xde
80106afa:	e9 5f f2 ff ff       	jmp    80105d5e <alltraps>

80106aff <vector223>:
80106aff:	6a 00                	push   $0x0
80106b01:	68 df 00 00 00       	push   $0xdf
80106b06:	e9 53 f2 ff ff       	jmp    80105d5e <alltraps>

80106b0b <vector224>:
80106b0b:	6a 00                	push   $0x0
80106b0d:	68 e0 00 00 00       	push   $0xe0
80106b12:	e9 47 f2 ff ff       	jmp    80105d5e <alltraps>

80106b17 <vector225>:
80106b17:	6a 00                	push   $0x0
80106b19:	68 e1 00 00 00       	push   $0xe1
80106b1e:	e9 3b f2 ff ff       	jmp    80105d5e <alltraps>

80106b23 <vector226>:
80106b23:	6a 00                	push   $0x0
80106b25:	68 e2 00 00 00       	push   $0xe2
80106b2a:	e9 2f f2 ff ff       	jmp    80105d5e <alltraps>

80106b2f <vector227>:
80106b2f:	6a 00                	push   $0x0
80106b31:	68 e3 00 00 00       	push   $0xe3
80106b36:	e9 23 f2 ff ff       	jmp    80105d5e <alltraps>

80106b3b <vector228>:
80106b3b:	6a 00                	push   $0x0
80106b3d:	68 e4 00 00 00       	push   $0xe4
80106b42:	e9 17 f2 ff ff       	jmp    80105d5e <alltraps>

80106b47 <vector229>:
80106b47:	6a 00                	push   $0x0
80106b49:	68 e5 00 00 00       	push   $0xe5
80106b4e:	e9 0b f2 ff ff       	jmp    80105d5e <alltraps>

80106b53 <vector230>:
80106b53:	6a 00                	push   $0x0
80106b55:	68 e6 00 00 00       	push   $0xe6
80106b5a:	e9 ff f1 ff ff       	jmp    80105d5e <alltraps>

80106b5f <vector231>:
80106b5f:	6a 00                	push   $0x0
80106b61:	68 e7 00 00 00       	push   $0xe7
80106b66:	e9 f3 f1 ff ff       	jmp    80105d5e <alltraps>

80106b6b <vector232>:
80106b6b:	6a 00                	push   $0x0
80106b6d:	68 e8 00 00 00       	push   $0xe8
80106b72:	e9 e7 f1 ff ff       	jmp    80105d5e <alltraps>

80106b77 <vector233>:
80106b77:	6a 00                	push   $0x0
80106b79:	68 e9 00 00 00       	push   $0xe9
80106b7e:	e9 db f1 ff ff       	jmp    80105d5e <alltraps>

80106b83 <vector234>:
80106b83:	6a 00                	push   $0x0
80106b85:	68 ea 00 00 00       	push   $0xea
80106b8a:	e9 cf f1 ff ff       	jmp    80105d5e <alltraps>

80106b8f <vector235>:
80106b8f:	6a 00                	push   $0x0
80106b91:	68 eb 00 00 00       	push   $0xeb
80106b96:	e9 c3 f1 ff ff       	jmp    80105d5e <alltraps>

80106b9b <vector236>:
80106b9b:	6a 00                	push   $0x0
80106b9d:	68 ec 00 00 00       	push   $0xec
80106ba2:	e9 b7 f1 ff ff       	jmp    80105d5e <alltraps>

80106ba7 <vector237>:
80106ba7:	6a 00                	push   $0x0
80106ba9:	68 ed 00 00 00       	push   $0xed
80106bae:	e9 ab f1 ff ff       	jmp    80105d5e <alltraps>

80106bb3 <vector238>:
80106bb3:	6a 00                	push   $0x0
80106bb5:	68 ee 00 00 00       	push   $0xee
80106bba:	e9 9f f1 ff ff       	jmp    80105d5e <alltraps>

80106bbf <vector239>:
80106bbf:	6a 00                	push   $0x0
80106bc1:	68 ef 00 00 00       	push   $0xef
80106bc6:	e9 93 f1 ff ff       	jmp    80105d5e <alltraps>

80106bcb <vector240>:
80106bcb:	6a 00                	push   $0x0
80106bcd:	68 f0 00 00 00       	push   $0xf0
80106bd2:	e9 87 f1 ff ff       	jmp    80105d5e <alltraps>

80106bd7 <vector241>:
80106bd7:	6a 00                	push   $0x0
80106bd9:	68 f1 00 00 00       	push   $0xf1
80106bde:	e9 7b f1 ff ff       	jmp    80105d5e <alltraps>

80106be3 <vector242>:
80106be3:	6a 00                	push   $0x0
80106be5:	68 f2 00 00 00       	push   $0xf2
80106bea:	e9 6f f1 ff ff       	jmp    80105d5e <alltraps>

80106bef <vector243>:
80106bef:	6a 00                	push   $0x0
80106bf1:	68 f3 00 00 00       	push   $0xf3
80106bf6:	e9 63 f1 ff ff       	jmp    80105d5e <alltraps>

80106bfb <vector244>:
80106bfb:	6a 00                	push   $0x0
80106bfd:	68 f4 00 00 00       	push   $0xf4
80106c02:	e9 57 f1 ff ff       	jmp    80105d5e <alltraps>

80106c07 <vector245>:
80106c07:	6a 00                	push   $0x0
80106c09:	68 f5 00 00 00       	push   $0xf5
80106c0e:	e9 4b f1 ff ff       	jmp    80105d5e <alltraps>

80106c13 <vector246>:
80106c13:	6a 00                	push   $0x0
80106c15:	68 f6 00 00 00       	push   $0xf6
80106c1a:	e9 3f f1 ff ff       	jmp    80105d5e <alltraps>

80106c1f <vector247>:
80106c1f:	6a 00                	push   $0x0
80106c21:	68 f7 00 00 00       	push   $0xf7
80106c26:	e9 33 f1 ff ff       	jmp    80105d5e <alltraps>

80106c2b <vector248>:
80106c2b:	6a 00                	push   $0x0
80106c2d:	68 f8 00 00 00       	push   $0xf8
80106c32:	e9 27 f1 ff ff       	jmp    80105d5e <alltraps>

80106c37 <vector249>:
80106c37:	6a 00                	push   $0x0
80106c39:	68 f9 00 00 00       	push   $0xf9
80106c3e:	e9 1b f1 ff ff       	jmp    80105d5e <alltraps>

80106c43 <vector250>:
80106c43:	6a 00                	push   $0x0
80106c45:	68 fa 00 00 00       	push   $0xfa
80106c4a:	e9 0f f1 ff ff       	jmp    80105d5e <alltraps>

80106c4f <vector251>:
80106c4f:	6a 00                	push   $0x0
80106c51:	68 fb 00 00 00       	push   $0xfb
80106c56:	e9 03 f1 ff ff       	jmp    80105d5e <alltraps>

80106c5b <vector252>:
80106c5b:	6a 00                	push   $0x0
80106c5d:	68 fc 00 00 00       	push   $0xfc
80106c62:	e9 f7 f0 ff ff       	jmp    80105d5e <alltraps>

80106c67 <vector253>:
80106c67:	6a 00                	push   $0x0
80106c69:	68 fd 00 00 00       	push   $0xfd
80106c6e:	e9 eb f0 ff ff       	jmp    80105d5e <alltraps>

80106c73 <vector254>:
80106c73:	6a 00                	push   $0x0
80106c75:	68 fe 00 00 00       	push   $0xfe
80106c7a:	e9 df f0 ff ff       	jmp    80105d5e <alltraps>

80106c7f <vector255>:
80106c7f:	6a 00                	push   $0x0
80106c81:	68 ff 00 00 00       	push   $0xff
80106c86:	e9 d3 f0 ff ff       	jmp    80105d5e <alltraps>
80106c8b:	66 90                	xchg   %ax,%ax
80106c8d:	66 90                	xchg   %ax,%ax
80106c8f:	90                   	nop

80106c90 <walkpgdir>:
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	57                   	push   %edi
80106c94:	56                   	push   %esi
80106c95:	89 d6                	mov    %edx,%esi
80106c97:	c1 ea 16             	shr    $0x16,%edx
80106c9a:	53                   	push   %ebx
80106c9b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80106c9e:	83 ec 0c             	sub    $0xc,%esp
80106ca1:	8b 1f                	mov    (%edi),%ebx
80106ca3:	f6 c3 01             	test   $0x1,%bl
80106ca6:	74 28                	je     80106cd0 <walkpgdir+0x40>
80106ca8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106cae:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106cb4:	89 f0                	mov    %esi,%eax
80106cb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cb9:	c1 e8 0a             	shr    $0xa,%eax
80106cbc:	25 fc 0f 00 00       	and    $0xffc,%eax
80106cc1:	01 d8                	add    %ebx,%eax
80106cc3:	5b                   	pop    %ebx
80106cc4:	5e                   	pop    %esi
80106cc5:	5f                   	pop    %edi
80106cc6:	5d                   	pop    %ebp
80106cc7:	c3                   	ret    
80106cc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ccf:	90                   	nop
80106cd0:	85 c9                	test   %ecx,%ecx
80106cd2:	74 2c                	je     80106d00 <walkpgdir+0x70>
80106cd4:	e8 47 be ff ff       	call   80102b20 <kalloc>
80106cd9:	89 c3                	mov    %eax,%ebx
80106cdb:	85 c0                	test   %eax,%eax
80106cdd:	74 21                	je     80106d00 <walkpgdir+0x70>
80106cdf:	83 ec 04             	sub    $0x4,%esp
80106ce2:	68 00 10 00 00       	push   $0x1000
80106ce7:	6a 00                	push   $0x0
80106ce9:	50                   	push   %eax
80106cea:	e8 71 de ff ff       	call   80104b60 <memset>
80106cef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106cf5:	83 c4 10             	add    $0x10,%esp
80106cf8:	83 c8 07             	or     $0x7,%eax
80106cfb:	89 07                	mov    %eax,(%edi)
80106cfd:	eb b5                	jmp    80106cb4 <walkpgdir+0x24>
80106cff:	90                   	nop
80106d00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d03:	31 c0                	xor    %eax,%eax
80106d05:	5b                   	pop    %ebx
80106d06:	5e                   	pop    %esi
80106d07:	5f                   	pop    %edi
80106d08:	5d                   	pop    %ebp
80106d09:	c3                   	ret    
80106d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d10 <mappages>:
80106d10:	55                   	push   %ebp
80106d11:	89 e5                	mov    %esp,%ebp
80106d13:	57                   	push   %edi
80106d14:	89 c7                	mov    %eax,%edi
80106d16:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d1a:	56                   	push   %esi
80106d1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d20:	89 d6                	mov    %edx,%esi
80106d22:	53                   	push   %ebx
80106d23:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106d29:	83 ec 1c             	sub    $0x1c,%esp
80106d2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d2f:	8b 45 08             	mov    0x8(%ebp),%eax
80106d32:	29 f0                	sub    %esi,%eax
80106d34:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d37:	eb 1f                	jmp    80106d58 <mappages+0x48>
80106d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d40:	f6 00 01             	testb  $0x1,(%eax)
80106d43:	75 45                	jne    80106d8a <mappages+0x7a>
80106d45:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106d48:	83 cb 01             	or     $0x1,%ebx
80106d4b:	89 18                	mov    %ebx,(%eax)
80106d4d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106d50:	74 2e                	je     80106d80 <mappages+0x70>
80106d52:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d5b:	b9 01 00 00 00       	mov    $0x1,%ecx
80106d60:	89 f2                	mov    %esi,%edx
80106d62:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106d65:	89 f8                	mov    %edi,%eax
80106d67:	e8 24 ff ff ff       	call   80106c90 <walkpgdir>
80106d6c:	85 c0                	test   %eax,%eax
80106d6e:	75 d0                	jne    80106d40 <mappages+0x30>
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d78:	5b                   	pop    %ebx
80106d79:	5e                   	pop    %esi
80106d7a:	5f                   	pop    %edi
80106d7b:	5d                   	pop    %ebp
80106d7c:	c3                   	ret    
80106d7d:	8d 76 00             	lea    0x0(%esi),%esi
80106d80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d83:	31 c0                	xor    %eax,%eax
80106d85:	5b                   	pop    %ebx
80106d86:	5e                   	pop    %esi
80106d87:	5f                   	pop    %edi
80106d88:	5d                   	pop    %ebp
80106d89:	c3                   	ret    
80106d8a:	83 ec 0c             	sub    $0xc,%esp
80106d8d:	68 e8 7e 10 80       	push   $0x80107ee8
80106d92:	e8 f9 95 ff ff       	call   80100390 <panic>
80106d97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d9e:	66 90                	xchg   %ax,%ax

80106da0 <deallocuvm.part.0>:
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	89 c6                	mov    %eax,%esi
80106da7:	53                   	push   %ebx
80106da8:	89 d3                	mov    %edx,%ebx
80106daa:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80106db0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106db6:	83 ec 1c             	sub    $0x1c,%esp
80106db9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106dbc:	39 da                	cmp    %ebx,%edx
80106dbe:	73 5b                	jae    80106e1b <deallocuvm.part.0+0x7b>
80106dc0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106dc3:	89 d7                	mov    %edx,%edi
80106dc5:	eb 14                	jmp    80106ddb <deallocuvm.part.0+0x3b>
80106dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dce:	66 90                	xchg   %ax,%ax
80106dd0:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106dd6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106dd9:	76 40                	jbe    80106e1b <deallocuvm.part.0+0x7b>
80106ddb:	31 c9                	xor    %ecx,%ecx
80106ddd:	89 fa                	mov    %edi,%edx
80106ddf:	89 f0                	mov    %esi,%eax
80106de1:	e8 aa fe ff ff       	call   80106c90 <walkpgdir>
80106de6:	89 c3                	mov    %eax,%ebx
80106de8:	85 c0                	test   %eax,%eax
80106dea:	74 44                	je     80106e30 <deallocuvm.part.0+0x90>
80106dec:	8b 00                	mov    (%eax),%eax
80106dee:	a8 01                	test   $0x1,%al
80106df0:	74 de                	je     80106dd0 <deallocuvm.part.0+0x30>
80106df2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106df7:	74 47                	je     80106e40 <deallocuvm.part.0+0xa0>
80106df9:	83 ec 0c             	sub    $0xc,%esp
80106dfc:	05 00 00 00 80       	add    $0x80000000,%eax
80106e01:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e07:	50                   	push   %eax
80106e08:	e8 53 bb ff ff       	call   80102960 <kfree>
80106e0d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106e13:	83 c4 10             	add    $0x10,%esp
80106e16:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106e19:	77 c0                	ja     80106ddb <deallocuvm.part.0+0x3b>
80106e1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e21:	5b                   	pop    %ebx
80106e22:	5e                   	pop    %esi
80106e23:	5f                   	pop    %edi
80106e24:	5d                   	pop    %ebp
80106e25:	c3                   	ret    
80106e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
80106e30:	89 fa                	mov    %edi,%edx
80106e32:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80106e38:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
80106e3e:	eb 96                	jmp    80106dd6 <deallocuvm.part.0+0x36>
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	68 9e 78 10 80       	push   $0x8010789e
80106e48:	e8 43 95 ff ff       	call   80100390 <panic>
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi

80106e50 <seginit>:
80106e50:	f3 0f 1e fb          	endbr32 
80106e54:	55                   	push   %ebp
80106e55:	89 e5                	mov    %esp,%ebp
80106e57:	83 ec 18             	sub    $0x18,%esp
80106e5a:	e8 d1 cf ff ff       	call   80103e30 <cpuid>
80106e5f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106e64:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106e6a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106e6e:	c7 80 98 3d 11 80 ff 	movl   $0xffff,-0x7feec268(%eax)
80106e75:	ff 00 00 
80106e78:	c7 80 9c 3d 11 80 00 	movl   $0xcf9a00,-0x7feec264(%eax)
80106e7f:	9a cf 00 
80106e82:	c7 80 a0 3d 11 80 ff 	movl   $0xffff,-0x7feec260(%eax)
80106e89:	ff 00 00 
80106e8c:	c7 80 a4 3d 11 80 00 	movl   $0xcf9200,-0x7feec25c(%eax)
80106e93:	92 cf 00 
80106e96:	c7 80 a8 3d 11 80 ff 	movl   $0xffff,-0x7feec258(%eax)
80106e9d:	ff 00 00 
80106ea0:	c7 80 ac 3d 11 80 00 	movl   $0xcffa00,-0x7feec254(%eax)
80106ea7:	fa cf 00 
80106eaa:	c7 80 b0 3d 11 80 ff 	movl   $0xffff,-0x7feec250(%eax)
80106eb1:	ff 00 00 
80106eb4:	c7 80 b4 3d 11 80 00 	movl   $0xcff200,-0x7feec24c(%eax)
80106ebb:	f2 cf 00 
80106ebe:	05 90 3d 11 80       	add    $0x80113d90,%eax
80106ec3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106ec7:	c1 e8 10             	shr    $0x10,%eax
80106eca:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106ece:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ed1:	0f 01 10             	lgdtl  (%eax)
80106ed4:	c9                   	leave  
80106ed5:	c3                   	ret    
80106ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106edd:	8d 76 00             	lea    0x0(%esi),%esi

80106ee0 <switchkvm>:
80106ee0:	f3 0f 1e fb          	endbr32 
80106ee4:	a1 44 6a 11 80       	mov    0x80116a44,%eax
80106ee9:	05 00 00 00 80       	add    $0x80000000,%eax
80106eee:	0f 22 d8             	mov    %eax,%cr3
80106ef1:	c3                   	ret    
80106ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f00 <switchuvm>:
80106f00:	f3 0f 1e fb          	endbr32 
80106f04:	55                   	push   %ebp
80106f05:	89 e5                	mov    %esp,%ebp
80106f07:	57                   	push   %edi
80106f08:	56                   	push   %esi
80106f09:	53                   	push   %ebx
80106f0a:	83 ec 1c             	sub    $0x1c,%esp
80106f0d:	8b 75 08             	mov    0x8(%ebp),%esi
80106f10:	85 f6                	test   %esi,%esi
80106f12:	0f 84 cb 00 00 00    	je     80106fe3 <switchuvm+0xe3>
80106f18:	8b 46 08             	mov    0x8(%esi),%eax
80106f1b:	85 c0                	test   %eax,%eax
80106f1d:	0f 84 da 00 00 00    	je     80106ffd <switchuvm+0xfd>
80106f23:	8b 46 04             	mov    0x4(%esi),%eax
80106f26:	85 c0                	test   %eax,%eax
80106f28:	0f 84 c2 00 00 00    	je     80106ff0 <switchuvm+0xf0>
80106f2e:	e8 1d da ff ff       	call   80104950 <pushcli>
80106f33:	e8 88 ce ff ff       	call   80103dc0 <mycpu>
80106f38:	89 c3                	mov    %eax,%ebx
80106f3a:	e8 81 ce ff ff       	call   80103dc0 <mycpu>
80106f3f:	89 c7                	mov    %eax,%edi
80106f41:	e8 7a ce ff ff       	call   80103dc0 <mycpu>
80106f46:	83 c7 08             	add    $0x8,%edi
80106f49:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f4c:	e8 6f ce ff ff       	call   80103dc0 <mycpu>
80106f51:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f54:	ba 67 00 00 00       	mov    $0x67,%edx
80106f59:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106f60:	83 c0 08             	add    $0x8,%eax
80106f63:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106f6a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106f6f:	83 c1 08             	add    $0x8,%ecx
80106f72:	c1 e8 18             	shr    $0x18,%eax
80106f75:	c1 e9 10             	shr    $0x10,%ecx
80106f78:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106f7e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106f84:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106f89:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80106f90:	bb 10 00 00 00       	mov    $0x10,%ebx
80106f95:	e8 26 ce ff ff       	call   80103dc0 <mycpu>
80106f9a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106fa1:	e8 1a ce ff ff       	call   80103dc0 <mycpu>
80106fa6:	66 89 58 10          	mov    %bx,0x10(%eax)
80106faa:	8b 5e 08             	mov    0x8(%esi),%ebx
80106fad:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fb3:	e8 08 ce ff ff       	call   80103dc0 <mycpu>
80106fb8:	89 58 0c             	mov    %ebx,0xc(%eax)
80106fbb:	e8 00 ce ff ff       	call   80103dc0 <mycpu>
80106fc0:	66 89 78 6e          	mov    %di,0x6e(%eax)
80106fc4:	b8 28 00 00 00       	mov    $0x28,%eax
80106fc9:	0f 00 d8             	ltr    %ax
80106fcc:	8b 46 04             	mov    0x4(%esi),%eax
80106fcf:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd4:	0f 22 d8             	mov    %eax,%cr3
80106fd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fda:	5b                   	pop    %ebx
80106fdb:	5e                   	pop    %esi
80106fdc:	5f                   	pop    %edi
80106fdd:	5d                   	pop    %ebp
80106fde:	e9 bd d9 ff ff       	jmp    801049a0 <popcli>
80106fe3:	83 ec 0c             	sub    $0xc,%esp
80106fe6:	68 ee 7e 10 80       	push   $0x80107eee
80106feb:	e8 a0 93 ff ff       	call   80100390 <panic>
80106ff0:	83 ec 0c             	sub    $0xc,%esp
80106ff3:	68 19 7f 10 80       	push   $0x80107f19
80106ff8:	e8 93 93 ff ff       	call   80100390 <panic>
80106ffd:	83 ec 0c             	sub    $0xc,%esp
80107000:	68 04 7f 10 80       	push   $0x80107f04
80107005:	e8 86 93 ff ff       	call   80100390 <panic>
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107010 <inituvm>:
80107010:	f3 0f 1e fb          	endbr32 
80107014:	55                   	push   %ebp
80107015:	89 e5                	mov    %esp,%ebp
80107017:	57                   	push   %edi
80107018:	56                   	push   %esi
80107019:	53                   	push   %ebx
8010701a:	83 ec 1c             	sub    $0x1c,%esp
8010701d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107020:	8b 75 10             	mov    0x10(%ebp),%esi
80107023:	8b 7d 08             	mov    0x8(%ebp),%edi
80107026:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107029:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010702f:	77 4b                	ja     8010707c <inituvm+0x6c>
80107031:	e8 ea ba ff ff       	call   80102b20 <kalloc>
80107036:	83 ec 04             	sub    $0x4,%esp
80107039:	68 00 10 00 00       	push   $0x1000
8010703e:	89 c3                	mov    %eax,%ebx
80107040:	6a 00                	push   $0x0
80107042:	50                   	push   %eax
80107043:	e8 18 db ff ff       	call   80104b60 <memset>
80107048:	58                   	pop    %eax
80107049:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010704f:	5a                   	pop    %edx
80107050:	6a 06                	push   $0x6
80107052:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107057:	31 d2                	xor    %edx,%edx
80107059:	50                   	push   %eax
8010705a:	89 f8                	mov    %edi,%eax
8010705c:	e8 af fc ff ff       	call   80106d10 <mappages>
80107061:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107064:	89 75 10             	mov    %esi,0x10(%ebp)
80107067:	83 c4 10             	add    $0x10,%esp
8010706a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010706d:	89 45 0c             	mov    %eax,0xc(%ebp)
80107070:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107073:	5b                   	pop    %ebx
80107074:	5e                   	pop    %esi
80107075:	5f                   	pop    %edi
80107076:	5d                   	pop    %ebp
80107077:	e9 84 db ff ff       	jmp    80104c00 <memmove>
8010707c:	83 ec 0c             	sub    $0xc,%esp
8010707f:	68 2d 7f 10 80       	push   $0x80107f2d
80107084:	e8 07 93 ff ff       	call   80100390 <panic>
80107089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107090 <loaduvm>:
80107090:	f3 0f 1e fb          	endbr32 
80107094:	55                   	push   %ebp
80107095:	89 e5                	mov    %esp,%ebp
80107097:	57                   	push   %edi
80107098:	56                   	push   %esi
80107099:	53                   	push   %ebx
8010709a:	83 ec 1c             	sub    $0x1c,%esp
8010709d:	8b 45 0c             	mov    0xc(%ebp),%eax
801070a0:	8b 75 18             	mov    0x18(%ebp),%esi
801070a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801070a8:	0f 85 99 00 00 00    	jne    80107147 <loaduvm+0xb7>
801070ae:	01 f0                	add    %esi,%eax
801070b0:	89 f3                	mov    %esi,%ebx
801070b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070b5:	8b 45 14             	mov    0x14(%ebp),%eax
801070b8:	01 f0                	add    %esi,%eax
801070ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070bd:	85 f6                	test   %esi,%esi
801070bf:	75 15                	jne    801070d6 <loaduvm+0x46>
801070c1:	eb 6d                	jmp    80107130 <loaduvm+0xa0>
801070c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070c7:	90                   	nop
801070c8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801070ce:	89 f0                	mov    %esi,%eax
801070d0:	29 d8                	sub    %ebx,%eax
801070d2:	39 c6                	cmp    %eax,%esi
801070d4:	76 5a                	jbe    80107130 <loaduvm+0xa0>
801070d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070d9:	8b 45 08             	mov    0x8(%ebp),%eax
801070dc:	31 c9                	xor    %ecx,%ecx
801070de:	29 da                	sub    %ebx,%edx
801070e0:	e8 ab fb ff ff       	call   80106c90 <walkpgdir>
801070e5:	85 c0                	test   %eax,%eax
801070e7:	74 51                	je     8010713a <loaduvm+0xaa>
801070e9:	8b 00                	mov    (%eax),%eax
801070eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801070ee:	bf 00 10 00 00       	mov    $0x1000,%edi
801070f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070f8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801070fe:	0f 46 fb             	cmovbe %ebx,%edi
80107101:	29 d9                	sub    %ebx,%ecx
80107103:	05 00 00 00 80       	add    $0x80000000,%eax
80107108:	57                   	push   %edi
80107109:	51                   	push   %ecx
8010710a:	50                   	push   %eax
8010710b:	ff 75 10             	pushl  0x10(%ebp)
8010710e:	e8 3d ae ff ff       	call   80101f50 <readi>
80107113:	83 c4 10             	add    $0x10,%esp
80107116:	39 f8                	cmp    %edi,%eax
80107118:	74 ae                	je     801070c8 <loaduvm+0x38>
8010711a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010711d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107122:	5b                   	pop    %ebx
80107123:	5e                   	pop    %esi
80107124:	5f                   	pop    %edi
80107125:	5d                   	pop    %ebp
80107126:	c3                   	ret    
80107127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010712e:	66 90                	xchg   %ax,%ax
80107130:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107133:	31 c0                	xor    %eax,%eax
80107135:	5b                   	pop    %ebx
80107136:	5e                   	pop    %esi
80107137:	5f                   	pop    %edi
80107138:	5d                   	pop    %ebp
80107139:	c3                   	ret    
8010713a:	83 ec 0c             	sub    $0xc,%esp
8010713d:	68 47 7f 10 80       	push   $0x80107f47
80107142:	e8 49 92 ff ff       	call   80100390 <panic>
80107147:	83 ec 0c             	sub    $0xc,%esp
8010714a:	68 e8 7f 10 80       	push   $0x80107fe8
8010714f:	e8 3c 92 ff ff       	call   80100390 <panic>
80107154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010715b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010715f:	90                   	nop

80107160 <allocuvm>:
80107160:	f3 0f 1e fb          	endbr32 
80107164:	55                   	push   %ebp
80107165:	89 e5                	mov    %esp,%ebp
80107167:	57                   	push   %edi
80107168:	56                   	push   %esi
80107169:	53                   	push   %ebx
8010716a:	83 ec 1c             	sub    $0x1c,%esp
8010716d:	8b 45 10             	mov    0x10(%ebp),%eax
80107170:	8b 7d 08             	mov    0x8(%ebp),%edi
80107173:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107176:	85 c0                	test   %eax,%eax
80107178:	0f 88 b2 00 00 00    	js     80107230 <allocuvm+0xd0>
8010717e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107181:	8b 45 0c             	mov    0xc(%ebp),%eax
80107184:	0f 82 96 00 00 00    	jb     80107220 <allocuvm+0xc0>
8010718a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107190:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107196:	39 75 10             	cmp    %esi,0x10(%ebp)
80107199:	77 40                	ja     801071db <allocuvm+0x7b>
8010719b:	e9 83 00 00 00       	jmp    80107223 <allocuvm+0xc3>
801071a0:	83 ec 04             	sub    $0x4,%esp
801071a3:	68 00 10 00 00       	push   $0x1000
801071a8:	6a 00                	push   $0x0
801071aa:	50                   	push   %eax
801071ab:	e8 b0 d9 ff ff       	call   80104b60 <memset>
801071b0:	58                   	pop    %eax
801071b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071b7:	5a                   	pop    %edx
801071b8:	6a 06                	push   $0x6
801071ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071bf:	89 f2                	mov    %esi,%edx
801071c1:	50                   	push   %eax
801071c2:	89 f8                	mov    %edi,%eax
801071c4:	e8 47 fb ff ff       	call   80106d10 <mappages>
801071c9:	83 c4 10             	add    $0x10,%esp
801071cc:	85 c0                	test   %eax,%eax
801071ce:	78 78                	js     80107248 <allocuvm+0xe8>
801071d0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071d6:	39 75 10             	cmp    %esi,0x10(%ebp)
801071d9:	76 48                	jbe    80107223 <allocuvm+0xc3>
801071db:	e8 40 b9 ff ff       	call   80102b20 <kalloc>
801071e0:	89 c3                	mov    %eax,%ebx
801071e2:	85 c0                	test   %eax,%eax
801071e4:	75 ba                	jne    801071a0 <allocuvm+0x40>
801071e6:	83 ec 0c             	sub    $0xc,%esp
801071e9:	68 65 7f 10 80       	push   $0x80107f65
801071ee:	e8 cd 96 ff ff       	call   801008c0 <cprintf>
801071f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801071f6:	83 c4 10             	add    $0x10,%esp
801071f9:	39 45 10             	cmp    %eax,0x10(%ebp)
801071fc:	74 32                	je     80107230 <allocuvm+0xd0>
801071fe:	8b 55 10             	mov    0x10(%ebp),%edx
80107201:	89 c1                	mov    %eax,%ecx
80107203:	89 f8                	mov    %edi,%eax
80107205:	e8 96 fb ff ff       	call   80106da0 <deallocuvm.part.0>
8010720a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107214:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107217:	5b                   	pop    %ebx
80107218:	5e                   	pop    %esi
80107219:	5f                   	pop    %edi
8010721a:	5d                   	pop    %ebp
8010721b:	c3                   	ret    
8010721c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107220:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107223:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107226:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107229:	5b                   	pop    %ebx
8010722a:	5e                   	pop    %esi
8010722b:	5f                   	pop    %edi
8010722c:	5d                   	pop    %ebp
8010722d:	c3                   	ret    
8010722e:	66 90                	xchg   %ax,%ax
80107230:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107237:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010723a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010723d:	5b                   	pop    %ebx
8010723e:	5e                   	pop    %esi
8010723f:	5f                   	pop    %edi
80107240:	5d                   	pop    %ebp
80107241:	c3                   	ret    
80107242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107248:	83 ec 0c             	sub    $0xc,%esp
8010724b:	68 7d 7f 10 80       	push   $0x80107f7d
80107250:	e8 6b 96 ff ff       	call   801008c0 <cprintf>
80107255:	8b 45 0c             	mov    0xc(%ebp),%eax
80107258:	83 c4 10             	add    $0x10,%esp
8010725b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010725e:	74 0c                	je     8010726c <allocuvm+0x10c>
80107260:	8b 55 10             	mov    0x10(%ebp),%edx
80107263:	89 c1                	mov    %eax,%ecx
80107265:	89 f8                	mov    %edi,%eax
80107267:	e8 34 fb ff ff       	call   80106da0 <deallocuvm.part.0>
8010726c:	83 ec 0c             	sub    $0xc,%esp
8010726f:	53                   	push   %ebx
80107270:	e8 eb b6 ff ff       	call   80102960 <kfree>
80107275:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010727c:	83 c4 10             	add    $0x10,%esp
8010727f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107282:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107285:	5b                   	pop    %ebx
80107286:	5e                   	pop    %esi
80107287:	5f                   	pop    %edi
80107288:	5d                   	pop    %ebp
80107289:	c3                   	ret    
8010728a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107290 <deallocuvm>:
80107290:	f3 0f 1e fb          	endbr32 
80107294:	55                   	push   %ebp
80107295:	89 e5                	mov    %esp,%ebp
80107297:	8b 55 0c             	mov    0xc(%ebp),%edx
8010729a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010729d:	8b 45 08             	mov    0x8(%ebp),%eax
801072a0:	39 d1                	cmp    %edx,%ecx
801072a2:	73 0c                	jae    801072b0 <deallocuvm+0x20>
801072a4:	5d                   	pop    %ebp
801072a5:	e9 f6 fa ff ff       	jmp    80106da0 <deallocuvm.part.0>
801072aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072b0:	89 d0                	mov    %edx,%eax
801072b2:	5d                   	pop    %ebp
801072b3:	c3                   	ret    
801072b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801072bf:	90                   	nop

801072c0 <freevm>:
801072c0:	f3 0f 1e fb          	endbr32 
801072c4:	55                   	push   %ebp
801072c5:	89 e5                	mov    %esp,%ebp
801072c7:	57                   	push   %edi
801072c8:	56                   	push   %esi
801072c9:	53                   	push   %ebx
801072ca:	83 ec 0c             	sub    $0xc,%esp
801072cd:	8b 75 08             	mov    0x8(%ebp),%esi
801072d0:	85 f6                	test   %esi,%esi
801072d2:	74 55                	je     80107329 <freevm+0x69>
801072d4:	31 c9                	xor    %ecx,%ecx
801072d6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801072db:	89 f0                	mov    %esi,%eax
801072dd:	89 f3                	mov    %esi,%ebx
801072df:	e8 bc fa ff ff       	call   80106da0 <deallocuvm.part.0>
801072e4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801072ea:	eb 0b                	jmp    801072f7 <freevm+0x37>
801072ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801072f0:	83 c3 04             	add    $0x4,%ebx
801072f3:	39 df                	cmp    %ebx,%edi
801072f5:	74 23                	je     8010731a <freevm+0x5a>
801072f7:	8b 03                	mov    (%ebx),%eax
801072f9:	a8 01                	test   $0x1,%al
801072fb:	74 f3                	je     801072f0 <freevm+0x30>
801072fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107302:	83 ec 0c             	sub    $0xc,%esp
80107305:	83 c3 04             	add    $0x4,%ebx
80107308:	05 00 00 00 80       	add    $0x80000000,%eax
8010730d:	50                   	push   %eax
8010730e:	e8 4d b6 ff ff       	call   80102960 <kfree>
80107313:	83 c4 10             	add    $0x10,%esp
80107316:	39 df                	cmp    %ebx,%edi
80107318:	75 dd                	jne    801072f7 <freevm+0x37>
8010731a:	89 75 08             	mov    %esi,0x8(%ebp)
8010731d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107320:	5b                   	pop    %ebx
80107321:	5e                   	pop    %esi
80107322:	5f                   	pop    %edi
80107323:	5d                   	pop    %ebp
80107324:	e9 37 b6 ff ff       	jmp    80102960 <kfree>
80107329:	83 ec 0c             	sub    $0xc,%esp
8010732c:	68 99 7f 10 80       	push   $0x80107f99
80107331:	e8 5a 90 ff ff       	call   80100390 <panic>
80107336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010733d:	8d 76 00             	lea    0x0(%esi),%esi

80107340 <setupkvm>:
80107340:	f3 0f 1e fb          	endbr32 
80107344:	55                   	push   %ebp
80107345:	89 e5                	mov    %esp,%ebp
80107347:	56                   	push   %esi
80107348:	53                   	push   %ebx
80107349:	e8 d2 b7 ff ff       	call   80102b20 <kalloc>
8010734e:	89 c6                	mov    %eax,%esi
80107350:	85 c0                	test   %eax,%eax
80107352:	74 42                	je     80107396 <setupkvm+0x56>
80107354:	83 ec 04             	sub    $0x4,%esp
80107357:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
8010735c:	68 00 10 00 00       	push   $0x1000
80107361:	6a 00                	push   $0x0
80107363:	50                   	push   %eax
80107364:	e8 f7 d7 ff ff       	call   80104b60 <memset>
80107369:	83 c4 10             	add    $0x10,%esp
8010736c:	8b 43 04             	mov    0x4(%ebx),%eax
8010736f:	83 ec 08             	sub    $0x8,%esp
80107372:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107375:	ff 73 0c             	pushl  0xc(%ebx)
80107378:	8b 13                	mov    (%ebx),%edx
8010737a:	50                   	push   %eax
8010737b:	29 c1                	sub    %eax,%ecx
8010737d:	89 f0                	mov    %esi,%eax
8010737f:	e8 8c f9 ff ff       	call   80106d10 <mappages>
80107384:	83 c4 10             	add    $0x10,%esp
80107387:	85 c0                	test   %eax,%eax
80107389:	78 15                	js     801073a0 <setupkvm+0x60>
8010738b:	83 c3 10             	add    $0x10,%ebx
8010738e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107394:	75 d6                	jne    8010736c <setupkvm+0x2c>
80107396:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107399:	89 f0                	mov    %esi,%eax
8010739b:	5b                   	pop    %ebx
8010739c:	5e                   	pop    %esi
8010739d:	5d                   	pop    %ebp
8010739e:	c3                   	ret    
8010739f:	90                   	nop
801073a0:	83 ec 0c             	sub    $0xc,%esp
801073a3:	56                   	push   %esi
801073a4:	31 f6                	xor    %esi,%esi
801073a6:	e8 15 ff ff ff       	call   801072c0 <freevm>
801073ab:	83 c4 10             	add    $0x10,%esp
801073ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801073b1:	89 f0                	mov    %esi,%eax
801073b3:	5b                   	pop    %ebx
801073b4:	5e                   	pop    %esi
801073b5:	5d                   	pop    %ebp
801073b6:	c3                   	ret    
801073b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073be:	66 90                	xchg   %ax,%ax

801073c0 <kvmalloc>:
801073c0:	f3 0f 1e fb          	endbr32 
801073c4:	55                   	push   %ebp
801073c5:	89 e5                	mov    %esp,%ebp
801073c7:	83 ec 08             	sub    $0x8,%esp
801073ca:	e8 71 ff ff ff       	call   80107340 <setupkvm>
801073cf:	a3 44 6a 11 80       	mov    %eax,0x80116a44
801073d4:	05 00 00 00 80       	add    $0x80000000,%eax
801073d9:	0f 22 d8             	mov    %eax,%cr3
801073dc:	c9                   	leave  
801073dd:	c3                   	ret    
801073de:	66 90                	xchg   %ax,%ax

801073e0 <clearpteu>:
801073e0:	f3 0f 1e fb          	endbr32 
801073e4:	55                   	push   %ebp
801073e5:	31 c9                	xor    %ecx,%ecx
801073e7:	89 e5                	mov    %esp,%ebp
801073e9:	83 ec 08             	sub    $0x8,%esp
801073ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801073ef:	8b 45 08             	mov    0x8(%ebp),%eax
801073f2:	e8 99 f8 ff ff       	call   80106c90 <walkpgdir>
801073f7:	85 c0                	test   %eax,%eax
801073f9:	74 05                	je     80107400 <clearpteu+0x20>
801073fb:	83 20 fb             	andl   $0xfffffffb,(%eax)
801073fe:	c9                   	leave  
801073ff:	c3                   	ret    
80107400:	83 ec 0c             	sub    $0xc,%esp
80107403:	68 aa 7f 10 80       	push   $0x80107faa
80107408:	e8 83 8f ff ff       	call   80100390 <panic>
8010740d:	8d 76 00             	lea    0x0(%esi),%esi

80107410 <copyuvm>:
80107410:	f3 0f 1e fb          	endbr32 
80107414:	55                   	push   %ebp
80107415:	89 e5                	mov    %esp,%ebp
80107417:	57                   	push   %edi
80107418:	56                   	push   %esi
80107419:	53                   	push   %ebx
8010741a:	83 ec 1c             	sub    $0x1c,%esp
8010741d:	e8 1e ff ff ff       	call   80107340 <setupkvm>
80107422:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107425:	85 c0                	test   %eax,%eax
80107427:	0f 84 9b 00 00 00    	je     801074c8 <copyuvm+0xb8>
8010742d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107430:	85 c9                	test   %ecx,%ecx
80107432:	0f 84 90 00 00 00    	je     801074c8 <copyuvm+0xb8>
80107438:	31 f6                	xor    %esi,%esi
8010743a:	eb 46                	jmp    80107482 <copyuvm+0x72>
8010743c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107440:	83 ec 04             	sub    $0x4,%esp
80107443:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107449:	68 00 10 00 00       	push   $0x1000
8010744e:	57                   	push   %edi
8010744f:	50                   	push   %eax
80107450:	e8 ab d7 ff ff       	call   80104c00 <memmove>
80107455:	58                   	pop    %eax
80107456:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010745c:	5a                   	pop    %edx
8010745d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107460:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107465:	89 f2                	mov    %esi,%edx
80107467:	50                   	push   %eax
80107468:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010746b:	e8 a0 f8 ff ff       	call   80106d10 <mappages>
80107470:	83 c4 10             	add    $0x10,%esp
80107473:	85 c0                	test   %eax,%eax
80107475:	78 61                	js     801074d8 <copyuvm+0xc8>
80107477:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010747d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107480:	76 46                	jbe    801074c8 <copyuvm+0xb8>
80107482:	8b 45 08             	mov    0x8(%ebp),%eax
80107485:	31 c9                	xor    %ecx,%ecx
80107487:	89 f2                	mov    %esi,%edx
80107489:	e8 02 f8 ff ff       	call   80106c90 <walkpgdir>
8010748e:	85 c0                	test   %eax,%eax
80107490:	74 61                	je     801074f3 <copyuvm+0xe3>
80107492:	8b 00                	mov    (%eax),%eax
80107494:	a8 01                	test   $0x1,%al
80107496:	74 4e                	je     801074e6 <copyuvm+0xd6>
80107498:	89 c7                	mov    %eax,%edi
8010749a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010749f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074a2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801074a8:	e8 73 b6 ff ff       	call   80102b20 <kalloc>
801074ad:	89 c3                	mov    %eax,%ebx
801074af:	85 c0                	test   %eax,%eax
801074b1:	75 8d                	jne    80107440 <copyuvm+0x30>
801074b3:	83 ec 0c             	sub    $0xc,%esp
801074b6:	ff 75 e0             	pushl  -0x20(%ebp)
801074b9:	e8 02 fe ff ff       	call   801072c0 <freevm>
801074be:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801074c5:	83 c4 10             	add    $0x10,%esp
801074c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074ce:	5b                   	pop    %ebx
801074cf:	5e                   	pop    %esi
801074d0:	5f                   	pop    %edi
801074d1:	5d                   	pop    %ebp
801074d2:	c3                   	ret    
801074d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074d7:	90                   	nop
801074d8:	83 ec 0c             	sub    $0xc,%esp
801074db:	53                   	push   %ebx
801074dc:	e8 7f b4 ff ff       	call   80102960 <kfree>
801074e1:	83 c4 10             	add    $0x10,%esp
801074e4:	eb cd                	jmp    801074b3 <copyuvm+0xa3>
801074e6:	83 ec 0c             	sub    $0xc,%esp
801074e9:	68 ce 7f 10 80       	push   $0x80107fce
801074ee:	e8 9d 8e ff ff       	call   80100390 <panic>
801074f3:	83 ec 0c             	sub    $0xc,%esp
801074f6:	68 b4 7f 10 80       	push   $0x80107fb4
801074fb:	e8 90 8e ff ff       	call   80100390 <panic>

80107500 <uva2ka>:
80107500:	f3 0f 1e fb          	endbr32 
80107504:	55                   	push   %ebp
80107505:	31 c9                	xor    %ecx,%ecx
80107507:	89 e5                	mov    %esp,%ebp
80107509:	83 ec 08             	sub    $0x8,%esp
8010750c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010750f:	8b 45 08             	mov    0x8(%ebp),%eax
80107512:	e8 79 f7 ff ff       	call   80106c90 <walkpgdir>
80107517:	8b 00                	mov    (%eax),%eax
80107519:	c9                   	leave  
8010751a:	89 c2                	mov    %eax,%edx
8010751c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107521:	83 e2 05             	and    $0x5,%edx
80107524:	05 00 00 00 80       	add    $0x80000000,%eax
80107529:	83 fa 05             	cmp    $0x5,%edx
8010752c:	ba 00 00 00 00       	mov    $0x0,%edx
80107531:	0f 45 c2             	cmovne %edx,%eax
80107534:	c3                   	ret    
80107535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010753c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107540 <copyout>:
80107540:	f3 0f 1e fb          	endbr32 
80107544:	55                   	push   %ebp
80107545:	89 e5                	mov    %esp,%ebp
80107547:	57                   	push   %edi
80107548:	56                   	push   %esi
80107549:	53                   	push   %ebx
8010754a:	83 ec 0c             	sub    $0xc,%esp
8010754d:	8b 75 14             	mov    0x14(%ebp),%esi
80107550:	8b 55 0c             	mov    0xc(%ebp),%edx
80107553:	85 f6                	test   %esi,%esi
80107555:	75 3c                	jne    80107593 <copyout+0x53>
80107557:	eb 67                	jmp    801075c0 <copyout+0x80>
80107559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107560:	8b 55 0c             	mov    0xc(%ebp),%edx
80107563:	89 fb                	mov    %edi,%ebx
80107565:	29 d3                	sub    %edx,%ebx
80107567:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010756d:	39 f3                	cmp    %esi,%ebx
8010756f:	0f 47 de             	cmova  %esi,%ebx
80107572:	29 fa                	sub    %edi,%edx
80107574:	83 ec 04             	sub    $0x4,%esp
80107577:	01 c2                	add    %eax,%edx
80107579:	53                   	push   %ebx
8010757a:	ff 75 10             	pushl  0x10(%ebp)
8010757d:	52                   	push   %edx
8010757e:	e8 7d d6 ff ff       	call   80104c00 <memmove>
80107583:	01 5d 10             	add    %ebx,0x10(%ebp)
80107586:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
8010758c:	83 c4 10             	add    $0x10,%esp
8010758f:	29 de                	sub    %ebx,%esi
80107591:	74 2d                	je     801075c0 <copyout+0x80>
80107593:	89 d7                	mov    %edx,%edi
80107595:	83 ec 08             	sub    $0x8,%esp
80107598:	89 55 0c             	mov    %edx,0xc(%ebp)
8010759b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801075a1:	57                   	push   %edi
801075a2:	ff 75 08             	pushl  0x8(%ebp)
801075a5:	e8 56 ff ff ff       	call   80107500 <uva2ka>
801075aa:	83 c4 10             	add    $0x10,%esp
801075ad:	85 c0                	test   %eax,%eax
801075af:	75 af                	jne    80107560 <copyout+0x20>
801075b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801075b9:	5b                   	pop    %ebx
801075ba:	5e                   	pop    %esi
801075bb:	5f                   	pop    %edi
801075bc:	5d                   	pop    %ebp
801075bd:	c3                   	ret    
801075be:	66 90                	xchg   %ax,%ax
801075c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075c3:	31 c0                	xor    %eax,%eax
801075c5:	5b                   	pop    %ebx
801075c6:	5e                   	pop    %esi
801075c7:	5f                   	pop    %edi
801075c8:	5d                   	pop    %ebp
801075c9:	c3                   	ret    
