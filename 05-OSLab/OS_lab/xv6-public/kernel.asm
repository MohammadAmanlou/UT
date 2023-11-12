
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 35 10 80       	mov    $0x80103530,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 00 79 10 80       	push   $0x80107900
80100055:	68 c0 c5 10 80       	push   $0x8010c5c0
8010005a:	e8 f1 49 00 00       	call   80104a50 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 bc 0c 11 80       	mov    $0x80110cbc,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
8010006e:	0c 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
80100078:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 79 10 80       	push   $0x80107907
80100097:	50                   	push   %eax
80100098:	e8 73 48 00 00       	call   80104910 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 60 0a 11 80    	cmp    $0x80110a60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e8:	e8 e3 4a 00 00       	call   80104bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 29 4b 00 00       	call   80104c90 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 47 00 00       	call   80104950 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 df 25 00 00       	call   80102770 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 0e 79 10 80       	push   $0x8010790e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 29 48 00 00       	call   801049f0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 93 25 00 00       	jmp    80102770 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 1f 79 10 80       	push   $0x8010791f
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 e8 47 00 00       	call   801049f0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 98 47 00 00       	call   801049b0 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010021f:	e8 ac 49 00 00       	call   80104bd0 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 10 0d 11 80       	mov    0x80110d10,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 1b 4a 00 00       	jmp    80104c90 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 26 79 10 80       	push   $0x80107926
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
801002b1:	e8 1a 49 00 00       	call   80104bd0 <acquire>
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
801002e5:	e8 36 41 00 00       	call   80104420 <sleep>
    while(input.r == input.w){
801002ea:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 61 3b 00 00       	call   80103e60 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 b5 10 80       	push   $0x8010b520
8010030e:	e8 7d 49 00 00       	call   80104c90 <release>
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
80100365:	e8 26 49 00 00       	call   80104c90 <release>
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
801003b6:	68 2d 79 10 80       	push   $0x8010792d
801003bb:	e8 00 05 00 00       	call   801008c0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 f7 04 00 00       	call   801008c0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 0f 83 10 80 	movl   $0x8010830f,(%esp)
801003d0:	e8 eb 04 00 00       	call   801008c0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 8f 46 00 00       	call   80104a70 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 41 79 10 80       	push   $0x80107941
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
8010042a:	e8 d1 60 00 00       	call   80106500 <uartputc>
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
8010058d:	e8 6e 5f 00 00       	call   80106500 <uartputc>
80100592:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100599:	e8 62 5f 00 00       	call   80106500 <uartputc>
8010059e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005a5:	e8 56 5f 00 00       	call   80106500 <uartputc>
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
801005cf:	e8 ac 47 00 00       	call   80104d80 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005d4:	b8 80 07 00 00       	mov    $0x780,%eax
801005d9:	83 c4 0c             	add    $0xc,%esp
801005dc:	29 d8                	sub    %ebx,%eax
801005de:	01 c0                	add    %eax,%eax
801005e0:	50                   	push   %eax
801005e1:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801005e8:	6a 00                	push   $0x0
801005ea:	50                   	push   %eax
801005eb:	e8 f0 46 00 00       	call   80104ce0 <memset>
801005f0:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
801005f6:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
801005fa:	83 c4 10             	add    $0x10,%esp
801005fd:	01 df                	add    %ebx,%edi
801005ff:	e9 d7 fe ff ff       	jmp    801004db <consputc.part.0+0xcb>
    panic("pos under/overflow");
80100604:	83 ec 0c             	sub    $0xc,%esp
80100607:	68 45 79 10 80       	push   $0x80107945
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
80100649:	0f b6 92 c8 79 10 80 	movzbl -0x7fef8638(%edx),%edx
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
8010086f:	e8 5c 43 00 00       	call   80104bd0 <acquire>
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
801008a7:	e8 e4 43 00 00       	call   80104c90 <release>
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
8010098d:	bb 58 79 10 80       	mov    $0x80107958,%ebx
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
801009cd:	e8 fe 41 00 00       	call   80104bd0 <acquire>
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
80100a38:	e8 53 42 00 00       	call   80104c90 <release>
80100a3d:	83 c4 10             	add    $0x10,%esp
}
80100a40:	e9 ee fe ff ff       	jmp    80100933 <cprintf+0x73>
    panic("null fmt");
80100a45:	83 ec 0c             	sub    $0xc,%esp
80100a48:	68 5f 79 10 80       	push   $0x8010795f
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
80100a8a:	e8 41 41 00 00       	call   80104bd0 <acquire>
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
80100ab8:	3e ff 24 b5 70 79 10 	notrack jmp *-0x7fef8690(,%esi,4)
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
80100d65:	e8 26 3f 00 00       	call   80104c90 <release>
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
80100e13:	e8 c8 37 00 00       	call   801045e0 <wakeup>
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
80100ebc:	e9 ef 38 00 00       	jmp    801047b0 <procdump>
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
80100f2a:	68 68 79 10 80       	push   $0x80107968
80100f2f:	68 20 b5 10 80       	push   $0x8010b520
80100f34:	e8 17 3b 00 00       	call   80104a50 <initlock>

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
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100f70:	f3 0f 1e fb          	endbr32 
80100f74:	55                   	push   %ebp
80100f75:	89 e5                	mov    %esp,%ebp
80100f77:	57                   	push   %edi
80100f78:	56                   	push   %esi
80100f79:	53                   	push   %ebx
80100f7a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100f80:	e8 db 2e 00 00       	call   80103e60 <myproc>
80100f85:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100f8b:	e8 90 22 00 00       	call   80103220 <begin_op>

  if((ip = namei(path)) == 0){
80100f90:	83 ec 0c             	sub    $0xc,%esp
80100f93:	ff 75 08             	pushl  0x8(%ebp)
80100f96:	e8 85 15 00 00       	call   80102520 <namei>
80100f9b:	83 c4 10             	add    $0x10,%esp
80100f9e:	85 c0                	test   %eax,%eax
80100fa0:	0f 84 fe 02 00 00    	je     801012a4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	89 c3                	mov    %eax,%ebx
80100fab:	50                   	push   %eax
80100fac:	e8 9f 0c 00 00       	call   80101c50 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100fb1:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100fb7:	6a 34                	push   $0x34
80100fb9:	6a 00                	push   $0x0
80100fbb:	50                   	push   %eax
80100fbc:	53                   	push   %ebx
80100fbd:	e8 8e 0f 00 00       	call   80101f50 <readi>
80100fc2:	83 c4 20             	add    $0x20,%esp
80100fc5:	83 f8 34             	cmp    $0x34,%eax
80100fc8:	74 26                	je     80100ff0 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100fca:	83 ec 0c             	sub    $0xc,%esp
80100fcd:	53                   	push   %ebx
80100fce:	e8 1d 0f 00 00       	call   80101ef0 <iunlockput>
    end_op();
80100fd3:	e8 b8 22 00 00       	call   80103290 <end_op>
80100fd8:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100fdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe3:	5b                   	pop    %ebx
80100fe4:	5e                   	pop    %esi
80100fe5:	5f                   	pop    %edi
80100fe6:	5d                   	pop    %ebp
80100fe7:	c3                   	ret    
80100fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fef:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100ff0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ff7:	45 4c 46 
80100ffa:	75 ce                	jne    80100fca <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
80100ffc:	e8 6f 66 00 00       	call   80107670 <setupkvm>
80101001:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101007:	85 c0                	test   %eax,%eax
80101009:	74 bf                	je     80100fca <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010100b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101012:	00 
80101013:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101019:	0f 84 a4 02 00 00    	je     801012c3 <exec+0x353>
  sz = 0;
8010101f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101026:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101029:	31 ff                	xor    %edi,%edi
8010102b:	e9 86 00 00 00       	jmp    801010b6 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80101030:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101037:	75 6c                	jne    801010a5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101039:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010103f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101045:	0f 82 87 00 00 00    	jb     801010d2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010104b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101051:	72 7f                	jb     801010d2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101053:	83 ec 04             	sub    $0x4,%esp
80101056:	50                   	push   %eax
80101057:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010105d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101063:	e8 28 64 00 00       	call   80107490 <allocuvm>
80101068:	83 c4 10             	add    $0x10,%esp
8010106b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101071:	85 c0                	test   %eax,%eax
80101073:	74 5d                	je     801010d2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101075:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010107b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101080:	75 50                	jne    801010d2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101082:	83 ec 0c             	sub    $0xc,%esp
80101085:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
8010108b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101091:	53                   	push   %ebx
80101092:	50                   	push   %eax
80101093:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101099:	e8 22 63 00 00       	call   801073c0 <loaduvm>
8010109e:	83 c4 20             	add    $0x20,%esp
801010a1:	85 c0                	test   %eax,%eax
801010a3:	78 2d                	js     801010d2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010a5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801010ac:	83 c7 01             	add    $0x1,%edi
801010af:	83 c6 20             	add    $0x20,%esi
801010b2:	39 f8                	cmp    %edi,%eax
801010b4:	7e 3a                	jle    801010f0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801010b6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801010bc:	6a 20                	push   $0x20
801010be:	56                   	push   %esi
801010bf:	50                   	push   %eax
801010c0:	53                   	push   %ebx
801010c1:	e8 8a 0e 00 00       	call   80101f50 <readi>
801010c6:	83 c4 10             	add    $0x10,%esp
801010c9:	83 f8 20             	cmp    $0x20,%eax
801010cc:	0f 84 5e ff ff ff    	je     80101030 <exec+0xc0>
    freevm(pgdir);
801010d2:	83 ec 0c             	sub    $0xc,%esp
801010d5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010db:	e8 10 65 00 00       	call   801075f0 <freevm>
  if(ip){
801010e0:	83 c4 10             	add    $0x10,%esp
801010e3:	e9 e2 fe ff ff       	jmp    80100fca <exec+0x5a>
801010e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ef:	90                   	nop
801010f0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801010f6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801010fc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80101102:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101108:	83 ec 0c             	sub    $0xc,%esp
8010110b:	53                   	push   %ebx
8010110c:	e8 df 0d 00 00       	call   80101ef0 <iunlockput>
  end_op();
80101111:	e8 7a 21 00 00       	call   80103290 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101116:	83 c4 0c             	add    $0xc,%esp
80101119:	56                   	push   %esi
8010111a:	57                   	push   %edi
8010111b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101121:	57                   	push   %edi
80101122:	e8 69 63 00 00       	call   80107490 <allocuvm>
80101127:	83 c4 10             	add    $0x10,%esp
8010112a:	89 c6                	mov    %eax,%esi
8010112c:	85 c0                	test   %eax,%eax
8010112e:	0f 84 94 00 00 00    	je     801011c8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010113d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010113f:	50                   	push   %eax
80101140:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101141:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101143:	e8 c8 65 00 00       	call   80107710 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
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
    ustack[3+argc] = sp;
80101173:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010117a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010117d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101183:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101186:	85 c0                	test   %eax,%eax
80101188:	74 59                	je     801011e3 <exec+0x273>
    if(argc >= MAXARG)
8010118a:	83 ff 20             	cmp    $0x20,%edi
8010118d:	74 39                	je     801011c8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	50                   	push   %eax
80101193:	e8 48 3d 00 00       	call   80104ee0 <strlen>
80101198:	f7 d0                	not    %eax
8010119a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010119c:	58                   	pop    %eax
8010119d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801011a0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011a3:	ff 34 b8             	pushl  (%eax,%edi,4)
801011a6:	e8 35 3d 00 00       	call   80104ee0 <strlen>
801011ab:	83 c0 01             	add    $0x1,%eax
801011ae:	50                   	push   %eax
801011af:	8b 45 0c             	mov    0xc(%ebp),%eax
801011b2:	ff 34 b8             	pushl  (%eax,%edi,4)
801011b5:	53                   	push   %ebx
801011b6:	56                   	push   %esi
801011b7:	e8 b4 66 00 00       	call   80107870 <copyout>
801011bc:	83 c4 20             	add    $0x20,%esp
801011bf:	85 c0                	test   %eax,%eax
801011c1:	79 ad                	jns    80101170 <exec+0x200>
801011c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011c7:	90                   	nop
    freevm(pgdir);
801011c8:	83 ec 0c             	sub    $0xc,%esp
801011cb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011d1:	e8 1a 64 00 00       	call   801075f0 <freevm>
801011d6:	83 c4 10             	add    $0x10,%esp
  return -1;
801011d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011de:	e9 fd fd ff ff       	jmp    80100fe0 <exec+0x70>
801011e3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011e9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801011f0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801011f2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801011f9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011fd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801011ff:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101202:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101208:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010120a:	50                   	push   %eax
8010120b:	52                   	push   %edx
8010120c:	53                   	push   %ebx
8010120d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101213:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010121a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010121d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101223:	e8 48 66 00 00       	call   80107870 <copyout>
80101228:	83 c4 10             	add    $0x10,%esp
8010122b:	85 c0                	test   %eax,%eax
8010122d:	78 99                	js     801011c8 <exec+0x258>
  for(last=s=path; *s; s++)
8010122f:	8b 45 08             	mov    0x8(%ebp),%eax
80101232:	8b 55 08             	mov    0x8(%ebp),%edx
80101235:	0f b6 00             	movzbl (%eax),%eax
80101238:	84 c0                	test   %al,%al
8010123a:	74 13                	je     8010124f <exec+0x2df>
8010123c:	89 d1                	mov    %edx,%ecx
8010123e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80101240:	83 c1 01             	add    $0x1,%ecx
80101243:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101245:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80101248:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010124b:	84 c0                	test   %al,%al
8010124d:	75 f1                	jne    80101240 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010124f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101255:	83 ec 04             	sub    $0x4,%esp
80101258:	6a 10                	push   $0x10
8010125a:	89 f8                	mov    %edi,%eax
8010125c:	52                   	push   %edx
8010125d:	83 c0 6c             	add    $0x6c,%eax
80101260:	50                   	push   %eax
80101261:	e8 3a 3c 00 00       	call   80104ea0 <safestrcpy>
  curproc->pgdir = pgdir;
80101266:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010126c:	89 f8                	mov    %edi,%eax
8010126e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101271:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101273:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101276:	89 c1                	mov    %eax,%ecx
80101278:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010127e:	8b 40 18             	mov    0x18(%eax),%eax
80101281:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101284:	8b 41 18             	mov    0x18(%ecx),%eax
80101287:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010128a:	89 0c 24             	mov    %ecx,(%esp)
8010128d:	e8 9e 5f 00 00       	call   80107230 <switchuvm>
  freevm(oldpgdir);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 56 63 00 00       	call   801075f0 <freevm>
  return 0;
8010129a:	83 c4 10             	add    $0x10,%esp
8010129d:	31 c0                	xor    %eax,%eax
8010129f:	e9 3c fd ff ff       	jmp    80100fe0 <exec+0x70>
    end_op();
801012a4:	e8 e7 1f 00 00       	call   80103290 <end_op>
    cprintf("exec: fail\n");
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 d9 79 10 80       	push   $0x801079d9
801012b1:	e8 0a f6 ff ff       	call   801008c0 <cprintf>
    return -1;
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012be:	e9 1d fd ff ff       	jmp    80100fe0 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801012c3:	31 ff                	xor    %edi,%edi
801012c5:	be 00 20 00 00       	mov    $0x2000,%esi
801012ca:	e9 39 fe ff ff       	jmp    80101108 <exec+0x198>
801012cf:	90                   	nop

801012d0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801012d0:	f3 0f 1e fb          	endbr32 
801012d4:	55                   	push   %ebp
801012d5:	89 e5                	mov    %esp,%ebp
801012d7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801012da:	68 e5 79 10 80       	push   $0x801079e5
801012df:	68 60 15 11 80       	push   $0x80111560
801012e4:	e8 67 37 00 00       	call   80104a50 <initlock>
}
801012e9:	83 c4 10             	add    $0x10,%esp
801012ec:	c9                   	leave  
801012ed:	c3                   	ret    
801012ee:	66 90                	xchg   %ax,%ax

801012f0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801012f0:	f3 0f 1e fb          	endbr32 
801012f4:	55                   	push   %ebp
801012f5:	89 e5                	mov    %esp,%ebp
801012f7:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012f8:	bb 94 15 11 80       	mov    $0x80111594,%ebx
{
801012fd:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101300:	68 60 15 11 80       	push   $0x80111560
80101305:	e8 c6 38 00 00       	call   80104bd0 <acquire>
8010130a:	83 c4 10             	add    $0x10,%esp
8010130d:	eb 0c                	jmp    8010131b <filealloc+0x2b>
8010130f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101310:	83 c3 18             	add    $0x18,%ebx
80101313:	81 fb f4 1e 11 80    	cmp    $0x80111ef4,%ebx
80101319:	74 25                	je     80101340 <filealloc+0x50>
    if(f->ref == 0){
8010131b:	8b 43 04             	mov    0x4(%ebx),%eax
8010131e:	85 c0                	test   %eax,%eax
80101320:	75 ee                	jne    80101310 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101322:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101325:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010132c:	68 60 15 11 80       	push   $0x80111560
80101331:	e8 5a 39 00 00       	call   80104c90 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101336:	89 d8                	mov    %ebx,%eax
      return f;
80101338:	83 c4 10             	add    $0x10,%esp
}
8010133b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010133e:	c9                   	leave  
8010133f:	c3                   	ret    
  release(&ftable.lock);
80101340:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101343:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101345:	68 60 15 11 80       	push   $0x80111560
8010134a:	e8 41 39 00 00       	call   80104c90 <release>
}
8010134f:	89 d8                	mov    %ebx,%eax
  return 0;
80101351:	83 c4 10             	add    $0x10,%esp
}
80101354:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101357:	c9                   	leave  
80101358:	c3                   	ret    
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101360:	f3 0f 1e fb          	endbr32 
80101364:	55                   	push   %ebp
80101365:	89 e5                	mov    %esp,%ebp
80101367:	53                   	push   %ebx
80101368:	83 ec 10             	sub    $0x10,%esp
8010136b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010136e:	68 60 15 11 80       	push   $0x80111560
80101373:	e8 58 38 00 00       	call   80104bd0 <acquire>
  if(f->ref < 1)
80101378:	8b 43 04             	mov    0x4(%ebx),%eax
8010137b:	83 c4 10             	add    $0x10,%esp
8010137e:	85 c0                	test   %eax,%eax
80101380:	7e 1a                	jle    8010139c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80101382:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101385:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101388:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
8010138b:	68 60 15 11 80       	push   $0x80111560
80101390:	e8 fb 38 00 00       	call   80104c90 <release>
  return f;
}
80101395:	89 d8                	mov    %ebx,%eax
80101397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010139a:	c9                   	leave  
8010139b:	c3                   	ret    
    panic("filedup");
8010139c:	83 ec 0c             	sub    $0xc,%esp
8010139f:	68 ec 79 10 80       	push   $0x801079ec
801013a4:	e8 e7 ef ff ff       	call   80100390 <panic>
801013a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013b0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801013b0:	f3 0f 1e fb          	endbr32 
801013b4:	55                   	push   %ebp
801013b5:	89 e5                	mov    %esp,%ebp
801013b7:	57                   	push   %edi
801013b8:	56                   	push   %esi
801013b9:	53                   	push   %ebx
801013ba:	83 ec 28             	sub    $0x28,%esp
801013bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801013c0:	68 60 15 11 80       	push   $0x80111560
801013c5:	e8 06 38 00 00       	call   80104bd0 <acquire>
  if(f->ref < 1)
801013ca:	8b 53 04             	mov    0x4(%ebx),%edx
801013cd:	83 c4 10             	add    $0x10,%esp
801013d0:	85 d2                	test   %edx,%edx
801013d2:	0f 8e a1 00 00 00    	jle    80101479 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801013d8:	83 ea 01             	sub    $0x1,%edx
801013db:	89 53 04             	mov    %edx,0x4(%ebx)
801013de:	75 40                	jne    80101420 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801013e0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801013e4:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801013e7:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801013e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801013ef:	8b 73 0c             	mov    0xc(%ebx),%esi
801013f2:	88 45 e7             	mov    %al,-0x19(%ebp)
801013f5:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801013f8:	68 60 15 11 80       	push   $0x80111560
  ff = *f;
801013fd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101400:	e8 8b 38 00 00       	call   80104c90 <release>

  if(ff.type == FD_PIPE)
80101405:	83 c4 10             	add    $0x10,%esp
80101408:	83 ff 01             	cmp    $0x1,%edi
8010140b:	74 53                	je     80101460 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
8010140d:	83 ff 02             	cmp    $0x2,%edi
80101410:	74 26                	je     80101438 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101412:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101415:	5b                   	pop    %ebx
80101416:	5e                   	pop    %esi
80101417:	5f                   	pop    %edi
80101418:	5d                   	pop    %ebp
80101419:	c3                   	ret    
8010141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101420:	c7 45 08 60 15 11 80 	movl   $0x80111560,0x8(%ebp)
}
80101427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142a:	5b                   	pop    %ebx
8010142b:	5e                   	pop    %esi
8010142c:	5f                   	pop    %edi
8010142d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010142e:	e9 5d 38 00 00       	jmp    80104c90 <release>
80101433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101437:	90                   	nop
    begin_op();
80101438:	e8 e3 1d 00 00       	call   80103220 <begin_op>
    iput(ff.ip);
8010143d:	83 ec 0c             	sub    $0xc,%esp
80101440:	ff 75 e0             	pushl  -0x20(%ebp)
80101443:	e8 38 09 00 00       	call   80101d80 <iput>
    end_op();
80101448:	83 c4 10             	add    $0x10,%esp
}
8010144b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144e:	5b                   	pop    %ebx
8010144f:	5e                   	pop    %esi
80101450:	5f                   	pop    %edi
80101451:	5d                   	pop    %ebp
    end_op();
80101452:	e9 39 1e 00 00       	jmp    80103290 <end_op>
80101457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101460:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101464:	83 ec 08             	sub    $0x8,%esp
80101467:	53                   	push   %ebx
80101468:	56                   	push   %esi
80101469:	e8 82 25 00 00       	call   801039f0 <pipeclose>
8010146e:	83 c4 10             	add    $0x10,%esp
}
80101471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101474:	5b                   	pop    %ebx
80101475:	5e                   	pop    %esi
80101476:	5f                   	pop    %edi
80101477:	5d                   	pop    %ebp
80101478:	c3                   	ret    
    panic("fileclose");
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 f4 79 10 80       	push   $0x801079f4
80101481:	e8 0a ef ff ff       	call   80100390 <panic>
80101486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148d:	8d 76 00             	lea    0x0(%esi),%esi

80101490 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101490:	f3 0f 1e fb          	endbr32 
80101494:	55                   	push   %ebp
80101495:	89 e5                	mov    %esp,%ebp
80101497:	53                   	push   %ebx
80101498:	83 ec 04             	sub    $0x4,%esp
8010149b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010149e:	83 3b 02             	cmpl   $0x2,(%ebx)
801014a1:	75 2d                	jne    801014d0 <filestat+0x40>
    ilock(f->ip);
801014a3:	83 ec 0c             	sub    $0xc,%esp
801014a6:	ff 73 10             	pushl  0x10(%ebx)
801014a9:	e8 a2 07 00 00       	call   80101c50 <ilock>
    stati(f->ip, st);
801014ae:	58                   	pop    %eax
801014af:	5a                   	pop    %edx
801014b0:	ff 75 0c             	pushl  0xc(%ebp)
801014b3:	ff 73 10             	pushl  0x10(%ebx)
801014b6:	e8 65 0a 00 00       	call   80101f20 <stati>
    iunlock(f->ip);
801014bb:	59                   	pop    %ecx
801014bc:	ff 73 10             	pushl  0x10(%ebx)
801014bf:	e8 6c 08 00 00       	call   80101d30 <iunlock>
    return 0;
  }
  return -1;
}
801014c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801014c7:	83 c4 10             	add    $0x10,%esp
801014ca:	31 c0                	xor    %eax,%eax
}
801014cc:	c9                   	leave  
801014cd:	c3                   	ret    
801014ce:	66 90                	xchg   %ax,%ax
801014d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801014d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801014d8:	c9                   	leave  
801014d9:	c3                   	ret    
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014e0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->readable == 0)
801014f6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801014fa:	74 64                	je     80101560 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
801014fc:	8b 03                	mov    (%ebx),%eax
801014fe:	83 f8 01             	cmp    $0x1,%eax
80101501:	74 45                	je     80101548 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101503:	83 f8 02             	cmp    $0x2,%eax
80101506:	75 5f                	jne    80101567 <fileread+0x87>
    ilock(f->ip);
80101508:	83 ec 0c             	sub    $0xc,%esp
8010150b:	ff 73 10             	pushl  0x10(%ebx)
8010150e:	e8 3d 07 00 00       	call   80101c50 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101513:	57                   	push   %edi
80101514:	ff 73 14             	pushl  0x14(%ebx)
80101517:	56                   	push   %esi
80101518:	ff 73 10             	pushl  0x10(%ebx)
8010151b:	e8 30 0a 00 00       	call   80101f50 <readi>
80101520:	83 c4 20             	add    $0x20,%esp
80101523:	89 c6                	mov    %eax,%esi
80101525:	85 c0                	test   %eax,%eax
80101527:	7e 03                	jle    8010152c <fileread+0x4c>
      f->off += r;
80101529:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010152c:	83 ec 0c             	sub    $0xc,%esp
8010152f:	ff 73 10             	pushl  0x10(%ebx)
80101532:	e8 f9 07 00 00       	call   80101d30 <iunlock>
    return r;
80101537:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010153d:	89 f0                	mov    %esi,%eax
8010153f:	5b                   	pop    %ebx
80101540:	5e                   	pop    %esi
80101541:	5f                   	pop    %edi
80101542:	5d                   	pop    %ebp
80101543:	c3                   	ret    
80101544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101548:	8b 43 0c             	mov    0xc(%ebx),%eax
8010154b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010154e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101551:	5b                   	pop    %ebx
80101552:	5e                   	pop    %esi
80101553:	5f                   	pop    %edi
80101554:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101555:	e9 36 26 00 00       	jmp    80103b90 <piperead>
8010155a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101560:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101565:	eb d3                	jmp    8010153a <fileread+0x5a>
  panic("fileread");
80101567:	83 ec 0c             	sub    $0xc,%esp
8010156a:	68 fe 79 10 80       	push   $0x801079fe
8010156f:	e8 1c ee ff ff       	call   80100390 <panic>
80101574:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010157b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010157f:	90                   	nop

80101580 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->writable == 0)
80101599:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010159d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801015a0:	0f 84 c1 00 00 00    	je     80101667 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
801015a6:	8b 06                	mov    (%esi),%eax
801015a8:	83 f8 01             	cmp    $0x1,%eax
801015ab:	0f 84 c3 00 00 00    	je     80101674 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801015b1:	83 f8 02             	cmp    $0x2,%eax
801015b4:	0f 85 cc 00 00 00    	jne    80101686 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801015ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801015bd:	31 ff                	xor    %edi,%edi
    while(i < n){
801015bf:	85 c0                	test   %eax,%eax
801015c1:	7f 34                	jg     801015f7 <filewrite+0x77>
801015c3:	e9 98 00 00 00       	jmp    80101660 <filewrite+0xe0>
801015c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015cf:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801015d0:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801015d3:	83 ec 0c             	sub    $0xc,%esp
801015d6:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801015d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801015dc:	e8 4f 07 00 00       	call   80101d30 <iunlock>
      end_op();
801015e1:	e8 aa 1c 00 00       	call   80103290 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801015e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015e9:	83 c4 10             	add    $0x10,%esp
801015ec:	39 c3                	cmp    %eax,%ebx
801015ee:	75 60                	jne    80101650 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
801015f0:	01 df                	add    %ebx,%edi
    while(i < n){
801015f2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801015f5:	7e 69                	jle    80101660 <filewrite+0xe0>
      int n1 = n - i;
801015f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801015fa:	b8 00 06 00 00       	mov    $0x600,%eax
801015ff:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101601:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101607:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010160a:	e8 11 1c 00 00       	call   80103220 <begin_op>
      ilock(f->ip);
8010160f:	83 ec 0c             	sub    $0xc,%esp
80101612:	ff 76 10             	pushl  0x10(%esi)
80101615:	e8 36 06 00 00       	call   80101c50 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
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
      iunlock(f->ip);
80101633:	83 ec 0c             	sub    $0xc,%esp
80101636:	ff 76 10             	pushl  0x10(%esi)
80101639:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010163c:	e8 ef 06 00 00       	call   80101d30 <iunlock>
      end_op();
80101641:	e8 4a 1c 00 00       	call   80103290 <end_op>
      if(r < 0)
80101646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101649:	83 c4 10             	add    $0x10,%esp
8010164c:	85 c0                	test   %eax,%eax
8010164e:	75 17                	jne    80101667 <filewrite+0xe7>
        panic("short filewrite");
80101650:	83 ec 0c             	sub    $0xc,%esp
80101653:	68 07 7a 10 80       	push   $0x80107a07
80101658:	e8 33 ed ff ff       	call   80100390 <panic>
8010165d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101660:	89 f8                	mov    %edi,%eax
80101662:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101665:	74 05                	je     8010166c <filewrite+0xec>
80101667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010166c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5f                   	pop    %edi
80101672:	5d                   	pop    %ebp
80101673:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101674:	8b 46 0c             	mov    0xc(%esi),%eax
80101677:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010167a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010167d:	5b                   	pop    %ebx
8010167e:	5e                   	pop    %esi
8010167f:	5f                   	pop    %edi
80101680:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101681:	e9 0a 24 00 00       	jmp    80103a90 <pipewrite>
  panic("filewrite");
80101686:	83 ec 0c             	sub    $0xc,%esp
80101689:	68 0d 7a 10 80       	push   $0x80107a0d
8010168e:	e8 fd ec ff ff       	call   80100390 <panic>
80101693:	66 90                	xchg   %ax,%ax
80101695:	66 90                	xchg   %ax,%ax
80101697:	66 90                	xchg   %ax,%ax
80101699:	66 90                	xchg   %ax,%ax
8010169b:	66 90                	xchg   %ax,%ax
8010169d:	66 90                	xchg   %ax,%ax
8010169f:	90                   	nop

801016a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801016a0:	55                   	push   %ebp
801016a1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801016a3:	89 d0                	mov    %edx,%eax
801016a5:	c1 e8 0c             	shr    $0xc,%eax
801016a8:	03 05 78 1f 11 80    	add    0x80111f78,%eax
{
801016ae:	89 e5                	mov    %esp,%ebp
801016b0:	56                   	push   %esi
801016b1:	53                   	push   %ebx
801016b2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801016b4:	83 ec 08             	sub    $0x8,%esp
801016b7:	50                   	push   %eax
801016b8:	51                   	push   %ecx
801016b9:	e8 12 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801016be:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801016c0:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801016c3:	ba 01 00 00 00       	mov    $0x1,%edx
801016c8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801016cb:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801016d1:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801016d4:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801016d6:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801016db:	85 d1                	test   %edx,%ecx
801016dd:	74 25                	je     80101704 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801016df:	f7 d2                	not    %edx
  log_write(bp);
801016e1:	83 ec 0c             	sub    $0xc,%esp
801016e4:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801016e6:	21 ca                	and    %ecx,%edx
801016e8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801016ec:	50                   	push   %eax
801016ed:	e8 0e 1d 00 00       	call   80103400 <log_write>
  brelse(bp);
801016f2:	89 34 24             	mov    %esi,(%esp)
801016f5:	e8 f6 ea ff ff       	call   801001f0 <brelse>
}
801016fa:	83 c4 10             	add    $0x10,%esp
801016fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101700:	5b                   	pop    %ebx
80101701:	5e                   	pop    %esi
80101702:	5d                   	pop    %ebp
80101703:	c3                   	ret    
    panic("freeing free block");
80101704:	83 ec 0c             	sub    $0xc,%esp
80101707:	68 17 7a 10 80       	push   $0x80107a17
8010170c:	e8 7f ec ff ff       	call   80100390 <panic>
80101711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop

80101720 <balloc>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	57                   	push   %edi
80101724:	56                   	push   %esi
80101725:	53                   	push   %ebx
80101726:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101729:	8b 0d 60 1f 11 80    	mov    0x80111f60,%ecx
{
8010172f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101732:	85 c9                	test   %ecx,%ecx
80101734:	0f 84 87 00 00 00    	je     801017c1 <balloc+0xa1>
8010173a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
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
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101761:	a1 60 1f 11 80       	mov    0x80111f60,%eax
80101766:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101769:	31 c0                	xor    %eax,%eax
8010176b:	eb 2f                	jmp    8010179c <balloc+0x7c>
8010176d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101770:	89 c1                	mov    %eax,%ecx
80101772:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101777:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010177a:	83 e1 07             	and    $0x7,%ecx
8010177d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010177f:	89 c1                	mov    %eax,%ecx
80101781:	c1 f9 03             	sar    $0x3,%ecx
80101784:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101789:	89 fa                	mov    %edi,%edx
8010178b:	85 df                	test   %ebx,%edi
8010178d:	74 41                	je     801017d0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010178f:	83 c0 01             	add    $0x1,%eax
80101792:	83 c6 01             	add    $0x1,%esi
80101795:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010179a:	74 05                	je     801017a1 <balloc+0x81>
8010179c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010179f:	77 cf                	ja     80101770 <balloc+0x50>
    brelse(bp);
801017a1:	83 ec 0c             	sub    $0xc,%esp
801017a4:	ff 75 e4             	pushl  -0x1c(%ebp)
801017a7:	e8 44 ea ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801017ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801017b3:	83 c4 10             	add    $0x10,%esp
801017b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801017b9:	39 05 60 1f 11 80    	cmp    %eax,0x80111f60
801017bf:	77 80                	ja     80101741 <balloc+0x21>
  panic("balloc: out of blocks");
801017c1:	83 ec 0c             	sub    $0xc,%esp
801017c4:	68 2a 7a 10 80       	push   $0x80107a2a
801017c9:	e8 c2 eb ff ff       	call   80100390 <panic>
801017ce:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801017d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801017d3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801017d6:	09 da                	or     %ebx,%edx
801017d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801017dc:	57                   	push   %edi
801017dd:	e8 1e 1c 00 00       	call   80103400 <log_write>
        brelse(bp);
801017e2:	89 3c 24             	mov    %edi,(%esp)
801017e5:	e8 06 ea ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801017ea:	58                   	pop    %eax
801017eb:	5a                   	pop    %edx
801017ec:	56                   	push   %esi
801017ed:	ff 75 d8             	pushl  -0x28(%ebp)
801017f0:	e8 db e8 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801017f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801017f8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801017fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801017fd:	68 00 02 00 00       	push   $0x200
80101802:	6a 00                	push   $0x0
80101804:	50                   	push   %eax
80101805:	e8 d6 34 00 00       	call   80104ce0 <memset>
  log_write(bp);
8010180a:	89 1c 24             	mov    %ebx,(%esp)
8010180d:	e8 ee 1b 00 00       	call   80103400 <log_write>
  brelse(bp);
80101812:	89 1c 24             	mov    %ebx,(%esp)
80101815:	e8 d6 e9 ff ff       	call   801001f0 <brelse>
}
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
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	57                   	push   %edi
80101834:	89 c7                	mov    %eax,%edi
80101836:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101837:	31 f6                	xor    %esi,%esi
{
80101839:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010183a:	bb b4 1f 11 80       	mov    $0x80111fb4,%ebx
{
8010183f:	83 ec 28             	sub    $0x28,%esp
80101842:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101845:	68 80 1f 11 80       	push   $0x80111f80
8010184a:	e8 81 33 00 00       	call   80104bd0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010184f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101852:	83 c4 10             	add    $0x10,%esp
80101855:	eb 1b                	jmp    80101872 <iget+0x42>
80101857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101860:	39 3b                	cmp    %edi,(%ebx)
80101862:	74 6c                	je     801018d0 <iget+0xa0>
80101864:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010186a:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
80101870:	73 26                	jae    80101898 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101872:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101875:	85 c9                	test   %ecx,%ecx
80101877:	7f e7                	jg     80101860 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101879:	85 f6                	test   %esi,%esi
8010187b:	75 e7                	jne    80101864 <iget+0x34>
8010187d:	89 d8                	mov    %ebx,%eax
8010187f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101885:	85 c9                	test   %ecx,%ecx
80101887:	75 6e                	jne    801018f7 <iget+0xc7>
80101889:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010188b:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
80101891:	72 df                	jb     80101872 <iget+0x42>
80101893:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101897:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101898:	85 f6                	test   %esi,%esi
8010189a:	74 73                	je     8010190f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010189c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010189f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801018a1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801018a4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801018ab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801018b2:	68 80 1f 11 80       	push   $0x80111f80
801018b7:	e8 d4 33 00 00       	call   80104c90 <release>

  return ip;
801018bc:	83 c4 10             	add    $0x10,%esp
}
801018bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018c2:	89 f0                	mov    %esi,%eax
801018c4:	5b                   	pop    %ebx
801018c5:	5e                   	pop    %esi
801018c6:	5f                   	pop    %edi
801018c7:	5d                   	pop    %ebp
801018c8:	c3                   	ret    
801018c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801018d3:	75 8f                	jne    80101864 <iget+0x34>
      release(&icache.lock);
801018d5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801018d8:	83 c1 01             	add    $0x1,%ecx
      return ip;
801018db:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801018dd:	68 80 1f 11 80       	push   $0x80111f80
      ip->ref++;
801018e2:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801018e5:	e8 a6 33 00 00       	call   80104c90 <release>
      return ip;
801018ea:	83 c4 10             	add    $0x10,%esp
}
801018ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018f0:	89 f0                	mov    %esi,%eax
801018f2:	5b                   	pop    %ebx
801018f3:	5e                   	pop    %esi
801018f4:	5f                   	pop    %edi
801018f5:	5d                   	pop    %ebp
801018f6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018f7:	81 fb d4 3b 11 80    	cmp    $0x80113bd4,%ebx
801018fd:	73 10                	jae    8010190f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018ff:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101902:	85 c9                	test   %ecx,%ecx
80101904:	0f 8f 56 ff ff ff    	jg     80101860 <iget+0x30>
8010190a:	e9 6e ff ff ff       	jmp    8010187d <iget+0x4d>
    panic("iget: no inodes");
8010190f:	83 ec 0c             	sub    $0xc,%esp
80101912:	68 40 7a 10 80       	push   $0x80107a40
80101917:	e8 74 ea ff ff       	call   80100390 <panic>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	89 c6                	mov    %eax,%esi
80101927:	53                   	push   %ebx
80101928:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010192b:	83 fa 0b             	cmp    $0xb,%edx
8010192e:	0f 86 84 00 00 00    	jbe    801019b8 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101934:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101937:	83 fb 7f             	cmp    $0x7f,%ebx
8010193a:	0f 87 98 00 00 00    	ja     801019d8 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101940:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101946:	8b 16                	mov    (%esi),%edx
80101948:	85 c0                	test   %eax,%eax
8010194a:	74 54                	je     801019a0 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010194c:	83 ec 08             	sub    $0x8,%esp
8010194f:	50                   	push   %eax
80101950:	52                   	push   %edx
80101951:	e8 7a e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101956:	83 c4 10             	add    $0x10,%esp
80101959:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010195d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010195f:	8b 1a                	mov    (%edx),%ebx
80101961:	85 db                	test   %ebx,%ebx
80101963:	74 1b                	je     80101980 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101965:	83 ec 0c             	sub    $0xc,%esp
80101968:	57                   	push   %edi
80101969:	e8 82 e8 ff ff       	call   801001f0 <brelse>
    return addr;
8010196e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101971:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101974:	89 d8                	mov    %ebx,%eax
80101976:	5b                   	pop    %ebx
80101977:	5e                   	pop    %esi
80101978:	5f                   	pop    %edi
80101979:	5d                   	pop    %ebp
8010197a:	c3                   	ret    
8010197b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010197f:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101980:	8b 06                	mov    (%esi),%eax
80101982:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101985:	e8 96 fd ff ff       	call   80101720 <balloc>
8010198a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010198d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101990:	89 c3                	mov    %eax,%ebx
80101992:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101994:	57                   	push   %edi
80101995:	e8 66 1a 00 00       	call   80103400 <log_write>
8010199a:	83 c4 10             	add    $0x10,%esp
8010199d:	eb c6                	jmp    80101965 <bmap+0x45>
8010199f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801019a0:	89 d0                	mov    %edx,%eax
801019a2:	e8 79 fd ff ff       	call   80101720 <balloc>
801019a7:	8b 16                	mov    (%esi),%edx
801019a9:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801019af:	eb 9b                	jmp    8010194c <bmap+0x2c>
801019b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
801019b8:	8d 3c 90             	lea    (%eax,%edx,4),%edi
801019bb:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801019be:	85 db                	test   %ebx,%ebx
801019c0:	75 af                	jne    80101971 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
801019c2:	8b 00                	mov    (%eax),%eax
801019c4:	e8 57 fd ff ff       	call   80101720 <balloc>
801019c9:	89 47 5c             	mov    %eax,0x5c(%edi)
801019cc:	89 c3                	mov    %eax,%ebx
}
801019ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019d1:	89 d8                	mov    %ebx,%eax
801019d3:	5b                   	pop    %ebx
801019d4:	5e                   	pop    %esi
801019d5:	5f                   	pop    %edi
801019d6:	5d                   	pop    %ebp
801019d7:	c3                   	ret    
  panic("bmap: out of range");
801019d8:	83 ec 0c             	sub    $0xc,%esp
801019db:	68 50 7a 10 80       	push   $0x80107a50
801019e0:	e8 ab e9 ff ff       	call   80100390 <panic>
801019e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019f0 <readsb>:
{
801019f0:	f3 0f 1e fb          	endbr32 
801019f4:	55                   	push   %ebp
801019f5:	89 e5                	mov    %esp,%ebp
801019f7:	56                   	push   %esi
801019f8:	53                   	push   %ebx
801019f9:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801019fc:	83 ec 08             	sub    $0x8,%esp
801019ff:	6a 01                	push   $0x1
80101a01:	ff 75 08             	pushl  0x8(%ebp)
80101a04:	e8 c7 e6 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101a09:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101a0c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101a0e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101a11:	6a 1c                	push   $0x1c
80101a13:	50                   	push   %eax
80101a14:	56                   	push   %esi
80101a15:	e8 66 33 00 00       	call   80104d80 <memmove>
  brelse(bp);
80101a1a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a1d:	83 c4 10             	add    $0x10,%esp
}
80101a20:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a23:	5b                   	pop    %ebx
80101a24:	5e                   	pop    %esi
80101a25:	5d                   	pop    %ebp
  brelse(bp);
80101a26:	e9 c5 e7 ff ff       	jmp    801001f0 <brelse>
80101a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a2f:	90                   	nop

80101a30 <iinit>:
{
80101a30:	f3 0f 1e fb          	endbr32 
80101a34:	55                   	push   %ebp
80101a35:	89 e5                	mov    %esp,%ebp
80101a37:	53                   	push   %ebx
80101a38:	bb c0 1f 11 80       	mov    $0x80111fc0,%ebx
80101a3d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101a40:	68 63 7a 10 80       	push   $0x80107a63
80101a45:	68 80 1f 11 80       	push   $0x80111f80
80101a4a:	e8 01 30 00 00       	call   80104a50 <initlock>
  for(i = 0; i < NINODE; i++) {
80101a4f:	83 c4 10             	add    $0x10,%esp
80101a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101a58:	83 ec 08             	sub    $0x8,%esp
80101a5b:	68 6a 7a 10 80       	push   $0x80107a6a
80101a60:	53                   	push   %ebx
80101a61:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a67:	e8 a4 2e 00 00       	call   80104910 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101a6c:	83 c4 10             	add    $0x10,%esp
80101a6f:	81 fb e0 3b 11 80    	cmp    $0x80113be0,%ebx
80101a75:	75 e1                	jne    80101a58 <iinit+0x28>
  readsb(dev, &sb);
80101a77:	83 ec 08             	sub    $0x8,%esp
80101a7a:	68 60 1f 11 80       	push   $0x80111f60
80101a7f:	ff 75 08             	pushl  0x8(%ebp)
80101a82:	e8 69 ff ff ff       	call   801019f0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101a87:	ff 35 78 1f 11 80    	pushl  0x80111f78
80101a8d:	ff 35 74 1f 11 80    	pushl  0x80111f74
80101a93:	ff 35 70 1f 11 80    	pushl  0x80111f70
80101a99:	ff 35 6c 1f 11 80    	pushl  0x80111f6c
80101a9f:	ff 35 68 1f 11 80    	pushl  0x80111f68
80101aa5:	ff 35 64 1f 11 80    	pushl  0x80111f64
80101aab:	ff 35 60 1f 11 80    	pushl  0x80111f60
80101ab1:	68 d0 7a 10 80       	push   $0x80107ad0
80101ab6:	e8 05 ee ff ff       	call   801008c0 <cprintf>
}
80101abb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101abe:	83 c4 30             	add    $0x30,%esp
80101ac1:	c9                   	leave  
80101ac2:	c3                   	ret    
80101ac3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ad0 <ialloc>:
{
80101ad0:	f3 0f 1e fb          	endbr32 
80101ad4:	55                   	push   %ebp
80101ad5:	89 e5                	mov    %esp,%ebp
80101ad7:	57                   	push   %edi
80101ad8:	56                   	push   %esi
80101ad9:	53                   	push   %ebx
80101ada:	83 ec 1c             	sub    $0x1c,%esp
80101add:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101ae0:	83 3d 68 1f 11 80 01 	cmpl   $0x1,0x80111f68
{
80101ae7:	8b 75 08             	mov    0x8(%ebp),%esi
80101aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101aed:	0f 86 8d 00 00 00    	jbe    80101b80 <ialloc+0xb0>
80101af3:	bf 01 00 00 00       	mov    $0x1,%edi
80101af8:	eb 1d                	jmp    80101b17 <ialloc+0x47>
80101afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101b00:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101b03:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101b06:	53                   	push   %ebx
80101b07:	e8 e4 e6 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101b0c:	83 c4 10             	add    $0x10,%esp
80101b0f:	3b 3d 68 1f 11 80    	cmp    0x80111f68,%edi
80101b15:	73 69                	jae    80101b80 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101b17:	89 f8                	mov    %edi,%eax
80101b19:	83 ec 08             	sub    $0x8,%esp
80101b1c:	c1 e8 03             	shr    $0x3,%eax
80101b1f:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101b25:	50                   	push   %eax
80101b26:	56                   	push   %esi
80101b27:	e8 a4 e5 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101b2c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101b2f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101b31:	89 f8                	mov    %edi,%eax
80101b33:	83 e0 07             	and    $0x7,%eax
80101b36:	c1 e0 06             	shl    $0x6,%eax
80101b39:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101b3d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101b41:	75 bd                	jne    80101b00 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101b43:	83 ec 04             	sub    $0x4,%esp
80101b46:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b49:	6a 40                	push   $0x40
80101b4b:	6a 00                	push   $0x0
80101b4d:	51                   	push   %ecx
80101b4e:	e8 8d 31 00 00       	call   80104ce0 <memset>
      dip->type = type;
80101b53:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b57:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b5a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101b5d:	89 1c 24             	mov    %ebx,(%esp)
80101b60:	e8 9b 18 00 00       	call   80103400 <log_write>
      brelse(bp);
80101b65:	89 1c 24             	mov    %ebx,(%esp)
80101b68:	e8 83 e6 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101b6d:	83 c4 10             	add    $0x10,%esp
}
80101b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101b73:	89 fa                	mov    %edi,%edx
}
80101b75:	5b                   	pop    %ebx
      return iget(dev, inum);
80101b76:	89 f0                	mov    %esi,%eax
}
80101b78:	5e                   	pop    %esi
80101b79:	5f                   	pop    %edi
80101b7a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101b7b:	e9 b0 fc ff ff       	jmp    80101830 <iget>
  panic("ialloc: no inodes");
80101b80:	83 ec 0c             	sub    $0xc,%esp
80101b83:	68 70 7a 10 80       	push   $0x80107a70
80101b88:	e8 03 e8 ff ff       	call   80100390 <panic>
80101b8d:	8d 76 00             	lea    0x0(%esi),%esi

80101b90 <iupdate>:
{
80101b90:	f3 0f 1e fb          	endbr32 
80101b94:	55                   	push   %ebp
80101b95:	89 e5                	mov    %esp,%ebp
80101b97:	56                   	push   %esi
80101b98:	53                   	push   %ebx
80101b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b9c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b9f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101ba2:	83 ec 08             	sub    $0x8,%esp
80101ba5:	c1 e8 03             	shr    $0x3,%eax
80101ba8:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101bae:	50                   	push   %eax
80101baf:	ff 73 a4             	pushl  -0x5c(%ebx)
80101bb2:	e8 19 e5 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101bb7:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bbb:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101bbe:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101bc0:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101bc3:	83 e0 07             	and    $0x7,%eax
80101bc6:	c1 e0 06             	shl    $0x6,%eax
80101bc9:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101bcd:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101bd0:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bd4:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101bd7:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101bdb:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101bdf:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101be3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101be7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101beb:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101bee:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bf1:	6a 34                	push   $0x34
80101bf3:	53                   	push   %ebx
80101bf4:	50                   	push   %eax
80101bf5:	e8 86 31 00 00       	call   80104d80 <memmove>
  log_write(bp);
80101bfa:	89 34 24             	mov    %esi,(%esp)
80101bfd:	e8 fe 17 00 00       	call   80103400 <log_write>
  brelse(bp);
80101c02:	89 75 08             	mov    %esi,0x8(%ebp)
80101c05:	83 c4 10             	add    $0x10,%esp
}
80101c08:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c0b:	5b                   	pop    %ebx
80101c0c:	5e                   	pop    %esi
80101c0d:	5d                   	pop    %ebp
  brelse(bp);
80101c0e:	e9 dd e5 ff ff       	jmp    801001f0 <brelse>
80101c13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c20 <idup>:
{
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	53                   	push   %ebx
80101c28:	83 ec 10             	sub    $0x10,%esp
80101c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101c2e:	68 80 1f 11 80       	push   $0x80111f80
80101c33:	e8 98 2f 00 00       	call   80104bd0 <acquire>
  ip->ref++;
80101c38:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c3c:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101c43:	e8 48 30 00 00       	call   80104c90 <release>
}
80101c48:	89 d8                	mov    %ebx,%eax
80101c4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c4d:	c9                   	leave  
80101c4e:	c3                   	ret    
80101c4f:	90                   	nop

80101c50 <ilock>:
{
80101c50:	f3 0f 1e fb          	endbr32 
80101c54:	55                   	push   %ebp
80101c55:	89 e5                	mov    %esp,%ebp
80101c57:	56                   	push   %esi
80101c58:	53                   	push   %ebx
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101c5c:	85 db                	test   %ebx,%ebx
80101c5e:	0f 84 b3 00 00 00    	je     80101d17 <ilock+0xc7>
80101c64:	8b 53 08             	mov    0x8(%ebx),%edx
80101c67:	85 d2                	test   %edx,%edx
80101c69:	0f 8e a8 00 00 00    	jle    80101d17 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101c6f:	83 ec 0c             	sub    $0xc,%esp
80101c72:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c75:	50                   	push   %eax
80101c76:	e8 d5 2c 00 00       	call   80104950 <acquiresleep>
  if(ip->valid == 0){
80101c7b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101c7e:	83 c4 10             	add    $0x10,%esp
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 0b                	je     80101c90 <ilock+0x40>
}
80101c85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c88:	5b                   	pop    %ebx
80101c89:	5e                   	pop    %esi
80101c8a:	5d                   	pop    %ebp
80101c8b:	c3                   	ret    
80101c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c90:	8b 43 04             	mov    0x4(%ebx),%eax
80101c93:	83 ec 08             	sub    $0x8,%esp
80101c96:	c1 e8 03             	shr    $0x3,%eax
80101c99:	03 05 74 1f 11 80    	add    0x80111f74,%eax
80101c9f:	50                   	push   %eax
80101ca0:	ff 33                	pushl  (%ebx)
80101ca2:	e8 29 e4 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ca7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101caa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101cac:	8b 43 04             	mov    0x4(%ebx),%eax
80101caf:	83 e0 07             	and    $0x7,%eax
80101cb2:	c1 e0 06             	shl    $0x6,%eax
80101cb5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101cb9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cbc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101cbf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101cc3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101cc7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101ccb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101ccf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101cd3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101cd7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101cdb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101cde:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ce1:	6a 34                	push   $0x34
80101ce3:	50                   	push   %eax
80101ce4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101ce7:	50                   	push   %eax
80101ce8:	e8 93 30 00 00       	call   80104d80 <memmove>
    brelse(bp);
80101ced:	89 34 24             	mov    %esi,(%esp)
80101cf0:	e8 fb e4 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101cf5:	83 c4 10             	add    $0x10,%esp
80101cf8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101cfd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101d04:	0f 85 7b ff ff ff    	jne    80101c85 <ilock+0x35>
      panic("ilock: no type");
80101d0a:	83 ec 0c             	sub    $0xc,%esp
80101d0d:	68 88 7a 10 80       	push   $0x80107a88
80101d12:	e8 79 e6 ff ff       	call   80100390 <panic>
    panic("ilock");
80101d17:	83 ec 0c             	sub    $0xc,%esp
80101d1a:	68 82 7a 10 80       	push   $0x80107a82
80101d1f:	e8 6c e6 ff ff       	call   80100390 <panic>
80101d24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d2f:	90                   	nop

80101d30 <iunlock>:
{
80101d30:	f3 0f 1e fb          	endbr32 
80101d34:	55                   	push   %ebp
80101d35:	89 e5                	mov    %esp,%ebp
80101d37:	56                   	push   %esi
80101d38:	53                   	push   %ebx
80101d39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d3c:	85 db                	test   %ebx,%ebx
80101d3e:	74 28                	je     80101d68 <iunlock+0x38>
80101d40:	83 ec 0c             	sub    $0xc,%esp
80101d43:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d46:	56                   	push   %esi
80101d47:	e8 a4 2c 00 00       	call   801049f0 <holdingsleep>
80101d4c:	83 c4 10             	add    $0x10,%esp
80101d4f:	85 c0                	test   %eax,%eax
80101d51:	74 15                	je     80101d68 <iunlock+0x38>
80101d53:	8b 43 08             	mov    0x8(%ebx),%eax
80101d56:	85 c0                	test   %eax,%eax
80101d58:	7e 0e                	jle    80101d68 <iunlock+0x38>
  releasesleep(&ip->lock);
80101d5a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101d5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d60:	5b                   	pop    %ebx
80101d61:	5e                   	pop    %esi
80101d62:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101d63:	e9 48 2c 00 00       	jmp    801049b0 <releasesleep>
    panic("iunlock");
80101d68:	83 ec 0c             	sub    $0xc,%esp
80101d6b:	68 97 7a 10 80       	push   $0x80107a97
80101d70:	e8 1b e6 ff ff       	call   80100390 <panic>
80101d75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d80 <iput>:
{
80101d80:	f3 0f 1e fb          	endbr32 
80101d84:	55                   	push   %ebp
80101d85:	89 e5                	mov    %esp,%ebp
80101d87:	57                   	push   %edi
80101d88:	56                   	push   %esi
80101d89:	53                   	push   %ebx
80101d8a:	83 ec 28             	sub    $0x28,%esp
80101d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101d90:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101d93:	57                   	push   %edi
80101d94:	e8 b7 2b 00 00       	call   80104950 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101d99:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101d9c:	83 c4 10             	add    $0x10,%esp
80101d9f:	85 d2                	test   %edx,%edx
80101da1:	74 07                	je     80101daa <iput+0x2a>
80101da3:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101da8:	74 36                	je     80101de0 <iput+0x60>
  releasesleep(&ip->lock);
80101daa:	83 ec 0c             	sub    $0xc,%esp
80101dad:	57                   	push   %edi
80101dae:	e8 fd 2b 00 00       	call   801049b0 <releasesleep>
  acquire(&icache.lock);
80101db3:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101dba:	e8 11 2e 00 00       	call   80104bd0 <acquire>
  ip->ref--;
80101dbf:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101dc3:	83 c4 10             	add    $0x10,%esp
80101dc6:	c7 45 08 80 1f 11 80 	movl   $0x80111f80,0x8(%ebp)
}
80101dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd0:	5b                   	pop    %ebx
80101dd1:	5e                   	pop    %esi
80101dd2:	5f                   	pop    %edi
80101dd3:	5d                   	pop    %ebp
  release(&icache.lock);
80101dd4:	e9 b7 2e 00 00       	jmp    80104c90 <release>
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	68 80 1f 11 80       	push   $0x80111f80
80101de8:	e8 e3 2d 00 00       	call   80104bd0 <acquire>
    int r = ip->ref;
80101ded:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101df0:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
80101df7:	e8 94 2e 00 00       	call   80104c90 <release>
    if(r == 1){
80101dfc:	83 c4 10             	add    $0x10,%esp
80101dff:	83 fe 01             	cmp    $0x1,%esi
80101e02:	75 a6                	jne    80101daa <iput+0x2a>
80101e04:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101e0a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101e0d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101e10:	89 cf                	mov    %ecx,%edi
80101e12:	eb 0b                	jmp    80101e1f <iput+0x9f>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e18:	83 c6 04             	add    $0x4,%esi
80101e1b:	39 fe                	cmp    %edi,%esi
80101e1d:	74 19                	je     80101e38 <iput+0xb8>
    if(ip->addrs[i]){
80101e1f:	8b 16                	mov    (%esi),%edx
80101e21:	85 d2                	test   %edx,%edx
80101e23:	74 f3                	je     80101e18 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101e25:	8b 03                	mov    (%ebx),%eax
80101e27:	e8 74 f8 ff ff       	call   801016a0 <bfree>
      ip->addrs[i] = 0;
80101e2c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101e32:	eb e4                	jmp    80101e18 <iput+0x98>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101e38:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101e3e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e41:	85 c0                	test   %eax,%eax
80101e43:	75 33                	jne    80101e78 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101e45:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101e48:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101e4f:	53                   	push   %ebx
80101e50:	e8 3b fd ff ff       	call   80101b90 <iupdate>
      ip->type = 0;
80101e55:	31 c0                	xor    %eax,%eax
80101e57:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101e5b:	89 1c 24             	mov    %ebx,(%esp)
80101e5e:	e8 2d fd ff ff       	call   80101b90 <iupdate>
      ip->valid = 0;
80101e63:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101e6a:	83 c4 10             	add    $0x10,%esp
80101e6d:	e9 38 ff ff ff       	jmp    80101daa <iput+0x2a>
80101e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e78:	83 ec 08             	sub    $0x8,%esp
80101e7b:	50                   	push   %eax
80101e7c:	ff 33                	pushl  (%ebx)
80101e7e:	e8 4d e2 ff ff       	call   801000d0 <bread>
80101e83:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e86:	83 c4 10             	add    $0x10,%esp
80101e89:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e92:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e95:	89 cf                	mov    %ecx,%edi
80101e97:	eb 0e                	jmp    80101ea7 <iput+0x127>
80101e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea0:	83 c6 04             	add    $0x4,%esi
80101ea3:	39 f7                	cmp    %esi,%edi
80101ea5:	74 19                	je     80101ec0 <iput+0x140>
      if(a[j])
80101ea7:	8b 16                	mov    (%esi),%edx
80101ea9:	85 d2                	test   %edx,%edx
80101eab:	74 f3                	je     80101ea0 <iput+0x120>
        bfree(ip->dev, a[j]);
80101ead:	8b 03                	mov    (%ebx),%eax
80101eaf:	e8 ec f7 ff ff       	call   801016a0 <bfree>
80101eb4:	eb ea                	jmp    80101ea0 <iput+0x120>
80101eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ebd:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ec6:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ec9:	e8 22 e3 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ece:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101ed4:	8b 03                	mov    (%ebx),%eax
80101ed6:	e8 c5 f7 ff ff       	call   801016a0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101edb:	83 c4 10             	add    $0x10,%esp
80101ede:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101ee5:	00 00 00 
80101ee8:	e9 58 ff ff ff       	jmp    80101e45 <iput+0xc5>
80101eed:	8d 76 00             	lea    0x0(%esi),%esi

80101ef0 <iunlockput>:
{
80101ef0:	f3 0f 1e fb          	endbr32 
80101ef4:	55                   	push   %ebp
80101ef5:	89 e5                	mov    %esp,%ebp
80101ef7:	53                   	push   %ebx
80101ef8:	83 ec 10             	sub    $0x10,%esp
80101efb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101efe:	53                   	push   %ebx
80101eff:	e8 2c fe ff ff       	call   80101d30 <iunlock>
  iput(ip);
80101f04:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101f07:	83 c4 10             	add    $0x10,%esp
}
80101f0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f0d:	c9                   	leave  
  iput(ip);
80101f0e:	e9 6d fe ff ff       	jmp    80101d80 <iput>
80101f13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f20 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101f20:	f3 0f 1e fb          	endbr32 
80101f24:	55                   	push   %ebp
80101f25:	89 e5                	mov    %esp,%ebp
80101f27:	8b 55 08             	mov    0x8(%ebp),%edx
80101f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101f2d:	8b 0a                	mov    (%edx),%ecx
80101f2f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101f32:	8b 4a 04             	mov    0x4(%edx),%ecx
80101f35:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101f38:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101f3c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101f3f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101f43:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101f47:	8b 52 58             	mov    0x58(%edx),%edx
80101f4a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f4d:	5d                   	pop    %ebp
80101f4e:	c3                   	ret    
80101f4f:	90                   	nop

80101f50 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
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
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f6c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f71:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f74:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101f77:	0f 84 a3 00 00 00    	je     80102020 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
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
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101f9f:	89 c1                	mov    %eax,%ecx
80101fa1:	29 f1                	sub    %esi,%ecx
80101fa3:	39 d0                	cmp    %edx,%eax
80101fa5:	0f 43 cb             	cmovae %ebx,%ecx
80101fa8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fab:	85 c9                	test   %ecx,%ecx
80101fad:	74 63                	je     80102012 <readi+0xc2>
80101faf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fb0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101fb3:	89 f2                	mov    %esi,%edx
80101fb5:	c1 ea 09             	shr    $0x9,%edx
80101fb8:	89 d8                	mov    %ebx,%eax
80101fba:	e8 61 f9 ff ff       	call   80101920 <bmap>
80101fbf:	83 ec 08             	sub    $0x8,%esp
80101fc2:	50                   	push   %eax
80101fc3:	ff 33                	pushl  (%ebx)
80101fc5:	e8 06 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101fca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101fcd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101fd2:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fd5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101fd7:	89 f0                	mov    %esi,%eax
80101fd9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fde:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101fe0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fe3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101fe5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fe9:	39 d9                	cmp    %ebx,%ecx
80101feb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101fee:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fef:	01 df                	add    %ebx,%edi
80101ff1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ff3:	50                   	push   %eax
80101ff4:	ff 75 e0             	pushl  -0x20(%ebp)
80101ff7:	e8 84 2d 00 00       	call   80104d80 <memmove>
    brelse(bp);
80101ffc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fff:	89 14 24             	mov    %edx,(%esp)
80102002:	e8 e9 e1 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102007:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010200a:	83 c4 10             	add    $0x10,%esp
8010200d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102010:	77 9e                	ja     80101fb0 <readi+0x60>
  }
  return n;
80102012:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102018:	5b                   	pop    %ebx
80102019:	5e                   	pop    %esi
8010201a:	5f                   	pop    %edi
8010201b:	5d                   	pop    %ebp
8010201c:	c3                   	ret    
8010201d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102020:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102024:	66 83 f8 09          	cmp    $0x9,%ax
80102028:	77 17                	ja     80102041 <readi+0xf1>
8010202a:	8b 04 c5 00 1f 11 80 	mov    -0x7feee100(,%eax,8),%eax
80102031:	85 c0                	test   %eax,%eax
80102033:	74 0c                	je     80102041 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102035:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010203b:	5b                   	pop    %ebx
8010203c:	5e                   	pop    %esi
8010203d:	5f                   	pop    %edi
8010203e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010203f:	ff e0                	jmp    *%eax
      return -1;
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	eb cd                	jmp    80102015 <readi+0xc5>
80102048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010204f:	90                   	nop

80102050 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
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
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102066:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
8010206b:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010206e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102071:	8b 75 10             	mov    0x10(%ebp),%esi
80102074:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80102077:	0f 84 b3 00 00 00    	je     80102130 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
8010207d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102080:	39 70 58             	cmp    %esi,0x58(%eax)
80102083:	0f 82 e3 00 00 00    	jb     8010216c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102089:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010208c:	89 f8                	mov    %edi,%eax
8010208e:	01 f0                	add    %esi,%eax
80102090:	0f 82 d6 00 00 00    	jb     8010216c <writei+0x11c>
80102096:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010209b:	0f 87 cb 00 00 00    	ja     8010216c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801020a8:	85 ff                	test   %edi,%edi
801020aa:	74 75                	je     80102121 <writei+0xd1>
801020ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020b0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801020b3:	89 f2                	mov    %esi,%edx
801020b5:	c1 ea 09             	shr    $0x9,%edx
801020b8:	89 f8                	mov    %edi,%eax
801020ba:	e8 61 f8 ff ff       	call   80101920 <bmap>
801020bf:	83 ec 08             	sub    $0x8,%esp
801020c2:	50                   	push   %eax
801020c3:	ff 37                	pushl  (%edi)
801020c5:	e8 06 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801020ca:	b9 00 02 00 00       	mov    $0x200,%ecx
801020cf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020d2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020d5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801020d7:	89 f0                	mov    %esi,%eax
801020d9:	83 c4 0c             	add    $0xc,%esp
801020dc:	25 ff 01 00 00       	and    $0x1ff,%eax
801020e1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801020e3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801020e7:	39 d9                	cmp    %ebx,%ecx
801020e9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801020ec:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020ed:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
801020ef:	ff 75 dc             	pushl  -0x24(%ebp)
801020f2:	50                   	push   %eax
801020f3:	e8 88 2c 00 00       	call   80104d80 <memmove>
    log_write(bp);
801020f8:	89 3c 24             	mov    %edi,(%esp)
801020fb:	e8 00 13 00 00       	call   80103400 <log_write>
    brelse(bp);
80102100:	89 3c 24             	mov    %edi,(%esp)
80102103:	e8 e8 e0 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102108:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102111:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102114:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102117:	77 97                	ja     801020b0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102119:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010211c:	3b 70 58             	cmp    0x58(%eax),%esi
8010211f:	77 37                	ja     80102158 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102121:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102130:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102134:	66 83 f8 09          	cmp    $0x9,%ax
80102138:	77 32                	ja     8010216c <writei+0x11c>
8010213a:	8b 04 c5 04 1f 11 80 	mov    -0x7feee0fc(,%eax,8),%eax
80102141:	85 c0                	test   %eax,%eax
80102143:	74 27                	je     8010216c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102145:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102148:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214b:	5b                   	pop    %ebx
8010214c:	5e                   	pop    %esi
8010214d:	5f                   	pop    %edi
8010214e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010214f:	ff e0                	jmp    *%eax
80102151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102158:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010215b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010215e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102161:	50                   	push   %eax
80102162:	e8 29 fa ff ff       	call   80101b90 <iupdate>
80102167:	83 c4 10             	add    $0x10,%esp
8010216a:	eb b5                	jmp    80102121 <writei+0xd1>
      return -1;
8010216c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102171:	eb b1                	jmp    80102124 <writei+0xd4>
80102173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102180 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102180:	f3 0f 1e fb          	endbr32 
80102184:	55                   	push   %ebp
80102185:	89 e5                	mov    %esp,%ebp
80102187:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010218a:	6a 0e                	push   $0xe
8010218c:	ff 75 0c             	pushl  0xc(%ebp)
8010218f:	ff 75 08             	pushl  0x8(%ebp)
80102192:	e8 59 2c 00 00       	call   80104df0 <strncmp>
}
80102197:	c9                   	leave  
80102198:	c3                   	ret    
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021a0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021a0:	f3 0f 1e fb          	endbr32 
801021a4:	55                   	push   %ebp
801021a5:	89 e5                	mov    %esp,%ebp
801021a7:	57                   	push   %edi
801021a8:	56                   	push   %esi
801021a9:	53                   	push   %ebx
801021aa:	83 ec 1c             	sub    $0x1c,%esp
801021ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021b0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021b5:	0f 85 89 00 00 00    	jne    80102244 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021bb:	8b 53 58             	mov    0x58(%ebx),%edx
801021be:	31 ff                	xor    %edi,%edi
801021c0:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021c3:	85 d2                	test   %edx,%edx
801021c5:	74 42                	je     80102209 <dirlookup+0x69>
801021c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ce:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021d0:	6a 10                	push   $0x10
801021d2:	57                   	push   %edi
801021d3:	56                   	push   %esi
801021d4:	53                   	push   %ebx
801021d5:	e8 76 fd ff ff       	call   80101f50 <readi>
801021da:	83 c4 10             	add    $0x10,%esp
801021dd:	83 f8 10             	cmp    $0x10,%eax
801021e0:	75 55                	jne    80102237 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
801021e2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021e7:	74 18                	je     80102201 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
801021e9:	83 ec 04             	sub    $0x4,%esp
801021ec:	8d 45 da             	lea    -0x26(%ebp),%eax
801021ef:	6a 0e                	push   $0xe
801021f1:	50                   	push   %eax
801021f2:	ff 75 0c             	pushl  0xc(%ebp)
801021f5:	e8 f6 2b 00 00       	call   80104df0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801021fa:	83 c4 10             	add    $0x10,%esp
801021fd:	85 c0                	test   %eax,%eax
801021ff:	74 17                	je     80102218 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102201:	83 c7 10             	add    $0x10,%edi
80102204:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102207:	72 c7                	jb     801021d0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102209:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010220c:	31 c0                	xor    %eax,%eax
}
8010220e:	5b                   	pop    %ebx
8010220f:	5e                   	pop    %esi
80102210:	5f                   	pop    %edi
80102211:	5d                   	pop    %ebp
80102212:	c3                   	ret    
80102213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102217:	90                   	nop
      if(poff)
80102218:	8b 45 10             	mov    0x10(%ebp),%eax
8010221b:	85 c0                	test   %eax,%eax
8010221d:	74 05                	je     80102224 <dirlookup+0x84>
        *poff = off;
8010221f:	8b 45 10             	mov    0x10(%ebp),%eax
80102222:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102224:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102228:	8b 03                	mov    (%ebx),%eax
8010222a:	e8 01 f6 ff ff       	call   80101830 <iget>
}
8010222f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102232:	5b                   	pop    %ebx
80102233:	5e                   	pop    %esi
80102234:	5f                   	pop    %edi
80102235:	5d                   	pop    %ebp
80102236:	c3                   	ret    
      panic("dirlookup read");
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 b1 7a 10 80       	push   $0x80107ab1
8010223f:	e8 4c e1 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102244:	83 ec 0c             	sub    $0xc,%esp
80102247:	68 9f 7a 10 80       	push   $0x80107a9f
8010224c:	e8 3f e1 ff ff       	call   80100390 <panic>
80102251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102258:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010225f:	90                   	nop

80102260 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	57                   	push   %edi
80102264:	56                   	push   %esi
80102265:	53                   	push   %ebx
80102266:	89 c3                	mov    %eax,%ebx
80102268:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010226b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010226e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102271:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102274:	0f 84 86 01 00 00    	je     80102400 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010227a:	e8 e1 1b 00 00       	call   80103e60 <myproc>
  acquire(&icache.lock);
8010227f:	83 ec 0c             	sub    $0xc,%esp
80102282:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102284:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102287:	68 80 1f 11 80       	push   $0x80111f80
8010228c:	e8 3f 29 00 00       	call   80104bd0 <acquire>
  ip->ref++;
80102291:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102295:	c7 04 24 80 1f 11 80 	movl   $0x80111f80,(%esp)
8010229c:	e8 ef 29 00 00       	call   80104c90 <release>
801022a1:	83 c4 10             	add    $0x10,%esp
801022a4:	eb 0d                	jmp    801022b3 <namex+0x53>
801022a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ad:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
801022b0:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
801022b3:	0f b6 07             	movzbl (%edi),%eax
801022b6:	3c 2f                	cmp    $0x2f,%al
801022b8:	74 f6                	je     801022b0 <namex+0x50>
  if(*path == 0)
801022ba:	84 c0                	test   %al,%al
801022bc:	0f 84 ee 00 00 00    	je     801023b0 <namex+0x150>
  while(*path != '/' && *path != 0)
801022c2:	0f b6 07             	movzbl (%edi),%eax
801022c5:	84 c0                	test   %al,%al
801022c7:	0f 84 fb 00 00 00    	je     801023c8 <namex+0x168>
801022cd:	89 fb                	mov    %edi,%ebx
801022cf:	3c 2f                	cmp    $0x2f,%al
801022d1:	0f 84 f1 00 00 00    	je     801023c8 <namex+0x168>
801022d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022de:	66 90                	xchg   %ax,%ax
801022e0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
801022e4:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
801022e7:	3c 2f                	cmp    $0x2f,%al
801022e9:	74 04                	je     801022ef <namex+0x8f>
801022eb:	84 c0                	test   %al,%al
801022ed:	75 f1                	jne    801022e0 <namex+0x80>
  len = path - s;
801022ef:	89 d8                	mov    %ebx,%eax
801022f1:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
801022f3:	83 f8 0d             	cmp    $0xd,%eax
801022f6:	0f 8e 84 00 00 00    	jle    80102380 <namex+0x120>
    memmove(name, s, DIRSIZ);
801022fc:	83 ec 04             	sub    $0x4,%esp
801022ff:	6a 0e                	push   $0xe
80102301:	57                   	push   %edi
    path++;
80102302:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80102304:	ff 75 e4             	pushl  -0x1c(%ebp)
80102307:	e8 74 2a 00 00       	call   80104d80 <memmove>
8010230c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010230f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102312:	75 0c                	jne    80102320 <namex+0xc0>
80102314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102318:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
8010231b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010231e:	74 f8                	je     80102318 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	56                   	push   %esi
80102324:	e8 27 f9 ff ff       	call   80101c50 <ilock>
    if(ip->type != T_DIR){
80102329:	83 c4 10             	add    $0x10,%esp
8010232c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102331:	0f 85 a1 00 00 00    	jne    801023d8 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102337:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010233a:	85 d2                	test   %edx,%edx
8010233c:	74 09                	je     80102347 <namex+0xe7>
8010233e:	80 3f 00             	cmpb   $0x0,(%edi)
80102341:	0f 84 d9 00 00 00    	je     80102420 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	6a 00                	push   $0x0
8010234c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010234f:	56                   	push   %esi
80102350:	e8 4b fe ff ff       	call   801021a0 <dirlookup>
80102355:	83 c4 10             	add    $0x10,%esp
80102358:	89 c3                	mov    %eax,%ebx
8010235a:	85 c0                	test   %eax,%eax
8010235c:	74 7a                	je     801023d8 <namex+0x178>
  iunlock(ip);
8010235e:	83 ec 0c             	sub    $0xc,%esp
80102361:	56                   	push   %esi
80102362:	e8 c9 f9 ff ff       	call   80101d30 <iunlock>
  iput(ip);
80102367:	89 34 24             	mov    %esi,(%esp)
8010236a:	89 de                	mov    %ebx,%esi
8010236c:	e8 0f fa ff ff       	call   80101d80 <iput>
80102371:	83 c4 10             	add    $0x10,%esp
80102374:	e9 3a ff ff ff       	jmp    801022b3 <namex+0x53>
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102380:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102383:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102386:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102389:	83 ec 04             	sub    $0x4,%esp
8010238c:	50                   	push   %eax
8010238d:	57                   	push   %edi
    name[len] = 0;
8010238e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102390:	ff 75 e4             	pushl  -0x1c(%ebp)
80102393:	e8 e8 29 00 00       	call   80104d80 <memmove>
    name[len] = 0;
80102398:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010239b:	83 c4 10             	add    $0x10,%esp
8010239e:	c6 00 00             	movb   $0x0,(%eax)
801023a1:	e9 69 ff ff ff       	jmp    8010230f <namex+0xaf>
801023a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ad:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801023b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801023b3:	85 c0                	test   %eax,%eax
801023b5:	0f 85 85 00 00 00    	jne    80102440 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
801023bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023be:	89 f0                	mov    %esi,%eax
801023c0:	5b                   	pop    %ebx
801023c1:	5e                   	pop    %esi
801023c2:	5f                   	pop    %edi
801023c3:	5d                   	pop    %ebp
801023c4:	c3                   	ret    
801023c5:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
801023c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801023cb:	89 fb                	mov    %edi,%ebx
801023cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801023d0:	31 c0                	xor    %eax,%eax
801023d2:	eb b5                	jmp    80102389 <namex+0x129>
801023d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801023d8:	83 ec 0c             	sub    $0xc,%esp
801023db:	56                   	push   %esi
801023dc:	e8 4f f9 ff ff       	call   80101d30 <iunlock>
  iput(ip);
801023e1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801023e4:	31 f6                	xor    %esi,%esi
  iput(ip);
801023e6:	e8 95 f9 ff ff       	call   80101d80 <iput>
      return 0;
801023eb:	83 c4 10             	add    $0x10,%esp
}
801023ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f1:	89 f0                	mov    %esi,%eax
801023f3:	5b                   	pop    %ebx
801023f4:	5e                   	pop    %esi
801023f5:	5f                   	pop    %edi
801023f6:	5d                   	pop    %ebp
801023f7:	c3                   	ret    
801023f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ff:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80102400:	ba 01 00 00 00       	mov    $0x1,%edx
80102405:	b8 01 00 00 00       	mov    $0x1,%eax
8010240a:	89 df                	mov    %ebx,%edi
8010240c:	e8 1f f4 ff ff       	call   80101830 <iget>
80102411:	89 c6                	mov    %eax,%esi
80102413:	e9 9b fe ff ff       	jmp    801022b3 <namex+0x53>
80102418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
      iunlock(ip);
80102420:	83 ec 0c             	sub    $0xc,%esp
80102423:	56                   	push   %esi
80102424:	e8 07 f9 ff ff       	call   80101d30 <iunlock>
      return ip;
80102429:	83 c4 10             	add    $0x10,%esp
}
8010242c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010242f:	89 f0                	mov    %esi,%eax
80102431:	5b                   	pop    %ebx
80102432:	5e                   	pop    %esi
80102433:	5f                   	pop    %edi
80102434:	5d                   	pop    %ebp
80102435:	c3                   	ret    
80102436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010243d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	56                   	push   %esi
    return 0;
80102444:	31 f6                	xor    %esi,%esi
    iput(ip);
80102446:	e8 35 f9 ff ff       	call   80101d80 <iput>
    return 0;
8010244b:	83 c4 10             	add    $0x10,%esp
8010244e:	e9 68 ff ff ff       	jmp    801023bb <namex+0x15b>
80102453:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010245a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102460 <dirlink>:
{
80102460:	f3 0f 1e fb          	endbr32 
80102464:	55                   	push   %ebp
80102465:	89 e5                	mov    %esp,%ebp
80102467:	57                   	push   %edi
80102468:	56                   	push   %esi
80102469:	53                   	push   %ebx
8010246a:	83 ec 20             	sub    $0x20,%esp
8010246d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102470:	6a 00                	push   $0x0
80102472:	ff 75 0c             	pushl  0xc(%ebp)
80102475:	53                   	push   %ebx
80102476:	e8 25 fd ff ff       	call   801021a0 <dirlookup>
8010247b:	83 c4 10             	add    $0x10,%esp
8010247e:	85 c0                	test   %eax,%eax
80102480:	75 6b                	jne    801024ed <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
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
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024a0:	6a 10                	push   $0x10
801024a2:	57                   	push   %edi
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	e8 a6 fa ff ff       	call   80101f50 <readi>
801024aa:	83 c4 10             	add    $0x10,%esp
801024ad:	83 f8 10             	cmp    $0x10,%eax
801024b0:	75 4e                	jne    80102500 <dirlink+0xa0>
    if(de.inum == 0)
801024b2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801024b7:	75 df                	jne    80102498 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
801024b9:	83 ec 04             	sub    $0x4,%esp
801024bc:	8d 45 da             	lea    -0x26(%ebp),%eax
801024bf:	6a 0e                	push   $0xe
801024c1:	ff 75 0c             	pushl  0xc(%ebp)
801024c4:	50                   	push   %eax
801024c5:	e8 76 29 00 00       	call   80104e40 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024ca:	6a 10                	push   $0x10
  de.inum = inum;
801024cc:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024cf:	57                   	push   %edi
801024d0:	56                   	push   %esi
801024d1:	53                   	push   %ebx
  de.inum = inum;
801024d2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024d6:	e8 75 fb ff ff       	call   80102050 <writei>
801024db:	83 c4 20             	add    $0x20,%esp
801024de:	83 f8 10             	cmp    $0x10,%eax
801024e1:	75 2a                	jne    8010250d <dirlink+0xad>
  return 0;
801024e3:	31 c0                	xor    %eax,%eax
}
801024e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024e8:	5b                   	pop    %ebx
801024e9:	5e                   	pop    %esi
801024ea:	5f                   	pop    %edi
801024eb:	5d                   	pop    %ebp
801024ec:	c3                   	ret    
    iput(ip);
801024ed:	83 ec 0c             	sub    $0xc,%esp
801024f0:	50                   	push   %eax
801024f1:	e8 8a f8 ff ff       	call   80101d80 <iput>
    return -1;
801024f6:	83 c4 10             	add    $0x10,%esp
801024f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024fe:	eb e5                	jmp    801024e5 <dirlink+0x85>
      panic("dirlink read");
80102500:	83 ec 0c             	sub    $0xc,%esp
80102503:	68 c0 7a 10 80       	push   $0x80107ac0
80102508:	e8 83 de ff ff       	call   80100390 <panic>
    panic("dirlink");
8010250d:	83 ec 0c             	sub    $0xc,%esp
80102510:	68 ce 80 10 80       	push   $0x801080ce
80102515:	e8 76 de ff ff       	call   80100390 <panic>
8010251a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102520 <namei>:

struct inode*
namei(char *path)
{
80102520:	f3 0f 1e fb          	endbr32 
80102524:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102525:	31 d2                	xor    %edx,%edx
{
80102527:	89 e5                	mov    %esp,%ebp
80102529:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010252c:	8b 45 08             	mov    0x8(%ebp),%eax
8010252f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102532:	e8 29 fd ff ff       	call   80102260 <namex>
}
80102537:	c9                   	leave  
80102538:	c3                   	ret    
80102539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102540 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102540:	f3 0f 1e fb          	endbr32 
80102544:	55                   	push   %ebp
  return namex(path, 1, name);
80102545:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010254a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010254c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010254f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102552:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102553:	e9 08 fd ff ff       	jmp    80102260 <namex>
80102558:	66 90                	xchg   %ax,%ax
8010255a:	66 90                	xchg   %ax,%ax
8010255c:	66 90                	xchg   %ax,%ax
8010255e:	66 90                	xchg   %ax,%ax

80102560 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102569:	85 c0                	test   %eax,%eax
8010256b:	0f 84 b4 00 00 00    	je     80102625 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102571:	8b 70 08             	mov    0x8(%eax),%esi
80102574:	89 c3                	mov    %eax,%ebx
80102576:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010257c:	0f 87 96 00 00 00    	ja     80102618 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102582:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258e:	66 90                	xchg   %ax,%ax
80102590:	89 ca                	mov    %ecx,%edx
80102592:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102593:	83 e0 c0             	and    $0xffffffc0,%eax
80102596:	3c 40                	cmp    $0x40,%al
80102598:	75 f6                	jne    80102590 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801025b7:	89 f0                	mov    %esi,%eax
801025b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025be:	c1 f8 08             	sar    $0x8,%eax
801025c1:	ee                   	out    %al,(%dx)
801025c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025c7:	89 f8                	mov    %edi,%eax
801025c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801025ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801025ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025d3:	c1 e0 04             	shl    $0x4,%eax
801025d6:	83 e0 10             	and    $0x10,%eax
801025d9:	83 c8 e0             	or     $0xffffffe0,%eax
801025dc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801025dd:	f6 03 04             	testb  $0x4,(%ebx)
801025e0:	75 16                	jne    801025f8 <idestart+0x98>
801025e2:	b8 20 00 00 00       	mov    $0x20,%eax
801025e7:	89 ca                	mov    %ecx,%edx
801025e9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
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
  asm volatile("cld; rep outsl" :
80102600:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102605:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102608:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010260d:	fc                   	cld    
8010260e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102610:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102613:	5b                   	pop    %ebx
80102614:	5e                   	pop    %esi
80102615:	5f                   	pop    %edi
80102616:	5d                   	pop    %ebp
80102617:	c3                   	ret    
    panic("incorrect blockno");
80102618:	83 ec 0c             	sub    $0xc,%esp
8010261b:	68 2c 7b 10 80       	push   $0x80107b2c
80102620:	e8 6b dd ff ff       	call   80100390 <panic>
    panic("idestart");
80102625:	83 ec 0c             	sub    $0xc,%esp
80102628:	68 23 7b 10 80       	push   $0x80107b23
8010262d:	e8 5e dd ff ff       	call   80100390 <panic>
80102632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102640 <ideinit>:
{
80102640:	f3 0f 1e fb          	endbr32 
80102644:	55                   	push   %ebp
80102645:	89 e5                	mov    %esp,%ebp
80102647:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010264a:	68 3e 7b 10 80       	push   $0x80107b3e
8010264f:	68 80 b5 10 80       	push   $0x8010b580
80102654:	e8 f7 23 00 00       	call   80104a50 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102659:	58                   	pop    %eax
8010265a:	a1 a0 42 11 80       	mov    0x801142a0,%eax
8010265f:	5a                   	pop    %edx
80102660:	83 e8 01             	sub    $0x1,%eax
80102663:	50                   	push   %eax
80102664:	6a 0e                	push   $0xe
80102666:	e8 b5 02 00 00       	call   80102920 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010266b:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010266e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102673:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102677:	90                   	nop
80102678:	ec                   	in     (%dx),%al
80102679:	83 e0 c0             	and    $0xffffffc0,%eax
8010267c:	3c 40                	cmp    $0x40,%al
8010267e:	75 f8                	jne    80102678 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102680:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102685:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010268a:	ee                   	out    %al,(%dx)
8010268b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102690:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102695:	eb 0e                	jmp    801026a5 <ideinit+0x65>
80102697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010269e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801026a0:	83 e9 01             	sub    $0x1,%ecx
801026a3:	74 0f                	je     801026b4 <ideinit+0x74>
801026a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801026a6:	84 c0                	test   %al,%al
801026a8:	74 f6                	je     801026a0 <ideinit+0x60>
      havedisk1 = 1;
801026aa:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801026b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026be:	ee                   	out    %al,(%dx)
}
801026bf:	c9                   	leave  
801026c0:	c3                   	ret    
801026c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026cf:	90                   	nop

801026d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026d0:	f3 0f 1e fb          	endbr32 
801026d4:	55                   	push   %ebp
801026d5:	89 e5                	mov    %esp,%ebp
801026d7:	57                   	push   %edi
801026d8:	56                   	push   %esi
801026d9:	53                   	push   %ebx
801026da:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026dd:	68 80 b5 10 80       	push   $0x8010b580
801026e2:	e8 e9 24 00 00       	call   80104bd0 <acquire>

  if((b = idequeue) == 0){
801026e7:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801026ed:	83 c4 10             	add    $0x10,%esp
801026f0:	85 db                	test   %ebx,%ebx
801026f2:	74 5f                	je     80102753 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801026f4:	8b 43 58             	mov    0x58(%ebx),%eax
801026f7:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801026fc:	8b 33                	mov    (%ebx),%esi
801026fe:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102704:	75 2b                	jne    80102731 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102706:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010270b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop
80102710:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102711:	89 c1                	mov    %eax,%ecx
80102713:	83 e1 c0             	and    $0xffffffc0,%ecx
80102716:	80 f9 40             	cmp    $0x40,%cl
80102719:	75 f5                	jne    80102710 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010271b:	a8 21                	test   $0x21,%al
8010271d:	75 12                	jne    80102731 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010271f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102722:	b9 80 00 00 00       	mov    $0x80,%ecx
80102727:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010272c:	fc                   	cld    
8010272d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010272f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102731:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102734:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102737:	83 ce 02             	or     $0x2,%esi
8010273a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010273c:	53                   	push   %ebx
8010273d:	e8 9e 1e 00 00       	call   801045e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102742:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102747:	83 c4 10             	add    $0x10,%esp
8010274a:	85 c0                	test   %eax,%eax
8010274c:	74 05                	je     80102753 <ideintr+0x83>
    idestart(idequeue);
8010274e:	e8 0d fe ff ff       	call   80102560 <idestart>
    release(&idelock);
80102753:	83 ec 0c             	sub    $0xc,%esp
80102756:	68 80 b5 10 80       	push   $0x8010b580
8010275b:	e8 30 25 00 00       	call   80104c90 <release>

  release(&idelock);
}
80102760:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102763:	5b                   	pop    %ebx
80102764:	5e                   	pop    %esi
80102765:	5f                   	pop    %edi
80102766:	5d                   	pop    %ebp
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop

80102770 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102770:	f3 0f 1e fb          	endbr32 
80102774:	55                   	push   %ebp
80102775:	89 e5                	mov    %esp,%ebp
80102777:	53                   	push   %ebx
80102778:	83 ec 10             	sub    $0x10,%esp
8010277b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010277e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102781:	50                   	push   %eax
80102782:	e8 69 22 00 00       	call   801049f0 <holdingsleep>
80102787:	83 c4 10             	add    $0x10,%esp
8010278a:	85 c0                	test   %eax,%eax
8010278c:	0f 84 cf 00 00 00    	je     80102861 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102792:	8b 03                	mov    (%ebx),%eax
80102794:	83 e0 06             	and    $0x6,%eax
80102797:	83 f8 02             	cmp    $0x2,%eax
8010279a:	0f 84 b4 00 00 00    	je     80102854 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801027a0:	8b 53 04             	mov    0x4(%ebx),%edx
801027a3:	85 d2                	test   %edx,%edx
801027a5:	74 0d                	je     801027b4 <iderw+0x44>
801027a7:	a1 60 b5 10 80       	mov    0x8010b560,%eax
801027ac:	85 c0                	test   %eax,%eax
801027ae:	0f 84 93 00 00 00    	je     80102847 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027b4:	83 ec 0c             	sub    $0xc,%esp
801027b7:	68 80 b5 10 80       	push   $0x8010b580
801027bc:	e8 0f 24 00 00       	call   80104bd0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027c1:	a1 64 b5 10 80       	mov    0x8010b564,%eax
  b->qnext = 0;
801027c6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027cd:	83 c4 10             	add    $0x10,%esp
801027d0:	85 c0                	test   %eax,%eax
801027d2:	74 6c                	je     80102840 <iderw+0xd0>
801027d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027d8:	89 c2                	mov    %eax,%edx
801027da:	8b 40 58             	mov    0x58(%eax),%eax
801027dd:	85 c0                	test   %eax,%eax
801027df:	75 f7                	jne    801027d8 <iderw+0x68>
801027e1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801027e4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801027e6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
801027ec:	74 42                	je     80102830 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027ee:	8b 03                	mov    (%ebx),%eax
801027f0:	83 e0 06             	and    $0x6,%eax
801027f3:	83 f8 02             	cmp    $0x2,%eax
801027f6:	74 23                	je     8010281b <iderw+0xab>
801027f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ff:	90                   	nop
    sleep(b, &idelock);
80102800:	83 ec 08             	sub    $0x8,%esp
80102803:	68 80 b5 10 80       	push   $0x8010b580
80102808:	53                   	push   %ebx
80102809:	e8 12 1c 00 00       	call   80104420 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010280e:	8b 03                	mov    (%ebx),%eax
80102810:	83 c4 10             	add    $0x10,%esp
80102813:	83 e0 06             	and    $0x6,%eax
80102816:	83 f8 02             	cmp    $0x2,%eax
80102819:	75 e5                	jne    80102800 <iderw+0x90>
  }


  release(&idelock);
8010281b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102825:	c9                   	leave  
  release(&idelock);
80102826:	e9 65 24 00 00       	jmp    80104c90 <release>
8010282b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010282f:	90                   	nop
    idestart(b);
80102830:	89 d8                	mov    %ebx,%eax
80102832:	e8 29 fd ff ff       	call   80102560 <idestart>
80102837:	eb b5                	jmp    801027ee <iderw+0x7e>
80102839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102840:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102845:	eb 9d                	jmp    801027e4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102847:	83 ec 0c             	sub    $0xc,%esp
8010284a:	68 6d 7b 10 80       	push   $0x80107b6d
8010284f:	e8 3c db ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102854:	83 ec 0c             	sub    $0xc,%esp
80102857:	68 58 7b 10 80       	push   $0x80107b58
8010285c:	e8 2f db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102861:	83 ec 0c             	sub    $0xc,%esp
80102864:	68 42 7b 10 80       	push   $0x80107b42
80102869:	e8 22 db ff ff       	call   80100390 <panic>
8010286e:	66 90                	xchg   %ax,%ax

80102870 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102870:	f3 0f 1e fb          	endbr32 
80102874:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102875:	c7 05 d4 3b 11 80 00 	movl   $0xfec00000,0x80113bd4
8010287c:	00 c0 fe 
{
8010287f:	89 e5                	mov    %esp,%ebp
80102881:	56                   	push   %esi
80102882:	53                   	push   %ebx
  ioapic->reg = reg;
80102883:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010288a:	00 00 00 
  return ioapic->data;
8010288d:	8b 15 d4 3b 11 80    	mov    0x80113bd4,%edx
80102893:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102896:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010289c:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801028a2:	0f b6 15 00 3d 11 80 	movzbl 0x80113d00,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028a9:	c1 ee 10             	shr    $0x10,%esi
801028ac:	89 f0                	mov    %esi,%eax
801028ae:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801028b1:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801028b4:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801028b7:	39 c2                	cmp    %eax,%edx
801028b9:	74 16                	je     801028d1 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028bb:	83 ec 0c             	sub    $0xc,%esp
801028be:	68 8c 7b 10 80       	push   $0x80107b8c
801028c3:	e8 f8 df ff ff       	call   801008c0 <cprintf>
801028c8:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
801028ce:	83 c4 10             	add    $0x10,%esp
801028d1:	83 c6 21             	add    $0x21,%esi
{
801028d4:	ba 10 00 00 00       	mov    $0x10,%edx
801028d9:	b8 20 00 00 00       	mov    $0x20,%eax
801028de:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801028e0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801028e2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801028e4:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
801028ea:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801028ed:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801028f3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801028f6:	8d 5a 01             	lea    0x1(%edx),%ebx
801028f9:	83 c2 02             	add    $0x2,%edx
801028fc:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801028fe:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
80102904:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010290b:	39 f0                	cmp    %esi,%eax
8010290d:	75 d1                	jne    801028e0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010290f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102912:	5b                   	pop    %ebx
80102913:	5e                   	pop    %esi
80102914:	5d                   	pop    %ebp
80102915:	c3                   	ret    
80102916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291d:	8d 76 00             	lea    0x0(%esi),%esi

80102920 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102920:	f3 0f 1e fb          	endbr32 
80102924:	55                   	push   %ebp
  ioapic->reg = reg;
80102925:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
{
8010292b:	89 e5                	mov    %esp,%ebp
8010292d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102930:	8d 50 20             	lea    0x20(%eax),%edx
80102933:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102937:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102939:	8b 0d d4 3b 11 80    	mov    0x80113bd4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010293f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102942:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102945:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102948:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010294a:	a1 d4 3b 11 80       	mov    0x80113bd4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010294f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102952:	89 50 10             	mov    %edx,0x10(%eax)
}
80102955:	5d                   	pop    %ebp
80102956:	c3                   	ret    
80102957:	66 90                	xchg   %ax,%ax
80102959:	66 90                	xchg   %ax,%ax
8010295b:	66 90                	xchg   %ax,%ax
8010295d:	66 90                	xchg   %ax,%ax
8010295f:	90                   	nop

80102960 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102960:	f3 0f 1e fb          	endbr32 
80102964:	55                   	push   %ebp
80102965:	89 e5                	mov    %esp,%ebp
80102967:	53                   	push   %ebx
80102968:	83 ec 04             	sub    $0x4,%esp
8010296b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010296e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102974:	75 7a                	jne    801029f0 <kfree+0x90>
80102976:	81 fb 48 6b 11 80    	cmp    $0x80116b48,%ebx
8010297c:	72 72                	jb     801029f0 <kfree+0x90>
8010297e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102984:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102989:	77 65                	ja     801029f0 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010298b:	83 ec 04             	sub    $0x4,%esp
8010298e:	68 00 10 00 00       	push   $0x1000
80102993:	6a 01                	push   $0x1
80102995:	53                   	push   %ebx
80102996:	e8 45 23 00 00       	call   80104ce0 <memset>

  if(kmem.use_lock)
8010299b:	8b 15 14 3c 11 80    	mov    0x80113c14,%edx
801029a1:	83 c4 10             	add    $0x10,%esp
801029a4:	85 d2                	test   %edx,%edx
801029a6:	75 20                	jne    801029c8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801029a8:	a1 18 3c 11 80       	mov    0x80113c18,%eax
801029ad:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801029af:	a1 14 3c 11 80       	mov    0x80113c14,%eax
  kmem.freelist = r;
801029b4:	89 1d 18 3c 11 80    	mov    %ebx,0x80113c18
  if(kmem.use_lock)
801029ba:	85 c0                	test   %eax,%eax
801029bc:	75 22                	jne    801029e0 <kfree+0x80>
    release(&kmem.lock);
}
801029be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029c1:	c9                   	leave  
801029c2:	c3                   	ret    
801029c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029c7:	90                   	nop
    acquire(&kmem.lock);
801029c8:	83 ec 0c             	sub    $0xc,%esp
801029cb:	68 e0 3b 11 80       	push   $0x80113be0
801029d0:	e8 fb 21 00 00       	call   80104bd0 <acquire>
801029d5:	83 c4 10             	add    $0x10,%esp
801029d8:	eb ce                	jmp    801029a8 <kfree+0x48>
801029da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029e0:	c7 45 08 e0 3b 11 80 	movl   $0x80113be0,0x8(%ebp)
}
801029e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ea:	c9                   	leave  
    release(&kmem.lock);
801029eb:	e9 a0 22 00 00       	jmp    80104c90 <release>
    panic("kfree");
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	68 be 7b 10 80       	push   $0x80107bbe
801029f8:	e8 93 d9 ff ff       	call   80100390 <panic>
801029fd:	8d 76 00             	lea    0x0(%esi),%esi

80102a00 <freerange>:
{
80102a00:	f3 0f 1e fb          	endbr32 
80102a04:	55                   	push   %ebp
80102a05:	89 e5                	mov    %esp,%ebp
80102a07:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a08:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a0b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a0e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a0f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a15:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a1b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a21:	39 de                	cmp    %ebx,%esi
80102a23:	72 1f                	jb     80102a44 <freerange+0x44>
80102a25:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102a28:	83 ec 0c             	sub    $0xc,%esp
80102a2b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a31:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a37:	50                   	push   %eax
80102a38:	e8 23 ff ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a3d:	83 c4 10             	add    $0x10,%esp
80102a40:	39 f3                	cmp    %esi,%ebx
80102a42:	76 e4                	jbe    80102a28 <freerange+0x28>
}
80102a44:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a47:	5b                   	pop    %ebx
80102a48:	5e                   	pop    %esi
80102a49:	5d                   	pop    %ebp
80102a4a:	c3                   	ret    
80102a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a4f:	90                   	nop

80102a50 <kinit1>:
{
80102a50:	f3 0f 1e fb          	endbr32 
80102a54:	55                   	push   %ebp
80102a55:	89 e5                	mov    %esp,%ebp
80102a57:	56                   	push   %esi
80102a58:	53                   	push   %ebx
80102a59:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102a5c:	83 ec 08             	sub    $0x8,%esp
80102a5f:	68 c4 7b 10 80       	push   $0x80107bc4
80102a64:	68 e0 3b 11 80       	push   $0x80113be0
80102a69:	e8 e2 1f 00 00       	call   80104a50 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a71:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a74:	c7 05 14 3c 11 80 00 	movl   $0x0,0x80113c14
80102a7b:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102a7e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a84:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a90:	39 de                	cmp    %ebx,%esi
80102a92:	72 20                	jb     80102ab4 <kinit1+0x64>
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a98:	83 ec 0c             	sub    $0xc,%esp
80102a9b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aa1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102aa7:	50                   	push   %eax
80102aa8:	e8 b3 fe ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aad:	83 c4 10             	add    $0x10,%esp
80102ab0:	39 de                	cmp    %ebx,%esi
80102ab2:	73 e4                	jae    80102a98 <kinit1+0x48>
}
80102ab4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ab7:	5b                   	pop    %ebx
80102ab8:	5e                   	pop    %esi
80102ab9:	5d                   	pop    %ebp
80102aba:	c3                   	ret    
80102abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102abf:	90                   	nop

80102ac0 <kinit2>:
{
80102ac0:	f3 0f 1e fb          	endbr32 
80102ac4:	55                   	push   %ebp
80102ac5:	89 e5                	mov    %esp,%ebp
80102ac7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102ac8:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102acb:	8b 75 0c             	mov    0xc(%ebp),%esi
80102ace:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102acf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ad5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102adb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ae1:	39 de                	cmp    %ebx,%esi
80102ae3:	72 1f                	jb     80102b04 <kinit2+0x44>
80102ae5:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102ae8:	83 ec 0c             	sub    $0xc,%esp
80102aeb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102af1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102af7:	50                   	push   %eax
80102af8:	e8 63 fe ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102afd:	83 c4 10             	add    $0x10,%esp
80102b00:	39 de                	cmp    %ebx,%esi
80102b02:	73 e4                	jae    80102ae8 <kinit2+0x28>
  kmem.use_lock = 1;
80102b04:	c7 05 14 3c 11 80 01 	movl   $0x1,0x80113c14
80102b0b:	00 00 00 
}
80102b0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b11:	5b                   	pop    %ebx
80102b12:	5e                   	pop    %esi
80102b13:	5d                   	pop    %ebp
80102b14:	c3                   	ret    
80102b15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b20:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102b24:	a1 14 3c 11 80       	mov    0x80113c14,%eax
80102b29:	85 c0                	test   %eax,%eax
80102b2b:	75 1b                	jne    80102b48 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b2d:	a1 18 3c 11 80       	mov    0x80113c18,%eax
  if(r)
80102b32:	85 c0                	test   %eax,%eax
80102b34:	74 0a                	je     80102b40 <kalloc+0x20>
    kmem.freelist = r->next;
80102b36:	8b 10                	mov    (%eax),%edx
80102b38:	89 15 18 3c 11 80    	mov    %edx,0x80113c18
  if(kmem.use_lock)
80102b3e:	c3                   	ret    
80102b3f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102b40:	c3                   	ret    
80102b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102b48:	55                   	push   %ebp
80102b49:	89 e5                	mov    %esp,%ebp
80102b4b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102b4e:	68 e0 3b 11 80       	push   $0x80113be0
80102b53:	e8 78 20 00 00       	call   80104bd0 <acquire>
  r = kmem.freelist;
80102b58:	a1 18 3c 11 80       	mov    0x80113c18,%eax
  if(r)
80102b5d:	8b 15 14 3c 11 80    	mov    0x80113c14,%edx
80102b63:	83 c4 10             	add    $0x10,%esp
80102b66:	85 c0                	test   %eax,%eax
80102b68:	74 08                	je     80102b72 <kalloc+0x52>
    kmem.freelist = r->next;
80102b6a:	8b 08                	mov    (%eax),%ecx
80102b6c:	89 0d 18 3c 11 80    	mov    %ecx,0x80113c18
  if(kmem.use_lock)
80102b72:	85 d2                	test   %edx,%edx
80102b74:	74 16                	je     80102b8c <kalloc+0x6c>
    release(&kmem.lock);
80102b76:	83 ec 0c             	sub    $0xc,%esp
80102b79:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b7c:	68 e0 3b 11 80       	push   $0x80113be0
80102b81:	e8 0a 21 00 00       	call   80104c90 <release>
  return (char*)r;
80102b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102b89:	83 c4 10             	add    $0x10,%esp
}
80102b8c:	c9                   	leave  
80102b8d:	c3                   	ret    
80102b8e:	66 90                	xchg   %ax,%ax

80102b90 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b90:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b94:	ba 64 00 00 00       	mov    $0x64,%edx
80102b99:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102b9a:	a8 01                	test   $0x1,%al
80102b9c:	0f 84 be 00 00 00    	je     80102c60 <kbdgetc+0xd0>
{
80102ba2:	55                   	push   %ebp
80102ba3:	ba 60 00 00 00       	mov    $0x60,%edx
80102ba8:	89 e5                	mov    %esp,%ebp
80102baa:	53                   	push   %ebx
80102bab:	ec                   	in     (%dx),%al
  return data;
80102bac:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx
    return -1;
  data = inb(KBDATAP);
80102bb2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102bb5:	3c e0                	cmp    $0xe0,%al
80102bb7:	74 57                	je     80102c10 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102bb9:	89 d9                	mov    %ebx,%ecx
80102bbb:	83 e1 40             	and    $0x40,%ecx
80102bbe:	84 c0                	test   %al,%al
80102bc0:	78 5e                	js     80102c20 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102bc2:	85 c9                	test   %ecx,%ecx
80102bc4:	74 09                	je     80102bcf <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102bc6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102bc9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102bcc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102bcf:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
  shift ^= togglecode[data];
80102bd6:	0f b6 82 00 7c 10 80 	movzbl -0x7fef8400(%edx),%eax
  shift |= shiftcode[data];
80102bdd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102bdf:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102be1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102be3:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102be9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102bec:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102bef:	8b 04 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%eax
80102bf6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102bfa:	74 0b                	je     80102c07 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102bfc:	8d 50 9f             	lea    -0x61(%eax),%edx
80102bff:	83 fa 19             	cmp    $0x19,%edx
80102c02:	77 44                	ja     80102c48 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c04:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c07:	5b                   	pop    %ebx
80102c08:	5d                   	pop    %ebp
80102c09:	c3                   	ret    
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102c10:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102c13:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c15:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
}
80102c1b:	5b                   	pop    %ebx
80102c1c:	5d                   	pop    %ebp
80102c1d:	c3                   	ret    
80102c1e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102c20:	83 e0 7f             	and    $0x7f,%eax
80102c23:	85 c9                	test   %ecx,%ecx
80102c25:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102c28:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102c2a:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
80102c31:	83 c9 40             	or     $0x40,%ecx
80102c34:	0f b6 c9             	movzbl %cl,%ecx
80102c37:	f7 d1                	not    %ecx
80102c39:	21 d9                	and    %ebx,%ecx
}
80102c3b:	5b                   	pop    %ebx
80102c3c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102c3d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102c43:	c3                   	ret    
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102c48:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102c4b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102c4e:	5b                   	pop    %ebx
80102c4f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102c50:	83 f9 1a             	cmp    $0x1a,%ecx
80102c53:	0f 42 c2             	cmovb  %edx,%eax
}
80102c56:	c3                   	ret    
80102c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c5e:	66 90                	xchg   %ax,%ax
    return -1;
80102c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102c65:	c3                   	ret    
80102c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6d:	8d 76 00             	lea    0x0(%esi),%esi

80102c70 <kbdintr>:

void
kbdintr(void)
{
80102c70:	f3 0f 1e fb          	endbr32 
80102c74:	55                   	push   %ebp
80102c75:	89 e5                	mov    %esp,%ebp
80102c77:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102c7a:	68 90 2b 10 80       	push   $0x80102b90
80102c7f:	e8 ec dd ff ff       	call   80100a70 <consoleintr>
}
80102c84:	83 c4 10             	add    $0x10,%esp
80102c87:	c9                   	leave  
80102c88:	c3                   	ret    
80102c89:	66 90                	xchg   %ax,%ax
80102c8b:	66 90                	xchg   %ax,%ax
80102c8d:	66 90                	xchg   %ax,%ax
80102c8f:	90                   	nop

80102c90 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102c90:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102c94:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102c99:	85 c0                	test   %eax,%eax
80102c9b:	0f 84 c7 00 00 00    	je     80102d68 <lapicinit+0xd8>
  lapic[index] = value;
80102ca1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102ca8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cab:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cae:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102cb5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cb8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cbb:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102cc2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102cc5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cc8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102ccf:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102cd2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cd5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102cdc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102cdf:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ce2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102ce9:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102cec:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102cef:	8b 50 30             	mov    0x30(%eax),%edx
80102cf2:	c1 ea 10             	shr    $0x10,%edx
80102cf5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102cfb:	75 73                	jne    80102d70 <lapicinit+0xe0>
  lapic[index] = value;
80102cfd:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d04:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d07:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d0a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d11:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d14:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d17:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d1e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d21:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d24:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d2b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d31:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d38:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d3b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d3e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d45:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102d48:	8b 50 20             	mov    0x20(%eax),%edx
80102d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d4f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102d50:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d56:	80 e6 10             	and    $0x10,%dh
80102d59:	75 f5                	jne    80102d50 <lapicinit+0xc0>
  lapic[index] = value;
80102d5b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d62:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d65:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102d68:	c3                   	ret    
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102d70:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102d77:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d7a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102d7d:	e9 7b ff ff ff       	jmp    80102cfd <lapicinit+0x6d>
80102d82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <lapicid>:

int
lapicid(void)
{
80102d90:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102d94:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102d99:	85 c0                	test   %eax,%eax
80102d9b:	74 0b                	je     80102da8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102d9d:	8b 40 20             	mov    0x20(%eax),%eax
80102da0:	c1 e8 18             	shr    $0x18,%eax
80102da3:	c3                   	ret    
80102da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102da8:	31 c0                	xor    %eax,%eax
}
80102daa:	c3                   	ret    
80102dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102daf:	90                   	nop

80102db0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102db0:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102db4:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102db9:	85 c0                	test   %eax,%eax
80102dbb:	74 0d                	je     80102dca <lapiceoi+0x1a>
  lapic[index] = value;
80102dbd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102dc4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dc7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102dca:	c3                   	ret    
80102dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dcf:	90                   	nop

80102dd0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102dd0:	f3 0f 1e fb          	endbr32 
}
80102dd4:	c3                   	ret    
80102dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102de0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102de0:	f3 0f 1e fb          	endbr32 
80102de4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e04:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102e06:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e09:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e0f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e11:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102e14:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102e16:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e19:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e1c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102e22:	a1 1c 3c 11 80       	mov    0x80113c1c,%eax
80102e27:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e2d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e30:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e37:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e3a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e3d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e44:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e47:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e4a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e50:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e53:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e59:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e5c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e62:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e65:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102e6b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102e6c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102e6f:	5d                   	pop    %ebp
80102e70:	c3                   	ret    
80102e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7f:	90                   	nop

80102e80 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e98:	ba 71 00 00 00       	mov    $0x71,%edx
80102e9d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102e9e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ea1:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ea6:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eb0:	31 c0                	xor    %eax,%eax
80102eb2:	89 da                	mov    %ebx,%edx
80102eb4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eb5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102eba:	89 ca                	mov    %ecx,%edx
80102ebc:	ec                   	in     (%dx),%al
80102ebd:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ec0:	89 da                	mov    %ebx,%edx
80102ec2:	b8 02 00 00 00       	mov    $0x2,%eax
80102ec7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ec8:	89 ca                	mov    %ecx,%edx
80102eca:	ec                   	in     (%dx),%al
80102ecb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ece:	89 da                	mov    %ebx,%edx
80102ed0:	b8 04 00 00 00       	mov    $0x4,%eax
80102ed5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ed6:	89 ca                	mov    %ecx,%edx
80102ed8:	ec                   	in     (%dx),%al
80102ed9:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102edc:	89 da                	mov    %ebx,%edx
80102ede:	b8 07 00 00 00       	mov    $0x7,%eax
80102ee3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee4:	89 ca                	mov    %ecx,%edx
80102ee6:	ec                   	in     (%dx),%al
80102ee7:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eea:	89 da                	mov    %ebx,%edx
80102eec:	b8 08 00 00 00       	mov    $0x8,%eax
80102ef1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ef2:	89 ca                	mov    %ecx,%edx
80102ef4:	ec                   	in     (%dx),%al
80102ef5:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef7:	89 da                	mov    %ebx,%edx
80102ef9:	b8 09 00 00 00       	mov    $0x9,%eax
80102efe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eff:	89 ca                	mov    %ecx,%edx
80102f01:	ec                   	in     (%dx),%al
80102f02:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f04:	89 da                	mov    %ebx,%edx
80102f06:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f0b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f0c:	89 ca                	mov    %ecx,%edx
80102f0e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f0f:	84 c0                	test   %al,%al
80102f11:	78 9d                	js     80102eb0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102f13:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f17:	89 fa                	mov    %edi,%edx
80102f19:	0f b6 fa             	movzbl %dl,%edi
80102f1c:	89 f2                	mov    %esi,%edx
80102f1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f21:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f25:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f44:	89 ca                	mov    %ecx,%edx
80102f46:	ec                   	in     (%dx),%al
80102f47:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f4a:	89 da                	mov    %ebx,%edx
80102f4c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f4f:	b8 02 00 00 00       	mov    $0x2,%eax
80102f54:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f55:	89 ca                	mov    %ecx,%edx
80102f57:	ec                   	in     (%dx),%al
80102f58:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f5b:	89 da                	mov    %ebx,%edx
80102f5d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102f60:	b8 04 00 00 00       	mov    $0x4,%eax
80102f65:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f66:	89 ca                	mov    %ecx,%edx
80102f68:	ec                   	in     (%dx),%al
80102f69:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6c:	89 da                	mov    %ebx,%edx
80102f6e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f71:	b8 07 00 00 00       	mov    $0x7,%eax
80102f76:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f77:	89 ca                	mov    %ecx,%edx
80102f79:	ec                   	in     (%dx),%al
80102f7a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f7d:	89 da                	mov    %ebx,%edx
80102f7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f82:	b8 08 00 00 00       	mov    $0x8,%eax
80102f87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f88:	89 ca                	mov    %ecx,%edx
80102f8a:	ec                   	in     (%dx),%al
80102f8b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f8e:	89 da                	mov    %ebx,%edx
80102f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102f93:	b8 09 00 00 00       	mov    $0x9,%eax
80102f98:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f99:	89 ca                	mov    %ecx,%edx
80102f9b:	ec                   	in     (%dx),%al
80102f9c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102f9f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102fa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102fa5:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102fa8:	6a 18                	push   $0x18
80102faa:	50                   	push   %eax
80102fab:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102fae:	50                   	push   %eax
80102faf:	e8 7c 1d 00 00       	call   80104d30 <memcmp>
80102fb4:	83 c4 10             	add    $0x10,%esp
80102fb7:	85 c0                	test   %eax,%eax
80102fb9:	0f 85 f1 fe ff ff    	jne    80102eb0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102fbf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102fc3:	75 78                	jne    8010303d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102fc5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fc8:	89 c2                	mov    %eax,%edx
80102fca:	83 e0 0f             	and    $0xf,%eax
80102fcd:	c1 ea 04             	shr    $0x4,%edx
80102fd0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fd3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fd6:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102fd9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102fdc:	89 c2                	mov    %eax,%edx
80102fde:	83 e0 0f             	and    $0xf,%eax
80102fe1:	c1 ea 04             	shr    $0x4,%edx
80102fe4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fe7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fea:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102fed:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ff0:	89 c2                	mov    %eax,%edx
80102ff2:	83 e0 0f             	and    $0xf,%eax
80102ff5:	c1 ea 04             	shr    $0x4,%edx
80102ff8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ffb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ffe:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103001:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103004:	89 c2                	mov    %eax,%edx
80103006:	83 e0 0f             	and    $0xf,%eax
80103009:	c1 ea 04             	shr    $0x4,%edx
8010300c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010300f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103012:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103015:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103018:	89 c2                	mov    %eax,%edx
8010301a:	83 e0 0f             	and    $0xf,%eax
8010301d:	c1 ea 04             	shr    $0x4,%edx
80103020:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103023:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103026:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103029:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010302c:	89 c2                	mov    %eax,%edx
8010302e:	83 e0 0f             	and    $0xf,%eax
80103031:	c1 ea 04             	shr    $0x4,%edx
80103034:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103037:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010303a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
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
  r->year += 2000;
80103063:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
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
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103080:	8b 0d 68 3c 11 80    	mov    0x80113c68,%ecx
80103086:	85 c9                	test   %ecx,%ecx
80103088:	0f 8e 8a 00 00 00    	jle    80103118 <install_trans+0x98>
{
8010308e:	55                   	push   %ebp
8010308f:	89 e5                	mov    %esp,%ebp
80103091:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103092:	31 ff                	xor    %edi,%edi
{
80103094:	56                   	push   %esi
80103095:	53                   	push   %ebx
80103096:	83 ec 0c             	sub    $0xc,%esp
80103099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801030a0:	a1 54 3c 11 80       	mov    0x80113c54,%eax
801030a5:	83 ec 08             	sub    $0x8,%esp
801030a8:	01 f8                	add    %edi,%eax
801030aa:	83 c0 01             	add    $0x1,%eax
801030ad:	50                   	push   %eax
801030ae:	ff 35 64 3c 11 80    	pushl  0x80113c64
801030b4:	e8 17 d0 ff ff       	call   801000d0 <bread>
801030b9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030bb:	58                   	pop    %eax
801030bc:	5a                   	pop    %edx
801030bd:	ff 34 bd 6c 3c 11 80 	pushl  -0x7feec394(,%edi,4)
801030c4:	ff 35 64 3c 11 80    	pushl  0x80113c64
  for (tail = 0; tail < log.lh.n; tail++) {
801030ca:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030cd:	e8 fe cf ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030d2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030d5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030d7:	8d 46 5c             	lea    0x5c(%esi),%eax
801030da:	68 00 02 00 00       	push   $0x200
801030df:	50                   	push   %eax
801030e0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801030e3:	50                   	push   %eax
801030e4:	e8 97 1c 00 00       	call   80104d80 <memmove>
    bwrite(dbuf);  // write dst to disk
801030e9:	89 1c 24             	mov    %ebx,(%esp)
801030ec:	e8 bf d0 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801030f1:	89 34 24             	mov    %esi,(%esp)
801030f4:	e8 f7 d0 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801030f9:	89 1c 24             	mov    %ebx,(%esp)
801030fc:	e8 ef d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103101:	83 c4 10             	add    $0x10,%esp
80103104:	39 3d 68 3c 11 80    	cmp    %edi,0x80113c68
8010310a:	7f 94                	jg     801030a0 <install_trans+0x20>
  }
}
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
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	53                   	push   %ebx
80103124:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103127:	ff 35 54 3c 11 80    	pushl  0x80113c54
8010312d:	ff 35 64 3c 11 80    	pushl  0x80113c64
80103133:	e8 98 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103138:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010313b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010313d:	a1 68 3c 11 80       	mov    0x80113c68,%eax
80103142:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103145:	85 c0                	test   %eax,%eax
80103147:	7e 19                	jle    80103162 <write_head+0x42>
80103149:	31 d2                	xor    %edx,%edx
8010314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010314f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103150:	8b 0c 95 6c 3c 11 80 	mov    -0x7feec394(,%edx,4),%ecx
80103157:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010315b:	83 c2 01             	add    $0x1,%edx
8010315e:	39 d0                	cmp    %edx,%eax
80103160:	75 ee                	jne    80103150 <write_head+0x30>
  }
  bwrite(buf);
80103162:	83 ec 0c             	sub    $0xc,%esp
80103165:	53                   	push   %ebx
80103166:	e8 45 d0 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010316b:	89 1c 24             	mov    %ebx,(%esp)
8010316e:	e8 7d d0 ff ff       	call   801001f0 <brelse>
}
80103173:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103176:	83 c4 10             	add    $0x10,%esp
80103179:	c9                   	leave  
8010317a:	c3                   	ret    
8010317b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010317f:	90                   	nop

80103180 <initlog>:
{
80103180:	f3 0f 1e fb          	endbr32 
80103184:	55                   	push   %ebp
80103185:	89 e5                	mov    %esp,%ebp
80103187:	53                   	push   %ebx
80103188:	83 ec 2c             	sub    $0x2c,%esp
8010318b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010318e:	68 00 7e 10 80       	push   $0x80107e00
80103193:	68 20 3c 11 80       	push   $0x80113c20
80103198:	e8 b3 18 00 00       	call   80104a50 <initlock>
  readsb(dev, &sb);
8010319d:	58                   	pop    %eax
8010319e:	8d 45 dc             	lea    -0x24(%ebp),%eax
801031a1:	5a                   	pop    %edx
801031a2:	50                   	push   %eax
801031a3:	53                   	push   %ebx
801031a4:	e8 47 e8 ff ff       	call   801019f0 <readsb>
  log.start = sb.logstart;
801031a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801031ac:	59                   	pop    %ecx
  log.dev = dev;
801031ad:	89 1d 64 3c 11 80    	mov    %ebx,0x80113c64
  log.size = sb.nlog;
801031b3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801031b6:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  log.size = sb.nlog;
801031bb:	89 15 58 3c 11 80    	mov    %edx,0x80113c58
  struct buf *buf = bread(log.dev, log.start);
801031c1:	5a                   	pop    %edx
801031c2:	50                   	push   %eax
801031c3:	53                   	push   %ebx
801031c4:	e8 07 cf ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801031c9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801031cc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801031cf:	89 0d 68 3c 11 80    	mov    %ecx,0x80113c68
  for (i = 0; i < log.lh.n; i++) {
801031d5:	85 c9                	test   %ecx,%ecx
801031d7:	7e 19                	jle    801031f2 <initlog+0x72>
801031d9:	31 d2                	xor    %edx,%edx
801031db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031df:	90                   	nop
    log.lh.block[i] = lh->block[i];
801031e0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801031e4:	89 1c 95 6c 3c 11 80 	mov    %ebx,-0x7feec394(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801031eb:	83 c2 01             	add    $0x1,%edx
801031ee:	39 d1                	cmp    %edx,%ecx
801031f0:	75 ee                	jne    801031e0 <initlog+0x60>
  brelse(buf);
801031f2:	83 ec 0c             	sub    $0xc,%esp
801031f5:	50                   	push   %eax
801031f6:	e8 f5 cf ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801031fb:	e8 80 fe ff ff       	call   80103080 <install_trans>
  log.lh.n = 0;
80103200:	c7 05 68 3c 11 80 00 	movl   $0x0,0x80113c68
80103207:	00 00 00 
  write_head(); // clear the log
8010320a:	e8 11 ff ff ff       	call   80103120 <write_head>
}
8010320f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103212:	83 c4 10             	add    $0x10,%esp
80103215:	c9                   	leave  
80103216:	c3                   	ret    
80103217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010321e:	66 90                	xchg   %ax,%ax

80103220 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103220:	f3 0f 1e fb          	endbr32 
80103224:	55                   	push   %ebp
80103225:	89 e5                	mov    %esp,%ebp
80103227:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010322a:	68 20 3c 11 80       	push   $0x80113c20
8010322f:	e8 9c 19 00 00       	call   80104bd0 <acquire>
80103234:	83 c4 10             	add    $0x10,%esp
80103237:	eb 1c                	jmp    80103255 <begin_op+0x35>
80103239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103240:	83 ec 08             	sub    $0x8,%esp
80103243:	68 20 3c 11 80       	push   $0x80113c20
80103248:	68 20 3c 11 80       	push   $0x80113c20
8010324d:	e8 ce 11 00 00       	call   80104420 <sleep>
80103252:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103255:	a1 60 3c 11 80       	mov    0x80113c60,%eax
8010325a:	85 c0                	test   %eax,%eax
8010325c:	75 e2                	jne    80103240 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010325e:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
80103263:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
80103269:	83 c0 01             	add    $0x1,%eax
8010326c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010326f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103272:	83 fa 1e             	cmp    $0x1e,%edx
80103275:	7f c9                	jg     80103240 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103277:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
8010327a:	a3 5c 3c 11 80       	mov    %eax,0x80113c5c
      release(&log.lock);
8010327f:	68 20 3c 11 80       	push   $0x80113c20
80103284:	e8 07 1a 00 00       	call   80104c90 <release>
      break;
    }
  }
}
80103289:	83 c4 10             	add    $0x10,%esp
8010328c:	c9                   	leave  
8010328d:	c3                   	ret    
8010328e:	66 90                	xchg   %ax,%ax

80103290 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103290:	f3 0f 1e fb          	endbr32 
80103294:	55                   	push   %ebp
80103295:	89 e5                	mov    %esp,%ebp
80103297:	57                   	push   %edi
80103298:	56                   	push   %esi
80103299:	53                   	push   %ebx
8010329a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
8010329d:	68 20 3c 11 80       	push   $0x80113c20
801032a2:	e8 29 19 00 00       	call   80104bd0 <acquire>
  log.outstanding -= 1;
801032a7:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
  if(log.committing)
801032ac:	8b 35 60 3c 11 80    	mov    0x80113c60,%esi
801032b2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801032b5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032b8:	89 1d 5c 3c 11 80    	mov    %ebx,0x80113c5c
  if(log.committing)
801032be:	85 f6                	test   %esi,%esi
801032c0:	0f 85 1e 01 00 00    	jne    801033e4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801032c6:	85 db                	test   %ebx,%ebx
801032c8:	0f 85 f2 00 00 00    	jne    801033c0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801032ce:	c7 05 60 3c 11 80 01 	movl   $0x1,0x80113c60
801032d5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801032d8:	83 ec 0c             	sub    $0xc,%esp
801032db:	68 20 3c 11 80       	push   $0x80113c20
801032e0:	e8 ab 19 00 00       	call   80104c90 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801032e5:	8b 0d 68 3c 11 80    	mov    0x80113c68,%ecx
801032eb:	83 c4 10             	add    $0x10,%esp
801032ee:	85 c9                	test   %ecx,%ecx
801032f0:	7f 3e                	jg     80103330 <end_op+0xa0>
    acquire(&log.lock);
801032f2:	83 ec 0c             	sub    $0xc,%esp
801032f5:	68 20 3c 11 80       	push   $0x80113c20
801032fa:	e8 d1 18 00 00       	call   80104bd0 <acquire>
    wakeup(&log);
801032ff:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
    log.committing = 0;
80103306:	c7 05 60 3c 11 80 00 	movl   $0x0,0x80113c60
8010330d:	00 00 00 
    wakeup(&log);
80103310:	e8 cb 12 00 00       	call   801045e0 <wakeup>
    release(&log.lock);
80103315:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
8010331c:	e8 6f 19 00 00       	call   80104c90 <release>
80103321:	83 c4 10             	add    $0x10,%esp
}
80103324:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103327:	5b                   	pop    %ebx
80103328:	5e                   	pop    %esi
80103329:	5f                   	pop    %edi
8010332a:	5d                   	pop    %ebp
8010332b:	c3                   	ret    
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103330:	a1 54 3c 11 80       	mov    0x80113c54,%eax
80103335:	83 ec 08             	sub    $0x8,%esp
80103338:	01 d8                	add    %ebx,%eax
8010333a:	83 c0 01             	add    $0x1,%eax
8010333d:	50                   	push   %eax
8010333e:	ff 35 64 3c 11 80    	pushl  0x80113c64
80103344:	e8 87 cd ff ff       	call   801000d0 <bread>
80103349:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010334b:	58                   	pop    %eax
8010334c:	5a                   	pop    %edx
8010334d:	ff 34 9d 6c 3c 11 80 	pushl  -0x7feec394(,%ebx,4)
80103354:	ff 35 64 3c 11 80    	pushl  0x80113c64
  for (tail = 0; tail < log.lh.n; tail++) {
8010335a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010335d:	e8 6e cd ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103362:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103365:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103367:	8d 40 5c             	lea    0x5c(%eax),%eax
8010336a:	68 00 02 00 00       	push   $0x200
8010336f:	50                   	push   %eax
80103370:	8d 46 5c             	lea    0x5c(%esi),%eax
80103373:	50                   	push   %eax
80103374:	e8 07 1a 00 00       	call   80104d80 <memmove>
    bwrite(to);  // write the log
80103379:	89 34 24             	mov    %esi,(%esp)
8010337c:	e8 2f ce ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103381:	89 3c 24             	mov    %edi,(%esp)
80103384:	e8 67 ce ff ff       	call   801001f0 <brelse>
    brelse(to);
80103389:	89 34 24             	mov    %esi,(%esp)
8010338c:	e8 5f ce ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103391:	83 c4 10             	add    $0x10,%esp
80103394:	3b 1d 68 3c 11 80    	cmp    0x80113c68,%ebx
8010339a:	7c 94                	jl     80103330 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010339c:	e8 7f fd ff ff       	call   80103120 <write_head>
    install_trans(); // Now install writes to home locations
801033a1:	e8 da fc ff ff       	call   80103080 <install_trans>
    log.lh.n = 0;
801033a6:	c7 05 68 3c 11 80 00 	movl   $0x0,0x80113c68
801033ad:	00 00 00 
    write_head();    // Erase the transaction from the log
801033b0:	e8 6b fd ff ff       	call   80103120 <write_head>
801033b5:	e9 38 ff ff ff       	jmp    801032f2 <end_op+0x62>
801033ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	68 20 3c 11 80       	push   $0x80113c20
801033c8:	e8 13 12 00 00       	call   801045e0 <wakeup>
  release(&log.lock);
801033cd:	c7 04 24 20 3c 11 80 	movl   $0x80113c20,(%esp)
801033d4:	e8 b7 18 00 00       	call   80104c90 <release>
801033d9:	83 c4 10             	add    $0x10,%esp
}
801033dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033df:	5b                   	pop    %ebx
801033e0:	5e                   	pop    %esi
801033e1:	5f                   	pop    %edi
801033e2:	5d                   	pop    %ebp
801033e3:	c3                   	ret    
    panic("log.committing");
801033e4:	83 ec 0c             	sub    $0xc,%esp
801033e7:	68 04 7e 10 80       	push   $0x80107e04
801033ec:	e8 9f cf ff ff       	call   80100390 <panic>
801033f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ff:	90                   	nop

80103400 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103400:	f3 0f 1e fb          	endbr32 
80103404:	55                   	push   %ebp
80103405:	89 e5                	mov    %esp,%ebp
80103407:	53                   	push   %ebx
80103408:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010340b:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
{
80103411:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103414:	83 fa 1d             	cmp    $0x1d,%edx
80103417:	0f 8f 91 00 00 00    	jg     801034ae <log_write+0xae>
8010341d:	a1 58 3c 11 80       	mov    0x80113c58,%eax
80103422:	83 e8 01             	sub    $0x1,%eax
80103425:	39 c2                	cmp    %eax,%edx
80103427:	0f 8d 81 00 00 00    	jge    801034ae <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010342d:	a1 5c 3c 11 80       	mov    0x80113c5c,%eax
80103432:	85 c0                	test   %eax,%eax
80103434:	0f 8e 81 00 00 00    	jle    801034bb <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010343a:	83 ec 0c             	sub    $0xc,%esp
8010343d:	68 20 3c 11 80       	push   $0x80113c20
80103442:	e8 89 17 00 00       	call   80104bd0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103447:	8b 15 68 3c 11 80    	mov    0x80113c68,%edx
8010344d:	83 c4 10             	add    $0x10,%esp
80103450:	85 d2                	test   %edx,%edx
80103452:	7e 4e                	jle    801034a2 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103454:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103457:	31 c0                	xor    %eax,%eax
80103459:	eb 0c                	jmp    80103467 <log_write+0x67>
8010345b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010345f:	90                   	nop
80103460:	83 c0 01             	add    $0x1,%eax
80103463:	39 c2                	cmp    %eax,%edx
80103465:	74 29                	je     80103490 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103467:	39 0c 85 6c 3c 11 80 	cmp    %ecx,-0x7feec394(,%eax,4)
8010346e:	75 f0                	jne    80103460 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103470:	89 0c 85 6c 3c 11 80 	mov    %ecx,-0x7feec394(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103477:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010347a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010347d:	c7 45 08 20 3c 11 80 	movl   $0x80113c20,0x8(%ebp)
}
80103484:	c9                   	leave  
  release(&log.lock);
80103485:	e9 06 18 00 00       	jmp    80104c90 <release>
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103490:	89 0c 95 6c 3c 11 80 	mov    %ecx,-0x7feec394(,%edx,4)
    log.lh.n++;
80103497:	83 c2 01             	add    $0x1,%edx
8010349a:	89 15 68 3c 11 80    	mov    %edx,0x80113c68
801034a0:	eb d5                	jmp    80103477 <log_write+0x77>
  log.lh.block[i] = b->blockno;
801034a2:	8b 43 08             	mov    0x8(%ebx),%eax
801034a5:	a3 6c 3c 11 80       	mov    %eax,0x80113c6c
  if (i == log.lh.n)
801034aa:	75 cb                	jne    80103477 <log_write+0x77>
801034ac:	eb e9                	jmp    80103497 <log_write+0x97>
    panic("too big a transaction");
801034ae:	83 ec 0c             	sub    $0xc,%esp
801034b1:	68 13 7e 10 80       	push   $0x80107e13
801034b6:	e8 d5 ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	68 29 7e 10 80       	push   $0x80107e29
801034c3:	e8 c8 ce ff ff       	call   80100390 <panic>
801034c8:	66 90                	xchg   %ax,%ax
801034ca:	66 90                	xchg   %ax,%ax
801034cc:	66 90                	xchg   %ax,%ax
801034ce:	66 90                	xchg   %ax,%ax

801034d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	53                   	push   %ebx
801034d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801034d7:	e8 64 09 00 00       	call   80103e40 <cpuid>
801034dc:	89 c3                	mov    %eax,%ebx
801034de:	e8 5d 09 00 00       	call   80103e40 <cpuid>
801034e3:	83 ec 04             	sub    $0x4,%esp
801034e6:	53                   	push   %ebx
801034e7:	50                   	push   %eax
801034e8:	68 44 7e 10 80       	push   $0x80107e44
801034ed:	e8 ce d3 ff ff       	call   801008c0 <cprintf>
  idtinit();       // load idt register
801034f2:	e8 49 2c 00 00       	call   80106140 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801034f7:	e8 d4 08 00 00       	call   80103dd0 <mycpu>
801034fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801034fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103503:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010350a:	e8 21 0c 00 00       	call   80104130 <scheduler>
8010350f:	90                   	nop

80103510 <mpenter>:
{
80103510:	f3 0f 1e fb          	endbr32 
80103514:	55                   	push   %ebp
80103515:	89 e5                	mov    %esp,%ebp
80103517:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010351a:	e8 f1 3c 00 00       	call   80107210 <switchkvm>
  seginit();
8010351f:	e8 5c 3c 00 00       	call   80107180 <seginit>
  lapicinit();
80103524:	e8 67 f7 ff ff       	call   80102c90 <lapicinit>
  mpmain();
80103529:	e8 a2 ff ff ff       	call   801034d0 <mpmain>
8010352e:	66 90                	xchg   %ax,%ax

80103530 <main>:
{
80103530:	f3 0f 1e fb          	endbr32 
80103534:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103538:	83 e4 f0             	and    $0xfffffff0,%esp
8010353b:	ff 71 fc             	pushl  -0x4(%ecx)
8010353e:	55                   	push   %ebp
8010353f:	89 e5                	mov    %esp,%ebp
80103541:	53                   	push   %ebx
80103542:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103543:	83 ec 08             	sub    $0x8,%esp
80103546:	68 00 00 40 80       	push   $0x80400000
8010354b:	68 48 6b 11 80       	push   $0x80116b48
80103550:	e8 fb f4 ff ff       	call   80102a50 <kinit1>
  kvmalloc();      // kernel page table
80103555:	e8 96 41 00 00       	call   801076f0 <kvmalloc>
  mpinit();        // detect other processors
8010355a:	e8 81 01 00 00       	call   801036e0 <mpinit>
  lapicinit();     // interrupt controller
8010355f:	e8 2c f7 ff ff       	call   80102c90 <lapicinit>
  seginit();       // segment descriptors
80103564:	e8 17 3c 00 00       	call   80107180 <seginit>
  picinit();       // disable pic
80103569:	e8 52 03 00 00       	call   801038c0 <picinit>
  ioapicinit();    // another interrupt controller
8010356e:	e8 fd f2 ff ff       	call   80102870 <ioapicinit>
  consoleinit();   // console hardware
80103573:	e8 a8 d9 ff ff       	call   80100f20 <consoleinit>
  uartinit();      // serial port
80103578:	e8 c3 2e 00 00       	call   80106440 <uartinit>
  pinit();         // process table
8010357d:	e8 2e 08 00 00       	call   80103db0 <pinit>
  tvinit();        // trap vectors
80103582:	e8 39 2b 00 00       	call   801060c0 <tvinit>
  binit();         // buffer cache
80103587:	e8 b4 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010358c:	e8 3f dd ff ff       	call   801012d0 <fileinit>
  ideinit();       // disk 
80103591:	e8 aa f0 ff ff       	call   80102640 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103596:	83 c4 0c             	add    $0xc,%esp
80103599:	68 8a 00 00 00       	push   $0x8a
8010359e:	68 8c b4 10 80       	push   $0x8010b48c
801035a3:	68 00 70 00 80       	push   $0x80007000
801035a8:	e8 d3 17 00 00       	call   80104d80 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
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
    if(c == mycpu())  // We've started already.
801035e9:	e8 e2 07 00 00       	call   80103dd0 <mycpu>
801035ee:	39 c3                	cmp    %eax,%ebx
801035f0:	74 de                	je     801035d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801035f2:	e8 29 f5 ff ff       	call   80102b20 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801035f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801035fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103510,0x80006ff8
80103601:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103604:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010360b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010360e:	05 00 10 00 00       	add    $0x1000,%eax
80103613:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103618:	0f b6 03             	movzbl (%ebx),%eax
8010361b:	68 00 70 00 00       	push   $0x7000
80103620:	50                   	push   %eax
80103621:	e8 ba f7 ff ff       	call   80102de0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103626:	83 c4 10             	add    $0x10,%esp
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103630:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103636:	85 c0                	test   %eax,%eax
80103638:	74 f6                	je     80103630 <main+0x100>
8010363a:	eb 94                	jmp    801035d0 <main+0xa0>
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103640:	83 ec 08             	sub    $0x8,%esp
80103643:	68 00 00 00 8e       	push   $0x8e000000
80103648:	68 00 00 40 80       	push   $0x80400000
8010364d:	e8 6e f4 ff ff       	call   80102ac0 <kinit2>
  userinit();      // first user process
80103652:	e8 39 08 00 00       	call   80103e90 <userinit>
  mpmain();        // finish this processor's setup
80103657:	e8 74 fe ff ff       	call   801034d0 <mpmain>
8010365c:	66 90                	xchg   %ax,%ax
8010365e:	66 90                	xchg   %ax,%ax

80103660 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	57                   	push   %edi
80103664:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103665:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010366b:	53                   	push   %ebx
  e = addr+len;
8010366c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010366f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103672:	39 de                	cmp    %ebx,%esi
80103674:	72 10                	jb     80103686 <mpsearch1+0x26>
80103676:	eb 50                	jmp    801036c8 <mpsearch1+0x68>
80103678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010367f:	90                   	nop
80103680:	89 fe                	mov    %edi,%esi
80103682:	39 fb                	cmp    %edi,%ebx
80103684:	76 42                	jbe    801036c8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103686:	83 ec 04             	sub    $0x4,%esp
80103689:	8d 7e 10             	lea    0x10(%esi),%edi
8010368c:	6a 04                	push   $0x4
8010368e:	68 58 7e 10 80       	push   $0x80107e58
80103693:	56                   	push   %esi
80103694:	e8 97 16 00 00       	call   80104d30 <memcmp>
80103699:	83 c4 10             	add    $0x10,%esp
8010369c:	85 c0                	test   %eax,%eax
8010369e:	75 e0                	jne    80103680 <mpsearch1+0x20>
801036a0:	89 f2                	mov    %esi,%edx
801036a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801036a8:	0f b6 0a             	movzbl (%edx),%ecx
801036ab:	83 c2 01             	add    $0x1,%edx
801036ae:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801036b0:	39 fa                	cmp    %edi,%edx
801036b2:	75 f4                	jne    801036a8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036b4:	84 c0                	test   %al,%al
801036b6:	75 c8                	jne    80103680 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801036b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036bb:	89 f0                	mov    %esi,%eax
801036bd:	5b                   	pop    %ebx
801036be:	5e                   	pop    %esi
801036bf:	5f                   	pop    %edi
801036c0:	5d                   	pop    %ebp
801036c1:	c3                   	ret    
801036c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036cb:	31 f6                	xor    %esi,%esi
}
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
  return conf;
}

void
mpinit(void)
{
801036e0:	f3 0f 1e fb          	endbr32 
801036e4:	55                   	push   %ebp
801036e5:	89 e5                	mov    %esp,%ebp
801036e7:	57                   	push   %edi
801036e8:	56                   	push   %esi
801036e9:	53                   	push   %ebx
801036ea:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801036ed:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801036f4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801036fb:	c1 e0 08             	shl    $0x8,%eax
801036fe:	09 d0                	or     %edx,%eax
80103700:	c1 e0 04             	shl    $0x4,%eax
80103703:	75 1b                	jne    80103720 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103705:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010370c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103713:	c1 e0 08             	shl    $0x8,%eax
80103716:	09 d0                	or     %edx,%eax
80103718:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010371b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103720:	ba 00 04 00 00       	mov    $0x400,%edx
80103725:	e8 36 ff ff ff       	call   80103660 <mpsearch1>
8010372a:	89 c6                	mov    %eax,%esi
8010372c:	85 c0                	test   %eax,%eax
8010372e:	0f 84 4c 01 00 00    	je     80103880 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103734:	8b 5e 04             	mov    0x4(%esi),%ebx
80103737:	85 db                	test   %ebx,%ebx
80103739:	0f 84 61 01 00 00    	je     801038a0 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010373f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103742:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103748:	6a 04                	push   $0x4
8010374a:	68 5d 7e 10 80       	push   $0x80107e5d
8010374f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103750:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103753:	e8 d8 15 00 00       	call   80104d30 <memcmp>
80103758:	83 c4 10             	add    $0x10,%esp
8010375b:	85 c0                	test   %eax,%eax
8010375d:	0f 85 3d 01 00 00    	jne    801038a0 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103763:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010376a:	3c 01                	cmp    $0x1,%al
8010376c:	74 08                	je     80103776 <mpinit+0x96>
8010376e:	3c 04                	cmp    $0x4,%al
80103770:	0f 85 2a 01 00 00    	jne    801038a0 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103776:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
8010377d:	66 85 d2             	test   %dx,%dx
80103780:	74 26                	je     801037a8 <mpinit+0xc8>
80103782:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103785:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103787:	31 d2                	xor    %edx,%edx
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103790:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103797:	83 c0 01             	add    $0x1,%eax
8010379a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010379c:	39 f8                	cmp    %edi,%eax
8010379e:	75 f0                	jne    80103790 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801037a0:	84 d2                	test   %dl,%dl
801037a2:	0f 85 f8 00 00 00    	jne    801038a0 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801037a8:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801037ae:	a3 1c 3c 11 80       	mov    %eax,0x80113c1c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037b3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801037b9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
801037c0:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037c5:	03 55 e4             	add    -0x1c(%ebp),%edx
801037c8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
801037d0:	39 c2                	cmp    %eax,%edx
801037d2:	76 15                	jbe    801037e9 <mpinit+0x109>
    switch(*p){
801037d4:	0f b6 08             	movzbl (%eax),%ecx
801037d7:	80 f9 02             	cmp    $0x2,%cl
801037da:	74 5c                	je     80103838 <mpinit+0x158>
801037dc:	77 42                	ja     80103820 <mpinit+0x140>
801037de:	84 c9                	test   %cl,%cl
801037e0:	74 6e                	je     80103850 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801037e2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037e5:	39 c2                	cmp    %eax,%edx
801037e7:	77 eb                	ja     801037d4 <mpinit+0xf4>
801037e9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801037ec:	85 db                	test   %ebx,%ebx
801037ee:	0f 84 b9 00 00 00    	je     801038ad <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801037f4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801037f8:	74 15                	je     8010380f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037fa:	b8 70 00 00 00       	mov    $0x70,%eax
801037ff:	ba 22 00 00 00       	mov    $0x22,%edx
80103804:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103805:	ba 23 00 00 00       	mov    $0x23,%edx
8010380a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010380b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010380e:	ee                   	out    %al,(%dx)
  }
}
8010380f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103812:	5b                   	pop    %ebx
80103813:	5e                   	pop    %esi
80103814:	5f                   	pop    %edi
80103815:	5d                   	pop    %ebp
80103816:	c3                   	ret    
80103817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010381e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103820:	83 e9 03             	sub    $0x3,%ecx
80103823:	80 f9 01             	cmp    $0x1,%cl
80103826:	76 ba                	jbe    801037e2 <mpinit+0x102>
80103828:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010382f:	eb 9f                	jmp    801037d0 <mpinit+0xf0>
80103831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103838:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010383c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010383f:	88 0d 00 3d 11 80    	mov    %cl,0x80113d00
      continue;
80103845:	eb 89                	jmp    801037d0 <mpinit+0xf0>
80103847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010384e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103850:	8b 0d a0 42 11 80    	mov    0x801142a0,%ecx
80103856:	83 f9 07             	cmp    $0x7,%ecx
80103859:	7f 19                	jg     80103874 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010385b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103861:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103865:	83 c1 01             	add    $0x1,%ecx
80103868:	89 0d a0 42 11 80    	mov    %ecx,0x801142a0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010386e:	88 9f 20 3d 11 80    	mov    %bl,-0x7feec2e0(%edi)
      p += sizeof(struct mpproc);
80103874:	83 c0 14             	add    $0x14,%eax
      continue;
80103877:	e9 54 ff ff ff       	jmp    801037d0 <mpinit+0xf0>
8010387c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103880:	ba 00 00 01 00       	mov    $0x10000,%edx
80103885:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010388a:	e8 d1 fd ff ff       	call   80103660 <mpsearch1>
8010388f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103891:	85 c0                	test   %eax,%eax
80103893:	0f 85 9b fe ff ff    	jne    80103734 <mpinit+0x54>
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801038a0:	83 ec 0c             	sub    $0xc,%esp
801038a3:	68 62 7e 10 80       	push   $0x80107e62
801038a8:	e8 e3 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801038ad:	83 ec 0c             	sub    $0xc,%esp
801038b0:	68 7c 7e 10 80       	push   $0x80107e7c
801038b5:	e8 d6 ca ff ff       	call   80100390 <panic>
801038ba:	66 90                	xchg   %ax,%ax
801038bc:	66 90                	xchg   %ax,%ax
801038be:	66 90                	xchg   %ax,%ax

801038c0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801038c0:	f3 0f 1e fb          	endbr32 
801038c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038c9:	ba 21 00 00 00       	mov    $0x21,%edx
801038ce:	ee                   	out    %al,(%dx)
801038cf:	ba a1 00 00 00       	mov    $0xa1,%edx
801038d4:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801038d5:	c3                   	ret    
801038d6:	66 90                	xchg   %ax,%ax
801038d8:	66 90                	xchg   %ax,%ax
801038da:	66 90                	xchg   %ax,%ax
801038dc:	66 90                	xchg   %ax,%ax
801038de:	66 90                	xchg   %ax,%ax

801038e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801038e0:	f3 0f 1e fb          	endbr32 
801038e4:	55                   	push   %ebp
801038e5:	89 e5                	mov    %esp,%ebp
801038e7:	57                   	push   %edi
801038e8:	56                   	push   %esi
801038e9:	53                   	push   %ebx
801038ea:	83 ec 0c             	sub    $0xc,%esp
801038ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038f0:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801038f3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038f9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801038ff:	e8 ec d9 ff ff       	call   801012f0 <filealloc>
80103904:	89 03                	mov    %eax,(%ebx)
80103906:	85 c0                	test   %eax,%eax
80103908:	0f 84 ac 00 00 00    	je     801039ba <pipealloc+0xda>
8010390e:	e8 dd d9 ff ff       	call   801012f0 <filealloc>
80103913:	89 06                	mov    %eax,(%esi)
80103915:	85 c0                	test   %eax,%eax
80103917:	0f 84 8b 00 00 00    	je     801039a8 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010391d:	e8 fe f1 ff ff       	call   80102b20 <kalloc>
80103922:	89 c7                	mov    %eax,%edi
80103924:	85 c0                	test   %eax,%eax
80103926:	0f 84 b4 00 00 00    	je     801039e0 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010392c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103933:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103936:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103939:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103940:	00 00 00 
  p->nwrite = 0;
80103943:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010394a:	00 00 00 
  p->nread = 0;
8010394d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103954:	00 00 00 
  initlock(&p->lock, "pipe");
80103957:	68 9b 7e 10 80       	push   $0x80107e9b
8010395c:	50                   	push   %eax
8010395d:	e8 ee 10 00 00       	call   80104a50 <initlock>
  (*f0)->type = FD_PIPE;
80103962:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103964:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103967:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010396d:	8b 03                	mov    (%ebx),%eax
8010396f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103973:	8b 03                	mov    (%ebx),%eax
80103975:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103979:	8b 03                	mov    (%ebx),%eax
8010397b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010397e:	8b 06                	mov    (%esi),%eax
80103980:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103986:	8b 06                	mov    (%esi),%eax
80103988:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010398c:	8b 06                	mov    (%esi),%eax
8010398e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103992:	8b 06                	mov    (%esi),%eax
80103994:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103997:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010399a:	31 c0                	xor    %eax,%eax
}
8010399c:	5b                   	pop    %ebx
8010399d:	5e                   	pop    %esi
8010399e:	5f                   	pop    %edi
8010399f:	5d                   	pop    %ebp
801039a0:	c3                   	ret    
801039a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801039a8:	8b 03                	mov    (%ebx),%eax
801039aa:	85 c0                	test   %eax,%eax
801039ac:	74 1e                	je     801039cc <pipealloc+0xec>
    fileclose(*f0);
801039ae:	83 ec 0c             	sub    $0xc,%esp
801039b1:	50                   	push   %eax
801039b2:	e8 f9 d9 ff ff       	call   801013b0 <fileclose>
801039b7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801039ba:	8b 06                	mov    (%esi),%eax
801039bc:	85 c0                	test   %eax,%eax
801039be:	74 0c                	je     801039cc <pipealloc+0xec>
    fileclose(*f1);
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	50                   	push   %eax
801039c4:	e8 e7 d9 ff ff       	call   801013b0 <fileclose>
801039c9:	83 c4 10             	add    $0x10,%esp
}
801039cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801039cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801039d4:	5b                   	pop    %ebx
801039d5:	5e                   	pop    %esi
801039d6:	5f                   	pop    %edi
801039d7:	5d                   	pop    %ebp
801039d8:	c3                   	ret    
801039d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801039e0:	8b 03                	mov    (%ebx),%eax
801039e2:	85 c0                	test   %eax,%eax
801039e4:	75 c8                	jne    801039ae <pipealloc+0xce>
801039e6:	eb d2                	jmp    801039ba <pipealloc+0xda>
801039e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039ef:	90                   	nop

801039f0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801039f0:	f3 0f 1e fb          	endbr32 
801039f4:	55                   	push   %ebp
801039f5:	89 e5                	mov    %esp,%ebp
801039f7:	56                   	push   %esi
801039f8:	53                   	push   %ebx
801039f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039fc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	53                   	push   %ebx
80103a03:	e8 c8 11 00 00       	call   80104bd0 <acquire>
  if(writable){
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	85 f6                	test   %esi,%esi
80103a0d:	74 41                	je     80103a50 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a0f:	83 ec 0c             	sub    $0xc,%esp
80103a12:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103a18:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a1f:	00 00 00 
    wakeup(&p->nread);
80103a22:	50                   	push   %eax
80103a23:	e8 b8 0b 00 00       	call   801045e0 <wakeup>
80103a28:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a2b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a31:	85 d2                	test   %edx,%edx
80103a33:	75 0a                	jne    80103a3f <pipeclose+0x4f>
80103a35:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a3b:	85 c0                	test   %eax,%eax
80103a3d:	74 31                	je     80103a70 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a45:	5b                   	pop    %ebx
80103a46:	5e                   	pop    %esi
80103a47:	5d                   	pop    %ebp
    release(&p->lock);
80103a48:	e9 43 12 00 00       	jmp    80104c90 <release>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103a50:	83 ec 0c             	sub    $0xc,%esp
80103a53:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103a59:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a60:	00 00 00 
    wakeup(&p->nwrite);
80103a63:	50                   	push   %eax
80103a64:	e8 77 0b 00 00       	call   801045e0 <wakeup>
80103a69:	83 c4 10             	add    $0x10,%esp
80103a6c:	eb bd                	jmp    80103a2b <pipeclose+0x3b>
80103a6e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103a70:	83 ec 0c             	sub    $0xc,%esp
80103a73:	53                   	push   %ebx
80103a74:	e8 17 12 00 00       	call   80104c90 <release>
    kfree((char*)p);
80103a79:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a7c:	83 c4 10             	add    $0x10,%esp
}
80103a7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a82:	5b                   	pop    %ebx
80103a83:	5e                   	pop    %esi
80103a84:	5d                   	pop    %ebp
    kfree((char*)p);
80103a85:	e9 d6 ee ff ff       	jmp    80102960 <kfree>
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a90 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103a90:	f3 0f 1e fb          	endbr32 
80103a94:	55                   	push   %ebp
80103a95:	89 e5                	mov    %esp,%ebp
80103a97:	57                   	push   %edi
80103a98:	56                   	push   %esi
80103a99:	53                   	push   %ebx
80103a9a:	83 ec 28             	sub    $0x28,%esp
80103a9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103aa0:	53                   	push   %ebx
80103aa1:	e8 2a 11 00 00       	call   80104bd0 <acquire>
  for(i = 0; i < n; i++){
80103aa6:	8b 45 10             	mov    0x10(%ebp),%eax
80103aa9:	83 c4 10             	add    $0x10,%esp
80103aac:	85 c0                	test   %eax,%eax
80103aae:	0f 8e bc 00 00 00    	jle    80103b70 <pipewrite+0xe0>
80103ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ab7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103abd:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103ac3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ac6:	03 45 10             	add    0x10(%ebp),%eax
80103ac9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103acc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103ad2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ad8:	89 ca                	mov    %ecx,%edx
80103ada:	05 00 02 00 00       	add    $0x200,%eax
80103adf:	39 c1                	cmp    %eax,%ecx
80103ae1:	74 3b                	je     80103b1e <pipewrite+0x8e>
80103ae3:	eb 63                	jmp    80103b48 <pipewrite+0xb8>
80103ae5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103ae8:	e8 73 03 00 00       	call   80103e60 <myproc>
80103aed:	8b 48 24             	mov    0x24(%eax),%ecx
80103af0:	85 c9                	test   %ecx,%ecx
80103af2:	75 34                	jne    80103b28 <pipewrite+0x98>
      wakeup(&p->nread);
80103af4:	83 ec 0c             	sub    $0xc,%esp
80103af7:	57                   	push   %edi
80103af8:	e8 e3 0a 00 00       	call   801045e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103afd:	58                   	pop    %eax
80103afe:	5a                   	pop    %edx
80103aff:	53                   	push   %ebx
80103b00:	56                   	push   %esi
80103b01:	e8 1a 09 00 00       	call   80104420 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b06:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b0c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b12:	83 c4 10             	add    $0x10,%esp
80103b15:	05 00 02 00 00       	add    $0x200,%eax
80103b1a:	39 c2                	cmp    %eax,%edx
80103b1c:	75 2a                	jne    80103b48 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103b1e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b24:	85 c0                	test   %eax,%eax
80103b26:	75 c0                	jne    80103ae8 <pipewrite+0x58>
        release(&p->lock);
80103b28:	83 ec 0c             	sub    $0xc,%esp
80103b2b:	53                   	push   %ebx
80103b2c:	e8 5f 11 00 00       	call   80104c90 <release>
        return -1;
80103b31:	83 c4 10             	add    $0x10,%esp
80103b34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103b39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b3c:	5b                   	pop    %ebx
80103b3d:	5e                   	pop    %esi
80103b3e:	5f                   	pop    %edi
80103b3f:	5d                   	pop    %ebp
80103b40:	c3                   	ret    
80103b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b48:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b4b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b4e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b54:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103b5a:	0f b6 06             	movzbl (%esi),%eax
80103b5d:	83 c6 01             	add    $0x1,%esi
80103b60:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103b63:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103b67:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b6a:	0f 85 5c ff ff ff    	jne    80103acc <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103b70:	83 ec 0c             	sub    $0xc,%esp
80103b73:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b79:	50                   	push   %eax
80103b7a:	e8 61 0a 00 00       	call   801045e0 <wakeup>
  release(&p->lock);
80103b7f:	89 1c 24             	mov    %ebx,(%esp)
80103b82:	e8 09 11 00 00       	call   80104c90 <release>
  return n;
80103b87:	8b 45 10             	mov    0x10(%ebp),%eax
80103b8a:	83 c4 10             	add    $0x10,%esp
80103b8d:	eb aa                	jmp    80103b39 <pipewrite+0xa9>
80103b8f:	90                   	nop

80103b90 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103b90:	f3 0f 1e fb          	endbr32 
80103b94:	55                   	push   %ebp
80103b95:	89 e5                	mov    %esp,%ebp
80103b97:	57                   	push   %edi
80103b98:	56                   	push   %esi
80103b99:	53                   	push   %ebx
80103b9a:	83 ec 18             	sub    $0x18,%esp
80103b9d:	8b 75 08             	mov    0x8(%ebp),%esi
80103ba0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103ba3:	56                   	push   %esi
80103ba4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103baa:	e8 21 10 00 00       	call   80104bd0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103baf:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103bb5:	83 c4 10             	add    $0x10,%esp
80103bb8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bbe:	74 33                	je     80103bf3 <piperead+0x63>
80103bc0:	eb 3b                	jmp    80103bfd <piperead+0x6d>
80103bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103bc8:	e8 93 02 00 00       	call   80103e60 <myproc>
80103bcd:	8b 48 24             	mov    0x24(%eax),%ecx
80103bd0:	85 c9                	test   %ecx,%ecx
80103bd2:	0f 85 88 00 00 00    	jne    80103c60 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103bd8:	83 ec 08             	sub    $0x8,%esp
80103bdb:	56                   	push   %esi
80103bdc:	53                   	push   %ebx
80103bdd:	e8 3e 08 00 00       	call   80104420 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103be2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103be8:	83 c4 10             	add    $0x10,%esp
80103beb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103bf1:	75 0a                	jne    80103bfd <piperead+0x6d>
80103bf3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103bf9:	85 c0                	test   %eax,%eax
80103bfb:	75 cb                	jne    80103bc8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103bfd:	8b 55 10             	mov    0x10(%ebp),%edx
80103c00:	31 db                	xor    %ebx,%ebx
80103c02:	85 d2                	test   %edx,%edx
80103c04:	7f 28                	jg     80103c2e <piperead+0x9e>
80103c06:	eb 34                	jmp    80103c3c <piperead+0xac>
80103c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c0f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103c10:	8d 48 01             	lea    0x1(%eax),%ecx
80103c13:	25 ff 01 00 00       	and    $0x1ff,%eax
80103c18:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103c1e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103c23:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c26:	83 c3 01             	add    $0x1,%ebx
80103c29:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c2c:	74 0e                	je     80103c3c <piperead+0xac>
    if(p->nread == p->nwrite)
80103c2e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c34:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c3a:	75 d4                	jne    80103c10 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103c3c:	83 ec 0c             	sub    $0xc,%esp
80103c3f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c45:	50                   	push   %eax
80103c46:	e8 95 09 00 00       	call   801045e0 <wakeup>
  release(&p->lock);
80103c4b:	89 34 24             	mov    %esi,(%esp)
80103c4e:	e8 3d 10 00 00       	call   80104c90 <release>
  return i;
80103c53:	83 c4 10             	add    $0x10,%esp
}
80103c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c59:	89 d8                	mov    %ebx,%eax
80103c5b:	5b                   	pop    %ebx
80103c5c:	5e                   	pop    %esi
80103c5d:	5f                   	pop    %edi
80103c5e:	5d                   	pop    %ebp
80103c5f:	c3                   	ret    
      release(&p->lock);
80103c60:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c68:	56                   	push   %esi
80103c69:	e8 22 10 00 00       	call   80104c90 <release>
      return -1;
80103c6e:	83 c4 10             	add    $0x10,%esp
}
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
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c84:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
{
80103c89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c8c:	68 c0 42 11 80       	push   $0x801142c0
80103c91:	e8 3a 0f 00 00       	call   80104bd0 <acquire>
80103c96:	83 c4 10             	add    $0x10,%esp
80103c99:	eb 14                	jmp    80103caf <allocproc+0x2f>
80103c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca0:	83 eb 80             	sub    $0xffffff80,%ebx
80103ca3:	81 fb f4 62 11 80    	cmp    $0x801162f4,%ebx
80103ca9:	0f 84 81 00 00 00    	je     80103d30 <allocproc+0xb0>
    if(p->state == UNUSED)
80103caf:	8b 43 0c             	mov    0xc(%ebx),%eax
80103cb2:	85 c0                	test   %eax,%eax
80103cb4:	75 ea                	jne    80103ca0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103cb6:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103cbb:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103cbe:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103cc5:	89 43 10             	mov    %eax,0x10(%ebx)
80103cc8:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103ccb:	68 c0 42 11 80       	push   $0x801142c0
  p->pid = nextpid++;
80103cd0:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103cd6:	e8 b5 0f 00 00       	call   80104c90 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103cdb:	e8 40 ee ff ff       	call   80102b20 <kalloc>
80103ce0:	83 c4 10             	add    $0x10,%esp
80103ce3:	89 43 08             	mov    %eax,0x8(%ebx)
80103ce6:	85 c0                	test   %eax,%eax
80103ce8:	74 5f                	je     80103d49 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103cea:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103cf0:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103cf3:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103cf8:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103cfb:	c7 40 14 a9 60 10 80 	movl   $0x801060a9,0x14(%eax)
  p->context = (struct context*)sp;
80103d02:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d05:	6a 14                	push   $0x14
80103d07:	6a 00                	push   $0x0
80103d09:	50                   	push   %eax
80103d0a:	e8 d1 0f 00 00       	call   80104ce0 <memset>
  p->context->eip = (uint)forkret;
80103d0f:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->start_time = ticks;
  return p;
80103d12:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d15:	c7 40 10 60 3d 10 80 	movl   $0x80103d60,0x10(%eax)
  p->start_time = ticks;
80103d1c:	a1 40 6b 11 80       	mov    0x80116b40,%eax
80103d21:	89 43 7c             	mov    %eax,0x7c(%ebx)
}
80103d24:	89 d8                	mov    %ebx,%eax
80103d26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d29:	c9                   	leave  
80103d2a:	c3                   	ret    
80103d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d2f:	90                   	nop
  release(&ptable.lock);
80103d30:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d33:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d35:	68 c0 42 11 80       	push   $0x801142c0
80103d3a:	e8 51 0f 00 00       	call   80104c90 <release>
}
80103d3f:	89 d8                	mov    %ebx,%eax
  return 0;
80103d41:	83 c4 10             	add    $0x10,%esp
}
80103d44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d47:	c9                   	leave  
80103d48:	c3                   	ret    
    p->state = UNUSED;
80103d49:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d50:	31 db                	xor    %ebx,%ebx
}
80103d52:	89 d8                	mov    %ebx,%eax
80103d54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d57:	c9                   	leave  
80103d58:	c3                   	ret    
80103d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d60 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103d60:	f3 0f 1e fb          	endbr32 
80103d64:	55                   	push   %ebp
80103d65:	89 e5                	mov    %esp,%ebp
80103d67:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103d6a:	68 c0 42 11 80       	push   $0x801142c0
80103d6f:	e8 1c 0f 00 00       	call   80104c90 <release>

  if (first) {
80103d74:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103d79:	83 c4 10             	add    $0x10,%esp
80103d7c:	85 c0                	test   %eax,%eax
80103d7e:	75 08                	jne    80103d88 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103d80:	c9                   	leave  
80103d81:	c3                   	ret    
80103d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103d88:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103d8f:	00 00 00 
    iinit(ROOTDEV);
80103d92:	83 ec 0c             	sub    $0xc,%esp
80103d95:	6a 01                	push   $0x1
80103d97:	e8 94 dc ff ff       	call   80101a30 <iinit>
    initlog(ROOTDEV);
80103d9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103da3:	e8 d8 f3 ff ff       	call   80103180 <initlog>
}
80103da8:	83 c4 10             	add    $0x10,%esp
80103dab:	c9                   	leave  
80103dac:	c3                   	ret    
80103dad:	8d 76 00             	lea    0x0(%esi),%esi

80103db0 <pinit>:
{
80103db0:	f3 0f 1e fb          	endbr32 
80103db4:	55                   	push   %ebp
80103db5:	89 e5                	mov    %esp,%ebp
80103db7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103dba:	68 a0 7e 10 80       	push   $0x80107ea0
80103dbf:	68 c0 42 11 80       	push   $0x801142c0
80103dc4:	e8 87 0c 00 00       	call   80104a50 <initlock>
}
80103dc9:	83 c4 10             	add    $0x10,%esp
80103dcc:	c9                   	leave  
80103dcd:	c3                   	ret    
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <mycpu>:
{
80103dd0:	f3 0f 1e fb          	endbr32 
80103dd4:	55                   	push   %ebp
80103dd5:	89 e5                	mov    %esp,%ebp
80103dd7:	56                   	push   %esi
80103dd8:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dd9:	9c                   	pushf  
80103dda:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ddb:	f6 c4 02             	test   $0x2,%ah
80103dde:	75 4a                	jne    80103e2a <mycpu+0x5a>
  apicid = lapicid();
80103de0:	e8 ab ef ff ff       	call   80102d90 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103de5:	8b 35 a0 42 11 80    	mov    0x801142a0,%esi
  apicid = lapicid();
80103deb:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103ded:	85 f6                	test   %esi,%esi
80103def:	7e 2c                	jle    80103e1d <mycpu+0x4d>
80103df1:	31 d2                	xor    %edx,%edx
80103df3:	eb 0a                	jmp    80103dff <mycpu+0x2f>
80103df5:	8d 76 00             	lea    0x0(%esi),%esi
80103df8:	83 c2 01             	add    $0x1,%edx
80103dfb:	39 f2                	cmp    %esi,%edx
80103dfd:	74 1e                	je     80103e1d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103dff:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103e05:	0f b6 81 20 3d 11 80 	movzbl -0x7feec2e0(%ecx),%eax
80103e0c:	39 d8                	cmp    %ebx,%eax
80103e0e:	75 e8                	jne    80103df8 <mycpu+0x28>
}
80103e10:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103e13:	8d 81 20 3d 11 80    	lea    -0x7feec2e0(%ecx),%eax
}
80103e19:	5b                   	pop    %ebx
80103e1a:	5e                   	pop    %esi
80103e1b:	5d                   	pop    %ebp
80103e1c:	c3                   	ret    
  panic("unknown apicid\n");
80103e1d:	83 ec 0c             	sub    $0xc,%esp
80103e20:	68 a7 7e 10 80       	push   $0x80107ea7
80103e25:	e8 66 c5 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 98 7f 10 80       	push   $0x80107f98
80103e32:	e8 59 c5 ff ff       	call   80100390 <panic>
80103e37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3e:	66 90                	xchg   %ax,%ax

80103e40 <cpuid>:
cpuid() {
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103e4a:	e8 81 ff ff ff       	call   80103dd0 <mycpu>
}
80103e4f:	c9                   	leave  
  return mycpu()-cpus;
80103e50:	2d 20 3d 11 80       	sub    $0x80113d20,%eax
80103e55:	c1 f8 04             	sar    $0x4,%eax
80103e58:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103e5e:	c3                   	ret    
80103e5f:	90                   	nop

80103e60 <myproc>:
myproc(void) {
80103e60:	f3 0f 1e fb          	endbr32 
80103e64:	55                   	push   %ebp
80103e65:	89 e5                	mov    %esp,%ebp
80103e67:	53                   	push   %ebx
80103e68:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103e6b:	e8 60 0c 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
80103e70:	e8 5b ff ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
80103e75:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e7b:	e8 a0 0c 00 00       	call   80104b20 <popcli>
}
80103e80:	83 c4 04             	add    $0x4,%esp
80103e83:	89 d8                	mov    %ebx,%eax
80103e85:	5b                   	pop    %ebx
80103e86:	5d                   	pop    %ebp
80103e87:	c3                   	ret    
80103e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e8f:	90                   	nop

80103e90 <userinit>:
{
80103e90:	f3 0f 1e fb          	endbr32 
80103e94:	55                   	push   %ebp
80103e95:	89 e5                	mov    %esp,%ebp
80103e97:	53                   	push   %ebx
80103e98:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103e9b:	e8 e0 fd ff ff       	call   80103c80 <allocproc>
80103ea0:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103ea2:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103ea7:	e8 c4 37 00 00       	call   80107670 <setupkvm>
80103eac:	89 43 04             	mov    %eax,0x4(%ebx)
80103eaf:	85 c0                	test   %eax,%eax
80103eb1:	0f 84 bd 00 00 00    	je     80103f74 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103eb7:	83 ec 04             	sub    $0x4,%esp
80103eba:	68 2c 00 00 00       	push   $0x2c
80103ebf:	68 60 b4 10 80       	push   $0x8010b460
80103ec4:	50                   	push   %eax
80103ec5:	e8 76 34 00 00       	call   80107340 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103eca:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ecd:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103ed3:	6a 4c                	push   $0x4c
80103ed5:	6a 00                	push   $0x0
80103ed7:	ff 73 18             	pushl  0x18(%ebx)
80103eda:	e8 01 0e 00 00       	call   80104ce0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103edf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ee2:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ee7:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103eea:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103eef:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ef3:	8b 43 18             	mov    0x18(%ebx),%eax
80103ef6:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103efa:	8b 43 18             	mov    0x18(%ebx),%eax
80103efd:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f01:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103f05:	8b 43 18             	mov    0x18(%ebx),%eax
80103f08:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f0c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103f10:	8b 43 18             	mov    0x18(%ebx),%eax
80103f13:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103f1a:	8b 43 18             	mov    0x18(%ebx),%eax
80103f1d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103f24:	8b 43 18             	mov    0x18(%ebx),%eax
80103f27:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f2e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103f31:	6a 10                	push   $0x10
80103f33:	68 d0 7e 10 80       	push   $0x80107ed0
80103f38:	50                   	push   %eax
80103f39:	e8 62 0f 00 00       	call   80104ea0 <safestrcpy>
  p->cwd = namei("/");
80103f3e:	c7 04 24 d9 7e 10 80 	movl   $0x80107ed9,(%esp)
80103f45:	e8 d6 e5 ff ff       	call   80102520 <namei>
80103f4a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103f4d:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103f54:	e8 77 0c 00 00       	call   80104bd0 <acquire>
  p->state = RUNNABLE;
80103f59:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103f60:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
80103f67:	e8 24 0d 00 00       	call   80104c90 <release>
}
80103f6c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f6f:	83 c4 10             	add    $0x10,%esp
80103f72:	c9                   	leave  
80103f73:	c3                   	ret    
    panic("userinit: out of memory?");
80103f74:	83 ec 0c             	sub    $0xc,%esp
80103f77:	68 b7 7e 10 80       	push   $0x80107eb7
80103f7c:	e8 0f c4 ff ff       	call   80100390 <panic>
80103f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f8f:	90                   	nop

80103f90 <growproc>:
{
80103f90:	f3 0f 1e fb          	endbr32 
80103f94:	55                   	push   %ebp
80103f95:	89 e5                	mov    %esp,%ebp
80103f97:	56                   	push   %esi
80103f98:	53                   	push   %ebx
80103f99:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103f9c:	e8 2f 0b 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
80103fa1:	e8 2a fe ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
80103fa6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fac:	e8 6f 0b 00 00       	call   80104b20 <popcli>
  sz = curproc->sz;
80103fb1:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103fb3:	85 f6                	test   %esi,%esi
80103fb5:	7f 19                	jg     80103fd0 <growproc+0x40>
  } else if(n < 0){
80103fb7:	75 37                	jne    80103ff0 <growproc+0x60>
  switchuvm(curproc);
80103fb9:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103fbc:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103fbe:	53                   	push   %ebx
80103fbf:	e8 6c 32 00 00       	call   80107230 <switchuvm>
  return 0;
80103fc4:	83 c4 10             	add    $0x10,%esp
80103fc7:	31 c0                	xor    %eax,%eax
}
80103fc9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fcc:	5b                   	pop    %ebx
80103fcd:	5e                   	pop    %esi
80103fce:	5d                   	pop    %ebp
80103fcf:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103fd0:	83 ec 04             	sub    $0x4,%esp
80103fd3:	01 c6                	add    %eax,%esi
80103fd5:	56                   	push   %esi
80103fd6:	50                   	push   %eax
80103fd7:	ff 73 04             	pushl  0x4(%ebx)
80103fda:	e8 b1 34 00 00       	call   80107490 <allocuvm>
80103fdf:	83 c4 10             	add    $0x10,%esp
80103fe2:	85 c0                	test   %eax,%eax
80103fe4:	75 d3                	jne    80103fb9 <growproc+0x29>
      return -1;
80103fe6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103feb:	eb dc                	jmp    80103fc9 <growproc+0x39>
80103fed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ff0:	83 ec 04             	sub    $0x4,%esp
80103ff3:	01 c6                	add    %eax,%esi
80103ff5:	56                   	push   %esi
80103ff6:	50                   	push   %eax
80103ff7:	ff 73 04             	pushl  0x4(%ebx)
80103ffa:	e8 c1 35 00 00       	call   801075c0 <deallocuvm>
80103fff:	83 c4 10             	add    $0x10,%esp
80104002:	85 c0                	test   %eax,%eax
80104004:	75 b3                	jne    80103fb9 <growproc+0x29>
80104006:	eb de                	jmp    80103fe6 <growproc+0x56>
80104008:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010400f:	90                   	nop

80104010 <fork>:
{
80104010:	f3 0f 1e fb          	endbr32 
80104014:	55                   	push   %ebp
80104015:	89 e5                	mov    %esp,%ebp
80104017:	57                   	push   %edi
80104018:	56                   	push   %esi
80104019:	53                   	push   %ebx
8010401a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
8010401d:	e8 ae 0a 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
80104022:	e8 a9 fd ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
80104027:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010402d:	e8 ee 0a 00 00       	call   80104b20 <popcli>
  if((np = allocproc()) == 0){
80104032:	e8 49 fc ff ff       	call   80103c80 <allocproc>
80104037:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010403a:	85 c0                	test   %eax,%eax
8010403c:	0f 84 bb 00 00 00    	je     801040fd <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104042:	83 ec 08             	sub    $0x8,%esp
80104045:	ff 33                	pushl  (%ebx)
80104047:	89 c7                	mov    %eax,%edi
80104049:	ff 73 04             	pushl  0x4(%ebx)
8010404c:	e8 ef 36 00 00       	call   80107740 <copyuvm>
80104051:	83 c4 10             	add    $0x10,%esp
80104054:	89 47 04             	mov    %eax,0x4(%edi)
80104057:	85 c0                	test   %eax,%eax
80104059:	0f 84 a5 00 00 00    	je     80104104 <fork+0xf4>
  np->sz = curproc->sz;
8010405f:	8b 03                	mov    (%ebx),%eax
80104061:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104064:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104066:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104069:	89 c8                	mov    %ecx,%eax
8010406b:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010406e:	b9 13 00 00 00       	mov    $0x13,%ecx
80104073:	8b 73 18             	mov    0x18(%ebx),%esi
80104076:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104078:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
8010407a:	8b 40 18             	mov    0x18(%eax),%eax
8010407d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80104088:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010408c:	85 c0                	test   %eax,%eax
8010408e:	74 13                	je     801040a3 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104090:	83 ec 0c             	sub    $0xc,%esp
80104093:	50                   	push   %eax
80104094:	e8 c7 d2 ff ff       	call   80101360 <filedup>
80104099:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010409c:	83 c4 10             	add    $0x10,%esp
8010409f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801040a3:	83 c6 01             	add    $0x1,%esi
801040a6:	83 fe 10             	cmp    $0x10,%esi
801040a9:	75 dd                	jne    80104088 <fork+0x78>
  np->cwd = idup(curproc->cwd);
801040ab:	83 ec 0c             	sub    $0xc,%esp
801040ae:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801040b1:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801040b4:	e8 67 db ff ff       	call   80101c20 <idup>
801040b9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801040bc:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801040bf:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801040c2:	8d 47 6c             	lea    0x6c(%edi),%eax
801040c5:	6a 10                	push   $0x10
801040c7:	53                   	push   %ebx
801040c8:	50                   	push   %eax
801040c9:	e8 d2 0d 00 00       	call   80104ea0 <safestrcpy>
  pid = np->pid;
801040ce:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801040d1:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801040d8:	e8 f3 0a 00 00       	call   80104bd0 <acquire>
  np->state = RUNNABLE;
801040dd:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801040e4:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
801040eb:	e8 a0 0b 00 00       	call   80104c90 <release>
  return pid;
801040f0:	83 c4 10             	add    $0x10,%esp
}
801040f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040f6:	89 d8                	mov    %ebx,%eax
801040f8:	5b                   	pop    %ebx
801040f9:	5e                   	pop    %esi
801040fa:	5f                   	pop    %edi
801040fb:	5d                   	pop    %ebp
801040fc:	c3                   	ret    
    return -1;
801040fd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104102:	eb ef                	jmp    801040f3 <fork+0xe3>
    kfree(np->kstack);
80104104:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104107:	83 ec 0c             	sub    $0xc,%esp
8010410a:	ff 73 08             	pushl  0x8(%ebx)
8010410d:	e8 4e e8 ff ff       	call   80102960 <kfree>
    np->kstack = 0;
80104112:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104119:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010411c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104123:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104128:	eb c9                	jmp    801040f3 <fork+0xe3>
8010412a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104130 <scheduler>:
{
80104130:	f3 0f 1e fb          	endbr32 
80104134:	55                   	push   %ebp
80104135:	89 e5                	mov    %esp,%ebp
80104137:	57                   	push   %edi
80104138:	56                   	push   %esi
80104139:	53                   	push   %ebx
8010413a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
8010413d:	e8 8e fc ff ff       	call   80103dd0 <mycpu>
  c->proc = 0;
80104142:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104149:	00 00 00 
  struct cpu *c = mycpu();
8010414c:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010414e:	8d 78 04             	lea    0x4(%eax),%edi
80104151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80104158:	fb                   	sti    
    acquire(&ptable.lock);
80104159:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010415c:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
    acquire(&ptable.lock);
80104161:	68 c0 42 11 80       	push   $0x801142c0
80104166:	e8 65 0a 00 00       	call   80104bd0 <acquire>
8010416b:	83 c4 10             	add    $0x10,%esp
8010416e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104170:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104174:	75 33                	jne    801041a9 <scheduler+0x79>
      switchuvm(p);
80104176:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104179:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010417f:	53                   	push   %ebx
80104180:	e8 ab 30 00 00       	call   80107230 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104185:	58                   	pop    %eax
80104186:	5a                   	pop    %edx
80104187:	ff 73 1c             	pushl  0x1c(%ebx)
8010418a:	57                   	push   %edi
      p->state = RUNNING;
8010418b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104192:	e8 6c 0d 00 00       	call   80104f03 <swtch>
      switchkvm();
80104197:	e8 74 30 00 00       	call   80107210 <switchkvm>
      c->proc = 0;
8010419c:	83 c4 10             	add    $0x10,%esp
8010419f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801041a6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041a9:	83 eb 80             	sub    $0xffffff80,%ebx
801041ac:	81 fb f4 62 11 80    	cmp    $0x801162f4,%ebx
801041b2:	75 bc                	jne    80104170 <scheduler+0x40>
    release(&ptable.lock);
801041b4:	83 ec 0c             	sub    $0xc,%esp
801041b7:	68 c0 42 11 80       	push   $0x801142c0
801041bc:	e8 cf 0a 00 00       	call   80104c90 <release>
    sti();
801041c1:	83 c4 10             	add    $0x10,%esp
801041c4:	eb 92                	jmp    80104158 <scheduler+0x28>
801041c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041cd:	8d 76 00             	lea    0x0(%esi),%esi

801041d0 <sched>:
{
801041d0:	f3 0f 1e fb          	endbr32 
801041d4:	55                   	push   %ebp
801041d5:	89 e5                	mov    %esp,%ebp
801041d7:	56                   	push   %esi
801041d8:	53                   	push   %ebx
  pushcli();
801041d9:	e8 f2 08 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
801041de:	e8 ed fb ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
801041e3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041e9:	e8 32 09 00 00       	call   80104b20 <popcli>
  if(!holding(&ptable.lock))
801041ee:	83 ec 0c             	sub    $0xc,%esp
801041f1:	68 c0 42 11 80       	push   $0x801142c0
801041f6:	e8 85 09 00 00       	call   80104b80 <holding>
801041fb:	83 c4 10             	add    $0x10,%esp
801041fe:	85 c0                	test   %eax,%eax
80104200:	74 4f                	je     80104251 <sched+0x81>
  if(mycpu()->ncli != 1)
80104202:	e8 c9 fb ff ff       	call   80103dd0 <mycpu>
80104207:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010420e:	75 68                	jne    80104278 <sched+0xa8>
  if(p->state == RUNNING)
80104210:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104214:	74 55                	je     8010426b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104216:	9c                   	pushf  
80104217:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104218:	f6 c4 02             	test   $0x2,%ah
8010421b:	75 41                	jne    8010425e <sched+0x8e>
  intena = mycpu()->intena;
8010421d:	e8 ae fb ff ff       	call   80103dd0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104222:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104225:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010422b:	e8 a0 fb ff ff       	call   80103dd0 <mycpu>
80104230:	83 ec 08             	sub    $0x8,%esp
80104233:	ff 70 04             	pushl  0x4(%eax)
80104236:	53                   	push   %ebx
80104237:	e8 c7 0c 00 00       	call   80104f03 <swtch>
  mycpu()->intena = intena;
8010423c:	e8 8f fb ff ff       	call   80103dd0 <mycpu>
}
80104241:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104244:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010424a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010424d:	5b                   	pop    %ebx
8010424e:	5e                   	pop    %esi
8010424f:	5d                   	pop    %ebp
80104250:	c3                   	ret    
    panic("sched ptable.lock");
80104251:	83 ec 0c             	sub    $0xc,%esp
80104254:	68 db 7e 10 80       	push   $0x80107edb
80104259:	e8 32 c1 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010425e:	83 ec 0c             	sub    $0xc,%esp
80104261:	68 07 7f 10 80       	push   $0x80107f07
80104266:	e8 25 c1 ff ff       	call   80100390 <panic>
    panic("sched running");
8010426b:	83 ec 0c             	sub    $0xc,%esp
8010426e:	68 f9 7e 10 80       	push   $0x80107ef9
80104273:	e8 18 c1 ff ff       	call   80100390 <panic>
    panic("sched locks");
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	68 ed 7e 10 80       	push   $0x80107eed
80104280:	e8 0b c1 ff ff       	call   80100390 <panic>
80104285:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010428c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104290 <exit>:
{
80104290:	f3 0f 1e fb          	endbr32 
80104294:	55                   	push   %ebp
80104295:	89 e5                	mov    %esp,%ebp
80104297:	57                   	push   %edi
80104298:	56                   	push   %esi
80104299:	53                   	push   %ebx
8010429a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010429d:	e8 2e 08 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
801042a2:	e8 29 fb ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
801042a7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042ad:	e8 6e 08 00 00       	call   80104b20 <popcli>
  if(curproc == initproc)
801042b2:	8d 5e 28             	lea    0x28(%esi),%ebx
801042b5:	8d 7e 68             	lea    0x68(%esi),%edi
801042b8:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
801042be:	0f 84 f3 00 00 00    	je     801043b7 <exit+0x127>
801042c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
801042c8:	8b 03                	mov    (%ebx),%eax
801042ca:	85 c0                	test   %eax,%eax
801042cc:	74 12                	je     801042e0 <exit+0x50>
      fileclose(curproc->ofile[fd]);
801042ce:	83 ec 0c             	sub    $0xc,%esp
801042d1:	50                   	push   %eax
801042d2:	e8 d9 d0 ff ff       	call   801013b0 <fileclose>
      curproc->ofile[fd] = 0;
801042d7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042dd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801042e0:	83 c3 04             	add    $0x4,%ebx
801042e3:	39 df                	cmp    %ebx,%edi
801042e5:	75 e1                	jne    801042c8 <exit+0x38>
  begin_op();
801042e7:	e8 34 ef ff ff       	call   80103220 <begin_op>
  iput(curproc->cwd);
801042ec:	83 ec 0c             	sub    $0xc,%esp
801042ef:	ff 76 68             	pushl  0x68(%esi)
801042f2:	e8 89 da ff ff       	call   80101d80 <iput>
  end_op();
801042f7:	e8 94 ef ff ff       	call   80103290 <end_op>
  curproc->cwd = 0;
801042fc:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104303:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010430a:	e8 c1 08 00 00       	call   80104bd0 <acquire>
  wakeup1(curproc->parent);
8010430f:	8b 56 14             	mov    0x14(%esi),%edx
80104312:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104315:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
8010431a:	eb 0e                	jmp    8010432a <exit+0x9a>
8010431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104320:	83 e8 80             	sub    $0xffffff80,%eax
80104323:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104328:	74 1c                	je     80104346 <exit+0xb6>
    if(p->state == SLEEPING && p->chan == chan)
8010432a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010432e:	75 f0                	jne    80104320 <exit+0x90>
80104330:	3b 50 20             	cmp    0x20(%eax),%edx
80104333:	75 eb                	jne    80104320 <exit+0x90>
      p->state = RUNNABLE;
80104335:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010433c:	83 e8 80             	sub    $0xffffff80,%eax
8010433f:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104344:	75 e4                	jne    8010432a <exit+0x9a>
      p->parent = initproc;
80104346:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010434c:	ba f4 42 11 80       	mov    $0x801142f4,%edx
80104351:	eb 10                	jmp    80104363 <exit+0xd3>
80104353:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104357:	90                   	nop
80104358:	83 ea 80             	sub    $0xffffff80,%edx
8010435b:	81 fa f4 62 11 80    	cmp    $0x801162f4,%edx
80104361:	74 3b                	je     8010439e <exit+0x10e>
    if(p->parent == curproc){
80104363:	39 72 14             	cmp    %esi,0x14(%edx)
80104366:	75 f0                	jne    80104358 <exit+0xc8>
      if(p->state == ZOMBIE)
80104368:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010436c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010436f:	75 e7                	jne    80104358 <exit+0xc8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104371:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
80104376:	eb 12                	jmp    8010438a <exit+0xfa>
80104378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010437f:	90                   	nop
80104380:	83 e8 80             	sub    $0xffffff80,%eax
80104383:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104388:	74 ce                	je     80104358 <exit+0xc8>
    if(p->state == SLEEPING && p->chan == chan)
8010438a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010438e:	75 f0                	jne    80104380 <exit+0xf0>
80104390:	3b 48 20             	cmp    0x20(%eax),%ecx
80104393:	75 eb                	jne    80104380 <exit+0xf0>
      p->state = RUNNABLE;
80104395:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010439c:	eb e2                	jmp    80104380 <exit+0xf0>
  curproc->state = ZOMBIE;
8010439e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801043a5:	e8 26 fe ff ff       	call   801041d0 <sched>
  panic("zombie exit");
801043aa:	83 ec 0c             	sub    $0xc,%esp
801043ad:	68 28 7f 10 80       	push   $0x80107f28
801043b2:	e8 d9 bf ff ff       	call   80100390 <panic>
    panic("init exiting");
801043b7:	83 ec 0c             	sub    $0xc,%esp
801043ba:	68 1b 7f 10 80       	push   $0x80107f1b
801043bf:	e8 cc bf ff ff       	call   80100390 <panic>
801043c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043cf:	90                   	nop

801043d0 <yield>:
{
801043d0:	f3 0f 1e fb          	endbr32 
801043d4:	55                   	push   %ebp
801043d5:	89 e5                	mov    %esp,%ebp
801043d7:	53                   	push   %ebx
801043d8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801043db:	68 c0 42 11 80       	push   $0x801142c0
801043e0:	e8 eb 07 00 00       	call   80104bd0 <acquire>
  pushcli();
801043e5:	e8 e6 06 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
801043ea:	e8 e1 f9 ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
801043ef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043f5:	e8 26 07 00 00       	call   80104b20 <popcli>
  myproc()->state = RUNNABLE;
801043fa:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104401:	e8 ca fd ff ff       	call   801041d0 <sched>
  release(&ptable.lock);
80104406:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010440d:	e8 7e 08 00 00       	call   80104c90 <release>
}
80104412:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104415:	83 c4 10             	add    $0x10,%esp
80104418:	c9                   	leave  
80104419:	c3                   	ret    
8010441a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104420 <sleep>:
{
80104420:	f3 0f 1e fb          	endbr32 
80104424:	55                   	push   %ebp
80104425:	89 e5                	mov    %esp,%ebp
80104427:	57                   	push   %edi
80104428:	56                   	push   %esi
80104429:	53                   	push   %ebx
8010442a:	83 ec 0c             	sub    $0xc,%esp
8010442d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104430:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104433:	e8 98 06 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
80104438:	e8 93 f9 ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
8010443d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104443:	e8 d8 06 00 00       	call   80104b20 <popcli>
  if(p == 0)
80104448:	85 db                	test   %ebx,%ebx
8010444a:	0f 84 83 00 00 00    	je     801044d3 <sleep+0xb3>
  if(lk == 0)
80104450:	85 f6                	test   %esi,%esi
80104452:	74 72                	je     801044c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104454:	81 fe c0 42 11 80    	cmp    $0x801142c0,%esi
8010445a:	74 4c                	je     801044a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010445c:	83 ec 0c             	sub    $0xc,%esp
8010445f:	68 c0 42 11 80       	push   $0x801142c0
80104464:	e8 67 07 00 00       	call   80104bd0 <acquire>
    release(lk);
80104469:	89 34 24             	mov    %esi,(%esp)
8010446c:	e8 1f 08 00 00       	call   80104c90 <release>
  p->chan = chan;
80104471:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104474:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010447b:	e8 50 fd ff ff       	call   801041d0 <sched>
  p->chan = 0;
80104480:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104487:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
8010448e:	e8 fd 07 00 00       	call   80104c90 <release>
    acquire(lk);
80104493:	89 75 08             	mov    %esi,0x8(%ebp)
80104496:	83 c4 10             	add    $0x10,%esp
}
80104499:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010449c:	5b                   	pop    %ebx
8010449d:	5e                   	pop    %esi
8010449e:	5f                   	pop    %edi
8010449f:	5d                   	pop    %ebp
    acquire(lk);
801044a0:	e9 2b 07 00 00       	jmp    80104bd0 <acquire>
801044a5:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
801044a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801044ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801044b2:	e8 19 fd ff ff       	call   801041d0 <sched>
  p->chan = 0;
801044b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801044be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044c1:	5b                   	pop    %ebx
801044c2:	5e                   	pop    %esi
801044c3:	5f                   	pop    %edi
801044c4:	5d                   	pop    %ebp
801044c5:	c3                   	ret    
    panic("sleep without lk");
801044c6:	83 ec 0c             	sub    $0xc,%esp
801044c9:	68 3a 7f 10 80       	push   $0x80107f3a
801044ce:	e8 bd be ff ff       	call   80100390 <panic>
    panic("sleep");
801044d3:	83 ec 0c             	sub    $0xc,%esp
801044d6:	68 34 7f 10 80       	push   $0x80107f34
801044db:	e8 b0 be ff ff       	call   80100390 <panic>

801044e0 <wait>:
{
801044e0:	f3 0f 1e fb          	endbr32 
801044e4:	55                   	push   %ebp
801044e5:	89 e5                	mov    %esp,%ebp
801044e7:	56                   	push   %esi
801044e8:	53                   	push   %ebx
  pushcli();
801044e9:	e8 e2 05 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
801044ee:	e8 dd f8 ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
801044f3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044f9:	e8 22 06 00 00       	call   80104b20 <popcli>
  acquire(&ptable.lock);
801044fe:	83 ec 0c             	sub    $0xc,%esp
80104501:	68 c0 42 11 80       	push   $0x801142c0
80104506:	e8 c5 06 00 00       	call   80104bd0 <acquire>
8010450b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010450e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104510:	bb f4 42 11 80       	mov    $0x801142f4,%ebx
80104515:	eb 14                	jmp    8010452b <wait+0x4b>
80104517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451e:	66 90                	xchg   %ax,%ax
80104520:	83 eb 80             	sub    $0xffffff80,%ebx
80104523:	81 fb f4 62 11 80    	cmp    $0x801162f4,%ebx
80104529:	74 1b                	je     80104546 <wait+0x66>
      if(p->parent != curproc)
8010452b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010452e:	75 f0                	jne    80104520 <wait+0x40>
      if(p->state == ZOMBIE){
80104530:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104534:	74 32                	je     80104568 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104536:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104539:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010453e:	81 fb f4 62 11 80    	cmp    $0x801162f4,%ebx
80104544:	75 e5                	jne    8010452b <wait+0x4b>
    if(!havekids || curproc->killed){
80104546:	85 c0                	test   %eax,%eax
80104548:	74 74                	je     801045be <wait+0xde>
8010454a:	8b 46 24             	mov    0x24(%esi),%eax
8010454d:	85 c0                	test   %eax,%eax
8010454f:	75 6d                	jne    801045be <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104551:	83 ec 08             	sub    $0x8,%esp
80104554:	68 c0 42 11 80       	push   $0x801142c0
80104559:	56                   	push   %esi
8010455a:	e8 c1 fe ff ff       	call   80104420 <sleep>
    havekids = 0;
8010455f:	83 c4 10             	add    $0x10,%esp
80104562:	eb aa                	jmp    8010450e <wait+0x2e>
80104564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104568:	83 ec 0c             	sub    $0xc,%esp
8010456b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010456e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104571:	e8 ea e3 ff ff       	call   80102960 <kfree>
        freevm(p->pgdir);
80104576:	5a                   	pop    %edx
80104577:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010457a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104581:	e8 6a 30 00 00       	call   801075f0 <freevm>
        release(&ptable.lock);
80104586:	c7 04 24 c0 42 11 80 	movl   $0x801142c0,(%esp)
        p->pid = 0;
8010458d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104594:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010459b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010459f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801045a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801045ad:	e8 de 06 00 00       	call   80104c90 <release>
        return pid;
801045b2:	83 c4 10             	add    $0x10,%esp
}
801045b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045b8:	89 f0                	mov    %esi,%eax
801045ba:	5b                   	pop    %ebx
801045bb:	5e                   	pop    %esi
801045bc:	5d                   	pop    %ebp
801045bd:	c3                   	ret    
      release(&ptable.lock);
801045be:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801045c1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801045c6:	68 c0 42 11 80       	push   $0x801142c0
801045cb:	e8 c0 06 00 00       	call   80104c90 <release>
      return -1;
801045d0:	83 c4 10             	add    $0x10,%esp
801045d3:	eb e0                	jmp    801045b5 <wait+0xd5>
801045d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801045e0:	f3 0f 1e fb          	endbr32 
801045e4:	55                   	push   %ebp
801045e5:	89 e5                	mov    %esp,%ebp
801045e7:	53                   	push   %ebx
801045e8:	83 ec 10             	sub    $0x10,%esp
801045eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801045ee:	68 c0 42 11 80       	push   $0x801142c0
801045f3:	e8 d8 05 00 00       	call   80104bd0 <acquire>
801045f8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045fb:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
80104600:	eb 10                	jmp    80104612 <wakeup+0x32>
80104602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104608:	83 e8 80             	sub    $0xffffff80,%eax
8010460b:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104610:	74 1c                	je     8010462e <wakeup+0x4e>
    if(p->state == SLEEPING && p->chan == chan)
80104612:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104616:	75 f0                	jne    80104608 <wakeup+0x28>
80104618:	3b 58 20             	cmp    0x20(%eax),%ebx
8010461b:	75 eb                	jne    80104608 <wakeup+0x28>
      p->state = RUNNABLE;
8010461d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104624:	83 e8 80             	sub    $0xffffff80,%eax
80104627:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
8010462c:	75 e4                	jne    80104612 <wakeup+0x32>
  wakeup1(chan);
  release(&ptable.lock);
8010462e:	c7 45 08 c0 42 11 80 	movl   $0x801142c0,0x8(%ebp)
}
80104635:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104638:	c9                   	leave  
  release(&ptable.lock);
80104639:	e9 52 06 00 00       	jmp    80104c90 <release>
8010463e:	66 90                	xchg   %ax,%ax

80104640 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104640:	f3 0f 1e fb          	endbr32 
80104644:	55                   	push   %ebp
80104645:	89 e5                	mov    %esp,%ebp
80104647:	53                   	push   %ebx
80104648:	83 ec 10             	sub    $0x10,%esp
8010464b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010464e:	68 c0 42 11 80       	push   $0x801142c0
80104653:	e8 78 05 00 00       	call   80104bd0 <acquire>
80104658:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010465b:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
80104660:	eb 10                	jmp    80104672 <kill+0x32>
80104662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104668:	83 e8 80             	sub    $0xffffff80,%eax
8010466b:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104670:	74 36                	je     801046a8 <kill+0x68>
    if(p->pid == pid){
80104672:	39 58 10             	cmp    %ebx,0x10(%eax)
80104675:	75 f1                	jne    80104668 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104677:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010467b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104682:	75 07                	jne    8010468b <kill+0x4b>
        p->state = RUNNABLE;
80104684:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010468b:	83 ec 0c             	sub    $0xc,%esp
8010468e:	68 c0 42 11 80       	push   $0x801142c0
80104693:	e8 f8 05 00 00       	call   80104c90 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104698:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010469b:	83 c4 10             	add    $0x10,%esp
8010469e:	31 c0                	xor    %eax,%eax
}
801046a0:	c9                   	leave  
801046a1:	c3                   	ret    
801046a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801046a8:	83 ec 0c             	sub    $0xc,%esp
801046ab:	68 c0 42 11 80       	push   $0x801142c0
801046b0:	e8 db 05 00 00       	call   80104c90 <release>
}
801046b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801046b8:	83 c4 10             	add    $0x10,%esp
801046bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046c0:	c9                   	leave  
801046c1:	c3                   	ret    
801046c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046d0 <get_uncle_count>:
    
}*/


//get_uncle_count
int get_uncle_count(int pid){
801046d0:	f3 0f 1e fb          	endbr32 
801046d4:	55                   	push   %ebp
801046d5:	89 e5                	mov    %esp,%ebp
801046d7:	53                   	push   %ebx
801046d8:	83 ec 10             	sub    $0x10,%esp
801046db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //pid = pid - 1; //////////////////////////////???????????????
  struct proc *p;
  struct proc *p_parent;
  struct proc *p_grandParent = 0;
  acquire(&ptable.lock);
801046de:	68 c0 42 11 80       	push   $0x801142c0
801046e3:	e8 e8 04 00 00       	call   80104bd0 <acquire>
  if(pid < 0 || pid >= NPROC){
801046e8:	83 c4 10             	add    $0x10,%esp
801046eb:	83 fb 3f             	cmp    $0x3f,%ebx
801046ee:	0f 87 a8 00 00 00    	ja     8010479c <get_uncle_count+0xcc>
  struct proc *p_grandParent = 0;
801046f4:	31 c9                	xor    %ecx,%ecx
      return -1;
      }
  int count = 0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f6:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
801046fb:	eb 0d                	jmp    8010470a <get_uncle_count+0x3a>
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
80104700:	83 e8 80             	sub    $0xffffff80,%eax
80104703:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104708:	74 36                	je     80104740 <get_uncle_count+0x70>
    count ++;
    if((p->pid) == pid){
8010470a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010470d:	75 f1                	jne    80104700 <get_uncle_count+0x30>
      p_parent = p->parent;
8010470f:	8b 50 14             	mov    0x14(%eax),%edx
      if(p_parent != 0){
80104712:	85 d2                	test   %edx,%edx
80104714:	74 6a                	je     80104780 <get_uncle_count+0xb0>
        p_grandParent = p_parent->parent;
80104716:	8b 4a 14             	mov    0x14(%edx),%ecx
        if(p_grandParent == 0){
80104719:	85 c9                	test   %ecx,%ecx
8010471b:	75 e3                	jne    80104700 <get_uncle_count+0x30>
          cprintf("grandparent is zero.");
8010471d:	83 ec 0c             	sub    $0xc,%esp
          return -1;
80104720:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
          cprintf("grandparent is zero.");
80104725:	68 4b 7f 10 80       	push   $0x80107f4b
8010472a:	e8 91 c1 ff ff       	call   801008c0 <cprintf>
          return -1;
8010472f:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ptable.lock);
  return siblings;

}
80104732:	89 d8                	mov    %ebx,%eax
80104734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104737:	c9                   	leave  
80104738:	c3                   	ret    
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
80104740:	b8 f4 42 11 80       	mov    $0x801142f4,%eax
  int siblings = 0;
80104745:	31 db                	xor    %ebx,%ebx
80104747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474e:	66 90                	xchg   %ax,%ax
      siblings++;
80104750:	31 d2                	xor    %edx,%edx
80104752:	39 48 14             	cmp    %ecx,0x14(%eax)
80104755:	0f 94 c2             	sete   %dl
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
80104758:	83 e8 80             	sub    $0xffffff80,%eax
      siblings++;
8010475b:	01 d3                	add    %edx,%ebx
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
8010475d:	3d f4 62 11 80       	cmp    $0x801162f4,%eax
80104762:	75 ec                	jne    80104750 <get_uncle_count+0x80>
  release(&ptable.lock);
80104764:	83 ec 0c             	sub    $0xc,%esp
80104767:	68 c0 42 11 80       	push   $0x801142c0
8010476c:	e8 1f 05 00 00       	call   80104c90 <release>
}
80104771:	89 d8                	mov    %ebx,%eax
  return siblings;
80104773:	83 c4 10             	add    $0x10,%esp
}
80104776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104779:	c9                   	leave  
8010477a:	c3                   	ret    
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop
        cprintf("parent is zero.");
80104780:	83 ec 0c             	sub    $0xc,%esp
        return -1;
80104783:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        cprintf("parent is zero.");
80104788:	68 50 7f 10 80       	push   $0x80107f50
8010478d:	e8 2e c1 ff ff       	call   801008c0 <cprintf>
}
80104792:	89 d8                	mov    %ebx,%eax
        return -1;
80104794:	83 c4 10             	add    $0x10,%esp
}
80104797:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010479a:	c9                   	leave  
8010479b:	c3                   	ret    
      return -1;
8010479c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801047a1:	eb 8f                	jmp    80104732 <get_uncle_count+0x62>
801047a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801047b0:	f3 0f 1e fb          	endbr32 
801047b4:	55                   	push   %ebp
801047b5:	89 e5                	mov    %esp,%ebp
801047b7:	57                   	push   %edi
801047b8:	56                   	push   %esi
801047b9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801047bc:	53                   	push   %ebx
801047bd:	bb 60 43 11 80       	mov    $0x80114360,%ebx
801047c2:	83 ec 3c             	sub    $0x3c,%esp
801047c5:	eb 28                	jmp    801047ef <procdump+0x3f>
801047c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ce:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801047d0:	83 ec 0c             	sub    $0xc,%esp
801047d3:	68 0f 83 10 80       	push   $0x8010830f
801047d8:	e8 e3 c0 ff ff       	call   801008c0 <cprintf>
801047dd:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047e0:	83 eb 80             	sub    $0xffffff80,%ebx
801047e3:	81 fb 60 63 11 80    	cmp    $0x80116360,%ebx
801047e9:	0f 84 81 00 00 00    	je     80104870 <procdump+0xc0>
    if(p->state == UNUSED)
801047ef:	8b 43 a0             	mov    -0x60(%ebx),%eax
801047f2:	85 c0                	test   %eax,%eax
801047f4:	74 ea                	je     801047e0 <procdump+0x30>
      state = "???";
801047f6:	ba 60 7f 10 80       	mov    $0x80107f60,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801047fb:	83 f8 05             	cmp    $0x5,%eax
801047fe:	77 11                	ja     80104811 <procdump+0x61>
80104800:	8b 14 85 c0 7f 10 80 	mov    -0x7fef8040(,%eax,4),%edx
      state = "???";
80104807:	b8 60 7f 10 80       	mov    $0x80107f60,%eax
8010480c:	85 d2                	test   %edx,%edx
8010480e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104811:	53                   	push   %ebx
80104812:	52                   	push   %edx
80104813:	ff 73 a4             	pushl  -0x5c(%ebx)
80104816:	68 64 7f 10 80       	push   $0x80107f64
8010481b:	e8 a0 c0 ff ff       	call   801008c0 <cprintf>
    if(p->state == SLEEPING){
80104820:	83 c4 10             	add    $0x10,%esp
80104823:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104827:	75 a7                	jne    801047d0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104829:	83 ec 08             	sub    $0x8,%esp
8010482c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010482f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104832:	50                   	push   %eax
80104833:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104836:	8b 40 0c             	mov    0xc(%eax),%eax
80104839:	83 c0 08             	add    $0x8,%eax
8010483c:	50                   	push   %eax
8010483d:	e8 2e 02 00 00       	call   80104a70 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104842:	83 c4 10             	add    $0x10,%esp
80104845:	8d 76 00             	lea    0x0(%esi),%esi
80104848:	8b 17                	mov    (%edi),%edx
8010484a:	85 d2                	test   %edx,%edx
8010484c:	74 82                	je     801047d0 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010484e:	83 ec 08             	sub    $0x8,%esp
80104851:	83 c7 04             	add    $0x4,%edi
80104854:	52                   	push   %edx
80104855:	68 41 79 10 80       	push   $0x80107941
8010485a:	e8 61 c0 ff ff       	call   801008c0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010485f:	83 c4 10             	add    $0x10,%esp
80104862:	39 fe                	cmp    %edi,%esi
80104864:	75 e2                	jne    80104848 <procdump+0x98>
80104866:	e9 65 ff ff ff       	jmp    801047d0 <procdump+0x20>
8010486b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010486f:	90                   	nop
  }
}
80104870:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104873:	5b                   	pop    %ebx
80104874:	5e                   	pop    %esi
80104875:	5f                   	pop    %edi
80104876:	5d                   	pop    %ebp
80104877:	c3                   	ret    
80104878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010487f:	90                   	nop

80104880 <find_digital_root>:

int 
find_digital_root(int n){
80104880:	f3 0f 1e fb          	endbr32 
80104884:	55                   	push   %ebp
80104885:	89 e5                	mov    %esp,%ebp
80104887:	57                   	push   %edi
80104888:	56                   	push   %esi
80104889:	53                   	push   %ebx
8010488a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n>9){
8010488d:	83 fb 09             	cmp    $0x9,%ebx
80104890:	7e 3d                	jle    801048cf <find_digital_root+0x4f>
    int sum = 0 ;
    while(n > 0){
      int digit = n%10;
80104892:	be 67 66 66 66       	mov    $0x66666667,%esi
80104897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489e:	66 90                	xchg   %ax,%ax
find_digital_root(int n){
801048a0:	89 d9                	mov    %ebx,%ecx
    int sum = 0 ;
801048a2:	31 db                	xor    %ebx,%ebx
801048a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      int digit = n%10;
801048a8:	89 c8                	mov    %ecx,%eax
801048aa:	89 cf                	mov    %ecx,%edi
801048ac:	f7 ee                	imul   %esi
801048ae:	89 c8                	mov    %ecx,%eax
801048b0:	c1 f8 1f             	sar    $0x1f,%eax
801048b3:	c1 fa 02             	sar    $0x2,%edx
801048b6:	29 c2                	sub    %eax,%edx
801048b8:	8d 04 92             	lea    (%edx,%edx,4),%eax
801048bb:	01 c0                	add    %eax,%eax
801048bd:	29 c7                	sub    %eax,%edi
801048bf:	89 c8                	mov    %ecx,%eax
      sum += digit;
      n = n/10;
801048c1:	89 d1                	mov    %edx,%ecx
      sum += digit;
801048c3:	01 fb                	add    %edi,%ebx
    while(n > 0){
801048c5:	83 f8 09             	cmp    $0x9,%eax
801048c8:	7f de                	jg     801048a8 <find_digital_root+0x28>
  while(n>9){
801048ca:	83 fb 09             	cmp    $0x9,%ebx
801048cd:	7f d1                	jg     801048a0 <find_digital_root+0x20>
    }
    n = sum;
  }
  
  return n;
}
801048cf:	89 d8                	mov    %ebx,%eax
801048d1:	5b                   	pop    %ebx
801048d2:	5e                   	pop    %esi
801048d3:	5f                   	pop    %edi
801048d4:	5d                   	pop    %ebp
801048d5:	c3                   	ret    
801048d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048dd:	8d 76 00             	lea    0x0(%esi),%esi

801048e0 <get_process_lifetime>:

int
get_process_lifetime(void){
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
801048e5:	89 e5                	mov    %esp,%ebp
801048e7:	56                   	push   %esi
801048e8:	53                   	push   %ebx
  return sys_uptime() - myproc()->start_time ; 
801048e9:	e8 42 17 00 00       	call   80106030 <sys_uptime>
801048ee:	89 c3                	mov    %eax,%ebx
  pushcli();
801048f0:	e8 db 01 00 00       	call   80104ad0 <pushcli>
  c = mycpu();
801048f5:	e8 d6 f4 ff ff       	call   80103dd0 <mycpu>
  p = c->proc;
801048fa:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104900:	e8 1b 02 00 00       	call   80104b20 <popcli>
  return sys_uptime() - myproc()->start_time ; 
80104905:	89 d8                	mov    %ebx,%eax
80104907:	5b                   	pop    %ebx
  return sys_uptime() - myproc()->start_time ; 
80104908:	2b 46 7c             	sub    0x7c(%esi),%eax
8010490b:	5e                   	pop    %esi
8010490c:	5d                   	pop    %ebp
8010490d:	c3                   	ret    
8010490e:	66 90                	xchg   %ax,%ax

80104910 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	53                   	push   %ebx
80104918:	83 ec 0c             	sub    $0xc,%esp
8010491b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010491e:	68 d8 7f 10 80       	push   $0x80107fd8
80104923:	8d 43 04             	lea    0x4(%ebx),%eax
80104926:	50                   	push   %eax
80104927:	e8 24 01 00 00       	call   80104a50 <initlock>
  lk->name = name;
8010492c:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010492f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104935:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104938:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010493f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104942:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104945:	c9                   	leave  
80104946:	c3                   	ret    
80104947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010494e:	66 90                	xchg   %ax,%ax

80104950 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104950:	f3 0f 1e fb          	endbr32 
80104954:	55                   	push   %ebp
80104955:	89 e5                	mov    %esp,%ebp
80104957:	56                   	push   %esi
80104958:	53                   	push   %ebx
80104959:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010495c:	8d 73 04             	lea    0x4(%ebx),%esi
8010495f:	83 ec 0c             	sub    $0xc,%esp
80104962:	56                   	push   %esi
80104963:	e8 68 02 00 00       	call   80104bd0 <acquire>
  while (lk->locked) {
80104968:	8b 13                	mov    (%ebx),%edx
8010496a:	83 c4 10             	add    $0x10,%esp
8010496d:	85 d2                	test   %edx,%edx
8010496f:	74 1a                	je     8010498b <acquiresleep+0x3b>
80104971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104978:	83 ec 08             	sub    $0x8,%esp
8010497b:	56                   	push   %esi
8010497c:	53                   	push   %ebx
8010497d:	e8 9e fa ff ff       	call   80104420 <sleep>
  while (lk->locked) {
80104982:	8b 03                	mov    (%ebx),%eax
80104984:	83 c4 10             	add    $0x10,%esp
80104987:	85 c0                	test   %eax,%eax
80104989:	75 ed                	jne    80104978 <acquiresleep+0x28>
  }
  lk->locked = 1;
8010498b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104991:	e8 ca f4 ff ff       	call   80103e60 <myproc>
80104996:	8b 40 10             	mov    0x10(%eax),%eax
80104999:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
8010499c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010499f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049a2:	5b                   	pop    %ebx
801049a3:	5e                   	pop    %esi
801049a4:	5d                   	pop    %ebp
  release(&lk->lk);
801049a5:	e9 e6 02 00 00       	jmp    80104c90 <release>
801049aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049b0:	f3 0f 1e fb          	endbr32 
801049b4:	55                   	push   %ebp
801049b5:	89 e5                	mov    %esp,%ebp
801049b7:	56                   	push   %esi
801049b8:	53                   	push   %ebx
801049b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049bc:	8d 73 04             	lea    0x4(%ebx),%esi
801049bf:	83 ec 0c             	sub    $0xc,%esp
801049c2:	56                   	push   %esi
801049c3:	e8 08 02 00 00       	call   80104bd0 <acquire>
  lk->locked = 0;
801049c8:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801049ce:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801049d5:	89 1c 24             	mov    %ebx,(%esp)
801049d8:	e8 03 fc ff ff       	call   801045e0 <wakeup>
  release(&lk->lk);
801049dd:	89 75 08             	mov    %esi,0x8(%ebp)
801049e0:	83 c4 10             	add    $0x10,%esp
}
801049e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049e6:	5b                   	pop    %ebx
801049e7:	5e                   	pop    %esi
801049e8:	5d                   	pop    %ebp
  release(&lk->lk);
801049e9:	e9 a2 02 00 00       	jmp    80104c90 <release>
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801049f0:	f3 0f 1e fb          	endbr32 
801049f4:	55                   	push   %ebp
801049f5:	89 e5                	mov    %esp,%ebp
801049f7:	57                   	push   %edi
801049f8:	31 ff                	xor    %edi,%edi
801049fa:	56                   	push   %esi
801049fb:	53                   	push   %ebx
801049fc:	83 ec 18             	sub    $0x18,%esp
801049ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a02:	8d 73 04             	lea    0x4(%ebx),%esi
80104a05:	56                   	push   %esi
80104a06:	e8 c5 01 00 00       	call   80104bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a0b:	8b 03                	mov    (%ebx),%eax
80104a0d:	83 c4 10             	add    $0x10,%esp
80104a10:	85 c0                	test   %eax,%eax
80104a12:	75 1c                	jne    80104a30 <holdingsleep+0x40>
  release(&lk->lk);
80104a14:	83 ec 0c             	sub    $0xc,%esp
80104a17:	56                   	push   %esi
80104a18:	e8 73 02 00 00       	call   80104c90 <release>
  return r;
}
80104a1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a20:	89 f8                	mov    %edi,%eax
80104a22:	5b                   	pop    %ebx
80104a23:	5e                   	pop    %esi
80104a24:	5f                   	pop    %edi
80104a25:	5d                   	pop    %ebp
80104a26:	c3                   	ret    
80104a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a2e:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104a30:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a33:	e8 28 f4 ff ff       	call   80103e60 <myproc>
80104a38:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a3b:	0f 94 c0             	sete   %al
80104a3e:	0f b6 c0             	movzbl %al,%eax
80104a41:	89 c7                	mov    %eax,%edi
80104a43:	eb cf                	jmp    80104a14 <holdingsleep+0x24>
80104a45:	66 90                	xchg   %ax,%ax
80104a47:	66 90                	xchg   %ax,%ax
80104a49:	66 90                	xchg   %ax,%ax
80104a4b:	66 90                	xchg   %ax,%ax
80104a4d:	66 90                	xchg   %ax,%ax
80104a4f:	90                   	nop

80104a50 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
80104a55:	89 e5                	mov    %esp,%ebp
80104a57:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a5d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104a63:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104a66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104a6d:	5d                   	pop    %ebp
80104a6e:	c3                   	ret    
80104a6f:	90                   	nop

80104a70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104a70:	f3 0f 1e fb          	endbr32 
80104a74:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a75:	31 d2                	xor    %edx,%edx
{
80104a77:	89 e5                	mov    %esp,%ebp
80104a79:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104a7a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104a7d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104a80:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104a83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a87:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a88:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104a8e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104a94:	77 1a                	ja     80104ab0 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104a96:	8b 58 04             	mov    0x4(%eax),%ebx
80104a99:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104a9c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104a9f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104aa1:	83 fa 0a             	cmp    $0xa,%edx
80104aa4:	75 e2                	jne    80104a88 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104aa6:	5b                   	pop    %ebx
80104aa7:	5d                   	pop    %ebp
80104aa8:	c3                   	ret    
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104ab0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104ab3:	8d 51 28             	lea    0x28(%ecx),%edx
80104ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104abd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104ac0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ac6:	83 c0 04             	add    $0x4,%eax
80104ac9:	39 d0                	cmp    %edx,%eax
80104acb:	75 f3                	jne    80104ac0 <getcallerpcs+0x50>
}
80104acd:	5b                   	pop    %ebx
80104ace:	5d                   	pop    %ebp
80104acf:	c3                   	ret    

80104ad0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104ad0:	f3 0f 1e fb          	endbr32 
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	53                   	push   %ebx
80104ad8:	83 ec 04             	sub    $0x4,%esp
80104adb:	9c                   	pushf  
80104adc:	5b                   	pop    %ebx
  asm volatile("cli");
80104add:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104ade:	e8 ed f2 ff ff       	call   80103dd0 <mycpu>
80104ae3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104ae9:	85 c0                	test   %eax,%eax
80104aeb:	74 13                	je     80104b00 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104aed:	e8 de f2 ff ff       	call   80103dd0 <mycpu>
80104af2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104af9:	83 c4 04             	add    $0x4,%esp
80104afc:	5b                   	pop    %ebx
80104afd:	5d                   	pop    %ebp
80104afe:	c3                   	ret    
80104aff:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104b00:	e8 cb f2 ff ff       	call   80103dd0 <mycpu>
80104b05:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b0b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b11:	eb da                	jmp    80104aed <pushcli+0x1d>
80104b13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b20 <popcli>:

void
popcli(void)
{
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	55                   	push   %ebp
80104b25:	89 e5                	mov    %esp,%ebp
80104b27:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b2a:	9c                   	pushf  
80104b2b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b2c:	f6 c4 02             	test   $0x2,%ah
80104b2f:	75 31                	jne    80104b62 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104b31:	e8 9a f2 ff ff       	call   80103dd0 <mycpu>
80104b36:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b3d:	78 30                	js     80104b6f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b3f:	e8 8c f2 ff ff       	call   80103dd0 <mycpu>
80104b44:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b4a:	85 d2                	test   %edx,%edx
80104b4c:	74 02                	je     80104b50 <popcli+0x30>
    sti();
}
80104b4e:	c9                   	leave  
80104b4f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b50:	e8 7b f2 ff ff       	call   80103dd0 <mycpu>
80104b55:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b5b:	85 c0                	test   %eax,%eax
80104b5d:	74 ef                	je     80104b4e <popcli+0x2e>
  asm volatile("sti");
80104b5f:	fb                   	sti    
}
80104b60:	c9                   	leave  
80104b61:	c3                   	ret    
    panic("popcli - interruptible");
80104b62:	83 ec 0c             	sub    $0xc,%esp
80104b65:	68 e3 7f 10 80       	push   $0x80107fe3
80104b6a:	e8 21 b8 ff ff       	call   80100390 <panic>
    panic("popcli");
80104b6f:	83 ec 0c             	sub    $0xc,%esp
80104b72:	68 fa 7f 10 80       	push   $0x80107ffa
80104b77:	e8 14 b8 ff ff       	call   80100390 <panic>
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b80 <holding>:
{
80104b80:	f3 0f 1e fb          	endbr32 
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	56                   	push   %esi
80104b88:	53                   	push   %ebx
80104b89:	8b 75 08             	mov    0x8(%ebp),%esi
80104b8c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104b8e:	e8 3d ff ff ff       	call   80104ad0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b93:	8b 06                	mov    (%esi),%eax
80104b95:	85 c0                	test   %eax,%eax
80104b97:	75 0f                	jne    80104ba8 <holding+0x28>
  popcli();
80104b99:	e8 82 ff ff ff       	call   80104b20 <popcli>
}
80104b9e:	89 d8                	mov    %ebx,%eax
80104ba0:	5b                   	pop    %ebx
80104ba1:	5e                   	pop    %esi
80104ba2:	5d                   	pop    %ebp
80104ba3:	c3                   	ret    
80104ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104ba8:	8b 5e 08             	mov    0x8(%esi),%ebx
80104bab:	e8 20 f2 ff ff       	call   80103dd0 <mycpu>
80104bb0:	39 c3                	cmp    %eax,%ebx
80104bb2:	0f 94 c3             	sete   %bl
  popcli();
80104bb5:	e8 66 ff ff ff       	call   80104b20 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104bba:	0f b6 db             	movzbl %bl,%ebx
}
80104bbd:	89 d8                	mov    %ebx,%eax
80104bbf:	5b                   	pop    %ebx
80104bc0:	5e                   	pop    %esi
80104bc1:	5d                   	pop    %ebp
80104bc2:	c3                   	ret    
80104bc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bd0 <acquire>:
{
80104bd0:	f3 0f 1e fb          	endbr32 
80104bd4:	55                   	push   %ebp
80104bd5:	89 e5                	mov    %esp,%ebp
80104bd7:	56                   	push   %esi
80104bd8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104bd9:	e8 f2 fe ff ff       	call   80104ad0 <pushcli>
  if(holding(lk))
80104bde:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104be1:	83 ec 0c             	sub    $0xc,%esp
80104be4:	53                   	push   %ebx
80104be5:	e8 96 ff ff ff       	call   80104b80 <holding>
80104bea:	83 c4 10             	add    $0x10,%esp
80104bed:	85 c0                	test   %eax,%eax
80104bef:	0f 85 7f 00 00 00    	jne    80104c74 <acquire+0xa4>
80104bf5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104bf7:	ba 01 00 00 00       	mov    $0x1,%edx
80104bfc:	eb 05                	jmp    80104c03 <acquire+0x33>
80104bfe:	66 90                	xchg   %ax,%ax
80104c00:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c03:	89 d0                	mov    %edx,%eax
80104c05:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c08:	85 c0                	test   %eax,%eax
80104c0a:	75 f4                	jne    80104c00 <acquire+0x30>
  __sync_synchronize();
80104c0c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c14:	e8 b7 f1 ff ff       	call   80103dd0 <mycpu>
80104c19:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104c1c:	89 e8                	mov    %ebp,%eax
80104c1e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c20:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104c26:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104c2c:	77 22                	ja     80104c50 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104c2e:	8b 50 04             	mov    0x4(%eax),%edx
80104c31:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104c35:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104c38:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104c3a:	83 fe 0a             	cmp    $0xa,%esi
80104c3d:	75 e1                	jne    80104c20 <acquire+0x50>
}
80104c3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c42:	5b                   	pop    %ebx
80104c43:	5e                   	pop    %esi
80104c44:	5d                   	pop    %ebp
80104c45:	c3                   	ret    
80104c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104c50:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104c54:	83 c3 34             	add    $0x34,%ebx
80104c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c66:	83 c0 04             	add    $0x4,%eax
80104c69:	39 d8                	cmp    %ebx,%eax
80104c6b:	75 f3                	jne    80104c60 <acquire+0x90>
}
80104c6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c70:	5b                   	pop    %ebx
80104c71:	5e                   	pop    %esi
80104c72:	5d                   	pop    %ebp
80104c73:	c3                   	ret    
    panic("acquire");
80104c74:	83 ec 0c             	sub    $0xc,%esp
80104c77:	68 01 80 10 80       	push   $0x80108001
80104c7c:	e8 0f b7 ff ff       	call   80100390 <panic>
80104c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8f:	90                   	nop

80104c90 <release>:
{
80104c90:	f3 0f 1e fb          	endbr32 
80104c94:	55                   	push   %ebp
80104c95:	89 e5                	mov    %esp,%ebp
80104c97:	53                   	push   %ebx
80104c98:	83 ec 10             	sub    $0x10,%esp
80104c9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104c9e:	53                   	push   %ebx
80104c9f:	e8 dc fe ff ff       	call   80104b80 <holding>
80104ca4:	83 c4 10             	add    $0x10,%esp
80104ca7:	85 c0                	test   %eax,%eax
80104ca9:	74 22                	je     80104ccd <release+0x3d>
  lk->pcs[0] = 0;
80104cab:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104cb2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104cb9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104cbe:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104cc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc7:	c9                   	leave  
  popcli();
80104cc8:	e9 53 fe ff ff       	jmp    80104b20 <popcli>
    panic("release");
80104ccd:	83 ec 0c             	sub    $0xc,%esp
80104cd0:	68 09 80 10 80       	push   $0x80108009
80104cd5:	e8 b6 b6 ff ff       	call   80100390 <panic>
80104cda:	66 90                	xchg   %ax,%ax
80104cdc:	66 90                	xchg   %ax,%ax
80104cde:	66 90                	xchg   %ax,%ax

80104ce0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104ce0:	f3 0f 1e fb          	endbr32 
80104ce4:	55                   	push   %ebp
80104ce5:	89 e5                	mov    %esp,%ebp
80104ce7:	57                   	push   %edi
80104ce8:	8b 55 08             	mov    0x8(%ebp),%edx
80104ceb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104cee:	53                   	push   %ebx
80104cef:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104cf2:	89 d7                	mov    %edx,%edi
80104cf4:	09 cf                	or     %ecx,%edi
80104cf6:	83 e7 03             	and    $0x3,%edi
80104cf9:	75 25                	jne    80104d20 <memset+0x40>
    c &= 0xFF;
80104cfb:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104cfe:	c1 e0 18             	shl    $0x18,%eax
80104d01:	89 fb                	mov    %edi,%ebx
80104d03:	c1 e9 02             	shr    $0x2,%ecx
80104d06:	c1 e3 10             	shl    $0x10,%ebx
80104d09:	09 d8                	or     %ebx,%eax
80104d0b:	09 f8                	or     %edi,%eax
80104d0d:	c1 e7 08             	shl    $0x8,%edi
80104d10:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104d12:	89 d7                	mov    %edx,%edi
80104d14:	fc                   	cld    
80104d15:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d17:	5b                   	pop    %ebx
80104d18:	89 d0                	mov    %edx,%eax
80104d1a:	5f                   	pop    %edi
80104d1b:	5d                   	pop    %ebp
80104d1c:	c3                   	ret    
80104d1d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104d20:	89 d7                	mov    %edx,%edi
80104d22:	fc                   	cld    
80104d23:	f3 aa                	rep stos %al,%es:(%edi)
80104d25:	5b                   	pop    %ebx
80104d26:	89 d0                	mov    %edx,%eax
80104d28:	5f                   	pop    %edi
80104d29:	5d                   	pop    %ebp
80104d2a:	c3                   	ret    
80104d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d2f:	90                   	nop

80104d30 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d30:	f3 0f 1e fb          	endbr32 
80104d34:	55                   	push   %ebp
80104d35:	89 e5                	mov    %esp,%ebp
80104d37:	56                   	push   %esi
80104d38:	8b 75 10             	mov    0x10(%ebp),%esi
80104d3b:	8b 55 08             	mov    0x8(%ebp),%edx
80104d3e:	53                   	push   %ebx
80104d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d42:	85 f6                	test   %esi,%esi
80104d44:	74 2a                	je     80104d70 <memcmp+0x40>
80104d46:	01 c6                	add    %eax,%esi
80104d48:	eb 10                	jmp    80104d5a <memcmp+0x2a>
80104d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d50:	83 c0 01             	add    $0x1,%eax
80104d53:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d56:	39 f0                	cmp    %esi,%eax
80104d58:	74 16                	je     80104d70 <memcmp+0x40>
    if(*s1 != *s2)
80104d5a:	0f b6 0a             	movzbl (%edx),%ecx
80104d5d:	0f b6 18             	movzbl (%eax),%ebx
80104d60:	38 d9                	cmp    %bl,%cl
80104d62:	74 ec                	je     80104d50 <memcmp+0x20>
      return *s1 - *s2;
80104d64:	0f b6 c1             	movzbl %cl,%eax
80104d67:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104d69:	5b                   	pop    %ebx
80104d6a:	5e                   	pop    %esi
80104d6b:	5d                   	pop    %ebp
80104d6c:	c3                   	ret    
80104d6d:	8d 76 00             	lea    0x0(%esi),%esi
80104d70:	5b                   	pop    %ebx
  return 0;
80104d71:	31 c0                	xor    %eax,%eax
}
80104d73:	5e                   	pop    %esi
80104d74:	5d                   	pop    %ebp
80104d75:	c3                   	ret    
80104d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi

80104d80 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104d80:	f3 0f 1e fb          	endbr32 
80104d84:	55                   	push   %ebp
80104d85:	89 e5                	mov    %esp,%ebp
80104d87:	57                   	push   %edi
80104d88:	8b 55 08             	mov    0x8(%ebp),%edx
80104d8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d8e:	56                   	push   %esi
80104d8f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104d92:	39 d6                	cmp    %edx,%esi
80104d94:	73 2a                	jae    80104dc0 <memmove+0x40>
80104d96:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104d99:	39 fa                	cmp    %edi,%edx
80104d9b:	73 23                	jae    80104dc0 <memmove+0x40>
80104d9d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104da0:	85 c9                	test   %ecx,%ecx
80104da2:	74 13                	je     80104db7 <memmove+0x37>
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104da8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104dac:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104daf:	83 e8 01             	sub    $0x1,%eax
80104db2:	83 f8 ff             	cmp    $0xffffffff,%eax
80104db5:	75 f1                	jne    80104da8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104db7:	5e                   	pop    %esi
80104db8:	89 d0                	mov    %edx,%eax
80104dba:	5f                   	pop    %edi
80104dbb:	5d                   	pop    %ebp
80104dbc:	c3                   	ret    
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104dc0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104dc3:	89 d7                	mov    %edx,%edi
80104dc5:	85 c9                	test   %ecx,%ecx
80104dc7:	74 ee                	je     80104db7 <memmove+0x37>
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104dd0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104dd1:	39 f0                	cmp    %esi,%eax
80104dd3:	75 fb                	jne    80104dd0 <memmove+0x50>
}
80104dd5:	5e                   	pop    %esi
80104dd6:	89 d0                	mov    %edx,%eax
80104dd8:	5f                   	pop    %edi
80104dd9:	5d                   	pop    %ebp
80104dda:	c3                   	ret    
80104ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ddf:	90                   	nop

80104de0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104de0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104de4:	eb 9a                	jmp    80104d80 <memmove>
80104de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ded:	8d 76 00             	lea    0x0(%esi),%esi

80104df0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104df0:	f3 0f 1e fb          	endbr32 
80104df4:	55                   	push   %ebp
80104df5:	89 e5                	mov    %esp,%ebp
80104df7:	56                   	push   %esi
80104df8:	8b 75 10             	mov    0x10(%ebp),%esi
80104dfb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104dfe:	53                   	push   %ebx
80104dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104e02:	85 f6                	test   %esi,%esi
80104e04:	74 32                	je     80104e38 <strncmp+0x48>
80104e06:	01 c6                	add    %eax,%esi
80104e08:	eb 14                	jmp    80104e1e <strncmp+0x2e>
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e10:	38 da                	cmp    %bl,%dl
80104e12:	75 14                	jne    80104e28 <strncmp+0x38>
    n--, p++, q++;
80104e14:	83 c0 01             	add    $0x1,%eax
80104e17:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e1a:	39 f0                	cmp    %esi,%eax
80104e1c:	74 1a                	je     80104e38 <strncmp+0x48>
80104e1e:	0f b6 11             	movzbl (%ecx),%edx
80104e21:	0f b6 18             	movzbl (%eax),%ebx
80104e24:	84 d2                	test   %dl,%dl
80104e26:	75 e8                	jne    80104e10 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104e28:	0f b6 c2             	movzbl %dl,%eax
80104e2b:	29 d8                	sub    %ebx,%eax
}
80104e2d:	5b                   	pop    %ebx
80104e2e:	5e                   	pop    %esi
80104e2f:	5d                   	pop    %ebp
80104e30:	c3                   	ret    
80104e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e38:	5b                   	pop    %ebx
    return 0;
80104e39:	31 c0                	xor    %eax,%eax
}
80104e3b:	5e                   	pop    %esi
80104e3c:	5d                   	pop    %ebp
80104e3d:	c3                   	ret    
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e40:	f3 0f 1e fb          	endbr32 
80104e44:	55                   	push   %ebp
80104e45:	89 e5                	mov    %esp,%ebp
80104e47:	57                   	push   %edi
80104e48:	56                   	push   %esi
80104e49:	8b 75 08             	mov    0x8(%ebp),%esi
80104e4c:	53                   	push   %ebx
80104e4d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e50:	89 f2                	mov    %esi,%edx
80104e52:	eb 1b                	jmp    80104e6f <strncpy+0x2f>
80104e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e58:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e5f:	83 c2 01             	add    $0x1,%edx
80104e62:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104e66:	89 f9                	mov    %edi,%ecx
80104e68:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e6b:	84 c9                	test   %cl,%cl
80104e6d:	74 09                	je     80104e78 <strncpy+0x38>
80104e6f:	89 c3                	mov    %eax,%ebx
80104e71:	83 e8 01             	sub    $0x1,%eax
80104e74:	85 db                	test   %ebx,%ebx
80104e76:	7f e0                	jg     80104e58 <strncpy+0x18>
    ;
  while(n-- > 0)
80104e78:	89 d1                	mov    %edx,%ecx
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	7e 15                	jle    80104e93 <strncpy+0x53>
80104e7e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104e80:	83 c1 01             	add    $0x1,%ecx
80104e83:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104e87:	89 c8                	mov    %ecx,%eax
80104e89:	f7 d0                	not    %eax
80104e8b:	01 d0                	add    %edx,%eax
80104e8d:	01 d8                	add    %ebx,%eax
80104e8f:	85 c0                	test   %eax,%eax
80104e91:	7f ed                	jg     80104e80 <strncpy+0x40>
  return os;
}
80104e93:	5b                   	pop    %ebx
80104e94:	89 f0                	mov    %esi,%eax
80104e96:	5e                   	pop    %esi
80104e97:	5f                   	pop    %edi
80104e98:	5d                   	pop    %ebp
80104e99:	c3                   	ret    
80104e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ea0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	56                   	push   %esi
80104ea8:	8b 55 10             	mov    0x10(%ebp),%edx
80104eab:	8b 75 08             	mov    0x8(%ebp),%esi
80104eae:	53                   	push   %ebx
80104eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104eb2:	85 d2                	test   %edx,%edx
80104eb4:	7e 21                	jle    80104ed7 <safestrcpy+0x37>
80104eb6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104eba:	89 f2                	mov    %esi,%edx
80104ebc:	eb 12                	jmp    80104ed0 <safestrcpy+0x30>
80104ebe:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ec0:	0f b6 08             	movzbl (%eax),%ecx
80104ec3:	83 c0 01             	add    $0x1,%eax
80104ec6:	83 c2 01             	add    $0x1,%edx
80104ec9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104ecc:	84 c9                	test   %cl,%cl
80104ece:	74 04                	je     80104ed4 <safestrcpy+0x34>
80104ed0:	39 d8                	cmp    %ebx,%eax
80104ed2:	75 ec                	jne    80104ec0 <safestrcpy+0x20>
    ;
  *s = 0;
80104ed4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104ed7:	89 f0                	mov    %esi,%eax
80104ed9:	5b                   	pop    %ebx
80104eda:	5e                   	pop    %esi
80104edb:	5d                   	pop    %ebp
80104edc:	c3                   	ret    
80104edd:	8d 76 00             	lea    0x0(%esi),%esi

80104ee0 <strlen>:

int
strlen(const char *s)
{
80104ee0:	f3 0f 1e fb          	endbr32 
80104ee4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ee5:	31 c0                	xor    %eax,%eax
{
80104ee7:	89 e5                	mov    %esp,%ebp
80104ee9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104eec:	80 3a 00             	cmpb   $0x0,(%edx)
80104eef:	74 10                	je     80104f01 <strlen+0x21>
80104ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef8:	83 c0 01             	add    $0x1,%eax
80104efb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104eff:	75 f7                	jne    80104ef8 <strlen+0x18>
    ;
  return n;
}
80104f01:	5d                   	pop    %ebp
80104f02:	c3                   	ret    

80104f03 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f03:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f07:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104f0b:	55                   	push   %ebp
  pushl %ebx
80104f0c:	53                   	push   %ebx
  pushl %esi
80104f0d:	56                   	push   %esi
  pushl %edi
80104f0e:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f0f:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f11:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104f13:	5f                   	pop    %edi
  popl %esi
80104f14:	5e                   	pop    %esi
  popl %ebx
80104f15:	5b                   	pop    %ebx
  popl %ebp
80104f16:	5d                   	pop    %ebp
  ret
80104f17:	c3                   	ret    
80104f18:	66 90                	xchg   %ax,%ax
80104f1a:	66 90                	xchg   %ax,%ax
80104f1c:	66 90                	xchg   %ax,%ax
80104f1e:	66 90                	xchg   %ax,%ax

80104f20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
80104f25:	89 e5                	mov    %esp,%ebp
80104f27:	53                   	push   %ebx
80104f28:	83 ec 04             	sub    $0x4,%esp
80104f2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f2e:	e8 2d ef ff ff       	call   80103e60 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f33:	8b 00                	mov    (%eax),%eax
80104f35:	39 d8                	cmp    %ebx,%eax
80104f37:	76 17                	jbe    80104f50 <fetchint+0x30>
80104f39:	8d 53 04             	lea    0x4(%ebx),%edx
80104f3c:	39 d0                	cmp    %edx,%eax
80104f3e:	72 10                	jb     80104f50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104f40:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f43:	8b 13                	mov    (%ebx),%edx
80104f45:	89 10                	mov    %edx,(%eax)
  return 0;
80104f47:	31 c0                	xor    %eax,%eax
}
80104f49:	83 c4 04             	add    $0x4,%esp
80104f4c:	5b                   	pop    %ebx
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop
    return -1;
80104f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f55:	eb f2                	jmp    80104f49 <fetchint+0x29>
80104f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
80104f65:	89 e5                	mov    %esp,%ebp
80104f67:	53                   	push   %ebx
80104f68:	83 ec 04             	sub    $0x4,%esp
80104f6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f6e:	e8 ed ee ff ff       	call   80103e60 <myproc>

  if(addr >= curproc->sz)
80104f73:	39 18                	cmp    %ebx,(%eax)
80104f75:	76 31                	jbe    80104fa8 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104f77:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f7a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f7c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f7e:	39 d3                	cmp    %edx,%ebx
80104f80:	73 26                	jae    80104fa8 <fetchstr+0x48>
80104f82:	89 d8                	mov    %ebx,%eax
80104f84:	eb 11                	jmp    80104f97 <fetchstr+0x37>
80104f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
80104f90:	83 c0 01             	add    $0x1,%eax
80104f93:	39 c2                	cmp    %eax,%edx
80104f95:	76 11                	jbe    80104fa8 <fetchstr+0x48>
    if(*s == 0)
80104f97:	80 38 00             	cmpb   $0x0,(%eax)
80104f9a:	75 f4                	jne    80104f90 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
80104f9c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104f9f:	29 d8                	sub    %ebx,%eax
}
80104fa1:	5b                   	pop    %ebx
80104fa2:	5d                   	pop    %ebp
80104fa3:	c3                   	ret    
80104fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fa8:	83 c4 04             	add    $0x4,%esp
    return -1;
80104fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fb0:	5b                   	pop    %ebx
80104fb1:	5d                   	pop    %ebp
80104fb2:	c3                   	ret    
80104fb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104fc0:	f3 0f 1e fb          	endbr32 
80104fc4:	55                   	push   %ebp
80104fc5:	89 e5                	mov    %esp,%ebp
80104fc7:	56                   	push   %esi
80104fc8:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fc9:	e8 92 ee ff ff       	call   80103e60 <myproc>
80104fce:	8b 55 08             	mov    0x8(%ebp),%edx
80104fd1:	8b 40 18             	mov    0x18(%eax),%eax
80104fd4:	8b 40 44             	mov    0x44(%eax),%eax
80104fd7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fda:	e8 81 ee ff ff       	call   80103e60 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fdf:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fe2:	8b 00                	mov    (%eax),%eax
80104fe4:	39 c6                	cmp    %eax,%esi
80104fe6:	73 18                	jae    80105000 <argint+0x40>
80104fe8:	8d 53 08             	lea    0x8(%ebx),%edx
80104feb:	39 d0                	cmp    %edx,%eax
80104fed:	72 11                	jb     80105000 <argint+0x40>
  *ip = *(int*)(addr);
80104fef:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ff2:	8b 53 04             	mov    0x4(%ebx),%edx
80104ff5:	89 10                	mov    %edx,(%eax)
  return 0;
80104ff7:	31 c0                	xor    %eax,%eax
}
80104ff9:	5b                   	pop    %ebx
80104ffa:	5e                   	pop    %esi
80104ffb:	5d                   	pop    %ebp
80104ffc:	c3                   	ret    
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105005:	eb f2                	jmp    80104ff9 <argint+0x39>
80105007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010500e:	66 90                	xchg   %ax,%ax

80105010 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105010:	f3 0f 1e fb          	endbr32 
80105014:	55                   	push   %ebp
80105015:	89 e5                	mov    %esp,%ebp
80105017:	56                   	push   %esi
80105018:	53                   	push   %ebx
80105019:	83 ec 10             	sub    $0x10,%esp
8010501c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010501f:	e8 3c ee ff ff       	call   80103e60 <myproc>
 
  if(argint(n, &i) < 0)
80105024:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105027:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80105029:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010502c:	50                   	push   %eax
8010502d:	ff 75 08             	pushl  0x8(%ebp)
80105030:	e8 8b ff ff ff       	call   80104fc0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105035:	83 c4 10             	add    $0x10,%esp
80105038:	85 c0                	test   %eax,%eax
8010503a:	78 24                	js     80105060 <argptr+0x50>
8010503c:	85 db                	test   %ebx,%ebx
8010503e:	78 20                	js     80105060 <argptr+0x50>
80105040:	8b 16                	mov    (%esi),%edx
80105042:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105045:	39 c2                	cmp    %eax,%edx
80105047:	76 17                	jbe    80105060 <argptr+0x50>
80105049:	01 c3                	add    %eax,%ebx
8010504b:	39 da                	cmp    %ebx,%edx
8010504d:	72 11                	jb     80105060 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010504f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105052:	89 02                	mov    %eax,(%edx)
  return 0;
80105054:	31 c0                	xor    %eax,%eax
}
80105056:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105059:	5b                   	pop    %ebx
8010505a:	5e                   	pop    %esi
8010505b:	5d                   	pop    %ebp
8010505c:	c3                   	ret    
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105060:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105065:	eb ef                	jmp    80105056 <argptr+0x46>
80105067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010506e:	66 90                	xchg   %ax,%ax

80105070 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105070:	f3 0f 1e fb          	endbr32 
80105074:	55                   	push   %ebp
80105075:	89 e5                	mov    %esp,%ebp
80105077:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010507a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010507d:	50                   	push   %eax
8010507e:	ff 75 08             	pushl  0x8(%ebp)
80105081:	e8 3a ff ff ff       	call   80104fc0 <argint>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	85 c0                	test   %eax,%eax
8010508b:	78 13                	js     801050a0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010508d:	83 ec 08             	sub    $0x8,%esp
80105090:	ff 75 0c             	pushl  0xc(%ebp)
80105093:	ff 75 f4             	pushl  -0xc(%ebp)
80105096:	e8 c5 fe ff ff       	call   80104f60 <fetchstr>
8010509b:	83 c4 10             	add    $0x10,%esp
}
8010509e:	c9                   	leave  
8010509f:	c3                   	ret    
801050a0:	c9                   	leave  
    return -1;
801050a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050a6:	c3                   	ret    
801050a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ae:	66 90                	xchg   %ax,%ax

801050b0 <syscall>:
[SYS_get_uncle_count] sys_get_uncle_count,
};

void
syscall(void)
{
801050b0:	f3 0f 1e fb          	endbr32 
801050b4:	55                   	push   %ebp
801050b5:	89 e5                	mov    %esp,%ebp
801050b7:	53                   	push   %ebx
801050b8:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801050bb:	e8 a0 ed ff ff       	call   80103e60 <myproc>
801050c0:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
801050c2:	8b 40 18             	mov    0x18(%eax),%eax
801050c5:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801050c8:	8d 50 ff             	lea    -0x1(%eax),%edx
801050cb:	83 fa 18             	cmp    $0x18,%edx
801050ce:	77 20                	ja     801050f0 <syscall+0x40>
801050d0:	8b 14 85 40 80 10 80 	mov    -0x7fef7fc0(,%eax,4),%edx
801050d7:	85 d2                	test   %edx,%edx
801050d9:	74 15                	je     801050f0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801050db:	ff d2                	call   *%edx
801050dd:	89 c2                	mov    %eax,%edx
801050df:	8b 43 18             	mov    0x18(%ebx),%eax
801050e2:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801050e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050e8:	c9                   	leave  
801050e9:	c3                   	ret    
801050ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801050f0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801050f1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801050f4:	50                   	push   %eax
801050f5:	ff 73 10             	pushl  0x10(%ebx)
801050f8:	68 11 80 10 80       	push   $0x80108011
801050fd:	e8 be b7 ff ff       	call   801008c0 <cprintf>
    curproc->tf->eax = -1;
80105102:	8b 43 18             	mov    0x18(%ebx),%eax
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010510f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105112:	c9                   	leave  
80105113:	c3                   	ret    
80105114:	66 90                	xchg   %ax,%ax
80105116:	66 90                	xchg   %ax,%ax
80105118:	66 90                	xchg   %ax,%ax
8010511a:	66 90                	xchg   %ax,%ax
8010511c:	66 90                	xchg   %ax,%ax
8010511e:	66 90                	xchg   %ax,%ax

80105120 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	57                   	push   %edi
80105124:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105125:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105128:	53                   	push   %ebx
80105129:	83 ec 34             	sub    $0x34,%esp
8010512c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010512f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105132:	57                   	push   %edi
80105133:	50                   	push   %eax
{
80105134:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105137:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010513a:	e8 01 d4 ff ff       	call   80102540 <nameiparent>
8010513f:	83 c4 10             	add    $0x10,%esp
80105142:	85 c0                	test   %eax,%eax
80105144:	0f 84 46 01 00 00    	je     80105290 <create+0x170>
    return 0;
  ilock(dp);
8010514a:	83 ec 0c             	sub    $0xc,%esp
8010514d:	89 c3                	mov    %eax,%ebx
8010514f:	50                   	push   %eax
80105150:	e8 fb ca ff ff       	call   80101c50 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105155:	83 c4 0c             	add    $0xc,%esp
80105158:	6a 00                	push   $0x0
8010515a:	57                   	push   %edi
8010515b:	53                   	push   %ebx
8010515c:	e8 3f d0 ff ff       	call   801021a0 <dirlookup>
80105161:	83 c4 10             	add    $0x10,%esp
80105164:	89 c6                	mov    %eax,%esi
80105166:	85 c0                	test   %eax,%eax
80105168:	74 56                	je     801051c0 <create+0xa0>
    iunlockput(dp);
8010516a:	83 ec 0c             	sub    $0xc,%esp
8010516d:	53                   	push   %ebx
8010516e:	e8 7d cd ff ff       	call   80101ef0 <iunlockput>
    ilock(ip);
80105173:	89 34 24             	mov    %esi,(%esp)
80105176:	e8 d5 ca ff ff       	call   80101c50 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010517b:	83 c4 10             	add    $0x10,%esp
8010517e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105183:	75 1b                	jne    801051a0 <create+0x80>
80105185:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010518a:	75 14                	jne    801051a0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010518c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010518f:	89 f0                	mov    %esi,%eax
80105191:	5b                   	pop    %ebx
80105192:	5e                   	pop    %esi
80105193:	5f                   	pop    %edi
80105194:	5d                   	pop    %ebp
80105195:	c3                   	ret    
80105196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801051a0:	83 ec 0c             	sub    $0xc,%esp
801051a3:	56                   	push   %esi
    return 0;
801051a4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801051a6:	e8 45 cd ff ff       	call   80101ef0 <iunlockput>
    return 0;
801051ab:	83 c4 10             	add    $0x10,%esp
}
801051ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b1:	89 f0                	mov    %esi,%eax
801051b3:	5b                   	pop    %ebx
801051b4:	5e                   	pop    %esi
801051b5:	5f                   	pop    %edi
801051b6:	5d                   	pop    %ebp
801051b7:	c3                   	ret    
801051b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051bf:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801051c0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801051c4:	83 ec 08             	sub    $0x8,%esp
801051c7:	50                   	push   %eax
801051c8:	ff 33                	pushl  (%ebx)
801051ca:	e8 01 c9 ff ff       	call   80101ad0 <ialloc>
801051cf:	83 c4 10             	add    $0x10,%esp
801051d2:	89 c6                	mov    %eax,%esi
801051d4:	85 c0                	test   %eax,%eax
801051d6:	0f 84 cd 00 00 00    	je     801052a9 <create+0x189>
  ilock(ip);
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	50                   	push   %eax
801051e0:	e8 6b ca ff ff       	call   80101c50 <ilock>
  ip->major = major;
801051e5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801051e9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801051ed:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801051f1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801051f5:	b8 01 00 00 00       	mov    $0x1,%eax
801051fa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801051fe:	89 34 24             	mov    %esi,(%esp)
80105201:	e8 8a c9 ff ff       	call   80101b90 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105206:	83 c4 10             	add    $0x10,%esp
80105209:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010520e:	74 30                	je     80105240 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105210:	83 ec 04             	sub    $0x4,%esp
80105213:	ff 76 04             	pushl  0x4(%esi)
80105216:	57                   	push   %edi
80105217:	53                   	push   %ebx
80105218:	e8 43 d2 ff ff       	call   80102460 <dirlink>
8010521d:	83 c4 10             	add    $0x10,%esp
80105220:	85 c0                	test   %eax,%eax
80105222:	78 78                	js     8010529c <create+0x17c>
  iunlockput(dp);
80105224:	83 ec 0c             	sub    $0xc,%esp
80105227:	53                   	push   %ebx
80105228:	e8 c3 cc ff ff       	call   80101ef0 <iunlockput>
  return ip;
8010522d:	83 c4 10             	add    $0x10,%esp
}
80105230:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105233:	89 f0                	mov    %esi,%eax
80105235:	5b                   	pop    %ebx
80105236:	5e                   	pop    %esi
80105237:	5f                   	pop    %edi
80105238:	5d                   	pop    %ebp
80105239:	c3                   	ret    
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105240:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105243:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105248:	53                   	push   %ebx
80105249:	e8 42 c9 ff ff       	call   80101b90 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010524e:	83 c4 0c             	add    $0xc,%esp
80105251:	ff 76 04             	pushl  0x4(%esi)
80105254:	68 c4 80 10 80       	push   $0x801080c4
80105259:	56                   	push   %esi
8010525a:	e8 01 d2 ff ff       	call   80102460 <dirlink>
8010525f:	83 c4 10             	add    $0x10,%esp
80105262:	85 c0                	test   %eax,%eax
80105264:	78 18                	js     8010527e <create+0x15e>
80105266:	83 ec 04             	sub    $0x4,%esp
80105269:	ff 73 04             	pushl  0x4(%ebx)
8010526c:	68 c3 80 10 80       	push   $0x801080c3
80105271:	56                   	push   %esi
80105272:	e8 e9 d1 ff ff       	call   80102460 <dirlink>
80105277:	83 c4 10             	add    $0x10,%esp
8010527a:	85 c0                	test   %eax,%eax
8010527c:	79 92                	jns    80105210 <create+0xf0>
      panic("create dots");
8010527e:	83 ec 0c             	sub    $0xc,%esp
80105281:	68 b7 80 10 80       	push   $0x801080b7
80105286:	e8 05 b1 ff ff       	call   80100390 <panic>
8010528b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010528f:	90                   	nop
}
80105290:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105293:	31 f6                	xor    %esi,%esi
}
80105295:	5b                   	pop    %ebx
80105296:	89 f0                	mov    %esi,%eax
80105298:	5e                   	pop    %esi
80105299:	5f                   	pop    %edi
8010529a:	5d                   	pop    %ebp
8010529b:	c3                   	ret    
    panic("create: dirlink");
8010529c:	83 ec 0c             	sub    $0xc,%esp
8010529f:	68 c6 80 10 80       	push   $0x801080c6
801052a4:	e8 e7 b0 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801052a9:	83 ec 0c             	sub    $0xc,%esp
801052ac:	68 a8 80 10 80       	push   $0x801080a8
801052b1:	e8 da b0 ff ff       	call   80100390 <panic>
801052b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	89 d6                	mov    %edx,%esi
801052c6:	53                   	push   %ebx
801052c7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801052c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801052cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052cf:	50                   	push   %eax
801052d0:	6a 00                	push   $0x0
801052d2:	e8 e9 fc ff ff       	call   80104fc0 <argint>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	78 2a                	js     80105308 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052e2:	77 24                	ja     80105308 <argfd.constprop.0+0x48>
801052e4:	e8 77 eb ff ff       	call   80103e60 <myproc>
801052e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801052f0:	85 c0                	test   %eax,%eax
801052f2:	74 14                	je     80105308 <argfd.constprop.0+0x48>
  if(pfd)
801052f4:	85 db                	test   %ebx,%ebx
801052f6:	74 02                	je     801052fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801052f8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801052fa:	89 06                	mov    %eax,(%esi)
  return 0;
801052fc:	31 c0                	xor    %eax,%eax
}
801052fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105301:	5b                   	pop    %ebx
80105302:	5e                   	pop    %esi
80105303:	5d                   	pop    %ebp
80105304:	c3                   	ret    
80105305:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530d:	eb ef                	jmp    801052fe <argfd.constprop.0+0x3e>
8010530f:	90                   	nop

80105310 <sys_dup>:
{
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105315:	31 c0                	xor    %eax,%eax
{
80105317:	89 e5                	mov    %esp,%ebp
80105319:	56                   	push   %esi
8010531a:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
8010531b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010531e:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105321:	e8 9a ff ff ff       	call   801052c0 <argfd.constprop.0>
80105326:	85 c0                	test   %eax,%eax
80105328:	78 1e                	js     80105348 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
8010532a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
8010532d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010532f:	e8 2c eb ff ff       	call   80103e60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105338:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010533c:	85 d2                	test   %edx,%edx
8010533e:	74 20                	je     80105360 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105340:	83 c3 01             	add    $0x1,%ebx
80105343:	83 fb 10             	cmp    $0x10,%ebx
80105346:	75 f0                	jne    80105338 <sys_dup+0x28>
}
80105348:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010534b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105350:	89 d8                	mov    %ebx,%eax
80105352:	5b                   	pop    %ebx
80105353:	5e                   	pop    %esi
80105354:	5d                   	pop    %ebp
80105355:	c3                   	ret    
80105356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010535d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105360:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	ff 75 f4             	pushl  -0xc(%ebp)
8010536a:	e8 f1 bf ff ff       	call   80101360 <filedup>
  return fd;
8010536f:	83 c4 10             	add    $0x10,%esp
}
80105372:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105375:	89 d8                	mov    %ebx,%eax
80105377:	5b                   	pop    %ebx
80105378:	5e                   	pop    %esi
80105379:	5d                   	pop    %ebp
8010537a:	c3                   	ret    
8010537b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010537f:	90                   	nop

80105380 <sys_read>:
{
80105380:	f3 0f 1e fb          	endbr32 
80105384:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105385:	31 c0                	xor    %eax,%eax
{
80105387:	89 e5                	mov    %esp,%ebp
80105389:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010538c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010538f:	e8 2c ff ff ff       	call   801052c0 <argfd.constprop.0>
80105394:	85 c0                	test   %eax,%eax
80105396:	78 48                	js     801053e0 <sys_read+0x60>
80105398:	83 ec 08             	sub    $0x8,%esp
8010539b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010539e:	50                   	push   %eax
8010539f:	6a 02                	push   $0x2
801053a1:	e8 1a fc ff ff       	call   80104fc0 <argint>
801053a6:	83 c4 10             	add    $0x10,%esp
801053a9:	85 c0                	test   %eax,%eax
801053ab:	78 33                	js     801053e0 <sys_read+0x60>
801053ad:	83 ec 04             	sub    $0x4,%esp
801053b0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b3:	ff 75 f0             	pushl  -0x10(%ebp)
801053b6:	50                   	push   %eax
801053b7:	6a 01                	push   $0x1
801053b9:	e8 52 fc ff ff       	call   80105010 <argptr>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 1b                	js     801053e0 <sys_read+0x60>
  return fileread(f, p, n);
801053c5:	83 ec 04             	sub    $0x4,%esp
801053c8:	ff 75 f0             	pushl  -0x10(%ebp)
801053cb:	ff 75 f4             	pushl  -0xc(%ebp)
801053ce:	ff 75 ec             	pushl  -0x14(%ebp)
801053d1:	e8 0a c1 ff ff       	call   801014e0 <fileread>
801053d6:	83 c4 10             	add    $0x10,%esp
}
801053d9:	c9                   	leave  
801053da:	c3                   	ret    
801053db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053df:	90                   	nop
801053e0:	c9                   	leave  
    return -1;
801053e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053e6:	c3                   	ret    
801053e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ee:	66 90                	xchg   %ax,%ax

801053f0 <sys_write>:
{
801053f0:	f3 0f 1e fb          	endbr32 
801053f4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053f5:	31 c0                	xor    %eax,%eax
{
801053f7:	89 e5                	mov    %esp,%ebp
801053f9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053fc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053ff:	e8 bc fe ff ff       	call   801052c0 <argfd.constprop.0>
80105404:	85 c0                	test   %eax,%eax
80105406:	78 48                	js     80105450 <sys_write+0x60>
80105408:	83 ec 08             	sub    $0x8,%esp
8010540b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010540e:	50                   	push   %eax
8010540f:	6a 02                	push   $0x2
80105411:	e8 aa fb ff ff       	call   80104fc0 <argint>
80105416:	83 c4 10             	add    $0x10,%esp
80105419:	85 c0                	test   %eax,%eax
8010541b:	78 33                	js     80105450 <sys_write+0x60>
8010541d:	83 ec 04             	sub    $0x4,%esp
80105420:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105423:	ff 75 f0             	pushl  -0x10(%ebp)
80105426:	50                   	push   %eax
80105427:	6a 01                	push   $0x1
80105429:	e8 e2 fb ff ff       	call   80105010 <argptr>
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	85 c0                	test   %eax,%eax
80105433:	78 1b                	js     80105450 <sys_write+0x60>
  return filewrite(f, p, n);
80105435:	83 ec 04             	sub    $0x4,%esp
80105438:	ff 75 f0             	pushl  -0x10(%ebp)
8010543b:	ff 75 f4             	pushl  -0xc(%ebp)
8010543e:	ff 75 ec             	pushl  -0x14(%ebp)
80105441:	e8 3a c1 ff ff       	call   80101580 <filewrite>
80105446:	83 c4 10             	add    $0x10,%esp
}
80105449:	c9                   	leave  
8010544a:	c3                   	ret    
8010544b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010544f:	90                   	nop
80105450:	c9                   	leave  
    return -1;
80105451:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105456:	c3                   	ret    
80105457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545e:	66 90                	xchg   %ax,%ax

80105460 <sys_close>:
{
80105460:	f3 0f 1e fb          	endbr32 
80105464:	55                   	push   %ebp
80105465:	89 e5                	mov    %esp,%ebp
80105467:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010546a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010546d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105470:	e8 4b fe ff ff       	call   801052c0 <argfd.constprop.0>
80105475:	85 c0                	test   %eax,%eax
80105477:	78 27                	js     801054a0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105479:	e8 e2 e9 ff ff       	call   80103e60 <myproc>
8010547e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105481:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105484:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010548b:	00 
  fileclose(f);
8010548c:	ff 75 f4             	pushl  -0xc(%ebp)
8010548f:	e8 1c bf ff ff       	call   801013b0 <fileclose>
  return 0;
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	31 c0                	xor    %eax,%eax
}
80105499:	c9                   	leave  
8010549a:	c3                   	ret    
8010549b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010549f:	90                   	nop
801054a0:	c9                   	leave  
    return -1;
801054a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054a6:	c3                   	ret    
801054a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ae:	66 90                	xchg   %ax,%ax

801054b0 <sys_fstat>:
{
801054b0:	f3 0f 1e fb          	endbr32 
801054b4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054b5:	31 c0                	xor    %eax,%eax
{
801054b7:	89 e5                	mov    %esp,%ebp
801054b9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054bc:	8d 55 f0             	lea    -0x10(%ebp),%edx
801054bf:	e8 fc fd ff ff       	call   801052c0 <argfd.constprop.0>
801054c4:	85 c0                	test   %eax,%eax
801054c6:	78 30                	js     801054f8 <sys_fstat+0x48>
801054c8:	83 ec 04             	sub    $0x4,%esp
801054cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ce:	6a 14                	push   $0x14
801054d0:	50                   	push   %eax
801054d1:	6a 01                	push   $0x1
801054d3:	e8 38 fb ff ff       	call   80105010 <argptr>
801054d8:	83 c4 10             	add    $0x10,%esp
801054db:	85 c0                	test   %eax,%eax
801054dd:	78 19                	js     801054f8 <sys_fstat+0x48>
  return filestat(f, st);
801054df:	83 ec 08             	sub    $0x8,%esp
801054e2:	ff 75 f4             	pushl  -0xc(%ebp)
801054e5:	ff 75 f0             	pushl  -0x10(%ebp)
801054e8:	e8 a3 bf ff ff       	call   80101490 <filestat>
801054ed:	83 c4 10             	add    $0x10,%esp
}
801054f0:	c9                   	leave  
801054f1:	c3                   	ret    
801054f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054f8:	c9                   	leave  
    return -1;
801054f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054fe:	c3                   	ret    
801054ff:	90                   	nop

80105500 <sys_link>:
{
80105500:	f3 0f 1e fb          	endbr32 
80105504:	55                   	push   %ebp
80105505:	89 e5                	mov    %esp,%ebp
80105507:	57                   	push   %edi
80105508:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105509:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010550c:	53                   	push   %ebx
8010550d:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105510:	50                   	push   %eax
80105511:	6a 00                	push   $0x0
80105513:	e8 58 fb ff ff       	call   80105070 <argstr>
80105518:	83 c4 10             	add    $0x10,%esp
8010551b:	85 c0                	test   %eax,%eax
8010551d:	0f 88 ff 00 00 00    	js     80105622 <sys_link+0x122>
80105523:	83 ec 08             	sub    $0x8,%esp
80105526:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105529:	50                   	push   %eax
8010552a:	6a 01                	push   $0x1
8010552c:	e8 3f fb ff ff       	call   80105070 <argstr>
80105531:	83 c4 10             	add    $0x10,%esp
80105534:	85 c0                	test   %eax,%eax
80105536:	0f 88 e6 00 00 00    	js     80105622 <sys_link+0x122>
  begin_op();
8010553c:	e8 df dc ff ff       	call   80103220 <begin_op>
  if((ip = namei(old)) == 0){
80105541:	83 ec 0c             	sub    $0xc,%esp
80105544:	ff 75 d4             	pushl  -0x2c(%ebp)
80105547:	e8 d4 cf ff ff       	call   80102520 <namei>
8010554c:	83 c4 10             	add    $0x10,%esp
8010554f:	89 c3                	mov    %eax,%ebx
80105551:	85 c0                	test   %eax,%eax
80105553:	0f 84 e8 00 00 00    	je     80105641 <sys_link+0x141>
  ilock(ip);
80105559:	83 ec 0c             	sub    $0xc,%esp
8010555c:	50                   	push   %eax
8010555d:	e8 ee c6 ff ff       	call   80101c50 <ilock>
  if(ip->type == T_DIR){
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010556a:	0f 84 b9 00 00 00    	je     80105629 <sys_link+0x129>
  iupdate(ip);
80105570:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105573:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105578:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010557b:	53                   	push   %ebx
8010557c:	e8 0f c6 ff ff       	call   80101b90 <iupdate>
  iunlock(ip);
80105581:	89 1c 24             	mov    %ebx,(%esp)
80105584:	e8 a7 c7 ff ff       	call   80101d30 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105589:	58                   	pop    %eax
8010558a:	5a                   	pop    %edx
8010558b:	57                   	push   %edi
8010558c:	ff 75 d0             	pushl  -0x30(%ebp)
8010558f:	e8 ac cf ff ff       	call   80102540 <nameiparent>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	89 c6                	mov    %eax,%esi
80105599:	85 c0                	test   %eax,%eax
8010559b:	74 5f                	je     801055fc <sys_link+0xfc>
  ilock(dp);
8010559d:	83 ec 0c             	sub    $0xc,%esp
801055a0:	50                   	push   %eax
801055a1:	e8 aa c6 ff ff       	call   80101c50 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055a6:	8b 03                	mov    (%ebx),%eax
801055a8:	83 c4 10             	add    $0x10,%esp
801055ab:	39 06                	cmp    %eax,(%esi)
801055ad:	75 41                	jne    801055f0 <sys_link+0xf0>
801055af:	83 ec 04             	sub    $0x4,%esp
801055b2:	ff 73 04             	pushl  0x4(%ebx)
801055b5:	57                   	push   %edi
801055b6:	56                   	push   %esi
801055b7:	e8 a4 ce ff ff       	call   80102460 <dirlink>
801055bc:	83 c4 10             	add    $0x10,%esp
801055bf:	85 c0                	test   %eax,%eax
801055c1:	78 2d                	js     801055f0 <sys_link+0xf0>
  iunlockput(dp);
801055c3:	83 ec 0c             	sub    $0xc,%esp
801055c6:	56                   	push   %esi
801055c7:	e8 24 c9 ff ff       	call   80101ef0 <iunlockput>
  iput(ip);
801055cc:	89 1c 24             	mov    %ebx,(%esp)
801055cf:	e8 ac c7 ff ff       	call   80101d80 <iput>
  end_op();
801055d4:	e8 b7 dc ff ff       	call   80103290 <end_op>
  return 0;
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	31 c0                	xor    %eax,%eax
}
801055de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055e1:	5b                   	pop    %ebx
801055e2:	5e                   	pop    %esi
801055e3:	5f                   	pop    %edi
801055e4:	5d                   	pop    %ebp
801055e5:	c3                   	ret    
801055e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ed:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801055f0:	83 ec 0c             	sub    $0xc,%esp
801055f3:	56                   	push   %esi
801055f4:	e8 f7 c8 ff ff       	call   80101ef0 <iunlockput>
    goto bad;
801055f9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801055fc:	83 ec 0c             	sub    $0xc,%esp
801055ff:	53                   	push   %ebx
80105600:	e8 4b c6 ff ff       	call   80101c50 <ilock>
  ip->nlink--;
80105605:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010560a:	89 1c 24             	mov    %ebx,(%esp)
8010560d:	e8 7e c5 ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105612:	89 1c 24             	mov    %ebx,(%esp)
80105615:	e8 d6 c8 ff ff       	call   80101ef0 <iunlockput>
  end_op();
8010561a:	e8 71 dc ff ff       	call   80103290 <end_op>
  return -1;
8010561f:	83 c4 10             	add    $0x10,%esp
80105622:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105627:	eb b5                	jmp    801055de <sys_link+0xde>
    iunlockput(ip);
80105629:	83 ec 0c             	sub    $0xc,%esp
8010562c:	53                   	push   %ebx
8010562d:	e8 be c8 ff ff       	call   80101ef0 <iunlockput>
    end_op();
80105632:	e8 59 dc ff ff       	call   80103290 <end_op>
    return -1;
80105637:	83 c4 10             	add    $0x10,%esp
8010563a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563f:	eb 9d                	jmp    801055de <sys_link+0xde>
    end_op();
80105641:	e8 4a dc ff ff       	call   80103290 <end_op>
    return -1;
80105646:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564b:	eb 91                	jmp    801055de <sys_link+0xde>
8010564d:	8d 76 00             	lea    0x0(%esi),%esi

80105650 <sys_unlink>:
{
80105650:	f3 0f 1e fb          	endbr32 
80105654:	55                   	push   %ebp
80105655:	89 e5                	mov    %esp,%ebp
80105657:	57                   	push   %edi
80105658:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105659:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010565c:	53                   	push   %ebx
8010565d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105660:	50                   	push   %eax
80105661:	6a 00                	push   $0x0
80105663:	e8 08 fa ff ff       	call   80105070 <argstr>
80105668:	83 c4 10             	add    $0x10,%esp
8010566b:	85 c0                	test   %eax,%eax
8010566d:	0f 88 7d 01 00 00    	js     801057f0 <sys_unlink+0x1a0>
  begin_op();
80105673:	e8 a8 db ff ff       	call   80103220 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105678:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010567b:	83 ec 08             	sub    $0x8,%esp
8010567e:	53                   	push   %ebx
8010567f:	ff 75 c0             	pushl  -0x40(%ebp)
80105682:	e8 b9 ce ff ff       	call   80102540 <nameiparent>
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	89 c6                	mov    %eax,%esi
8010568c:	85 c0                	test   %eax,%eax
8010568e:	0f 84 66 01 00 00    	je     801057fa <sys_unlink+0x1aa>
  ilock(dp);
80105694:	83 ec 0c             	sub    $0xc,%esp
80105697:	50                   	push   %eax
80105698:	e8 b3 c5 ff ff       	call   80101c50 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010569d:	58                   	pop    %eax
8010569e:	5a                   	pop    %edx
8010569f:	68 c4 80 10 80       	push   $0x801080c4
801056a4:	53                   	push   %ebx
801056a5:	e8 d6 ca ff ff       	call   80102180 <namecmp>
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	85 c0                	test   %eax,%eax
801056af:	0f 84 03 01 00 00    	je     801057b8 <sys_unlink+0x168>
801056b5:	83 ec 08             	sub    $0x8,%esp
801056b8:	68 c3 80 10 80       	push   $0x801080c3
801056bd:	53                   	push   %ebx
801056be:	e8 bd ca ff ff       	call   80102180 <namecmp>
801056c3:	83 c4 10             	add    $0x10,%esp
801056c6:	85 c0                	test   %eax,%eax
801056c8:	0f 84 ea 00 00 00    	je     801057b8 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
801056ce:	83 ec 04             	sub    $0x4,%esp
801056d1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056d4:	50                   	push   %eax
801056d5:	53                   	push   %ebx
801056d6:	56                   	push   %esi
801056d7:	e8 c4 ca ff ff       	call   801021a0 <dirlookup>
801056dc:	83 c4 10             	add    $0x10,%esp
801056df:	89 c3                	mov    %eax,%ebx
801056e1:	85 c0                	test   %eax,%eax
801056e3:	0f 84 cf 00 00 00    	je     801057b8 <sys_unlink+0x168>
  ilock(ip);
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	50                   	push   %eax
801056ed:	e8 5e c5 ff ff       	call   80101c50 <ilock>
  if(ip->nlink < 1)
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801056fa:	0f 8e 23 01 00 00    	jle    80105823 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105700:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105705:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105708:	74 66                	je     80105770 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010570a:	83 ec 04             	sub    $0x4,%esp
8010570d:	6a 10                	push   $0x10
8010570f:	6a 00                	push   $0x0
80105711:	57                   	push   %edi
80105712:	e8 c9 f5 ff ff       	call   80104ce0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105717:	6a 10                	push   $0x10
80105719:	ff 75 c4             	pushl  -0x3c(%ebp)
8010571c:	57                   	push   %edi
8010571d:	56                   	push   %esi
8010571e:	e8 2d c9 ff ff       	call   80102050 <writei>
80105723:	83 c4 20             	add    $0x20,%esp
80105726:	83 f8 10             	cmp    $0x10,%eax
80105729:	0f 85 e7 00 00 00    	jne    80105816 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
8010572f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105734:	0f 84 96 00 00 00    	je     801057d0 <sys_unlink+0x180>
  iunlockput(dp);
8010573a:	83 ec 0c             	sub    $0xc,%esp
8010573d:	56                   	push   %esi
8010573e:	e8 ad c7 ff ff       	call   80101ef0 <iunlockput>
  ip->nlink--;
80105743:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105748:	89 1c 24             	mov    %ebx,(%esp)
8010574b:	e8 40 c4 ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105750:	89 1c 24             	mov    %ebx,(%esp)
80105753:	e8 98 c7 ff ff       	call   80101ef0 <iunlockput>
  end_op();
80105758:	e8 33 db ff ff       	call   80103290 <end_op>
  return 0;
8010575d:	83 c4 10             	add    $0x10,%esp
80105760:	31 c0                	xor    %eax,%eax
}
80105762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105765:	5b                   	pop    %ebx
80105766:	5e                   	pop    %esi
80105767:	5f                   	pop    %edi
80105768:	5d                   	pop    %ebp
80105769:	c3                   	ret    
8010576a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105770:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105774:	76 94                	jbe    8010570a <sys_unlink+0xba>
80105776:	ba 20 00 00 00       	mov    $0x20,%edx
8010577b:	eb 0b                	jmp    80105788 <sys_unlink+0x138>
8010577d:	8d 76 00             	lea    0x0(%esi),%esi
80105780:	83 c2 10             	add    $0x10,%edx
80105783:	39 53 58             	cmp    %edx,0x58(%ebx)
80105786:	76 82                	jbe    8010570a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105788:	6a 10                	push   $0x10
8010578a:	52                   	push   %edx
8010578b:	57                   	push   %edi
8010578c:	53                   	push   %ebx
8010578d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105790:	e8 bb c7 ff ff       	call   80101f50 <readi>
80105795:	83 c4 10             	add    $0x10,%esp
80105798:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010579b:	83 f8 10             	cmp    $0x10,%eax
8010579e:	75 69                	jne    80105809 <sys_unlink+0x1b9>
    if(de.inum != 0)
801057a0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801057a5:	74 d9                	je     80105780 <sys_unlink+0x130>
    iunlockput(ip);
801057a7:	83 ec 0c             	sub    $0xc,%esp
801057aa:	53                   	push   %ebx
801057ab:	e8 40 c7 ff ff       	call   80101ef0 <iunlockput>
    goto bad;
801057b0:	83 c4 10             	add    $0x10,%esp
801057b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057b7:	90                   	nop
  iunlockput(dp);
801057b8:	83 ec 0c             	sub    $0xc,%esp
801057bb:	56                   	push   %esi
801057bc:	e8 2f c7 ff ff       	call   80101ef0 <iunlockput>
  end_op();
801057c1:	e8 ca da ff ff       	call   80103290 <end_op>
  return -1;
801057c6:	83 c4 10             	add    $0x10,%esp
801057c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ce:	eb 92                	jmp    80105762 <sys_unlink+0x112>
    iupdate(dp);
801057d0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801057d3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801057d8:	56                   	push   %esi
801057d9:	e8 b2 c3 ff ff       	call   80101b90 <iupdate>
801057de:	83 c4 10             	add    $0x10,%esp
801057e1:	e9 54 ff ff ff       	jmp    8010573a <sys_unlink+0xea>
801057e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f5:	e9 68 ff ff ff       	jmp    80105762 <sys_unlink+0x112>
    end_op();
801057fa:	e8 91 da ff ff       	call   80103290 <end_op>
    return -1;
801057ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105804:	e9 59 ff ff ff       	jmp    80105762 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105809:	83 ec 0c             	sub    $0xc,%esp
8010580c:	68 e8 80 10 80       	push   $0x801080e8
80105811:	e8 7a ab ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105816:	83 ec 0c             	sub    $0xc,%esp
80105819:	68 fa 80 10 80       	push   $0x801080fa
8010581e:	e8 6d ab ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105823:	83 ec 0c             	sub    $0xc,%esp
80105826:	68 d6 80 10 80       	push   $0x801080d6
8010582b:	e8 60 ab ff ff       	call   80100390 <panic>

80105830 <sys_open>:

int
sys_open(void)
{
80105830:	f3 0f 1e fb          	endbr32 
80105834:	55                   	push   %ebp
80105835:	89 e5                	mov    %esp,%ebp
80105837:	57                   	push   %edi
80105838:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105839:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
8010583c:	53                   	push   %ebx
8010583d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105840:	50                   	push   %eax
80105841:	6a 00                	push   $0x0
80105843:	e8 28 f8 ff ff       	call   80105070 <argstr>
80105848:	83 c4 10             	add    $0x10,%esp
8010584b:	85 c0                	test   %eax,%eax
8010584d:	0f 88 8a 00 00 00    	js     801058dd <sys_open+0xad>
80105853:	83 ec 08             	sub    $0x8,%esp
80105856:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 01                	push   $0x1
8010585c:	e8 5f f7 ff ff       	call   80104fc0 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 75                	js     801058dd <sys_open+0xad>
    return -1;

  begin_op();
80105868:	e8 b3 d9 ff ff       	call   80103220 <begin_op>

  if(omode & O_CREATE){
8010586d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105871:	75 75                	jne    801058e8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105873:	83 ec 0c             	sub    $0xc,%esp
80105876:	ff 75 e0             	pushl  -0x20(%ebp)
80105879:	e8 a2 cc ff ff       	call   80102520 <namei>
8010587e:	83 c4 10             	add    $0x10,%esp
80105881:	89 c6                	mov    %eax,%esi
80105883:	85 c0                	test   %eax,%eax
80105885:	74 7e                	je     80105905 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105887:	83 ec 0c             	sub    $0xc,%esp
8010588a:	50                   	push   %eax
8010588b:	e8 c0 c3 ff ff       	call   80101c50 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105890:	83 c4 10             	add    $0x10,%esp
80105893:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105898:	0f 84 c2 00 00 00    	je     80105960 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010589e:	e8 4d ba ff ff       	call   801012f0 <filealloc>
801058a3:	89 c7                	mov    %eax,%edi
801058a5:	85 c0                	test   %eax,%eax
801058a7:	74 23                	je     801058cc <sys_open+0x9c>
  struct proc *curproc = myproc();
801058a9:	e8 b2 e5 ff ff       	call   80103e60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058ae:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801058b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801058b4:	85 d2                	test   %edx,%edx
801058b6:	74 60                	je     80105918 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801058b8:	83 c3 01             	add    $0x1,%ebx
801058bb:	83 fb 10             	cmp    $0x10,%ebx
801058be:	75 f0                	jne    801058b0 <sys_open+0x80>
    if(f)
      fileclose(f);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	57                   	push   %edi
801058c4:	e8 e7 ba ff ff       	call   801013b0 <fileclose>
801058c9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801058cc:	83 ec 0c             	sub    $0xc,%esp
801058cf:	56                   	push   %esi
801058d0:	e8 1b c6 ff ff       	call   80101ef0 <iunlockput>
    end_op();
801058d5:	e8 b6 d9 ff ff       	call   80103290 <end_op>
    return -1;
801058da:	83 c4 10             	add    $0x10,%esp
801058dd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058e2:	eb 6d                	jmp    80105951 <sys_open+0x121>
801058e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801058e8:	83 ec 0c             	sub    $0xc,%esp
801058eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801058ee:	31 c9                	xor    %ecx,%ecx
801058f0:	ba 02 00 00 00       	mov    $0x2,%edx
801058f5:	6a 00                	push   $0x0
801058f7:	e8 24 f8 ff ff       	call   80105120 <create>
    if(ip == 0){
801058fc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801058ff:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105901:	85 c0                	test   %eax,%eax
80105903:	75 99                	jne    8010589e <sys_open+0x6e>
      end_op();
80105905:	e8 86 d9 ff ff       	call   80103290 <end_op>
      return -1;
8010590a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010590f:	eb 40                	jmp    80105951 <sys_open+0x121>
80105911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105918:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010591b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010591f:	56                   	push   %esi
80105920:	e8 0b c4 ff ff       	call   80101d30 <iunlock>
  end_op();
80105925:	e8 66 d9 ff ff       	call   80103290 <end_op>

  f->type = FD_INODE;
8010592a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105930:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105933:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105936:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105939:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010593b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105942:	f7 d0                	not    %eax
80105944:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105947:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010594a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010594d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105951:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105954:	89 d8                	mov    %ebx,%eax
80105956:	5b                   	pop    %ebx
80105957:	5e                   	pop    %esi
80105958:	5f                   	pop    %edi
80105959:	5d                   	pop    %ebp
8010595a:	c3                   	ret    
8010595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010595f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105960:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105963:	85 c9                	test   %ecx,%ecx
80105965:	0f 84 33 ff ff ff    	je     8010589e <sys_open+0x6e>
8010596b:	e9 5c ff ff ff       	jmp    801058cc <sys_open+0x9c>

80105970 <sys_mkdir>:

int
sys_mkdir(void)
{
80105970:	f3 0f 1e fb          	endbr32 
80105974:	55                   	push   %ebp
80105975:	89 e5                	mov    %esp,%ebp
80105977:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010597a:	e8 a1 d8 ff ff       	call   80103220 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010597f:	83 ec 08             	sub    $0x8,%esp
80105982:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105985:	50                   	push   %eax
80105986:	6a 00                	push   $0x0
80105988:	e8 e3 f6 ff ff       	call   80105070 <argstr>
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	85 c0                	test   %eax,%eax
80105992:	78 34                	js     801059c8 <sys_mkdir+0x58>
80105994:	83 ec 0c             	sub    $0xc,%esp
80105997:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010599a:	31 c9                	xor    %ecx,%ecx
8010599c:	ba 01 00 00 00       	mov    $0x1,%edx
801059a1:	6a 00                	push   $0x0
801059a3:	e8 78 f7 ff ff       	call   80105120 <create>
801059a8:	83 c4 10             	add    $0x10,%esp
801059ab:	85 c0                	test   %eax,%eax
801059ad:	74 19                	je     801059c8 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059af:	83 ec 0c             	sub    $0xc,%esp
801059b2:	50                   	push   %eax
801059b3:	e8 38 c5 ff ff       	call   80101ef0 <iunlockput>
  end_op();
801059b8:	e8 d3 d8 ff ff       	call   80103290 <end_op>
  return 0;
801059bd:	83 c4 10             	add    $0x10,%esp
801059c0:	31 c0                	xor    %eax,%eax
}
801059c2:	c9                   	leave  
801059c3:	c3                   	ret    
801059c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801059c8:	e8 c3 d8 ff ff       	call   80103290 <end_op>
    return -1;
801059cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059d2:	c9                   	leave  
801059d3:	c3                   	ret    
801059d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059df:	90                   	nop

801059e0 <sys_mknod>:

int
sys_mknod(void)
{
801059e0:	f3 0f 1e fb          	endbr32 
801059e4:	55                   	push   %ebp
801059e5:	89 e5                	mov    %esp,%ebp
801059e7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801059ea:	e8 31 d8 ff ff       	call   80103220 <begin_op>
  if((argstr(0, &path)) < 0 ||
801059ef:	83 ec 08             	sub    $0x8,%esp
801059f2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059f5:	50                   	push   %eax
801059f6:	6a 00                	push   $0x0
801059f8:	e8 73 f6 ff ff       	call   80105070 <argstr>
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	85 c0                	test   %eax,%eax
80105a02:	78 64                	js     80105a68 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105a04:	83 ec 08             	sub    $0x8,%esp
80105a07:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a0a:	50                   	push   %eax
80105a0b:	6a 01                	push   $0x1
80105a0d:	e8 ae f5 ff ff       	call   80104fc0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a12:	83 c4 10             	add    $0x10,%esp
80105a15:	85 c0                	test   %eax,%eax
80105a17:	78 4f                	js     80105a68 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105a19:	83 ec 08             	sub    $0x8,%esp
80105a1c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a1f:	50                   	push   %eax
80105a20:	6a 02                	push   $0x2
80105a22:	e8 99 f5 ff ff       	call   80104fc0 <argint>
     argint(1, &major) < 0 ||
80105a27:	83 c4 10             	add    $0x10,%esp
80105a2a:	85 c0                	test   %eax,%eax
80105a2c:	78 3a                	js     80105a68 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a2e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a32:	83 ec 0c             	sub    $0xc,%esp
80105a35:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a39:	ba 03 00 00 00       	mov    $0x3,%edx
80105a3e:	50                   	push   %eax
80105a3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a42:	e8 d9 f6 ff ff       	call   80105120 <create>
     argint(2, &minor) < 0 ||
80105a47:	83 c4 10             	add    $0x10,%esp
80105a4a:	85 c0                	test   %eax,%eax
80105a4c:	74 1a                	je     80105a68 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a4e:	83 ec 0c             	sub    $0xc,%esp
80105a51:	50                   	push   %eax
80105a52:	e8 99 c4 ff ff       	call   80101ef0 <iunlockput>
  end_op();
80105a57:	e8 34 d8 ff ff       	call   80103290 <end_op>
  return 0;
80105a5c:	83 c4 10             	add    $0x10,%esp
80105a5f:	31 c0                	xor    %eax,%eax
}
80105a61:	c9                   	leave  
80105a62:	c3                   	ret    
80105a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a67:	90                   	nop
    end_op();
80105a68:	e8 23 d8 ff ff       	call   80103290 <end_op>
    return -1;
80105a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a72:	c9                   	leave  
80105a73:	c3                   	ret    
80105a74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a7f:	90                   	nop

80105a80 <sys_chdir>:

int
sys_chdir(void)
{
80105a80:	f3 0f 1e fb          	endbr32 
80105a84:	55                   	push   %ebp
80105a85:	89 e5                	mov    %esp,%ebp
80105a87:	56                   	push   %esi
80105a88:	53                   	push   %ebx
80105a89:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a8c:	e8 cf e3 ff ff       	call   80103e60 <myproc>
80105a91:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105a93:	e8 88 d7 ff ff       	call   80103220 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a98:	83 ec 08             	sub    $0x8,%esp
80105a9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a9e:	50                   	push   %eax
80105a9f:	6a 00                	push   $0x0
80105aa1:	e8 ca f5 ff ff       	call   80105070 <argstr>
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	85 c0                	test   %eax,%eax
80105aab:	78 73                	js     80105b20 <sys_chdir+0xa0>
80105aad:	83 ec 0c             	sub    $0xc,%esp
80105ab0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab3:	e8 68 ca ff ff       	call   80102520 <namei>
80105ab8:	83 c4 10             	add    $0x10,%esp
80105abb:	89 c3                	mov    %eax,%ebx
80105abd:	85 c0                	test   %eax,%eax
80105abf:	74 5f                	je     80105b20 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105ac1:	83 ec 0c             	sub    $0xc,%esp
80105ac4:	50                   	push   %eax
80105ac5:	e8 86 c1 ff ff       	call   80101c50 <ilock>
  if(ip->type != T_DIR){
80105aca:	83 c4 10             	add    $0x10,%esp
80105acd:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ad2:	75 2c                	jne    80105b00 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ad4:	83 ec 0c             	sub    $0xc,%esp
80105ad7:	53                   	push   %ebx
80105ad8:	e8 53 c2 ff ff       	call   80101d30 <iunlock>
  iput(curproc->cwd);
80105add:	58                   	pop    %eax
80105ade:	ff 76 68             	pushl  0x68(%esi)
80105ae1:	e8 9a c2 ff ff       	call   80101d80 <iput>
  end_op();
80105ae6:	e8 a5 d7 ff ff       	call   80103290 <end_op>
  curproc->cwd = ip;
80105aeb:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105aee:	83 c4 10             	add    $0x10,%esp
80105af1:	31 c0                	xor    %eax,%eax
}
80105af3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105af6:	5b                   	pop    %ebx
80105af7:	5e                   	pop    %esi
80105af8:	5d                   	pop    %ebp
80105af9:	c3                   	ret    
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	53                   	push   %ebx
80105b04:	e8 e7 c3 ff ff       	call   80101ef0 <iunlockput>
    end_op();
80105b09:	e8 82 d7 ff ff       	call   80103290 <end_op>
    return -1;
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b16:	eb db                	jmp    80105af3 <sys_chdir+0x73>
80105b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b1f:	90                   	nop
    end_op();
80105b20:	e8 6b d7 ff ff       	call   80103290 <end_op>
    return -1;
80105b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b2a:	eb c7                	jmp    80105af3 <sys_chdir+0x73>
80105b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b30 <sys_exec>:

int
sys_exec(void)
{
80105b30:	f3 0f 1e fb          	endbr32 
80105b34:	55                   	push   %ebp
80105b35:	89 e5                	mov    %esp,%ebp
80105b37:	57                   	push   %edi
80105b38:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b39:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b3f:	53                   	push   %ebx
80105b40:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b46:	50                   	push   %eax
80105b47:	6a 00                	push   $0x0
80105b49:	e8 22 f5 ff ff       	call   80105070 <argstr>
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	85 c0                	test   %eax,%eax
80105b53:	0f 88 8b 00 00 00    	js     80105be4 <sys_exec+0xb4>
80105b59:	83 ec 08             	sub    $0x8,%esp
80105b5c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b62:	50                   	push   %eax
80105b63:	6a 01                	push   $0x1
80105b65:	e8 56 f4 ff ff       	call   80104fc0 <argint>
80105b6a:	83 c4 10             	add    $0x10,%esp
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	78 73                	js     80105be4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b71:	83 ec 04             	sub    $0x4,%esp
80105b74:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105b7a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b7c:	68 80 00 00 00       	push   $0x80
80105b81:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105b87:	6a 00                	push   $0x0
80105b89:	50                   	push   %eax
80105b8a:	e8 51 f1 ff ff       	call   80104ce0 <memset>
80105b8f:	83 c4 10             	add    $0x10,%esp
80105b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b98:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b9e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ba5:	83 ec 08             	sub    $0x8,%esp
80105ba8:	57                   	push   %edi
80105ba9:	01 f0                	add    %esi,%eax
80105bab:	50                   	push   %eax
80105bac:	e8 6f f3 ff ff       	call   80104f20 <fetchint>
80105bb1:	83 c4 10             	add    $0x10,%esp
80105bb4:	85 c0                	test   %eax,%eax
80105bb6:	78 2c                	js     80105be4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80105bb8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105bbe:	85 c0                	test   %eax,%eax
80105bc0:	74 36                	je     80105bf8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105bc2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105bc8:	83 ec 08             	sub    $0x8,%esp
80105bcb:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105bce:	52                   	push   %edx
80105bcf:	50                   	push   %eax
80105bd0:	e8 8b f3 ff ff       	call   80104f60 <fetchstr>
80105bd5:	83 c4 10             	add    $0x10,%esp
80105bd8:	85 c0                	test   %eax,%eax
80105bda:	78 08                	js     80105be4 <sys_exec+0xb4>
  for(i=0;; i++){
80105bdc:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105bdf:	83 fb 20             	cmp    $0x20,%ebx
80105be2:	75 b4                	jne    80105b98 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105be4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105be7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bec:	5b                   	pop    %ebx
80105bed:	5e                   	pop    %esi
80105bee:	5f                   	pop    %edi
80105bef:	5d                   	pop    %ebp
80105bf0:	c3                   	ret    
80105bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105bf8:	83 ec 08             	sub    $0x8,%esp
80105bfb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105c01:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c08:	00 00 00 00 
  return exec(path, argv);
80105c0c:	50                   	push   %eax
80105c0d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105c13:	e8 58 b3 ff ff       	call   80100f70 <exec>
80105c18:	83 c4 10             	add    $0x10,%esp
}
80105c1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c1e:	5b                   	pop    %ebx
80105c1f:	5e                   	pop    %esi
80105c20:	5f                   	pop    %edi
80105c21:	5d                   	pop    %ebp
80105c22:	c3                   	ret    
80105c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c30 <sys_pipe>:

int
sys_pipe(void)
{
80105c30:	f3 0f 1e fb          	endbr32 
80105c34:	55                   	push   %ebp
80105c35:	89 e5                	mov    %esp,%ebp
80105c37:	57                   	push   %edi
80105c38:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c39:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c3c:	53                   	push   %ebx
80105c3d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c40:	6a 08                	push   $0x8
80105c42:	50                   	push   %eax
80105c43:	6a 00                	push   $0x0
80105c45:	e8 c6 f3 ff ff       	call   80105010 <argptr>
80105c4a:	83 c4 10             	add    $0x10,%esp
80105c4d:	85 c0                	test   %eax,%eax
80105c4f:	78 4e                	js     80105c9f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c51:	83 ec 08             	sub    $0x8,%esp
80105c54:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c57:	50                   	push   %eax
80105c58:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c5b:	50                   	push   %eax
80105c5c:	e8 7f dc ff ff       	call   801038e0 <pipealloc>
80105c61:	83 c4 10             	add    $0x10,%esp
80105c64:	85 c0                	test   %eax,%eax
80105c66:	78 37                	js     80105c9f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c68:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c6b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c6d:	e8 ee e1 ff ff       	call   80103e60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105c78:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c7c:	85 f6                	test   %esi,%esi
80105c7e:	74 30                	je     80105cb0 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105c80:	83 c3 01             	add    $0x1,%ebx
80105c83:	83 fb 10             	cmp    $0x10,%ebx
80105c86:	75 f0                	jne    80105c78 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105c88:	83 ec 0c             	sub    $0xc,%esp
80105c8b:	ff 75 e0             	pushl  -0x20(%ebp)
80105c8e:	e8 1d b7 ff ff       	call   801013b0 <fileclose>
    fileclose(wf);
80105c93:	58                   	pop    %eax
80105c94:	ff 75 e4             	pushl  -0x1c(%ebp)
80105c97:	e8 14 b7 ff ff       	call   801013b0 <fileclose>
    return -1;
80105c9c:	83 c4 10             	add    $0x10,%esp
80105c9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ca4:	eb 5b                	jmp    80105d01 <sys_pipe+0xd1>
80105ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cad:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105cb0:	8d 73 08             	lea    0x8(%ebx),%esi
80105cb3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cb7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105cba:	e8 a1 e1 ff ff       	call   80103e60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cbf:	31 d2                	xor    %edx,%edx
80105cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105cc8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105ccc:	85 c9                	test   %ecx,%ecx
80105cce:	74 20                	je     80105cf0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105cd0:	83 c2 01             	add    $0x1,%edx
80105cd3:	83 fa 10             	cmp    $0x10,%edx
80105cd6:	75 f0                	jne    80105cc8 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105cd8:	e8 83 e1 ff ff       	call   80103e60 <myproc>
80105cdd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105ce4:	00 
80105ce5:	eb a1                	jmp    80105c88 <sys_pipe+0x58>
80105ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cee:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105cf0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105cf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cf7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105cf9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cfc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105cff:	31 c0                	xor    %eax,%eax
}
80105d01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d04:	5b                   	pop    %ebx
80105d05:	5e                   	pop    %esi
80105d06:	5f                   	pop    %edi
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret    
80105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_copy_file>:

int 
sys_copy_file(void) {
80105d10:	f3 0f 1e fb          	endbr32 
80105d14:	55                   	push   %ebp
80105d15:	89 e5                	mov    %esp,%ebp
80105d17:	57                   	push   %edi
80105d18:	56                   	push   %esi
  struct inode* ip_dst;
  struct inode* ip_src;
  int bytesRead;
  char buf[1024];

  if (argstr(0, &src_path) < 0 || argstr(1, &dst_path) < 0)
80105d19:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
sys_copy_file(void) {
80105d1f:	53                   	push   %ebx
80105d20:	81 ec 34 04 00 00    	sub    $0x434,%esp
  if (argstr(0, &src_path) < 0 || argstr(1, &dst_path) < 0)
80105d26:	50                   	push   %eax
80105d27:	6a 00                	push   $0x0
80105d29:	e8 42 f3 ff ff       	call   80105070 <argstr>
80105d2e:	83 c4 10             	add    $0x10,%esp
80105d31:	85 c0                	test   %eax,%eax
80105d33:	0f 88 fa 00 00 00    	js     80105e33 <sys_copy_file+0x123>
80105d39:	83 ec 08             	sub    $0x8,%esp
80105d3c:	8d 85 e4 fb ff ff    	lea    -0x41c(%ebp),%eax
80105d42:	50                   	push   %eax
80105d43:	6a 01                	push   $0x1
80105d45:	e8 26 f3 ff ff       	call   80105070 <argstr>
80105d4a:	83 c4 10             	add    $0x10,%esp
80105d4d:	85 c0                	test   %eax,%eax
80105d4f:	0f 88 de 00 00 00    	js     80105e33 <sys_copy_file+0x123>
    return -1;
  begin_op();
80105d55:	e8 c6 d4 ff ff       	call   80103220 <begin_op>

  if ((ip_src = namei(src_path)) == 0) { // Check if source file exists
80105d5a:	83 ec 0c             	sub    $0xc,%esp
80105d5d:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
80105d63:	e8 b8 c7 ff ff       	call   80102520 <namei>
80105d68:	83 c4 10             	add    $0x10,%esp
80105d6b:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
80105d71:	85 c0                	test   %eax,%eax
80105d73:	0f 84 b5 00 00 00    	je     80105e2e <sys_copy_file+0x11e>
    end_op();
    return -1;
  }
 
  ip_dst = namei(dst_path);
80105d79:	83 ec 0c             	sub    $0xc,%esp
80105d7c:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
80105d82:	e8 99 c7 ff ff       	call   80102520 <namei>
  if (ip_dst > 0) { // Check if destination file already exists
80105d87:	83 c4 10             	add    $0x10,%esp
80105d8a:	85 c0                	test   %eax,%eax
80105d8c:	0f 85 9c 00 00 00    	jne    80105e2e <sys_copy_file+0x11e>
    end_op();
    return -1;
  }
  ip_dst = create(dst_path, T_FILE, 0, 0);
80105d92:	83 ec 0c             	sub    $0xc,%esp
80105d95:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
80105d9b:	31 c9                	xor    %ecx,%ecx
80105d9d:	ba 02 00 00 00       	mov    $0x2,%edx
80105da2:	6a 00                	push   $0x0

  int bytesWrote = 0;
  int readOffset = 0;
  int writeOffset = 0;
80105da4:	31 f6                	xor    %esi,%esi
  int readOffset = 0;
80105da6:	31 db                	xor    %ebx,%ebx
80105da8:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
  ip_dst = create(dst_path, T_FILE, 0, 0);
80105dae:	e8 6d f3 ff ff       	call   80105120 <create>
  ilock(ip_src);
80105db3:	5a                   	pop    %edx
80105db4:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
  ip_dst = create(dst_path, T_FILE, 0, 0);
80105dba:	89 85 d0 fb ff ff    	mov    %eax,-0x430(%ebp)
  ilock(ip_src);
80105dc0:	e8 8b be ff ff       	call   80101c50 <ilock>
  while ((bytesRead = readi(ip_src, buf, readOffset, sizeof(buf))) > 0) {
80105dc5:	83 c4 10             	add    $0x10,%esp
80105dc8:	eb 1f                	jmp    80105de9 <sys_copy_file+0xd9>
80105dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    readOffset += bytesRead;
    if ((bytesWrote = writei(ip_dst , buf,writeOffset,  bytesRead)) <= 0)
80105dd0:	50                   	push   %eax
    readOffset += bytesRead;
80105dd1:	01 c3                	add    %eax,%ebx
    if ((bytesWrote = writei(ip_dst , buf,writeOffset,  bytesRead)) <= 0)
80105dd3:	56                   	push   %esi
80105dd4:	57                   	push   %edi
80105dd5:	ff b5 d0 fb ff ff    	pushl  -0x430(%ebp)
80105ddb:	e8 70 c2 ff ff       	call   80102050 <writei>
80105de0:	83 c4 10             	add    $0x10,%esp
80105de3:	85 c0                	test   %eax,%eax
80105de5:	7e 4c                	jle    80105e33 <sys_copy_file+0x123>
      return -1;
    writeOffset += bytesWrote;
80105de7:	01 c6                	add    %eax,%esi
  while ((bytesRead = readi(ip_src, buf, readOffset, sizeof(buf))) > 0) {
80105de9:	68 00 04 00 00       	push   $0x400
80105dee:	53                   	push   %ebx
80105def:	57                   	push   %edi
80105df0:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
80105df6:	e8 55 c1 ff ff       	call   80101f50 <readi>
80105dfb:	83 c4 10             	add    $0x10,%esp
80105dfe:	85 c0                	test   %eax,%eax
80105e00:	7f ce                	jg     80105dd0 <sys_copy_file+0xc0>
   
}

  iunlock(ip_src);
80105e02:	83 ec 0c             	sub    $0xc,%esp
80105e05:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
80105e0b:	e8 20 bf ff ff       	call   80101d30 <iunlock>
  iunlock(ip_dst);
80105e10:	58                   	pop    %eax
80105e11:	ff b5 d0 fb ff ff    	pushl  -0x430(%ebp)
80105e17:	e8 14 bf ff ff       	call   80101d30 <iunlock>
  end_op();
80105e1c:	e8 6f d4 ff ff       	call   80103290 <end_op>

  return 0;
80105e21:	83 c4 10             	add    $0x10,%esp
}
80105e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80105e27:	31 c0                	xor    %eax,%eax
}
80105e29:	5b                   	pop    %ebx
80105e2a:	5e                   	pop    %esi
80105e2b:	5f                   	pop    %edi
80105e2c:	5d                   	pop    %ebp
80105e2d:	c3                   	ret    
    end_op();
80105e2e:	e8 5d d4 ff ff       	call   80103290 <end_op>
}
80105e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105e36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e3b:	5b                   	pop    %ebx
80105e3c:	5e                   	pop    %esi
80105e3d:	5f                   	pop    %edi
80105e3e:	5d                   	pop    %ebp
80105e3f:	c3                   	ret    

80105e40 <sys_get_process_lifetime>:
    return -1;
  //cprintf("sysproc.h %d", pid);
  return get_process_lifetime(pid);
}*/

int sys_get_process_lifetime(void){
80105e40:	f3 0f 1e fb          	endbr32 
  return get_process_lifetime();
80105e44:	e9 97 ea ff ff       	jmp    801048e0 <get_process_lifetime>
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e50 <sys_get_uncle_count>:
}

int sys_get_uncle_count(void){
80105e50:	f3 0f 1e fb          	endbr32 
80105e54:	55                   	push   %ebp
80105e55:	89 e5                	mov    %esp,%ebp
80105e57:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid) < 0){
80105e5a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e5d:	50                   	push   %eax
80105e5e:	6a 00                	push   $0x0
80105e60:	e8 5b f1 ff ff       	call   80104fc0 <argint>
80105e65:	83 c4 10             	add    $0x10,%esp
80105e68:	85 c0                	test   %eax,%eax
80105e6a:	78 14                	js     80105e80 <sys_get_uncle_count+0x30>
    return -1;
  }
  return get_uncle_count(pid);
80105e6c:	83 ec 0c             	sub    $0xc,%esp
80105e6f:	ff 75 f4             	pushl  -0xc(%ebp)
80105e72:	e8 59 e8 ff ff       	call   801046d0 <get_uncle_count>
80105e77:	83 c4 10             	add    $0x10,%esp
}
80105e7a:	c9                   	leave  
80105e7b:	c3                   	ret    
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e80:	c9                   	leave  
    return -1;
80105e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e86:	c3                   	ret    
80105e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e8e:	66 90                	xchg   %ax,%ax

80105e90 <sys_fork>:

int
sys_fork(void)
{
80105e90:	f3 0f 1e fb          	endbr32 
  return fork();
80105e94:	e9 77 e1 ff ff       	jmp    80104010 <fork>
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ea0 <sys_exit>:
}

int
sys_exit(void)
{
80105ea0:	f3 0f 1e fb          	endbr32 
80105ea4:	55                   	push   %ebp
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	83 ec 08             	sub    $0x8,%esp
  exit();
80105eaa:	e8 e1 e3 ff ff       	call   80104290 <exit>
  return 0;  // not reached
}
80105eaf:	31 c0                	xor    %eax,%eax
80105eb1:	c9                   	leave  
80105eb2:	c3                   	ret    
80105eb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ec0 <sys_wait>:

int
sys_wait(void)
{
80105ec0:	f3 0f 1e fb          	endbr32 
  return wait();
80105ec4:	e9 17 e6 ff ff       	jmp    801044e0 <wait>
80105ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ed0 <sys_kill>:
}

int
sys_kill(void)
{
80105ed0:	f3 0f 1e fb          	endbr32 
80105ed4:	55                   	push   %ebp
80105ed5:	89 e5                	mov    %esp,%ebp
80105ed7:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105eda:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105edd:	50                   	push   %eax
80105ede:	6a 00                	push   $0x0
80105ee0:	e8 db f0 ff ff       	call   80104fc0 <argint>
80105ee5:	83 c4 10             	add    $0x10,%esp
80105ee8:	85 c0                	test   %eax,%eax
80105eea:	78 14                	js     80105f00 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105eec:	83 ec 0c             	sub    $0xc,%esp
80105eef:	ff 75 f4             	pushl  -0xc(%ebp)
80105ef2:	e8 49 e7 ff ff       	call   80104640 <kill>
80105ef7:	83 c4 10             	add    $0x10,%esp
}
80105efa:	c9                   	leave  
80105efb:	c3                   	ret    
80105efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f00:	c9                   	leave  
    return -1;
80105f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f06:	c3                   	ret    
80105f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f0e:	66 90                	xchg   %ax,%ax

80105f10 <sys_getpid>:

int
sys_getpid(void)
{
80105f10:	f3 0f 1e fb          	endbr32 
80105f14:	55                   	push   %ebp
80105f15:	89 e5                	mov    %esp,%ebp
80105f17:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105f1a:	e8 41 df ff ff       	call   80103e60 <myproc>
80105f1f:	8b 40 10             	mov    0x10(%eax),%eax
}
80105f22:	c9                   	leave  
80105f23:	c3                   	ret    
80105f24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f2f:	90                   	nop

80105f30 <sys_sbrk>:

int
sys_sbrk(void)
{
80105f30:	f3 0f 1e fb          	endbr32 
80105f34:	55                   	push   %ebp
80105f35:	89 e5                	mov    %esp,%ebp
80105f37:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105f38:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f3b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f3e:	50                   	push   %eax
80105f3f:	6a 00                	push   $0x0
80105f41:	e8 7a f0 ff ff       	call   80104fc0 <argint>
80105f46:	83 c4 10             	add    $0x10,%esp
80105f49:	85 c0                	test   %eax,%eax
80105f4b:	78 23                	js     80105f70 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105f4d:	e8 0e df ff ff       	call   80103e60 <myproc>
  if(growproc(n) < 0)
80105f52:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105f55:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105f57:	ff 75 f4             	pushl  -0xc(%ebp)
80105f5a:	e8 31 e0 ff ff       	call   80103f90 <growproc>
80105f5f:	83 c4 10             	add    $0x10,%esp
80105f62:	85 c0                	test   %eax,%eax
80105f64:	78 0a                	js     80105f70 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105f66:	89 d8                	mov    %ebx,%eax
80105f68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f6b:	c9                   	leave  
80105f6c:	c3                   	ret    
80105f6d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105f70:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f75:	eb ef                	jmp    80105f66 <sys_sbrk+0x36>
80105f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7e:	66 90                	xchg   %ax,%ax

80105f80 <sys_sleep>:

int
sys_sleep(void)
{
80105f80:	f3 0f 1e fb          	endbr32 
80105f84:	55                   	push   %ebp
80105f85:	89 e5                	mov    %esp,%ebp
80105f87:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105f88:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f8b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f8e:	50                   	push   %eax
80105f8f:	6a 00                	push   $0x0
80105f91:	e8 2a f0 ff ff       	call   80104fc0 <argint>
80105f96:	83 c4 10             	add    $0x10,%esp
80105f99:	85 c0                	test   %eax,%eax
80105f9b:	0f 88 86 00 00 00    	js     80106027 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105fa1:	83 ec 0c             	sub    $0xc,%esp
80105fa4:	68 00 63 11 80       	push   $0x80116300
80105fa9:	e8 22 ec ff ff       	call   80104bd0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105fae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105fb1:	8b 1d 40 6b 11 80    	mov    0x80116b40,%ebx
  while(ticks - ticks0 < n){
80105fb7:	83 c4 10             	add    $0x10,%esp
80105fba:	85 d2                	test   %edx,%edx
80105fbc:	75 23                	jne    80105fe1 <sys_sleep+0x61>
80105fbe:	eb 50                	jmp    80106010 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105fc0:	83 ec 08             	sub    $0x8,%esp
80105fc3:	68 00 63 11 80       	push   $0x80116300
80105fc8:	68 40 6b 11 80       	push   $0x80116b40
80105fcd:	e8 4e e4 ff ff       	call   80104420 <sleep>
  while(ticks - ticks0 < n){
80105fd2:	a1 40 6b 11 80       	mov    0x80116b40,%eax
80105fd7:	83 c4 10             	add    $0x10,%esp
80105fda:	29 d8                	sub    %ebx,%eax
80105fdc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105fdf:	73 2f                	jae    80106010 <sys_sleep+0x90>
    if(myproc()->killed){
80105fe1:	e8 7a de ff ff       	call   80103e60 <myproc>
80105fe6:	8b 40 24             	mov    0x24(%eax),%eax
80105fe9:	85 c0                	test   %eax,%eax
80105feb:	74 d3                	je     80105fc0 <sys_sleep+0x40>
      release(&tickslock);
80105fed:	83 ec 0c             	sub    $0xc,%esp
80105ff0:	68 00 63 11 80       	push   $0x80116300
80105ff5:	e8 96 ec ff ff       	call   80104c90 <release>
  }
  release(&tickslock);
  return 0;
}
80105ffa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105ffd:	83 c4 10             	add    $0x10,%esp
80106000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106005:	c9                   	leave  
80106006:	c3                   	ret    
80106007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010600e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106010:	83 ec 0c             	sub    $0xc,%esp
80106013:	68 00 63 11 80       	push   $0x80116300
80106018:	e8 73 ec ff ff       	call   80104c90 <release>
  return 0;
8010601d:	83 c4 10             	add    $0x10,%esp
80106020:	31 c0                	xor    %eax,%eax
}
80106022:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106025:	c9                   	leave  
80106026:	c3                   	ret    
    return -1;
80106027:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010602c:	eb f4                	jmp    80106022 <sys_sleep+0xa2>
8010602e:	66 90                	xchg   %ax,%ax

80106030 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106030:	f3 0f 1e fb          	endbr32 
80106034:	55                   	push   %ebp
80106035:	89 e5                	mov    %esp,%ebp
80106037:	53                   	push   %ebx
80106038:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010603b:	68 00 63 11 80       	push   $0x80116300
80106040:	e8 8b eb ff ff       	call   80104bd0 <acquire>
  xticks = ticks;
80106045:	8b 1d 40 6b 11 80    	mov    0x80116b40,%ebx
  release(&tickslock);
8010604b:	c7 04 24 00 63 11 80 	movl   $0x80116300,(%esp)
80106052:	e8 39 ec ff ff       	call   80104c90 <release>
  return xticks;
}
80106057:	89 d8                	mov    %ebx,%eax
80106059:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010605c:	c9                   	leave  
8010605d:	c3                   	ret    
8010605e:	66 90                	xchg   %ax,%ax

80106060 <sys_find_digital_root>:

int
sys_find_digital_root(void)
{
80106060:	f3 0f 1e fb          	endbr32 
80106064:	55                   	push   %ebp
80106065:	89 e5                	mov    %esp,%ebp
80106067:	53                   	push   %ebx
80106068:	83 ec 04             	sub    $0x4,%esp
  int n = myproc()->tf->ebx;
8010606b:	e8 f0 dd ff ff       	call   80103e60 <myproc>
  cprintf("KERNEL: sys_find_digital_root(%d)\n", n);
80106070:	83 ec 08             	sub    $0x8,%esp
  int n = myproc()->tf->ebx;
80106073:	8b 40 18             	mov    0x18(%eax),%eax
80106076:	8b 58 10             	mov    0x10(%eax),%ebx
  cprintf("KERNEL: sys_find_digital_root(%d)\n", n);
80106079:	53                   	push   %ebx
8010607a:	68 0c 81 10 80       	push   $0x8010810c
8010607f:	e8 3c a8 ff ff       	call   801008c0 <cprintf>
  return find_digital_root(n);
80106084:	89 1c 24             	mov    %ebx,(%esp)
80106087:	e8 f4 e7 ff ff       	call   80104880 <find_digital_root>

}
8010608c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010608f:	c9                   	leave  
80106090:	c3                   	ret    

80106091 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106091:	1e                   	push   %ds
  pushl %es
80106092:	06                   	push   %es
  pushl %fs
80106093:	0f a0                	push   %fs
  pushl %gs
80106095:	0f a8                	push   %gs
  pushal
80106097:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106098:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010609c:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010609e:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801060a0:	54                   	push   %esp
  call trap
801060a1:	e8 ca 00 00 00       	call   80106170 <trap>
  addl $4, %esp
801060a6:	83 c4 04             	add    $0x4,%esp

801060a9 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801060a9:	61                   	popa   
  popl %gs
801060aa:	0f a9                	pop    %gs
  popl %fs
801060ac:	0f a1                	pop    %fs
  popl %es
801060ae:	07                   	pop    %es
  popl %ds
801060af:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801060b0:	83 c4 08             	add    $0x8,%esp
  iret
801060b3:	cf                   	iret   
801060b4:	66 90                	xchg   %ax,%ax
801060b6:	66 90                	xchg   %ax,%ax
801060b8:	66 90                	xchg   %ax,%ax
801060ba:	66 90                	xchg   %ax,%ax
801060bc:	66 90                	xchg   %ax,%ax
801060be:	66 90                	xchg   %ax,%ax

801060c0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801060c0:	f3 0f 1e fb          	endbr32 
801060c4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801060c5:	31 c0                	xor    %eax,%eax
{
801060c7:	89 e5                	mov    %esp,%ebp
801060c9:	83 ec 08             	sub    $0x8,%esp
801060cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801060d0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801060d7:	c7 04 c5 42 63 11 80 	movl   $0x8e000008,-0x7fee9cbe(,%eax,8)
801060de:	08 00 00 8e 
801060e2:	66 89 14 c5 40 63 11 	mov    %dx,-0x7fee9cc0(,%eax,8)
801060e9:	80 
801060ea:	c1 ea 10             	shr    $0x10,%edx
801060ed:	66 89 14 c5 46 63 11 	mov    %dx,-0x7fee9cba(,%eax,8)
801060f4:	80 
  for(i = 0; i < 256; i++)
801060f5:	83 c0 01             	add    $0x1,%eax
801060f8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060fd:	75 d1                	jne    801060d0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801060ff:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106102:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106107:	c7 05 42 65 11 80 08 	movl   $0xef000008,0x80116542
8010610e:	00 00 ef 
  initlock(&tickslock, "time");
80106111:	68 2f 81 10 80       	push   $0x8010812f
80106116:	68 00 63 11 80       	push   $0x80116300
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010611b:	66 a3 40 65 11 80    	mov    %ax,0x80116540
80106121:	c1 e8 10             	shr    $0x10,%eax
80106124:	66 a3 46 65 11 80    	mov    %ax,0x80116546
  initlock(&tickslock, "time");
8010612a:	e8 21 e9 ff ff       	call   80104a50 <initlock>
}
8010612f:	83 c4 10             	add    $0x10,%esp
80106132:	c9                   	leave  
80106133:	c3                   	ret    
80106134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010613b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop

80106140 <idtinit>:

void
idtinit(void)
{
80106140:	f3 0f 1e fb          	endbr32 
80106144:	55                   	push   %ebp
  pd[0] = size-1;
80106145:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010614a:	89 e5                	mov    %esp,%ebp
8010614c:	83 ec 10             	sub    $0x10,%esp
8010614f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106153:	b8 40 63 11 80       	mov    $0x80116340,%eax
80106158:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010615c:	c1 e8 10             	shr    $0x10,%eax
8010615f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106163:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106166:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106169:	c9                   	leave  
8010616a:	c3                   	ret    
8010616b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010616f:	90                   	nop

80106170 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106170:	f3 0f 1e fb          	endbr32 
80106174:	55                   	push   %ebp
80106175:	89 e5                	mov    %esp,%ebp
80106177:	57                   	push   %edi
80106178:	56                   	push   %esi
80106179:	53                   	push   %ebx
8010617a:	83 ec 1c             	sub    $0x1c,%esp
8010617d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106180:	8b 43 30             	mov    0x30(%ebx),%eax
80106183:	83 f8 40             	cmp    $0x40,%eax
80106186:	0f 84 bc 01 00 00    	je     80106348 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010618c:	83 e8 20             	sub    $0x20,%eax
8010618f:	83 f8 1f             	cmp    $0x1f,%eax
80106192:	77 08                	ja     8010619c <trap+0x2c>
80106194:	3e ff 24 85 d8 81 10 	notrack jmp *-0x7fef7e28(,%eax,4)
8010619b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010619c:	e8 bf dc ff ff       	call   80103e60 <myproc>
801061a1:	8b 7b 38             	mov    0x38(%ebx),%edi
801061a4:	85 c0                	test   %eax,%eax
801061a6:	0f 84 eb 01 00 00    	je     80106397 <trap+0x227>
801061ac:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801061b0:	0f 84 e1 01 00 00    	je     80106397 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801061b6:	0f 20 d1             	mov    %cr2,%ecx
801061b9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061bc:	e8 7f dc ff ff       	call   80103e40 <cpuid>
801061c1:	8b 73 30             	mov    0x30(%ebx),%esi
801061c4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801061c7:	8b 43 34             	mov    0x34(%ebx),%eax
801061ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801061cd:	e8 8e dc ff ff       	call   80103e60 <myproc>
801061d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061d5:	e8 86 dc ff ff       	call   80103e60 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061da:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061dd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061e0:	51                   	push   %ecx
801061e1:	57                   	push   %edi
801061e2:	52                   	push   %edx
801061e3:	ff 75 e4             	pushl  -0x1c(%ebp)
801061e6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801061e7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801061ea:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061ed:	56                   	push   %esi
801061ee:	ff 70 10             	pushl  0x10(%eax)
801061f1:	68 94 81 10 80       	push   $0x80108194
801061f6:	e8 c5 a6 ff ff       	call   801008c0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801061fb:	83 c4 20             	add    $0x20,%esp
801061fe:	e8 5d dc ff ff       	call   80103e60 <myproc>
80106203:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010620a:	e8 51 dc ff ff       	call   80103e60 <myproc>
8010620f:	85 c0                	test   %eax,%eax
80106211:	74 1d                	je     80106230 <trap+0xc0>
80106213:	e8 48 dc ff ff       	call   80103e60 <myproc>
80106218:	8b 50 24             	mov    0x24(%eax),%edx
8010621b:	85 d2                	test   %edx,%edx
8010621d:	74 11                	je     80106230 <trap+0xc0>
8010621f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106223:	83 e0 03             	and    $0x3,%eax
80106226:	66 83 f8 03          	cmp    $0x3,%ax
8010622a:	0f 84 50 01 00 00    	je     80106380 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106230:	e8 2b dc ff ff       	call   80103e60 <myproc>
80106235:	85 c0                	test   %eax,%eax
80106237:	74 0f                	je     80106248 <trap+0xd8>
80106239:	e8 22 dc ff ff       	call   80103e60 <myproc>
8010623e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106242:	0f 84 e8 00 00 00    	je     80106330 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106248:	e8 13 dc ff ff       	call   80103e60 <myproc>
8010624d:	85 c0                	test   %eax,%eax
8010624f:	74 1d                	je     8010626e <trap+0xfe>
80106251:	e8 0a dc ff ff       	call   80103e60 <myproc>
80106256:	8b 40 24             	mov    0x24(%eax),%eax
80106259:	85 c0                	test   %eax,%eax
8010625b:	74 11                	je     8010626e <trap+0xfe>
8010625d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106261:	83 e0 03             	and    $0x3,%eax
80106264:	66 83 f8 03          	cmp    $0x3,%ax
80106268:	0f 84 03 01 00 00    	je     80106371 <trap+0x201>
    exit();
}
8010626e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106271:	5b                   	pop    %ebx
80106272:	5e                   	pop    %esi
80106273:	5f                   	pop    %edi
80106274:	5d                   	pop    %ebp
80106275:	c3                   	ret    
    ideintr();
80106276:	e8 55 c4 ff ff       	call   801026d0 <ideintr>
    lapiceoi();
8010627b:	e8 30 cb ff ff       	call   80102db0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106280:	e8 db db ff ff       	call   80103e60 <myproc>
80106285:	85 c0                	test   %eax,%eax
80106287:	75 8a                	jne    80106213 <trap+0xa3>
80106289:	eb a5                	jmp    80106230 <trap+0xc0>
    if(cpuid() == 0){
8010628b:	e8 b0 db ff ff       	call   80103e40 <cpuid>
80106290:	85 c0                	test   %eax,%eax
80106292:	75 e7                	jne    8010627b <trap+0x10b>
      acquire(&tickslock);
80106294:	83 ec 0c             	sub    $0xc,%esp
80106297:	68 00 63 11 80       	push   $0x80116300
8010629c:	e8 2f e9 ff ff       	call   80104bd0 <acquire>
      wakeup(&ticks);
801062a1:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
      ticks++;
801062a8:	83 05 40 6b 11 80 01 	addl   $0x1,0x80116b40
      wakeup(&ticks);
801062af:	e8 2c e3 ff ff       	call   801045e0 <wakeup>
      release(&tickslock);
801062b4:	c7 04 24 00 63 11 80 	movl   $0x80116300,(%esp)
801062bb:	e8 d0 e9 ff ff       	call   80104c90 <release>
801062c0:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801062c3:	eb b6                	jmp    8010627b <trap+0x10b>
    kbdintr();
801062c5:	e8 a6 c9 ff ff       	call   80102c70 <kbdintr>
    lapiceoi();
801062ca:	e8 e1 ca ff ff       	call   80102db0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062cf:	e8 8c db ff ff       	call   80103e60 <myproc>
801062d4:	85 c0                	test   %eax,%eax
801062d6:	0f 85 37 ff ff ff    	jne    80106213 <trap+0xa3>
801062dc:	e9 4f ff ff ff       	jmp    80106230 <trap+0xc0>
    uartintr();
801062e1:	e8 4a 02 00 00       	call   80106530 <uartintr>
    lapiceoi();
801062e6:	e8 c5 ca ff ff       	call   80102db0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062eb:	e8 70 db ff ff       	call   80103e60 <myproc>
801062f0:	85 c0                	test   %eax,%eax
801062f2:	0f 85 1b ff ff ff    	jne    80106213 <trap+0xa3>
801062f8:	e9 33 ff ff ff       	jmp    80106230 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062fd:	8b 7b 38             	mov    0x38(%ebx),%edi
80106300:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106304:	e8 37 db ff ff       	call   80103e40 <cpuid>
80106309:	57                   	push   %edi
8010630a:	56                   	push   %esi
8010630b:	50                   	push   %eax
8010630c:	68 3c 81 10 80       	push   $0x8010813c
80106311:	e8 aa a5 ff ff       	call   801008c0 <cprintf>
    lapiceoi();
80106316:	e8 95 ca ff ff       	call   80102db0 <lapiceoi>
    break;
8010631b:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010631e:	e8 3d db ff ff       	call   80103e60 <myproc>
80106323:	85 c0                	test   %eax,%eax
80106325:	0f 85 e8 fe ff ff    	jne    80106213 <trap+0xa3>
8010632b:	e9 00 ff ff ff       	jmp    80106230 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106330:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106334:	0f 85 0e ff ff ff    	jne    80106248 <trap+0xd8>
    yield();
8010633a:	e8 91 e0 ff ff       	call   801043d0 <yield>
8010633f:	e9 04 ff ff ff       	jmp    80106248 <trap+0xd8>
80106344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106348:	e8 13 db ff ff       	call   80103e60 <myproc>
8010634d:	8b 70 24             	mov    0x24(%eax),%esi
80106350:	85 f6                	test   %esi,%esi
80106352:	75 3c                	jne    80106390 <trap+0x220>
    myproc()->tf = tf;
80106354:	e8 07 db ff ff       	call   80103e60 <myproc>
80106359:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010635c:	e8 4f ed ff ff       	call   801050b0 <syscall>
    if(myproc()->killed)
80106361:	e8 fa da ff ff       	call   80103e60 <myproc>
80106366:	8b 48 24             	mov    0x24(%eax),%ecx
80106369:	85 c9                	test   %ecx,%ecx
8010636b:	0f 84 fd fe ff ff    	je     8010626e <trap+0xfe>
}
80106371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106374:	5b                   	pop    %ebx
80106375:	5e                   	pop    %esi
80106376:	5f                   	pop    %edi
80106377:	5d                   	pop    %ebp
      exit();
80106378:	e9 13 df ff ff       	jmp    80104290 <exit>
8010637d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106380:	e8 0b df ff ff       	call   80104290 <exit>
80106385:	e9 a6 fe ff ff       	jmp    80106230 <trap+0xc0>
8010638a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106390:	e8 fb de ff ff       	call   80104290 <exit>
80106395:	eb bd                	jmp    80106354 <trap+0x1e4>
80106397:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010639a:	e8 a1 da ff ff       	call   80103e40 <cpuid>
8010639f:	83 ec 0c             	sub    $0xc,%esp
801063a2:	56                   	push   %esi
801063a3:	57                   	push   %edi
801063a4:	50                   	push   %eax
801063a5:	ff 73 30             	pushl  0x30(%ebx)
801063a8:	68 60 81 10 80       	push   $0x80108160
801063ad:	e8 0e a5 ff ff       	call   801008c0 <cprintf>
      panic("trap");
801063b2:	83 c4 14             	add    $0x14,%esp
801063b5:	68 34 81 10 80       	push   $0x80108134
801063ba:	e8 d1 9f ff ff       	call   80100390 <panic>
801063bf:	90                   	nop

801063c0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801063c0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801063c4:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
801063c9:	85 c0                	test   %eax,%eax
801063cb:	74 1b                	je     801063e8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801063cd:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063d2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801063d3:	a8 01                	test   $0x1,%al
801063d5:	74 11                	je     801063e8 <uartgetc+0x28>
801063d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063dc:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801063dd:	0f b6 c0             	movzbl %al,%eax
801063e0:	c3                   	ret    
801063e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063ed:	c3                   	ret    
801063ee:	66 90                	xchg   %ax,%ax

801063f0 <uartputc.part.0>:
uartputc(int c)
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	57                   	push   %edi
801063f4:	89 c7                	mov    %eax,%edi
801063f6:	56                   	push   %esi
801063f7:	be fd 03 00 00       	mov    $0x3fd,%esi
801063fc:	53                   	push   %ebx
801063fd:	bb 80 00 00 00       	mov    $0x80,%ebx
80106402:	83 ec 0c             	sub    $0xc,%esp
80106405:	eb 1b                	jmp    80106422 <uartputc.part.0+0x32>
80106407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010640e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106410:	83 ec 0c             	sub    $0xc,%esp
80106413:	6a 0a                	push   $0xa
80106415:	e8 b6 c9 ff ff       	call   80102dd0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010641a:	83 c4 10             	add    $0x10,%esp
8010641d:	83 eb 01             	sub    $0x1,%ebx
80106420:	74 07                	je     80106429 <uartputc.part.0+0x39>
80106422:	89 f2                	mov    %esi,%edx
80106424:	ec                   	in     (%dx),%al
80106425:	a8 20                	test   $0x20,%al
80106427:	74 e7                	je     80106410 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106429:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010642e:	89 f8                	mov    %edi,%eax
80106430:	ee                   	out    %al,(%dx)
}
80106431:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106434:	5b                   	pop    %ebx
80106435:	5e                   	pop    %esi
80106436:	5f                   	pop    %edi
80106437:	5d                   	pop    %ebp
80106438:	c3                   	ret    
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106440 <uartinit>:
{
80106440:	f3 0f 1e fb          	endbr32 
80106444:	55                   	push   %ebp
80106445:	31 c9                	xor    %ecx,%ecx
80106447:	89 c8                	mov    %ecx,%eax
80106449:	89 e5                	mov    %esp,%ebp
8010644b:	57                   	push   %edi
8010644c:	56                   	push   %esi
8010644d:	53                   	push   %ebx
8010644e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106453:	89 da                	mov    %ebx,%edx
80106455:	83 ec 0c             	sub    $0xc,%esp
80106458:	ee                   	out    %al,(%dx)
80106459:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010645e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106463:	89 fa                	mov    %edi,%edx
80106465:	ee                   	out    %al,(%dx)
80106466:	b8 0c 00 00 00       	mov    $0xc,%eax
8010646b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106470:	ee                   	out    %al,(%dx)
80106471:	be f9 03 00 00       	mov    $0x3f9,%esi
80106476:	89 c8                	mov    %ecx,%eax
80106478:	89 f2                	mov    %esi,%edx
8010647a:	ee                   	out    %al,(%dx)
8010647b:	b8 03 00 00 00       	mov    $0x3,%eax
80106480:	89 fa                	mov    %edi,%edx
80106482:	ee                   	out    %al,(%dx)
80106483:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106488:	89 c8                	mov    %ecx,%eax
8010648a:	ee                   	out    %al,(%dx)
8010648b:	b8 01 00 00 00       	mov    $0x1,%eax
80106490:	89 f2                	mov    %esi,%edx
80106492:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106493:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106498:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106499:	3c ff                	cmp    $0xff,%al
8010649b:	74 52                	je     801064ef <uartinit+0xaf>
  uart = 1;
8010649d:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
801064a4:	00 00 00 
801064a7:	89 da                	mov    %ebx,%edx
801064a9:	ec                   	in     (%dx),%al
801064aa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064af:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801064b0:	83 ec 08             	sub    $0x8,%esp
801064b3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
801064b8:	bb 58 82 10 80       	mov    $0x80108258,%ebx
  ioapicenable(IRQ_COM1, 0);
801064bd:	6a 00                	push   $0x0
801064bf:	6a 04                	push   $0x4
801064c1:	e8 5a c4 ff ff       	call   80102920 <ioapicenable>
801064c6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801064c9:	b8 78 00 00 00       	mov    $0x78,%eax
801064ce:	eb 04                	jmp    801064d4 <uartinit+0x94>
801064d0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801064d4:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801064da:	85 d2                	test   %edx,%edx
801064dc:	74 08                	je     801064e6 <uartinit+0xa6>
    uartputc(*p);
801064de:	0f be c0             	movsbl %al,%eax
801064e1:	e8 0a ff ff ff       	call   801063f0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801064e6:	89 f0                	mov    %esi,%eax
801064e8:	83 c3 01             	add    $0x1,%ebx
801064eb:	84 c0                	test   %al,%al
801064ed:	75 e1                	jne    801064d0 <uartinit+0x90>
}
801064ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064f2:	5b                   	pop    %ebx
801064f3:	5e                   	pop    %esi
801064f4:	5f                   	pop    %edi
801064f5:	5d                   	pop    %ebp
801064f6:	c3                   	ret    
801064f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064fe:	66 90                	xchg   %ax,%ax

80106500 <uartputc>:
{
80106500:	f3 0f 1e fb          	endbr32 
80106504:	55                   	push   %ebp
  if(!uart)
80106505:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
8010650b:	89 e5                	mov    %esp,%ebp
8010650d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106510:	85 d2                	test   %edx,%edx
80106512:	74 0c                	je     80106520 <uartputc+0x20>
}
80106514:	5d                   	pop    %ebp
80106515:	e9 d6 fe ff ff       	jmp    801063f0 <uartputc.part.0>
8010651a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106520:	5d                   	pop    %ebp
80106521:	c3                   	ret    
80106522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106530 <uartintr>:

void
uartintr(void)
{
80106530:	f3 0f 1e fb          	endbr32 
80106534:	55                   	push   %ebp
80106535:	89 e5                	mov    %esp,%ebp
80106537:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010653a:	68 c0 63 10 80       	push   $0x801063c0
8010653f:	e8 2c a5 ff ff       	call   80100a70 <consoleintr>
}
80106544:	83 c4 10             	add    $0x10,%esp
80106547:	c9                   	leave  
80106548:	c3                   	ret    

80106549 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106549:	6a 00                	push   $0x0
  pushl $0
8010654b:	6a 00                	push   $0x0
  jmp alltraps
8010654d:	e9 3f fb ff ff       	jmp    80106091 <alltraps>

80106552 <vector1>:
.globl vector1
vector1:
  pushl $0
80106552:	6a 00                	push   $0x0
  pushl $1
80106554:	6a 01                	push   $0x1
  jmp alltraps
80106556:	e9 36 fb ff ff       	jmp    80106091 <alltraps>

8010655b <vector2>:
.globl vector2
vector2:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $2
8010655d:	6a 02                	push   $0x2
  jmp alltraps
8010655f:	e9 2d fb ff ff       	jmp    80106091 <alltraps>

80106564 <vector3>:
.globl vector3
vector3:
  pushl $0
80106564:	6a 00                	push   $0x0
  pushl $3
80106566:	6a 03                	push   $0x3
  jmp alltraps
80106568:	e9 24 fb ff ff       	jmp    80106091 <alltraps>

8010656d <vector4>:
.globl vector4
vector4:
  pushl $0
8010656d:	6a 00                	push   $0x0
  pushl $4
8010656f:	6a 04                	push   $0x4
  jmp alltraps
80106571:	e9 1b fb ff ff       	jmp    80106091 <alltraps>

80106576 <vector5>:
.globl vector5
vector5:
  pushl $0
80106576:	6a 00                	push   $0x0
  pushl $5
80106578:	6a 05                	push   $0x5
  jmp alltraps
8010657a:	e9 12 fb ff ff       	jmp    80106091 <alltraps>

8010657f <vector6>:
.globl vector6
vector6:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $6
80106581:	6a 06                	push   $0x6
  jmp alltraps
80106583:	e9 09 fb ff ff       	jmp    80106091 <alltraps>

80106588 <vector7>:
.globl vector7
vector7:
  pushl $0
80106588:	6a 00                	push   $0x0
  pushl $7
8010658a:	6a 07                	push   $0x7
  jmp alltraps
8010658c:	e9 00 fb ff ff       	jmp    80106091 <alltraps>

80106591 <vector8>:
.globl vector8
vector8:
  pushl $8
80106591:	6a 08                	push   $0x8
  jmp alltraps
80106593:	e9 f9 fa ff ff       	jmp    80106091 <alltraps>

80106598 <vector9>:
.globl vector9
vector9:
  pushl $0
80106598:	6a 00                	push   $0x0
  pushl $9
8010659a:	6a 09                	push   $0x9
  jmp alltraps
8010659c:	e9 f0 fa ff ff       	jmp    80106091 <alltraps>

801065a1 <vector10>:
.globl vector10
vector10:
  pushl $10
801065a1:	6a 0a                	push   $0xa
  jmp alltraps
801065a3:	e9 e9 fa ff ff       	jmp    80106091 <alltraps>

801065a8 <vector11>:
.globl vector11
vector11:
  pushl $11
801065a8:	6a 0b                	push   $0xb
  jmp alltraps
801065aa:	e9 e2 fa ff ff       	jmp    80106091 <alltraps>

801065af <vector12>:
.globl vector12
vector12:
  pushl $12
801065af:	6a 0c                	push   $0xc
  jmp alltraps
801065b1:	e9 db fa ff ff       	jmp    80106091 <alltraps>

801065b6 <vector13>:
.globl vector13
vector13:
  pushl $13
801065b6:	6a 0d                	push   $0xd
  jmp alltraps
801065b8:	e9 d4 fa ff ff       	jmp    80106091 <alltraps>

801065bd <vector14>:
.globl vector14
vector14:
  pushl $14
801065bd:	6a 0e                	push   $0xe
  jmp alltraps
801065bf:	e9 cd fa ff ff       	jmp    80106091 <alltraps>

801065c4 <vector15>:
.globl vector15
vector15:
  pushl $0
801065c4:	6a 00                	push   $0x0
  pushl $15
801065c6:	6a 0f                	push   $0xf
  jmp alltraps
801065c8:	e9 c4 fa ff ff       	jmp    80106091 <alltraps>

801065cd <vector16>:
.globl vector16
vector16:
  pushl $0
801065cd:	6a 00                	push   $0x0
  pushl $16
801065cf:	6a 10                	push   $0x10
  jmp alltraps
801065d1:	e9 bb fa ff ff       	jmp    80106091 <alltraps>

801065d6 <vector17>:
.globl vector17
vector17:
  pushl $17
801065d6:	6a 11                	push   $0x11
  jmp alltraps
801065d8:	e9 b4 fa ff ff       	jmp    80106091 <alltraps>

801065dd <vector18>:
.globl vector18
vector18:
  pushl $0
801065dd:	6a 00                	push   $0x0
  pushl $18
801065df:	6a 12                	push   $0x12
  jmp alltraps
801065e1:	e9 ab fa ff ff       	jmp    80106091 <alltraps>

801065e6 <vector19>:
.globl vector19
vector19:
  pushl $0
801065e6:	6a 00                	push   $0x0
  pushl $19
801065e8:	6a 13                	push   $0x13
  jmp alltraps
801065ea:	e9 a2 fa ff ff       	jmp    80106091 <alltraps>

801065ef <vector20>:
.globl vector20
vector20:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $20
801065f1:	6a 14                	push   $0x14
  jmp alltraps
801065f3:	e9 99 fa ff ff       	jmp    80106091 <alltraps>

801065f8 <vector21>:
.globl vector21
vector21:
  pushl $0
801065f8:	6a 00                	push   $0x0
  pushl $21
801065fa:	6a 15                	push   $0x15
  jmp alltraps
801065fc:	e9 90 fa ff ff       	jmp    80106091 <alltraps>

80106601 <vector22>:
.globl vector22
vector22:
  pushl $0
80106601:	6a 00                	push   $0x0
  pushl $22
80106603:	6a 16                	push   $0x16
  jmp alltraps
80106605:	e9 87 fa ff ff       	jmp    80106091 <alltraps>

8010660a <vector23>:
.globl vector23
vector23:
  pushl $0
8010660a:	6a 00                	push   $0x0
  pushl $23
8010660c:	6a 17                	push   $0x17
  jmp alltraps
8010660e:	e9 7e fa ff ff       	jmp    80106091 <alltraps>

80106613 <vector24>:
.globl vector24
vector24:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $24
80106615:	6a 18                	push   $0x18
  jmp alltraps
80106617:	e9 75 fa ff ff       	jmp    80106091 <alltraps>

8010661c <vector25>:
.globl vector25
vector25:
  pushl $0
8010661c:	6a 00                	push   $0x0
  pushl $25
8010661e:	6a 19                	push   $0x19
  jmp alltraps
80106620:	e9 6c fa ff ff       	jmp    80106091 <alltraps>

80106625 <vector26>:
.globl vector26
vector26:
  pushl $0
80106625:	6a 00                	push   $0x0
  pushl $26
80106627:	6a 1a                	push   $0x1a
  jmp alltraps
80106629:	e9 63 fa ff ff       	jmp    80106091 <alltraps>

8010662e <vector27>:
.globl vector27
vector27:
  pushl $0
8010662e:	6a 00                	push   $0x0
  pushl $27
80106630:	6a 1b                	push   $0x1b
  jmp alltraps
80106632:	e9 5a fa ff ff       	jmp    80106091 <alltraps>

80106637 <vector28>:
.globl vector28
vector28:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $28
80106639:	6a 1c                	push   $0x1c
  jmp alltraps
8010663b:	e9 51 fa ff ff       	jmp    80106091 <alltraps>

80106640 <vector29>:
.globl vector29
vector29:
  pushl $0
80106640:	6a 00                	push   $0x0
  pushl $29
80106642:	6a 1d                	push   $0x1d
  jmp alltraps
80106644:	e9 48 fa ff ff       	jmp    80106091 <alltraps>

80106649 <vector30>:
.globl vector30
vector30:
  pushl $0
80106649:	6a 00                	push   $0x0
  pushl $30
8010664b:	6a 1e                	push   $0x1e
  jmp alltraps
8010664d:	e9 3f fa ff ff       	jmp    80106091 <alltraps>

80106652 <vector31>:
.globl vector31
vector31:
  pushl $0
80106652:	6a 00                	push   $0x0
  pushl $31
80106654:	6a 1f                	push   $0x1f
  jmp alltraps
80106656:	e9 36 fa ff ff       	jmp    80106091 <alltraps>

8010665b <vector32>:
.globl vector32
vector32:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $32
8010665d:	6a 20                	push   $0x20
  jmp alltraps
8010665f:	e9 2d fa ff ff       	jmp    80106091 <alltraps>

80106664 <vector33>:
.globl vector33
vector33:
  pushl $0
80106664:	6a 00                	push   $0x0
  pushl $33
80106666:	6a 21                	push   $0x21
  jmp alltraps
80106668:	e9 24 fa ff ff       	jmp    80106091 <alltraps>

8010666d <vector34>:
.globl vector34
vector34:
  pushl $0
8010666d:	6a 00                	push   $0x0
  pushl $34
8010666f:	6a 22                	push   $0x22
  jmp alltraps
80106671:	e9 1b fa ff ff       	jmp    80106091 <alltraps>

80106676 <vector35>:
.globl vector35
vector35:
  pushl $0
80106676:	6a 00                	push   $0x0
  pushl $35
80106678:	6a 23                	push   $0x23
  jmp alltraps
8010667a:	e9 12 fa ff ff       	jmp    80106091 <alltraps>

8010667f <vector36>:
.globl vector36
vector36:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $36
80106681:	6a 24                	push   $0x24
  jmp alltraps
80106683:	e9 09 fa ff ff       	jmp    80106091 <alltraps>

80106688 <vector37>:
.globl vector37
vector37:
  pushl $0
80106688:	6a 00                	push   $0x0
  pushl $37
8010668a:	6a 25                	push   $0x25
  jmp alltraps
8010668c:	e9 00 fa ff ff       	jmp    80106091 <alltraps>

80106691 <vector38>:
.globl vector38
vector38:
  pushl $0
80106691:	6a 00                	push   $0x0
  pushl $38
80106693:	6a 26                	push   $0x26
  jmp alltraps
80106695:	e9 f7 f9 ff ff       	jmp    80106091 <alltraps>

8010669a <vector39>:
.globl vector39
vector39:
  pushl $0
8010669a:	6a 00                	push   $0x0
  pushl $39
8010669c:	6a 27                	push   $0x27
  jmp alltraps
8010669e:	e9 ee f9 ff ff       	jmp    80106091 <alltraps>

801066a3 <vector40>:
.globl vector40
vector40:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $40
801066a5:	6a 28                	push   $0x28
  jmp alltraps
801066a7:	e9 e5 f9 ff ff       	jmp    80106091 <alltraps>

801066ac <vector41>:
.globl vector41
vector41:
  pushl $0
801066ac:	6a 00                	push   $0x0
  pushl $41
801066ae:	6a 29                	push   $0x29
  jmp alltraps
801066b0:	e9 dc f9 ff ff       	jmp    80106091 <alltraps>

801066b5 <vector42>:
.globl vector42
vector42:
  pushl $0
801066b5:	6a 00                	push   $0x0
  pushl $42
801066b7:	6a 2a                	push   $0x2a
  jmp alltraps
801066b9:	e9 d3 f9 ff ff       	jmp    80106091 <alltraps>

801066be <vector43>:
.globl vector43
vector43:
  pushl $0
801066be:	6a 00                	push   $0x0
  pushl $43
801066c0:	6a 2b                	push   $0x2b
  jmp alltraps
801066c2:	e9 ca f9 ff ff       	jmp    80106091 <alltraps>

801066c7 <vector44>:
.globl vector44
vector44:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $44
801066c9:	6a 2c                	push   $0x2c
  jmp alltraps
801066cb:	e9 c1 f9 ff ff       	jmp    80106091 <alltraps>

801066d0 <vector45>:
.globl vector45
vector45:
  pushl $0
801066d0:	6a 00                	push   $0x0
  pushl $45
801066d2:	6a 2d                	push   $0x2d
  jmp alltraps
801066d4:	e9 b8 f9 ff ff       	jmp    80106091 <alltraps>

801066d9 <vector46>:
.globl vector46
vector46:
  pushl $0
801066d9:	6a 00                	push   $0x0
  pushl $46
801066db:	6a 2e                	push   $0x2e
  jmp alltraps
801066dd:	e9 af f9 ff ff       	jmp    80106091 <alltraps>

801066e2 <vector47>:
.globl vector47
vector47:
  pushl $0
801066e2:	6a 00                	push   $0x0
  pushl $47
801066e4:	6a 2f                	push   $0x2f
  jmp alltraps
801066e6:	e9 a6 f9 ff ff       	jmp    80106091 <alltraps>

801066eb <vector48>:
.globl vector48
vector48:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $48
801066ed:	6a 30                	push   $0x30
  jmp alltraps
801066ef:	e9 9d f9 ff ff       	jmp    80106091 <alltraps>

801066f4 <vector49>:
.globl vector49
vector49:
  pushl $0
801066f4:	6a 00                	push   $0x0
  pushl $49
801066f6:	6a 31                	push   $0x31
  jmp alltraps
801066f8:	e9 94 f9 ff ff       	jmp    80106091 <alltraps>

801066fd <vector50>:
.globl vector50
vector50:
  pushl $0
801066fd:	6a 00                	push   $0x0
  pushl $50
801066ff:	6a 32                	push   $0x32
  jmp alltraps
80106701:	e9 8b f9 ff ff       	jmp    80106091 <alltraps>

80106706 <vector51>:
.globl vector51
vector51:
  pushl $0
80106706:	6a 00                	push   $0x0
  pushl $51
80106708:	6a 33                	push   $0x33
  jmp alltraps
8010670a:	e9 82 f9 ff ff       	jmp    80106091 <alltraps>

8010670f <vector52>:
.globl vector52
vector52:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $52
80106711:	6a 34                	push   $0x34
  jmp alltraps
80106713:	e9 79 f9 ff ff       	jmp    80106091 <alltraps>

80106718 <vector53>:
.globl vector53
vector53:
  pushl $0
80106718:	6a 00                	push   $0x0
  pushl $53
8010671a:	6a 35                	push   $0x35
  jmp alltraps
8010671c:	e9 70 f9 ff ff       	jmp    80106091 <alltraps>

80106721 <vector54>:
.globl vector54
vector54:
  pushl $0
80106721:	6a 00                	push   $0x0
  pushl $54
80106723:	6a 36                	push   $0x36
  jmp alltraps
80106725:	e9 67 f9 ff ff       	jmp    80106091 <alltraps>

8010672a <vector55>:
.globl vector55
vector55:
  pushl $0
8010672a:	6a 00                	push   $0x0
  pushl $55
8010672c:	6a 37                	push   $0x37
  jmp alltraps
8010672e:	e9 5e f9 ff ff       	jmp    80106091 <alltraps>

80106733 <vector56>:
.globl vector56
vector56:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $56
80106735:	6a 38                	push   $0x38
  jmp alltraps
80106737:	e9 55 f9 ff ff       	jmp    80106091 <alltraps>

8010673c <vector57>:
.globl vector57
vector57:
  pushl $0
8010673c:	6a 00                	push   $0x0
  pushl $57
8010673e:	6a 39                	push   $0x39
  jmp alltraps
80106740:	e9 4c f9 ff ff       	jmp    80106091 <alltraps>

80106745 <vector58>:
.globl vector58
vector58:
  pushl $0
80106745:	6a 00                	push   $0x0
  pushl $58
80106747:	6a 3a                	push   $0x3a
  jmp alltraps
80106749:	e9 43 f9 ff ff       	jmp    80106091 <alltraps>

8010674e <vector59>:
.globl vector59
vector59:
  pushl $0
8010674e:	6a 00                	push   $0x0
  pushl $59
80106750:	6a 3b                	push   $0x3b
  jmp alltraps
80106752:	e9 3a f9 ff ff       	jmp    80106091 <alltraps>

80106757 <vector60>:
.globl vector60
vector60:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $60
80106759:	6a 3c                	push   $0x3c
  jmp alltraps
8010675b:	e9 31 f9 ff ff       	jmp    80106091 <alltraps>

80106760 <vector61>:
.globl vector61
vector61:
  pushl $0
80106760:	6a 00                	push   $0x0
  pushl $61
80106762:	6a 3d                	push   $0x3d
  jmp alltraps
80106764:	e9 28 f9 ff ff       	jmp    80106091 <alltraps>

80106769 <vector62>:
.globl vector62
vector62:
  pushl $0
80106769:	6a 00                	push   $0x0
  pushl $62
8010676b:	6a 3e                	push   $0x3e
  jmp alltraps
8010676d:	e9 1f f9 ff ff       	jmp    80106091 <alltraps>

80106772 <vector63>:
.globl vector63
vector63:
  pushl $0
80106772:	6a 00                	push   $0x0
  pushl $63
80106774:	6a 3f                	push   $0x3f
  jmp alltraps
80106776:	e9 16 f9 ff ff       	jmp    80106091 <alltraps>

8010677b <vector64>:
.globl vector64
vector64:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $64
8010677d:	6a 40                	push   $0x40
  jmp alltraps
8010677f:	e9 0d f9 ff ff       	jmp    80106091 <alltraps>

80106784 <vector65>:
.globl vector65
vector65:
  pushl $0
80106784:	6a 00                	push   $0x0
  pushl $65
80106786:	6a 41                	push   $0x41
  jmp alltraps
80106788:	e9 04 f9 ff ff       	jmp    80106091 <alltraps>

8010678d <vector66>:
.globl vector66
vector66:
  pushl $0
8010678d:	6a 00                	push   $0x0
  pushl $66
8010678f:	6a 42                	push   $0x42
  jmp alltraps
80106791:	e9 fb f8 ff ff       	jmp    80106091 <alltraps>

80106796 <vector67>:
.globl vector67
vector67:
  pushl $0
80106796:	6a 00                	push   $0x0
  pushl $67
80106798:	6a 43                	push   $0x43
  jmp alltraps
8010679a:	e9 f2 f8 ff ff       	jmp    80106091 <alltraps>

8010679f <vector68>:
.globl vector68
vector68:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $68
801067a1:	6a 44                	push   $0x44
  jmp alltraps
801067a3:	e9 e9 f8 ff ff       	jmp    80106091 <alltraps>

801067a8 <vector69>:
.globl vector69
vector69:
  pushl $0
801067a8:	6a 00                	push   $0x0
  pushl $69
801067aa:	6a 45                	push   $0x45
  jmp alltraps
801067ac:	e9 e0 f8 ff ff       	jmp    80106091 <alltraps>

801067b1 <vector70>:
.globl vector70
vector70:
  pushl $0
801067b1:	6a 00                	push   $0x0
  pushl $70
801067b3:	6a 46                	push   $0x46
  jmp alltraps
801067b5:	e9 d7 f8 ff ff       	jmp    80106091 <alltraps>

801067ba <vector71>:
.globl vector71
vector71:
  pushl $0
801067ba:	6a 00                	push   $0x0
  pushl $71
801067bc:	6a 47                	push   $0x47
  jmp alltraps
801067be:	e9 ce f8 ff ff       	jmp    80106091 <alltraps>

801067c3 <vector72>:
.globl vector72
vector72:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $72
801067c5:	6a 48                	push   $0x48
  jmp alltraps
801067c7:	e9 c5 f8 ff ff       	jmp    80106091 <alltraps>

801067cc <vector73>:
.globl vector73
vector73:
  pushl $0
801067cc:	6a 00                	push   $0x0
  pushl $73
801067ce:	6a 49                	push   $0x49
  jmp alltraps
801067d0:	e9 bc f8 ff ff       	jmp    80106091 <alltraps>

801067d5 <vector74>:
.globl vector74
vector74:
  pushl $0
801067d5:	6a 00                	push   $0x0
  pushl $74
801067d7:	6a 4a                	push   $0x4a
  jmp alltraps
801067d9:	e9 b3 f8 ff ff       	jmp    80106091 <alltraps>

801067de <vector75>:
.globl vector75
vector75:
  pushl $0
801067de:	6a 00                	push   $0x0
  pushl $75
801067e0:	6a 4b                	push   $0x4b
  jmp alltraps
801067e2:	e9 aa f8 ff ff       	jmp    80106091 <alltraps>

801067e7 <vector76>:
.globl vector76
vector76:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $76
801067e9:	6a 4c                	push   $0x4c
  jmp alltraps
801067eb:	e9 a1 f8 ff ff       	jmp    80106091 <alltraps>

801067f0 <vector77>:
.globl vector77
vector77:
  pushl $0
801067f0:	6a 00                	push   $0x0
  pushl $77
801067f2:	6a 4d                	push   $0x4d
  jmp alltraps
801067f4:	e9 98 f8 ff ff       	jmp    80106091 <alltraps>

801067f9 <vector78>:
.globl vector78
vector78:
  pushl $0
801067f9:	6a 00                	push   $0x0
  pushl $78
801067fb:	6a 4e                	push   $0x4e
  jmp alltraps
801067fd:	e9 8f f8 ff ff       	jmp    80106091 <alltraps>

80106802 <vector79>:
.globl vector79
vector79:
  pushl $0
80106802:	6a 00                	push   $0x0
  pushl $79
80106804:	6a 4f                	push   $0x4f
  jmp alltraps
80106806:	e9 86 f8 ff ff       	jmp    80106091 <alltraps>

8010680b <vector80>:
.globl vector80
vector80:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $80
8010680d:	6a 50                	push   $0x50
  jmp alltraps
8010680f:	e9 7d f8 ff ff       	jmp    80106091 <alltraps>

80106814 <vector81>:
.globl vector81
vector81:
  pushl $0
80106814:	6a 00                	push   $0x0
  pushl $81
80106816:	6a 51                	push   $0x51
  jmp alltraps
80106818:	e9 74 f8 ff ff       	jmp    80106091 <alltraps>

8010681d <vector82>:
.globl vector82
vector82:
  pushl $0
8010681d:	6a 00                	push   $0x0
  pushl $82
8010681f:	6a 52                	push   $0x52
  jmp alltraps
80106821:	e9 6b f8 ff ff       	jmp    80106091 <alltraps>

80106826 <vector83>:
.globl vector83
vector83:
  pushl $0
80106826:	6a 00                	push   $0x0
  pushl $83
80106828:	6a 53                	push   $0x53
  jmp alltraps
8010682a:	e9 62 f8 ff ff       	jmp    80106091 <alltraps>

8010682f <vector84>:
.globl vector84
vector84:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $84
80106831:	6a 54                	push   $0x54
  jmp alltraps
80106833:	e9 59 f8 ff ff       	jmp    80106091 <alltraps>

80106838 <vector85>:
.globl vector85
vector85:
  pushl $0
80106838:	6a 00                	push   $0x0
  pushl $85
8010683a:	6a 55                	push   $0x55
  jmp alltraps
8010683c:	e9 50 f8 ff ff       	jmp    80106091 <alltraps>

80106841 <vector86>:
.globl vector86
vector86:
  pushl $0
80106841:	6a 00                	push   $0x0
  pushl $86
80106843:	6a 56                	push   $0x56
  jmp alltraps
80106845:	e9 47 f8 ff ff       	jmp    80106091 <alltraps>

8010684a <vector87>:
.globl vector87
vector87:
  pushl $0
8010684a:	6a 00                	push   $0x0
  pushl $87
8010684c:	6a 57                	push   $0x57
  jmp alltraps
8010684e:	e9 3e f8 ff ff       	jmp    80106091 <alltraps>

80106853 <vector88>:
.globl vector88
vector88:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $88
80106855:	6a 58                	push   $0x58
  jmp alltraps
80106857:	e9 35 f8 ff ff       	jmp    80106091 <alltraps>

8010685c <vector89>:
.globl vector89
vector89:
  pushl $0
8010685c:	6a 00                	push   $0x0
  pushl $89
8010685e:	6a 59                	push   $0x59
  jmp alltraps
80106860:	e9 2c f8 ff ff       	jmp    80106091 <alltraps>

80106865 <vector90>:
.globl vector90
vector90:
  pushl $0
80106865:	6a 00                	push   $0x0
  pushl $90
80106867:	6a 5a                	push   $0x5a
  jmp alltraps
80106869:	e9 23 f8 ff ff       	jmp    80106091 <alltraps>

8010686e <vector91>:
.globl vector91
vector91:
  pushl $0
8010686e:	6a 00                	push   $0x0
  pushl $91
80106870:	6a 5b                	push   $0x5b
  jmp alltraps
80106872:	e9 1a f8 ff ff       	jmp    80106091 <alltraps>

80106877 <vector92>:
.globl vector92
vector92:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $92
80106879:	6a 5c                	push   $0x5c
  jmp alltraps
8010687b:	e9 11 f8 ff ff       	jmp    80106091 <alltraps>

80106880 <vector93>:
.globl vector93
vector93:
  pushl $0
80106880:	6a 00                	push   $0x0
  pushl $93
80106882:	6a 5d                	push   $0x5d
  jmp alltraps
80106884:	e9 08 f8 ff ff       	jmp    80106091 <alltraps>

80106889 <vector94>:
.globl vector94
vector94:
  pushl $0
80106889:	6a 00                	push   $0x0
  pushl $94
8010688b:	6a 5e                	push   $0x5e
  jmp alltraps
8010688d:	e9 ff f7 ff ff       	jmp    80106091 <alltraps>

80106892 <vector95>:
.globl vector95
vector95:
  pushl $0
80106892:	6a 00                	push   $0x0
  pushl $95
80106894:	6a 5f                	push   $0x5f
  jmp alltraps
80106896:	e9 f6 f7 ff ff       	jmp    80106091 <alltraps>

8010689b <vector96>:
.globl vector96
vector96:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $96
8010689d:	6a 60                	push   $0x60
  jmp alltraps
8010689f:	e9 ed f7 ff ff       	jmp    80106091 <alltraps>

801068a4 <vector97>:
.globl vector97
vector97:
  pushl $0
801068a4:	6a 00                	push   $0x0
  pushl $97
801068a6:	6a 61                	push   $0x61
  jmp alltraps
801068a8:	e9 e4 f7 ff ff       	jmp    80106091 <alltraps>

801068ad <vector98>:
.globl vector98
vector98:
  pushl $0
801068ad:	6a 00                	push   $0x0
  pushl $98
801068af:	6a 62                	push   $0x62
  jmp alltraps
801068b1:	e9 db f7 ff ff       	jmp    80106091 <alltraps>

801068b6 <vector99>:
.globl vector99
vector99:
  pushl $0
801068b6:	6a 00                	push   $0x0
  pushl $99
801068b8:	6a 63                	push   $0x63
  jmp alltraps
801068ba:	e9 d2 f7 ff ff       	jmp    80106091 <alltraps>

801068bf <vector100>:
.globl vector100
vector100:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $100
801068c1:	6a 64                	push   $0x64
  jmp alltraps
801068c3:	e9 c9 f7 ff ff       	jmp    80106091 <alltraps>

801068c8 <vector101>:
.globl vector101
vector101:
  pushl $0
801068c8:	6a 00                	push   $0x0
  pushl $101
801068ca:	6a 65                	push   $0x65
  jmp alltraps
801068cc:	e9 c0 f7 ff ff       	jmp    80106091 <alltraps>

801068d1 <vector102>:
.globl vector102
vector102:
  pushl $0
801068d1:	6a 00                	push   $0x0
  pushl $102
801068d3:	6a 66                	push   $0x66
  jmp alltraps
801068d5:	e9 b7 f7 ff ff       	jmp    80106091 <alltraps>

801068da <vector103>:
.globl vector103
vector103:
  pushl $0
801068da:	6a 00                	push   $0x0
  pushl $103
801068dc:	6a 67                	push   $0x67
  jmp alltraps
801068de:	e9 ae f7 ff ff       	jmp    80106091 <alltraps>

801068e3 <vector104>:
.globl vector104
vector104:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $104
801068e5:	6a 68                	push   $0x68
  jmp alltraps
801068e7:	e9 a5 f7 ff ff       	jmp    80106091 <alltraps>

801068ec <vector105>:
.globl vector105
vector105:
  pushl $0
801068ec:	6a 00                	push   $0x0
  pushl $105
801068ee:	6a 69                	push   $0x69
  jmp alltraps
801068f0:	e9 9c f7 ff ff       	jmp    80106091 <alltraps>

801068f5 <vector106>:
.globl vector106
vector106:
  pushl $0
801068f5:	6a 00                	push   $0x0
  pushl $106
801068f7:	6a 6a                	push   $0x6a
  jmp alltraps
801068f9:	e9 93 f7 ff ff       	jmp    80106091 <alltraps>

801068fe <vector107>:
.globl vector107
vector107:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $107
80106900:	6a 6b                	push   $0x6b
  jmp alltraps
80106902:	e9 8a f7 ff ff       	jmp    80106091 <alltraps>

80106907 <vector108>:
.globl vector108
vector108:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $108
80106909:	6a 6c                	push   $0x6c
  jmp alltraps
8010690b:	e9 81 f7 ff ff       	jmp    80106091 <alltraps>

80106910 <vector109>:
.globl vector109
vector109:
  pushl $0
80106910:	6a 00                	push   $0x0
  pushl $109
80106912:	6a 6d                	push   $0x6d
  jmp alltraps
80106914:	e9 78 f7 ff ff       	jmp    80106091 <alltraps>

80106919 <vector110>:
.globl vector110
vector110:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $110
8010691b:	6a 6e                	push   $0x6e
  jmp alltraps
8010691d:	e9 6f f7 ff ff       	jmp    80106091 <alltraps>

80106922 <vector111>:
.globl vector111
vector111:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $111
80106924:	6a 6f                	push   $0x6f
  jmp alltraps
80106926:	e9 66 f7 ff ff       	jmp    80106091 <alltraps>

8010692b <vector112>:
.globl vector112
vector112:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $112
8010692d:	6a 70                	push   $0x70
  jmp alltraps
8010692f:	e9 5d f7 ff ff       	jmp    80106091 <alltraps>

80106934 <vector113>:
.globl vector113
vector113:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $113
80106936:	6a 71                	push   $0x71
  jmp alltraps
80106938:	e9 54 f7 ff ff       	jmp    80106091 <alltraps>

8010693d <vector114>:
.globl vector114
vector114:
  pushl $0
8010693d:	6a 00                	push   $0x0
  pushl $114
8010693f:	6a 72                	push   $0x72
  jmp alltraps
80106941:	e9 4b f7 ff ff       	jmp    80106091 <alltraps>

80106946 <vector115>:
.globl vector115
vector115:
  pushl $0
80106946:	6a 00                	push   $0x0
  pushl $115
80106948:	6a 73                	push   $0x73
  jmp alltraps
8010694a:	e9 42 f7 ff ff       	jmp    80106091 <alltraps>

8010694f <vector116>:
.globl vector116
vector116:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $116
80106951:	6a 74                	push   $0x74
  jmp alltraps
80106953:	e9 39 f7 ff ff       	jmp    80106091 <alltraps>

80106958 <vector117>:
.globl vector117
vector117:
  pushl $0
80106958:	6a 00                	push   $0x0
  pushl $117
8010695a:	6a 75                	push   $0x75
  jmp alltraps
8010695c:	e9 30 f7 ff ff       	jmp    80106091 <alltraps>

80106961 <vector118>:
.globl vector118
vector118:
  pushl $0
80106961:	6a 00                	push   $0x0
  pushl $118
80106963:	6a 76                	push   $0x76
  jmp alltraps
80106965:	e9 27 f7 ff ff       	jmp    80106091 <alltraps>

8010696a <vector119>:
.globl vector119
vector119:
  pushl $0
8010696a:	6a 00                	push   $0x0
  pushl $119
8010696c:	6a 77                	push   $0x77
  jmp alltraps
8010696e:	e9 1e f7 ff ff       	jmp    80106091 <alltraps>

80106973 <vector120>:
.globl vector120
vector120:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $120
80106975:	6a 78                	push   $0x78
  jmp alltraps
80106977:	e9 15 f7 ff ff       	jmp    80106091 <alltraps>

8010697c <vector121>:
.globl vector121
vector121:
  pushl $0
8010697c:	6a 00                	push   $0x0
  pushl $121
8010697e:	6a 79                	push   $0x79
  jmp alltraps
80106980:	e9 0c f7 ff ff       	jmp    80106091 <alltraps>

80106985 <vector122>:
.globl vector122
vector122:
  pushl $0
80106985:	6a 00                	push   $0x0
  pushl $122
80106987:	6a 7a                	push   $0x7a
  jmp alltraps
80106989:	e9 03 f7 ff ff       	jmp    80106091 <alltraps>

8010698e <vector123>:
.globl vector123
vector123:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $123
80106990:	6a 7b                	push   $0x7b
  jmp alltraps
80106992:	e9 fa f6 ff ff       	jmp    80106091 <alltraps>

80106997 <vector124>:
.globl vector124
vector124:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $124
80106999:	6a 7c                	push   $0x7c
  jmp alltraps
8010699b:	e9 f1 f6 ff ff       	jmp    80106091 <alltraps>

801069a0 <vector125>:
.globl vector125
vector125:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $125
801069a2:	6a 7d                	push   $0x7d
  jmp alltraps
801069a4:	e9 e8 f6 ff ff       	jmp    80106091 <alltraps>

801069a9 <vector126>:
.globl vector126
vector126:
  pushl $0
801069a9:	6a 00                	push   $0x0
  pushl $126
801069ab:	6a 7e                	push   $0x7e
  jmp alltraps
801069ad:	e9 df f6 ff ff       	jmp    80106091 <alltraps>

801069b2 <vector127>:
.globl vector127
vector127:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $127
801069b4:	6a 7f                	push   $0x7f
  jmp alltraps
801069b6:	e9 d6 f6 ff ff       	jmp    80106091 <alltraps>

801069bb <vector128>:
.globl vector128
vector128:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $128
801069bd:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801069c2:	e9 ca f6 ff ff       	jmp    80106091 <alltraps>

801069c7 <vector129>:
.globl vector129
vector129:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $129
801069c9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801069ce:	e9 be f6 ff ff       	jmp    80106091 <alltraps>

801069d3 <vector130>:
.globl vector130
vector130:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $130
801069d5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801069da:	e9 b2 f6 ff ff       	jmp    80106091 <alltraps>

801069df <vector131>:
.globl vector131
vector131:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $131
801069e1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801069e6:	e9 a6 f6 ff ff       	jmp    80106091 <alltraps>

801069eb <vector132>:
.globl vector132
vector132:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $132
801069ed:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801069f2:	e9 9a f6 ff ff       	jmp    80106091 <alltraps>

801069f7 <vector133>:
.globl vector133
vector133:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $133
801069f9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801069fe:	e9 8e f6 ff ff       	jmp    80106091 <alltraps>

80106a03 <vector134>:
.globl vector134
vector134:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $134
80106a05:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106a0a:	e9 82 f6 ff ff       	jmp    80106091 <alltraps>

80106a0f <vector135>:
.globl vector135
vector135:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $135
80106a11:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106a16:	e9 76 f6 ff ff       	jmp    80106091 <alltraps>

80106a1b <vector136>:
.globl vector136
vector136:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $136
80106a1d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106a22:	e9 6a f6 ff ff       	jmp    80106091 <alltraps>

80106a27 <vector137>:
.globl vector137
vector137:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $137
80106a29:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106a2e:	e9 5e f6 ff ff       	jmp    80106091 <alltraps>

80106a33 <vector138>:
.globl vector138
vector138:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $138
80106a35:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106a3a:	e9 52 f6 ff ff       	jmp    80106091 <alltraps>

80106a3f <vector139>:
.globl vector139
vector139:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $139
80106a41:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106a46:	e9 46 f6 ff ff       	jmp    80106091 <alltraps>

80106a4b <vector140>:
.globl vector140
vector140:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $140
80106a4d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106a52:	e9 3a f6 ff ff       	jmp    80106091 <alltraps>

80106a57 <vector141>:
.globl vector141
vector141:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $141
80106a59:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106a5e:	e9 2e f6 ff ff       	jmp    80106091 <alltraps>

80106a63 <vector142>:
.globl vector142
vector142:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $142
80106a65:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106a6a:	e9 22 f6 ff ff       	jmp    80106091 <alltraps>

80106a6f <vector143>:
.globl vector143
vector143:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $143
80106a71:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106a76:	e9 16 f6 ff ff       	jmp    80106091 <alltraps>

80106a7b <vector144>:
.globl vector144
vector144:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $144
80106a7d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106a82:	e9 0a f6 ff ff       	jmp    80106091 <alltraps>

80106a87 <vector145>:
.globl vector145
vector145:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $145
80106a89:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106a8e:	e9 fe f5 ff ff       	jmp    80106091 <alltraps>

80106a93 <vector146>:
.globl vector146
vector146:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $146
80106a95:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a9a:	e9 f2 f5 ff ff       	jmp    80106091 <alltraps>

80106a9f <vector147>:
.globl vector147
vector147:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $147
80106aa1:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106aa6:	e9 e6 f5 ff ff       	jmp    80106091 <alltraps>

80106aab <vector148>:
.globl vector148
vector148:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $148
80106aad:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106ab2:	e9 da f5 ff ff       	jmp    80106091 <alltraps>

80106ab7 <vector149>:
.globl vector149
vector149:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $149
80106ab9:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106abe:	e9 ce f5 ff ff       	jmp    80106091 <alltraps>

80106ac3 <vector150>:
.globl vector150
vector150:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $150
80106ac5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106aca:	e9 c2 f5 ff ff       	jmp    80106091 <alltraps>

80106acf <vector151>:
.globl vector151
vector151:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $151
80106ad1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106ad6:	e9 b6 f5 ff ff       	jmp    80106091 <alltraps>

80106adb <vector152>:
.globl vector152
vector152:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $152
80106add:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106ae2:	e9 aa f5 ff ff       	jmp    80106091 <alltraps>

80106ae7 <vector153>:
.globl vector153
vector153:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $153
80106ae9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106aee:	e9 9e f5 ff ff       	jmp    80106091 <alltraps>

80106af3 <vector154>:
.globl vector154
vector154:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $154
80106af5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106afa:	e9 92 f5 ff ff       	jmp    80106091 <alltraps>

80106aff <vector155>:
.globl vector155
vector155:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $155
80106b01:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106b06:	e9 86 f5 ff ff       	jmp    80106091 <alltraps>

80106b0b <vector156>:
.globl vector156
vector156:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $156
80106b0d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106b12:	e9 7a f5 ff ff       	jmp    80106091 <alltraps>

80106b17 <vector157>:
.globl vector157
vector157:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $157
80106b19:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106b1e:	e9 6e f5 ff ff       	jmp    80106091 <alltraps>

80106b23 <vector158>:
.globl vector158
vector158:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $158
80106b25:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106b2a:	e9 62 f5 ff ff       	jmp    80106091 <alltraps>

80106b2f <vector159>:
.globl vector159
vector159:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $159
80106b31:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106b36:	e9 56 f5 ff ff       	jmp    80106091 <alltraps>

80106b3b <vector160>:
.globl vector160
vector160:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $160
80106b3d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106b42:	e9 4a f5 ff ff       	jmp    80106091 <alltraps>

80106b47 <vector161>:
.globl vector161
vector161:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $161
80106b49:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106b4e:	e9 3e f5 ff ff       	jmp    80106091 <alltraps>

80106b53 <vector162>:
.globl vector162
vector162:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $162
80106b55:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106b5a:	e9 32 f5 ff ff       	jmp    80106091 <alltraps>

80106b5f <vector163>:
.globl vector163
vector163:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $163
80106b61:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106b66:	e9 26 f5 ff ff       	jmp    80106091 <alltraps>

80106b6b <vector164>:
.globl vector164
vector164:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $164
80106b6d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106b72:	e9 1a f5 ff ff       	jmp    80106091 <alltraps>

80106b77 <vector165>:
.globl vector165
vector165:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $165
80106b79:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106b7e:	e9 0e f5 ff ff       	jmp    80106091 <alltraps>

80106b83 <vector166>:
.globl vector166
vector166:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $166
80106b85:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106b8a:	e9 02 f5 ff ff       	jmp    80106091 <alltraps>

80106b8f <vector167>:
.globl vector167
vector167:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $167
80106b91:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b96:	e9 f6 f4 ff ff       	jmp    80106091 <alltraps>

80106b9b <vector168>:
.globl vector168
vector168:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $168
80106b9d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ba2:	e9 ea f4 ff ff       	jmp    80106091 <alltraps>

80106ba7 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $169
80106ba9:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106bae:	e9 de f4 ff ff       	jmp    80106091 <alltraps>

80106bb3 <vector170>:
.globl vector170
vector170:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $170
80106bb5:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106bba:	e9 d2 f4 ff ff       	jmp    80106091 <alltraps>

80106bbf <vector171>:
.globl vector171
vector171:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $171
80106bc1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106bc6:	e9 c6 f4 ff ff       	jmp    80106091 <alltraps>

80106bcb <vector172>:
.globl vector172
vector172:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $172
80106bcd:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106bd2:	e9 ba f4 ff ff       	jmp    80106091 <alltraps>

80106bd7 <vector173>:
.globl vector173
vector173:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $173
80106bd9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106bde:	e9 ae f4 ff ff       	jmp    80106091 <alltraps>

80106be3 <vector174>:
.globl vector174
vector174:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $174
80106be5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106bea:	e9 a2 f4 ff ff       	jmp    80106091 <alltraps>

80106bef <vector175>:
.globl vector175
vector175:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $175
80106bf1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106bf6:	e9 96 f4 ff ff       	jmp    80106091 <alltraps>

80106bfb <vector176>:
.globl vector176
vector176:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $176
80106bfd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106c02:	e9 8a f4 ff ff       	jmp    80106091 <alltraps>

80106c07 <vector177>:
.globl vector177
vector177:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $177
80106c09:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106c0e:	e9 7e f4 ff ff       	jmp    80106091 <alltraps>

80106c13 <vector178>:
.globl vector178
vector178:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $178
80106c15:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106c1a:	e9 72 f4 ff ff       	jmp    80106091 <alltraps>

80106c1f <vector179>:
.globl vector179
vector179:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $179
80106c21:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106c26:	e9 66 f4 ff ff       	jmp    80106091 <alltraps>

80106c2b <vector180>:
.globl vector180
vector180:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $180
80106c2d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106c32:	e9 5a f4 ff ff       	jmp    80106091 <alltraps>

80106c37 <vector181>:
.globl vector181
vector181:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $181
80106c39:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106c3e:	e9 4e f4 ff ff       	jmp    80106091 <alltraps>

80106c43 <vector182>:
.globl vector182
vector182:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $182
80106c45:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106c4a:	e9 42 f4 ff ff       	jmp    80106091 <alltraps>

80106c4f <vector183>:
.globl vector183
vector183:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $183
80106c51:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106c56:	e9 36 f4 ff ff       	jmp    80106091 <alltraps>

80106c5b <vector184>:
.globl vector184
vector184:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $184
80106c5d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106c62:	e9 2a f4 ff ff       	jmp    80106091 <alltraps>

80106c67 <vector185>:
.globl vector185
vector185:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $185
80106c69:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106c6e:	e9 1e f4 ff ff       	jmp    80106091 <alltraps>

80106c73 <vector186>:
.globl vector186
vector186:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $186
80106c75:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106c7a:	e9 12 f4 ff ff       	jmp    80106091 <alltraps>

80106c7f <vector187>:
.globl vector187
vector187:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $187
80106c81:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106c86:	e9 06 f4 ff ff       	jmp    80106091 <alltraps>

80106c8b <vector188>:
.globl vector188
vector188:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $188
80106c8d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106c92:	e9 fa f3 ff ff       	jmp    80106091 <alltraps>

80106c97 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $189
80106c99:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c9e:	e9 ee f3 ff ff       	jmp    80106091 <alltraps>

80106ca3 <vector190>:
.globl vector190
vector190:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $190
80106ca5:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106caa:	e9 e2 f3 ff ff       	jmp    80106091 <alltraps>

80106caf <vector191>:
.globl vector191
vector191:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $191
80106cb1:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106cb6:	e9 d6 f3 ff ff       	jmp    80106091 <alltraps>

80106cbb <vector192>:
.globl vector192
vector192:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $192
80106cbd:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106cc2:	e9 ca f3 ff ff       	jmp    80106091 <alltraps>

80106cc7 <vector193>:
.globl vector193
vector193:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $193
80106cc9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106cce:	e9 be f3 ff ff       	jmp    80106091 <alltraps>

80106cd3 <vector194>:
.globl vector194
vector194:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $194
80106cd5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106cda:	e9 b2 f3 ff ff       	jmp    80106091 <alltraps>

80106cdf <vector195>:
.globl vector195
vector195:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $195
80106ce1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106ce6:	e9 a6 f3 ff ff       	jmp    80106091 <alltraps>

80106ceb <vector196>:
.globl vector196
vector196:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $196
80106ced:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106cf2:	e9 9a f3 ff ff       	jmp    80106091 <alltraps>

80106cf7 <vector197>:
.globl vector197
vector197:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $197
80106cf9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106cfe:	e9 8e f3 ff ff       	jmp    80106091 <alltraps>

80106d03 <vector198>:
.globl vector198
vector198:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $198
80106d05:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106d0a:	e9 82 f3 ff ff       	jmp    80106091 <alltraps>

80106d0f <vector199>:
.globl vector199
vector199:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $199
80106d11:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106d16:	e9 76 f3 ff ff       	jmp    80106091 <alltraps>

80106d1b <vector200>:
.globl vector200
vector200:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $200
80106d1d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106d22:	e9 6a f3 ff ff       	jmp    80106091 <alltraps>

80106d27 <vector201>:
.globl vector201
vector201:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $201
80106d29:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106d2e:	e9 5e f3 ff ff       	jmp    80106091 <alltraps>

80106d33 <vector202>:
.globl vector202
vector202:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $202
80106d35:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106d3a:	e9 52 f3 ff ff       	jmp    80106091 <alltraps>

80106d3f <vector203>:
.globl vector203
vector203:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $203
80106d41:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106d46:	e9 46 f3 ff ff       	jmp    80106091 <alltraps>

80106d4b <vector204>:
.globl vector204
vector204:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $204
80106d4d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106d52:	e9 3a f3 ff ff       	jmp    80106091 <alltraps>

80106d57 <vector205>:
.globl vector205
vector205:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $205
80106d59:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106d5e:	e9 2e f3 ff ff       	jmp    80106091 <alltraps>

80106d63 <vector206>:
.globl vector206
vector206:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $206
80106d65:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106d6a:	e9 22 f3 ff ff       	jmp    80106091 <alltraps>

80106d6f <vector207>:
.globl vector207
vector207:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $207
80106d71:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106d76:	e9 16 f3 ff ff       	jmp    80106091 <alltraps>

80106d7b <vector208>:
.globl vector208
vector208:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $208
80106d7d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106d82:	e9 0a f3 ff ff       	jmp    80106091 <alltraps>

80106d87 <vector209>:
.globl vector209
vector209:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $209
80106d89:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106d8e:	e9 fe f2 ff ff       	jmp    80106091 <alltraps>

80106d93 <vector210>:
.globl vector210
vector210:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $210
80106d95:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d9a:	e9 f2 f2 ff ff       	jmp    80106091 <alltraps>

80106d9f <vector211>:
.globl vector211
vector211:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $211
80106da1:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106da6:	e9 e6 f2 ff ff       	jmp    80106091 <alltraps>

80106dab <vector212>:
.globl vector212
vector212:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $212
80106dad:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106db2:	e9 da f2 ff ff       	jmp    80106091 <alltraps>

80106db7 <vector213>:
.globl vector213
vector213:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $213
80106db9:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106dbe:	e9 ce f2 ff ff       	jmp    80106091 <alltraps>

80106dc3 <vector214>:
.globl vector214
vector214:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $214
80106dc5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106dca:	e9 c2 f2 ff ff       	jmp    80106091 <alltraps>

80106dcf <vector215>:
.globl vector215
vector215:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $215
80106dd1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106dd6:	e9 b6 f2 ff ff       	jmp    80106091 <alltraps>

80106ddb <vector216>:
.globl vector216
vector216:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $216
80106ddd:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106de2:	e9 aa f2 ff ff       	jmp    80106091 <alltraps>

80106de7 <vector217>:
.globl vector217
vector217:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $217
80106de9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106dee:	e9 9e f2 ff ff       	jmp    80106091 <alltraps>

80106df3 <vector218>:
.globl vector218
vector218:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $218
80106df5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106dfa:	e9 92 f2 ff ff       	jmp    80106091 <alltraps>

80106dff <vector219>:
.globl vector219
vector219:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $219
80106e01:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106e06:	e9 86 f2 ff ff       	jmp    80106091 <alltraps>

80106e0b <vector220>:
.globl vector220
vector220:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $220
80106e0d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106e12:	e9 7a f2 ff ff       	jmp    80106091 <alltraps>

80106e17 <vector221>:
.globl vector221
vector221:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $221
80106e19:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106e1e:	e9 6e f2 ff ff       	jmp    80106091 <alltraps>

80106e23 <vector222>:
.globl vector222
vector222:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $222
80106e25:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106e2a:	e9 62 f2 ff ff       	jmp    80106091 <alltraps>

80106e2f <vector223>:
.globl vector223
vector223:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $223
80106e31:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106e36:	e9 56 f2 ff ff       	jmp    80106091 <alltraps>

80106e3b <vector224>:
.globl vector224
vector224:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $224
80106e3d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106e42:	e9 4a f2 ff ff       	jmp    80106091 <alltraps>

80106e47 <vector225>:
.globl vector225
vector225:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $225
80106e49:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106e4e:	e9 3e f2 ff ff       	jmp    80106091 <alltraps>

80106e53 <vector226>:
.globl vector226
vector226:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $226
80106e55:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106e5a:	e9 32 f2 ff ff       	jmp    80106091 <alltraps>

80106e5f <vector227>:
.globl vector227
vector227:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $227
80106e61:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106e66:	e9 26 f2 ff ff       	jmp    80106091 <alltraps>

80106e6b <vector228>:
.globl vector228
vector228:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $228
80106e6d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106e72:	e9 1a f2 ff ff       	jmp    80106091 <alltraps>

80106e77 <vector229>:
.globl vector229
vector229:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $229
80106e79:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106e7e:	e9 0e f2 ff ff       	jmp    80106091 <alltraps>

80106e83 <vector230>:
.globl vector230
vector230:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $230
80106e85:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106e8a:	e9 02 f2 ff ff       	jmp    80106091 <alltraps>

80106e8f <vector231>:
.globl vector231
vector231:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $231
80106e91:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e96:	e9 f6 f1 ff ff       	jmp    80106091 <alltraps>

80106e9b <vector232>:
.globl vector232
vector232:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $232
80106e9d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106ea2:	e9 ea f1 ff ff       	jmp    80106091 <alltraps>

80106ea7 <vector233>:
.globl vector233
vector233:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $233
80106ea9:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106eae:	e9 de f1 ff ff       	jmp    80106091 <alltraps>

80106eb3 <vector234>:
.globl vector234
vector234:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $234
80106eb5:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106eba:	e9 d2 f1 ff ff       	jmp    80106091 <alltraps>

80106ebf <vector235>:
.globl vector235
vector235:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $235
80106ec1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ec6:	e9 c6 f1 ff ff       	jmp    80106091 <alltraps>

80106ecb <vector236>:
.globl vector236
vector236:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $236
80106ecd:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106ed2:	e9 ba f1 ff ff       	jmp    80106091 <alltraps>

80106ed7 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $237
80106ed9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106ede:	e9 ae f1 ff ff       	jmp    80106091 <alltraps>

80106ee3 <vector238>:
.globl vector238
vector238:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $238
80106ee5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106eea:	e9 a2 f1 ff ff       	jmp    80106091 <alltraps>

80106eef <vector239>:
.globl vector239
vector239:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $239
80106ef1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ef6:	e9 96 f1 ff ff       	jmp    80106091 <alltraps>

80106efb <vector240>:
.globl vector240
vector240:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $240
80106efd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106f02:	e9 8a f1 ff ff       	jmp    80106091 <alltraps>

80106f07 <vector241>:
.globl vector241
vector241:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $241
80106f09:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106f0e:	e9 7e f1 ff ff       	jmp    80106091 <alltraps>

80106f13 <vector242>:
.globl vector242
vector242:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $242
80106f15:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106f1a:	e9 72 f1 ff ff       	jmp    80106091 <alltraps>

80106f1f <vector243>:
.globl vector243
vector243:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $243
80106f21:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106f26:	e9 66 f1 ff ff       	jmp    80106091 <alltraps>

80106f2b <vector244>:
.globl vector244
vector244:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $244
80106f2d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106f32:	e9 5a f1 ff ff       	jmp    80106091 <alltraps>

80106f37 <vector245>:
.globl vector245
vector245:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $245
80106f39:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106f3e:	e9 4e f1 ff ff       	jmp    80106091 <alltraps>

80106f43 <vector246>:
.globl vector246
vector246:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $246
80106f45:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106f4a:	e9 42 f1 ff ff       	jmp    80106091 <alltraps>

80106f4f <vector247>:
.globl vector247
vector247:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $247
80106f51:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106f56:	e9 36 f1 ff ff       	jmp    80106091 <alltraps>

80106f5b <vector248>:
.globl vector248
vector248:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $248
80106f5d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106f62:	e9 2a f1 ff ff       	jmp    80106091 <alltraps>

80106f67 <vector249>:
.globl vector249
vector249:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $249
80106f69:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106f6e:	e9 1e f1 ff ff       	jmp    80106091 <alltraps>

80106f73 <vector250>:
.globl vector250
vector250:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $250
80106f75:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106f7a:	e9 12 f1 ff ff       	jmp    80106091 <alltraps>

80106f7f <vector251>:
.globl vector251
vector251:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $251
80106f81:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106f86:	e9 06 f1 ff ff       	jmp    80106091 <alltraps>

80106f8b <vector252>:
.globl vector252
vector252:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $252
80106f8d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106f92:	e9 fa f0 ff ff       	jmp    80106091 <alltraps>

80106f97 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $253
80106f99:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f9e:	e9 ee f0 ff ff       	jmp    80106091 <alltraps>

80106fa3 <vector254>:
.globl vector254
vector254:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $254
80106fa5:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106faa:	e9 e2 f0 ff ff       	jmp    80106091 <alltraps>

80106faf <vector255>:
.globl vector255
vector255:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $255
80106fb1:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106fb6:	e9 d6 f0 ff ff       	jmp    80106091 <alltraps>
80106fbb:	66 90                	xchg   %ax,%ax
80106fbd:	66 90                	xchg   %ax,%ax
80106fbf:	90                   	nop

80106fc0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	57                   	push   %edi
80106fc4:	56                   	push   %esi
80106fc5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106fc7:	c1 ea 16             	shr    $0x16,%edx
{
80106fca:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106fcb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106fce:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106fd1:	8b 1f                	mov    (%edi),%ebx
80106fd3:	f6 c3 01             	test   $0x1,%bl
80106fd6:	74 28                	je     80107000 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fd8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fde:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106fe4:	89 f0                	mov    %esi,%eax
}
80106fe6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106fe9:	c1 e8 0a             	shr    $0xa,%eax
80106fec:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ff1:	01 d8                	add    %ebx,%eax
}
80106ff3:	5b                   	pop    %ebx
80106ff4:	5e                   	pop    %esi
80106ff5:	5f                   	pop    %edi
80106ff6:	5d                   	pop    %ebp
80106ff7:	c3                   	ret    
80106ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fff:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107000:	85 c9                	test   %ecx,%ecx
80107002:	74 2c                	je     80107030 <walkpgdir+0x70>
80107004:	e8 17 bb ff ff       	call   80102b20 <kalloc>
80107009:	89 c3                	mov    %eax,%ebx
8010700b:	85 c0                	test   %eax,%eax
8010700d:	74 21                	je     80107030 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010700f:	83 ec 04             	sub    $0x4,%esp
80107012:	68 00 10 00 00       	push   $0x1000
80107017:	6a 00                	push   $0x0
80107019:	50                   	push   %eax
8010701a:	e8 c1 dc ff ff       	call   80104ce0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010701f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107025:	83 c4 10             	add    $0x10,%esp
80107028:	83 c8 07             	or     $0x7,%eax
8010702b:	89 07                	mov    %eax,(%edi)
8010702d:	eb b5                	jmp    80106fe4 <walkpgdir+0x24>
8010702f:	90                   	nop
}
80107030:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107033:	31 c0                	xor    %eax,%eax
}
80107035:	5b                   	pop    %ebx
80107036:	5e                   	pop    %esi
80107037:	5f                   	pop    %edi
80107038:	5d                   	pop    %ebp
80107039:	c3                   	ret    
8010703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107040 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107046:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010704a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010704b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107050:	89 d6                	mov    %edx,%esi
{
80107052:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107053:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107059:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010705c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010705f:	8b 45 08             	mov    0x8(%ebp),%eax
80107062:	29 f0                	sub    %esi,%eax
80107064:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107067:	eb 1f                	jmp    80107088 <mappages+0x48>
80107069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107070:	f6 00 01             	testb  $0x1,(%eax)
80107073:	75 45                	jne    801070ba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107075:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107078:	83 cb 01             	or     $0x1,%ebx
8010707b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010707d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107080:	74 2e                	je     801070b0 <mappages+0x70>
      break;
    a += PGSIZE;
80107082:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107088:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010708b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107090:	89 f2                	mov    %esi,%edx
80107092:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107095:	89 f8                	mov    %edi,%eax
80107097:	e8 24 ff ff ff       	call   80106fc0 <walkpgdir>
8010709c:	85 c0                	test   %eax,%eax
8010709e:	75 d0                	jne    80107070 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801070a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070a8:	5b                   	pop    %ebx
801070a9:	5e                   	pop    %esi
801070aa:	5f                   	pop    %edi
801070ab:	5d                   	pop    %ebp
801070ac:	c3                   	ret    
801070ad:	8d 76 00             	lea    0x0(%esi),%esi
801070b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070b3:	31 c0                	xor    %eax,%eax
}
801070b5:	5b                   	pop    %ebx
801070b6:	5e                   	pop    %esi
801070b7:	5f                   	pop    %edi
801070b8:	5d                   	pop    %ebp
801070b9:	c3                   	ret    
      panic("remap");
801070ba:	83 ec 0c             	sub    $0xc,%esp
801070bd:	68 60 82 10 80       	push   $0x80108260
801070c2:	e8 c9 92 ff ff       	call   80100390 <panic>
801070c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ce:	66 90                	xchg   %ax,%ax

801070d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	89 c6                	mov    %eax,%esi
801070d7:	53                   	push   %ebx
801070d8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070da:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801070e0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070e6:	83 ec 1c             	sub    $0x1c,%esp
801070e9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801070ec:	39 da                	cmp    %ebx,%edx
801070ee:	73 5b                	jae    8010714b <deallocuvm.part.0+0x7b>
801070f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801070f3:	89 d7                	mov    %edx,%edi
801070f5:	eb 14                	jmp    8010710b <deallocuvm.part.0+0x3b>
801070f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070fe:	66 90                	xchg   %ax,%ax
80107100:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107106:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107109:	76 40                	jbe    8010714b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010710b:	31 c9                	xor    %ecx,%ecx
8010710d:	89 fa                	mov    %edi,%edx
8010710f:	89 f0                	mov    %esi,%eax
80107111:	e8 aa fe ff ff       	call   80106fc0 <walkpgdir>
80107116:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107118:	85 c0                	test   %eax,%eax
8010711a:	74 44                	je     80107160 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010711c:	8b 00                	mov    (%eax),%eax
8010711e:	a8 01                	test   $0x1,%al
80107120:	74 de                	je     80107100 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107122:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107127:	74 47                	je     80107170 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107129:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010712c:	05 00 00 00 80       	add    $0x80000000,%eax
80107131:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107137:	50                   	push   %eax
80107138:	e8 23 b8 ff ff       	call   80102960 <kfree>
      *pte = 0;
8010713d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107143:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107146:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107149:	77 c0                	ja     8010710b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010714b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010714e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107151:	5b                   	pop    %ebx
80107152:	5e                   	pop    %esi
80107153:	5f                   	pop    %edi
80107154:	5d                   	pop    %ebp
80107155:	c3                   	ret    
80107156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107160:	89 fa                	mov    %edi,%edx
80107162:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107168:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010716e:	eb 96                	jmp    80107106 <deallocuvm.part.0+0x36>
        panic("kfree");
80107170:	83 ec 0c             	sub    $0xc,%esp
80107173:	68 be 7b 10 80       	push   $0x80107bbe
80107178:	e8 13 92 ff ff       	call   80100390 <panic>
8010717d:	8d 76 00             	lea    0x0(%esi),%esi

80107180 <seginit>:
{
80107180:	f3 0f 1e fb          	endbr32 
80107184:	55                   	push   %ebp
80107185:	89 e5                	mov    %esp,%ebp
80107187:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010718a:	e8 b1 cc ff ff       	call   80103e40 <cpuid>
  pd[0] = size-1;
8010718f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107194:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010719a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010719e:	c7 80 98 3d 11 80 ff 	movl   $0xffff,-0x7feec268(%eax)
801071a5:	ff 00 00 
801071a8:	c7 80 9c 3d 11 80 00 	movl   $0xcf9a00,-0x7feec264(%eax)
801071af:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801071b2:	c7 80 a0 3d 11 80 ff 	movl   $0xffff,-0x7feec260(%eax)
801071b9:	ff 00 00 
801071bc:	c7 80 a4 3d 11 80 00 	movl   $0xcf9200,-0x7feec25c(%eax)
801071c3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801071c6:	c7 80 a8 3d 11 80 ff 	movl   $0xffff,-0x7feec258(%eax)
801071cd:	ff 00 00 
801071d0:	c7 80 ac 3d 11 80 00 	movl   $0xcffa00,-0x7feec254(%eax)
801071d7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801071da:	c7 80 b0 3d 11 80 ff 	movl   $0xffff,-0x7feec250(%eax)
801071e1:	ff 00 00 
801071e4:	c7 80 b4 3d 11 80 00 	movl   $0xcff200,-0x7feec24c(%eax)
801071eb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071ee:	05 90 3d 11 80       	add    $0x80113d90,%eax
  pd[1] = (uint)p;
801071f3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071f7:	c1 e8 10             	shr    $0x10,%eax
801071fa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801071fe:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107201:	0f 01 10             	lgdtl  (%eax)
}
80107204:	c9                   	leave  
80107205:	c3                   	ret    
80107206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010720d:	8d 76 00             	lea    0x0(%esi),%esi

80107210 <switchkvm>:
{
80107210:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107214:	a1 44 6b 11 80       	mov    0x80116b44,%eax
80107219:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010721e:	0f 22 d8             	mov    %eax,%cr3
}
80107221:	c3                   	ret    
80107222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107230 <switchuvm>:
{
80107230:	f3 0f 1e fb          	endbr32 
80107234:	55                   	push   %ebp
80107235:	89 e5                	mov    %esp,%ebp
80107237:	57                   	push   %edi
80107238:	56                   	push   %esi
80107239:	53                   	push   %ebx
8010723a:	83 ec 1c             	sub    $0x1c,%esp
8010723d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107240:	85 f6                	test   %esi,%esi
80107242:	0f 84 cb 00 00 00    	je     80107313 <switchuvm+0xe3>
  if(p->kstack == 0)
80107248:	8b 46 08             	mov    0x8(%esi),%eax
8010724b:	85 c0                	test   %eax,%eax
8010724d:	0f 84 da 00 00 00    	je     8010732d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107253:	8b 46 04             	mov    0x4(%esi),%eax
80107256:	85 c0                	test   %eax,%eax
80107258:	0f 84 c2 00 00 00    	je     80107320 <switchuvm+0xf0>
  pushcli();
8010725e:	e8 6d d8 ff ff       	call   80104ad0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107263:	e8 68 cb ff ff       	call   80103dd0 <mycpu>
80107268:	89 c3                	mov    %eax,%ebx
8010726a:	e8 61 cb ff ff       	call   80103dd0 <mycpu>
8010726f:	89 c7                	mov    %eax,%edi
80107271:	e8 5a cb ff ff       	call   80103dd0 <mycpu>
80107276:	83 c7 08             	add    $0x8,%edi
80107279:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010727c:	e8 4f cb ff ff       	call   80103dd0 <mycpu>
80107281:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107284:	ba 67 00 00 00       	mov    $0x67,%edx
80107289:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107290:	83 c0 08             	add    $0x8,%eax
80107293:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010729a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010729f:	83 c1 08             	add    $0x8,%ecx
801072a2:	c1 e8 18             	shr    $0x18,%eax
801072a5:	c1 e9 10             	shr    $0x10,%ecx
801072a8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801072ae:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801072b4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801072b9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072c0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801072c5:	e8 06 cb ff ff       	call   80103dd0 <mycpu>
801072ca:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072d1:	e8 fa ca ff ff       	call   80103dd0 <mycpu>
801072d6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072da:	8b 5e 08             	mov    0x8(%esi),%ebx
801072dd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072e3:	e8 e8 ca ff ff       	call   80103dd0 <mycpu>
801072e8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072eb:	e8 e0 ca ff ff       	call   80103dd0 <mycpu>
801072f0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801072f4:	b8 28 00 00 00       	mov    $0x28,%eax
801072f9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072fc:	8b 46 04             	mov    0x4(%esi),%eax
801072ff:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107304:	0f 22 d8             	mov    %eax,%cr3
}
80107307:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010730a:	5b                   	pop    %ebx
8010730b:	5e                   	pop    %esi
8010730c:	5f                   	pop    %edi
8010730d:	5d                   	pop    %ebp
  popcli();
8010730e:	e9 0d d8 ff ff       	jmp    80104b20 <popcli>
    panic("switchuvm: no process");
80107313:	83 ec 0c             	sub    $0xc,%esp
80107316:	68 66 82 10 80       	push   $0x80108266
8010731b:	e8 70 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107320:	83 ec 0c             	sub    $0xc,%esp
80107323:	68 91 82 10 80       	push   $0x80108291
80107328:	e8 63 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
8010732d:	83 ec 0c             	sub    $0xc,%esp
80107330:	68 7c 82 10 80       	push   $0x8010827c
80107335:	e8 56 90 ff ff       	call   80100390 <panic>
8010733a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107340 <inituvm>:
{
80107340:	f3 0f 1e fb          	endbr32 
80107344:	55                   	push   %ebp
80107345:	89 e5                	mov    %esp,%ebp
80107347:	57                   	push   %edi
80107348:	56                   	push   %esi
80107349:	53                   	push   %ebx
8010734a:	83 ec 1c             	sub    $0x1c,%esp
8010734d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107350:	8b 75 10             	mov    0x10(%ebp),%esi
80107353:	8b 7d 08             	mov    0x8(%ebp),%edi
80107356:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107359:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010735f:	77 4b                	ja     801073ac <inituvm+0x6c>
  mem = kalloc();
80107361:	e8 ba b7 ff ff       	call   80102b20 <kalloc>
  memset(mem, 0, PGSIZE);
80107366:	83 ec 04             	sub    $0x4,%esp
80107369:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010736e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107370:	6a 00                	push   $0x0
80107372:	50                   	push   %eax
80107373:	e8 68 d9 ff ff       	call   80104ce0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107378:	58                   	pop    %eax
80107379:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010737f:	5a                   	pop    %edx
80107380:	6a 06                	push   $0x6
80107382:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107387:	31 d2                	xor    %edx,%edx
80107389:	50                   	push   %eax
8010738a:	89 f8                	mov    %edi,%eax
8010738c:	e8 af fc ff ff       	call   80107040 <mappages>
  memmove(mem, init, sz);
80107391:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107394:	89 75 10             	mov    %esi,0x10(%ebp)
80107397:	83 c4 10             	add    $0x10,%esp
8010739a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010739d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801073a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073a3:	5b                   	pop    %ebx
801073a4:	5e                   	pop    %esi
801073a5:	5f                   	pop    %edi
801073a6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801073a7:	e9 d4 d9 ff ff       	jmp    80104d80 <memmove>
    panic("inituvm: more than a page");
801073ac:	83 ec 0c             	sub    $0xc,%esp
801073af:	68 a5 82 10 80       	push   $0x801082a5
801073b4:	e8 d7 8f ff ff       	call   80100390 <panic>
801073b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073c0 <loaduvm>:
{
801073c0:	f3 0f 1e fb          	endbr32 
801073c4:	55                   	push   %ebp
801073c5:	89 e5                	mov    %esp,%ebp
801073c7:	57                   	push   %edi
801073c8:	56                   	push   %esi
801073c9:	53                   	push   %ebx
801073ca:	83 ec 1c             	sub    $0x1c,%esp
801073cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801073d0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801073d3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801073d8:	0f 85 99 00 00 00    	jne    80107477 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801073de:	01 f0                	add    %esi,%eax
801073e0:	89 f3                	mov    %esi,%ebx
801073e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073e5:	8b 45 14             	mov    0x14(%ebp),%eax
801073e8:	01 f0                	add    %esi,%eax
801073ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801073ed:	85 f6                	test   %esi,%esi
801073ef:	75 15                	jne    80107406 <loaduvm+0x46>
801073f1:	eb 6d                	jmp    80107460 <loaduvm+0xa0>
801073f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073f7:	90                   	nop
801073f8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073fe:	89 f0                	mov    %esi,%eax
80107400:	29 d8                	sub    %ebx,%eax
80107402:	39 c6                	cmp    %eax,%esi
80107404:	76 5a                	jbe    80107460 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107406:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107409:	8b 45 08             	mov    0x8(%ebp),%eax
8010740c:	31 c9                	xor    %ecx,%ecx
8010740e:	29 da                	sub    %ebx,%edx
80107410:	e8 ab fb ff ff       	call   80106fc0 <walkpgdir>
80107415:	85 c0                	test   %eax,%eax
80107417:	74 51                	je     8010746a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107419:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010741b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010741e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107423:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107428:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010742e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107431:	29 d9                	sub    %ebx,%ecx
80107433:	05 00 00 00 80       	add    $0x80000000,%eax
80107438:	57                   	push   %edi
80107439:	51                   	push   %ecx
8010743a:	50                   	push   %eax
8010743b:	ff 75 10             	pushl  0x10(%ebp)
8010743e:	e8 0d ab ff ff       	call   80101f50 <readi>
80107443:	83 c4 10             	add    $0x10,%esp
80107446:	39 f8                	cmp    %edi,%eax
80107448:	74 ae                	je     801073f8 <loaduvm+0x38>
}
8010744a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010744d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107452:	5b                   	pop    %ebx
80107453:	5e                   	pop    %esi
80107454:	5f                   	pop    %edi
80107455:	5d                   	pop    %ebp
80107456:	c3                   	ret    
80107457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745e:	66 90                	xchg   %ax,%ax
80107460:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107463:	31 c0                	xor    %eax,%eax
}
80107465:	5b                   	pop    %ebx
80107466:	5e                   	pop    %esi
80107467:	5f                   	pop    %edi
80107468:	5d                   	pop    %ebp
80107469:	c3                   	ret    
      panic("loaduvm: address should exist");
8010746a:	83 ec 0c             	sub    $0xc,%esp
8010746d:	68 bf 82 10 80       	push   $0x801082bf
80107472:	e8 19 8f ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107477:	83 ec 0c             	sub    $0xc,%esp
8010747a:	68 60 83 10 80       	push   $0x80108360
8010747f:	e8 0c 8f ff ff       	call   80100390 <panic>
80107484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010748b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010748f:	90                   	nop

80107490 <allocuvm>:
{
80107490:	f3 0f 1e fb          	endbr32 
80107494:	55                   	push   %ebp
80107495:	89 e5                	mov    %esp,%ebp
80107497:	57                   	push   %edi
80107498:	56                   	push   %esi
80107499:	53                   	push   %ebx
8010749a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010749d:	8b 45 10             	mov    0x10(%ebp),%eax
{
801074a0:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801074a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074a6:	85 c0                	test   %eax,%eax
801074a8:	0f 88 b2 00 00 00    	js     80107560 <allocuvm+0xd0>
  if(newsz < oldsz)
801074ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801074b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801074b4:	0f 82 96 00 00 00    	jb     80107550 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801074ba:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801074c0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801074c6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074c9:	77 40                	ja     8010750b <allocuvm+0x7b>
801074cb:	e9 83 00 00 00       	jmp    80107553 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801074d0:	83 ec 04             	sub    $0x4,%esp
801074d3:	68 00 10 00 00       	push   $0x1000
801074d8:	6a 00                	push   $0x0
801074da:	50                   	push   %eax
801074db:	e8 00 d8 ff ff       	call   80104ce0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801074e0:	58                   	pop    %eax
801074e1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074e7:	5a                   	pop    %edx
801074e8:	6a 06                	push   $0x6
801074ea:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074ef:	89 f2                	mov    %esi,%edx
801074f1:	50                   	push   %eax
801074f2:	89 f8                	mov    %edi,%eax
801074f4:	e8 47 fb ff ff       	call   80107040 <mappages>
801074f9:	83 c4 10             	add    $0x10,%esp
801074fc:	85 c0                	test   %eax,%eax
801074fe:	78 78                	js     80107578 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107500:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107506:	39 75 10             	cmp    %esi,0x10(%ebp)
80107509:	76 48                	jbe    80107553 <allocuvm+0xc3>
    mem = kalloc();
8010750b:	e8 10 b6 ff ff       	call   80102b20 <kalloc>
80107510:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107512:	85 c0                	test   %eax,%eax
80107514:	75 ba                	jne    801074d0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107516:	83 ec 0c             	sub    $0xc,%esp
80107519:	68 dd 82 10 80       	push   $0x801082dd
8010751e:	e8 9d 93 ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
80107523:	8b 45 0c             	mov    0xc(%ebp),%eax
80107526:	83 c4 10             	add    $0x10,%esp
80107529:	39 45 10             	cmp    %eax,0x10(%ebp)
8010752c:	74 32                	je     80107560 <allocuvm+0xd0>
8010752e:	8b 55 10             	mov    0x10(%ebp),%edx
80107531:	89 c1                	mov    %eax,%ecx
80107533:	89 f8                	mov    %edi,%eax
80107535:	e8 96 fb ff ff       	call   801070d0 <deallocuvm.part.0>
      return 0;
8010753a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107541:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107544:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107547:	5b                   	pop    %ebx
80107548:	5e                   	pop    %esi
80107549:	5f                   	pop    %edi
8010754a:	5d                   	pop    %ebp
8010754b:	c3                   	ret    
8010754c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107553:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107556:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107559:	5b                   	pop    %ebx
8010755a:	5e                   	pop    %esi
8010755b:	5f                   	pop    %edi
8010755c:	5d                   	pop    %ebp
8010755d:	c3                   	ret    
8010755e:	66 90                	xchg   %ax,%ax
    return 0;
80107560:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107567:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010756a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010756d:	5b                   	pop    %ebx
8010756e:	5e                   	pop    %esi
8010756f:	5f                   	pop    %edi
80107570:	5d                   	pop    %ebp
80107571:	c3                   	ret    
80107572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107578:	83 ec 0c             	sub    $0xc,%esp
8010757b:	68 f5 82 10 80       	push   $0x801082f5
80107580:	e8 3b 93 ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
80107585:	8b 45 0c             	mov    0xc(%ebp),%eax
80107588:	83 c4 10             	add    $0x10,%esp
8010758b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010758e:	74 0c                	je     8010759c <allocuvm+0x10c>
80107590:	8b 55 10             	mov    0x10(%ebp),%edx
80107593:	89 c1                	mov    %eax,%ecx
80107595:	89 f8                	mov    %edi,%eax
80107597:	e8 34 fb ff ff       	call   801070d0 <deallocuvm.part.0>
      kfree(mem);
8010759c:	83 ec 0c             	sub    $0xc,%esp
8010759f:	53                   	push   %ebx
801075a0:	e8 bb b3 ff ff       	call   80102960 <kfree>
      return 0;
801075a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801075ac:	83 c4 10             	add    $0x10,%esp
}
801075af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075b5:	5b                   	pop    %ebx
801075b6:	5e                   	pop    %esi
801075b7:	5f                   	pop    %edi
801075b8:	5d                   	pop    %ebp
801075b9:	c3                   	ret    
801075ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075c0 <deallocuvm>:
{
801075c0:	f3 0f 1e fb          	endbr32 
801075c4:	55                   	push   %ebp
801075c5:	89 e5                	mov    %esp,%ebp
801075c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
801075cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801075d0:	39 d1                	cmp    %edx,%ecx
801075d2:	73 0c                	jae    801075e0 <deallocuvm+0x20>
}
801075d4:	5d                   	pop    %ebp
801075d5:	e9 f6 fa ff ff       	jmp    801070d0 <deallocuvm.part.0>
801075da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075e0:	89 d0                	mov    %edx,%eax
801075e2:	5d                   	pop    %ebp
801075e3:	c3                   	ret    
801075e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075ef:	90                   	nop

801075f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801075f0:	f3 0f 1e fb          	endbr32 
801075f4:	55                   	push   %ebp
801075f5:	89 e5                	mov    %esp,%ebp
801075f7:	57                   	push   %edi
801075f8:	56                   	push   %esi
801075f9:	53                   	push   %ebx
801075fa:	83 ec 0c             	sub    $0xc,%esp
801075fd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107600:	85 f6                	test   %esi,%esi
80107602:	74 55                	je     80107659 <freevm+0x69>
  if(newsz >= oldsz)
80107604:	31 c9                	xor    %ecx,%ecx
80107606:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010760b:	89 f0                	mov    %esi,%eax
8010760d:	89 f3                	mov    %esi,%ebx
8010760f:	e8 bc fa ff ff       	call   801070d0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107614:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010761a:	eb 0b                	jmp    80107627 <freevm+0x37>
8010761c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107620:	83 c3 04             	add    $0x4,%ebx
80107623:	39 df                	cmp    %ebx,%edi
80107625:	74 23                	je     8010764a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107627:	8b 03                	mov    (%ebx),%eax
80107629:	a8 01                	test   $0x1,%al
8010762b:	74 f3                	je     80107620 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010762d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107632:	83 ec 0c             	sub    $0xc,%esp
80107635:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107638:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010763d:	50                   	push   %eax
8010763e:	e8 1d b3 ff ff       	call   80102960 <kfree>
80107643:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107646:	39 df                	cmp    %ebx,%edi
80107648:	75 dd                	jne    80107627 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010764a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010764d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107650:	5b                   	pop    %ebx
80107651:	5e                   	pop    %esi
80107652:	5f                   	pop    %edi
80107653:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107654:	e9 07 b3 ff ff       	jmp    80102960 <kfree>
    panic("freevm: no pgdir");
80107659:	83 ec 0c             	sub    $0xc,%esp
8010765c:	68 11 83 10 80       	push   $0x80108311
80107661:	e8 2a 8d ff ff       	call   80100390 <panic>
80107666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010766d:	8d 76 00             	lea    0x0(%esi),%esi

80107670 <setupkvm>:
{
80107670:	f3 0f 1e fb          	endbr32 
80107674:	55                   	push   %ebp
80107675:	89 e5                	mov    %esp,%ebp
80107677:	56                   	push   %esi
80107678:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107679:	e8 a2 b4 ff ff       	call   80102b20 <kalloc>
8010767e:	89 c6                	mov    %eax,%esi
80107680:	85 c0                	test   %eax,%eax
80107682:	74 42                	je     801076c6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107684:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107687:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
8010768c:	68 00 10 00 00       	push   $0x1000
80107691:	6a 00                	push   $0x0
80107693:	50                   	push   %eax
80107694:	e8 47 d6 ff ff       	call   80104ce0 <memset>
80107699:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010769c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010769f:	83 ec 08             	sub    $0x8,%esp
801076a2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801076a5:	ff 73 0c             	pushl  0xc(%ebx)
801076a8:	8b 13                	mov    (%ebx),%edx
801076aa:	50                   	push   %eax
801076ab:	29 c1                	sub    %eax,%ecx
801076ad:	89 f0                	mov    %esi,%eax
801076af:	e8 8c f9 ff ff       	call   80107040 <mappages>
801076b4:	83 c4 10             	add    $0x10,%esp
801076b7:	85 c0                	test   %eax,%eax
801076b9:	78 15                	js     801076d0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801076bb:	83 c3 10             	add    $0x10,%ebx
801076be:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801076c4:	75 d6                	jne    8010769c <setupkvm+0x2c>
}
801076c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076c9:	89 f0                	mov    %esi,%eax
801076cb:	5b                   	pop    %ebx
801076cc:	5e                   	pop    %esi
801076cd:	5d                   	pop    %ebp
801076ce:	c3                   	ret    
801076cf:	90                   	nop
      freevm(pgdir);
801076d0:	83 ec 0c             	sub    $0xc,%esp
801076d3:	56                   	push   %esi
      return 0;
801076d4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076d6:	e8 15 ff ff ff       	call   801075f0 <freevm>
      return 0;
801076db:	83 c4 10             	add    $0x10,%esp
}
801076de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076e1:	89 f0                	mov    %esi,%eax
801076e3:	5b                   	pop    %ebx
801076e4:	5e                   	pop    %esi
801076e5:	5d                   	pop    %ebp
801076e6:	c3                   	ret    
801076e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ee:	66 90                	xchg   %ax,%ax

801076f0 <kvmalloc>:
{
801076f0:	f3 0f 1e fb          	endbr32 
801076f4:	55                   	push   %ebp
801076f5:	89 e5                	mov    %esp,%ebp
801076f7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076fa:	e8 71 ff ff ff       	call   80107670 <setupkvm>
801076ff:	a3 44 6b 11 80       	mov    %eax,0x80116b44
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107704:	05 00 00 00 80       	add    $0x80000000,%eax
80107709:	0f 22 d8             	mov    %eax,%cr3
}
8010770c:	c9                   	leave  
8010770d:	c3                   	ret    
8010770e:	66 90                	xchg   %ax,%ax

80107710 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107710:	f3 0f 1e fb          	endbr32 
80107714:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107715:	31 c9                	xor    %ecx,%ecx
{
80107717:	89 e5                	mov    %esp,%ebp
80107719:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010771c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010771f:	8b 45 08             	mov    0x8(%ebp),%eax
80107722:	e8 99 f8 ff ff       	call   80106fc0 <walkpgdir>
  if(pte == 0)
80107727:	85 c0                	test   %eax,%eax
80107729:	74 05                	je     80107730 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
8010772b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010772e:	c9                   	leave  
8010772f:	c3                   	ret    
    panic("clearpteu");
80107730:	83 ec 0c             	sub    $0xc,%esp
80107733:	68 22 83 10 80       	push   $0x80108322
80107738:	e8 53 8c ff ff       	call   80100390 <panic>
8010773d:	8d 76 00             	lea    0x0(%esi),%esi

80107740 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107740:	f3 0f 1e fb          	endbr32 
80107744:	55                   	push   %ebp
80107745:	89 e5                	mov    %esp,%ebp
80107747:	57                   	push   %edi
80107748:	56                   	push   %esi
80107749:	53                   	push   %ebx
8010774a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010774d:	e8 1e ff ff ff       	call   80107670 <setupkvm>
80107752:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107755:	85 c0                	test   %eax,%eax
80107757:	0f 84 9b 00 00 00    	je     801077f8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010775d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107760:	85 c9                	test   %ecx,%ecx
80107762:	0f 84 90 00 00 00    	je     801077f8 <copyuvm+0xb8>
80107768:	31 f6                	xor    %esi,%esi
8010776a:	eb 46                	jmp    801077b2 <copyuvm+0x72>
8010776c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107770:	83 ec 04             	sub    $0x4,%esp
80107773:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107779:	68 00 10 00 00       	push   $0x1000
8010777e:	57                   	push   %edi
8010777f:	50                   	push   %eax
80107780:	e8 fb d5 ff ff       	call   80104d80 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107785:	58                   	pop    %eax
80107786:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010778c:	5a                   	pop    %edx
8010778d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107790:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107795:	89 f2                	mov    %esi,%edx
80107797:	50                   	push   %eax
80107798:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010779b:	e8 a0 f8 ff ff       	call   80107040 <mappages>
801077a0:	83 c4 10             	add    $0x10,%esp
801077a3:	85 c0                	test   %eax,%eax
801077a5:	78 61                	js     80107808 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801077a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801077ad:	39 75 0c             	cmp    %esi,0xc(%ebp)
801077b0:	76 46                	jbe    801077f8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801077b2:	8b 45 08             	mov    0x8(%ebp),%eax
801077b5:	31 c9                	xor    %ecx,%ecx
801077b7:	89 f2                	mov    %esi,%edx
801077b9:	e8 02 f8 ff ff       	call   80106fc0 <walkpgdir>
801077be:	85 c0                	test   %eax,%eax
801077c0:	74 61                	je     80107823 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801077c2:	8b 00                	mov    (%eax),%eax
801077c4:	a8 01                	test   $0x1,%al
801077c6:	74 4e                	je     80107816 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801077c8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801077ca:	25 ff 0f 00 00       	and    $0xfff,%eax
801077cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801077d2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801077d8:	e8 43 b3 ff ff       	call   80102b20 <kalloc>
801077dd:	89 c3                	mov    %eax,%ebx
801077df:	85 c0                	test   %eax,%eax
801077e1:	75 8d                	jne    80107770 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801077e3:	83 ec 0c             	sub    $0xc,%esp
801077e6:	ff 75 e0             	pushl  -0x20(%ebp)
801077e9:	e8 02 fe ff ff       	call   801075f0 <freevm>
  return 0;
801077ee:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077f5:	83 c4 10             	add    $0x10,%esp
}
801077f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077fe:	5b                   	pop    %ebx
801077ff:	5e                   	pop    %esi
80107800:	5f                   	pop    %edi
80107801:	5d                   	pop    %ebp
80107802:	c3                   	ret    
80107803:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107807:	90                   	nop
      kfree(mem);
80107808:	83 ec 0c             	sub    $0xc,%esp
8010780b:	53                   	push   %ebx
8010780c:	e8 4f b1 ff ff       	call   80102960 <kfree>
      goto bad;
80107811:	83 c4 10             	add    $0x10,%esp
80107814:	eb cd                	jmp    801077e3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107816:	83 ec 0c             	sub    $0xc,%esp
80107819:	68 46 83 10 80       	push   $0x80108346
8010781e:	e8 6d 8b ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107823:	83 ec 0c             	sub    $0xc,%esp
80107826:	68 2c 83 10 80       	push   $0x8010832c
8010782b:	e8 60 8b ff ff       	call   80100390 <panic>

80107830 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107830:	f3 0f 1e fb          	endbr32 
80107834:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107835:	31 c9                	xor    %ecx,%ecx
{
80107837:	89 e5                	mov    %esp,%ebp
80107839:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010783c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010783f:	8b 45 08             	mov    0x8(%ebp),%eax
80107842:	e8 79 f7 ff ff       	call   80106fc0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107847:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107849:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010784a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010784c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107851:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107854:	05 00 00 00 80       	add    $0x80000000,%eax
80107859:	83 fa 05             	cmp    $0x5,%edx
8010785c:	ba 00 00 00 00       	mov    $0x0,%edx
80107861:	0f 45 c2             	cmovne %edx,%eax
}
80107864:	c3                   	ret    
80107865:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010786c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107870 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107870:	f3 0f 1e fb          	endbr32 
80107874:	55                   	push   %ebp
80107875:	89 e5                	mov    %esp,%ebp
80107877:	57                   	push   %edi
80107878:	56                   	push   %esi
80107879:	53                   	push   %ebx
8010787a:	83 ec 0c             	sub    $0xc,%esp
8010787d:	8b 75 14             	mov    0x14(%ebp),%esi
80107880:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107883:	85 f6                	test   %esi,%esi
80107885:	75 3c                	jne    801078c3 <copyout+0x53>
80107887:	eb 67                	jmp    801078f0 <copyout+0x80>
80107889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107890:	8b 55 0c             	mov    0xc(%ebp),%edx
80107893:	89 fb                	mov    %edi,%ebx
80107895:	29 d3                	sub    %edx,%ebx
80107897:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010789d:	39 f3                	cmp    %esi,%ebx
8010789f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801078a2:	29 fa                	sub    %edi,%edx
801078a4:	83 ec 04             	sub    $0x4,%esp
801078a7:	01 c2                	add    %eax,%edx
801078a9:	53                   	push   %ebx
801078aa:	ff 75 10             	pushl  0x10(%ebp)
801078ad:	52                   	push   %edx
801078ae:	e8 cd d4 ff ff       	call   80104d80 <memmove>
    len -= n;
    buf += n;
801078b3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
801078b6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
801078bc:	83 c4 10             	add    $0x10,%esp
801078bf:	29 de                	sub    %ebx,%esi
801078c1:	74 2d                	je     801078f0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801078c3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078c5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801078c8:	89 55 0c             	mov    %edx,0xc(%ebp)
801078cb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078d1:	57                   	push   %edi
801078d2:	ff 75 08             	pushl  0x8(%ebp)
801078d5:	e8 56 ff ff ff       	call   80107830 <uva2ka>
    if(pa0 == 0)
801078da:	83 c4 10             	add    $0x10,%esp
801078dd:	85 c0                	test   %eax,%eax
801078df:	75 af                	jne    80107890 <copyout+0x20>
  }
  return 0;
}
801078e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078e9:	5b                   	pop    %ebx
801078ea:	5e                   	pop    %esi
801078eb:	5f                   	pop    %edi
801078ec:	5d                   	pop    %ebp
801078ed:	c3                   	ret    
801078ee:	66 90                	xchg   %ax,%ax
801078f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078f3:	31 c0                	xor    %eax,%eax
}
801078f5:	5b                   	pop    %ebx
801078f6:	5e                   	pop    %esi
801078f7:	5f                   	pop    %edi
801078f8:	5d                   	pop    %ebp
801078f9:	c3                   	ret    
