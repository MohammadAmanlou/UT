
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
80100015:	b8 00 c0 10 00       	mov    $0x10c000,%eax
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
80100028:	bc 30 e6 10 80       	mov    $0x8010e630,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 35 10 80       	mov    $0x801035b0,%eax
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
80100048:	bb 74 e6 10 80       	mov    $0x8010e674,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 00 9d 10 80       	push   $0x80109d00
80100055:	68 40 e6 10 80       	push   $0x8010e640
8010005a:	e8 c1 5b 00 00       	call   80105c20 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 3c 2d 11 80       	mov    $0x80112d3c,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 8c 2d 11 80 3c 	movl   $0x80112d3c,0x80112d8c
8010006e:	2d 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 90 2d 11 80 3c 	movl   $0x80112d3c,0x80112d90
80100078:	2d 11 80 
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
8010008b:	c7 43 50 3c 2d 11 80 	movl   $0x80112d3c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 9d 10 80       	push   $0x80109d07
80100097:	50                   	push   %eax
80100098:	e8 23 59 00 00       	call   801059c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 90 2d 11 80       	mov    0x80112d90,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 90 2d 11 80    	mov    %ebx,0x80112d90
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb e0 2a 11 80    	cmp    $0x80112ae0,%ebx
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
801000e3:	68 40 e6 10 80       	push   $0x8010e640
801000e8:	e8 b3 5c 00 00       	call   80105da0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 90 2d 11 80    	mov    0x80112d90,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb 3c 2d 11 80    	cmp    $0x80112d3c,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 3c 2d 11 80    	cmp    $0x80112d3c,%ebx
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
80100120:	8b 1d 8c 2d 11 80    	mov    0x80112d8c,%ebx
80100126:	81 fb 3c 2d 11 80    	cmp    $0x80112d3c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 3c 2d 11 80    	cmp    $0x80112d3c,%ebx
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
8010015d:	68 40 e6 10 80       	push   $0x8010e640
80100162:	e8 f9 5c 00 00       	call   80105e60 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 58 00 00       	call   80105a00 <acquiresleep>
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
8010018c:	e8 5f 26 00 00       	call   801027f0 <iderw>
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
801001a3:	68 0e 9d 10 80       	push   $0x80109d0e
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
801001c2:	e8 d9 58 00 00       	call   80105aa0 <holdingsleep>
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
801001d8:	e9 13 26 00 00       	jmp    801027f0 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 1f 9d 10 80       	push   $0x80109d1f
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
80100203:	e8 98 58 00 00       	call   80105aa0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 48 58 00 00       	call   80105a60 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 40 e6 10 80 	movl   $0x8010e640,(%esp)
8010021f:	e8 7c 5b 00 00       	call   80105da0 <acquire>
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
80100246:	a1 90 2d 11 80       	mov    0x80112d90,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 3c 2d 11 80 	movl   $0x80112d3c,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 90 2d 11 80       	mov    0x80112d90,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 90 2d 11 80    	mov    %ebx,0x80112d90
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 40 e6 10 80 	movl   $0x8010e640,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 eb 5b 00 00       	jmp    80105e60 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 26 9d 10 80       	push   $0x80109d26
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
801002a5:	e8 06 1b 00 00       	call   80101db0 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 20 d5 10 80 	movl   $0x8010d520,(%esp)
801002b1:	e8 ea 5a 00 00       	call   80105da0 <acquire>
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
801002c6:	a1 20 30 11 80       	mov    0x80113020,%eax
801002cb:	3b 05 24 30 11 80    	cmp    0x80113024,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 20 d5 10 80       	push   $0x8010d520
801002e0:	68 20 30 11 80       	push   $0x80113020
801002e5:	e8 96 42 00 00       	call   80104580 <sleep>
    while(input.r == input.w){
801002ea:	a1 20 30 11 80       	mov    0x80113020,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 24 30 11 80    	cmp    0x80113024,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 71 3c 00 00       	call   80103f70 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 d5 10 80       	push   $0x8010d520
8010030e:	e8 4d 5b 00 00       	call   80105e60 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 b4 19 00 00       	call   80101cd0 <ilock>
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
80100333:	89 15 20 30 11 80    	mov    %edx,0x80113020
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a a0 2f 11 80 	movsbl -0x7feed060(%edx),%ecx
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
80100360:	68 20 d5 10 80       	push   $0x8010d520
80100365:	e8 f6 5a 00 00       	call   80105e60 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 5d 19 00 00       	call   80101cd0 <ilock>
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
80100386:	a3 20 30 11 80       	mov    %eax,0x80113020
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
8010039d:	c7 05 54 d5 10 80 00 	movl   $0x0,0x8010d554
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 5e 2a 00 00       	call   80102e10 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 2d 9d 10 80       	push   $0x80109d2d
801003bb:	e8 00 05 00 00       	call   801008c0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 f7 04 00 00       	call   801008c0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 85 a3 10 80 	movl   $0x8010a385,(%esp)
801003d0:	e8 eb 04 00 00       	call   801008c0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 5f 58 00 00       	call   80105c40 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 41 9d 10 80       	push   $0x80109d41
801003f1:	e8 ca 04 00 00       	call   801008c0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 5c d5 10 80 01 	movl   $0x1,0x8010d55c
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
8010042a:	e8 e1 77 00 00       	call   80107c10 <uartputc>
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
80100468:	8b 3d 58 d5 10 80    	mov    0x8010d558,%edi
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
801004ce:	8b 3d 58 d5 10 80    	mov    0x8010d558,%edi
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
80100560:	c7 05 58 d5 10 80 00 	movl   $0x0,0x8010d558
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
8010058d:	e8 7e 76 00 00       	call   80107c10 <uartputc>
80100592:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100599:	e8 72 76 00 00       	call   80107c10 <uartputc>
8010059e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005a5:	e8 66 76 00 00       	call   80107c10 <uartputc>
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
801005cf:	e8 7c 59 00 00       	call   80105f50 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801005d4:	b8 80 07 00 00       	mov    $0x780,%eax
801005d9:	83 c4 0c             	add    $0xc,%esp
801005dc:	29 d8                	sub    %ebx,%eax
801005de:	01 c0                	add    %eax,%eax
801005e0:	50                   	push   %eax
801005e1:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
801005e8:	6a 00                	push   $0x0
801005ea:	50                   	push   %eax
801005eb:	e8 c0 58 00 00       	call   80105eb0 <memset>
801005f0:	8b 3d 58 d5 10 80    	mov    0x8010d558,%edi
801005f6:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
801005fa:	83 c4 10             	add    $0x10,%esp
801005fd:	01 df                	add    %ebx,%edi
801005ff:	e9 d7 fe ff ff       	jmp    801004db <consputc.part.0+0xcb>
    panic("pos under/overflow");
80100604:	83 ec 0c             	sub    $0xc,%esp
80100607:	68 45 9d 10 80       	push   $0x80109d45
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
80100649:	0f b6 92 c8 9d 10 80 	movzbl -0x7fef6238(%edx),%edx
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
80100683:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
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
801006cc:	a1 58 d5 10 80       	mov    0x8010d558,%eax
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
8010072f:	c7 05 58 d5 10 80 00 	movl   $0x0,0x8010d558
80100736:	00 00 00 
  for ( int i = input.e ; i > input.w ; i-- ){
80100739:	8b 1d 28 30 11 80    	mov    0x80113028,%ebx
8010073f:	3b 1d 24 30 11 80    	cmp    0x80113024,%ebx
80100745:	76 2b                	jbe    80100772 <arrow+0xb2>
    if (input.buf[i - 1] != '\n'){
80100747:	83 eb 01             	sub    $0x1,%ebx
8010074a:	80 bb a0 2f 11 80 0a 	cmpb   $0xa,-0x7feed060(%ebx)
80100751:	74 17                	je     8010076a <arrow+0xaa>
  if(panicked){
80100753:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
80100759:	85 d2                	test   %edx,%edx
8010075b:	74 03                	je     80100760 <arrow+0xa0>
  asm volatile("cli");
8010075d:	fa                   	cli    
    for(;;)
8010075e:	eb fe                	jmp    8010075e <arrow+0x9e>
80100760:	b8 00 01 00 00       	mov    $0x100,%eax
80100765:	e8 a6 fc ff ff       	call   80100410 <consputc.part.0>
  for ( int i = input.e ; i > input.w ; i-- ){
8010076a:	39 1d 24 30 11 80    	cmp    %ebx,0x80113024
80100770:	72 d5                	jb     80100747 <arrow+0x87>
  if (arr == UP){
80100772:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100775:	a1 b8 35 11 80       	mov    0x801135b8,%eax
8010077a:	85 c9                	test   %ecx,%ecx
8010077c:	74 50                	je     801007ce <arrow+0x10e>
  if ((arr == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
8010077e:	83 f8 08             	cmp    $0x8,%eax
80100781:	0f 8f b8 00 00 00    	jg     8010083f <arrow+0x17f>
80100787:	8d 50 01             	lea    0x1(%eax),%edx
8010078a:	3b 15 c0 35 11 80    	cmp    0x801135c0,%edx
80100790:	0f 8d a9 00 00 00    	jge    8010083f <arrow+0x17f>
    input = history.hist[history.index + 2 ];
80100796:	8d 70 02             	lea    0x2(%eax),%esi
80100799:	bf a0 2f 11 80       	mov    $0x80112fa0,%edi
8010079e:	b9 23 00 00 00       	mov    $0x23,%ecx
    history.index ++ ;
801007a3:	89 15 b8 35 11 80    	mov    %edx,0x801135b8
    input = history.hist[history.index + 2 ];
801007a9:	69 f6 8c 00 00 00    	imul   $0x8c,%esi,%esi
801007af:	81 c6 40 30 11 80    	add    $0x80113040,%esi
801007b5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.e -- ;
801007b7:	8b 15 28 30 11 80    	mov    0x80113028,%edx
801007bd:	8d 42 ff             	lea    -0x1(%edx),%eax
    input.buf[input.e] = '\0';
801007c0:	c6 82 9f 2f 11 80 00 	movb   $0x0,-0x7feed061(%edx)
    input.e -- ;
801007c7:	a3 28 30 11 80       	mov    %eax,0x80113028
    input.buf[input.e] = '\0';
801007cc:	eb 35                	jmp    80100803 <arrow+0x143>
    input = history.hist[history.index ];
801007ce:	69 f0 8c 00 00 00    	imul   $0x8c,%eax,%esi
801007d4:	bf a0 2f 11 80       	mov    $0x80112fa0,%edi
801007d9:	b9 23 00 00 00       	mov    $0x23,%ecx
    history.index -- ;
801007de:	83 e8 01             	sub    $0x1,%eax
801007e1:	a3 b8 35 11 80       	mov    %eax,0x801135b8
    input = history.hist[history.index ];
801007e6:	81 c6 40 30 11 80    	add    $0x80113040,%esi
801007ec:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    input.e -- ;
801007ee:	8b 15 28 30 11 80    	mov    0x80113028,%edx
801007f4:	8d 42 ff             	lea    -0x1(%edx),%eax
    input.buf[input.e] = '\0';
801007f7:	c6 82 9f 2f 11 80 00 	movb   $0x0,-0x7feed061(%edx)
    input.e -- ;
801007fe:	a3 28 30 11 80       	mov    %eax,0x80113028
  for (int i = input.w ; i < input.e; i++)
80100803:	8b 1d 24 30 11 80    	mov    0x80113024,%ebx
80100809:	39 d8                	cmp    %ebx,%eax
8010080b:	76 2a                	jbe    80100837 <arrow+0x177>
  if(panicked){
8010080d:	a1 5c d5 10 80       	mov    0x8010d55c,%eax
80100812:	85 c0                	test   %eax,%eax
80100814:	74 0a                	je     80100820 <arrow+0x160>
80100816:	fa                   	cli    
    for(;;)
80100817:	eb fe                	jmp    80100817 <arrow+0x157>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(input.buf[i]);
80100820:	0f be 83 a0 2f 11 80 	movsbl -0x7feed060(%ebx),%eax
  for (int i = input.w ; i < input.e; i++)
80100827:	83 c3 01             	add    $0x1,%ebx
8010082a:	e8 e1 fb ff ff       	call   80100410 <consputc.part.0>
8010082f:	39 1d 28 30 11 80    	cmp    %ebx,0x80113028
80100835:	77 d6                	ja     8010080d <arrow+0x14d>
}
80100837:	83 c4 1c             	add    $0x1c,%esp
8010083a:	5b                   	pop    %ebx
8010083b:	5e                   	pop    %esi
8010083c:	5f                   	pop    %edi
8010083d:	5d                   	pop    %ebp
8010083e:	c3                   	ret    
8010083f:	a1 28 30 11 80       	mov    0x80113028,%eax
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
80100863:	e8 48 15 00 00       	call   80101db0 <iunlock>
  acquire(&cons.lock);
80100868:	c7 04 24 20 d5 10 80 	movl   $0x8010d520,(%esp)
8010086f:	e8 2c 55 00 00       	call   80105da0 <acquire>
  for(i = 0; i < n; i++)
80100874:	83 c4 10             	add    $0x10,%esp
80100877:	85 db                	test   %ebx,%ebx
80100879:	7e 24                	jle    8010089f <consolewrite+0x4f>
8010087b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010087e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100881:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
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
801008a2:	68 20 d5 10 80       	push   $0x8010d520
801008a7:	e8 b4 55 00 00       	call   80105e60 <release>
  ilock(ip);
801008ac:	58                   	pop    %eax
801008ad:	ff 75 08             	pushl  0x8(%ebp)
801008b0:	e8 1b 14 00 00       	call   80101cd0 <ilock>

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
801008cd:	a1 54 d5 10 80       	mov    0x8010d554,%eax
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
801008fc:	8b 0d 5c d5 10 80    	mov    0x8010d55c,%ecx
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
8010098d:	bb 58 9d 10 80       	mov    $0x80109d58,%ebx
      for(; *s; s++)
80100992:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100997:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
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
801009c8:	68 20 d5 10 80       	push   $0x8010d520
801009cd:	e8 ce 53 00 00       	call   80105da0 <acquire>
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
801009f0:	8b 3d 5c d5 10 80    	mov    0x8010d55c,%edi
801009f6:	85 ff                	test   %edi,%edi
801009f8:	0f 84 12 ff ff ff    	je     80100910 <cprintf+0x50>
801009fe:	fa                   	cli    
    for(;;)
801009ff:	eb fe                	jmp    801009ff <cprintf+0x13f>
80100a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100a08:	8b 0d 5c d5 10 80    	mov    0x8010d55c,%ecx
80100a0e:	85 c9                	test   %ecx,%ecx
80100a10:	74 06                	je     80100a18 <cprintf+0x158>
80100a12:	fa                   	cli    
    for(;;)
80100a13:	eb fe                	jmp    80100a13 <cprintf+0x153>
80100a15:	8d 76 00             	lea    0x0(%esi),%esi
80100a18:	b8 25 00 00 00       	mov    $0x25,%eax
80100a1d:	e8 ee f9 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100a22:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
80100a28:	85 d2                	test   %edx,%edx
80100a2a:	74 2c                	je     80100a58 <cprintf+0x198>
80100a2c:	fa                   	cli    
    for(;;)
80100a2d:	eb fe                	jmp    80100a2d <cprintf+0x16d>
80100a2f:	90                   	nop
    release(&cons.lock);
80100a30:	83 ec 0c             	sub    $0xc,%esp
80100a33:	68 20 d5 10 80       	push   $0x8010d520
80100a38:	e8 23 54 00 00       	call   80105e60 <release>
80100a3d:	83 c4 10             	add    $0x10,%esp
}
80100a40:	e9 ee fe ff ff       	jmp    80100933 <cprintf+0x73>
    panic("null fmt");
80100a45:	83 ec 0c             	sub    $0xc,%esp
80100a48:	68 5f 9d 10 80       	push   $0x80109d5f
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
80100a82:	68 20 d5 10 80       	push   $0x8010d520
{
80100a87:	89 45 dc             	mov    %eax,-0x24(%ebp)
  acquire(&cons.lock);
80100a8a:	e8 11 53 00 00       	call   80105da0 <acquire>
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
80100ab8:	3e ff 24 b5 70 9d 10 	notrack jmp *-0x7fef6290(,%esi,4)
80100abf:	80 
80100ac0:	bb 01 00 00 00       	mov    $0x1,%ebx
80100ac5:	eb cb                	jmp    80100a92 <consoleintr+0x22>
80100ac7:	b8 00 01 00 00       	mov    $0x100,%eax
80100acc:	e8 3f f9 ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100ad1:	a1 28 30 11 80       	mov    0x80113028,%eax
80100ad6:	3b 05 24 30 11 80    	cmp    0x80113024,%eax
80100adc:	74 b4                	je     80100a92 <consoleintr+0x22>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100ade:	83 e8 01             	sub    $0x1,%eax
80100ae1:	89 c2                	mov    %eax,%edx
80100ae3:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100ae6:	80 ba a0 2f 11 80 0a 	cmpb   $0xa,-0x7feed060(%edx)
80100aed:	74 a3                	je     80100a92 <consoleintr+0x22>
        input.e--;
80100aef:	a3 28 30 11 80       	mov    %eax,0x80113028
  if(panicked){
80100af4:	a1 5c d5 10 80       	mov    0x8010d55c,%eax
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
80100b14:	a1 bc 35 11 80       	mov    0x801135bc,%eax
80100b19:	85 c0                	test   %eax,%eax
80100b1b:	0f 84 71 ff ff ff    	je     80100a92 <consoleintr+0x22>
80100b21:	a1 c0 35 11 80       	mov    0x801135c0,%eax
80100b26:	2b 05 b8 35 11 80    	sub    0x801135b8,%eax
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
80100b51:	a1 28 30 11 80       	mov    0x80113028,%eax
80100b56:	3b 05 24 30 11 80    	cmp    0x80113024,%eax
80100b5c:	0f 84 30 ff ff ff    	je     80100a92 <consoleintr+0x22>
        input.e--;  
80100b62:	83 e8 01             	sub    $0x1,%eax
80100b65:	a3 28 30 11 80       	mov    %eax,0x80113028
  if(panicked){
80100b6a:	a1 5c d5 10 80       	mov    0x8010d55c,%eax
80100b6f:	85 c0                	test   %eax,%eax
80100b71:	0f 84 06 02 00 00    	je     80100d7d <consoleintr+0x30d>
80100b77:	fa                   	cli    
    for(;;)
80100b78:	eb fe                	jmp    80100b78 <consoleintr+0x108>
      if (backs > 0) {
80100b7a:	a1 58 d5 10 80       	mov    0x8010d558,%eax
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
80100bdd:	a3 58 d5 10 80       	mov    %eax,0x8010d558
80100be2:	e9 ab fe ff ff       	jmp    80100a92 <consoleintr+0x22>
      if ((input.e - backs) > input.w)
80100be7:	a1 58 d5 10 80       	mov    0x8010d558,%eax
80100bec:	8b 3d 28 30 11 80    	mov    0x80113028,%edi
80100bf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100bf5:	29 c7                	sub    %eax,%edi
80100bf7:	3b 3d 24 30 11 80    	cmp    0x80113024,%edi
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
80100c56:	a3 58 d5 10 80       	mov    %eax,0x8010d558
80100c5b:	e9 32 fe ff ff       	jmp    80100a92 <consoleintr+0x22>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100c60:	85 f6                	test   %esi,%esi
80100c62:	0f 84 2a fe ff ff    	je     80100a92 <consoleintr+0x22>
80100c68:	a1 28 30 11 80       	mov    0x80113028,%eax
80100c6d:	89 c2                	mov    %eax,%edx
80100c6f:	2b 15 20 30 11 80    	sub    0x80113020,%edx
80100c75:	83 fa 7f             	cmp    $0x7f,%edx
80100c78:	0f 87 14 fe ff ff    	ja     80100a92 <consoleintr+0x22>
        c = (c == '\r') ? '\n' : c;
80100c7e:	8d 48 01             	lea    0x1(%eax),%ecx
80100c81:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
80100c87:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
80100c8a:	89 0d 28 30 11 80    	mov    %ecx,0x80113028
        c = (c == '\r') ? '\n' : c;
80100c90:	83 fe 0d             	cmp    $0xd,%esi
80100c93:	0f 84 f3 00 00 00    	je     80100d8c <consoleintr+0x31c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100c99:	89 f1                	mov    %esi,%ecx
80100c9b:	88 88 a0 2f 11 80    	mov    %cl,-0x7feed060(%eax)
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
80100cd1:	8b 3d 5c d5 10 80    	mov    0x8010d55c,%edi
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
80100cef:	8b 0d 5c d5 10 80    	mov    0x8010d55c,%ecx
  backs = 0;
80100cf5:	c7 05 58 d5 10 80 00 	movl   $0x0,0x8010d558
80100cfc:	00 00 00 
  input.e = input.w = input.r = 0;
80100cff:	c7 05 20 30 11 80 00 	movl   $0x0,0x80113020
80100d06:	00 00 00 
80100d09:	c7 05 24 30 11 80 00 	movl   $0x0,0x80113024
80100d10:	00 00 00 
80100d13:	c7 05 28 30 11 80 00 	movl   $0x0,0x80113028
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
80100d30:	8b 15 bc 35 11 80    	mov    0x801135bc,%edx
80100d36:	85 d2                	test   %edx,%edx
80100d38:	0f 84 54 fd ff ff    	je     80100a92 <consoleintr+0x22>
80100d3e:	a1 c0 35 11 80       	mov    0x801135c0,%eax
80100d43:	2b 05 b8 35 11 80    	sub    0x801135b8,%eax
80100d49:	39 c2                	cmp    %eax,%edx
80100d4b:	0f 8e 41 fd ff ff    	jle    80100a92 <consoleintr+0x22>
        arrow(UP);
80100d51:	31 c0                	xor    %eax,%eax
80100d53:	e8 68 f9 ff ff       	call   801006c0 <arrow>
80100d58:	e9 35 fd ff ff       	jmp    80100a92 <consoleintr+0x22>
  release(&cons.lock);
80100d5d:	83 ec 0c             	sub    $0xc,%esp
80100d60:	68 20 d5 10 80       	push   $0x8010d520
80100d65:	e8 f6 50 00 00       	call   80105e60 <release>
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
80100d8c:	c6 80 a0 2f 11 80 0a 	movb   $0xa,-0x7feed060(%eax)
  if(panicked){
80100d93:	85 d2                	test   %edx,%edx
80100d95:	0f 85 0e ff ff ff    	jne    80100ca9 <consoleintr+0x239>
80100d9b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100da0:	e8 6b f6 ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100da5:	8b 15 28 30 11 80    	mov    0x80113028,%edx
          if (history.count < 9){
80100dab:	a1 bc 35 11 80       	mov    0x801135bc,%eax
80100db0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100db3:	83 f8 08             	cmp    $0x8,%eax
80100db6:	0f 8f 05 01 00 00    	jg     80100ec1 <consoleintr+0x451>
            history.hist[history.last + 1] = input;
80100dbc:	8b 3d c0 35 11 80    	mov    0x801135c0,%edi
80100dc2:	b9 23 00 00 00       	mov    $0x23,%ecx
80100dc7:	be a0 2f 11 80       	mov    $0x80112fa0,%esi
80100dcc:	83 c7 01             	add    $0x1,%edi
80100dcf:	69 c7 8c 00 00 00    	imul   $0x8c,%edi,%eax
80100dd5:	89 7d e0             	mov    %edi,-0x20(%ebp)
80100dd8:	05 40 30 11 80       	add    $0x80113040,%eax
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
80100dea:	89 3d c0 35 11 80    	mov    %edi,0x801135c0
            history.index = history.last;
80100df0:	89 3d b8 35 11 80    	mov    %edi,0x801135b8
            history.count ++ ;
80100df6:	a3 bc 35 11 80       	mov    %eax,0x801135bc
          wakeup(&input.r);
80100dfb:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100dfe:	89 15 24 30 11 80    	mov    %edx,0x80113024
          wakeup(&input.r);
80100e04:	68 20 30 11 80       	push   $0x80113020
          backs = 0;
80100e09:	c7 05 58 d5 10 80 00 	movl   $0x0,0x8010d558
80100e10:	00 00 00 
          wakeup(&input.r);
80100e13:	e8 28 39 00 00       	call   80104740 <wakeup>
80100e18:	83 c4 10             	add    $0x10,%esp
80100e1b:	e9 72 fc ff ff       	jmp    80100a92 <consoleintr+0x22>
80100e20:	b8 24 00 00 00       	mov    $0x24,%eax
80100e25:	e8 e6 f5 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100e2a:	8b 15 5c d5 10 80    	mov    0x8010d55c,%edx
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
80100e99:	a1 20 30 11 80       	mov    0x80113020,%eax
80100e9e:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
80100ea4:	39 15 28 30 11 80    	cmp    %edx,0x80113028
80100eaa:	0f 85 e2 fb ff ff    	jne    80100a92 <consoleintr+0x22>
80100eb0:	e9 f6 fe ff ff       	jmp    80100dab <consoleintr+0x33b>
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100ebc:	e9 5f 3a 00 00       	jmp    80104920 <procdump>
80100ec1:	b8 40 30 11 80       	mov    $0x80113040,%eax
              history.hist[h] = history.hist[h+1]; 
80100ec6:	8d b0 8c 00 00 00    	lea    0x8c(%eax),%esi
80100ecc:	89 c7                	mov    %eax,%edi
80100ece:	b9 23 00 00 00       	mov    $0x23,%ecx
80100ed3:	05 8c 00 00 00       	add    $0x8c,%eax
80100ed8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            for (int h = 0; h < 9; h++) {
80100eda:	bf 2c 35 11 80       	mov    $0x8011352c,%edi
80100edf:	39 c7                	cmp    %eax,%edi
80100ee1:	75 e3                	jne    80100ec6 <consoleintr+0x456>
            history.hist[9] = input;
80100ee3:	b9 23 00 00 00       	mov    $0x23,%ecx
80100ee8:	be a0 2f 11 80       	mov    $0x80112fa0,%esi
            history.index = 9;
80100eed:	c7 05 b8 35 11 80 09 	movl   $0x9,0x801135b8
80100ef4:	00 00 00 
            history.hist[9] = input;
80100ef7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            history.last = 9;
80100ef9:	c7 05 c0 35 11 80 09 	movl   $0x9,0x801135c0
80100f00:	00 00 00 
            history.count = 10;
80100f03:	c7 05 bc 35 11 80 0a 	movl   $0xa,0x801135bc
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
80100f2a:	68 68 9d 10 80       	push   $0x80109d68
80100f2f:	68 20 d5 10 80       	push   $0x8010d520
80100f34:	e8 e7 4c 00 00       	call   80105c20 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100f39:	58                   	pop    %eax
80100f3a:	5a                   	pop    %edx
80100f3b:	6a 00                	push   $0x0
80100f3d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100f3f:	c7 05 8c 3f 11 80 50 	movl   $0x80100850,0x80113f8c
80100f46:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80100f49:	c7 05 88 3f 11 80 90 	movl   $0x80100290,0x80113f88
80100f50:	02 10 80 
  cons.locking = 1;
80100f53:	c7 05 54 d5 10 80 01 	movl   $0x1,0x8010d554
80100f5a:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100f5d:	e8 3e 1a 00 00       	call   801029a0 <ioapicenable>
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
  pushcli();
80100f80:	e8 1b 4d 00 00       	call   80105ca0 <pushcli>
  for (int i = 0; i < ncpu; i++){
80100f85:	8b 15 40 63 11 80    	mov    0x80116340,%edx
80100f8b:	85 d2                	test   %edx,%edx
80100f8d:	7e 24                	jle    80100fb3 <exec+0x43>
80100f8f:	69 d2 b4 00 00 00    	imul   $0xb4,%edx,%edx
80100f95:	31 c0                	xor    %eax,%eax
80100f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9e:	66 90                	xchg   %ax,%ax
    cpus[i].syscalls_count = 0;
80100fa0:	c7 80 50 5e 11 80 00 	movl   $0x0,-0x7feea1b0(%eax)
80100fa7:	00 00 00 
  for (int i = 0; i < ncpu; i++){
80100faa:	05 b4 00 00 00       	add    $0xb4,%eax
80100faf:	39 d0                	cmp    %edx,%eax
80100fb1:	75 ed                	jne    80100fa0 <exec+0x30>
  }
  count_shared_syscalls = 0;
80100fb3:	c7 05 c0 d5 10 80 00 	movl   $0x0,0x8010d5c0
80100fba:	00 00 00 
  popcli();
80100fbd:	e8 2e 4d 00 00       	call   80105cf0 <popcli>
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100fc2:	e8 a9 2f 00 00       	call   80103f70 <myproc>
80100fc7:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100fcd:	e8 ce 22 00 00       	call   801032a0 <begin_op>

  if((ip = namei(path)) == 0){
80100fd2:	83 ec 0c             	sub    $0xc,%esp
80100fd5:	ff 75 08             	pushl  0x8(%ebp)
80100fd8:	e8 c3 15 00 00       	call   801025a0 <namei>
80100fdd:	83 c4 10             	add    $0x10,%esp
80100fe0:	89 c3                	mov    %eax,%ebx
80100fe2:	85 c0                	test   %eax,%eax
80100fe4:	0f 84 2d 03 00 00    	je     80101317 <exec+0x3a7>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100fea:	83 ec 0c             	sub    $0xc,%esp
80100fed:	50                   	push   %eax
80100fee:	e8 dd 0c 00 00       	call   80101cd0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100ff3:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ff9:	6a 34                	push   $0x34
80100ffb:	6a 00                	push   $0x0
80100ffd:	50                   	push   %eax
80100ffe:	53                   	push   %ebx
80100fff:	e8 cc 0f 00 00       	call   80101fd0 <readi>
80101004:	83 c4 20             	add    $0x20,%esp
80101007:	83 f8 34             	cmp    $0x34,%eax
8010100a:	74 24                	je     80101030 <exec+0xc0>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010100c:	83 ec 0c             	sub    $0xc,%esp
8010100f:	53                   	push   %ebx
80101010:	e8 5b 0f 00 00       	call   80101f70 <iunlockput>
    end_op();
80101015:	e8 f6 22 00 00       	call   80103310 <end_op>
8010101a:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
8010101d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101022:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101025:	5b                   	pop    %ebx
80101026:	5e                   	pop    %esi
80101027:	5f                   	pop    %edi
80101028:	5d                   	pop    %ebp
80101029:	c3                   	ret    
8010102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80101030:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101037:	45 4c 46 
8010103a:	75 d0                	jne    8010100c <exec+0x9c>
  if((pgdir = setupkvm()) == 0)
8010103c:	e8 3f 7d 00 00       	call   80108d80 <setupkvm>
80101041:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101047:	85 c0                	test   %eax,%eax
80101049:	74 c1                	je     8010100c <exec+0x9c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010104b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101052:	00 
80101053:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101059:	0f 84 d7 02 00 00    	je     80101336 <exec+0x3c6>
  sz = 0;
8010105f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101066:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101069:	31 ff                	xor    %edi,%edi
8010106b:	e9 86 00 00 00       	jmp    801010f6 <exec+0x186>
    if(ph.type != ELF_PROG_LOAD)
80101070:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101077:	75 6c                	jne    801010e5 <exec+0x175>
    if(ph.memsz < ph.filesz)
80101079:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010107f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101085:	0f 82 87 00 00 00    	jb     80101112 <exec+0x1a2>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010108b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101091:	72 7f                	jb     80101112 <exec+0x1a2>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101093:	83 ec 04             	sub    $0x4,%esp
80101096:	50                   	push   %eax
80101097:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010109d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010a3:	e8 f8 7a 00 00       	call   80108ba0 <allocuvm>
801010a8:	83 c4 10             	add    $0x10,%esp
801010ab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801010b1:	85 c0                	test   %eax,%eax
801010b3:	74 5d                	je     80101112 <exec+0x1a2>
    if(ph.vaddr % PGSIZE != 0)
801010b5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801010bb:	a9 ff 0f 00 00       	test   $0xfff,%eax
801010c0:	75 50                	jne    80101112 <exec+0x1a2>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801010c2:	83 ec 0c             	sub    $0xc,%esp
801010c5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
801010cb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
801010d1:	53                   	push   %ebx
801010d2:	50                   	push   %eax
801010d3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010d9:	e8 f2 79 00 00       	call   80108ad0 <loaduvm>
801010de:	83 c4 20             	add    $0x20,%esp
801010e1:	85 c0                	test   %eax,%eax
801010e3:	78 2d                	js     80101112 <exec+0x1a2>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010e5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801010ec:	83 c7 01             	add    $0x1,%edi
801010ef:	83 c6 20             	add    $0x20,%esi
801010f2:	39 f8                	cmp    %edi,%eax
801010f4:	7e 32                	jle    80101128 <exec+0x1b8>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801010f6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801010fc:	6a 20                	push   $0x20
801010fe:	56                   	push   %esi
801010ff:	50                   	push   %eax
80101100:	53                   	push   %ebx
80101101:	e8 ca 0e 00 00       	call   80101fd0 <readi>
80101106:	83 c4 10             	add    $0x10,%esp
80101109:	83 f8 20             	cmp    $0x20,%eax
8010110c:	0f 84 5e ff ff ff    	je     80101070 <exec+0x100>
    freevm(pgdir);
80101112:	83 ec 0c             	sub    $0xc,%esp
80101115:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
8010111b:	e8 e0 7b 00 00       	call   80108d00 <freevm>
  if(ip){
80101120:	83 c4 10             	add    $0x10,%esp
80101123:	e9 e4 fe ff ff       	jmp    8010100c <exec+0x9c>
80101128:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
8010112e:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80101134:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
8010113a:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
  iunlockput(ip);
80101140:	83 ec 0c             	sub    $0xc,%esp
80101143:	53                   	push   %ebx
80101144:	e8 27 0e 00 00       	call   80101f70 <iunlockput>
  end_op();
80101149:	e8 c2 21 00 00       	call   80103310 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
8010114e:	83 c4 0c             	add    $0xc,%esp
80101151:	57                   	push   %edi
80101152:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101158:	56                   	push   %esi
80101159:	57                   	push   %edi
8010115a:	e8 41 7a 00 00       	call   80108ba0 <allocuvm>
8010115f:	83 c4 10             	add    $0x10,%esp
80101162:	89 c6                	mov    %eax,%esi
80101164:	85 c0                	test   %eax,%eax
80101166:	0f 84 8f 00 00 00    	je     801011fb <exec+0x28b>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010116c:	83 ec 08             	sub    $0x8,%esp
8010116f:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80101175:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101177:	50                   	push   %eax
80101178:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101179:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010117b:	e8 a0 7c 00 00       	call   80108e20 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101180:	8b 45 0c             	mov    0xc(%ebp),%eax
80101183:	83 c4 10             	add    $0x10,%esp
80101186:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
8010118c:	8b 00                	mov    (%eax),%eax
8010118e:	85 c0                	test   %eax,%eax
80101190:	0f 84 86 00 00 00    	je     8010121c <exec+0x2ac>
80101196:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
8010119c:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801011a2:	eb 23                	jmp    801011c7 <exec+0x257>
801011a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
801011ab:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
801011b2:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
801011b5:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
801011bb:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801011be:	85 c0                	test   %eax,%eax
801011c0:	74 54                	je     80101216 <exec+0x2a6>
    if(argc >= MAXARG)
801011c2:	83 ff 20             	cmp    $0x20,%edi
801011c5:	74 34                	je     801011fb <exec+0x28b>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801011c7:	83 ec 0c             	sub    $0xc,%esp
801011ca:	50                   	push   %eax
801011cb:	e8 e0 4e 00 00       	call   801060b0 <strlen>
801011d0:	f7 d0                	not    %eax
801011d2:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011d4:	58                   	pop    %eax
801011d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801011d8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011db:	ff 34 b8             	pushl  (%eax,%edi,4)
801011de:	e8 cd 4e 00 00       	call   801060b0 <strlen>
801011e3:	83 c0 01             	add    $0x1,%eax
801011e6:	50                   	push   %eax
801011e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801011ea:	ff 34 b8             	pushl  (%eax,%edi,4)
801011ed:	53                   	push   %ebx
801011ee:	56                   	push   %esi
801011ef:	e8 8c 7d 00 00       	call   80108f80 <copyout>
801011f4:	83 c4 20             	add    $0x20,%esp
801011f7:	85 c0                	test   %eax,%eax
801011f9:	79 ad                	jns    801011a8 <exec+0x238>
    freevm(pgdir);
801011fb:	83 ec 0c             	sub    $0xc,%esp
801011fe:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101204:	e8 f7 7a 00 00       	call   80108d00 <freevm>
80101209:	83 c4 10             	add    $0x10,%esp
  return -1;
8010120c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101211:	e9 0c fe ff ff       	jmp    80101022 <exec+0xb2>
80101216:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010121c:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101223:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101225:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
8010122c:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101230:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80101232:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101235:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
8010123b:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010123d:	50                   	push   %eax
8010123e:	52                   	push   %edx
8010123f:	53                   	push   %ebx
80101240:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101246:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010124d:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101250:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80101256:	89 9d f0 fe ff ff    	mov    %ebx,-0x110(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010125c:	e8 1f 7d 00 00       	call   80108f80 <copyout>
80101261:	83 c4 10             	add    $0x10,%esp
80101264:	85 c0                	test   %eax,%eax
80101266:	78 93                	js     801011fb <exec+0x28b>
  for(last=s=path; *s; s++)
80101268:	8b 45 08             	mov    0x8(%ebp),%eax
8010126b:	8b 55 08             	mov    0x8(%ebp),%edx
8010126e:	0f b6 00             	movzbl (%eax),%eax
80101271:	84 c0                	test   %al,%al
80101273:	74 11                	je     80101286 <exec+0x316>
80101275:	89 d1                	mov    %edx,%ecx
    if(*s == '/')
80101277:	83 c1 01             	add    $0x1,%ecx
8010127a:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
8010127c:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
8010127f:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80101282:	84 c0                	test   %al,%al
80101284:	75 f1                	jne    80101277 <exec+0x307>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101286:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
8010128c:	83 ec 04             	sub    $0x4,%esp
8010128f:	6a 10                	push   $0x10
80101291:	89 f8                	mov    %edi,%eax
80101293:	52                   	push   %edx
80101294:	83 c0 6c             	add    $0x6c,%eax
80101297:	50                   	push   %eax
80101298:	e8 d3 4d 00 00       	call   80106070 <safestrcpy>
  for(int i = 0; i < SHAREDREGIONS; i++) {
8010129d:	89 f8                	mov    %edi,%eax
8010129f:	83 c4 10             	add    $0x10,%esp
801012a2:	8d bf ac 00 00 00    	lea    0xac(%edi),%edi
801012a8:	8d 98 ac 05 00 00    	lea    0x5ac(%eax),%ebx
801012ae:	66 90                	xchg   %ax,%ax
    if(curproc->pages[i].shmid != -1 && curproc->pages[i].key != -1) {
801012b0:	83 7f 08 ff          	cmpl   $0xffffffff,0x8(%edi)
801012b4:	74 13                	je     801012c9 <exec+0x359>
801012b6:	83 3f ff             	cmpl   $0xffffffff,(%edi)
801012b9:	74 0e                	je     801012c9 <exec+0x359>
      shmdtWrapper(curproc->pages[i].virtualAddr);
801012bb:	83 ec 0c             	sub    $0xc,%esp
801012be:	ff 77 10             	pushl  0x10(%edi)
801012c1:	e8 2a 8a 00 00       	call   80109cf0 <shmdtWrapper>
801012c6:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < SHAREDREGIONS; i++) {
801012c9:	83 c7 14             	add    $0x14,%edi
801012cc:	39 fb                	cmp    %edi,%ebx
801012ce:	75 e0                	jne    801012b0 <exec+0x340>
  oldpgdir = curproc->pgdir;
801012d0:	8b 8d ec fe ff ff    	mov    -0x114(%ebp),%ecx
  curproc->pgdir = pgdir;
801012d6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  switchuvm(curproc);
801012dc:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801012df:	89 31                	mov    %esi,(%ecx)
  oldpgdir = curproc->pgdir;
801012e1:	8b 79 04             	mov    0x4(%ecx),%edi
  curproc->pgdir = pgdir;
801012e4:	89 41 04             	mov    %eax,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
801012e7:	8b 41 18             	mov    0x18(%ecx),%eax
801012ea:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  curproc->tf->esp = sp;
801012f0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  curproc->tf->eip = elf.entry;  // main
801012f6:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801012f9:	8b 41 18             	mov    0x18(%ecx),%eax
801012fc:	89 70 44             	mov    %esi,0x44(%eax)
  switchuvm(curproc);
801012ff:	51                   	push   %ecx
80101300:	e8 3b 76 00 00       	call   80108940 <switchuvm>
  freevm(oldpgdir);
80101305:	89 3c 24             	mov    %edi,(%esp)
80101308:	e8 f3 79 00 00       	call   80108d00 <freevm>
  return 0;
8010130d:	83 c4 10             	add    $0x10,%esp
80101310:	31 c0                	xor    %eax,%eax
80101312:	e9 0b fd ff ff       	jmp    80101022 <exec+0xb2>
    end_op();
80101317:	e8 f4 1f 00 00       	call   80103310 <end_op>
    cprintf("exec: fail\n");
8010131c:	83 ec 0c             	sub    $0xc,%esp
8010131f:	68 d9 9d 10 80       	push   $0x80109dd9
80101324:	e8 97 f5 ff ff       	call   801008c0 <cprintf>
    return -1;
80101329:	83 c4 10             	add    $0x10,%esp
8010132c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101331:	e9 ec fc ff ff       	jmp    80101022 <exec+0xb2>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101336:	31 f6                	xor    %esi,%esi
80101338:	bf 00 20 00 00       	mov    $0x2000,%edi
8010133d:	e9 fe fd ff ff       	jmp    80101140 <exec+0x1d0>
80101342:	66 90                	xchg   %ax,%ax
80101344:	66 90                	xchg   %ax,%ax
80101346:	66 90                	xchg   %ax,%ax
80101348:	66 90                	xchg   %ax,%ax
8010134a:	66 90                	xchg   %ax,%ax
8010134c:	66 90                	xchg   %ax,%ax
8010134e:	66 90                	xchg   %ax,%ax

80101350 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101350:	f3 0f 1e fb          	endbr32 
80101354:	55                   	push   %ebp
80101355:	89 e5                	mov    %esp,%ebp
80101357:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
8010135a:	68 e5 9d 10 80       	push   $0x80109de5
8010135f:	68 e0 35 11 80       	push   $0x801135e0
80101364:	e8 b7 48 00 00       	call   80105c20 <initlock>
}
80101369:	83 c4 10             	add    $0x10,%esp
8010136c:	c9                   	leave  
8010136d:	c3                   	ret    
8010136e:	66 90                	xchg   %ax,%ax

80101370 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101370:	f3 0f 1e fb          	endbr32 
80101374:	55                   	push   %ebp
80101375:	89 e5                	mov    %esp,%ebp
80101377:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101378:	bb 14 36 11 80       	mov    $0x80113614,%ebx
{
8010137d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101380:	68 e0 35 11 80       	push   $0x801135e0
80101385:	e8 16 4a 00 00       	call   80105da0 <acquire>
8010138a:	83 c4 10             	add    $0x10,%esp
8010138d:	eb 0c                	jmp    8010139b <filealloc+0x2b>
8010138f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101390:	83 c3 18             	add    $0x18,%ebx
80101393:	81 fb 74 3f 11 80    	cmp    $0x80113f74,%ebx
80101399:	74 25                	je     801013c0 <filealloc+0x50>
    if(f->ref == 0){
8010139b:	8b 43 04             	mov    0x4(%ebx),%eax
8010139e:	85 c0                	test   %eax,%eax
801013a0:	75 ee                	jne    80101390 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801013a2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801013a5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801013ac:	68 e0 35 11 80       	push   $0x801135e0
801013b1:	e8 aa 4a 00 00       	call   80105e60 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801013b6:	89 d8                	mov    %ebx,%eax
      return f;
801013b8:	83 c4 10             	add    $0x10,%esp
}
801013bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013be:	c9                   	leave  
801013bf:	c3                   	ret    
  release(&ftable.lock);
801013c0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801013c3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
801013c5:	68 e0 35 11 80       	push   $0x801135e0
801013ca:	e8 91 4a 00 00       	call   80105e60 <release>
}
801013cf:	89 d8                	mov    %ebx,%eax
  return 0;
801013d1:	83 c4 10             	add    $0x10,%esp
}
801013d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013d7:	c9                   	leave  
801013d8:	c3                   	ret    
801013d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013e0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801013e0:	f3 0f 1e fb          	endbr32 
801013e4:	55                   	push   %ebp
801013e5:	89 e5                	mov    %esp,%ebp
801013e7:	53                   	push   %ebx
801013e8:	83 ec 10             	sub    $0x10,%esp
801013eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801013ee:	68 e0 35 11 80       	push   $0x801135e0
801013f3:	e8 a8 49 00 00       	call   80105da0 <acquire>
  if(f->ref < 1)
801013f8:	8b 43 04             	mov    0x4(%ebx),%eax
801013fb:	83 c4 10             	add    $0x10,%esp
801013fe:	85 c0                	test   %eax,%eax
80101400:	7e 1a                	jle    8010141c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80101402:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101405:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101408:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
8010140b:	68 e0 35 11 80       	push   $0x801135e0
80101410:	e8 4b 4a 00 00       	call   80105e60 <release>
  return f;
}
80101415:	89 d8                	mov    %ebx,%eax
80101417:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010141a:	c9                   	leave  
8010141b:	c3                   	ret    
    panic("filedup");
8010141c:	83 ec 0c             	sub    $0xc,%esp
8010141f:	68 ec 9d 10 80       	push   $0x80109dec
80101424:	e8 67 ef ff ff       	call   80100390 <panic>
80101429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101430 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101430:	f3 0f 1e fb          	endbr32 
80101434:	55                   	push   %ebp
80101435:	89 e5                	mov    %esp,%ebp
80101437:	57                   	push   %edi
80101438:	56                   	push   %esi
80101439:	53                   	push   %ebx
8010143a:	83 ec 28             	sub    $0x28,%esp
8010143d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101440:	68 e0 35 11 80       	push   $0x801135e0
80101445:	e8 56 49 00 00       	call   80105da0 <acquire>
  if(f->ref < 1)
8010144a:	8b 53 04             	mov    0x4(%ebx),%edx
8010144d:	83 c4 10             	add    $0x10,%esp
80101450:	85 d2                	test   %edx,%edx
80101452:	0f 8e a1 00 00 00    	jle    801014f9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101458:	83 ea 01             	sub    $0x1,%edx
8010145b:	89 53 04             	mov    %edx,0x4(%ebx)
8010145e:	75 40                	jne    801014a0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101460:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101464:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101467:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101469:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010146f:	8b 73 0c             	mov    0xc(%ebx),%esi
80101472:	88 45 e7             	mov    %al,-0x19(%ebp)
80101475:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101478:	68 e0 35 11 80       	push   $0x801135e0
  ff = *f;
8010147d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101480:	e8 db 49 00 00       	call   80105e60 <release>

  if(ff.type == FD_PIPE)
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	83 ff 01             	cmp    $0x1,%edi
8010148b:	74 53                	je     801014e0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
8010148d:	83 ff 02             	cmp    $0x2,%edi
80101490:	74 26                	je     801014b8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101492:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101495:	5b                   	pop    %ebx
80101496:	5e                   	pop    %esi
80101497:	5f                   	pop    %edi
80101498:	5d                   	pop    %ebp
80101499:	c3                   	ret    
8010149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
801014a0:	c7 45 08 e0 35 11 80 	movl   $0x801135e0,0x8(%ebp)
}
801014a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014aa:	5b                   	pop    %ebx
801014ab:	5e                   	pop    %esi
801014ac:	5f                   	pop    %edi
801014ad:	5d                   	pop    %ebp
    release(&ftable.lock);
801014ae:	e9 ad 49 00 00       	jmp    80105e60 <release>
801014b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014b7:	90                   	nop
    begin_op();
801014b8:	e8 e3 1d 00 00       	call   801032a0 <begin_op>
    iput(ff.ip);
801014bd:	83 ec 0c             	sub    $0xc,%esp
801014c0:	ff 75 e0             	pushl  -0x20(%ebp)
801014c3:	e8 38 09 00 00       	call   80101e00 <iput>
    end_op();
801014c8:	83 c4 10             	add    $0x10,%esp
}
801014cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014ce:	5b                   	pop    %ebx
801014cf:	5e                   	pop    %esi
801014d0:	5f                   	pop    %edi
801014d1:	5d                   	pop    %ebp
    end_op();
801014d2:	e9 39 1e 00 00       	jmp    80103310 <end_op>
801014d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014de:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801014e0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801014e4:	83 ec 08             	sub    $0x8,%esp
801014e7:	53                   	push   %ebx
801014e8:	56                   	push   %esi
801014e9:	e8 92 25 00 00       	call   80103a80 <pipeclose>
801014ee:	83 c4 10             	add    $0x10,%esp
}
801014f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014f4:	5b                   	pop    %ebx
801014f5:	5e                   	pop    %esi
801014f6:	5f                   	pop    %edi
801014f7:	5d                   	pop    %ebp
801014f8:	c3                   	ret    
    panic("fileclose");
801014f9:	83 ec 0c             	sub    $0xc,%esp
801014fc:	68 f4 9d 10 80       	push   $0x80109df4
80101501:	e8 8a ee ff ff       	call   80100390 <panic>
80101506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010150d:	8d 76 00             	lea    0x0(%esi),%esi

80101510 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101510:	f3 0f 1e fb          	endbr32 
80101514:	55                   	push   %ebp
80101515:	89 e5                	mov    %esp,%ebp
80101517:	53                   	push   %ebx
80101518:	83 ec 04             	sub    $0x4,%esp
8010151b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010151e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101521:	75 2d                	jne    80101550 <filestat+0x40>
    ilock(f->ip);
80101523:	83 ec 0c             	sub    $0xc,%esp
80101526:	ff 73 10             	pushl  0x10(%ebx)
80101529:	e8 a2 07 00 00       	call   80101cd0 <ilock>
    stati(f->ip, st);
8010152e:	58                   	pop    %eax
8010152f:	5a                   	pop    %edx
80101530:	ff 75 0c             	pushl  0xc(%ebp)
80101533:	ff 73 10             	pushl  0x10(%ebx)
80101536:	e8 65 0a 00 00       	call   80101fa0 <stati>
    iunlock(f->ip);
8010153b:	59                   	pop    %ecx
8010153c:	ff 73 10             	pushl  0x10(%ebx)
8010153f:	e8 6c 08 00 00       	call   80101db0 <iunlock>
    return 0;
  }
  return -1;
}
80101544:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101547:	83 c4 10             	add    $0x10,%esp
8010154a:	31 c0                	xor    %eax,%eax
}
8010154c:	c9                   	leave  
8010154d:	c3                   	ret    
8010154e:	66 90                	xchg   %ax,%ax
80101550:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101553:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101558:	c9                   	leave  
80101559:	c3                   	ret    
8010155a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101560 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101560:	f3 0f 1e fb          	endbr32 
80101564:	55                   	push   %ebp
80101565:	89 e5                	mov    %esp,%ebp
80101567:	57                   	push   %edi
80101568:	56                   	push   %esi
80101569:	53                   	push   %ebx
8010156a:	83 ec 0c             	sub    $0xc,%esp
8010156d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101570:	8b 75 0c             	mov    0xc(%ebp),%esi
80101573:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101576:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010157a:	74 64                	je     801015e0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
8010157c:	8b 03                	mov    (%ebx),%eax
8010157e:	83 f8 01             	cmp    $0x1,%eax
80101581:	74 45                	je     801015c8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101583:	83 f8 02             	cmp    $0x2,%eax
80101586:	75 5f                	jne    801015e7 <fileread+0x87>
    ilock(f->ip);
80101588:	83 ec 0c             	sub    $0xc,%esp
8010158b:	ff 73 10             	pushl  0x10(%ebx)
8010158e:	e8 3d 07 00 00       	call   80101cd0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101593:	57                   	push   %edi
80101594:	ff 73 14             	pushl  0x14(%ebx)
80101597:	56                   	push   %esi
80101598:	ff 73 10             	pushl  0x10(%ebx)
8010159b:	e8 30 0a 00 00       	call   80101fd0 <readi>
801015a0:	83 c4 20             	add    $0x20,%esp
801015a3:	89 c6                	mov    %eax,%esi
801015a5:	85 c0                	test   %eax,%eax
801015a7:	7e 03                	jle    801015ac <fileread+0x4c>
      f->off += r;
801015a9:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801015ac:	83 ec 0c             	sub    $0xc,%esp
801015af:	ff 73 10             	pushl  0x10(%ebx)
801015b2:	e8 f9 07 00 00       	call   80101db0 <iunlock>
    return r;
801015b7:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801015ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015bd:	89 f0                	mov    %esi,%eax
801015bf:	5b                   	pop    %ebx
801015c0:	5e                   	pop    %esi
801015c1:	5f                   	pop    %edi
801015c2:	5d                   	pop    %ebp
801015c3:	c3                   	ret    
801015c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
801015c8:	8b 43 0c             	mov    0xc(%ebx),%eax
801015cb:	89 45 08             	mov    %eax,0x8(%ebp)
}
801015ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015d1:	5b                   	pop    %ebx
801015d2:	5e                   	pop    %esi
801015d3:	5f                   	pop    %edi
801015d4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801015d5:	e9 46 26 00 00       	jmp    80103c20 <piperead>
801015da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801015e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
801015e5:	eb d3                	jmp    801015ba <fileread+0x5a>
  panic("fileread");
801015e7:	83 ec 0c             	sub    $0xc,%esp
801015ea:	68 fe 9d 10 80       	push   $0x80109dfe
801015ef:	e8 9c ed ff ff       	call   80100390 <panic>
801015f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015ff:	90                   	nop

80101600 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101600:	f3 0f 1e fb          	endbr32 
80101604:	55                   	push   %ebp
80101605:	89 e5                	mov    %esp,%ebp
80101607:	57                   	push   %edi
80101608:	56                   	push   %esi
80101609:	53                   	push   %ebx
8010160a:	83 ec 1c             	sub    $0x1c,%esp
8010160d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101610:	8b 75 08             	mov    0x8(%ebp),%esi
80101613:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101616:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101619:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010161d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101620:	0f 84 c1 00 00 00    	je     801016e7 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101626:	8b 06                	mov    (%esi),%eax
80101628:	83 f8 01             	cmp    $0x1,%eax
8010162b:	0f 84 c3 00 00 00    	je     801016f4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101631:	83 f8 02             	cmp    $0x2,%eax
80101634:	0f 85 cc 00 00 00    	jne    80101706 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010163a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
8010163d:	31 ff                	xor    %edi,%edi
    while(i < n){
8010163f:	85 c0                	test   %eax,%eax
80101641:	7f 34                	jg     80101677 <filewrite+0x77>
80101643:	e9 98 00 00 00       	jmp    801016e0 <filewrite+0xe0>
80101648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010164f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101650:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101653:	83 ec 0c             	sub    $0xc,%esp
80101656:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101659:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010165c:	e8 4f 07 00 00       	call   80101db0 <iunlock>
      end_op();
80101661:	e8 aa 1c 00 00       	call   80103310 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101666:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101669:	83 c4 10             	add    $0x10,%esp
8010166c:	39 c3                	cmp    %eax,%ebx
8010166e:	75 60                	jne    801016d0 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
80101670:	01 df                	add    %ebx,%edi
    while(i < n){
80101672:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101675:	7e 69                	jle    801016e0 <filewrite+0xe0>
      int n1 = n - i;
80101677:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010167a:	b8 00 06 00 00       	mov    $0x600,%eax
8010167f:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101681:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101687:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010168a:	e8 11 1c 00 00       	call   801032a0 <begin_op>
      ilock(f->ip);
8010168f:	83 ec 0c             	sub    $0xc,%esp
80101692:	ff 76 10             	pushl  0x10(%esi)
80101695:	e8 36 06 00 00       	call   80101cd0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010169a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010169d:	53                   	push   %ebx
8010169e:	ff 76 14             	pushl  0x14(%esi)
801016a1:	01 f8                	add    %edi,%eax
801016a3:	50                   	push   %eax
801016a4:	ff 76 10             	pushl  0x10(%esi)
801016a7:	e8 24 0a 00 00       	call   801020d0 <writei>
801016ac:	83 c4 20             	add    $0x20,%esp
801016af:	85 c0                	test   %eax,%eax
801016b1:	7f 9d                	jg     80101650 <filewrite+0x50>
      iunlock(f->ip);
801016b3:	83 ec 0c             	sub    $0xc,%esp
801016b6:	ff 76 10             	pushl  0x10(%esi)
801016b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801016bc:	e8 ef 06 00 00       	call   80101db0 <iunlock>
      end_op();
801016c1:	e8 4a 1c 00 00       	call   80103310 <end_op>
      if(r < 0)
801016c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016c9:	83 c4 10             	add    $0x10,%esp
801016cc:	85 c0                	test   %eax,%eax
801016ce:	75 17                	jne    801016e7 <filewrite+0xe7>
        panic("short filewrite");
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	68 07 9e 10 80       	push   $0x80109e07
801016d8:	e8 b3 ec ff ff       	call   80100390 <panic>
801016dd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
801016e0:	89 f8                	mov    %edi,%eax
801016e2:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801016e5:	74 05                	je     801016ec <filewrite+0xec>
801016e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801016ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016ef:	5b                   	pop    %ebx
801016f0:	5e                   	pop    %esi
801016f1:	5f                   	pop    %edi
801016f2:	5d                   	pop    %ebp
801016f3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801016f4:	8b 46 0c             	mov    0xc(%esi),%eax
801016f7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801016fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016fd:	5b                   	pop    %ebx
801016fe:	5e                   	pop    %esi
801016ff:	5f                   	pop    %edi
80101700:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101701:	e9 1a 24 00 00       	jmp    80103b20 <pipewrite>
  panic("filewrite");
80101706:	83 ec 0c             	sub    $0xc,%esp
80101709:	68 0d 9e 10 80       	push   $0x80109e0d
8010170e:	e8 7d ec ff ff       	call   80100390 <panic>
80101713:	66 90                	xchg   %ax,%ax
80101715:	66 90                	xchg   %ax,%ax
80101717:	66 90                	xchg   %ax,%ax
80101719:	66 90                	xchg   %ax,%ax
8010171b:	66 90                	xchg   %ax,%ax
8010171d:	66 90                	xchg   %ax,%ax
8010171f:	90                   	nop

80101720 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101720:	55                   	push   %ebp
80101721:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101723:	89 d0                	mov    %edx,%eax
80101725:	c1 e8 0c             	shr    $0xc,%eax
80101728:	03 05 f8 3f 11 80    	add    0x80113ff8,%eax
{
8010172e:	89 e5                	mov    %esp,%ebp
80101730:	56                   	push   %esi
80101731:	53                   	push   %ebx
80101732:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101734:	83 ec 08             	sub    $0x8,%esp
80101737:	50                   	push   %eax
80101738:	51                   	push   %ecx
80101739:	e8 92 e9 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010173e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101740:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101743:	ba 01 00 00 00       	mov    $0x1,%edx
80101748:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010174b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101751:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101754:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101756:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
8010175b:	85 d1                	test   %edx,%ecx
8010175d:	74 25                	je     80101784 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010175f:	f7 d2                	not    %edx
  log_write(bp);
80101761:	83 ec 0c             	sub    $0xc,%esp
80101764:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
80101766:	21 ca                	and    %ecx,%edx
80101768:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
8010176c:	50                   	push   %eax
8010176d:	e8 0e 1d 00 00       	call   80103480 <log_write>
  brelse(bp);
80101772:	89 34 24             	mov    %esi,(%esp)
80101775:	e8 76 ea ff ff       	call   801001f0 <brelse>
}
8010177a:	83 c4 10             	add    $0x10,%esp
8010177d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101780:	5b                   	pop    %ebx
80101781:	5e                   	pop    %esi
80101782:	5d                   	pop    %ebp
80101783:	c3                   	ret    
    panic("freeing free block");
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 17 9e 10 80       	push   $0x80109e17
8010178c:	e8 ff eb ff ff       	call   80100390 <panic>
80101791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010179f:	90                   	nop

801017a0 <balloc>:
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801017a9:	8b 0d e0 3f 11 80    	mov    0x80113fe0,%ecx
{
801017af:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801017b2:	85 c9                	test   %ecx,%ecx
801017b4:	0f 84 87 00 00 00    	je     80101841 <balloc+0xa1>
801017ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801017c1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801017c4:	83 ec 08             	sub    $0x8,%esp
801017c7:	89 f0                	mov    %esi,%eax
801017c9:	c1 f8 0c             	sar    $0xc,%eax
801017cc:	03 05 f8 3f 11 80    	add    0x80113ff8,%eax
801017d2:	50                   	push   %eax
801017d3:	ff 75 d8             	pushl  -0x28(%ebp)
801017d6:	e8 f5 e8 ff ff       	call   801000d0 <bread>
801017db:	83 c4 10             	add    $0x10,%esp
801017de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801017e1:	a1 e0 3f 11 80       	mov    0x80113fe0,%eax
801017e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801017e9:	31 c0                	xor    %eax,%eax
801017eb:	eb 2f                	jmp    8010181c <balloc+0x7c>
801017ed:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801017f0:	89 c1                	mov    %eax,%ecx
801017f2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801017f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801017fa:	83 e1 07             	and    $0x7,%ecx
801017fd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801017ff:	89 c1                	mov    %eax,%ecx
80101801:	c1 f9 03             	sar    $0x3,%ecx
80101804:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101809:	89 fa                	mov    %edi,%edx
8010180b:	85 df                	test   %ebx,%edi
8010180d:	74 41                	je     80101850 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010180f:	83 c0 01             	add    $0x1,%eax
80101812:	83 c6 01             	add    $0x1,%esi
80101815:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010181a:	74 05                	je     80101821 <balloc+0x81>
8010181c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010181f:	77 cf                	ja     801017f0 <balloc+0x50>
    brelse(bp);
80101821:	83 ec 0c             	sub    $0xc,%esp
80101824:	ff 75 e4             	pushl  -0x1c(%ebp)
80101827:	e8 c4 e9 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010182c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101833:	83 c4 10             	add    $0x10,%esp
80101836:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101839:	39 05 e0 3f 11 80    	cmp    %eax,0x80113fe0
8010183f:	77 80                	ja     801017c1 <balloc+0x21>
  panic("balloc: out of blocks");
80101841:	83 ec 0c             	sub    $0xc,%esp
80101844:	68 2a 9e 10 80       	push   $0x80109e2a
80101849:	e8 42 eb ff ff       	call   80100390 <panic>
8010184e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101850:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101853:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101856:	09 da                	or     %ebx,%edx
80101858:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010185c:	57                   	push   %edi
8010185d:	e8 1e 1c 00 00       	call   80103480 <log_write>
        brelse(bp);
80101862:	89 3c 24             	mov    %edi,(%esp)
80101865:	e8 86 e9 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010186a:	58                   	pop    %eax
8010186b:	5a                   	pop    %edx
8010186c:	56                   	push   %esi
8010186d:	ff 75 d8             	pushl  -0x28(%ebp)
80101870:	e8 5b e8 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101875:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101878:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010187a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010187d:	68 00 02 00 00       	push   $0x200
80101882:	6a 00                	push   $0x0
80101884:	50                   	push   %eax
80101885:	e8 26 46 00 00       	call   80105eb0 <memset>
  log_write(bp);
8010188a:	89 1c 24             	mov    %ebx,(%esp)
8010188d:	e8 ee 1b 00 00       	call   80103480 <log_write>
  brelse(bp);
80101892:	89 1c 24             	mov    %ebx,(%esp)
80101895:	e8 56 e9 ff ff       	call   801001f0 <brelse>
}
8010189a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010189d:	89 f0                	mov    %esi,%eax
8010189f:	5b                   	pop    %ebx
801018a0:	5e                   	pop    %esi
801018a1:	5f                   	pop    %edi
801018a2:	5d                   	pop    %ebp
801018a3:	c3                   	ret    
801018a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop

801018b0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	57                   	push   %edi
801018b4:	89 c7                	mov    %eax,%edi
801018b6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801018b7:	31 f6                	xor    %esi,%esi
{
801018b9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018ba:	bb 34 40 11 80       	mov    $0x80114034,%ebx
{
801018bf:	83 ec 28             	sub    $0x28,%esp
801018c2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801018c5:	68 00 40 11 80       	push   $0x80114000
801018ca:	e8 d1 44 00 00       	call   80105da0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801018d2:	83 c4 10             	add    $0x10,%esp
801018d5:	eb 1b                	jmp    801018f2 <iget+0x42>
801018d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018de:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018e0:	39 3b                	cmp    %edi,(%ebx)
801018e2:	74 6c                	je     80101950 <iget+0xa0>
801018e4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018ea:	81 fb 54 5c 11 80    	cmp    $0x80115c54,%ebx
801018f0:	73 26                	jae    80101918 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018f2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801018f5:	85 c9                	test   %ecx,%ecx
801018f7:	7f e7                	jg     801018e0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018f9:	85 f6                	test   %esi,%esi
801018fb:	75 e7                	jne    801018e4 <iget+0x34>
801018fd:	89 d8                	mov    %ebx,%eax
801018ff:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101905:	85 c9                	test   %ecx,%ecx
80101907:	75 6e                	jne    80101977 <iget+0xc7>
80101909:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010190b:	81 fb 54 5c 11 80    	cmp    $0x80115c54,%ebx
80101911:	72 df                	jb     801018f2 <iget+0x42>
80101913:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101917:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101918:	85 f6                	test   %esi,%esi
8010191a:	74 73                	je     8010198f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010191c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010191f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101921:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101924:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010192b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101932:	68 00 40 11 80       	push   $0x80114000
80101937:	e8 24 45 00 00       	call   80105e60 <release>

  return ip;
8010193c:	83 c4 10             	add    $0x10,%esp
}
8010193f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101942:	89 f0                	mov    %esi,%eax
80101944:	5b                   	pop    %ebx
80101945:	5e                   	pop    %esi
80101946:	5f                   	pop    %edi
80101947:	5d                   	pop    %ebp
80101948:	c3                   	ret    
80101949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101950:	39 53 04             	cmp    %edx,0x4(%ebx)
80101953:	75 8f                	jne    801018e4 <iget+0x34>
      release(&icache.lock);
80101955:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101958:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010195b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010195d:	68 00 40 11 80       	push   $0x80114000
      ip->ref++;
80101962:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101965:	e8 f6 44 00 00       	call   80105e60 <release>
      return ip;
8010196a:	83 c4 10             	add    $0x10,%esp
}
8010196d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101970:	89 f0                	mov    %esi,%eax
80101972:	5b                   	pop    %ebx
80101973:	5e                   	pop    %esi
80101974:	5f                   	pop    %edi
80101975:	5d                   	pop    %ebp
80101976:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101977:	81 fb 54 5c 11 80    	cmp    $0x80115c54,%ebx
8010197d:	73 10                	jae    8010198f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010197f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101982:	85 c9                	test   %ecx,%ecx
80101984:	0f 8f 56 ff ff ff    	jg     801018e0 <iget+0x30>
8010198a:	e9 6e ff ff ff       	jmp    801018fd <iget+0x4d>
    panic("iget: no inodes");
8010198f:	83 ec 0c             	sub    $0xc,%esp
80101992:	68 40 9e 10 80       	push   $0x80109e40
80101997:	e8 f4 e9 ff ff       	call   80100390 <panic>
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	89 c6                	mov    %eax,%esi
801019a7:	53                   	push   %ebx
801019a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801019ab:	83 fa 0b             	cmp    $0xb,%edx
801019ae:	0f 86 84 00 00 00    	jbe    80101a38 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801019b4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801019b7:	83 fb 7f             	cmp    $0x7f,%ebx
801019ba:	0f 87 98 00 00 00    	ja     80101a58 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801019c0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801019c6:	8b 16                	mov    (%esi),%edx
801019c8:	85 c0                	test   %eax,%eax
801019ca:	74 54                	je     80101a20 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801019cc:	83 ec 08             	sub    $0x8,%esp
801019cf:	50                   	push   %eax
801019d0:	52                   	push   %edx
801019d1:	e8 fa e6 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801019d6:	83 c4 10             	add    $0x10,%esp
801019d9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
801019dd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801019df:	8b 1a                	mov    (%edx),%ebx
801019e1:	85 db                	test   %ebx,%ebx
801019e3:	74 1b                	je     80101a00 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801019e5:	83 ec 0c             	sub    $0xc,%esp
801019e8:	57                   	push   %edi
801019e9:	e8 02 e8 ff ff       	call   801001f0 <brelse>
    return addr;
801019ee:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801019f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019f4:	89 d8                	mov    %ebx,%eax
801019f6:	5b                   	pop    %ebx
801019f7:	5e                   	pop    %esi
801019f8:	5f                   	pop    %edi
801019f9:	5d                   	pop    %ebp
801019fa:	c3                   	ret    
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101a00:	8b 06                	mov    (%esi),%eax
80101a02:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101a05:	e8 96 fd ff ff       	call   801017a0 <balloc>
80101a0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101a0d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101a10:	89 c3                	mov    %eax,%ebx
80101a12:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101a14:	57                   	push   %edi
80101a15:	e8 66 1a 00 00       	call   80103480 <log_write>
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	eb c6                	jmp    801019e5 <bmap+0x45>
80101a1f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101a20:	89 d0                	mov    %edx,%eax
80101a22:	e8 79 fd ff ff       	call   801017a0 <balloc>
80101a27:	8b 16                	mov    (%esi),%edx
80101a29:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101a2f:	eb 9b                	jmp    801019cc <bmap+0x2c>
80101a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101a38:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80101a3b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101a3e:	85 db                	test   %ebx,%ebx
80101a40:	75 af                	jne    801019f1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101a42:	8b 00                	mov    (%eax),%eax
80101a44:	e8 57 fd ff ff       	call   801017a0 <balloc>
80101a49:	89 47 5c             	mov    %eax,0x5c(%edi)
80101a4c:	89 c3                	mov    %eax,%ebx
}
80101a4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a51:	89 d8                	mov    %ebx,%eax
80101a53:	5b                   	pop    %ebx
80101a54:	5e                   	pop    %esi
80101a55:	5f                   	pop    %edi
80101a56:	5d                   	pop    %ebp
80101a57:	c3                   	ret    
  panic("bmap: out of range");
80101a58:	83 ec 0c             	sub    $0xc,%esp
80101a5b:	68 50 9e 10 80       	push   $0x80109e50
80101a60:	e8 2b e9 ff ff       	call   80100390 <panic>
80101a65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a70 <readsb>:
{
80101a70:	f3 0f 1e fb          	endbr32 
80101a74:	55                   	push   %ebp
80101a75:	89 e5                	mov    %esp,%ebp
80101a77:	56                   	push   %esi
80101a78:	53                   	push   %ebx
80101a79:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101a7c:	83 ec 08             	sub    $0x8,%esp
80101a7f:	6a 01                	push   $0x1
80101a81:	ff 75 08             	pushl  0x8(%ebp)
80101a84:	e8 47 e6 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101a89:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101a8c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101a8e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101a91:	6a 1c                	push   $0x1c
80101a93:	50                   	push   %eax
80101a94:	56                   	push   %esi
80101a95:	e8 b6 44 00 00       	call   80105f50 <memmove>
  brelse(bp);
80101a9a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a9d:	83 c4 10             	add    $0x10,%esp
}
80101aa0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101aa3:	5b                   	pop    %ebx
80101aa4:	5e                   	pop    %esi
80101aa5:	5d                   	pop    %ebp
  brelse(bp);
80101aa6:	e9 45 e7 ff ff       	jmp    801001f0 <brelse>
80101aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aaf:	90                   	nop

80101ab0 <iinit>:
{
80101ab0:	f3 0f 1e fb          	endbr32 
80101ab4:	55                   	push   %ebp
80101ab5:	89 e5                	mov    %esp,%ebp
80101ab7:	53                   	push   %ebx
80101ab8:	bb 40 40 11 80       	mov    $0x80114040,%ebx
80101abd:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101ac0:	68 63 9e 10 80       	push   $0x80109e63
80101ac5:	68 00 40 11 80       	push   $0x80114000
80101aca:	e8 51 41 00 00       	call   80105c20 <initlock>
  for(i = 0; i < NINODE; i++) {
80101acf:	83 c4 10             	add    $0x10,%esp
80101ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101ad8:	83 ec 08             	sub    $0x8,%esp
80101adb:	68 6a 9e 10 80       	push   $0x80109e6a
80101ae0:	53                   	push   %ebx
80101ae1:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101ae7:	e8 d4 3e 00 00       	call   801059c0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101aec:	83 c4 10             	add    $0x10,%esp
80101aef:	81 fb 60 5c 11 80    	cmp    $0x80115c60,%ebx
80101af5:	75 e1                	jne    80101ad8 <iinit+0x28>
  readsb(dev, &sb);
80101af7:	83 ec 08             	sub    $0x8,%esp
80101afa:	68 e0 3f 11 80       	push   $0x80113fe0
80101aff:	ff 75 08             	pushl  0x8(%ebp)
80101b02:	e8 69 ff ff ff       	call   80101a70 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101b07:	ff 35 f8 3f 11 80    	pushl  0x80113ff8
80101b0d:	ff 35 f4 3f 11 80    	pushl  0x80113ff4
80101b13:	ff 35 f0 3f 11 80    	pushl  0x80113ff0
80101b19:	ff 35 ec 3f 11 80    	pushl  0x80113fec
80101b1f:	ff 35 e8 3f 11 80    	pushl  0x80113fe8
80101b25:	ff 35 e4 3f 11 80    	pushl  0x80113fe4
80101b2b:	ff 35 e0 3f 11 80    	pushl  0x80113fe0
80101b31:	68 d0 9e 10 80       	push   $0x80109ed0
80101b36:	e8 85 ed ff ff       	call   801008c0 <cprintf>
}
80101b3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b3e:	83 c4 30             	add    $0x30,%esp
80101b41:	c9                   	leave  
80101b42:	c3                   	ret    
80101b43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b50 <ialloc>:
{
80101b50:	f3 0f 1e fb          	endbr32 
80101b54:	55                   	push   %ebp
80101b55:	89 e5                	mov    %esp,%ebp
80101b57:	57                   	push   %edi
80101b58:	56                   	push   %esi
80101b59:	53                   	push   %ebx
80101b5a:	83 ec 1c             	sub    $0x1c,%esp
80101b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101b60:	83 3d e8 3f 11 80 01 	cmpl   $0x1,0x80113fe8
{
80101b67:	8b 75 08             	mov    0x8(%ebp),%esi
80101b6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101b6d:	0f 86 8d 00 00 00    	jbe    80101c00 <ialloc+0xb0>
80101b73:	bf 01 00 00 00       	mov    $0x1,%edi
80101b78:	eb 1d                	jmp    80101b97 <ialloc+0x47>
80101b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101b80:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101b83:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101b86:	53                   	push   %ebx
80101b87:	e8 64 e6 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101b8c:	83 c4 10             	add    $0x10,%esp
80101b8f:	3b 3d e8 3f 11 80    	cmp    0x80113fe8,%edi
80101b95:	73 69                	jae    80101c00 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101b97:	89 f8                	mov    %edi,%eax
80101b99:	83 ec 08             	sub    $0x8,%esp
80101b9c:	c1 e8 03             	shr    $0x3,%eax
80101b9f:	03 05 f4 3f 11 80    	add    0x80113ff4,%eax
80101ba5:	50                   	push   %eax
80101ba6:	56                   	push   %esi
80101ba7:	e8 24 e5 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101bac:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101baf:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101bb1:	89 f8                	mov    %edi,%eax
80101bb3:	83 e0 07             	and    $0x7,%eax
80101bb6:	c1 e0 06             	shl    $0x6,%eax
80101bb9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101bbd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101bc1:	75 bd                	jne    80101b80 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101bc3:	83 ec 04             	sub    $0x4,%esp
80101bc6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101bc9:	6a 40                	push   $0x40
80101bcb:	6a 00                	push   $0x0
80101bcd:	51                   	push   %ecx
80101bce:	e8 dd 42 00 00       	call   80105eb0 <memset>
      dip->type = type;
80101bd3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101bd7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101bda:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101bdd:	89 1c 24             	mov    %ebx,(%esp)
80101be0:	e8 9b 18 00 00       	call   80103480 <log_write>
      brelse(bp);
80101be5:	89 1c 24             	mov    %ebx,(%esp)
80101be8:	e8 03 e6 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101bed:	83 c4 10             	add    $0x10,%esp
}
80101bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101bf3:	89 fa                	mov    %edi,%edx
}
80101bf5:	5b                   	pop    %ebx
      return iget(dev, inum);
80101bf6:	89 f0                	mov    %esi,%eax
}
80101bf8:	5e                   	pop    %esi
80101bf9:	5f                   	pop    %edi
80101bfa:	5d                   	pop    %ebp
      return iget(dev, inum);
80101bfb:	e9 b0 fc ff ff       	jmp    801018b0 <iget>
  panic("ialloc: no inodes");
80101c00:	83 ec 0c             	sub    $0xc,%esp
80101c03:	68 70 9e 10 80       	push   $0x80109e70
80101c08:	e8 83 e7 ff ff       	call   80100390 <panic>
80101c0d:	8d 76 00             	lea    0x0(%esi),%esi

80101c10 <iupdate>:
{
80101c10:	f3 0f 1e fb          	endbr32 
80101c14:	55                   	push   %ebp
80101c15:	89 e5                	mov    %esp,%ebp
80101c17:	56                   	push   %esi
80101c18:	53                   	push   %ebx
80101c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c1c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c1f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c22:	83 ec 08             	sub    $0x8,%esp
80101c25:	c1 e8 03             	shr    $0x3,%eax
80101c28:	03 05 f4 3f 11 80    	add    0x80113ff4,%eax
80101c2e:	50                   	push   %eax
80101c2f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101c32:	e8 99 e4 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101c37:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c3b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c3e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c40:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101c43:	83 e0 07             	and    $0x7,%eax
80101c46:	c1 e0 06             	shl    $0x6,%eax
80101c49:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101c4d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101c50:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c54:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101c57:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101c5b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101c5f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101c63:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101c67:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101c6b:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101c6e:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c71:	6a 34                	push   $0x34
80101c73:	53                   	push   %ebx
80101c74:	50                   	push   %eax
80101c75:	e8 d6 42 00 00       	call   80105f50 <memmove>
  log_write(bp);
80101c7a:	89 34 24             	mov    %esi,(%esp)
80101c7d:	e8 fe 17 00 00       	call   80103480 <log_write>
  brelse(bp);
80101c82:	89 75 08             	mov    %esi,0x8(%ebp)
80101c85:	83 c4 10             	add    $0x10,%esp
}
80101c88:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c8b:	5b                   	pop    %ebx
80101c8c:	5e                   	pop    %esi
80101c8d:	5d                   	pop    %ebp
  brelse(bp);
80101c8e:	e9 5d e5 ff ff       	jmp    801001f0 <brelse>
80101c93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ca0 <idup>:
{
80101ca0:	f3 0f 1e fb          	endbr32 
80101ca4:	55                   	push   %ebp
80101ca5:	89 e5                	mov    %esp,%ebp
80101ca7:	53                   	push   %ebx
80101ca8:	83 ec 10             	sub    $0x10,%esp
80101cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101cae:	68 00 40 11 80       	push   $0x80114000
80101cb3:	e8 e8 40 00 00       	call   80105da0 <acquire>
  ip->ref++;
80101cb8:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101cbc:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80101cc3:	e8 98 41 00 00       	call   80105e60 <release>
}
80101cc8:	89 d8                	mov    %ebx,%eax
80101cca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ccd:	c9                   	leave  
80101cce:	c3                   	ret    
80101ccf:	90                   	nop

80101cd0 <ilock>:
{
80101cd0:	f3 0f 1e fb          	endbr32 
80101cd4:	55                   	push   %ebp
80101cd5:	89 e5                	mov    %esp,%ebp
80101cd7:	56                   	push   %esi
80101cd8:	53                   	push   %ebx
80101cd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101cdc:	85 db                	test   %ebx,%ebx
80101cde:	0f 84 b3 00 00 00    	je     80101d97 <ilock+0xc7>
80101ce4:	8b 53 08             	mov    0x8(%ebx),%edx
80101ce7:	85 d2                	test   %edx,%edx
80101ce9:	0f 8e a8 00 00 00    	jle    80101d97 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101cef:	83 ec 0c             	sub    $0xc,%esp
80101cf2:	8d 43 0c             	lea    0xc(%ebx),%eax
80101cf5:	50                   	push   %eax
80101cf6:	e8 05 3d 00 00       	call   80105a00 <acquiresleep>
  if(ip->valid == 0){
80101cfb:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101cfe:	83 c4 10             	add    $0x10,%esp
80101d01:	85 c0                	test   %eax,%eax
80101d03:	74 0b                	je     80101d10 <ilock+0x40>
}
80101d05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d08:	5b                   	pop    %ebx
80101d09:	5e                   	pop    %esi
80101d0a:	5d                   	pop    %ebp
80101d0b:	c3                   	ret    
80101d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d10:	8b 43 04             	mov    0x4(%ebx),%eax
80101d13:	83 ec 08             	sub    $0x8,%esp
80101d16:	c1 e8 03             	shr    $0x3,%eax
80101d19:	03 05 f4 3f 11 80    	add    0x80113ff4,%eax
80101d1f:	50                   	push   %eax
80101d20:	ff 33                	pushl  (%ebx)
80101d22:	e8 a9 e3 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101d27:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101d2a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101d2c:	8b 43 04             	mov    0x4(%ebx),%eax
80101d2f:	83 e0 07             	and    $0x7,%eax
80101d32:	c1 e0 06             	shl    $0x6,%eax
80101d35:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101d39:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101d3c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101d3f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101d43:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101d47:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101d4b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101d4f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101d53:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101d57:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101d5b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101d5e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101d61:	6a 34                	push   $0x34
80101d63:	50                   	push   %eax
80101d64:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101d67:	50                   	push   %eax
80101d68:	e8 e3 41 00 00       	call   80105f50 <memmove>
    brelse(bp);
80101d6d:	89 34 24             	mov    %esi,(%esp)
80101d70:	e8 7b e4 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101d75:	83 c4 10             	add    $0x10,%esp
80101d78:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101d7d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101d84:	0f 85 7b ff ff ff    	jne    80101d05 <ilock+0x35>
      panic("ilock: no type");
80101d8a:	83 ec 0c             	sub    $0xc,%esp
80101d8d:	68 88 9e 10 80       	push   $0x80109e88
80101d92:	e8 f9 e5 ff ff       	call   80100390 <panic>
    panic("ilock");
80101d97:	83 ec 0c             	sub    $0xc,%esp
80101d9a:	68 82 9e 10 80       	push   $0x80109e82
80101d9f:	e8 ec e5 ff ff       	call   80100390 <panic>
80101da4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101daf:	90                   	nop

80101db0 <iunlock>:
{
80101db0:	f3 0f 1e fb          	endbr32 
80101db4:	55                   	push   %ebp
80101db5:	89 e5                	mov    %esp,%ebp
80101db7:	56                   	push   %esi
80101db8:	53                   	push   %ebx
80101db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101dbc:	85 db                	test   %ebx,%ebx
80101dbe:	74 28                	je     80101de8 <iunlock+0x38>
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	8d 73 0c             	lea    0xc(%ebx),%esi
80101dc6:	56                   	push   %esi
80101dc7:	e8 d4 3c 00 00       	call   80105aa0 <holdingsleep>
80101dcc:	83 c4 10             	add    $0x10,%esp
80101dcf:	85 c0                	test   %eax,%eax
80101dd1:	74 15                	je     80101de8 <iunlock+0x38>
80101dd3:	8b 43 08             	mov    0x8(%ebx),%eax
80101dd6:	85 c0                	test   %eax,%eax
80101dd8:	7e 0e                	jle    80101de8 <iunlock+0x38>
  releasesleep(&ip->lock);
80101dda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101ddd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101de0:	5b                   	pop    %ebx
80101de1:	5e                   	pop    %esi
80101de2:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101de3:	e9 78 3c 00 00       	jmp    80105a60 <releasesleep>
    panic("iunlock");
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	68 97 9e 10 80       	push   $0x80109e97
80101df0:	e8 9b e5 ff ff       	call   80100390 <panic>
80101df5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e00 <iput>:
{
80101e00:	f3 0f 1e fb          	endbr32 
80101e04:	55                   	push   %ebp
80101e05:	89 e5                	mov    %esp,%ebp
80101e07:	57                   	push   %edi
80101e08:	56                   	push   %esi
80101e09:	53                   	push   %ebx
80101e0a:	83 ec 28             	sub    $0x28,%esp
80101e0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101e10:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101e13:	57                   	push   %edi
80101e14:	e8 e7 3b 00 00       	call   80105a00 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101e19:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101e1c:	83 c4 10             	add    $0x10,%esp
80101e1f:	85 d2                	test   %edx,%edx
80101e21:	74 07                	je     80101e2a <iput+0x2a>
80101e23:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101e28:	74 36                	je     80101e60 <iput+0x60>
  releasesleep(&ip->lock);
80101e2a:	83 ec 0c             	sub    $0xc,%esp
80101e2d:	57                   	push   %edi
80101e2e:	e8 2d 3c 00 00       	call   80105a60 <releasesleep>
  acquire(&icache.lock);
80101e33:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80101e3a:	e8 61 3f 00 00       	call   80105da0 <acquire>
  ip->ref--;
80101e3f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101e43:	83 c4 10             	add    $0x10,%esp
80101e46:	c7 45 08 00 40 11 80 	movl   $0x80114000,0x8(%ebp)
}
80101e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
  release(&icache.lock);
80101e54:	e9 07 40 00 00       	jmp    80105e60 <release>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101e60:	83 ec 0c             	sub    $0xc,%esp
80101e63:	68 00 40 11 80       	push   $0x80114000
80101e68:	e8 33 3f 00 00       	call   80105da0 <acquire>
    int r = ip->ref;
80101e6d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101e70:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
80101e77:	e8 e4 3f 00 00       	call   80105e60 <release>
    if(r == 1){
80101e7c:	83 c4 10             	add    $0x10,%esp
80101e7f:	83 fe 01             	cmp    $0x1,%esi
80101e82:	75 a6                	jne    80101e2a <iput+0x2a>
80101e84:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101e8a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101e8d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101e90:	89 cf                	mov    %ecx,%edi
80101e92:	eb 0b                	jmp    80101e9f <iput+0x9f>
80101e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e98:	83 c6 04             	add    $0x4,%esi
80101e9b:	39 fe                	cmp    %edi,%esi
80101e9d:	74 19                	je     80101eb8 <iput+0xb8>
    if(ip->addrs[i]){
80101e9f:	8b 16                	mov    (%esi),%edx
80101ea1:	85 d2                	test   %edx,%edx
80101ea3:	74 f3                	je     80101e98 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101ea5:	8b 03                	mov    (%ebx),%eax
80101ea7:	e8 74 f8 ff ff       	call   80101720 <bfree>
      ip->addrs[i] = 0;
80101eac:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101eb2:	eb e4                	jmp    80101e98 <iput+0x98>
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101eb8:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101ebe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ec1:	85 c0                	test   %eax,%eax
80101ec3:	75 33                	jne    80101ef8 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101ec8:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101ecf:	53                   	push   %ebx
80101ed0:	e8 3b fd ff ff       	call   80101c10 <iupdate>
      ip->type = 0;
80101ed5:	31 c0                	xor    %eax,%eax
80101ed7:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101edb:	89 1c 24             	mov    %ebx,(%esp)
80101ede:	e8 2d fd ff ff       	call   80101c10 <iupdate>
      ip->valid = 0;
80101ee3:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101eea:	83 c4 10             	add    $0x10,%esp
80101eed:	e9 38 ff ff ff       	jmp    80101e2a <iput+0x2a>
80101ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101ef8:	83 ec 08             	sub    $0x8,%esp
80101efb:	50                   	push   %eax
80101efc:	ff 33                	pushl  (%ebx)
80101efe:	e8 cd e1 ff ff       	call   801000d0 <bread>
80101f03:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101f06:	83 c4 10             	add    $0x10,%esp
80101f09:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101f0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101f12:	8d 70 5c             	lea    0x5c(%eax),%esi
80101f15:	89 cf                	mov    %ecx,%edi
80101f17:	eb 0e                	jmp    80101f27 <iput+0x127>
80101f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f20:	83 c6 04             	add    $0x4,%esi
80101f23:	39 f7                	cmp    %esi,%edi
80101f25:	74 19                	je     80101f40 <iput+0x140>
      if(a[j])
80101f27:	8b 16                	mov    (%esi),%edx
80101f29:	85 d2                	test   %edx,%edx
80101f2b:	74 f3                	je     80101f20 <iput+0x120>
        bfree(ip->dev, a[j]);
80101f2d:	8b 03                	mov    (%ebx),%eax
80101f2f:	e8 ec f7 ff ff       	call   80101720 <bfree>
80101f34:	eb ea                	jmp    80101f20 <iput+0x120>
80101f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f3d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101f40:	83 ec 0c             	sub    $0xc,%esp
80101f43:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f46:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101f49:	e8 a2 e2 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101f4e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101f54:	8b 03                	mov    (%ebx),%eax
80101f56:	e8 c5 f7 ff ff       	call   80101720 <bfree>
    ip->addrs[NDIRECT] = 0;
80101f5b:	83 c4 10             	add    $0x10,%esp
80101f5e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101f65:	00 00 00 
80101f68:	e9 58 ff ff ff       	jmp    80101ec5 <iput+0xc5>
80101f6d:	8d 76 00             	lea    0x0(%esi),%esi

80101f70 <iunlockput>:
{
80101f70:	f3 0f 1e fb          	endbr32 
80101f74:	55                   	push   %ebp
80101f75:	89 e5                	mov    %esp,%ebp
80101f77:	53                   	push   %ebx
80101f78:	83 ec 10             	sub    $0x10,%esp
80101f7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101f7e:	53                   	push   %ebx
80101f7f:	e8 2c fe ff ff       	call   80101db0 <iunlock>
  iput(ip);
80101f84:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101f87:	83 c4 10             	add    $0x10,%esp
}
80101f8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f8d:	c9                   	leave  
  iput(ip);
80101f8e:	e9 6d fe ff ff       	jmp    80101e00 <iput>
80101f93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101fa0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101fa0:	f3 0f 1e fb          	endbr32 
80101fa4:	55                   	push   %ebp
80101fa5:	89 e5                	mov    %esp,%ebp
80101fa7:	8b 55 08             	mov    0x8(%ebp),%edx
80101faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101fad:	8b 0a                	mov    (%edx),%ecx
80101faf:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101fb2:	8b 4a 04             	mov    0x4(%edx),%ecx
80101fb5:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101fb8:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101fbc:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101fbf:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101fc3:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101fc7:	8b 52 58             	mov    0x58(%edx),%edx
80101fca:	89 50 10             	mov    %edx,0x10(%eax)
}
80101fcd:	5d                   	pop    %ebp
80101fce:	c3                   	ret    
80101fcf:	90                   	nop

80101fd0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101fd0:	f3 0f 1e fb          	endbr32 
80101fd4:	55                   	push   %ebp
80101fd5:	89 e5                	mov    %esp,%ebp
80101fd7:	57                   	push   %edi
80101fd8:	56                   	push   %esi
80101fd9:	53                   	push   %ebx
80101fda:	83 ec 1c             	sub    $0x1c,%esp
80101fdd:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101fe0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe3:	8b 75 10             	mov    0x10(%ebp),%esi
80101fe6:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101fe9:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fec:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ff1:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ff4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ff7:	0f 84 a3 00 00 00    	je     801020a0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ffd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102000:	8b 40 58             	mov    0x58(%eax),%eax
80102003:	39 c6                	cmp    %eax,%esi
80102005:	0f 87 b6 00 00 00    	ja     801020c1 <readi+0xf1>
8010200b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010200e:	31 c9                	xor    %ecx,%ecx
80102010:	89 da                	mov    %ebx,%edx
80102012:	01 f2                	add    %esi,%edx
80102014:	0f 92 c1             	setb   %cl
80102017:	89 cf                	mov    %ecx,%edi
80102019:	0f 82 a2 00 00 00    	jb     801020c1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010201f:	89 c1                	mov    %eax,%ecx
80102021:	29 f1                	sub    %esi,%ecx
80102023:	39 d0                	cmp    %edx,%eax
80102025:	0f 43 cb             	cmovae %ebx,%ecx
80102028:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010202b:	85 c9                	test   %ecx,%ecx
8010202d:	74 63                	je     80102092 <readi+0xc2>
8010202f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102030:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102033:	89 f2                	mov    %esi,%edx
80102035:	c1 ea 09             	shr    $0x9,%edx
80102038:	89 d8                	mov    %ebx,%eax
8010203a:	e8 61 f9 ff ff       	call   801019a0 <bmap>
8010203f:	83 ec 08             	sub    $0x8,%esp
80102042:	50                   	push   %eax
80102043:	ff 33                	pushl  (%ebx)
80102045:	e8 86 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010204a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010204d:	b9 00 02 00 00       	mov    $0x200,%ecx
80102052:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102055:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102057:	89 f0                	mov    %esi,%eax
80102059:	25 ff 01 00 00       	and    $0x1ff,%eax
8010205e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102060:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102063:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102065:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102069:	39 d9                	cmp    %ebx,%ecx
8010206b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010206e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010206f:	01 df                	add    %ebx,%edi
80102071:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102073:	50                   	push   %eax
80102074:	ff 75 e0             	pushl  -0x20(%ebp)
80102077:	e8 d4 3e 00 00       	call   80105f50 <memmove>
    brelse(bp);
8010207c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010207f:	89 14 24             	mov    %edx,(%esp)
80102082:	e8 69 e1 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102087:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010208a:	83 c4 10             	add    $0x10,%esp
8010208d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102090:	77 9e                	ja     80102030 <readi+0x60>
  }
  return n;
80102092:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102098:	5b                   	pop    %ebx
80102099:	5e                   	pop    %esi
8010209a:	5f                   	pop    %edi
8010209b:	5d                   	pop    %ebp
8010209c:	c3                   	ret    
8010209d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801020a0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801020a4:	66 83 f8 09          	cmp    $0x9,%ax
801020a8:	77 17                	ja     801020c1 <readi+0xf1>
801020aa:	8b 04 c5 80 3f 11 80 	mov    -0x7feec080(,%eax,8),%eax
801020b1:	85 c0                	test   %eax,%eax
801020b3:	74 0c                	je     801020c1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801020b5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801020b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020bb:	5b                   	pop    %ebx
801020bc:	5e                   	pop    %esi
801020bd:	5f                   	pop    %edi
801020be:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801020bf:	ff e0                	jmp    *%eax
      return -1;
801020c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020c6:	eb cd                	jmp    80102095 <readi+0xc5>
801020c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020cf:	90                   	nop

801020d0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801020d0:	f3 0f 1e fb          	endbr32 
801020d4:	55                   	push   %ebp
801020d5:	89 e5                	mov    %esp,%ebp
801020d7:	57                   	push   %edi
801020d8:	56                   	push   %esi
801020d9:	53                   	push   %ebx
801020da:	83 ec 1c             	sub    $0x1c,%esp
801020dd:	8b 45 08             	mov    0x8(%ebp),%eax
801020e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801020e3:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801020e6:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801020eb:	89 75 dc             	mov    %esi,-0x24(%ebp)
801020ee:	89 45 d8             	mov    %eax,-0x28(%ebp)
801020f1:	8b 75 10             	mov    0x10(%ebp),%esi
801020f4:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
801020f7:	0f 84 b3 00 00 00    	je     801021b0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801020fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102100:	39 70 58             	cmp    %esi,0x58(%eax)
80102103:	0f 82 e3 00 00 00    	jb     801021ec <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102109:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010210c:	89 f8                	mov    %edi,%eax
8010210e:	01 f0                	add    %esi,%eax
80102110:	0f 82 d6 00 00 00    	jb     801021ec <writei+0x11c>
80102116:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010211b:	0f 87 cb 00 00 00    	ja     801021ec <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102121:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102128:	85 ff                	test   %edi,%edi
8010212a:	74 75                	je     801021a1 <writei+0xd1>
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102130:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102133:	89 f2                	mov    %esi,%edx
80102135:	c1 ea 09             	shr    $0x9,%edx
80102138:	89 f8                	mov    %edi,%eax
8010213a:	e8 61 f8 ff ff       	call   801019a0 <bmap>
8010213f:	83 ec 08             	sub    $0x8,%esp
80102142:	50                   	push   %eax
80102143:	ff 37                	pushl  (%edi)
80102145:	e8 86 df ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010214a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010214f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102152:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102155:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102157:	89 f0                	mov    %esi,%eax
80102159:	83 c4 0c             	add    $0xc,%esp
8010215c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102161:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102163:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102167:	39 d9                	cmp    %ebx,%ecx
80102169:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010216c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010216d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
8010216f:	ff 75 dc             	pushl  -0x24(%ebp)
80102172:	50                   	push   %eax
80102173:	e8 d8 3d 00 00       	call   80105f50 <memmove>
    log_write(bp);
80102178:	89 3c 24             	mov    %edi,(%esp)
8010217b:	e8 00 13 00 00       	call   80103480 <log_write>
    brelse(bp);
80102180:	89 3c 24             	mov    %edi,(%esp)
80102183:	e8 68 e0 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102188:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010218b:	83 c4 10             	add    $0x10,%esp
8010218e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102191:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102194:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102197:	77 97                	ja     80102130 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102199:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010219c:	3b 70 58             	cmp    0x58(%eax),%esi
8010219f:	77 37                	ja     801021d8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801021a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801021a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021a7:	5b                   	pop    %ebx
801021a8:	5e                   	pop    %esi
801021a9:	5f                   	pop    %edi
801021aa:	5d                   	pop    %ebp
801021ab:	c3                   	ret    
801021ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801021b0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801021b4:	66 83 f8 09          	cmp    $0x9,%ax
801021b8:	77 32                	ja     801021ec <writei+0x11c>
801021ba:	8b 04 c5 84 3f 11 80 	mov    -0x7feec07c(,%eax,8),%eax
801021c1:	85 c0                	test   %eax,%eax
801021c3:	74 27                	je     801021ec <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
801021c5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801021c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021cb:	5b                   	pop    %ebx
801021cc:	5e                   	pop    %esi
801021cd:	5f                   	pop    %edi
801021ce:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801021cf:	ff e0                	jmp    *%eax
801021d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801021d8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801021db:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801021de:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
801021e1:	50                   	push   %eax
801021e2:	e8 29 fa ff ff       	call   80101c10 <iupdate>
801021e7:	83 c4 10             	add    $0x10,%esp
801021ea:	eb b5                	jmp    801021a1 <writei+0xd1>
      return -1;
801021ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021f1:	eb b1                	jmp    801021a4 <writei+0xd4>
801021f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102200 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102200:	f3 0f 1e fb          	endbr32 
80102204:	55                   	push   %ebp
80102205:	89 e5                	mov    %esp,%ebp
80102207:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010220a:	6a 0e                	push   $0xe
8010220c:	ff 75 0c             	pushl  0xc(%ebp)
8010220f:	ff 75 08             	pushl  0x8(%ebp)
80102212:	e8 a9 3d 00 00       	call   80105fc0 <strncmp>
}
80102217:	c9                   	leave  
80102218:	c3                   	ret    
80102219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102220 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102220:	f3 0f 1e fb          	endbr32 
80102224:	55                   	push   %ebp
80102225:	89 e5                	mov    %esp,%ebp
80102227:	57                   	push   %edi
80102228:	56                   	push   %esi
80102229:	53                   	push   %ebx
8010222a:	83 ec 1c             	sub    $0x1c,%esp
8010222d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102230:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102235:	0f 85 89 00 00 00    	jne    801022c4 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010223b:	8b 53 58             	mov    0x58(%ebx),%edx
8010223e:	31 ff                	xor    %edi,%edi
80102240:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102243:	85 d2                	test   %edx,%edx
80102245:	74 42                	je     80102289 <dirlookup+0x69>
80102247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010224e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102250:	6a 10                	push   $0x10
80102252:	57                   	push   %edi
80102253:	56                   	push   %esi
80102254:	53                   	push   %ebx
80102255:	e8 76 fd ff ff       	call   80101fd0 <readi>
8010225a:	83 c4 10             	add    $0x10,%esp
8010225d:	83 f8 10             	cmp    $0x10,%eax
80102260:	75 55                	jne    801022b7 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80102262:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102267:	74 18                	je     80102281 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80102269:	83 ec 04             	sub    $0x4,%esp
8010226c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010226f:	6a 0e                	push   $0xe
80102271:	50                   	push   %eax
80102272:	ff 75 0c             	pushl  0xc(%ebp)
80102275:	e8 46 3d 00 00       	call   80105fc0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
8010227a:	83 c4 10             	add    $0x10,%esp
8010227d:	85 c0                	test   %eax,%eax
8010227f:	74 17                	je     80102298 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102281:	83 c7 10             	add    $0x10,%edi
80102284:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102287:	72 c7                	jb     80102250 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102289:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010228c:	31 c0                	xor    %eax,%eax
}
8010228e:	5b                   	pop    %ebx
8010228f:	5e                   	pop    %esi
80102290:	5f                   	pop    %edi
80102291:	5d                   	pop    %ebp
80102292:	c3                   	ret    
80102293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102297:	90                   	nop
      if(poff)
80102298:	8b 45 10             	mov    0x10(%ebp),%eax
8010229b:	85 c0                	test   %eax,%eax
8010229d:	74 05                	je     801022a4 <dirlookup+0x84>
        *poff = off;
8010229f:	8b 45 10             	mov    0x10(%ebp),%eax
801022a2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801022a4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801022a8:	8b 03                	mov    (%ebx),%eax
801022aa:	e8 01 f6 ff ff       	call   801018b0 <iget>
}
801022af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b2:	5b                   	pop    %ebx
801022b3:	5e                   	pop    %esi
801022b4:	5f                   	pop    %edi
801022b5:	5d                   	pop    %ebp
801022b6:	c3                   	ret    
      panic("dirlookup read");
801022b7:	83 ec 0c             	sub    $0xc,%esp
801022ba:	68 b1 9e 10 80       	push   $0x80109eb1
801022bf:	e8 cc e0 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
801022c4:	83 ec 0c             	sub    $0xc,%esp
801022c7:	68 9f 9e 10 80       	push   $0x80109e9f
801022cc:	e8 bf e0 ff ff       	call   80100390 <panic>
801022d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop

801022e0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	57                   	push   %edi
801022e4:	56                   	push   %esi
801022e5:	53                   	push   %ebx
801022e6:	89 c3                	mov    %eax,%ebx
801022e8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801022eb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801022ee:	89 55 e0             	mov    %edx,-0x20(%ebp)
801022f1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801022f4:	0f 84 86 01 00 00    	je     80102480 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801022fa:	e8 71 1c 00 00       	call   80103f70 <myproc>
  acquire(&icache.lock);
801022ff:	83 ec 0c             	sub    $0xc,%esp
80102302:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102304:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102307:	68 00 40 11 80       	push   $0x80114000
8010230c:	e8 8f 3a 00 00       	call   80105da0 <acquire>
  ip->ref++;
80102311:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102315:	c7 04 24 00 40 11 80 	movl   $0x80114000,(%esp)
8010231c:	e8 3f 3b 00 00       	call   80105e60 <release>
80102321:	83 c4 10             	add    $0x10,%esp
80102324:	eb 0d                	jmp    80102333 <namex+0x53>
80102326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010232d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80102330:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80102333:	0f b6 07             	movzbl (%edi),%eax
80102336:	3c 2f                	cmp    $0x2f,%al
80102338:	74 f6                	je     80102330 <namex+0x50>
  if(*path == 0)
8010233a:	84 c0                	test   %al,%al
8010233c:	0f 84 ee 00 00 00    	je     80102430 <namex+0x150>
  while(*path != '/' && *path != 0)
80102342:	0f b6 07             	movzbl (%edi),%eax
80102345:	84 c0                	test   %al,%al
80102347:	0f 84 fb 00 00 00    	je     80102448 <namex+0x168>
8010234d:	89 fb                	mov    %edi,%ebx
8010234f:	3c 2f                	cmp    $0x2f,%al
80102351:	0f 84 f1 00 00 00    	je     80102448 <namex+0x168>
80102357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010235e:	66 90                	xchg   %ax,%ax
80102360:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80102364:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80102367:	3c 2f                	cmp    $0x2f,%al
80102369:	74 04                	je     8010236f <namex+0x8f>
8010236b:	84 c0                	test   %al,%al
8010236d:	75 f1                	jne    80102360 <namex+0x80>
  len = path - s;
8010236f:	89 d8                	mov    %ebx,%eax
80102371:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80102373:	83 f8 0d             	cmp    $0xd,%eax
80102376:	0f 8e 84 00 00 00    	jle    80102400 <namex+0x120>
    memmove(name, s, DIRSIZ);
8010237c:	83 ec 04             	sub    $0x4,%esp
8010237f:	6a 0e                	push   $0xe
80102381:	57                   	push   %edi
    path++;
80102382:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80102384:	ff 75 e4             	pushl  -0x1c(%ebp)
80102387:	e8 c4 3b 00 00       	call   80105f50 <memmove>
8010238c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010238f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102392:	75 0c                	jne    801023a0 <namex+0xc0>
80102394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102398:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
8010239b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010239e:	74 f8                	je     80102398 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	56                   	push   %esi
801023a4:	e8 27 f9 ff ff       	call   80101cd0 <ilock>
    if(ip->type != T_DIR){
801023a9:	83 c4 10             	add    $0x10,%esp
801023ac:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801023b1:	0f 85 a1 00 00 00    	jne    80102458 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801023b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801023ba:	85 d2                	test   %edx,%edx
801023bc:	74 09                	je     801023c7 <namex+0xe7>
801023be:	80 3f 00             	cmpb   $0x0,(%edi)
801023c1:	0f 84 d9 00 00 00    	je     801024a0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801023c7:	83 ec 04             	sub    $0x4,%esp
801023ca:	6a 00                	push   $0x0
801023cc:	ff 75 e4             	pushl  -0x1c(%ebp)
801023cf:	56                   	push   %esi
801023d0:	e8 4b fe ff ff       	call   80102220 <dirlookup>
801023d5:	83 c4 10             	add    $0x10,%esp
801023d8:	89 c3                	mov    %eax,%ebx
801023da:	85 c0                	test   %eax,%eax
801023dc:	74 7a                	je     80102458 <namex+0x178>
  iunlock(ip);
801023de:	83 ec 0c             	sub    $0xc,%esp
801023e1:	56                   	push   %esi
801023e2:	e8 c9 f9 ff ff       	call   80101db0 <iunlock>
  iput(ip);
801023e7:	89 34 24             	mov    %esi,(%esp)
801023ea:	89 de                	mov    %ebx,%esi
801023ec:	e8 0f fa ff ff       	call   80101e00 <iput>
801023f1:	83 c4 10             	add    $0x10,%esp
801023f4:	e9 3a ff ff ff       	jmp    80102333 <namex+0x53>
801023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102400:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102403:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102406:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102409:	83 ec 04             	sub    $0x4,%esp
8010240c:	50                   	push   %eax
8010240d:	57                   	push   %edi
    name[len] = 0;
8010240e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102410:	ff 75 e4             	pushl  -0x1c(%ebp)
80102413:	e8 38 3b 00 00       	call   80105f50 <memmove>
    name[len] = 0;
80102418:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010241b:	83 c4 10             	add    $0x10,%esp
8010241e:	c6 00 00             	movb   $0x0,(%eax)
80102421:	e9 69 ff ff ff       	jmp    8010238f <namex+0xaf>
80102426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010242d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102430:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102433:	85 c0                	test   %eax,%eax
80102435:	0f 85 85 00 00 00    	jne    801024c0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010243b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010243e:	89 f0                	mov    %esi,%eax
80102440:	5b                   	pop    %ebx
80102441:	5e                   	pop    %esi
80102442:	5f                   	pop    %edi
80102443:	5d                   	pop    %ebp
80102444:	c3                   	ret    
80102445:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010244b:	89 fb                	mov    %edi,%ebx
8010244d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102450:	31 c0                	xor    %eax,%eax
80102452:	eb b5                	jmp    80102409 <namex+0x129>
80102454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102458:	83 ec 0c             	sub    $0xc,%esp
8010245b:	56                   	push   %esi
8010245c:	e8 4f f9 ff ff       	call   80101db0 <iunlock>
  iput(ip);
80102461:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102464:	31 f6                	xor    %esi,%esi
  iput(ip);
80102466:	e8 95 f9 ff ff       	call   80101e00 <iput>
      return 0;
8010246b:	83 c4 10             	add    $0x10,%esp
}
8010246e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102471:	89 f0                	mov    %esi,%eax
80102473:	5b                   	pop    %ebx
80102474:	5e                   	pop    %esi
80102475:	5f                   	pop    %edi
80102476:	5d                   	pop    %ebp
80102477:	c3                   	ret    
80102478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80102480:	ba 01 00 00 00       	mov    $0x1,%edx
80102485:	b8 01 00 00 00       	mov    $0x1,%eax
8010248a:	89 df                	mov    %ebx,%edi
8010248c:	e8 1f f4 ff ff       	call   801018b0 <iget>
80102491:	89 c6                	mov    %eax,%esi
80102493:	e9 9b fe ff ff       	jmp    80102333 <namex+0x53>
80102498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010249f:	90                   	nop
      iunlock(ip);
801024a0:	83 ec 0c             	sub    $0xc,%esp
801024a3:	56                   	push   %esi
801024a4:	e8 07 f9 ff ff       	call   80101db0 <iunlock>
      return ip;
801024a9:	83 c4 10             	add    $0x10,%esp
}
801024ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024af:	89 f0                	mov    %esi,%eax
801024b1:	5b                   	pop    %ebx
801024b2:	5e                   	pop    %esi
801024b3:	5f                   	pop    %edi
801024b4:	5d                   	pop    %ebp
801024b5:	c3                   	ret    
801024b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024bd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
801024c0:	83 ec 0c             	sub    $0xc,%esp
801024c3:	56                   	push   %esi
    return 0;
801024c4:	31 f6                	xor    %esi,%esi
    iput(ip);
801024c6:	e8 35 f9 ff ff       	call   80101e00 <iput>
    return 0;
801024cb:	83 c4 10             	add    $0x10,%esp
801024ce:	e9 68 ff ff ff       	jmp    8010243b <namex+0x15b>
801024d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801024e0 <dirlink>:
{
801024e0:	f3 0f 1e fb          	endbr32 
801024e4:	55                   	push   %ebp
801024e5:	89 e5                	mov    %esp,%ebp
801024e7:	57                   	push   %edi
801024e8:	56                   	push   %esi
801024e9:	53                   	push   %ebx
801024ea:	83 ec 20             	sub    $0x20,%esp
801024ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801024f0:	6a 00                	push   $0x0
801024f2:	ff 75 0c             	pushl  0xc(%ebp)
801024f5:	53                   	push   %ebx
801024f6:	e8 25 fd ff ff       	call   80102220 <dirlookup>
801024fb:	83 c4 10             	add    $0x10,%esp
801024fe:	85 c0                	test   %eax,%eax
80102500:	75 6b                	jne    8010256d <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102502:	8b 7b 58             	mov    0x58(%ebx),%edi
80102505:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102508:	85 ff                	test   %edi,%edi
8010250a:	74 2d                	je     80102539 <dirlink+0x59>
8010250c:	31 ff                	xor    %edi,%edi
8010250e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102511:	eb 0d                	jmp    80102520 <dirlink+0x40>
80102513:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102517:	90                   	nop
80102518:	83 c7 10             	add    $0x10,%edi
8010251b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010251e:	73 19                	jae    80102539 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102520:	6a 10                	push   $0x10
80102522:	57                   	push   %edi
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
80102525:	e8 a6 fa ff ff       	call   80101fd0 <readi>
8010252a:	83 c4 10             	add    $0x10,%esp
8010252d:	83 f8 10             	cmp    $0x10,%eax
80102530:	75 4e                	jne    80102580 <dirlink+0xa0>
    if(de.inum == 0)
80102532:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102537:	75 df                	jne    80102518 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102539:	83 ec 04             	sub    $0x4,%esp
8010253c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010253f:	6a 0e                	push   $0xe
80102541:	ff 75 0c             	pushl  0xc(%ebp)
80102544:	50                   	push   %eax
80102545:	e8 c6 3a 00 00       	call   80106010 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010254a:	6a 10                	push   $0x10
  de.inum = inum;
8010254c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010254f:	57                   	push   %edi
80102550:	56                   	push   %esi
80102551:	53                   	push   %ebx
  de.inum = inum;
80102552:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102556:	e8 75 fb ff ff       	call   801020d0 <writei>
8010255b:	83 c4 20             	add    $0x20,%esp
8010255e:	83 f8 10             	cmp    $0x10,%eax
80102561:	75 2a                	jne    8010258d <dirlink+0xad>
  return 0;
80102563:	31 c0                	xor    %eax,%eax
}
80102565:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102568:	5b                   	pop    %ebx
80102569:	5e                   	pop    %esi
8010256a:	5f                   	pop    %edi
8010256b:	5d                   	pop    %ebp
8010256c:	c3                   	ret    
    iput(ip);
8010256d:	83 ec 0c             	sub    $0xc,%esp
80102570:	50                   	push   %eax
80102571:	e8 8a f8 ff ff       	call   80101e00 <iput>
    return -1;
80102576:	83 c4 10             	add    $0x10,%esp
80102579:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010257e:	eb e5                	jmp    80102565 <dirlink+0x85>
      panic("dirlink read");
80102580:	83 ec 0c             	sub    $0xc,%esp
80102583:	68 c0 9e 10 80       	push   $0x80109ec0
80102588:	e8 03 de ff ff       	call   80100390 <panic>
    panic("dirlink");
8010258d:	83 ec 0c             	sub    $0xc,%esp
80102590:	68 f6 a6 10 80       	push   $0x8010a6f6
80102595:	e8 f6 dd ff ff       	call   80100390 <panic>
8010259a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801025a0 <namei>:

struct inode*
namei(char *path)
{
801025a0:	f3 0f 1e fb          	endbr32 
801025a4:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801025a5:	31 d2                	xor    %edx,%edx
{
801025a7:	89 e5                	mov    %esp,%ebp
801025a9:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801025ac:	8b 45 08             	mov    0x8(%ebp),%eax
801025af:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801025b2:	e8 29 fd ff ff       	call   801022e0 <namex>
}
801025b7:	c9                   	leave  
801025b8:	c3                   	ret    
801025b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801025c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801025c0:	f3 0f 1e fb          	endbr32 
801025c4:	55                   	push   %ebp
  return namex(path, 1, name);
801025c5:	ba 01 00 00 00       	mov    $0x1,%edx
{
801025ca:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801025cc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
801025d2:	5d                   	pop    %ebp
  return namex(path, 1, name);
801025d3:	e9 08 fd ff ff       	jmp    801022e0 <namex>
801025d8:	66 90                	xchg   %ax,%ax
801025da:	66 90                	xchg   %ax,%ax
801025dc:	66 90                	xchg   %ax,%ax
801025de:	66 90                	xchg   %ax,%ax

801025e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	57                   	push   %edi
801025e4:	56                   	push   %esi
801025e5:	53                   	push   %ebx
801025e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801025e9:	85 c0                	test   %eax,%eax
801025eb:	0f 84 b4 00 00 00    	je     801026a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801025f1:	8b 70 08             	mov    0x8(%eax),%esi
801025f4:	89 c3                	mov    %eax,%ebx
801025f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801025fc:	0f 87 96 00 00 00    	ja     80102698 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102602:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260e:	66 90                	xchg   %ax,%ax
80102610:	89 ca                	mov    %ecx,%edx
80102612:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102613:	83 e0 c0             	and    $0xffffffc0,%eax
80102616:	3c 40                	cmp    $0x40,%al
80102618:	75 f6                	jne    80102610 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010261a:	31 ff                	xor    %edi,%edi
8010261c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102621:	89 f8                	mov    %edi,%eax
80102623:	ee                   	out    %al,(%dx)
80102624:	b8 01 00 00 00       	mov    $0x1,%eax
80102629:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010262e:	ee                   	out    %al,(%dx)
8010262f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102634:	89 f0                	mov    %esi,%eax
80102636:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102637:	89 f0                	mov    %esi,%eax
80102639:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010263e:	c1 f8 08             	sar    $0x8,%eax
80102641:	ee                   	out    %al,(%dx)
80102642:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102647:	89 f8                	mov    %edi,%eax
80102649:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010264a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010264e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102653:	c1 e0 04             	shl    $0x4,%eax
80102656:	83 e0 10             	and    $0x10,%eax
80102659:	83 c8 e0             	or     $0xffffffe0,%eax
8010265c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010265d:	f6 03 04             	testb  $0x4,(%ebx)
80102660:	75 16                	jne    80102678 <idestart+0x98>
80102662:	b8 20 00 00 00       	mov    $0x20,%eax
80102667:	89 ca                	mov    %ecx,%edx
80102669:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010266a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010266d:	5b                   	pop    %ebx
8010266e:	5e                   	pop    %esi
8010266f:	5f                   	pop    %edi
80102670:	5d                   	pop    %ebp
80102671:	c3                   	ret    
80102672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102678:	b8 30 00 00 00       	mov    $0x30,%eax
8010267d:	89 ca                	mov    %ecx,%edx
8010267f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102680:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102685:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102688:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010268d:	fc                   	cld    
8010268e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102690:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102693:	5b                   	pop    %ebx
80102694:	5e                   	pop    %esi
80102695:	5f                   	pop    %edi
80102696:	5d                   	pop    %ebp
80102697:	c3                   	ret    
    panic("incorrect blockno");
80102698:	83 ec 0c             	sub    $0xc,%esp
8010269b:	68 2c 9f 10 80       	push   $0x80109f2c
801026a0:	e8 eb dc ff ff       	call   80100390 <panic>
    panic("idestart");
801026a5:	83 ec 0c             	sub    $0xc,%esp
801026a8:	68 23 9f 10 80       	push   $0x80109f23
801026ad:	e8 de dc ff ff       	call   80100390 <panic>
801026b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801026c0 <ideinit>:
{
801026c0:	f3 0f 1e fb          	endbr32 
801026c4:	55                   	push   %ebp
801026c5:	89 e5                	mov    %esp,%ebp
801026c7:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801026ca:	68 3e 9f 10 80       	push   $0x80109f3e
801026cf:	68 80 d5 10 80       	push   $0x8010d580
801026d4:	e8 47 35 00 00       	call   80105c20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801026d9:	58                   	pop    %eax
801026da:	a1 40 63 11 80       	mov    0x80116340,%eax
801026df:	5a                   	pop    %edx
801026e0:	83 e8 01             	sub    $0x1,%eax
801026e3:	50                   	push   %eax
801026e4:	6a 0e                	push   $0xe
801026e6:	e8 b5 02 00 00       	call   801029a0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801026eb:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ee:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026f7:	90                   	nop
801026f8:	ec                   	in     (%dx),%al
801026f9:	83 e0 c0             	and    $0xffffffc0,%eax
801026fc:	3c 40                	cmp    $0x40,%al
801026fe:	75 f8                	jne    801026f8 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102700:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102705:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010270a:	ee                   	out    %al,(%dx)
8010270b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102710:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102715:	eb 0e                	jmp    80102725 <ideinit+0x65>
80102717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010271e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102720:	83 e9 01             	sub    $0x1,%ecx
80102723:	74 0f                	je     80102734 <ideinit+0x74>
80102725:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102726:	84 c0                	test   %al,%al
80102728:	74 f6                	je     80102720 <ideinit+0x60>
      havedisk1 = 1;
8010272a:	c7 05 60 d5 10 80 01 	movl   $0x1,0x8010d560
80102731:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102734:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102739:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010273e:	ee                   	out    %al,(%dx)
}
8010273f:	c9                   	leave  
80102740:	c3                   	ret    
80102741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010274f:	90                   	nop

80102750 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102750:	f3 0f 1e fb          	endbr32 
80102754:	55                   	push   %ebp
80102755:	89 e5                	mov    %esp,%ebp
80102757:	57                   	push   %edi
80102758:	56                   	push   %esi
80102759:	53                   	push   %ebx
8010275a:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010275d:	68 80 d5 10 80       	push   $0x8010d580
80102762:	e8 39 36 00 00       	call   80105da0 <acquire>

  if((b = idequeue) == 0){
80102767:	8b 1d 64 d5 10 80    	mov    0x8010d564,%ebx
8010276d:	83 c4 10             	add    $0x10,%esp
80102770:	85 db                	test   %ebx,%ebx
80102772:	74 5f                	je     801027d3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102774:	8b 43 58             	mov    0x58(%ebx),%eax
80102777:	a3 64 d5 10 80       	mov    %eax,0x8010d564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010277c:	8b 33                	mov    (%ebx),%esi
8010277e:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102784:	75 2b                	jne    801027b1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102786:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010278b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010278f:	90                   	nop
80102790:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102791:	89 c1                	mov    %eax,%ecx
80102793:	83 e1 c0             	and    $0xffffffc0,%ecx
80102796:	80 f9 40             	cmp    $0x40,%cl
80102799:	75 f5                	jne    80102790 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010279b:	a8 21                	test   $0x21,%al
8010279d:	75 12                	jne    801027b1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010279f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801027a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801027a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801027ac:	fc                   	cld    
801027ad:	f3 6d                	rep insl (%dx),%es:(%edi)
801027af:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801027b1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801027b4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801027b7:	83 ce 02             	or     $0x2,%esi
801027ba:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801027bc:	53                   	push   %ebx
801027bd:	e8 7e 1f 00 00       	call   80104740 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801027c2:	a1 64 d5 10 80       	mov    0x8010d564,%eax
801027c7:	83 c4 10             	add    $0x10,%esp
801027ca:	85 c0                	test   %eax,%eax
801027cc:	74 05                	je     801027d3 <ideintr+0x83>
    idestart(idequeue);
801027ce:	e8 0d fe ff ff       	call   801025e0 <idestart>
    release(&idelock);
801027d3:	83 ec 0c             	sub    $0xc,%esp
801027d6:	68 80 d5 10 80       	push   $0x8010d580
801027db:	e8 80 36 00 00       	call   80105e60 <release>

  release(&idelock);
}
801027e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027e3:	5b                   	pop    %ebx
801027e4:	5e                   	pop    %esi
801027e5:	5f                   	pop    %edi
801027e6:	5d                   	pop    %ebp
801027e7:	c3                   	ret    
801027e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ef:	90                   	nop

801027f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801027f0:	f3 0f 1e fb          	endbr32 
801027f4:	55                   	push   %ebp
801027f5:	89 e5                	mov    %esp,%ebp
801027f7:	53                   	push   %ebx
801027f8:	83 ec 10             	sub    $0x10,%esp
801027fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801027fe:	8d 43 0c             	lea    0xc(%ebx),%eax
80102801:	50                   	push   %eax
80102802:	e8 99 32 00 00       	call   80105aa0 <holdingsleep>
80102807:	83 c4 10             	add    $0x10,%esp
8010280a:	85 c0                	test   %eax,%eax
8010280c:	0f 84 cf 00 00 00    	je     801028e1 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102812:	8b 03                	mov    (%ebx),%eax
80102814:	83 e0 06             	and    $0x6,%eax
80102817:	83 f8 02             	cmp    $0x2,%eax
8010281a:	0f 84 b4 00 00 00    	je     801028d4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102820:	8b 53 04             	mov    0x4(%ebx),%edx
80102823:	85 d2                	test   %edx,%edx
80102825:	74 0d                	je     80102834 <iderw+0x44>
80102827:	a1 60 d5 10 80       	mov    0x8010d560,%eax
8010282c:	85 c0                	test   %eax,%eax
8010282e:	0f 84 93 00 00 00    	je     801028c7 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102834:	83 ec 0c             	sub    $0xc,%esp
80102837:	68 80 d5 10 80       	push   $0x8010d580
8010283c:	e8 5f 35 00 00       	call   80105da0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102841:	a1 64 d5 10 80       	mov    0x8010d564,%eax
  b->qnext = 0;
80102846:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010284d:	83 c4 10             	add    $0x10,%esp
80102850:	85 c0                	test   %eax,%eax
80102852:	74 6c                	je     801028c0 <iderw+0xd0>
80102854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102858:	89 c2                	mov    %eax,%edx
8010285a:	8b 40 58             	mov    0x58(%eax),%eax
8010285d:	85 c0                	test   %eax,%eax
8010285f:	75 f7                	jne    80102858 <iderw+0x68>
80102861:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102864:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102866:	39 1d 64 d5 10 80    	cmp    %ebx,0x8010d564
8010286c:	74 42                	je     801028b0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010286e:	8b 03                	mov    (%ebx),%eax
80102870:	83 e0 06             	and    $0x6,%eax
80102873:	83 f8 02             	cmp    $0x2,%eax
80102876:	74 23                	je     8010289b <iderw+0xab>
80102878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010287f:	90                   	nop
    sleep(b, &idelock);
80102880:	83 ec 08             	sub    $0x8,%esp
80102883:	68 80 d5 10 80       	push   $0x8010d580
80102888:	53                   	push   %ebx
80102889:	e8 f2 1c 00 00       	call   80104580 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010288e:	8b 03                	mov    (%ebx),%eax
80102890:	83 c4 10             	add    $0x10,%esp
80102893:	83 e0 06             	and    $0x6,%eax
80102896:	83 f8 02             	cmp    $0x2,%eax
80102899:	75 e5                	jne    80102880 <iderw+0x90>
  }


  release(&idelock);
8010289b:	c7 45 08 80 d5 10 80 	movl   $0x8010d580,0x8(%ebp)
}
801028a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028a5:	c9                   	leave  
  release(&idelock);
801028a6:	e9 b5 35 00 00       	jmp    80105e60 <release>
801028ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028af:	90                   	nop
    idestart(b);
801028b0:	89 d8                	mov    %ebx,%eax
801028b2:	e8 29 fd ff ff       	call   801025e0 <idestart>
801028b7:	eb b5                	jmp    8010286e <iderw+0x7e>
801028b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028c0:	ba 64 d5 10 80       	mov    $0x8010d564,%edx
801028c5:	eb 9d                	jmp    80102864 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
801028c7:	83 ec 0c             	sub    $0xc,%esp
801028ca:	68 6d 9f 10 80       	push   $0x80109f6d
801028cf:	e8 bc da ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
801028d4:	83 ec 0c             	sub    $0xc,%esp
801028d7:	68 58 9f 10 80       	push   $0x80109f58
801028dc:	e8 af da ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801028e1:	83 ec 0c             	sub    $0xc,%esp
801028e4:	68 42 9f 10 80       	push   $0x80109f42
801028e9:	e8 a2 da ff ff       	call   80100390 <panic>
801028ee:	66 90                	xchg   %ax,%ax

801028f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801028f0:	f3 0f 1e fb          	endbr32 
801028f4:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801028f5:	c7 05 54 5c 11 80 00 	movl   $0xfec00000,0x80115c54
801028fc:	00 c0 fe 
{
801028ff:	89 e5                	mov    %esp,%ebp
80102901:	56                   	push   %esi
80102902:	53                   	push   %ebx
  ioapic->reg = reg;
80102903:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010290a:	00 00 00 
  return ioapic->data;
8010290d:	8b 15 54 5c 11 80    	mov    0x80115c54,%edx
80102913:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102916:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010291c:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102922:	0f b6 15 80 5d 11 80 	movzbl 0x80115d80,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102929:	c1 ee 10             	shr    $0x10,%esi
8010292c:	89 f0                	mov    %esi,%eax
8010292e:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102931:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102934:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102937:	39 c2                	cmp    %eax,%edx
80102939:	74 16                	je     80102951 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010293b:	83 ec 0c             	sub    $0xc,%esp
8010293e:	68 8c 9f 10 80       	push   $0x80109f8c
80102943:	e8 78 df ff ff       	call   801008c0 <cprintf>
80102948:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
8010294e:	83 c4 10             	add    $0x10,%esp
80102951:	83 c6 21             	add    $0x21,%esi
{
80102954:	ba 10 00 00 00       	mov    $0x10,%edx
80102959:	b8 20 00 00 00       	mov    $0x20,%eax
8010295e:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102960:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102962:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102964:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
8010296a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010296d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102973:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102976:	8d 5a 01             	lea    0x1(%edx),%ebx
80102979:	83 c2 02             	add    $0x2,%edx
8010297c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010297e:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
80102984:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010298b:	39 f0                	cmp    %esi,%eax
8010298d:	75 d1                	jne    80102960 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010298f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102992:	5b                   	pop    %ebx
80102993:	5e                   	pop    %esi
80102994:	5d                   	pop    %ebp
80102995:	c3                   	ret    
80102996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010299d:	8d 76 00             	lea    0x0(%esi),%esi

801029a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801029a0:	f3 0f 1e fb          	endbr32 
801029a4:	55                   	push   %ebp
  ioapic->reg = reg;
801029a5:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
{
801029ab:	89 e5                	mov    %esp,%ebp
801029ad:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801029b0:	8d 50 20             	lea    0x20(%eax),%edx
801029b3:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801029b7:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801029b9:	8b 0d 54 5c 11 80    	mov    0x80115c54,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801029bf:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801029c2:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801029c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801029c8:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801029ca:	a1 54 5c 11 80       	mov    0x80115c54,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801029cf:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801029d2:	89 50 10             	mov    %edx,0x10(%eax)
}
801029d5:	5d                   	pop    %ebp
801029d6:	c3                   	ret    
801029d7:	66 90                	xchg   %ax,%ax
801029d9:	66 90                	xchg   %ax,%ax
801029db:	66 90                	xchg   %ax,%ax
801029dd:	66 90                	xchg   %ax,%ax
801029df:	90                   	nop

801029e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801029e0:	f3 0f 1e fb          	endbr32 
801029e4:	55                   	push   %ebp
801029e5:	89 e5                	mov    %esp,%ebp
801029e7:	53                   	push   %ebx
801029e8:	83 ec 04             	sub    $0x4,%esp
801029eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801029ee:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801029f4:	75 7a                	jne    80102a70 <kfree+0x90>
801029f6:	81 fb 54 21 13 80    	cmp    $0x80132154,%ebx
801029fc:	72 72                	jb     80102a70 <kfree+0x90>
801029fe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102a04:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a09:	77 65                	ja     80102a70 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102a0b:	83 ec 04             	sub    $0x4,%esp
80102a0e:	68 00 10 00 00       	push   $0x1000
80102a13:	6a 01                	push   $0x1
80102a15:	53                   	push   %ebx
80102a16:	e8 95 34 00 00       	call   80105eb0 <memset>

  if(kmem.use_lock)
80102a1b:	8b 15 94 5c 11 80    	mov    0x80115c94,%edx
80102a21:	83 c4 10             	add    $0x10,%esp
80102a24:	85 d2                	test   %edx,%edx
80102a26:	75 20                	jne    80102a48 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102a28:	a1 98 5c 11 80       	mov    0x80115c98,%eax
80102a2d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102a2f:	a1 94 5c 11 80       	mov    0x80115c94,%eax
  kmem.freelist = r;
80102a34:	89 1d 98 5c 11 80    	mov    %ebx,0x80115c98
  if(kmem.use_lock)
80102a3a:	85 c0                	test   %eax,%eax
80102a3c:	75 22                	jne    80102a60 <kfree+0x80>
    release(&kmem.lock);
}
80102a3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a41:	c9                   	leave  
80102a42:	c3                   	ret    
80102a43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a47:	90                   	nop
    acquire(&kmem.lock);
80102a48:	83 ec 0c             	sub    $0xc,%esp
80102a4b:	68 60 5c 11 80       	push   $0x80115c60
80102a50:	e8 4b 33 00 00       	call   80105da0 <acquire>
80102a55:	83 c4 10             	add    $0x10,%esp
80102a58:	eb ce                	jmp    80102a28 <kfree+0x48>
80102a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102a60:	c7 45 08 60 5c 11 80 	movl   $0x80115c60,0x8(%ebp)
}
80102a67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a6a:	c9                   	leave  
    release(&kmem.lock);
80102a6b:	e9 f0 33 00 00       	jmp    80105e60 <release>
    panic("kfree");
80102a70:	83 ec 0c             	sub    $0xc,%esp
80102a73:	68 be 9f 10 80       	push   $0x80109fbe
80102a78:	e8 13 d9 ff ff       	call   80100390 <panic>
80102a7d:	8d 76 00             	lea    0x0(%esi),%esi

80102a80 <freerange>:
{
80102a80:	f3 0f 1e fb          	endbr32 
80102a84:	55                   	push   %ebp
80102a85:	89 e5                	mov    %esp,%ebp
80102a87:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a88:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a8b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a8e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a8f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a95:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a9b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102aa1:	39 de                	cmp    %ebx,%esi
80102aa3:	72 1f                	jb     80102ac4 <freerange+0x44>
80102aa5:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102aa8:	83 ec 0c             	sub    $0xc,%esp
80102aab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ab1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102ab7:	50                   	push   %eax
80102ab8:	e8 23 ff ff ff       	call   801029e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102abd:	83 c4 10             	add    $0x10,%esp
80102ac0:	39 f3                	cmp    %esi,%ebx
80102ac2:	76 e4                	jbe    80102aa8 <freerange+0x28>
}
80102ac4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ac7:	5b                   	pop    %ebx
80102ac8:	5e                   	pop    %esi
80102ac9:	5d                   	pop    %ebp
80102aca:	c3                   	ret    
80102acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102acf:	90                   	nop

80102ad0 <kinit1>:
{
80102ad0:	f3 0f 1e fb          	endbr32 
80102ad4:	55                   	push   %ebp
80102ad5:	89 e5                	mov    %esp,%ebp
80102ad7:	56                   	push   %esi
80102ad8:	53                   	push   %ebx
80102ad9:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102adc:	83 ec 08             	sub    $0x8,%esp
80102adf:	68 c4 9f 10 80       	push   $0x80109fc4
80102ae4:	68 60 5c 11 80       	push   $0x80115c60
80102ae9:	e8 32 31 00 00       	call   80105c20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102aee:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102af1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102af4:	c7 05 94 5c 11 80 00 	movl   $0x0,0x80115c94
80102afb:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102afe:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b04:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b0a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b10:	39 de                	cmp    %ebx,%esi
80102b12:	72 20                	jb     80102b34 <kinit1+0x64>
80102b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102b18:	83 ec 0c             	sub    $0xc,%esp
80102b1b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b27:	50                   	push   %eax
80102b28:	e8 b3 fe ff ff       	call   801029e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b2d:	83 c4 10             	add    $0x10,%esp
80102b30:	39 de                	cmp    %ebx,%esi
80102b32:	73 e4                	jae    80102b18 <kinit1+0x48>
}
80102b34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b37:	5b                   	pop    %ebx
80102b38:	5e                   	pop    %esi
80102b39:	5d                   	pop    %ebp
80102b3a:	c3                   	ret    
80102b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b3f:	90                   	nop

80102b40 <kinit2>:
{
80102b40:	f3 0f 1e fb          	endbr32 
80102b44:	55                   	push   %ebp
80102b45:	89 e5                	mov    %esp,%ebp
80102b47:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102b48:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102b4b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102b4e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102b4f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b55:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b5b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b61:	39 de                	cmp    %ebx,%esi
80102b63:	72 1f                	jb     80102b84 <kinit2+0x44>
80102b65:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102b68:	83 ec 0c             	sub    $0xc,%esp
80102b6b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b71:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b77:	50                   	push   %eax
80102b78:	e8 63 fe ff ff       	call   801029e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b7d:	83 c4 10             	add    $0x10,%esp
80102b80:	39 de                	cmp    %ebx,%esi
80102b82:	73 e4                	jae    80102b68 <kinit2+0x28>
  kmem.use_lock = 1;
80102b84:	c7 05 94 5c 11 80 01 	movl   $0x1,0x80115c94
80102b8b:	00 00 00 
}
80102b8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b91:	5b                   	pop    %ebx
80102b92:	5e                   	pop    %esi
80102b93:	5d                   	pop    %ebp
80102b94:	c3                   	ret    
80102b95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ba0:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102ba4:	a1 94 5c 11 80       	mov    0x80115c94,%eax
80102ba9:	85 c0                	test   %eax,%eax
80102bab:	75 1b                	jne    80102bc8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102bad:	a1 98 5c 11 80       	mov    0x80115c98,%eax
  if(r)
80102bb2:	85 c0                	test   %eax,%eax
80102bb4:	74 0a                	je     80102bc0 <kalloc+0x20>
    kmem.freelist = r->next;
80102bb6:	8b 10                	mov    (%eax),%edx
80102bb8:	89 15 98 5c 11 80    	mov    %edx,0x80115c98
  if(kmem.use_lock)
80102bbe:	c3                   	ret    
80102bbf:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102bc0:	c3                   	ret    
80102bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102bc8:	55                   	push   %ebp
80102bc9:	89 e5                	mov    %esp,%ebp
80102bcb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102bce:	68 60 5c 11 80       	push   $0x80115c60
80102bd3:	e8 c8 31 00 00       	call   80105da0 <acquire>
  r = kmem.freelist;
80102bd8:	a1 98 5c 11 80       	mov    0x80115c98,%eax
  if(r)
80102bdd:	8b 15 94 5c 11 80    	mov    0x80115c94,%edx
80102be3:	83 c4 10             	add    $0x10,%esp
80102be6:	85 c0                	test   %eax,%eax
80102be8:	74 08                	je     80102bf2 <kalloc+0x52>
    kmem.freelist = r->next;
80102bea:	8b 08                	mov    (%eax),%ecx
80102bec:	89 0d 98 5c 11 80    	mov    %ecx,0x80115c98
  if(kmem.use_lock)
80102bf2:	85 d2                	test   %edx,%edx
80102bf4:	74 16                	je     80102c0c <kalloc+0x6c>
    release(&kmem.lock);
80102bf6:	83 ec 0c             	sub    $0xc,%esp
80102bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102bfc:	68 60 5c 11 80       	push   $0x80115c60
80102c01:	e8 5a 32 00 00       	call   80105e60 <release>
  return (char*)r;
80102c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102c09:	83 c4 10             	add    $0x10,%esp
}
80102c0c:	c9                   	leave  
80102c0d:	c3                   	ret    
80102c0e:	66 90                	xchg   %ax,%ax

80102c10 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c10:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c14:	ba 64 00 00 00       	mov    $0x64,%edx
80102c19:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102c1a:	a8 01                	test   $0x1,%al
80102c1c:	0f 84 be 00 00 00    	je     80102ce0 <kbdgetc+0xd0>
{
80102c22:	55                   	push   %ebp
80102c23:	ba 60 00 00 00       	mov    $0x60,%edx
80102c28:	89 e5                	mov    %esp,%ebp
80102c2a:	53                   	push   %ebx
80102c2b:	ec                   	in     (%dx),%al
  return data;
80102c2c:	8b 1d b4 d5 10 80    	mov    0x8010d5b4,%ebx
    return -1;
  data = inb(KBDATAP);
80102c32:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102c35:	3c e0                	cmp    $0xe0,%al
80102c37:	74 57                	je     80102c90 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102c39:	89 d9                	mov    %ebx,%ecx
80102c3b:	83 e1 40             	and    $0x40,%ecx
80102c3e:	84 c0                	test   %al,%al
80102c40:	78 5e                	js     80102ca0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102c42:	85 c9                	test   %ecx,%ecx
80102c44:	74 09                	je     80102c4f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c46:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102c49:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102c4c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102c4f:	0f b6 8a 00 a1 10 80 	movzbl -0x7fef5f00(%edx),%ecx
  shift ^= togglecode[data];
80102c56:	0f b6 82 00 a0 10 80 	movzbl -0x7fef6000(%edx),%eax
  shift |= shiftcode[data];
80102c5d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102c5f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c61:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102c63:	89 0d b4 d5 10 80    	mov    %ecx,0x8010d5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102c69:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c6c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c6f:	8b 04 85 e0 9f 10 80 	mov    -0x7fef6020(,%eax,4),%eax
80102c76:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102c7a:	74 0b                	je     80102c87 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102c7c:	8d 50 9f             	lea    -0x61(%eax),%edx
80102c7f:	83 fa 19             	cmp    $0x19,%edx
80102c82:	77 44                	ja     80102cc8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c84:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c87:	5b                   	pop    %ebx
80102c88:	5d                   	pop    %ebp
80102c89:	c3                   	ret    
80102c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102c90:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102c93:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c95:	89 1d b4 d5 10 80    	mov    %ebx,0x8010d5b4
}
80102c9b:	5b                   	pop    %ebx
80102c9c:	5d                   	pop    %ebp
80102c9d:	c3                   	ret    
80102c9e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102ca0:	83 e0 7f             	and    $0x7f,%eax
80102ca3:	85 c9                	test   %ecx,%ecx
80102ca5:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102ca8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102caa:	0f b6 8a 00 a1 10 80 	movzbl -0x7fef5f00(%edx),%ecx
80102cb1:	83 c9 40             	or     $0x40,%ecx
80102cb4:	0f b6 c9             	movzbl %cl,%ecx
80102cb7:	f7 d1                	not    %ecx
80102cb9:	21 d9                	and    %ebx,%ecx
}
80102cbb:	5b                   	pop    %ebx
80102cbc:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102cbd:	89 0d b4 d5 10 80    	mov    %ecx,0x8010d5b4
}
80102cc3:	c3                   	ret    
80102cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102cc8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102ccb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102cce:	5b                   	pop    %ebx
80102ccf:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102cd0:	83 f9 1a             	cmp    $0x1a,%ecx
80102cd3:	0f 42 c2             	cmovb  %edx,%eax
}
80102cd6:	c3                   	ret    
80102cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cde:	66 90                	xchg   %ax,%ax
    return -1;
80102ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102ce5:	c3                   	ret    
80102ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ced:	8d 76 00             	lea    0x0(%esi),%esi

80102cf0 <kbdintr>:

void
kbdintr(void)
{
80102cf0:	f3 0f 1e fb          	endbr32 
80102cf4:	55                   	push   %ebp
80102cf5:	89 e5                	mov    %esp,%ebp
80102cf7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102cfa:	68 10 2c 10 80       	push   $0x80102c10
80102cff:	e8 6c dd ff ff       	call   80100a70 <consoleintr>
}
80102d04:	83 c4 10             	add    $0x10,%esp
80102d07:	c9                   	leave  
80102d08:	c3                   	ret    
80102d09:	66 90                	xchg   %ax,%ax
80102d0b:	66 90                	xchg   %ax,%ax
80102d0d:	66 90                	xchg   %ax,%ax
80102d0f:	90                   	nop

80102d10 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102d10:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102d14:	a1 9c 5c 11 80       	mov    0x80115c9c,%eax
80102d19:	85 c0                	test   %eax,%eax
80102d1b:	0f 84 c7 00 00 00    	je     80102de8 <lapicinit+0xd8>
  lapic[index] = value;
80102d21:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102d28:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d2e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102d35:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d38:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d3b:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102d42:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102d45:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d48:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102d4f:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102d52:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d55:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d5c:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d5f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d62:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d69:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d6c:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d6f:	8b 50 30             	mov    0x30(%eax),%edx
80102d72:	c1 ea 10             	shr    $0x10,%edx
80102d75:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102d7b:	75 73                	jne    80102df0 <lapicinit+0xe0>
  lapic[index] = value;
80102d7d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d84:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d87:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d8a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d91:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d94:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d97:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d9e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102da1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102da4:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102dab:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102db1:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102db8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dbb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dbe:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102dc5:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102dc8:	8b 50 20             	mov    0x20(%eax),%edx
80102dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dcf:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102dd0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102dd6:	80 e6 10             	and    $0x10,%dh
80102dd9:	75 f5                	jne    80102dd0 <lapicinit+0xc0>
  lapic[index] = value;
80102ddb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102de2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102de5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102de8:	c3                   	ret    
80102de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102df0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102df7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102dfa:	8b 50 20             	mov    0x20(%eax),%edx
}
80102dfd:	e9 7b ff ff ff       	jmp    80102d7d <lapicinit+0x6d>
80102e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e10 <lapicid>:

int
lapicid(void)
{
80102e10:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102e14:	a1 9c 5c 11 80       	mov    0x80115c9c,%eax
80102e19:	85 c0                	test   %eax,%eax
80102e1b:	74 0b                	je     80102e28 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102e1d:	8b 40 20             	mov    0x20(%eax),%eax
80102e20:	c1 e8 18             	shr    $0x18,%eax
80102e23:	c3                   	ret    
80102e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102e28:	31 c0                	xor    %eax,%eax
}
80102e2a:	c3                   	ret    
80102e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e2f:	90                   	nop

80102e30 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102e30:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102e34:	a1 9c 5c 11 80       	mov    0x80115c9c,%eax
80102e39:	85 c0                	test   %eax,%eax
80102e3b:	74 0d                	je     80102e4a <lapiceoi+0x1a>
  lapic[index] = value;
80102e3d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e47:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102e4a:	c3                   	ret    
80102e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e4f:	90                   	nop

80102e50 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102e50:	f3 0f 1e fb          	endbr32 
}
80102e54:	c3                   	ret    
80102e55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e60 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e60:	f3 0f 1e fb          	endbr32 
80102e64:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e65:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e6a:	ba 70 00 00 00       	mov    $0x70,%edx
80102e6f:	89 e5                	mov    %esp,%ebp
80102e71:	53                   	push   %ebx
80102e72:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e75:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e78:	ee                   	out    %al,(%dx)
80102e79:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e7e:	ba 71 00 00 00       	mov    $0x71,%edx
80102e83:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e84:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102e86:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e89:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e8f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e91:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102e94:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102e96:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e99:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e9c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102ea2:	a1 9c 5c 11 80       	mov    0x80115c9c,%eax
80102ea7:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ead:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102eb0:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102eb7:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102eba:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ebd:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ec4:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ec7:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102eca:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ed0:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ed3:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ed9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102edc:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ee2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ee5:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102eeb:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102eec:	8b 40 20             	mov    0x20(%eax),%eax
}
80102eef:	5d                   	pop    %ebp
80102ef0:	c3                   	ret    
80102ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eff:	90                   	nop

80102f00 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102f00:	f3 0f 1e fb          	endbr32 
80102f04:	55                   	push   %ebp
80102f05:	b8 0b 00 00 00       	mov    $0xb,%eax
80102f0a:	ba 70 00 00 00       	mov    $0x70,%edx
80102f0f:	89 e5                	mov    %esp,%ebp
80102f11:	57                   	push   %edi
80102f12:	56                   	push   %esi
80102f13:	53                   	push   %ebx
80102f14:	83 ec 4c             	sub    $0x4c,%esp
80102f17:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f18:	ba 71 00 00 00       	mov    $0x71,%edx
80102f1d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102f1e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f21:	bb 70 00 00 00       	mov    $0x70,%ebx
80102f26:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f30:	31 c0                	xor    %eax,%eax
80102f32:	89 da                	mov    %ebx,%edx
80102f34:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f35:	b9 71 00 00 00       	mov    $0x71,%ecx
80102f3a:	89 ca                	mov    %ecx,%edx
80102f3c:	ec                   	in     (%dx),%al
80102f3d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f40:	89 da                	mov    %ebx,%edx
80102f42:	b8 02 00 00 00       	mov    $0x2,%eax
80102f47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f48:	89 ca                	mov    %ecx,%edx
80102f4a:	ec                   	in     (%dx),%al
80102f4b:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f4e:	89 da                	mov    %ebx,%edx
80102f50:	b8 04 00 00 00       	mov    $0x4,%eax
80102f55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f56:	89 ca                	mov    %ecx,%edx
80102f58:	ec                   	in     (%dx),%al
80102f59:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f5c:	89 da                	mov    %ebx,%edx
80102f5e:	b8 07 00 00 00       	mov    $0x7,%eax
80102f63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f64:	89 ca                	mov    %ecx,%edx
80102f66:	ec                   	in     (%dx),%al
80102f67:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6a:	89 da                	mov    %ebx,%edx
80102f6c:	b8 08 00 00 00       	mov    $0x8,%eax
80102f71:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f72:	89 ca                	mov    %ecx,%edx
80102f74:	ec                   	in     (%dx),%al
80102f75:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f77:	89 da                	mov    %ebx,%edx
80102f79:	b8 09 00 00 00       	mov    $0x9,%eax
80102f7e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f7f:	89 ca                	mov    %ecx,%edx
80102f81:	ec                   	in     (%dx),%al
80102f82:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f84:	89 da                	mov    %ebx,%edx
80102f86:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f8c:	89 ca                	mov    %ecx,%edx
80102f8e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f8f:	84 c0                	test   %al,%al
80102f91:	78 9d                	js     80102f30 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102f93:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f97:	89 fa                	mov    %edi,%edx
80102f99:	0f b6 fa             	movzbl %dl,%edi
80102f9c:	89 f2                	mov    %esi,%edx
80102f9e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fa1:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102fa5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fa8:	89 da                	mov    %ebx,%edx
80102faa:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102fad:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102fb0:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102fb4:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102fb7:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102fba:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102fbe:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102fc1:	31 c0                	xor    %eax,%eax
80102fc3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fc4:	89 ca                	mov    %ecx,%edx
80102fc6:	ec                   	in     (%dx),%al
80102fc7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fca:	89 da                	mov    %ebx,%edx
80102fcc:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102fcf:	b8 02 00 00 00       	mov    $0x2,%eax
80102fd4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd5:	89 ca                	mov    %ecx,%edx
80102fd7:	ec                   	in     (%dx),%al
80102fd8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fdb:	89 da                	mov    %ebx,%edx
80102fdd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102fe0:	b8 04 00 00 00       	mov    $0x4,%eax
80102fe5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fe6:	89 ca                	mov    %ecx,%edx
80102fe8:	ec                   	in     (%dx),%al
80102fe9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fec:	89 da                	mov    %ebx,%edx
80102fee:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ff1:	b8 07 00 00 00       	mov    $0x7,%eax
80102ff6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ff7:	89 ca                	mov    %ecx,%edx
80102ff9:	ec                   	in     (%dx),%al
80102ffa:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ffd:	89 da                	mov    %ebx,%edx
80102fff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103002:	b8 08 00 00 00       	mov    $0x8,%eax
80103007:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103008:	89 ca                	mov    %ecx,%edx
8010300a:	ec                   	in     (%dx),%al
8010300b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010300e:	89 da                	mov    %ebx,%edx
80103010:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103013:	b8 09 00 00 00       	mov    $0x9,%eax
80103018:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103019:	89 ca                	mov    %ecx,%edx
8010301b:	ec                   	in     (%dx),%al
8010301c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010301f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103022:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103025:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103028:	6a 18                	push   $0x18
8010302a:	50                   	push   %eax
8010302b:	8d 45 b8             	lea    -0x48(%ebp),%eax
8010302e:	50                   	push   %eax
8010302f:	e8 cc 2e 00 00       	call   80105f00 <memcmp>
80103034:	83 c4 10             	add    $0x10,%esp
80103037:	85 c0                	test   %eax,%eax
80103039:	0f 85 f1 fe ff ff    	jne    80102f30 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
8010303f:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103043:	75 78                	jne    801030bd <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103045:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103048:	89 c2                	mov    %eax,%edx
8010304a:	83 e0 0f             	and    $0xf,%eax
8010304d:	c1 ea 04             	shr    $0x4,%edx
80103050:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103053:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103056:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103059:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010305c:	89 c2                	mov    %eax,%edx
8010305e:	83 e0 0f             	and    $0xf,%eax
80103061:	c1 ea 04             	shr    $0x4,%edx
80103064:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103067:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010306a:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
8010306d:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103070:	89 c2                	mov    %eax,%edx
80103072:	83 e0 0f             	and    $0xf,%eax
80103075:	c1 ea 04             	shr    $0x4,%edx
80103078:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010307b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010307e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103081:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103084:	89 c2                	mov    %eax,%edx
80103086:	83 e0 0f             	and    $0xf,%eax
80103089:	c1 ea 04             	shr    $0x4,%edx
8010308c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010308f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103092:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103095:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103098:	89 c2                	mov    %eax,%edx
8010309a:	83 e0 0f             	and    $0xf,%eax
8010309d:	c1 ea 04             	shr    $0x4,%edx
801030a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030a3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030a6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801030a9:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030ac:	89 c2                	mov    %eax,%edx
801030ae:	83 e0 0f             	and    $0xf,%eax
801030b1:	c1 ea 04             	shr    $0x4,%edx
801030b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030b7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030ba:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801030bd:	8b 75 08             	mov    0x8(%ebp),%esi
801030c0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801030c3:	89 06                	mov    %eax,(%esi)
801030c5:	8b 45 bc             	mov    -0x44(%ebp),%eax
801030c8:	89 46 04             	mov    %eax,0x4(%esi)
801030cb:	8b 45 c0             	mov    -0x40(%ebp),%eax
801030ce:	89 46 08             	mov    %eax,0x8(%esi)
801030d1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801030d4:	89 46 0c             	mov    %eax,0xc(%esi)
801030d7:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030da:	89 46 10             	mov    %eax,0x10(%esi)
801030dd:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030e0:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801030e3:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801030ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030ed:	5b                   	pop    %ebx
801030ee:	5e                   	pop    %esi
801030ef:	5f                   	pop    %edi
801030f0:	5d                   	pop    %ebp
801030f1:	c3                   	ret    
801030f2:	66 90                	xchg   %ax,%ax
801030f4:	66 90                	xchg   %ax,%ax
801030f6:	66 90                	xchg   %ax,%ax
801030f8:	66 90                	xchg   %ax,%ax
801030fa:	66 90                	xchg   %ax,%ax
801030fc:	66 90                	xchg   %ax,%ax
801030fe:	66 90                	xchg   %ax,%ax

80103100 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103100:	8b 0d e8 5c 11 80    	mov    0x80115ce8,%ecx
80103106:	85 c9                	test   %ecx,%ecx
80103108:	0f 8e 8a 00 00 00    	jle    80103198 <install_trans+0x98>
{
8010310e:	55                   	push   %ebp
8010310f:	89 e5                	mov    %esp,%ebp
80103111:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103112:	31 ff                	xor    %edi,%edi
{
80103114:	56                   	push   %esi
80103115:	53                   	push   %ebx
80103116:	83 ec 0c             	sub    $0xc,%esp
80103119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103120:	a1 d4 5c 11 80       	mov    0x80115cd4,%eax
80103125:	83 ec 08             	sub    $0x8,%esp
80103128:	01 f8                	add    %edi,%eax
8010312a:	83 c0 01             	add    $0x1,%eax
8010312d:	50                   	push   %eax
8010312e:	ff 35 e4 5c 11 80    	pushl  0x80115ce4
80103134:	e8 97 cf ff ff       	call   801000d0 <bread>
80103139:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010313b:	58                   	pop    %eax
8010313c:	5a                   	pop    %edx
8010313d:	ff 34 bd ec 5c 11 80 	pushl  -0x7feea314(,%edi,4)
80103144:	ff 35 e4 5c 11 80    	pushl  0x80115ce4
  for (tail = 0; tail < log.lh.n; tail++) {
8010314a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010314d:	e8 7e cf ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103152:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103155:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103157:	8d 46 5c             	lea    0x5c(%esi),%eax
8010315a:	68 00 02 00 00       	push   $0x200
8010315f:	50                   	push   %eax
80103160:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103163:	50                   	push   %eax
80103164:	e8 e7 2d 00 00       	call   80105f50 <memmove>
    bwrite(dbuf);  // write dst to disk
80103169:	89 1c 24             	mov    %ebx,(%esp)
8010316c:	e8 3f d0 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103171:	89 34 24             	mov    %esi,(%esp)
80103174:	e8 77 d0 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103179:	89 1c 24             	mov    %ebx,(%esp)
8010317c:	e8 6f d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103181:	83 c4 10             	add    $0x10,%esp
80103184:	39 3d e8 5c 11 80    	cmp    %edi,0x80115ce8
8010318a:	7f 94                	jg     80103120 <install_trans+0x20>
  }
}
8010318c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010318f:	5b                   	pop    %ebx
80103190:	5e                   	pop    %esi
80103191:	5f                   	pop    %edi
80103192:	5d                   	pop    %ebp
80103193:	c3                   	ret    
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103198:	c3                   	ret    
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801031a0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	53                   	push   %ebx
801031a4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
801031a7:	ff 35 d4 5c 11 80    	pushl  0x80115cd4
801031ad:	ff 35 e4 5c 11 80    	pushl  0x80115ce4
801031b3:	e8 18 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031b8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801031bb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
801031bd:	a1 e8 5c 11 80       	mov    0x80115ce8,%eax
801031c2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801031c5:	85 c0                	test   %eax,%eax
801031c7:	7e 19                	jle    801031e2 <write_head+0x42>
801031c9:	31 d2                	xor    %edx,%edx
801031cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031cf:	90                   	nop
    hb->block[i] = log.lh.block[i];
801031d0:	8b 0c 95 ec 5c 11 80 	mov    -0x7feea314(,%edx,4),%ecx
801031d7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801031db:	83 c2 01             	add    $0x1,%edx
801031de:	39 d0                	cmp    %edx,%eax
801031e0:	75 ee                	jne    801031d0 <write_head+0x30>
  }
  bwrite(buf);
801031e2:	83 ec 0c             	sub    $0xc,%esp
801031e5:	53                   	push   %ebx
801031e6:	e8 c5 cf ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801031eb:	89 1c 24             	mov    %ebx,(%esp)
801031ee:	e8 fd cf ff ff       	call   801001f0 <brelse>
}
801031f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031f6:	83 c4 10             	add    $0x10,%esp
801031f9:	c9                   	leave  
801031fa:	c3                   	ret    
801031fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031ff:	90                   	nop

80103200 <initlog>:
{
80103200:	f3 0f 1e fb          	endbr32 
80103204:	55                   	push   %ebp
80103205:	89 e5                	mov    %esp,%ebp
80103207:	53                   	push   %ebx
80103208:	83 ec 2c             	sub    $0x2c,%esp
8010320b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010320e:	68 00 a2 10 80       	push   $0x8010a200
80103213:	68 a0 5c 11 80       	push   $0x80115ca0
80103218:	e8 03 2a 00 00       	call   80105c20 <initlock>
  readsb(dev, &sb);
8010321d:	58                   	pop    %eax
8010321e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103221:	5a                   	pop    %edx
80103222:	50                   	push   %eax
80103223:	53                   	push   %ebx
80103224:	e8 47 e8 ff ff       	call   80101a70 <readsb>
  log.start = sb.logstart;
80103229:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010322c:	59                   	pop    %ecx
  log.dev = dev;
8010322d:	89 1d e4 5c 11 80    	mov    %ebx,0x80115ce4
  log.size = sb.nlog;
80103233:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103236:	a3 d4 5c 11 80       	mov    %eax,0x80115cd4
  log.size = sb.nlog;
8010323b:	89 15 d8 5c 11 80    	mov    %edx,0x80115cd8
  struct buf *buf = bread(log.dev, log.start);
80103241:	5a                   	pop    %edx
80103242:	50                   	push   %eax
80103243:	53                   	push   %ebx
80103244:	e8 87 ce ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103249:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
8010324c:	8b 48 5c             	mov    0x5c(%eax),%ecx
8010324f:	89 0d e8 5c 11 80    	mov    %ecx,0x80115ce8
  for (i = 0; i < log.lh.n; i++) {
80103255:	85 c9                	test   %ecx,%ecx
80103257:	7e 19                	jle    80103272 <initlog+0x72>
80103259:	31 d2                	xor    %edx,%edx
8010325b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010325f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103260:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80103264:	89 1c 95 ec 5c 11 80 	mov    %ebx,-0x7feea314(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010326b:	83 c2 01             	add    $0x1,%edx
8010326e:	39 d1                	cmp    %edx,%ecx
80103270:	75 ee                	jne    80103260 <initlog+0x60>
  brelse(buf);
80103272:	83 ec 0c             	sub    $0xc,%esp
80103275:	50                   	push   %eax
80103276:	e8 75 cf ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010327b:	e8 80 fe ff ff       	call   80103100 <install_trans>
  log.lh.n = 0;
80103280:	c7 05 e8 5c 11 80 00 	movl   $0x0,0x80115ce8
80103287:	00 00 00 
  write_head(); // clear the log
8010328a:	e8 11 ff ff ff       	call   801031a0 <write_head>
}
8010328f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103292:	83 c4 10             	add    $0x10,%esp
80103295:	c9                   	leave  
80103296:	c3                   	ret    
80103297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010329e:	66 90                	xchg   %ax,%ax

801032a0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801032a0:	f3 0f 1e fb          	endbr32 
801032a4:	55                   	push   %ebp
801032a5:	89 e5                	mov    %esp,%ebp
801032a7:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801032aa:	68 a0 5c 11 80       	push   $0x80115ca0
801032af:	e8 ec 2a 00 00       	call   80105da0 <acquire>
801032b4:	83 c4 10             	add    $0x10,%esp
801032b7:	eb 1c                	jmp    801032d5 <begin_op+0x35>
801032b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801032c0:	83 ec 08             	sub    $0x8,%esp
801032c3:	68 a0 5c 11 80       	push   $0x80115ca0
801032c8:	68 a0 5c 11 80       	push   $0x80115ca0
801032cd:	e8 ae 12 00 00       	call   80104580 <sleep>
801032d2:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801032d5:	a1 e0 5c 11 80       	mov    0x80115ce0,%eax
801032da:	85 c0                	test   %eax,%eax
801032dc:	75 e2                	jne    801032c0 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801032de:	a1 dc 5c 11 80       	mov    0x80115cdc,%eax
801032e3:	8b 15 e8 5c 11 80    	mov    0x80115ce8,%edx
801032e9:	83 c0 01             	add    $0x1,%eax
801032ec:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801032ef:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801032f2:	83 fa 1e             	cmp    $0x1e,%edx
801032f5:	7f c9                	jg     801032c0 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801032f7:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801032fa:	a3 dc 5c 11 80       	mov    %eax,0x80115cdc
      release(&log.lock);
801032ff:	68 a0 5c 11 80       	push   $0x80115ca0
80103304:	e8 57 2b 00 00       	call   80105e60 <release>
      break;
    }
  }
}
80103309:	83 c4 10             	add    $0x10,%esp
8010330c:	c9                   	leave  
8010330d:	c3                   	ret    
8010330e:	66 90                	xchg   %ax,%ax

80103310 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103310:	f3 0f 1e fb          	endbr32 
80103314:	55                   	push   %ebp
80103315:	89 e5                	mov    %esp,%ebp
80103317:	57                   	push   %edi
80103318:	56                   	push   %esi
80103319:	53                   	push   %ebx
8010331a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
8010331d:	68 a0 5c 11 80       	push   $0x80115ca0
80103322:	e8 79 2a 00 00       	call   80105da0 <acquire>
  log.outstanding -= 1;
80103327:	a1 dc 5c 11 80       	mov    0x80115cdc,%eax
  if(log.committing)
8010332c:	8b 35 e0 5c 11 80    	mov    0x80115ce0,%esi
80103332:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103335:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103338:	89 1d dc 5c 11 80    	mov    %ebx,0x80115cdc
  if(log.committing)
8010333e:	85 f6                	test   %esi,%esi
80103340:	0f 85 1e 01 00 00    	jne    80103464 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103346:	85 db                	test   %ebx,%ebx
80103348:	0f 85 f2 00 00 00    	jne    80103440 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010334e:	c7 05 e0 5c 11 80 01 	movl   $0x1,0x80115ce0
80103355:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103358:	83 ec 0c             	sub    $0xc,%esp
8010335b:	68 a0 5c 11 80       	push   $0x80115ca0
80103360:	e8 fb 2a 00 00       	call   80105e60 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103365:	8b 0d e8 5c 11 80    	mov    0x80115ce8,%ecx
8010336b:	83 c4 10             	add    $0x10,%esp
8010336e:	85 c9                	test   %ecx,%ecx
80103370:	7f 3e                	jg     801033b0 <end_op+0xa0>
    acquire(&log.lock);
80103372:	83 ec 0c             	sub    $0xc,%esp
80103375:	68 a0 5c 11 80       	push   $0x80115ca0
8010337a:	e8 21 2a 00 00       	call   80105da0 <acquire>
    wakeup(&log);
8010337f:	c7 04 24 a0 5c 11 80 	movl   $0x80115ca0,(%esp)
    log.committing = 0;
80103386:	c7 05 e0 5c 11 80 00 	movl   $0x0,0x80115ce0
8010338d:	00 00 00 
    wakeup(&log);
80103390:	e8 ab 13 00 00       	call   80104740 <wakeup>
    release(&log.lock);
80103395:	c7 04 24 a0 5c 11 80 	movl   $0x80115ca0,(%esp)
8010339c:	e8 bf 2a 00 00       	call   80105e60 <release>
801033a1:	83 c4 10             	add    $0x10,%esp
}
801033a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033a7:	5b                   	pop    %ebx
801033a8:	5e                   	pop    %esi
801033a9:	5f                   	pop    %edi
801033aa:	5d                   	pop    %ebp
801033ab:	c3                   	ret    
801033ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801033b0:	a1 d4 5c 11 80       	mov    0x80115cd4,%eax
801033b5:	83 ec 08             	sub    $0x8,%esp
801033b8:	01 d8                	add    %ebx,%eax
801033ba:	83 c0 01             	add    $0x1,%eax
801033bd:	50                   	push   %eax
801033be:	ff 35 e4 5c 11 80    	pushl  0x80115ce4
801033c4:	e8 07 cd ff ff       	call   801000d0 <bread>
801033c9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033cb:	58                   	pop    %eax
801033cc:	5a                   	pop    %edx
801033cd:	ff 34 9d ec 5c 11 80 	pushl  -0x7feea314(,%ebx,4)
801033d4:	ff 35 e4 5c 11 80    	pushl  0x80115ce4
  for (tail = 0; tail < log.lh.n; tail++) {
801033da:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033dd:	e8 ee cc ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801033e2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033e5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801033e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801033ea:	68 00 02 00 00       	push   $0x200
801033ef:	50                   	push   %eax
801033f0:	8d 46 5c             	lea    0x5c(%esi),%eax
801033f3:	50                   	push   %eax
801033f4:	e8 57 2b 00 00       	call   80105f50 <memmove>
    bwrite(to);  // write the log
801033f9:	89 34 24             	mov    %esi,(%esp)
801033fc:	e8 af cd ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103401:	89 3c 24             	mov    %edi,(%esp)
80103404:	e8 e7 cd ff ff       	call   801001f0 <brelse>
    brelse(to);
80103409:	89 34 24             	mov    %esi,(%esp)
8010340c:	e8 df cd ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103411:	83 c4 10             	add    $0x10,%esp
80103414:	3b 1d e8 5c 11 80    	cmp    0x80115ce8,%ebx
8010341a:	7c 94                	jl     801033b0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010341c:	e8 7f fd ff ff       	call   801031a0 <write_head>
    install_trans(); // Now install writes to home locations
80103421:	e8 da fc ff ff       	call   80103100 <install_trans>
    log.lh.n = 0;
80103426:	c7 05 e8 5c 11 80 00 	movl   $0x0,0x80115ce8
8010342d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103430:	e8 6b fd ff ff       	call   801031a0 <write_head>
80103435:	e9 38 ff ff ff       	jmp    80103372 <end_op+0x62>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103440:	83 ec 0c             	sub    $0xc,%esp
80103443:	68 a0 5c 11 80       	push   $0x80115ca0
80103448:	e8 f3 12 00 00       	call   80104740 <wakeup>
  release(&log.lock);
8010344d:	c7 04 24 a0 5c 11 80 	movl   $0x80115ca0,(%esp)
80103454:	e8 07 2a 00 00       	call   80105e60 <release>
80103459:	83 c4 10             	add    $0x10,%esp
}
8010345c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010345f:	5b                   	pop    %ebx
80103460:	5e                   	pop    %esi
80103461:	5f                   	pop    %edi
80103462:	5d                   	pop    %ebp
80103463:	c3                   	ret    
    panic("log.committing");
80103464:	83 ec 0c             	sub    $0xc,%esp
80103467:	68 04 a2 10 80       	push   $0x8010a204
8010346c:	e8 1f cf ff ff       	call   80100390 <panic>
80103471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010347f:	90                   	nop

80103480 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103480:	f3 0f 1e fb          	endbr32 
80103484:	55                   	push   %ebp
80103485:	89 e5                	mov    %esp,%ebp
80103487:	53                   	push   %ebx
80103488:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010348b:	8b 15 e8 5c 11 80    	mov    0x80115ce8,%edx
{
80103491:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103494:	83 fa 1d             	cmp    $0x1d,%edx
80103497:	0f 8f 91 00 00 00    	jg     8010352e <log_write+0xae>
8010349d:	a1 d8 5c 11 80       	mov    0x80115cd8,%eax
801034a2:	83 e8 01             	sub    $0x1,%eax
801034a5:	39 c2                	cmp    %eax,%edx
801034a7:	0f 8d 81 00 00 00    	jge    8010352e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
801034ad:	a1 dc 5c 11 80       	mov    0x80115cdc,%eax
801034b2:	85 c0                	test   %eax,%eax
801034b4:	0f 8e 81 00 00 00    	jle    8010353b <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
801034ba:	83 ec 0c             	sub    $0xc,%esp
801034bd:	68 a0 5c 11 80       	push   $0x80115ca0
801034c2:	e8 d9 28 00 00       	call   80105da0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801034c7:	8b 15 e8 5c 11 80    	mov    0x80115ce8,%edx
801034cd:	83 c4 10             	add    $0x10,%esp
801034d0:	85 d2                	test   %edx,%edx
801034d2:	7e 4e                	jle    80103522 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034d4:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801034d7:	31 c0                	xor    %eax,%eax
801034d9:	eb 0c                	jmp    801034e7 <log_write+0x67>
801034db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034df:	90                   	nop
801034e0:	83 c0 01             	add    $0x1,%eax
801034e3:	39 c2                	cmp    %eax,%edx
801034e5:	74 29                	je     80103510 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034e7:	39 0c 85 ec 5c 11 80 	cmp    %ecx,-0x7feea314(,%eax,4)
801034ee:	75 f0                	jne    801034e0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801034f0:	89 0c 85 ec 5c 11 80 	mov    %ecx,-0x7feea314(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801034f7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801034fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801034fd:	c7 45 08 a0 5c 11 80 	movl   $0x80115ca0,0x8(%ebp)
}
80103504:	c9                   	leave  
  release(&log.lock);
80103505:	e9 56 29 00 00       	jmp    80105e60 <release>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103510:	89 0c 95 ec 5c 11 80 	mov    %ecx,-0x7feea314(,%edx,4)
    log.lh.n++;
80103517:	83 c2 01             	add    $0x1,%edx
8010351a:	89 15 e8 5c 11 80    	mov    %edx,0x80115ce8
80103520:	eb d5                	jmp    801034f7 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103522:	8b 43 08             	mov    0x8(%ebx),%eax
80103525:	a3 ec 5c 11 80       	mov    %eax,0x80115cec
  if (i == log.lh.n)
8010352a:	75 cb                	jne    801034f7 <log_write+0x77>
8010352c:	eb e9                	jmp    80103517 <log_write+0x97>
    panic("too big a transaction");
8010352e:	83 ec 0c             	sub    $0xc,%esp
80103531:	68 13 a2 10 80       	push   $0x8010a213
80103536:	e8 55 ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
8010353b:	83 ec 0c             	sub    $0xc,%esp
8010353e:	68 29 a2 10 80       	push   $0x8010a229
80103543:	e8 48 ce ff ff       	call   80100390 <panic>
80103548:	66 90                	xchg   %ax,%ax
8010354a:	66 90                	xchg   %ax,%ax
8010354c:	66 90                	xchg   %ax,%ax
8010354e:	66 90                	xchg   %ax,%ax

80103550 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	53                   	push   %ebx
80103554:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103557:	e8 f4 09 00 00       	call   80103f50 <cpuid>
8010355c:	89 c3                	mov    %eax,%ebx
8010355e:	e8 ed 09 00 00       	call   80103f50 <cpuid>
80103563:	83 ec 04             	sub    $0x4,%esp
80103566:	53                   	push   %ebx
80103567:	50                   	push   %eax
80103568:	68 44 a2 10 80       	push   $0x8010a244
8010356d:	e8 4e d3 ff ff       	call   801008c0 <cprintf>
  idtinit();       // load idt register
80103572:	e8 09 42 00 00       	call   80107780 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103577:	e8 64 09 00 00       	call   80103ee0 <mycpu>
8010357c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010357e:	b8 01 00 00 00       	mov    $0x1,%eax
80103583:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010358a:	e8 c1 0b 00 00       	call   80104150 <scheduler>
8010358f:	90                   	nop

80103590 <mpenter>:
{
80103590:	f3 0f 1e fb          	endbr32 
80103594:	55                   	push   %ebp
80103595:	89 e5                	mov    %esp,%ebp
80103597:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010359a:	e8 81 53 00 00       	call   80108920 <switchkvm>
  seginit();
8010359f:	e8 ec 52 00 00       	call   80108890 <seginit>
  lapicinit();
801035a4:	e8 67 f7 ff ff       	call   80102d10 <lapicinit>
  mpmain();
801035a9:	e8 a2 ff ff ff       	call   80103550 <mpmain>
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <main>:
{
801035b0:	f3 0f 1e fb          	endbr32 
801035b4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801035b8:	83 e4 f0             	and    $0xfffffff0,%esp
801035bb:	ff 71 fc             	pushl  -0x4(%ecx)
801035be:	55                   	push   %ebp
801035bf:	89 e5                	mov    %esp,%ebp
801035c1:	53                   	push   %ebx
801035c2:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801035c3:	83 ec 08             	sub    $0x8,%esp
801035c6:	68 00 00 40 80       	push   $0x80400000
801035cb:	68 54 21 13 80       	push   $0x80132154
801035d0:	e8 fb f4 ff ff       	call   80102ad0 <kinit1>
  kvmalloc();      // kernel page table
801035d5:	e8 26 58 00 00       	call   80108e00 <kvmalloc>
  mpinit();        // detect other processors
801035da:	e8 91 01 00 00       	call   80103770 <mpinit>
  lapicinit();     // interrupt controller
801035df:	e8 2c f7 ff ff       	call   80102d10 <lapicinit>
  seginit();       // segment descriptors
801035e4:	e8 a7 52 00 00       	call   80108890 <seginit>
  picinit();       // disable pic
801035e9:	e8 62 03 00 00       	call   80103950 <picinit>
  ioapicinit();    // another interrupt controller
801035ee:	e8 fd f2 ff ff       	call   801028f0 <ioapicinit>
  consoleinit();   // console hardware
801035f3:	e8 28 d9 ff ff       	call   80100f20 <consoleinit>
  uartinit();      // serial port
801035f8:	e8 53 45 00 00       	call   80107b50 <uartinit>
  pinit();         // process table
801035fd:	e8 be 08 00 00       	call   80103ec0 <pinit>
  tvinit();        // trap vectors
80103602:	e8 f9 40 00 00       	call   80107700 <tvinit>
  binit();         // buffer cache
80103607:	e8 34 ca ff ff       	call   80100040 <binit>
  init_queue_test();
8010360c:	e8 8f 23 00 00       	call   801059a0 <init_queue_test>
  fileinit();      // file table
80103611:	e8 3a dd ff ff       	call   80101350 <fileinit>
  ideinit();       // disk 
80103616:	e8 a5 f0 ff ff       	call   801026c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010361b:	83 c4 0c             	add    $0xc,%esp
8010361e:	68 8a 00 00 00       	push   $0x8a
80103623:	68 8c d4 10 80       	push   $0x8010d48c
80103628:	68 00 70 00 80       	push   $0x80007000
8010362d:	e8 1e 29 00 00       	call   80105f50 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103632:	83 c4 10             	add    $0x10,%esp
80103635:	69 05 40 63 11 80 b4 	imul   $0xb4,0x80116340,%eax
8010363c:	00 00 00 
8010363f:	05 a0 5d 11 80       	add    $0x80115da0,%eax
80103644:	3d a0 5d 11 80       	cmp    $0x80115da0,%eax
80103649:	76 7d                	jbe    801036c8 <main+0x118>
8010364b:	bb a0 5d 11 80       	mov    $0x80115da0,%ebx
80103650:	eb 1f                	jmp    80103671 <main+0xc1>
80103652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103658:	69 05 40 63 11 80 b4 	imul   $0xb4,0x80116340,%eax
8010365f:	00 00 00 
80103662:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
80103668:	05 a0 5d 11 80       	add    $0x80115da0,%eax
8010366d:	39 c3                	cmp    %eax,%ebx
8010366f:	73 57                	jae    801036c8 <main+0x118>
    if(c == mycpu())  // We've started already.
80103671:	e8 6a 08 00 00       	call   80103ee0 <mycpu>
80103676:	39 c3                	cmp    %eax,%ebx
80103678:	74 de                	je     80103658 <main+0xa8>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
8010367a:	e8 21 f5 ff ff       	call   80102ba0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
8010367f:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103682:	c7 05 f8 6f 00 80 90 	movl   $0x80103590,0x80006ff8
80103689:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010368c:	c7 05 f4 6f 00 80 00 	movl   $0x10c000,0x80006ff4
80103693:	c0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103696:	05 00 10 00 00       	add    $0x1000,%eax
8010369b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801036a0:	0f b6 03             	movzbl (%ebx),%eax
801036a3:	68 00 70 00 00       	push   $0x7000
801036a8:	50                   	push   %eax
801036a9:	e8 b2 f7 ff ff       	call   80102e60 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801036ae:	83 c4 10             	add    $0x10,%esp
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036b8:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801036be:	85 c0                	test   %eax,%eax
801036c0:	74 f6                	je     801036b8 <main+0x108>
801036c2:	eb 94                	jmp    80103658 <main+0xa8>
801036c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801036c8:	83 ec 08             	sub    $0x8,%esp
801036cb:	68 00 00 00 8e       	push   $0x8e000000
801036d0:	68 00 00 40 80       	push   $0x80400000
801036d5:	e8 66 f4 ff ff       	call   80102b40 <kinit2>
  userinit();      // first user process
801036da:	e8 51 14 00 00       	call   80104b30 <userinit>
  sharedMemoryInit();
801036df:	e8 6c 64 00 00       	call   80109b50 <sharedMemoryInit>
  mpmain();        // finish this processor's setup
801036e4:	e8 67 fe ff ff       	call   80103550 <mpmain>
801036e9:	66 90                	xchg   %ax,%ax
801036eb:	66 90                	xchg   %ax,%ax
801036ed:	66 90                	xchg   %ax,%ax
801036ef:	90                   	nop

801036f0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	57                   	push   %edi
801036f4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801036f5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801036fb:	53                   	push   %ebx
  e = addr+len;
801036fc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801036ff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103702:	39 de                	cmp    %ebx,%esi
80103704:	72 10                	jb     80103716 <mpsearch1+0x26>
80103706:	eb 50                	jmp    80103758 <mpsearch1+0x68>
80103708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370f:	90                   	nop
80103710:	89 fe                	mov    %edi,%esi
80103712:	39 fb                	cmp    %edi,%ebx
80103714:	76 42                	jbe    80103758 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103716:	83 ec 04             	sub    $0x4,%esp
80103719:	8d 7e 10             	lea    0x10(%esi),%edi
8010371c:	6a 04                	push   $0x4
8010371e:	68 58 a2 10 80       	push   $0x8010a258
80103723:	56                   	push   %esi
80103724:	e8 d7 27 00 00       	call   80105f00 <memcmp>
80103729:	83 c4 10             	add    $0x10,%esp
8010372c:	85 c0                	test   %eax,%eax
8010372e:	75 e0                	jne    80103710 <mpsearch1+0x20>
80103730:	89 f2                	mov    %esi,%edx
80103732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103738:	0f b6 0a             	movzbl (%edx),%ecx
8010373b:	83 c2 01             	add    $0x1,%edx
8010373e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103740:	39 fa                	cmp    %edi,%edx
80103742:	75 f4                	jne    80103738 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103744:	84 c0                	test   %al,%al
80103746:	75 c8                	jne    80103710 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103748:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010374b:	89 f0                	mov    %esi,%eax
8010374d:	5b                   	pop    %ebx
8010374e:	5e                   	pop    %esi
8010374f:	5f                   	pop    %edi
80103750:	5d                   	pop    %ebp
80103751:	c3                   	ret    
80103752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103758:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010375b:	31 f6                	xor    %esi,%esi
}
8010375d:	5b                   	pop    %ebx
8010375e:	89 f0                	mov    %esi,%eax
80103760:	5e                   	pop    %esi
80103761:	5f                   	pop    %edi
80103762:	5d                   	pop    %ebp
80103763:	c3                   	ret    
80103764:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010376b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010376f:	90                   	nop

80103770 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103770:	f3 0f 1e fb          	endbr32 
80103774:	55                   	push   %ebp
80103775:	89 e5                	mov    %esp,%ebp
80103777:	57                   	push   %edi
80103778:	56                   	push   %esi
80103779:	53                   	push   %ebx
8010377a:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010377d:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103784:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
8010378b:	c1 e0 08             	shl    $0x8,%eax
8010378e:	09 d0                	or     %edx,%eax
80103790:	c1 e0 04             	shl    $0x4,%eax
80103793:	75 1b                	jne    801037b0 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103795:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010379c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801037a3:	c1 e0 08             	shl    $0x8,%eax
801037a6:	09 d0                	or     %edx,%eax
801037a8:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801037ab:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801037b0:	ba 00 04 00 00       	mov    $0x400,%edx
801037b5:	e8 36 ff ff ff       	call   801036f0 <mpsearch1>
801037ba:	89 c6                	mov    %eax,%esi
801037bc:	85 c0                	test   %eax,%eax
801037be:	0f 84 4c 01 00 00    	je     80103910 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037c4:	8b 5e 04             	mov    0x4(%esi),%ebx
801037c7:	85 db                	test   %ebx,%ebx
801037c9:	0f 84 61 01 00 00    	je     80103930 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
801037cf:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801037d2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801037d8:	6a 04                	push   $0x4
801037da:	68 5d a2 10 80       	push   $0x8010a25d
801037df:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801037e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801037e3:	e8 18 27 00 00       	call   80105f00 <memcmp>
801037e8:	83 c4 10             	add    $0x10,%esp
801037eb:	85 c0                	test   %eax,%eax
801037ed:	0f 85 3d 01 00 00    	jne    80103930 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
801037f3:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801037fa:	3c 01                	cmp    $0x1,%al
801037fc:	74 08                	je     80103806 <mpinit+0x96>
801037fe:	3c 04                	cmp    $0x4,%al
80103800:	0f 85 2a 01 00 00    	jne    80103930 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103806:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
8010380d:	66 85 d2             	test   %dx,%dx
80103810:	74 26                	je     80103838 <mpinit+0xc8>
80103812:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103815:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103817:	31 d2                	xor    %edx,%edx
80103819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103820:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103827:	83 c0 01             	add    $0x1,%eax
8010382a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010382c:	39 f8                	cmp    %edi,%eax
8010382e:	75 f0                	jne    80103820 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103830:	84 d2                	test   %dl,%dl
80103832:	0f 85 f8 00 00 00    	jne    80103930 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103838:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010383e:	a3 9c 5c 11 80       	mov    %eax,0x80115c9c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103843:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103849:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
80103850:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103855:	03 55 e4             	add    -0x1c(%ebp),%edx
80103858:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010385b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010385f:	90                   	nop
80103860:	39 c2                	cmp    %eax,%edx
80103862:	76 15                	jbe    80103879 <mpinit+0x109>
    switch(*p){
80103864:	0f b6 08             	movzbl (%eax),%ecx
80103867:	80 f9 02             	cmp    $0x2,%cl
8010386a:	74 5c                	je     801038c8 <mpinit+0x158>
8010386c:	77 42                	ja     801038b0 <mpinit+0x140>
8010386e:	84 c9                	test   %cl,%cl
80103870:	74 6e                	je     801038e0 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103872:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103875:	39 c2                	cmp    %eax,%edx
80103877:	77 eb                	ja     80103864 <mpinit+0xf4>
80103879:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010387c:	85 db                	test   %ebx,%ebx
8010387e:	0f 84 b9 00 00 00    	je     8010393d <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103884:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103888:	74 15                	je     8010389f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010388a:	b8 70 00 00 00       	mov    $0x70,%eax
8010388f:	ba 22 00 00 00       	mov    $0x22,%edx
80103894:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103895:	ba 23 00 00 00       	mov    $0x23,%edx
8010389a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010389b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010389e:	ee                   	out    %al,(%dx)
  }
}
8010389f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038a2:	5b                   	pop    %ebx
801038a3:	5e                   	pop    %esi
801038a4:	5f                   	pop    %edi
801038a5:	5d                   	pop    %ebp
801038a6:	c3                   	ret    
801038a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ae:	66 90                	xchg   %ax,%ax
    switch(*p){
801038b0:	83 e9 03             	sub    $0x3,%ecx
801038b3:	80 f9 01             	cmp    $0x1,%cl
801038b6:	76 ba                	jbe    80103872 <mpinit+0x102>
801038b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801038bf:	eb 9f                	jmp    80103860 <mpinit+0xf0>
801038c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801038c8:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801038cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801038cf:	88 0d 80 5d 11 80    	mov    %cl,0x80115d80
      continue;
801038d5:	eb 89                	jmp    80103860 <mpinit+0xf0>
801038d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038de:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
801038e0:	8b 0d 40 63 11 80    	mov    0x80116340,%ecx
801038e6:	83 f9 07             	cmp    $0x7,%ecx
801038e9:	7f 19                	jg     80103904 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038eb:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
801038f1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801038f5:	83 c1 01             	add    $0x1,%ecx
801038f8:	89 0d 40 63 11 80    	mov    %ecx,0x80116340
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038fe:	88 9f a0 5d 11 80    	mov    %bl,-0x7feea260(%edi)
      p += sizeof(struct mpproc);
80103904:	83 c0 14             	add    $0x14,%eax
      continue;
80103907:	e9 54 ff ff ff       	jmp    80103860 <mpinit+0xf0>
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103910:	ba 00 00 01 00       	mov    $0x10000,%edx
80103915:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010391a:	e8 d1 fd ff ff       	call   801036f0 <mpsearch1>
8010391f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103921:	85 c0                	test   %eax,%eax
80103923:	0f 85 9b fe ff ff    	jne    801037c4 <mpinit+0x54>
80103929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103930:	83 ec 0c             	sub    $0xc,%esp
80103933:	68 62 a2 10 80       	push   $0x8010a262
80103938:	e8 53 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010393d:	83 ec 0c             	sub    $0xc,%esp
80103940:	68 7c a2 10 80       	push   $0x8010a27c
80103945:	e8 46 ca ff ff       	call   80100390 <panic>
8010394a:	66 90                	xchg   %ax,%ax
8010394c:	66 90                	xchg   %ax,%ax
8010394e:	66 90                	xchg   %ax,%ax

80103950 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103950:	f3 0f 1e fb          	endbr32 
80103954:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103959:	ba 21 00 00 00       	mov    $0x21,%edx
8010395e:	ee                   	out    %al,(%dx)
8010395f:	ba a1 00 00 00       	mov    $0xa1,%edx
80103964:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103965:	c3                   	ret    
80103966:	66 90                	xchg   %ax,%ax
80103968:	66 90                	xchg   %ax,%ax
8010396a:	66 90                	xchg   %ax,%ax
8010396c:	66 90                	xchg   %ax,%ax
8010396e:	66 90                	xchg   %ax,%ax

80103970 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103970:	f3 0f 1e fb          	endbr32 
80103974:	55                   	push   %ebp
80103975:	89 e5                	mov    %esp,%ebp
80103977:	57                   	push   %edi
80103978:	56                   	push   %esi
80103979:	53                   	push   %ebx
8010397a:	83 ec 0c             	sub    $0xc,%esp
8010397d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103980:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103983:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103989:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010398f:	e8 dc d9 ff ff       	call   80101370 <filealloc>
80103994:	89 03                	mov    %eax,(%ebx)
80103996:	85 c0                	test   %eax,%eax
80103998:	0f 84 ac 00 00 00    	je     80103a4a <pipealloc+0xda>
8010399e:	e8 cd d9 ff ff       	call   80101370 <filealloc>
801039a3:	89 06                	mov    %eax,(%esi)
801039a5:	85 c0                	test   %eax,%eax
801039a7:	0f 84 8b 00 00 00    	je     80103a38 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801039ad:	e8 ee f1 ff ff       	call   80102ba0 <kalloc>
801039b2:	89 c7                	mov    %eax,%edi
801039b4:	85 c0                	test   %eax,%eax
801039b6:	0f 84 b4 00 00 00    	je     80103a70 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
801039bc:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801039c3:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801039c6:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801039c9:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801039d0:	00 00 00 
  p->nwrite = 0;
801039d3:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801039da:	00 00 00 
  p->nread = 0;
801039dd:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801039e4:	00 00 00 
  initlock(&p->lock, "pipe");
801039e7:	68 9b a2 10 80       	push   $0x8010a29b
801039ec:	50                   	push   %eax
801039ed:	e8 2e 22 00 00       	call   80105c20 <initlock>
  (*f0)->type = FD_PIPE;
801039f2:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801039f4:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801039f7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801039fd:	8b 03                	mov    (%ebx),%eax
801039ff:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103a03:	8b 03                	mov    (%ebx),%eax
80103a05:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103a09:	8b 03                	mov    (%ebx),%eax
80103a0b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103a0e:	8b 06                	mov    (%esi),%eax
80103a10:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103a16:	8b 06                	mov    (%esi),%eax
80103a18:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103a1c:	8b 06                	mov    (%esi),%eax
80103a1e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103a22:	8b 06                	mov    (%esi),%eax
80103a24:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103a27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103a2a:	31 c0                	xor    %eax,%eax
}
80103a2c:	5b                   	pop    %ebx
80103a2d:	5e                   	pop    %esi
80103a2e:	5f                   	pop    %edi
80103a2f:	5d                   	pop    %ebp
80103a30:	c3                   	ret    
80103a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103a38:	8b 03                	mov    (%ebx),%eax
80103a3a:	85 c0                	test   %eax,%eax
80103a3c:	74 1e                	je     80103a5c <pipealloc+0xec>
    fileclose(*f0);
80103a3e:	83 ec 0c             	sub    $0xc,%esp
80103a41:	50                   	push   %eax
80103a42:	e8 e9 d9 ff ff       	call   80101430 <fileclose>
80103a47:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103a4a:	8b 06                	mov    (%esi),%eax
80103a4c:	85 c0                	test   %eax,%eax
80103a4e:	74 0c                	je     80103a5c <pipealloc+0xec>
    fileclose(*f1);
80103a50:	83 ec 0c             	sub    $0xc,%esp
80103a53:	50                   	push   %eax
80103a54:	e8 d7 d9 ff ff       	call   80101430 <fileclose>
80103a59:	83 c4 10             	add    $0x10,%esp
}
80103a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103a5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a64:	5b                   	pop    %ebx
80103a65:	5e                   	pop    %esi
80103a66:	5f                   	pop    %edi
80103a67:	5d                   	pop    %ebp
80103a68:	c3                   	ret    
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103a70:	8b 03                	mov    (%ebx),%eax
80103a72:	85 c0                	test   %eax,%eax
80103a74:	75 c8                	jne    80103a3e <pipealloc+0xce>
80103a76:	eb d2                	jmp    80103a4a <pipealloc+0xda>
80103a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a7f:	90                   	nop

80103a80 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103a80:	f3 0f 1e fb          	endbr32 
80103a84:	55                   	push   %ebp
80103a85:	89 e5                	mov    %esp,%ebp
80103a87:	56                   	push   %esi
80103a88:	53                   	push   %ebx
80103a89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103a8f:	83 ec 0c             	sub    $0xc,%esp
80103a92:	53                   	push   %ebx
80103a93:	e8 08 23 00 00       	call   80105da0 <acquire>
  if(writable){
80103a98:	83 c4 10             	add    $0x10,%esp
80103a9b:	85 f6                	test   %esi,%esi
80103a9d:	74 41                	je     80103ae0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a9f:	83 ec 0c             	sub    $0xc,%esp
80103aa2:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103aa8:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103aaf:	00 00 00 
    wakeup(&p->nread);
80103ab2:	50                   	push   %eax
80103ab3:	e8 88 0c 00 00       	call   80104740 <wakeup>
80103ab8:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103abb:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103ac1:	85 d2                	test   %edx,%edx
80103ac3:	75 0a                	jne    80103acf <pipeclose+0x4f>
80103ac5:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103acb:	85 c0                	test   %eax,%eax
80103acd:	74 31                	je     80103b00 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103acf:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103ad2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ad5:	5b                   	pop    %ebx
80103ad6:	5e                   	pop    %esi
80103ad7:	5d                   	pop    %ebp
    release(&p->lock);
80103ad8:	e9 83 23 00 00       	jmp    80105e60 <release>
80103add:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103ae0:	83 ec 0c             	sub    $0xc,%esp
80103ae3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103ae9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103af0:	00 00 00 
    wakeup(&p->nwrite);
80103af3:	50                   	push   %eax
80103af4:	e8 47 0c 00 00       	call   80104740 <wakeup>
80103af9:	83 c4 10             	add    $0x10,%esp
80103afc:	eb bd                	jmp    80103abb <pipeclose+0x3b>
80103afe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103b00:	83 ec 0c             	sub    $0xc,%esp
80103b03:	53                   	push   %ebx
80103b04:	e8 57 23 00 00       	call   80105e60 <release>
    kfree((char*)p);
80103b09:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103b0c:	83 c4 10             	add    $0x10,%esp
}
80103b0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b12:	5b                   	pop    %ebx
80103b13:	5e                   	pop    %esi
80103b14:	5d                   	pop    %ebp
    kfree((char*)p);
80103b15:	e9 c6 ee ff ff       	jmp    801029e0 <kfree>
80103b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b20 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103b20:	f3 0f 1e fb          	endbr32 
80103b24:	55                   	push   %ebp
80103b25:	89 e5                	mov    %esp,%ebp
80103b27:	57                   	push   %edi
80103b28:	56                   	push   %esi
80103b29:	53                   	push   %ebx
80103b2a:	83 ec 28             	sub    $0x28,%esp
80103b2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103b30:	53                   	push   %ebx
80103b31:	e8 6a 22 00 00       	call   80105da0 <acquire>
  for(i = 0; i < n; i++){
80103b36:	8b 45 10             	mov    0x10(%ebp),%eax
80103b39:	83 c4 10             	add    $0x10,%esp
80103b3c:	85 c0                	test   %eax,%eax
80103b3e:	0f 8e bc 00 00 00    	jle    80103c00 <pipewrite+0xe0>
80103b44:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b47:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103b4d:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103b53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b56:	03 45 10             	add    0x10(%ebp),%eax
80103b59:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b5c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b62:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b68:	89 ca                	mov    %ecx,%edx
80103b6a:	05 00 02 00 00       	add    $0x200,%eax
80103b6f:	39 c1                	cmp    %eax,%ecx
80103b71:	74 3b                	je     80103bae <pipewrite+0x8e>
80103b73:	eb 63                	jmp    80103bd8 <pipewrite+0xb8>
80103b75:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103b78:	e8 f3 03 00 00       	call   80103f70 <myproc>
80103b7d:	8b 48 24             	mov    0x24(%eax),%ecx
80103b80:	85 c9                	test   %ecx,%ecx
80103b82:	75 34                	jne    80103bb8 <pipewrite+0x98>
      wakeup(&p->nread);
80103b84:	83 ec 0c             	sub    $0xc,%esp
80103b87:	57                   	push   %edi
80103b88:	e8 b3 0b 00 00       	call   80104740 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b8d:	58                   	pop    %eax
80103b8e:	5a                   	pop    %edx
80103b8f:	53                   	push   %ebx
80103b90:	56                   	push   %esi
80103b91:	e8 ea 09 00 00       	call   80104580 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b96:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b9c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103ba2:	83 c4 10             	add    $0x10,%esp
80103ba5:	05 00 02 00 00       	add    $0x200,%eax
80103baa:	39 c2                	cmp    %eax,%edx
80103bac:	75 2a                	jne    80103bd8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103bae:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103bb4:	85 c0                	test   %eax,%eax
80103bb6:	75 c0                	jne    80103b78 <pipewrite+0x58>
        release(&p->lock);
80103bb8:	83 ec 0c             	sub    $0xc,%esp
80103bbb:	53                   	push   %ebx
80103bbc:	e8 9f 22 00 00       	call   80105e60 <release>
        return -1;
80103bc1:	83 c4 10             	add    $0x10,%esp
80103bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103bc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bcc:	5b                   	pop    %ebx
80103bcd:	5e                   	pop    %esi
80103bce:	5f                   	pop    %edi
80103bcf:	5d                   	pop    %ebp
80103bd0:	c3                   	ret    
80103bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103bd8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103bdb:	8d 4a 01             	lea    0x1(%edx),%ecx
80103bde:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103be4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103bea:	0f b6 06             	movzbl (%esi),%eax
80103bed:	83 c6 01             	add    $0x1,%esi
80103bf0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103bf3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103bf7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103bfa:	0f 85 5c ff ff ff    	jne    80103b5c <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103c09:	50                   	push   %eax
80103c0a:	e8 31 0b 00 00       	call   80104740 <wakeup>
  release(&p->lock);
80103c0f:	89 1c 24             	mov    %ebx,(%esp)
80103c12:	e8 49 22 00 00       	call   80105e60 <release>
  return n;
80103c17:	8b 45 10             	mov    0x10(%ebp),%eax
80103c1a:	83 c4 10             	add    $0x10,%esp
80103c1d:	eb aa                	jmp    80103bc9 <pipewrite+0xa9>
80103c1f:	90                   	nop

80103c20 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103c20:	f3 0f 1e fb          	endbr32 
80103c24:	55                   	push   %ebp
80103c25:	89 e5                	mov    %esp,%ebp
80103c27:	57                   	push   %edi
80103c28:	56                   	push   %esi
80103c29:	53                   	push   %ebx
80103c2a:	83 ec 18             	sub    $0x18,%esp
80103c2d:	8b 75 08             	mov    0x8(%ebp),%esi
80103c30:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103c33:	56                   	push   %esi
80103c34:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103c3a:	e8 61 21 00 00       	call   80105da0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c3f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c45:	83 c4 10             	add    $0x10,%esp
80103c48:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103c4e:	74 33                	je     80103c83 <piperead+0x63>
80103c50:	eb 3b                	jmp    80103c8d <piperead+0x6d>
80103c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103c58:	e8 13 03 00 00       	call   80103f70 <myproc>
80103c5d:	8b 48 24             	mov    0x24(%eax),%ecx
80103c60:	85 c9                	test   %ecx,%ecx
80103c62:	0f 85 88 00 00 00    	jne    80103cf0 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103c68:	83 ec 08             	sub    $0x8,%esp
80103c6b:	56                   	push   %esi
80103c6c:	53                   	push   %ebx
80103c6d:	e8 0e 09 00 00       	call   80104580 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c72:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103c78:	83 c4 10             	add    $0x10,%esp
80103c7b:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103c81:	75 0a                	jne    80103c8d <piperead+0x6d>
80103c83:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103c89:	85 c0                	test   %eax,%eax
80103c8b:	75 cb                	jne    80103c58 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c8d:	8b 55 10             	mov    0x10(%ebp),%edx
80103c90:	31 db                	xor    %ebx,%ebx
80103c92:	85 d2                	test   %edx,%edx
80103c94:	7f 28                	jg     80103cbe <piperead+0x9e>
80103c96:	eb 34                	jmp    80103ccc <piperead+0xac>
80103c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103ca0:	8d 48 01             	lea    0x1(%eax),%ecx
80103ca3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103ca8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103cae:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103cb3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103cb6:	83 c3 01             	add    $0x1,%ebx
80103cb9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103cbc:	74 0e                	je     80103ccc <piperead+0xac>
    if(p->nread == p->nwrite)
80103cbe:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103cc4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103cca:	75 d4                	jne    80103ca0 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103ccc:	83 ec 0c             	sub    $0xc,%esp
80103ccf:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103cd5:	50                   	push   %eax
80103cd6:	e8 65 0a 00 00       	call   80104740 <wakeup>
  release(&p->lock);
80103cdb:	89 34 24             	mov    %esi,(%esp)
80103cde:	e8 7d 21 00 00       	call   80105e60 <release>
  return i;
80103ce3:	83 c4 10             	add    $0x10,%esp
}
80103ce6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ce9:	89 d8                	mov    %ebx,%eax
80103ceb:	5b                   	pop    %ebx
80103cec:	5e                   	pop    %esi
80103ced:	5f                   	pop    %edi
80103cee:	5d                   	pop    %ebp
80103cef:	c3                   	ret    
      release(&p->lock);
80103cf0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103cf3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103cf8:	56                   	push   %esi
80103cf9:	e8 62 21 00 00       	call   80105e60 <release>
      return -1;
80103cfe:	83 c4 10             	add    $0x10,%esp
}
80103d01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d04:	89 d8                	mov    %ebx,%eax
80103d06:	5b                   	pop    %ebx
80103d07:	5e                   	pop    %esi
80103d08:	5f                   	pop    %edi
80103d09:	5d                   	pop    %ebp
80103d0a:	c3                   	ret    
80103d0b:	66 90                	xchg   %ax,%ax
80103d0d:	66 90                	xchg   %ax,%ax
80103d0f:	90                   	nop

80103d10 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d14:	bb 94 63 11 80       	mov    $0x80116394,%ebx
{
80103d19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103d1c:	68 60 63 11 80       	push   $0x80116360
80103d21:	e8 7a 20 00 00       	call   80105da0 <acquire>
80103d26:	83 c4 10             	add    $0x10,%esp
80103d29:	eb 17                	jmp    80103d42 <allocproc+0x32>
80103d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d2f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d30:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
80103d36:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
80103d3c:	0f 84 fe 00 00 00    	je     80103e40 <allocproc+0x130>
    if(p->state == UNUSED)
80103d42:	8b 43 0c             	mov    0xc(%ebx),%eax
80103d45:	85 c0                	test   %eax,%eax
80103d47:	75 e7                	jne    80103d30 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103d49:	a1 04 d0 10 80       	mov    0x8010d004,%eax

  release(&ptable.lock);
80103d4e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103d51:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103d58:	89 43 10             	mov    %eax,0x10(%ebx)
80103d5b:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103d5e:	68 60 63 11 80       	push   $0x80116360
  p->pid = nextpid++;
80103d63:	89 15 04 d0 10 80    	mov    %edx,0x8010d004
  release(&ptable.lock);
80103d69:	e8 f2 20 00 00       	call   80105e60 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d6e:	e8 2d ee ff ff       	call   80102ba0 <kalloc>
80103d73:	83 c4 10             	add    $0x10,%esp
80103d76:	89 43 08             	mov    %eax,0x8(%ebx)
80103d79:	85 c0                	test   %eax,%eax
80103d7b:	0f 84 d8 00 00 00    	je     80103e59 <allocproc+0x149>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103d81:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103d87:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d8a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d8f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103d92:	c7 40 14 ef 76 10 80 	movl   $0x801076ef,0x14(%eax)
  p->context = (struct context*)sp;
80103d99:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d9c:	6a 14                	push   $0x14
80103d9e:	6a 00                	push   $0x0
80103da0:	50                   	push   %eax
80103da1:	e8 0a 21 00 00       	call   80105eb0 <memset>
  p->context->eip = (uint)forkret;
80103da6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103da9:	83 c4 10             	add    $0x10,%esp
  p->sched_info.bjf.arrival_time = ticks;
  p->sched_info.queue = UNSET;
  p->sched_info.bjf.priority = 3;
  p->sched_info.bjf.priority_ratio = 1;
80103dac:	d9 e8                	fld1   
  p->context->eip = (uint)forkret;
80103dae:	c7 40 10 70 3e 10 80 	movl   $0x80103e70,0x10(%eax)
  p->sched_info.bjf.arrival_time = ticks;
80103db5:	a1 e0 d6 12 80       	mov    0x8012d6e0,%eax
  p->sched_info.bjf.priority_ratio = 1;
80103dba:	d9 93 8c 00 00 00    	fsts   0x8c(%ebx)
  p->sched_info.bjf.arrival_time_ratio = 1;
  p->sched_info.bjf.executed_cycle = 0;
  p->sched_info.bjf.executed_cycle_ratio = 1;
  p->sched_info.bjf.process_size = p->sz;
80103dc0:	8b 13                	mov    (%ebx),%edx
  p->sched_info.bjf.arrival_time_ratio = 1;
80103dc2:	d9 93 94 00 00 00    	fsts   0x94(%ebx)
  p->sched_info.queue = UNSET;
80103dc8:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103dcf:	00 00 00 
  p->sched_info.bjf.priority = 3;
80103dd2:	c7 83 88 00 00 00 03 	movl   $0x3,0x88(%ebx)
80103dd9:	00 00 00 
  p->sched_info.bjf.executed_cycle = 0;
80103ddc:	c7 83 98 00 00 00 00 	movl   $0x0,0x98(%ebx)
80103de3:	00 00 00 
  p->sched_info.bjf.executed_cycle_ratio = 1;
80103de6:	d9 93 9c 00 00 00    	fsts   0x9c(%ebx)
  p->sched_info.bjf.arrival_time = ticks;
80103dec:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  p->sched_info.bjf.process_size = p->sz;
80103df2:	89 93 a0 00 00 00    	mov    %edx,0xa0(%ebx)
  p->sched_info.bjf.process_size_ratio = 1;
80103df8:	8d 93 ac 05 00 00    	lea    0x5ac(%ebx),%edx
  p->start_time = ticks;
80103dfe:	89 43 7c             	mov    %eax,0x7c(%ebx)
80103e01:	8d 83 ac 00 00 00    	lea    0xac(%ebx),%eax
  p->sched_info.bjf.process_size_ratio = 1;
80103e07:	d9 9b a4 00 00 00    	fstps  0xa4(%ebx)


  for(int i = 0; i < SHAREDREGIONS; i++) {
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
    // default values
    p->pages[i].key = -1;
80103e10:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    p->pages[i].shmid = -1;
80103e16:	83 c0 14             	add    $0x14,%eax
80103e19:	c7 40 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%eax)
    p->pages[i].size  = 0;
80103e20:	c7 40 f0 00 00 00 00 	movl   $0x0,-0x10(%eax)
    p->pages[i].perm = PTE_W | PTE_U;
80103e27:	c7 40 f8 06 00 00 00 	movl   $0x6,-0x8(%eax)
    p->pages[i].virtualAddr = (void *)0;
80103e2e:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(int i = 0; i < SHAREDREGIONS; i++) {
80103e35:	39 d0                	cmp    %edx,%eax
80103e37:	75 d7                	jne    80103e10 <allocproc+0x100>




  return p;
}
80103e39:	89 d8                	mov    %ebx,%eax
80103e3b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e3e:	c9                   	leave  
80103e3f:	c3                   	ret    
  release(&ptable.lock);
80103e40:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103e43:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103e45:	68 60 63 11 80       	push   $0x80116360
80103e4a:	e8 11 20 00 00       	call   80105e60 <release>
}
80103e4f:	89 d8                	mov    %ebx,%eax
  return 0;
80103e51:	83 c4 10             	add    $0x10,%esp
}
80103e54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e57:	c9                   	leave  
80103e58:	c3                   	ret    
    p->state = UNUSED;
80103e59:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103e60:	31 db                	xor    %ebx,%ebx
}
80103e62:	89 d8                	mov    %ebx,%eax
80103e64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e67:	c9                   	leave  
80103e68:	c3                   	ret    
80103e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e70 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103e70:	f3 0f 1e fb          	endbr32 
80103e74:	55                   	push   %ebp
80103e75:	89 e5                	mov    %esp,%ebp
80103e77:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103e7a:	68 60 63 11 80       	push   $0x80116360
80103e7f:	e8 dc 1f 00 00       	call   80105e60 <release>

  if (first) {
80103e84:	a1 00 d0 10 80       	mov    0x8010d000,%eax
80103e89:	83 c4 10             	add    $0x10,%esp
80103e8c:	85 c0                	test   %eax,%eax
80103e8e:	75 08                	jne    80103e98 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103e90:	c9                   	leave  
80103e91:	c3                   	ret    
80103e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103e98:	c7 05 00 d0 10 80 00 	movl   $0x0,0x8010d000
80103e9f:	00 00 00 
    iinit(ROOTDEV);
80103ea2:	83 ec 0c             	sub    $0xc,%esp
80103ea5:	6a 01                	push   $0x1
80103ea7:	e8 04 dc ff ff       	call   80101ab0 <iinit>
    initlog(ROOTDEV);
80103eac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103eb3:	e8 48 f3 ff ff       	call   80103200 <initlog>
}
80103eb8:	83 c4 10             	add    $0x10,%esp
80103ebb:	c9                   	leave  
80103ebc:	c3                   	ret    
80103ebd:	8d 76 00             	lea    0x0(%esi),%esi

80103ec0 <pinit>:
{
80103ec0:	f3 0f 1e fb          	endbr32 
80103ec4:	55                   	push   %ebp
80103ec5:	89 e5                	mov    %esp,%ebp
80103ec7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103eca:	68 a0 a2 10 80       	push   $0x8010a2a0
80103ecf:	68 60 63 11 80       	push   $0x80116360
80103ed4:	e8 47 1d 00 00       	call   80105c20 <initlock>
}
80103ed9:	83 c4 10             	add    $0x10,%esp
80103edc:	c9                   	leave  
80103edd:	c3                   	ret    
80103ede:	66 90                	xchg   %ax,%ax

80103ee0 <mycpu>:
{
80103ee0:	f3 0f 1e fb          	endbr32 
80103ee4:	55                   	push   %ebp
80103ee5:	89 e5                	mov    %esp,%ebp
80103ee7:	56                   	push   %esi
80103ee8:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ee9:	9c                   	pushf  
80103eea:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103eeb:	f6 c4 02             	test   $0x2,%ah
80103eee:	75 4a                	jne    80103f3a <mycpu+0x5a>
  apicid = lapicid();
80103ef0:	e8 1b ef ff ff       	call   80102e10 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103ef5:	8b 35 40 63 11 80    	mov    0x80116340,%esi
  apicid = lapicid();
80103efb:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103efd:	85 f6                	test   %esi,%esi
80103eff:	7e 2c                	jle    80103f2d <mycpu+0x4d>
80103f01:	31 d2                	xor    %edx,%edx
80103f03:	eb 0a                	jmp    80103f0f <mycpu+0x2f>
80103f05:	8d 76 00             	lea    0x0(%esi),%esi
80103f08:	83 c2 01             	add    $0x1,%edx
80103f0b:	39 f2                	cmp    %esi,%edx
80103f0d:	74 1e                	je     80103f2d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103f0f:	69 ca b4 00 00 00    	imul   $0xb4,%edx,%ecx
80103f15:	0f b6 81 a0 5d 11 80 	movzbl -0x7feea260(%ecx),%eax
80103f1c:	39 d8                	cmp    %ebx,%eax
80103f1e:	75 e8                	jne    80103f08 <mycpu+0x28>
}
80103f20:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103f23:	8d 81 a0 5d 11 80    	lea    -0x7feea260(%ecx),%eax
}
80103f29:	5b                   	pop    %ebx
80103f2a:	5e                   	pop    %esi
80103f2b:	5d                   	pop    %ebp
80103f2c:	c3                   	ret    
  panic("unknown apicid\n");
80103f2d:	83 ec 0c             	sub    $0xc,%esp
80103f30:	68 a7 a2 10 80       	push   $0x8010a2a7
80103f35:	e8 56 c4 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f3a:	83 ec 0c             	sub    $0xc,%esp
80103f3d:	68 00 a4 10 80       	push   $0x8010a400
80103f42:	e8 49 c4 ff ff       	call   80100390 <panic>
80103f47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f4e:	66 90                	xchg   %ax,%ax

80103f50 <cpuid>:
cpuid() {
80103f50:	f3 0f 1e fb          	endbr32 
80103f54:	55                   	push   %ebp
80103f55:	89 e5                	mov    %esp,%ebp
80103f57:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103f5a:	e8 81 ff ff ff       	call   80103ee0 <mycpu>
}
80103f5f:	c9                   	leave  
  return mycpu()-cpus;
80103f60:	2d a0 5d 11 80       	sub    $0x80115da0,%eax
80103f65:	c1 f8 02             	sar    $0x2,%eax
80103f68:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
80103f6e:	c3                   	ret    
80103f6f:	90                   	nop

80103f70 <myproc>:
myproc(void) {
80103f70:	f3 0f 1e fb          	endbr32 
80103f74:	55                   	push   %ebp
80103f75:	89 e5                	mov    %esp,%ebp
80103f77:	53                   	push   %ebx
80103f78:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f7b:	e8 20 1d 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80103f80:	e8 5b ff ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80103f85:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f8b:	e8 60 1d 00 00       	call   80105cf0 <popcli>
}
80103f90:	83 c4 04             	add    $0x4,%esp
80103f93:	89 d8                	mov    %ebx,%eax
80103f95:	5b                   	pop    %ebx
80103f96:	5d                   	pop    %ebp
80103f97:	c3                   	ret    
80103f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f9f:	90                   	nop

80103fa0 <growproc>:
{
80103fa0:	f3 0f 1e fb          	endbr32 
80103fa4:	55                   	push   %ebp
80103fa5:	89 e5                	mov    %esp,%ebp
80103fa7:	56                   	push   %esi
80103fa8:	53                   	push   %ebx
80103fa9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103fac:	e8 ef 1c 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80103fb1:	e8 2a ff ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80103fb6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbc:	e8 2f 1d 00 00       	call   80105cf0 <popcli>
  sz = curproc->sz;
80103fc1:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103fc3:	85 f6                	test   %esi,%esi
80103fc5:	7f 19                	jg     80103fe0 <growproc+0x40>
  } else if(n < 0){
80103fc7:	75 37                	jne    80104000 <growproc+0x60>
  switchuvm(curproc);
80103fc9:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103fcc:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103fce:	53                   	push   %ebx
80103fcf:	e8 6c 49 00 00       	call   80108940 <switchuvm>
  return 0;
80103fd4:	83 c4 10             	add    $0x10,%esp
80103fd7:	31 c0                	xor    %eax,%eax
}
80103fd9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fdc:	5b                   	pop    %ebx
80103fdd:	5e                   	pop    %esi
80103fde:	5d                   	pop    %ebp
80103fdf:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103fe0:	83 ec 04             	sub    $0x4,%esp
80103fe3:	01 c6                	add    %eax,%esi
80103fe5:	56                   	push   %esi
80103fe6:	50                   	push   %eax
80103fe7:	ff 73 04             	pushl  0x4(%ebx)
80103fea:	e8 b1 4b 00 00       	call   80108ba0 <allocuvm>
80103fef:	83 c4 10             	add    $0x10,%esp
80103ff2:	85 c0                	test   %eax,%eax
80103ff4:	75 d3                	jne    80103fc9 <growproc+0x29>
      return -1;
80103ff6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ffb:	eb dc                	jmp    80103fd9 <growproc+0x39>
80103ffd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104000:	83 ec 04             	sub    $0x4,%esp
80104003:	01 c6                	add    %eax,%esi
80104005:	56                   	push   %esi
80104006:	50                   	push   %eax
80104007:	ff 73 04             	pushl  0x4(%ebx)
8010400a:	e8 c1 4c 00 00       	call   80108cd0 <deallocuvm>
8010400f:	83 c4 10             	add    $0x10,%esp
80104012:	85 c0                	test   %eax,%eax
80104014:	75 b3                	jne    80103fc9 <growproc+0x29>
80104016:	eb de                	jmp    80103ff6 <growproc+0x56>
80104018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010401f:	90                   	nop

80104020 <bjfrank>:
{
80104020:	f3 0f 1e fb          	endbr32 
80104024:	55                   	push   %ebp
80104025:	89 e5                	mov    %esp,%ebp
80104027:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010402a:	5d                   	pop    %ebp
  return p->sched_info.bjf.priority * p->sched_info.bjf.priority_ratio +
8010402b:	db 80 88 00 00 00    	fildl  0x88(%eax)
80104031:	d8 88 8c 00 00 00    	fmuls  0x8c(%eax)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
80104037:	db 80 90 00 00 00    	fildl  0x90(%eax)
8010403d:	d8 88 94 00 00 00    	fmuls  0x94(%eax)
  return p->sched_info.bjf.priority * p->sched_info.bjf.priority_ratio +
80104043:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
80104045:	d9 80 98 00 00 00    	flds   0x98(%eax)
8010404b:	d8 88 9c 00 00 00    	fmuls  0x9c(%eax)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
80104051:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.process_size * p->sched_info.bjf.process_size_ratio;
80104053:	db 80 a0 00 00 00    	fildl  0xa0(%eax)
80104059:	d8 88 a4 00 00 00    	fmuls  0xa4(%eax)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
8010405f:	de c1                	faddp  %st,%st(1)
}
80104061:	c3                   	ret    
80104062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104070 <lcfs>:
{
80104070:	f3 0f 1e fb          	endbr32 
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104074:	b8 94 63 11 80       	mov    $0x80116394,%eax
  struct proc *result = 0;
80104079:	31 d2                	xor    %edx,%edx
8010407b:	eb 1f                	jmp    8010409c <lcfs+0x2c>
8010407d:	8d 76 00             	lea    0x0(%esi),%esi
      if (result->sched_info.arrival_queue_time < p->sched_info.arrival_queue_time)
80104080:	8b 88 a8 00 00 00    	mov    0xa8(%eax),%ecx
80104086:	39 8a a8 00 00 00    	cmp    %ecx,0xa8(%edx)
8010408c:	0f 4c d0             	cmovl  %eax,%edx
8010408f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104090:	05 ac 05 00 00       	add    $0x5ac,%eax
80104095:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010409a:	74 21                	je     801040bd <lcfs+0x4d>
    if (p->state != RUNNABLE || p->sched_info.queue != LCFS)
8010409c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801040a0:	75 ee                	jne    80104090 <lcfs+0x20>
801040a2:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
801040a9:	75 e5                	jne    80104090 <lcfs+0x20>
    if (result != 0)
801040ab:	85 d2                	test   %edx,%edx
801040ad:	75 d1                	jne    80104080 <lcfs+0x10>
801040af:	89 c2                	mov    %eax,%edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040b1:	05 ac 05 00 00       	add    $0x5ac,%eax
801040b6:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801040bb:	75 df                	jne    8010409c <lcfs+0x2c>
}
801040bd:	89 d0                	mov    %edx,%eax
801040bf:	c3                   	ret    

801040c0 <bestjobfirst>:
{
801040c0:	f3 0f 1e fb          	endbr32 
  float min_rank = 2e6;
801040c4:	d9 05 bc a5 10 80    	flds   0x8010a5bc
  struct proc *min_p = 0;
801040ca:	31 d2                	xor    %edx,%edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040cc:	b8 94 63 11 80       	mov    $0x80116394,%eax
801040d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (p->state != RUNNABLE || p->sched_info.queue != BJF)
801040d8:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801040dc:	75 5a                	jne    80104138 <bestjobfirst+0x78>
801040de:	83 b8 80 00 00 00 03 	cmpl   $0x3,0x80(%eax)
801040e5:	75 51                	jne    80104138 <bestjobfirst+0x78>
  return p->sched_info.bjf.priority * p->sched_info.bjf.priority_ratio +
801040e7:	db 80 88 00 00 00    	fildl  0x88(%eax)
801040ed:	d8 88 8c 00 00 00    	fmuls  0x8c(%eax)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
801040f3:	db 80 90 00 00 00    	fildl  0x90(%eax)
801040f9:	d8 88 94 00 00 00    	fmuls  0x94(%eax)
  return p->sched_info.bjf.priority * p->sched_info.bjf.priority_ratio +
801040ff:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
80104101:	d9 80 98 00 00 00    	flds   0x98(%eax)
80104107:	d8 88 9c 00 00 00    	fmuls  0x9c(%eax)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
8010410d:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.process_size * p->sched_info.bjf.process_size_ratio;
8010410f:	db 80 a0 00 00 00    	fildl  0xa0(%eax)
80104115:	d8 88 a4 00 00 00    	fmuls  0xa4(%eax)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
8010411b:	de c1                	faddp  %st,%st(1)
8010411d:	d9 c9                	fxch   %st(1)
    if (p_rank < min_rank)
8010411f:	db f1                	fcomi  %st(1),%st
80104121:	76 0d                	jbe    80104130 <bestjobfirst+0x70>
80104123:	dd d8                	fstp   %st(0)
80104125:	89 c2                	mov    %eax,%edx
80104127:	eb 0f                	jmp    80104138 <bestjobfirst+0x78>
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104130:	dd d9                	fstp   %st(1)
80104132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104138:	05 ac 05 00 00       	add    $0x5ac,%eax
8010413d:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
80104142:	75 94                	jne    801040d8 <bestjobfirst+0x18>
80104144:	dd d8                	fstp   %st(0)
}
80104146:	89 d0                	mov    %edx,%eax
80104148:	c3                   	ret    
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104150 <scheduler>:
{
80104150:	f3 0f 1e fb          	endbr32 
80104154:	55                   	push   %ebp
80104155:	89 e5                	mov    %esp,%ebp
80104157:	57                   	push   %edi
      p = ptable.proc;
80104158:	bf 94 63 11 80       	mov    $0x80116394,%edi
{
8010415d:	56                   	push   %esi
  struct proc *last_scheduled_RR = &ptable.proc[NPROC - 1];
8010415e:	be e8 c8 12 80       	mov    $0x8012c8e8,%esi
{
80104163:	53                   	push   %ebx
80104164:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80104167:	e8 74 fd ff ff       	call   80103ee0 <mycpu>
  c->proc = 0;
8010416c:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104173:	00 00 00 
  struct cpu *c = mycpu();
80104176:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c->proc = 0;
80104179:	83 c0 04             	add    $0x4,%eax
8010417c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010417f:	90                   	nop
  asm volatile("sti");
80104180:	fb                   	sti    
    acquire(&ptable.lock);
80104181:	83 ec 0c             	sub    $0xc,%esp
80104184:	89 f3                	mov    %esi,%ebx
80104186:	68 60 63 11 80       	push   $0x80116360
8010418b:	e8 10 1c 00 00       	call   80105da0 <acquire>
80104190:	83 c4 10             	add    $0x10,%esp
80104193:	eb 0b                	jmp    801041a0 <scheduler+0x50>
80104195:	8d 76 00             	lea    0x0(%esi),%esi
    if (p == last_scheduled)
80104198:	39 de                	cmp    %ebx,%esi
8010419a:	0f 84 90 00 00 00    	je     80104230 <scheduler+0xe0>
    p++;
801041a0:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
      p = ptable.proc;
801041a6:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
801041ac:	0f 43 df             	cmovae %edi,%ebx
    if (p->state == RUNNABLE && p->sched_info.queue == ROUND_ROBIN)
801041af:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801041b3:	75 e3                	jne    80104198 <scheduler+0x48>
801041b5:	83 bb 80 00 00 00 01 	cmpl   $0x1,0x80(%ebx)
801041bc:	75 da                	jne    80104198 <scheduler+0x48>
801041be:	89 de                	mov    %ebx,%esi
    c->proc = p;
801041c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    switchuvm(p);
801041c3:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
801041c6:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
    switchuvm(p);
801041cc:	53                   	push   %ebx
801041cd:	e8 6e 47 00 00       	call   80108940 <switchuvm>
    p->sched_info.bjf.executed_cycle += 0.1f;
801041d2:	d9 05 c0 a5 10 80    	flds   0x8010a5c0
801041d8:	d8 83 98 00 00 00    	fadds  0x98(%ebx)
    p->state = RUNNING;
801041de:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    p->sched_info.last_run = ticks;
801041e5:	a1 e0 d6 12 80       	mov    0x8012d6e0,%eax
801041ea:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
    p->sched_info.bjf.executed_cycle += 0.1f;
801041f0:	d9 9b 98 00 00 00    	fstps  0x98(%ebx)
    swtch(&(c->scheduler), p->context);
801041f6:	58                   	pop    %eax
801041f7:	5a                   	pop    %edx
801041f8:	ff 73 1c             	pushl  0x1c(%ebx)
801041fb:	ff 75 e0             	pushl  -0x20(%ebp)
801041fe:	e8 d0 1e 00 00       	call   801060d3 <swtch>
    switchkvm();
80104203:	e8 18 47 00 00       	call   80108920 <switchkvm>
    c->proc = 0;
80104208:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010420b:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104212:	00 00 00 
  release(&ptable.lock);
80104215:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
8010421c:	e8 3f 1c 00 00       	call   80105e60 <release>
80104221:	83 c4 10             	add    $0x10,%esp
80104224:	e9 57 ff ff ff       	jmp    80104180 <scheduler+0x30>
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *result = 0;
80104230:	31 db                	xor    %ebx,%ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104232:	b8 94 63 11 80       	mov    $0x80116394,%eax
80104237:	eb 23                	jmp    8010425c <scheduler+0x10c>
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if (result->sched_info.arrival_queue_time < p->sched_info.arrival_queue_time)
80104240:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
80104246:	39 93 a8 00 00 00    	cmp    %edx,0xa8(%ebx)
8010424c:	0f 4c d8             	cmovl  %eax,%ebx
8010424f:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104250:	05 ac 05 00 00       	add    $0x5ac,%eax
80104255:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010425a:	74 24                	je     80104280 <scheduler+0x130>
    if (p->state != RUNNABLE || p->sched_info.queue != LCFS)
8010425c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104260:	75 ee                	jne    80104250 <scheduler+0x100>
80104262:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
80104269:	75 e5                	jne    80104250 <scheduler+0x100>
    if (result != 0)
8010426b:	85 db                	test   %ebx,%ebx
8010426d:	75 d1                	jne    80104240 <scheduler+0xf0>
8010426f:	89 c3                	mov    %eax,%ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104271:	05 ac 05 00 00       	add    $0x5ac,%eax
80104276:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010427b:	75 df                	jne    8010425c <scheduler+0x10c>
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
      if (!p)
80104280:	85 db                	test   %ebx,%ebx
80104282:	0f 85 38 ff ff ff    	jne    801041c0 <scheduler+0x70>
        p = bestjobfirst();
80104288:	e8 33 fe ff ff       	call   801040c0 <bestjobfirst>
8010428d:	89 c3                	mov    %eax,%ebx
        if (!p)
8010428f:	85 c0                	test   %eax,%eax
80104291:	0f 85 29 ff ff ff    	jne    801041c0 <scheduler+0x70>
          release(&ptable.lock);
80104297:	83 ec 0c             	sub    $0xc,%esp
8010429a:	68 60 63 11 80       	push   $0x80116360
8010429f:	e8 bc 1b 00 00       	call   80105e60 <release>
          continue;
801042a4:	83 c4 10             	add    $0x10,%esp
801042a7:	e9 d4 fe ff ff       	jmp    80104180 <scheduler+0x30>
801042ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042b0 <roundrobin>:
{
801042b0:	f3 0f 1e fb          	endbr32 
801042b4:	55                   	push   %ebp
      p = ptable.proc;
801042b5:	b9 94 63 11 80       	mov    $0x80116394,%ecx
{
801042ba:	89 e5                	mov    %esp,%ebp
801042bc:	8b 55 08             	mov    0x8(%ebp),%edx
  struct proc *p = last_scheduled;
801042bf:	89 d0                	mov    %edx,%eax
801042c1:	eb 09                	jmp    801042cc <roundrobin+0x1c>
801042c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042c7:	90                   	nop
    if (p == last_scheduled)
801042c8:	39 d0                	cmp    %edx,%eax
801042ca:	74 24                	je     801042f0 <roundrobin+0x40>
    p++;
801042cc:	05 ac 05 00 00       	add    $0x5ac,%eax
      p = ptable.proc;
801042d1:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801042d6:	0f 43 c1             	cmovae %ecx,%eax
    if (p->state == RUNNABLE && p->sched_info.queue == ROUND_ROBIN)
801042d9:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801042dd:	75 e9                	jne    801042c8 <roundrobin+0x18>
801042df:	83 b8 80 00 00 00 01 	cmpl   $0x1,0x80(%eax)
801042e6:	75 e0                	jne    801042c8 <roundrobin+0x18>
}
801042e8:	5d                   	pop    %ebp
801042e9:	c3                   	ret    
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return 0;
801042f0:	31 c0                	xor    %eax,%eax
}
801042f2:	5d                   	pop    %ebp
801042f3:	c3                   	ret    
801042f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042ff:	90                   	nop

80104300 <sched>:
{
80104300:	f3 0f 1e fb          	endbr32 
80104304:	55                   	push   %ebp
80104305:	89 e5                	mov    %esp,%ebp
80104307:	56                   	push   %esi
80104308:	53                   	push   %ebx
  pushcli();
80104309:	e8 92 19 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
8010430e:	e8 cd fb ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80104313:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104319:	e8 d2 19 00 00       	call   80105cf0 <popcli>
  if(!holding(&ptable.lock))
8010431e:	83 ec 0c             	sub    $0xc,%esp
80104321:	68 60 63 11 80       	push   $0x80116360
80104326:	e8 25 1a 00 00       	call   80105d50 <holding>
8010432b:	83 c4 10             	add    $0x10,%esp
8010432e:	85 c0                	test   %eax,%eax
80104330:	74 4f                	je     80104381 <sched+0x81>
  if(mycpu()->ncli != 1)
80104332:	e8 a9 fb ff ff       	call   80103ee0 <mycpu>
80104337:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010433e:	75 68                	jne    801043a8 <sched+0xa8>
  if(p->state == RUNNING)
80104340:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104344:	74 55                	je     8010439b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104346:	9c                   	pushf  
80104347:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104348:	f6 c4 02             	test   $0x2,%ah
8010434b:	75 41                	jne    8010438e <sched+0x8e>
  intena = mycpu()->intena;
8010434d:	e8 8e fb ff ff       	call   80103ee0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104352:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104355:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010435b:	e8 80 fb ff ff       	call   80103ee0 <mycpu>
80104360:	83 ec 08             	sub    $0x8,%esp
80104363:	ff 70 04             	pushl  0x4(%eax)
80104366:	53                   	push   %ebx
80104367:	e8 67 1d 00 00       	call   801060d3 <swtch>
  mycpu()->intena = intena;
8010436c:	e8 6f fb ff ff       	call   80103ee0 <mycpu>
}
80104371:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104374:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010437a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010437d:	5b                   	pop    %ebx
8010437e:	5e                   	pop    %esi
8010437f:	5d                   	pop    %ebp
80104380:	c3                   	ret    
    panic("sched ptable.lock");
80104381:	83 ec 0c             	sub    $0xc,%esp
80104384:	68 b7 a2 10 80       	push   $0x8010a2b7
80104389:	e8 02 c0 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010438e:	83 ec 0c             	sub    $0xc,%esp
80104391:	68 e3 a2 10 80       	push   $0x8010a2e3
80104396:	e8 f5 bf ff ff       	call   80100390 <panic>
    panic("sched running");
8010439b:	83 ec 0c             	sub    $0xc,%esp
8010439e:	68 d5 a2 10 80       	push   $0x8010a2d5
801043a3:	e8 e8 bf ff ff       	call   80100390 <panic>
    panic("sched locks");
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	68 c9 a2 10 80       	push   $0x8010a2c9
801043b0:	e8 db bf ff ff       	call   80100390 <panic>
801043b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043c0 <exit>:
{
801043c0:	f3 0f 1e fb          	endbr32 
801043c4:	55                   	push   %ebp
801043c5:	89 e5                	mov    %esp,%ebp
801043c7:	57                   	push   %edi
801043c8:	56                   	push   %esi
801043c9:	53                   	push   %ebx
801043ca:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801043cd:	e8 ce 18 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
801043d2:	e8 09 fb ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
801043d7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043dd:	e8 0e 19 00 00       	call   80105cf0 <popcli>
  if(curproc == initproc)
801043e2:	8d 5e 28             	lea    0x28(%esi),%ebx
801043e5:	8d 7e 68             	lea    0x68(%esi),%edi
801043e8:	39 35 1c d6 10 80    	cmp    %esi,0x8010d61c
801043ee:	0f 84 2d 01 00 00    	je     80104521 <exit+0x161>
801043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
801043f8:	8b 03                	mov    (%ebx),%eax
801043fa:	85 c0                	test   %eax,%eax
801043fc:	74 12                	je     80104410 <exit+0x50>
      fileclose(curproc->ofile[fd]);
801043fe:	83 ec 0c             	sub    $0xc,%esp
80104401:	50                   	push   %eax
80104402:	e8 29 d0 ff ff       	call   80101430 <fileclose>
      curproc->ofile[fd] = 0;
80104407:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010440d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104410:	83 c3 04             	add    $0x4,%ebx
80104413:	39 df                	cmp    %ebx,%edi
80104415:	75 e1                	jne    801043f8 <exit+0x38>
80104417:	8d 9e ac 00 00 00    	lea    0xac(%esi),%ebx
8010441d:	8d be ac 05 00 00    	lea    0x5ac(%esi),%edi
80104423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104427:	90                   	nop
    if(curproc->pages[i].shmid != -1 && curproc->pages[i].key != -1) {
80104428:	83 7b 08 ff          	cmpl   $0xffffffff,0x8(%ebx)
8010442c:	74 13                	je     80104441 <exit+0x81>
8010442e:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
80104431:	74 0e                	je     80104441 <exit+0x81>
      shmdtWrapper(curproc->pages[i].virtualAddr);
80104433:	83 ec 0c             	sub    $0xc,%esp
80104436:	ff 73 10             	pushl  0x10(%ebx)
80104439:	e8 b2 58 00 00       	call   80109cf0 <shmdtWrapper>
8010443e:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < SHAREDREGIONS; i++) {
80104441:	83 c3 14             	add    $0x14,%ebx
80104444:	39 df                	cmp    %ebx,%edi
80104446:	75 e0                	jne    80104428 <exit+0x68>
  begin_op();
80104448:	e8 53 ee ff ff       	call   801032a0 <begin_op>
  iput(curproc->cwd);
8010444d:	83 ec 0c             	sub    $0xc,%esp
80104450:	ff 76 68             	pushl  0x68(%esi)
80104453:	e8 a8 d9 ff ff       	call   80101e00 <iput>
  end_op();
80104458:	e8 b3 ee ff ff       	call   80103310 <end_op>
  curproc->cwd = 0;
8010445d:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104464:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
8010446b:	e8 30 19 00 00       	call   80105da0 <acquire>
  wakeup1(curproc->parent);
80104470:	8b 56 14             	mov    0x14(%esi),%edx
80104473:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104476:	b8 94 63 11 80       	mov    $0x80116394,%eax
8010447b:	eb 0f                	jmp    8010448c <exit+0xcc>
8010447d:	8d 76 00             	lea    0x0(%esi),%esi
80104480:	05 ac 05 00 00       	add    $0x5ac,%eax
80104485:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010448a:	74 1e                	je     801044aa <exit+0xea>
    if(p->state == SLEEPING && p->chan == chan)
8010448c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104490:	75 ee                	jne    80104480 <exit+0xc0>
80104492:	3b 50 20             	cmp    0x20(%eax),%edx
80104495:	75 e9                	jne    80104480 <exit+0xc0>
      p->state = RUNNABLE;
80104497:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010449e:	05 ac 05 00 00       	add    $0x5ac,%eax
801044a3:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801044a8:	75 e2                	jne    8010448c <exit+0xcc>
      p->parent = initproc;
801044aa:	8b 0d 1c d6 10 80    	mov    0x8010d61c,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044b0:	ba 94 63 11 80       	mov    $0x80116394,%edx
801044b5:	eb 17                	jmp    801044ce <exit+0x10e>
801044b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044be:	66 90                	xchg   %ax,%ax
801044c0:	81 c2 ac 05 00 00    	add    $0x5ac,%edx
801044c6:	81 fa 94 ce 12 80    	cmp    $0x8012ce94,%edx
801044cc:	74 3a                	je     80104508 <exit+0x148>
    if(p->parent == curproc){
801044ce:	39 72 14             	cmp    %esi,0x14(%edx)
801044d1:	75 ed                	jne    801044c0 <exit+0x100>
      if(p->state == ZOMBIE)
801044d3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801044d7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801044da:	75 e4                	jne    801044c0 <exit+0x100>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044dc:	b8 94 63 11 80       	mov    $0x80116394,%eax
801044e1:	eb 11                	jmp    801044f4 <exit+0x134>
801044e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044e7:	90                   	nop
801044e8:	05 ac 05 00 00       	add    $0x5ac,%eax
801044ed:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801044f2:	74 cc                	je     801044c0 <exit+0x100>
    if(p->state == SLEEPING && p->chan == chan)
801044f4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044f8:	75 ee                	jne    801044e8 <exit+0x128>
801044fa:	3b 48 20             	cmp    0x20(%eax),%ecx
801044fd:	75 e9                	jne    801044e8 <exit+0x128>
      p->state = RUNNABLE;
801044ff:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104506:	eb e0                	jmp    801044e8 <exit+0x128>
  curproc->state = ZOMBIE;
80104508:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010450f:	e8 ec fd ff ff       	call   80104300 <sched>
  panic("zombie exit");
80104514:	83 ec 0c             	sub    $0xc,%esp
80104517:	68 04 a3 10 80       	push   $0x8010a304
8010451c:	e8 6f be ff ff       	call   80100390 <panic>
    panic("init exiting");
80104521:	83 ec 0c             	sub    $0xc,%esp
80104524:	68 f7 a2 10 80       	push   $0x8010a2f7
80104529:	e8 62 be ff ff       	call   80100390 <panic>
8010452e:	66 90                	xchg   %ax,%ax

80104530 <yield>:
{
80104530:	f3 0f 1e fb          	endbr32 
80104534:	55                   	push   %ebp
80104535:	89 e5                	mov    %esp,%ebp
80104537:	53                   	push   %ebx
80104538:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010453b:	68 60 63 11 80       	push   $0x80116360
80104540:	e8 5b 18 00 00       	call   80105da0 <acquire>
  pushcli();
80104545:	e8 56 17 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
8010454a:	e8 91 f9 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
8010454f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104555:	e8 96 17 00 00       	call   80105cf0 <popcli>
  myproc()->state = RUNNABLE;
8010455a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104561:	e8 9a fd ff ff       	call   80104300 <sched>
  release(&ptable.lock);
80104566:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
8010456d:	e8 ee 18 00 00       	call   80105e60 <release>
}
80104572:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104575:	83 c4 10             	add    $0x10,%esp
80104578:	c9                   	leave  
80104579:	c3                   	ret    
8010457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104580 <sleep>:
{
80104580:	f3 0f 1e fb          	endbr32 
80104584:	55                   	push   %ebp
80104585:	89 e5                	mov    %esp,%ebp
80104587:	57                   	push   %edi
80104588:	56                   	push   %esi
80104589:	53                   	push   %ebx
8010458a:	83 ec 0c             	sub    $0xc,%esp
8010458d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104590:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104593:	e8 08 17 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80104598:	e8 43 f9 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
8010459d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045a3:	e8 48 17 00 00       	call   80105cf0 <popcli>
  if(p == 0)
801045a8:	85 db                	test   %ebx,%ebx
801045aa:	0f 84 83 00 00 00    	je     80104633 <sleep+0xb3>
  if(lk == 0)
801045b0:	85 f6                	test   %esi,%esi
801045b2:	74 72                	je     80104626 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801045b4:	81 fe 60 63 11 80    	cmp    $0x80116360,%esi
801045ba:	74 4c                	je     80104608 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801045bc:	83 ec 0c             	sub    $0xc,%esp
801045bf:	68 60 63 11 80       	push   $0x80116360
801045c4:	e8 d7 17 00 00       	call   80105da0 <acquire>
    release(lk);
801045c9:	89 34 24             	mov    %esi,(%esp)
801045cc:	e8 8f 18 00 00       	call   80105e60 <release>
  p->chan = chan;
801045d1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045d4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045db:	e8 20 fd ff ff       	call   80104300 <sched>
  p->chan = 0;
801045e0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045e7:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
801045ee:	e8 6d 18 00 00       	call   80105e60 <release>
    acquire(lk);
801045f3:	89 75 08             	mov    %esi,0x8(%ebp)
801045f6:	83 c4 10             	add    $0x10,%esp
}
801045f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045fc:	5b                   	pop    %ebx
801045fd:	5e                   	pop    %esi
801045fe:	5f                   	pop    %edi
801045ff:	5d                   	pop    %ebp
    acquire(lk);
80104600:	e9 9b 17 00 00       	jmp    80105da0 <acquire>
80104605:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104608:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010460b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104612:	e8 e9 fc ff ff       	call   80104300 <sched>
  p->chan = 0;
80104617:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010461e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5f                   	pop    %edi
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
    panic("sleep without lk");
80104626:	83 ec 0c             	sub    $0xc,%esp
80104629:	68 16 a3 10 80       	push   $0x8010a316
8010462e:	e8 5d bd ff ff       	call   80100390 <panic>
    panic("sleep");
80104633:	83 ec 0c             	sub    $0xc,%esp
80104636:	68 10 a3 10 80       	push   $0x8010a310
8010463b:	e8 50 bd ff ff       	call   80100390 <panic>

80104640 <wait>:
{
80104640:	f3 0f 1e fb          	endbr32 
80104644:	55                   	push   %ebp
80104645:	89 e5                	mov    %esp,%ebp
80104647:	56                   	push   %esi
80104648:	53                   	push   %ebx
  pushcli();
80104649:	e8 52 16 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
8010464e:	e8 8d f8 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80104653:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104659:	e8 92 16 00 00       	call   80105cf0 <popcli>
  acquire(&ptable.lock);
8010465e:	83 ec 0c             	sub    $0xc,%esp
80104661:	68 60 63 11 80       	push   $0x80116360
80104666:	e8 35 17 00 00       	call   80105da0 <acquire>
8010466b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010466e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104670:	bb 94 63 11 80       	mov    $0x80116394,%ebx
80104675:	eb 17                	jmp    8010468e <wait+0x4e>
80104677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010467e:	66 90                	xchg   %ax,%ax
80104680:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
80104686:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
8010468c:	74 1e                	je     801046ac <wait+0x6c>
      if(p->parent != curproc)
8010468e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104691:	75 ed                	jne    80104680 <wait+0x40>
      if(p->state == ZOMBIE){
80104693:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104697:	74 37                	je     801046d0 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104699:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
      havekids = 1;
8010469f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046a4:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
801046aa:	75 e2                	jne    8010468e <wait+0x4e>
    if(!havekids || curproc->killed){
801046ac:	85 c0                	test   %eax,%eax
801046ae:	74 76                	je     80104726 <wait+0xe6>
801046b0:	8b 46 24             	mov    0x24(%esi),%eax
801046b3:	85 c0                	test   %eax,%eax
801046b5:	75 6f                	jne    80104726 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801046b7:	83 ec 08             	sub    $0x8,%esp
801046ba:	68 60 63 11 80       	push   $0x80116360
801046bf:	56                   	push   %esi
801046c0:	e8 bb fe ff ff       	call   80104580 <sleep>
    havekids = 0;
801046c5:	83 c4 10             	add    $0x10,%esp
801046c8:	eb a4                	jmp    8010466e <wait+0x2e>
801046ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801046d0:	83 ec 0c             	sub    $0xc,%esp
801046d3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801046d6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801046d9:	e8 02 e3 ff ff       	call   801029e0 <kfree>
        freevm(p->pgdir);
801046de:	5a                   	pop    %edx
801046df:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801046e2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801046e9:	e8 12 46 00 00       	call   80108d00 <freevm>
        release(&ptable.lock);
801046ee:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
        p->pid = 0;
801046f5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801046fc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104703:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104707:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010470e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104715:	e8 46 17 00 00       	call   80105e60 <release>
        return pid;
8010471a:	83 c4 10             	add    $0x10,%esp
}
8010471d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104720:	89 f0                	mov    %esi,%eax
80104722:	5b                   	pop    %ebx
80104723:	5e                   	pop    %esi
80104724:	5d                   	pop    %ebp
80104725:	c3                   	ret    
      release(&ptable.lock);
80104726:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104729:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010472e:	68 60 63 11 80       	push   $0x80116360
80104733:	e8 28 17 00 00       	call   80105e60 <release>
      return -1;
80104738:	83 c4 10             	add    $0x10,%esp
8010473b:	eb e0                	jmp    8010471d <wait+0xdd>
8010473d:	8d 76 00             	lea    0x0(%esi),%esi

80104740 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104740:	f3 0f 1e fb          	endbr32 
80104744:	55                   	push   %ebp
80104745:	89 e5                	mov    %esp,%ebp
80104747:	53                   	push   %ebx
80104748:	83 ec 10             	sub    $0x10,%esp
8010474b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010474e:	68 60 63 11 80       	push   $0x80116360
80104753:	e8 48 16 00 00       	call   80105da0 <acquire>
80104758:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010475b:	b8 94 63 11 80       	mov    $0x80116394,%eax
80104760:	eb 12                	jmp    80104774 <wakeup+0x34>
80104762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104768:	05 ac 05 00 00       	add    $0x5ac,%eax
8010476d:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
80104772:	74 1e                	je     80104792 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104774:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104778:	75 ee                	jne    80104768 <wakeup+0x28>
8010477a:	3b 58 20             	cmp    0x20(%eax),%ebx
8010477d:	75 e9                	jne    80104768 <wakeup+0x28>
      p->state = RUNNABLE;
8010477f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104786:	05 ac 05 00 00       	add    $0x5ac,%eax
8010478b:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
80104790:	75 e2                	jne    80104774 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104792:	c7 45 08 60 63 11 80 	movl   $0x80116360,0x8(%ebp)
}
80104799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010479c:	c9                   	leave  
  release(&ptable.lock);
8010479d:	e9 be 16 00 00       	jmp    80105e60 <release>
801047a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801047b0:	f3 0f 1e fb          	endbr32 
801047b4:	55                   	push   %ebp
801047b5:	89 e5                	mov    %esp,%ebp
801047b7:	53                   	push   %ebx
801047b8:	83 ec 10             	sub    $0x10,%esp
801047bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801047be:	68 60 63 11 80       	push   $0x80116360
801047c3:	e8 d8 15 00 00       	call   80105da0 <acquire>
801047c8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047cb:	b8 94 63 11 80       	mov    $0x80116394,%eax
801047d0:	eb 12                	jmp    801047e4 <kill+0x34>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d8:	05 ac 05 00 00       	add    $0x5ac,%eax
801047dd:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801047e2:	74 34                	je     80104818 <kill+0x68>
    if(p->pid == pid){
801047e4:	39 58 10             	cmp    %ebx,0x10(%eax)
801047e7:	75 ef                	jne    801047d8 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801047e9:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801047ed:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801047f4:	75 07                	jne    801047fd <kill+0x4d>
        p->state = RUNNABLE;
801047f6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801047fd:	83 ec 0c             	sub    $0xc,%esp
80104800:	68 60 63 11 80       	push   $0x80116360
80104805:	e8 56 16 00 00       	call   80105e60 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010480a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010480d:	83 c4 10             	add    $0x10,%esp
80104810:	31 c0                	xor    %eax,%eax
}
80104812:	c9                   	leave  
80104813:	c3                   	ret    
80104814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	68 60 63 11 80       	push   $0x80116360
80104820:	e8 3b 16 00 00       	call   80105e60 <release>
}
80104825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104828:	83 c4 10             	add    $0x10,%esp
8010482b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104830:	c9                   	leave  
80104831:	c3                   	ret    
80104832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104840 <get_uncle_count>:

//get_uncle_count
int get_uncle_count(int pid){
80104840:	f3 0f 1e fb          	endbr32 
80104844:	55                   	push   %ebp
80104845:	89 e5                	mov    %esp,%ebp
80104847:	53                   	push   %ebx
80104848:	83 ec 10             	sub    $0x10,%esp
8010484b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  struct proc *p_parent;
  struct proc *p_grandParent = 0;
  acquire(&ptable.lock);
8010484e:	68 60 63 11 80       	push   $0x80116360
80104853:	e8 48 15 00 00       	call   80105da0 <acquire>
  if(pid < 0 || pid >= NPROC){
80104858:	83 c4 10             	add    $0x10,%esp
8010485b:	83 fb 3f             	cmp    $0x3f,%ebx
8010485e:	0f 87 a8 00 00 00    	ja     8010490c <get_uncle_count+0xcc>
  struct proc *p_grandParent = 0;
80104864:	31 c9                	xor    %ecx,%ecx
      return -1;
      }
  int count = 0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104866:	b8 94 63 11 80       	mov    $0x80116394,%eax
8010486b:	eb 0f                	jmp    8010487c <get_uncle_count+0x3c>
8010486d:	8d 76 00             	lea    0x0(%esi),%esi
80104870:	05 ac 05 00 00       	add    $0x5ac,%eax
80104875:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010487a:	74 34                	je     801048b0 <get_uncle_count+0x70>
    count ++;
    if((p->pid) == pid){
8010487c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010487f:	75 ef                	jne    80104870 <get_uncle_count+0x30>
      p_parent = p->parent;
80104881:	8b 50 14             	mov    0x14(%eax),%edx
      if(p_parent != 0){
80104884:	85 d2                	test   %edx,%edx
80104886:	74 68                	je     801048f0 <get_uncle_count+0xb0>
        p_grandParent = p_parent->parent;
80104888:	8b 4a 14             	mov    0x14(%edx),%ecx
        if(p_grandParent == 0){
8010488b:	85 c9                	test   %ecx,%ecx
8010488d:	75 e1                	jne    80104870 <get_uncle_count+0x30>
          cprintf("grandparent is zero.");
8010488f:	83 ec 0c             	sub    $0xc,%esp
          return -1;
80104892:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
          cprintf("grandparent is zero.");
80104897:	68 27 a3 10 80       	push   $0x8010a327
8010489c:	e8 1f c0 ff ff       	call   801008c0 <cprintf>
          return -1;
801048a1:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ptable.lock);
  return siblings;

}
801048a4:	89 d8                	mov    %ebx,%eax
801048a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a9:	c9                   	leave  
801048aa:	c3                   	ret    
801048ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048af:	90                   	nop
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
801048b0:	b8 94 63 11 80       	mov    $0x80116394,%eax
  int siblings = 0;
801048b5:	31 db                	xor    %ebx,%ebx
801048b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048be:	66 90                	xchg   %ax,%ax
      siblings++;
801048c0:	31 d2                	xor    %edx,%edx
801048c2:	39 48 14             	cmp    %ecx,0x14(%eax)
801048c5:	0f 94 c2             	sete   %dl
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
801048c8:	05 ac 05 00 00       	add    $0x5ac,%eax
      siblings++;
801048cd:	01 d3                	add    %edx,%ebx
  for(struct proc *i = ptable.proc; i < &ptable.proc[NPROC]; i++){
801048cf:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
801048d4:	75 ea                	jne    801048c0 <get_uncle_count+0x80>
  release(&ptable.lock);
801048d6:	83 ec 0c             	sub    $0xc,%esp
801048d9:	68 60 63 11 80       	push   $0x80116360
801048de:	e8 7d 15 00 00       	call   80105e60 <release>
}
801048e3:	89 d8                	mov    %ebx,%eax
  return siblings;
801048e5:	83 c4 10             	add    $0x10,%esp
}
801048e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048eb:	c9                   	leave  
801048ec:	c3                   	ret    
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("parent is zero.");
801048f0:	83 ec 0c             	sub    $0xc,%esp
        return -1;
801048f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        cprintf("parent is zero.");
801048f8:	68 2c a3 10 80       	push   $0x8010a32c
801048fd:	e8 be bf ff ff       	call   801008c0 <cprintf>
}
80104902:	89 d8                	mov    %ebx,%eax
        return -1;
80104904:	83 c4 10             	add    $0x10,%esp
}
80104907:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010490a:	c9                   	leave  
8010490b:	c3                   	ret    
      return -1;
8010490c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104911:	eb 91                	jmp    801048a4 <get_uncle_count+0x64>
80104913:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104920 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104920:	f3 0f 1e fb          	endbr32 
80104924:	55                   	push   %ebp
80104925:	89 e5                	mov    %esp,%ebp
80104927:	57                   	push   %edi
80104928:	56                   	push   %esi
80104929:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010492c:	53                   	push   %ebx
8010492d:	bb 00 64 11 80       	mov    $0x80116400,%ebx
80104932:	83 ec 3c             	sub    $0x3c,%esp
80104935:	eb 2b                	jmp    80104962 <procdump+0x42>
80104937:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104940:	83 ec 0c             	sub    $0xc,%esp
80104943:	68 85 a3 10 80       	push   $0x8010a385
80104948:	e8 73 bf ff ff       	call   801008c0 <cprintf>
8010494d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104950:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
80104956:	81 fb 00 cf 12 80    	cmp    $0x8012cf00,%ebx
8010495c:	0f 84 8e 00 00 00    	je     801049f0 <procdump+0xd0>
    if(p->state == UNUSED)
80104962:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104965:	85 c0                	test   %eax,%eax
80104967:	74 e7                	je     80104950 <procdump+0x30>
      state = "???";
80104969:	ba 3c a3 10 80       	mov    $0x8010a33c,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010496e:	83 f8 05             	cmp    $0x5,%eax
80104971:	77 11                	ja     80104984 <procdump+0x64>
80104973:	8b 14 85 a4 a5 10 80 	mov    -0x7fef5a5c(,%eax,4),%edx
      state = "???";
8010497a:	b8 3c a3 10 80       	mov    $0x8010a33c,%eax
8010497f:	85 d2                	test   %edx,%edx
80104981:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104984:	53                   	push   %ebx
80104985:	52                   	push   %edx
80104986:	ff 73 a4             	pushl  -0x5c(%ebx)
80104989:	68 40 a3 10 80       	push   $0x8010a340
8010498e:	e8 2d bf ff ff       	call   801008c0 <cprintf>
    if(p->state == SLEEPING){
80104993:	83 c4 10             	add    $0x10,%esp
80104996:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010499a:	75 a4                	jne    80104940 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010499c:	83 ec 08             	sub    $0x8,%esp
8010499f:	8d 45 c0             	lea    -0x40(%ebp),%eax
801049a2:	8d 7d c0             	lea    -0x40(%ebp),%edi
801049a5:	50                   	push   %eax
801049a6:	8b 43 b0             	mov    -0x50(%ebx),%eax
801049a9:	8b 40 0c             	mov    0xc(%eax),%eax
801049ac:	83 c0 08             	add    $0x8,%eax
801049af:	50                   	push   %eax
801049b0:	e8 8b 12 00 00       	call   80105c40 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801049b5:	83 c4 10             	add    $0x10,%esp
801049b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049bf:	90                   	nop
801049c0:	8b 17                	mov    (%edi),%edx
801049c2:	85 d2                	test   %edx,%edx
801049c4:	0f 84 76 ff ff ff    	je     80104940 <procdump+0x20>
        cprintf(" %p", pc[i]);
801049ca:	83 ec 08             	sub    $0x8,%esp
801049cd:	83 c7 04             	add    $0x4,%edi
801049d0:	52                   	push   %edx
801049d1:	68 41 9d 10 80       	push   $0x80109d41
801049d6:	e8 e5 be ff ff       	call   801008c0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801049db:	83 c4 10             	add    $0x10,%esp
801049de:	39 fe                	cmp    %edi,%esi
801049e0:	75 de                	jne    801049c0 <procdump+0xa0>
801049e2:	e9 59 ff ff ff       	jmp    80104940 <procdump+0x20>
801049e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ee:	66 90                	xchg   %ax,%ax
  }
}
801049f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049f3:	5b                   	pop    %ebx
801049f4:	5e                   	pop    %esi
801049f5:	5f                   	pop    %edi
801049f6:	5d                   	pop    %ebp
801049f7:	c3                   	ret    
801049f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ff:	90                   	nop

80104a00 <find_digital_root>:

int 
find_digital_root(int n){
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	89 e5                	mov    %esp,%ebp
80104a07:	57                   	push   %edi
80104a08:	56                   	push   %esi
80104a09:	53                   	push   %ebx
80104a0a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n>9){
80104a0d:	83 fb 09             	cmp    $0x9,%ebx
80104a10:	7e 3d                	jle    80104a4f <find_digital_root+0x4f>
    int sum = 0 ;
    while(n > 0){
      int digit = n%10;
80104a12:	be 67 66 66 66       	mov    $0x66666667,%esi
80104a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1e:	66 90                	xchg   %ax,%ax
find_digital_root(int n){
80104a20:	89 d9                	mov    %ebx,%ecx
    int sum = 0 ;
80104a22:	31 db                	xor    %ebx,%ebx
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      int digit = n%10;
80104a28:	89 c8                	mov    %ecx,%eax
80104a2a:	89 cf                	mov    %ecx,%edi
80104a2c:	f7 ee                	imul   %esi
80104a2e:	89 c8                	mov    %ecx,%eax
80104a30:	c1 f8 1f             	sar    $0x1f,%eax
80104a33:	c1 fa 02             	sar    $0x2,%edx
80104a36:	29 c2                	sub    %eax,%edx
80104a38:	8d 04 92             	lea    (%edx,%edx,4),%eax
80104a3b:	01 c0                	add    %eax,%eax
80104a3d:	29 c7                	sub    %eax,%edi
80104a3f:	89 c8                	mov    %ecx,%eax
      sum += digit;
      n = n/10;
80104a41:	89 d1                	mov    %edx,%ecx
      sum += digit;
80104a43:	01 fb                	add    %edi,%ebx
    while(n > 0){
80104a45:	83 f8 09             	cmp    $0x9,%eax
80104a48:	7f de                	jg     80104a28 <find_digital_root+0x28>
  while(n>9){
80104a4a:	83 fb 09             	cmp    $0x9,%ebx
80104a4d:	7f d1                	jg     80104a20 <find_digital_root+0x20>
    }
    n = sum;
  }
  
  return n;
}
80104a4f:	89 d8                	mov    %ebx,%eax
80104a51:	5b                   	pop    %ebx
80104a52:	5e                   	pop    %esi
80104a53:	5f                   	pop    %edi
80104a54:	5d                   	pop    %ebp
80104a55:	c3                   	ret    
80104a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <get_process_lifetime>:

int
get_process_lifetime(void){
80104a60:	f3 0f 1e fb          	endbr32 
80104a64:	55                   	push   %ebp
80104a65:	89 e5                	mov    %esp,%ebp
80104a67:	56                   	push   %esi
80104a68:	53                   	push   %ebx
  return sys_uptime() - myproc()->start_time ; 
80104a69:	e8 b2 28 00 00       	call   80107320 <sys_uptime>
80104a6e:	89 c3                	mov    %eax,%ebx
  pushcli();
80104a70:	e8 2b 12 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80104a75:	e8 66 f4 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80104a7a:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104a80:	e8 6b 12 00 00       	call   80105cf0 <popcli>
  return sys_uptime() - myproc()->start_time ; 
80104a85:	89 d8                	mov    %ebx,%eax
}
80104a87:	5b                   	pop    %ebx
  return sys_uptime() - myproc()->start_time ; 
80104a88:	2b 46 7c             	sub    0x7c(%esi),%eax
}
80104a8b:	5e                   	pop    %esi
80104a8c:	5d                   	pop    %ebp
80104a8d:	c3                   	ret    
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <change_Q>:
  }
  release(&ptable.lock);
}

int change_Q(int pid, int new_queue)
{
80104a90:	f3 0f 1e fb          	endbr32 
80104a94:	55                   	push   %ebp
80104a95:	89 e5                	mov    %esp,%ebp
80104a97:	57                   	push   %edi
80104a98:	56                   	push   %esi
80104a99:	53                   	push   %ebx
80104a9a:	83 ec 0c             	sub    $0xc,%esp
80104a9d:	8b 75 0c             	mov    0xc(%ebp),%esi
80104aa0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  int old_queue = -1;

  if (new_queue == UNSET)
80104aa3:	85 f6                	test   %esi,%esi
80104aa5:	75 0c                	jne    80104ab3 <change_Q+0x23>
  {
    if (pid == 1)
80104aa7:	83 fb 01             	cmp    $0x1,%ebx
80104aaa:	74 69                	je     80104b15 <change_Q+0x85>
      new_queue = ROUND_ROBIN;
    else if (pid > 1)
80104aac:	7e 6e                	jle    80104b1c <change_Q+0x8c>
      new_queue = LCFS;
80104aae:	be 02 00 00 00       	mov    $0x2,%esi
    else
      return -1;
  }
  acquire(&ptable.lock);
80104ab3:	83 ec 0c             	sub    $0xc,%esp
  int old_queue = -1;
80104ab6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  acquire(&ptable.lock);
80104abb:	68 60 63 11 80       	push   $0x80116360
80104ac0:	e8 db 12 00 00       	call   80105da0 <acquire>
    if (p->pid == pid)
    {
      old_queue = p->sched_info.queue;
      p->sched_info.queue = new_queue;

      p->sched_info.arrival_queue_time = ticks;
80104ac5:	8b 15 e0 d6 12 80    	mov    0x8012d6e0,%edx
80104acb:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ace:	b8 94 63 11 80       	mov    $0x80116394,%eax
80104ad3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ad7:	90                   	nop
    if (p->pid == pid)
80104ad8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104adb:	75 12                	jne    80104aef <change_Q+0x5f>
      old_queue = p->sched_info.queue;
80104add:	8b b8 80 00 00 00    	mov    0x80(%eax),%edi
      p->sched_info.arrival_queue_time = ticks;
80104ae3:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
      p->sched_info.queue = new_queue;
80104ae9:	89 b0 80 00 00 00    	mov    %esi,0x80(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104aef:	05 ac 05 00 00       	add    $0x5ac,%eax
80104af4:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
80104af9:	75 dd                	jne    80104ad8 <change_Q+0x48>
    }
  }
  release(&ptable.lock);
80104afb:	83 ec 0c             	sub    $0xc,%esp
80104afe:	68 60 63 11 80       	push   $0x80116360
80104b03:	e8 58 13 00 00       	call   80105e60 <release>
  return old_queue;
80104b08:	83 c4 10             	add    $0x10,%esp
}
80104b0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b0e:	89 f8                	mov    %edi,%eax
80104b10:	5b                   	pop    %ebx
80104b11:	5e                   	pop    %esi
80104b12:	5f                   	pop    %edi
80104b13:	5d                   	pop    %ebp
80104b14:	c3                   	ret    
      new_queue = ROUND_ROBIN;
80104b15:	be 01 00 00 00       	mov    $0x1,%esi
80104b1a:	eb 97                	jmp    80104ab3 <change_Q+0x23>
      return -1;
80104b1c:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104b21:	eb e8                	jmp    80104b0b <change_Q+0x7b>
80104b23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b30 <userinit>:
{
80104b30:	f3 0f 1e fb          	endbr32 
80104b34:	55                   	push   %ebp
80104b35:	89 e5                	mov    %esp,%ebp
80104b37:	53                   	push   %ebx
80104b38:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104b3b:	e8 d0 f1 ff ff       	call   80103d10 <allocproc>
80104b40:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104b42:	a3 1c d6 10 80       	mov    %eax,0x8010d61c
  if((p->pgdir = setupkvm()) == 0)
80104b47:	e8 34 42 00 00       	call   80108d80 <setupkvm>
80104b4c:	89 43 04             	mov    %eax,0x4(%ebx)
80104b4f:	85 c0                	test   %eax,%eax
80104b51:	0f 84 c9 00 00 00    	je     80104c20 <userinit+0xf0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104b57:	83 ec 04             	sub    $0x4,%esp
80104b5a:	68 2c 00 00 00       	push   $0x2c
80104b5f:	68 60 d4 10 80       	push   $0x8010d460
80104b64:	50                   	push   %eax
80104b65:	e8 e6 3e 00 00       	call   80108a50 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104b6a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104b6d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104b73:	6a 4c                	push   $0x4c
80104b75:	6a 00                	push   $0x0
80104b77:	ff 73 18             	pushl  0x18(%ebx)
80104b7a:	e8 31 13 00 00       	call   80105eb0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104b7f:	8b 43 18             	mov    0x18(%ebx),%eax
80104b82:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104b87:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104b8a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104b8f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104b93:	8b 43 18             	mov    0x18(%ebx),%eax
80104b96:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104b9a:	8b 43 18             	mov    0x18(%ebx),%eax
80104b9d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104ba1:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104ba5:	8b 43 18             	mov    0x18(%ebx),%eax
80104ba8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104bac:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104bb0:	8b 43 18             	mov    0x18(%ebx),%eax
80104bb3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104bba:	8b 43 18             	mov    0x18(%ebx),%eax
80104bbd:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104bc4:	8b 43 18             	mov    0x18(%ebx),%eax
80104bc7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104bce:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104bd1:	6a 10                	push   $0x10
80104bd3:	68 62 a3 10 80       	push   $0x8010a362
80104bd8:	50                   	push   %eax
80104bd9:	e8 92 14 00 00       	call   80106070 <safestrcpy>
  p->cwd = namei("/");
80104bde:	c7 04 24 6b a3 10 80 	movl   $0x8010a36b,(%esp)
80104be5:	e8 b6 d9 ff ff       	call   801025a0 <namei>
80104bea:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104bed:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
80104bf4:	e8 a7 11 00 00       	call   80105da0 <acquire>
  p->state = RUNNABLE;
80104bf9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104c00:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
80104c07:	e8 54 12 00 00       	call   80105e60 <release>
  change_Q(p->pid, UNSET);
80104c0c:	58                   	pop    %eax
80104c0d:	5a                   	pop    %edx
80104c0e:	6a 00                	push   $0x0
80104c10:	ff 73 10             	pushl  0x10(%ebx)
80104c13:	e8 78 fe ff ff       	call   80104a90 <change_Q>
}
80104c18:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c1b:	83 c4 10             	add    $0x10,%esp
80104c1e:	c9                   	leave  
80104c1f:	c3                   	ret    
    panic("userinit: out of memory?");
80104c20:	83 ec 0c             	sub    $0xc,%esp
80104c23:	68 49 a3 10 80       	push   $0x8010a349
80104c28:	e8 63 b7 ff ff       	call   80100390 <panic>
80104c2d:	8d 76 00             	lea    0x0(%esi),%esi

80104c30 <fork>:
{
80104c30:	f3 0f 1e fb          	endbr32 
80104c34:	55                   	push   %ebp
80104c35:	89 e5                	mov    %esp,%ebp
80104c37:	57                   	push   %edi
80104c38:	56                   	push   %esi
80104c39:	53                   	push   %ebx
80104c3a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104c3d:	e8 5e 10 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80104c42:	e8 99 f2 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80104c47:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c4d:	e8 9e 10 00 00       	call   80105cf0 <popcli>
  if((np = allocproc()) == 0){
80104c52:	e8 b9 f0 ff ff       	call   80103d10 <allocproc>
80104c57:	85 c0                	test   %eax,%eax
80104c59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104c5c:	0f 84 54 01 00 00    	je     80104db6 <fork+0x186>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104c62:	83 ec 08             	sub    $0x8,%esp
80104c65:	ff 33                	pushl  (%ebx)
80104c67:	ff 73 04             	pushl  0x4(%ebx)
80104c6a:	e8 e1 41 00 00       	call   80108e50 <copyuvm>
80104c6f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104c72:	83 c4 10             	add    $0x10,%esp
80104c75:	89 42 04             	mov    %eax,0x4(%edx)
80104c78:	85 c0                	test   %eax,%eax
80104c7a:	0f 84 3f 01 00 00    	je     80104dbf <fork+0x18f>
  np->sz = curproc->sz;
80104c80:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80104c82:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
80104c85:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80104c88:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80104c8d:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
80104c8f:	8b 73 18             	mov    0x18(%ebx),%esi
80104c92:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104c94:	31 f6                	xor    %esi,%esi
80104c96:	89 d7                	mov    %edx,%edi
  np->tf->eax = 0;
80104c98:	8b 42 18             	mov    0x18(%edx),%eax
80104c9b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80104ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80104ca8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104cac:	85 c0                	test   %eax,%eax
80104cae:	74 10                	je     80104cc0 <fork+0x90>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104cb0:	83 ec 0c             	sub    $0xc,%esp
80104cb3:	50                   	push   %eax
80104cb4:	e8 27 c7 ff ff       	call   801013e0 <filedup>
80104cb9:	83 c4 10             	add    $0x10,%esp
80104cbc:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104cc0:	83 c6 01             	add    $0x1,%esi
80104cc3:	83 fe 10             	cmp    $0x10,%esi
80104cc6:	75 e0                	jne    80104ca8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
80104cc8:	83 ec 0c             	sub    $0xc,%esp
80104ccb:	ff 73 68             	pushl  0x68(%ebx)
  pid = np->pid;
80104cce:	be ac 00 00 00       	mov    $0xac,%esi
80104cd3:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  for(int i = 0; i < SHAREDREGIONS; i++) {
80104cd6:	31 ff                	xor    %edi,%edi
  np->cwd = idup(curproc->cwd);
80104cd8:	e8 c3 cf ff ff       	call   80101ca0 <idup>
80104cdd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104ce0:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104ce3:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104ce6:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104ce9:	6a 10                	push   $0x10
80104ceb:	50                   	push   %eax
80104cec:	8d 42 6c             	lea    0x6c(%edx),%eax
80104cef:	50                   	push   %eax
80104cf0:	e8 7b 13 00 00       	call   80106070 <safestrcpy>
  pid = np->pid;
80104cf5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104cf8:	83 c4 10             	add    $0x10,%esp
80104cfb:	8b 42 10             	mov    0x10(%edx),%eax
80104cfe:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(int i = 0; i < SHAREDREGIONS; i++) {
80104d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->pages[i].key != -1 && curproc->pages[i].shmid != -1) {
80104d08:	83 3c 33 ff          	cmpl   $0xffffffff,(%ebx,%esi,1)
80104d0c:	74 5a                	je     80104d68 <fork+0x138>
80104d0e:	83 7c 33 08 ff       	cmpl   $0xffffffff,0x8(%ebx,%esi,1)
80104d13:	74 53                	je     80104d68 <fork+0x138>
      np->pages[i] = curproc->pages[i];
80104d15:	8b 04 33             	mov    (%ebx,%esi,1),%eax
      int index = getShmidIndex(np->pages[i].shmid);
80104d18:	83 ec 0c             	sub    $0xc,%esp
      np->pages[i] = curproc->pages[i];
80104d1b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104d1e:	89 04 32             	mov    %eax,(%edx,%esi,1)
80104d21:	8b 44 33 04          	mov    0x4(%ebx,%esi,1),%eax
80104d25:	89 44 32 04          	mov    %eax,0x4(%edx,%esi,1)
80104d29:	8b 44 33 08          	mov    0x8(%ebx,%esi,1),%eax
80104d2d:	89 44 32 08          	mov    %eax,0x8(%edx,%esi,1)
80104d31:	8b 4c 33 0c          	mov    0xc(%ebx,%esi,1),%ecx
80104d35:	89 4c 32 0c          	mov    %ecx,0xc(%edx,%esi,1)
80104d39:	8b 4c 33 10          	mov    0x10(%ebx,%esi,1),%ecx
80104d3d:	89 4c 32 10          	mov    %ecx,0x10(%edx,%esi,1)
      int index = getShmidIndex(np->pages[i].shmid);
80104d41:	50                   	push   %eax
80104d42:	e8 c9 4e 00 00       	call   80109c10 <getShmidIndex>
      if(index != -1) {
80104d47:	83 c4 10             	add    $0x10,%esp
80104d4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104d4d:	83 f8 ff             	cmp    $0xffffffff,%eax
80104d50:	74 16                	je     80104d68 <fork+0x138>
        mappagesWrapper(np, index, i);
80104d52:	83 ec 04             	sub    $0x4,%esp
80104d55:	57                   	push   %edi
80104d56:	50                   	push   %eax
80104d57:	52                   	push   %edx
80104d58:	e8 e3 4e 00 00       	call   80109c40 <mappagesWrapper>
80104d5d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104d60:	83 c4 10             	add    $0x10,%esp
80104d63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d67:	90                   	nop
  for(int i = 0; i < SHAREDREGIONS; i++) {
80104d68:	83 c7 01             	add    $0x1,%edi
80104d6b:	83 c6 14             	add    $0x14,%esi
80104d6e:	83 ff 40             	cmp    $0x40,%edi
80104d71:	75 95                	jne    80104d08 <fork+0xd8>
  acquire(&ptable.lock);
80104d73:	83 ec 0c             	sub    $0xc,%esp
80104d76:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104d79:	68 60 63 11 80       	push   $0x80116360
80104d7e:	e8 1d 10 00 00       	call   80105da0 <acquire>
  np->state = RUNNABLE;
80104d83:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104d86:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80104d8d:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
80104d94:	e8 c7 10 00 00       	call   80105e60 <release>
  change_Q(np->pid, UNSET);
80104d99:	58                   	pop    %eax
80104d9a:	5a                   	pop    %edx
80104d9b:	6a 00                	push   $0x0
80104d9d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104da0:	ff 72 10             	pushl  0x10(%edx)
80104da3:	e8 e8 fc ff ff       	call   80104a90 <change_Q>
  return pid;
80104da8:	83 c4 10             	add    $0x10,%esp
}
80104dab:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104dae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104db1:	5b                   	pop    %ebx
80104db2:	5e                   	pop    %esi
80104db3:	5f                   	pop    %edi
80104db4:	5d                   	pop    %ebp
80104db5:	c3                   	ret    
    return -1;
80104db6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80104dbd:	eb ec                	jmp    80104dab <fork+0x17b>
    kfree(np->kstack);
80104dbf:	83 ec 0c             	sub    $0xc,%esp
80104dc2:	ff 72 08             	pushl  0x8(%edx)
80104dc5:	e8 16 dc ff ff       	call   801029e0 <kfree>
    np->kstack = 0;
80104dca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
80104dcd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80104dd4:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104dd7:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
80104dde:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
80104de5:	eb c4                	jmp    80104dab <fork+0x17b>
80104de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dee:	66 90                	xchg   %ax,%ax

80104df0 <ageprocs>:
{
80104df0:	f3 0f 1e fb          	endbr32 
80104df4:	55                   	push   %ebp
80104df5:	89 e5                	mov    %esp,%ebp
80104df7:	56                   	push   %esi
80104df8:	53                   	push   %ebx
80104df9:	8b 75 08             	mov    0x8(%ebp),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104dfc:	bb 94 63 11 80       	mov    $0x80116394,%ebx
  acquire(&ptable.lock);
80104e01:	83 ec 0c             	sub    $0xc,%esp
80104e04:	68 60 63 11 80       	push   $0x80116360
80104e09:	e8 92 0f 00 00       	call   80105da0 <acquire>
80104e0e:	83 c4 10             	add    $0x10,%esp
80104e11:	eb 13                	jmp    80104e26 <ageprocs+0x36>
80104e13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e17:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e18:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
80104e1e:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
80104e24:	74 57                	je     80104e7d <ageprocs+0x8d>
    if (p->state == RUNNABLE && p->sched_info.queue != ROUND_ROBIN)
80104e26:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104e2a:	75 ec                	jne    80104e18 <ageprocs+0x28>
80104e2c:	83 bb 80 00 00 00 01 	cmpl   $0x1,0x80(%ebx)
80104e33:	74 e3                	je     80104e18 <ageprocs+0x28>
      if (os_ticks - p->sched_info.last_run > AGING_THRESHOLD)
80104e35:	89 f0                	mov    %esi,%eax
80104e37:	2b 83 84 00 00 00    	sub    0x84(%ebx),%eax
80104e3d:	3d 40 1f 00 00       	cmp    $0x1f40,%eax
80104e42:	7e d4                	jle    80104e18 <ageprocs+0x28>
        release(&ptable.lock);
80104e44:	83 ec 0c             	sub    $0xc,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e47:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
        release(&ptable.lock);
80104e4d:	68 60 63 11 80       	push   $0x80116360
80104e52:	e8 09 10 00 00       	call   80105e60 <release>
        change_Q(p->pid, ROUND_ROBIN);
80104e57:	58                   	pop    %eax
80104e58:	5a                   	pop    %edx
80104e59:	6a 01                	push   $0x1
80104e5b:	ff b3 64 fa ff ff    	pushl  -0x59c(%ebx)
80104e61:	e8 2a fc ff ff       	call   80104a90 <change_Q>
        acquire(&ptable.lock);
80104e66:	c7 04 24 60 63 11 80 	movl   $0x80116360,(%esp)
80104e6d:	e8 2e 0f 00 00       	call   80105da0 <acquire>
80104e72:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e75:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
80104e7b:	75 a9                	jne    80104e26 <ageprocs+0x36>
  release(&ptable.lock);
80104e7d:	c7 45 08 60 63 11 80 	movl   $0x80116360,0x8(%ebp)
}
80104e84:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e87:	5b                   	pop    %ebx
80104e88:	5e                   	pop    %esi
80104e89:	5d                   	pop    %ebp
  release(&ptable.lock);
80104e8a:	e9 d1 0f 00 00       	jmp    80105e60 <release>
80104e8f:	90                   	nop

80104e90 <num_digits>:

int num_digits(int n) {
80104e90:	f3 0f 1e fb          	endbr32 
80104e94:	55                   	push   %ebp
80104e95:	89 e5                	mov    %esp,%ebp
80104e97:	56                   	push   %esi
80104e98:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e9b:	53                   	push   %ebx
  int num = 0;
80104e9c:	31 db                	xor    %ebx,%ebx
  while(n!= 0) {
80104e9e:	85 c9                	test   %ecx,%ecx
80104ea0:	74 21                	je     80104ec3 <num_digits+0x33>
    n/=10;
80104ea2:	be 67 66 66 66       	mov    $0x66666667,%esi
80104ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eae:	66 90                	xchg   %ax,%ax
80104eb0:	89 c8                	mov    %ecx,%eax
80104eb2:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80104eb5:	83 c3 01             	add    $0x1,%ebx
    n/=10;
80104eb8:	f7 ee                	imul   %esi
80104eba:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80104ebd:	29 ca                	sub    %ecx,%edx
80104ebf:	89 d1                	mov    %edx,%ecx
80104ec1:	75 ed                	jne    80104eb0 <num_digits+0x20>
  }
  return num;
}
80104ec3:	89 d8                	mov    %ebx,%eax
80104ec5:	5b                   	pop    %ebx
80104ec6:	5e                   	pop    %esi
80104ec7:	5d                   	pop    %ebp
80104ec8:	c3                   	ret    
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ed0 <space>:

void
space(int count)
{
80104ed0:	f3 0f 1e fb          	endbr32 
80104ed4:	55                   	push   %ebp
80104ed5:	89 e5                	mov    %esp,%ebp
80104ed7:	56                   	push   %esi
80104ed8:	8b 75 08             	mov    0x8(%ebp),%esi
80104edb:	53                   	push   %ebx
  for(int i = 0; i < count; ++i)
80104edc:	85 f6                	test   %esi,%esi
80104ede:	7e 1f                	jle    80104eff <space+0x2f>
80104ee0:	31 db                	xor    %ebx,%ebx
80104ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" ");
80104ee8:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80104eeb:	83 c3 01             	add    $0x1,%ebx
    cprintf(" ");
80104eee:	68 fe a3 10 80       	push   $0x8010a3fe
80104ef3:	e8 c8 b9 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80104ef8:	83 c4 10             	add    $0x10,%esp
80104efb:	39 de                	cmp    %ebx,%esi
80104efd:	75 e9                	jne    80104ee8 <space+0x18>
}
80104eff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f02:	5b                   	pop    %ebx
80104f03:	5e                   	pop    %esi
80104f04:	5d                   	pop    %ebp
80104f05:	c3                   	ret    
80104f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi

80104f10 <set_proc_bjf_params>:

int set_proc_bjf_params(int pid, float priority_ratio, float arrival_time_ratio, float executed_cycle_ratio, float process_size_ratio)
{
80104f10:	f3 0f 1e fb          	endbr32 
80104f14:	55                   	push   %ebp
80104f15:	89 e5                	mov    %esp,%ebp
80104f17:	53                   	push   %ebx
80104f18:	83 ec 10             	sub    $0x10,%esp
80104f1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104f1e:	68 60 63 11 80       	push   $0x80116360
80104f23:	e8 78 0e 00 00       	call   80105da0 <acquire>
80104f28:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f2b:	b8 94 63 11 80       	mov    $0x80116394,%eax
80104f30:	eb 12                	jmp    80104f44 <set_proc_bjf_params+0x34>
80104f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f38:	05 ac 05 00 00       	add    $0x5ac,%eax
80104f3d:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
80104f42:	74 44                	je     80104f88 <set_proc_bjf_params+0x78>
  {
    if (p->pid == pid)
80104f44:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f47:	75 ef                	jne    80104f38 <set_proc_bjf_params+0x28>
    {
      p->sched_info.bjf.priority_ratio = priority_ratio;
80104f49:	d9 45 0c             	flds   0xc(%ebp)
      p->sched_info.bjf.arrival_time_ratio = arrival_time_ratio;
      p->sched_info.bjf.executed_cycle_ratio = executed_cycle_ratio;
      p->sched_info.bjf.process_size_ratio = process_size_ratio;
      release(&ptable.lock);
80104f4c:	83 ec 0c             	sub    $0xc,%esp
      p->sched_info.bjf.priority_ratio = priority_ratio;
80104f4f:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
      p->sched_info.bjf.arrival_time_ratio = arrival_time_ratio;
80104f55:	d9 45 10             	flds   0x10(%ebp)
80104f58:	d9 98 94 00 00 00    	fstps  0x94(%eax)
      p->sched_info.bjf.executed_cycle_ratio = executed_cycle_ratio;
80104f5e:	d9 45 14             	flds   0x14(%ebp)
80104f61:	d9 98 9c 00 00 00    	fstps  0x9c(%eax)
      p->sched_info.bjf.process_size_ratio = process_size_ratio;
80104f67:	d9 45 18             	flds   0x18(%ebp)
80104f6a:	d9 98 a4 00 00 00    	fstps  0xa4(%eax)
      release(&ptable.lock);
80104f70:	68 60 63 11 80       	push   $0x80116360
80104f75:	e8 e6 0e 00 00       	call   80105e60 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104f7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104f7d:	83 c4 10             	add    $0x10,%esp
80104f80:	31 c0                	xor    %eax,%eax
}
80104f82:	c9                   	leave  
80104f83:	c3                   	ret    
80104f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	68 60 63 11 80       	push   $0x80116360
80104f90:	e8 cb 0e 00 00       	call   80105e60 <release>
}
80104f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104f98:	83 c4 10             	add    $0x10,%esp
80104f9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fa0:	c9                   	leave  
80104fa1:	c3                   	ret    
80104fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <set_system_bjf_params>:

int set_system_bjf_params(float priority_ratio, float arrival_time_ratio, float executed_cycle_ratio, float process_size_ratio)
{
80104fb0:	f3 0f 1e fb          	endbr32 
80104fb4:	55                   	push   %ebp
80104fb5:	89 e5                	mov    %esp,%ebp
80104fb7:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104fba:	68 60 63 11 80       	push   $0x80116360
80104fbf:	e8 dc 0d 00 00       	call   80105da0 <acquire>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fc4:	d9 45 08             	flds   0x8(%ebp)
80104fc7:	d9 45 0c             	flds   0xc(%ebp)
  acquire(&ptable.lock);
80104fca:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fcd:	d9 45 10             	flds   0x10(%ebp)
80104fd0:	d9 45 14             	flds   0x14(%ebp)
80104fd3:	d9 cb                	fxch   %st(3)
80104fd5:	b8 94 63 11 80       	mov    $0x80116394,%eax
80104fda:	eb 0a                	jmp    80104fe6 <set_system_bjf_params+0x36>
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fe0:	d9 cb                	fxch   %st(3)
80104fe2:	d9 c9                	fxch   %st(1)
80104fe4:	d9 ca                	fxch   %st(2)
  {
    p->sched_info.bjf.priority_ratio = priority_ratio;
80104fe6:	d9 90 8c 00 00 00    	fsts   0x8c(%eax)
80104fec:	d9 ca                	fxch   %st(2)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fee:	05 ac 05 00 00       	add    $0x5ac,%eax
    p->sched_info.bjf.arrival_time_ratio = arrival_time_ratio;
80104ff3:	d9 90 e8 fa ff ff    	fsts   -0x518(%eax)
80104ff9:	d9 c9                	fxch   %st(1)
    p->sched_info.bjf.executed_cycle_ratio = executed_cycle_ratio;
80104ffb:	d9 90 f0 fa ff ff    	fsts   -0x510(%eax)
80105001:	d9 cb                	fxch   %st(3)
    p->sched_info.bjf.process_size_ratio = process_size_ratio;
80105003:	d9 90 f8 fa ff ff    	fsts   -0x508(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105009:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010500e:	75 d0                	jne    80104fe0 <set_system_bjf_params+0x30>
80105010:	dd d8                	fstp   %st(0)
80105012:	dd d8                	fstp   %st(0)
80105014:	dd d8                	fstp   %st(0)
80105016:	dd d8                	fstp   %st(0)
  }
  release(&ptable.lock);
80105018:	83 ec 0c             	sub    $0xc,%esp
8010501b:	68 60 63 11 80       	push   $0x80116360
80105020:	e8 3b 0e 00 00       	call   80105e60 <release>
  return 0;
}
80105025:	31 c0                	xor    %eax,%eax
80105027:	c9                   	leave  
80105028:	c3                   	ret    
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105030 <show_process_info>:

void show_process_info()
{
80105030:	f3 0f 1e fb          	endbr32 
80105034:	55                   	push   %ebp
80105035:	89 e5                	mov    %esp,%ebp
80105037:	57                   	push   %edi
80105038:	56                   	push   %esi
  static int columns[] = {16, 8, 9, 8, 8, 8, 9, 8, 8, 8, 8};
  cprintf("Process_Name    PID     State    Queue   Cycle   Arrival Priority R_Prty  R_Arvl  R_Exec  R_Size  Rank\n"
          "------------------------------------------------------------------------------------------------------\n");

  struct proc *p;
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105039:	be 94 63 11 80       	mov    $0x80116394,%esi
{
8010503e:	53                   	push   %ebx
    n/=10;
8010503f:	bb 67 66 66 66       	mov    $0x66666667,%ebx
{
80105044:	83 ec 28             	sub    $0x28,%esp
  cprintf("Process_Name    PID     State    Queue   Cycle   Arrival Priority R_Prty  R_Arvl  R_Exec  R_Size  Rank\n"
80105047:	68 28 a4 10 80       	push   $0x8010a428
8010504c:	e8 6f b8 ff ff       	call   801008c0 <cprintf>
80105051:	83 c4 10             	add    $0x10,%esp
80105054:	eb 1c                	jmp    80105072 <show_process_info+0x42>
80105056:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105060:	81 c6 ac 05 00 00    	add    $0x5ac,%esi
80105066:	81 fe 94 ce 12 80    	cmp    $0x8012ce94,%esi
8010506c:	0f 84 89 06 00 00    	je     801056fb <show_process_info+0x6cb>
  {
    if (p->state == UNUSED)
80105072:	8b 46 0c             	mov    0xc(%esi),%eax
80105075:	85 c0                	test   %eax,%eax
80105077:	74 e7                	je     80105060 <show_process_info+0x30>

    const char *state;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "unknown state";
80105079:	c7 45 e0 6d a3 10 80 	movl   $0x8010a36d,-0x20(%ebp)
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105080:	83 f8 05             	cmp    $0x5,%eax
80105083:	77 14                	ja     80105099 <show_process_info+0x69>
80105085:	8b 3c 85 8c a5 10 80 	mov    -0x7fef5a74(,%eax,4),%edi
      state = "unknown state";
8010508c:	b8 6d a3 10 80       	mov    $0x8010a36d,%eax
80105091:	85 ff                	test   %edi,%edi
80105093:	0f 45 c7             	cmovne %edi,%eax
80105096:	89 45 e0             	mov    %eax,-0x20(%ebp)

    cprintf("%s", p->name);
80105099:	83 ec 08             	sub    $0x8,%esp
8010509c:	8d 7e 6c             	lea    0x6c(%esi),%edi
8010509f:	57                   	push   %edi
801050a0:	68 46 a3 10 80       	push   $0x8010a346
801050a5:	e8 16 b8 ff ff       	call   801008c0 <cprintf>
    space(columns[0] - strlen(p->name));
801050aa:	89 3c 24             	mov    %edi,(%esp)
801050ad:	bf 10 00 00 00       	mov    $0x10,%edi
801050b2:	e8 f9 0f 00 00       	call   801060b0 <strlen>
  for(int i = 0; i < count; ++i)
801050b7:	83 c4 10             	add    $0x10,%esp
    space(columns[0] - strlen(p->name));
801050ba:	29 c7                	sub    %eax,%edi
801050bc:	89 f8                	mov    %edi,%eax
  for(int i = 0; i < count; ++i)
801050be:	31 ff                	xor    %edi,%edi
801050c0:	85 c0                	test   %eax,%eax
801050c2:	7e 26                	jle    801050ea <show_process_info+0xba>
801050c4:	89 75 dc             	mov    %esi,-0x24(%ebp)
801050c7:	89 fe                	mov    %edi,%esi
801050c9:	89 c7                	mov    %eax,%edi
801050cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050cf:	90                   	nop
    cprintf(" ");
801050d0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801050d3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801050d6:	68 fe a3 10 80       	push   $0x8010a3fe
801050db:	e8 e0 b7 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
801050e0:	83 c4 10             	add    $0x10,%esp
801050e3:	39 f7                	cmp    %esi,%edi
801050e5:	75 e9                	jne    801050d0 <show_process_info+0xa0>
801050e7:	8b 75 dc             	mov    -0x24(%ebp),%esi

    cprintf("%d", p->pid);
801050ea:	83 ec 08             	sub    $0x8,%esp
801050ed:	ff 76 10             	pushl  0x10(%esi)
  int num = 0;
801050f0:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->pid);
801050f2:	68 7b a3 10 80       	push   $0x8010a37b
801050f7:	e8 c4 b7 ff ff       	call   801008c0 <cprintf>
    space(columns[1] - num_digits(p->pid));
801050fc:	8b 4e 10             	mov    0x10(%esi),%ecx
  while(n!= 0) {
801050ff:	83 c4 10             	add    $0x10,%esp
    space(columns[1] - num_digits(p->pid));
80105102:	b8 08 00 00 00       	mov    $0x8,%eax
  while(n!= 0) {
80105107:	85 c9                	test   %ecx,%ecx
80105109:	74 23                	je     8010512e <show_process_info+0xfe>
8010510b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010510f:	90                   	nop
    n/=10;
80105110:	89 c8                	mov    %ecx,%eax
80105112:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80105115:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105118:	f7 eb                	imul   %ebx
8010511a:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010511d:	29 ca                	sub    %ecx,%edx
8010511f:	89 d1                	mov    %edx,%ecx
80105121:	75 ed                	jne    80105110 <show_process_info+0xe0>
    space(columns[1] - num_digits(p->pid));
80105123:	b8 08 00 00 00       	mov    $0x8,%eax
80105128:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
8010512a:	85 c0                	test   %eax,%eax
8010512c:	7e 2c                	jle    8010515a <show_process_info+0x12a>
    space(columns[1] - num_digits(p->pid));
8010512e:	31 ff                	xor    %edi,%edi
80105130:	89 75 dc             	mov    %esi,-0x24(%ebp)
80105133:	89 fe                	mov    %edi,%esi
80105135:	89 c7                	mov    %eax,%edi
80105137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513e:	66 90                	xchg   %ax,%ax
    cprintf(" ");
80105140:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105143:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105146:	68 fe a3 10 80       	push   $0x8010a3fe
8010514b:	e8 70 b7 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105150:	83 c4 10             	add    $0x10,%esp
80105153:	39 fe                	cmp    %edi,%esi
80105155:	7c e9                	jl     80105140 <show_process_info+0x110>
80105157:	8b 75 dc             	mov    -0x24(%ebp),%esi

    cprintf("%s", state);
8010515a:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010515d:	83 ec 08             	sub    $0x8,%esp
80105160:	57                   	push   %edi
80105161:	68 46 a3 10 80       	push   $0x8010a346
80105166:	e8 55 b7 ff ff       	call   801008c0 <cprintf>
    space(columns[2] - strlen(state));
8010516b:	89 3c 24             	mov    %edi,(%esp)
8010516e:	bf 09 00 00 00       	mov    $0x9,%edi
80105173:	e8 38 0f 00 00       	call   801060b0 <strlen>
  for(int i = 0; i < count; ++i)
80105178:	83 c4 10             	add    $0x10,%esp
    space(columns[2] - strlen(state));
8010517b:	29 c7                	sub    %eax,%edi
8010517d:	89 f8                	mov    %edi,%eax
  for(int i = 0; i < count; ++i)
8010517f:	31 ff                	xor    %edi,%edi
80105181:	85 c0                	test   %eax,%eax
80105183:	7e 25                	jle    801051aa <show_process_info+0x17a>
80105185:	89 75 e0             	mov    %esi,-0x20(%ebp)
80105188:	89 fe                	mov    %edi,%esi
8010518a:	89 c7                	mov    %eax,%edi
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" ");
80105190:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105193:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105196:	68 fe a3 10 80       	push   $0x8010a3fe
8010519b:	e8 20 b7 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
801051a0:	83 c4 10             	add    $0x10,%esp
801051a3:	39 f7                	cmp    %esi,%edi
801051a5:	75 e9                	jne    80105190 <show_process_info+0x160>
801051a7:	8b 75 e0             	mov    -0x20(%ebp),%esi

    cprintf("%d", p->sched_info.queue);
801051aa:	83 ec 08             	sub    $0x8,%esp
801051ad:	ff b6 80 00 00 00    	pushl  0x80(%esi)
  int num = 0;
801051b3:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->sched_info.queue);
801051b5:	68 7b a3 10 80       	push   $0x8010a37b
801051ba:	e8 01 b7 ff ff       	call   801008c0 <cprintf>
    space(columns[3] - num_digits(p->sched_info.queue));
801051bf:	8b 8e 80 00 00 00    	mov    0x80(%esi),%ecx
  while(n!= 0) {
801051c5:	83 c4 10             	add    $0x10,%esp
    space(columns[3] - num_digits(p->sched_info.queue));
801051c8:	b8 08 00 00 00       	mov    $0x8,%eax
  while(n!= 0) {
801051cd:	85 c9                	test   %ecx,%ecx
801051cf:	74 25                	je     801051f6 <show_process_info+0x1c6>
801051d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n/=10;
801051d8:	89 c8                	mov    %ecx,%eax
801051da:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
801051dd:	83 c7 01             	add    $0x1,%edi
    n/=10;
801051e0:	f7 eb                	imul   %ebx
801051e2:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801051e5:	29 ca                	sub    %ecx,%edx
801051e7:	89 d1                	mov    %edx,%ecx
801051e9:	75 ed                	jne    801051d8 <show_process_info+0x1a8>
    space(columns[3] - num_digits(p->sched_info.queue));
801051eb:	b8 08 00 00 00       	mov    $0x8,%eax
801051f0:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
801051f2:	85 c0                	test   %eax,%eax
801051f4:	7e 24                	jle    8010521a <show_process_info+0x1ea>
    space(columns[3] - num_digits(p->sched_info.queue));
801051f6:	31 ff                	xor    %edi,%edi
801051f8:	89 75 e0             	mov    %esi,-0x20(%ebp)
801051fb:	89 fe                	mov    %edi,%esi
801051fd:	89 c7                	mov    %eax,%edi
801051ff:	90                   	nop
    cprintf(" ");
80105200:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105203:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105206:	68 fe a3 10 80       	push   $0x8010a3fe
8010520b:	e8 b0 b6 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105210:	83 c4 10             	add    $0x10,%esp
80105213:	39 f7                	cmp    %esi,%edi
80105215:	7f e9                	jg     80105200 <show_process_info+0x1d0>
80105217:	8b 75 e0             	mov    -0x20(%ebp),%esi

    cprintf("%d", (int)p->sched_info.bjf.executed_cycle);
8010521a:	d9 86 98 00 00 00    	flds   0x98(%esi)
80105220:	83 ec 08             	sub    $0x8,%esp
  int num = 0;
80105223:	31 ff                	xor    %edi,%edi
    cprintf("%d", (int)p->sched_info.bjf.executed_cycle);
80105225:	d9 7d e6             	fnstcw -0x1a(%ebp)
80105228:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
8010522c:	80 cc 0c             	or     $0xc,%ah
8010522f:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
80105233:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105236:	db 5d e0             	fistpl -0x20(%ebp)
80105239:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010523c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010523f:	50                   	push   %eax
80105240:	68 7b a3 10 80       	push   $0x8010a37b
80105245:	e8 76 b6 ff ff       	call   801008c0 <cprintf>
    space(columns[4] - num_digits((int)p->sched_info.bjf.executed_cycle));
8010524a:	d9 86 98 00 00 00    	flds   0x98(%esi)
  while(n!= 0) {
80105250:	83 c4 10             	add    $0x10,%esp
    space(columns[4] - num_digits((int)p->sched_info.bjf.executed_cycle));
80105253:	d9 7d e6             	fnstcw -0x1a(%ebp)
80105256:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
8010525a:	80 cc 0c             	or     $0xc,%ah
8010525d:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
80105261:	b8 08 00 00 00       	mov    $0x8,%eax
80105266:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105269:	db 5d e0             	fistpl -0x20(%ebp)
8010526c:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010526f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  while(n!= 0) {
80105272:	85 c9                	test   %ecx,%ecx
80105274:	74 28                	je     8010529e <show_process_info+0x26e>
80105276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010527d:	8d 76 00             	lea    0x0(%esi),%esi
    n/=10;
80105280:	89 c8                	mov    %ecx,%eax
80105282:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80105285:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105288:	f7 eb                	imul   %ebx
8010528a:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010528d:	29 ca                	sub    %ecx,%edx
8010528f:	89 d1                	mov    %edx,%ecx
80105291:	75 ed                	jne    80105280 <show_process_info+0x250>
    space(columns[4] - num_digits((int)p->sched_info.bjf.executed_cycle));
80105293:	b8 08 00 00 00       	mov    $0x8,%eax
80105298:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
8010529a:	85 c0                	test   %eax,%eax
8010529c:	7e 2c                	jle    801052ca <show_process_info+0x29a>
    space(columns[4] - num_digits((int)p->sched_info.bjf.executed_cycle));
8010529e:	31 ff                	xor    %edi,%edi
801052a0:	89 75 e0             	mov    %esi,-0x20(%ebp)
801052a3:	89 fe                	mov    %edi,%esi
801052a5:	89 c7                	mov    %eax,%edi
801052a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ae:	66 90                	xchg   %ax,%ax
    cprintf(" ");
801052b0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801052b3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801052b6:	68 fe a3 10 80       	push   $0x8010a3fe
801052bb:	e8 00 b6 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
801052c0:	83 c4 10             	add    $0x10,%esp
801052c3:	39 fe                	cmp    %edi,%esi
801052c5:	7c e9                	jl     801052b0 <show_process_info+0x280>
801052c7:	8b 75 e0             	mov    -0x20(%ebp),%esi

    cprintf("%d", p->sched_info.bjf.arrival_time);
801052ca:	83 ec 08             	sub    $0x8,%esp
801052cd:	ff b6 90 00 00 00    	pushl  0x90(%esi)
  int num = 0;
801052d3:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->sched_info.bjf.arrival_time);
801052d5:	68 7b a3 10 80       	push   $0x8010a37b
801052da:	e8 e1 b5 ff ff       	call   801008c0 <cprintf>
    space(columns[5] - num_digits(p->sched_info.bjf.arrival_time));
801052df:	8b 8e 90 00 00 00    	mov    0x90(%esi),%ecx
  while(n!= 0) {
801052e5:	83 c4 10             	add    $0x10,%esp
    space(columns[5] - num_digits(p->sched_info.bjf.arrival_time));
801052e8:	b8 08 00 00 00       	mov    $0x8,%eax
  while(n!= 0) {
801052ed:	85 c9                	test   %ecx,%ecx
801052ef:	74 25                	je     80105316 <show_process_info+0x2e6>
801052f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n/=10;
801052f8:	89 c8                	mov    %ecx,%eax
801052fa:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
801052fd:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105300:	f7 eb                	imul   %ebx
80105302:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105305:	29 ca                	sub    %ecx,%edx
80105307:	89 d1                	mov    %edx,%ecx
80105309:	75 ed                	jne    801052f8 <show_process_info+0x2c8>
    space(columns[5] - num_digits(p->sched_info.bjf.arrival_time));
8010530b:	b8 08 00 00 00       	mov    $0x8,%eax
80105310:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
80105312:	85 c0                	test   %eax,%eax
80105314:	7e 24                	jle    8010533a <show_process_info+0x30a>
    space(columns[5] - num_digits(p->sched_info.bjf.arrival_time));
80105316:	31 ff                	xor    %edi,%edi
80105318:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010531b:	89 fe                	mov    %edi,%esi
8010531d:	89 c7                	mov    %eax,%edi
8010531f:	90                   	nop
    cprintf(" ");
80105320:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105323:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105326:	68 fe a3 10 80       	push   $0x8010a3fe
8010532b:	e8 90 b5 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105330:	83 c4 10             	add    $0x10,%esp
80105333:	39 fe                	cmp    %edi,%esi
80105335:	7c e9                	jl     80105320 <show_process_info+0x2f0>
80105337:	8b 75 e0             	mov    -0x20(%ebp),%esi

    cprintf("%d", p->sched_info.bjf.priority);
8010533a:	83 ec 08             	sub    $0x8,%esp
8010533d:	ff b6 88 00 00 00    	pushl  0x88(%esi)
  int num = 0;
80105343:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->sched_info.bjf.priority);
80105345:	68 7b a3 10 80       	push   $0x8010a37b
8010534a:	e8 71 b5 ff ff       	call   801008c0 <cprintf>
    space(columns[6] - num_digits(p->sched_info.bjf.priority));
8010534f:	8b 8e 88 00 00 00    	mov    0x88(%esi),%ecx
  while(n!= 0) {
80105355:	83 c4 10             	add    $0x10,%esp
    space(columns[6] - num_digits(p->sched_info.bjf.priority));
80105358:	b8 09 00 00 00       	mov    $0x9,%eax
  while(n!= 0) {
8010535d:	85 c9                	test   %ecx,%ecx
8010535f:	74 25                	je     80105386 <show_process_info+0x356>
80105361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n/=10;
80105368:	89 c8                	mov    %ecx,%eax
8010536a:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
8010536d:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105370:	f7 eb                	imul   %ebx
80105372:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
80105375:	29 ca                	sub    %ecx,%edx
80105377:	89 d1                	mov    %edx,%ecx
80105379:	75 ed                	jne    80105368 <show_process_info+0x338>
    space(columns[6] - num_digits(p->sched_info.bjf.priority));
8010537b:	b8 09 00 00 00       	mov    $0x9,%eax
80105380:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
80105382:	85 c0                	test   %eax,%eax
80105384:	7e 24                	jle    801053aa <show_process_info+0x37a>
    space(columns[6] - num_digits(p->sched_info.bjf.priority));
80105386:	31 ff                	xor    %edi,%edi
80105388:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010538b:	89 fe                	mov    %edi,%esi
8010538d:	89 c7                	mov    %eax,%edi
8010538f:	90                   	nop
    cprintf(" ");
80105390:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105393:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105396:	68 fe a3 10 80       	push   $0x8010a3fe
8010539b:	e8 20 b5 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
801053a0:	83 c4 10             	add    $0x10,%esp
801053a3:	39 fe                	cmp    %edi,%esi
801053a5:	7c e9                	jl     80105390 <show_process_info+0x360>
801053a7:	8b 75 e0             	mov    -0x20(%ebp),%esi

    cprintf("%d", (int)p->sched_info.bjf.priority_ratio);
801053aa:	d9 86 8c 00 00 00    	flds   0x8c(%esi)
801053b0:	83 ec 08             	sub    $0x8,%esp
  int num = 0;
801053b3:	31 ff                	xor    %edi,%edi
    cprintf("%d", (int)p->sched_info.bjf.priority_ratio);
801053b5:	d9 7d e6             	fnstcw -0x1a(%ebp)
801053b8:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
801053bc:	80 cc 0c             	or     $0xc,%ah
801053bf:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
801053c3:	d9 6d e4             	fldcw  -0x1c(%ebp)
801053c6:	db 5d e0             	fistpl -0x20(%ebp)
801053c9:	d9 6d e6             	fldcw  -0x1a(%ebp)
801053cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053cf:	50                   	push   %eax
801053d0:	68 7b a3 10 80       	push   $0x8010a37b
801053d5:	e8 e6 b4 ff ff       	call   801008c0 <cprintf>
    space(columns[7] - num_digits((int)p->sched_info.bjf.priority_ratio));
801053da:	d9 86 8c 00 00 00    	flds   0x8c(%esi)
  while(n!= 0) {
801053e0:	83 c4 10             	add    $0x10,%esp
    space(columns[7] - num_digits((int)p->sched_info.bjf.priority_ratio));
801053e3:	d9 7d e6             	fnstcw -0x1a(%ebp)
801053e6:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
801053ea:	80 cc 0c             	or     $0xc,%ah
801053ed:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
801053f1:	b8 08 00 00 00       	mov    $0x8,%eax
801053f6:	d9 6d e4             	fldcw  -0x1c(%ebp)
801053f9:	db 5d e0             	fistpl -0x20(%ebp)
801053fc:	d9 6d e6             	fldcw  -0x1a(%ebp)
801053ff:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  while(n!= 0) {
80105402:	85 c9                	test   %ecx,%ecx
80105404:	74 28                	je     8010542e <show_process_info+0x3fe>
80105406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
    n/=10;
80105410:	89 c8                	mov    %ecx,%eax
80105412:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80105415:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105418:	f7 eb                	imul   %ebx
8010541a:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010541d:	29 ca                	sub    %ecx,%edx
8010541f:	89 d1                	mov    %edx,%ecx
80105421:	75 ed                	jne    80105410 <show_process_info+0x3e0>
    space(columns[7] - num_digits((int)p->sched_info.bjf.priority_ratio));
80105423:	b8 08 00 00 00       	mov    $0x8,%eax
80105428:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
8010542a:	85 c0                	test   %eax,%eax
8010542c:	7e 3a                	jle    80105468 <show_process_info+0x438>
    space(columns[7] - num_digits((int)p->sched_info.bjf.priority_ratio));
8010542e:	31 ff                	xor    %edi,%edi
80105430:	89 75 e0             	mov    %esi,-0x20(%ebp)
80105433:	89 fe                	mov    %edi,%esi
80105435:	89 c7                	mov    %eax,%edi
80105437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010543e:	66 90                	xchg   %ax,%ax
    cprintf(" ");
80105440:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105443:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105446:	68 fe a3 10 80       	push   $0x8010a3fe
8010544b:	e8 70 b4 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105450:	83 c4 10             	add    $0x10,%esp
80105453:	39 fe                	cmp    %edi,%esi
80105455:	7c e9                	jl     80105440 <show_process_info+0x410>
80105457:	d9 7d e6             	fnstcw -0x1a(%ebp)
8010545a:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010545d:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
80105461:	80 cc 0c             	or     $0xc,%ah
80105464:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)

    cprintf("%d", (int)p->sched_info.bjf.arrival_time_ratio);
80105468:	d9 86 94 00 00 00    	flds   0x94(%esi)
8010546e:	83 ec 08             	sub    $0x8,%esp
  int num = 0;
80105471:	31 ff                	xor    %edi,%edi
    cprintf("%d", (int)p->sched_info.bjf.arrival_time_ratio);
80105473:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105476:	db 5d e0             	fistpl -0x20(%ebp)
80105479:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010547c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010547f:	50                   	push   %eax
80105480:	68 7b a3 10 80       	push   $0x8010a37b
80105485:	e8 36 b4 ff ff       	call   801008c0 <cprintf>
    space(columns[8] - num_digits((int)p->sched_info.bjf.arrival_time_ratio));
8010548a:	d9 86 94 00 00 00    	flds   0x94(%esi)
  while(n!= 0) {
80105490:	83 c4 10             	add    $0x10,%esp
    space(columns[8] - num_digits((int)p->sched_info.bjf.arrival_time_ratio));
80105493:	d9 7d e6             	fnstcw -0x1a(%ebp)
80105496:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
8010549a:	80 cc 0c             	or     $0xc,%ah
8010549d:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
801054a1:	b8 08 00 00 00       	mov    $0x8,%eax
801054a6:	d9 6d e4             	fldcw  -0x1c(%ebp)
801054a9:	db 5d e0             	fistpl -0x20(%ebp)
801054ac:	d9 6d e6             	fldcw  -0x1a(%ebp)
801054af:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  while(n!= 0) {
801054b2:	85 c9                	test   %ecx,%ecx
801054b4:	74 28                	je     801054de <show_process_info+0x4ae>
801054b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054bd:	8d 76 00             	lea    0x0(%esi),%esi
    n/=10;
801054c0:	89 c8                	mov    %ecx,%eax
801054c2:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
801054c5:	83 c7 01             	add    $0x1,%edi
    n/=10;
801054c8:	f7 eb                	imul   %ebx
801054ca:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
801054cd:	29 ca                	sub    %ecx,%edx
801054cf:	89 d1                	mov    %edx,%ecx
801054d1:	75 ed                	jne    801054c0 <show_process_info+0x490>
    space(columns[8] - num_digits((int)p->sched_info.bjf.arrival_time_ratio));
801054d3:	b8 08 00 00 00       	mov    $0x8,%eax
801054d8:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
801054da:	85 c0                	test   %eax,%eax
801054dc:	7e 3a                	jle    80105518 <show_process_info+0x4e8>
    space(columns[8] - num_digits((int)p->sched_info.bjf.arrival_time_ratio));
801054de:	31 ff                	xor    %edi,%edi
801054e0:	89 75 e0             	mov    %esi,-0x20(%ebp)
801054e3:	89 fe                	mov    %edi,%esi
801054e5:	89 c7                	mov    %eax,%edi
801054e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ee:	66 90                	xchg   %ax,%ax
    cprintf(" ");
801054f0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801054f3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801054f6:	68 fe a3 10 80       	push   $0x8010a3fe
801054fb:	e8 c0 b3 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105500:	83 c4 10             	add    $0x10,%esp
80105503:	39 fe                	cmp    %edi,%esi
80105505:	7c e9                	jl     801054f0 <show_process_info+0x4c0>
80105507:	d9 7d e6             	fnstcw -0x1a(%ebp)
8010550a:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010550d:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
80105511:	80 cc 0c             	or     $0xc,%ah
80105514:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)

    cprintf("%d", (int)p->sched_info.bjf.executed_cycle_ratio);
80105518:	d9 86 9c 00 00 00    	flds   0x9c(%esi)
8010551e:	83 ec 08             	sub    $0x8,%esp
  int num = 0;
80105521:	31 ff                	xor    %edi,%edi
    cprintf("%d", (int)p->sched_info.bjf.executed_cycle_ratio);
80105523:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105526:	db 5d e0             	fistpl -0x20(%ebp)
80105529:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010552c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010552f:	50                   	push   %eax
80105530:	68 7b a3 10 80       	push   $0x8010a37b
80105535:	e8 86 b3 ff ff       	call   801008c0 <cprintf>
    space(columns[9] - num_digits((int)p->sched_info.bjf.executed_cycle_ratio));
8010553a:	d9 86 9c 00 00 00    	flds   0x9c(%esi)
  while(n!= 0) {
80105540:	83 c4 10             	add    $0x10,%esp
    space(columns[9] - num_digits((int)p->sched_info.bjf.executed_cycle_ratio));
80105543:	d9 7d e6             	fnstcw -0x1a(%ebp)
80105546:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
8010554a:	80 cc 0c             	or     $0xc,%ah
8010554d:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
80105551:	b8 08 00 00 00       	mov    $0x8,%eax
80105556:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105559:	db 5d e0             	fistpl -0x20(%ebp)
8010555c:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010555f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  while(n!= 0) {
80105562:	85 c9                	test   %ecx,%ecx
80105564:	74 28                	je     8010558e <show_process_info+0x55e>
80105566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010556d:	8d 76 00             	lea    0x0(%esi),%esi
    n/=10;
80105570:	89 c8                	mov    %ecx,%eax
80105572:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80105575:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105578:	f7 eb                	imul   %ebx
8010557a:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010557d:	29 ca                	sub    %ecx,%edx
8010557f:	89 d1                	mov    %edx,%ecx
80105581:	75 ed                	jne    80105570 <show_process_info+0x540>
    space(columns[9] - num_digits((int)p->sched_info.bjf.executed_cycle_ratio));
80105583:	b8 08 00 00 00       	mov    $0x8,%eax
80105588:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
8010558a:	85 c0                	test   %eax,%eax
8010558c:	7e 3a                	jle    801055c8 <show_process_info+0x598>
    space(columns[9] - num_digits((int)p->sched_info.bjf.executed_cycle_ratio));
8010558e:	31 ff                	xor    %edi,%edi
80105590:	89 75 e0             	mov    %esi,-0x20(%ebp)
80105593:	89 fe                	mov    %edi,%esi
80105595:	89 c7                	mov    %eax,%edi
80105597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010559e:	66 90                	xchg   %ax,%ax
    cprintf(" ");
801055a0:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
801055a3:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
801055a6:	68 fe a3 10 80       	push   $0x8010a3fe
801055ab:	e8 10 b3 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
801055b0:	83 c4 10             	add    $0x10,%esp
801055b3:	39 fe                	cmp    %edi,%esi
801055b5:	7c e9                	jl     801055a0 <show_process_info+0x570>
801055b7:	d9 7d e6             	fnstcw -0x1a(%ebp)
801055ba:	8b 75 e0             	mov    -0x20(%ebp),%esi
801055bd:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
801055c1:	80 cc 0c             	or     $0xc,%ah
801055c4:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)

    cprintf("%d", (int)p->sched_info.bjf.process_size_ratio);
801055c8:	d9 86 a4 00 00 00    	flds   0xa4(%esi)
801055ce:	83 ec 08             	sub    $0x8,%esp
  int num = 0;
801055d1:	31 ff                	xor    %edi,%edi
    cprintf("%d", (int)p->sched_info.bjf.process_size_ratio);
801055d3:	d9 6d e4             	fldcw  -0x1c(%ebp)
801055d6:	db 5d e0             	fistpl -0x20(%ebp)
801055d9:	d9 6d e6             	fldcw  -0x1a(%ebp)
801055dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055df:	50                   	push   %eax
801055e0:	68 7b a3 10 80       	push   $0x8010a37b
801055e5:	e8 d6 b2 ff ff       	call   801008c0 <cprintf>
    space(columns[10] - num_digits((int)p->sched_info.bjf.process_size_ratio));
801055ea:	d9 86 a4 00 00 00    	flds   0xa4(%esi)
  while(n!= 0) {
801055f0:	83 c4 10             	add    $0x10,%esp
    space(columns[10] - num_digits((int)p->sched_info.bjf.process_size_ratio));
801055f3:	d9 7d e6             	fnstcw -0x1a(%ebp)
801055f6:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
801055fa:	80 cc 0c             	or     $0xc,%ah
801055fd:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
80105601:	b8 08 00 00 00       	mov    $0x8,%eax
80105606:	d9 6d e4             	fldcw  -0x1c(%ebp)
80105609:	db 55 e0             	fistl  -0x20(%ebp)
8010560c:	d9 6d e6             	fldcw  -0x1a(%ebp)
8010560f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  while(n!= 0) {
80105612:	85 c9                	test   %ecx,%ecx
80105614:	74 32                	je     80105648 <show_process_info+0x618>
80105616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010561d:	8d 76 00             	lea    0x0(%esi),%esi
    n/=10;
80105620:	89 c8                	mov    %ecx,%eax
80105622:	c1 f9 1f             	sar    $0x1f,%ecx
    num += 1;
80105625:	83 c7 01             	add    $0x1,%edi
    n/=10;
80105628:	f7 eb                	imul   %ebx
8010562a:	c1 fa 02             	sar    $0x2,%edx
  while(n!= 0) {
8010562d:	29 ca                	sub    %ecx,%edx
8010562f:	89 d1                	mov    %edx,%ecx
80105631:	75 ed                	jne    80105620 <show_process_info+0x5f0>
    space(columns[10] - num_digits((int)p->sched_info.bjf.process_size_ratio));
80105633:	b8 08 00 00 00       	mov    $0x8,%eax
80105638:	29 f8                	sub    %edi,%eax
  for(int i = 0; i < count; ++i)
8010563a:	85 c0                	test   %eax,%eax
8010563c:	7e 50                	jle    8010568e <show_process_info+0x65e>
8010563e:	dd d8                	fstp   %st(0)
80105640:	eb 0e                	jmp    80105650 <show_process_info+0x620>
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105648:	dd d8                	fstp   %st(0)
8010564a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    space(columns[10] - num_digits((int)p->sched_info.bjf.process_size_ratio));
80105650:	31 ff                	xor    %edi,%edi
80105652:	89 75 e0             	mov    %esi,-0x20(%ebp)
80105655:	89 fe                	mov    %edi,%esi
80105657:	89 c7                	mov    %eax,%edi
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" ");
80105660:	83 ec 0c             	sub    $0xc,%esp
  for(int i = 0; i < count; ++i)
80105663:	83 c6 01             	add    $0x1,%esi
    cprintf(" ");
80105666:	68 fe a3 10 80       	push   $0x8010a3fe
8010566b:	e8 50 b2 ff ff       	call   801008c0 <cprintf>
  for(int i = 0; i < count; ++i)
80105670:	83 c4 10             	add    $0x10,%esp
80105673:	39 fe                	cmp    %edi,%esi
80105675:	7c e9                	jl     80105660 <show_process_info+0x630>
80105677:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010567a:	d9 86 a4 00 00 00    	flds   0xa4(%esi)
80105680:	d9 7d e6             	fnstcw -0x1a(%ebp)
80105683:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
80105687:	80 cc 0c             	or     $0xc,%ah
8010568a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
8010568e:	db 86 90 00 00 00    	fildl  0x90(%esi)
80105694:	d8 8e 94 00 00 00    	fmuls  0x94(%esi)

    cprintf("%d", (int)bjfrank(p));
8010569a:	83 ec 08             	sub    $0x8,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010569d:	81 c6 ac 05 00 00    	add    $0x5ac,%esi
  return p->sched_info.bjf.priority * p->sched_info.bjf.priority_ratio +
801056a3:	db 86 dc fa ff ff    	fildl  -0x524(%esi)
801056a9:	d8 8e e0 fa ff ff    	fmuls  -0x520(%esi)
801056af:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
801056b1:	d9 86 ec fa ff ff    	flds   -0x514(%esi)
801056b7:	d8 8e f0 fa ff ff    	fmuls  -0x510(%esi)
         p->sched_info.bjf.arrival_time * p->sched_info.bjf.arrival_time_ratio +
801056bd:	de c1                	faddp  %st,%st(1)
         p->sched_info.bjf.process_size * p->sched_info.bjf.process_size_ratio;
801056bf:	db 86 f4 fa ff ff    	fildl  -0x50c(%esi)
801056c5:	de ca                	fmulp  %st,%st(2)
         p->sched_info.bjf.executed_cycle * p->sched_info.bjf.executed_cycle_ratio +
801056c7:	de c1                	faddp  %st,%st(1)
    cprintf("%d", (int)bjfrank(p));
801056c9:	d9 6d e4             	fldcw  -0x1c(%ebp)
801056cc:	db 5d e0             	fistpl -0x20(%ebp)
801056cf:	d9 6d e6             	fldcw  -0x1a(%ebp)
801056d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801056d5:	50                   	push   %eax
801056d6:	68 7b a3 10 80       	push   $0x8010a37b
801056db:	e8 e0 b1 ff ff       	call   801008c0 <cprintf>
    cprintf("\n");
801056e0:	c7 04 24 85 a3 10 80 	movl   $0x8010a385,(%esp)
801056e7:	e8 d4 b1 ff ff       	call   801008c0 <cprintf>
801056ec:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801056ef:	81 fe 94 ce 12 80    	cmp    $0x8012ce94,%esi
801056f5:	0f 85 77 f9 ff ff    	jne    80105072 <show_process_info+0x42>
  }
}
801056fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056fe:	5b                   	pop    %ebx
801056ff:	5e                   	pop    %esi
80105700:	5f                   	pop    %edi
80105701:	5d                   	pop    %ebp
80105702:	c3                   	ret    
80105703:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010570a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105710 <priority_wakeup>:

void priority_wakeup(void* chan){
80105710:	f3 0f 1e fb          	endbr32 
80105714:	55                   	push   %ebp
80105715:	89 e5                	mov    %esp,%ebp
80105717:	56                   	push   %esi
80105718:	53                   	push   %ebx
80105719:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010571c:	83 ec 0c             	sub    $0xc,%esp
8010571f:	68 60 63 11 80       	push   $0x80116360
80105724:	e8 77 06 00 00       	call   80105da0 <acquire>
80105729:	83 c4 10             	add    $0x10,%esp
  struct proc *p;
  struct proc * p_max_pid = 0 ;
  int first = 1 ; 
8010572c:	b9 01 00 00 00       	mov    $0x1,%ecx
  struct proc * p_max_pid = 0 ;
80105731:	31 d2                	xor    %edx,%edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105733:	b8 94 63 11 80       	mov    $0x80116394,%eax
80105738:	eb 12                	jmp    8010574c <priority_wakeup+0x3c>
8010573a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105740:	05 ac 05 00 00       	add    $0x5ac,%eax
80105745:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010574a:	74 24                	je     80105770 <priority_wakeup+0x60>
    if(p->state == SLEEPING && p->chan == chan){
8010574c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80105750:	75 ee                	jne    80105740 <priority_wakeup+0x30>
80105752:	39 58 20             	cmp    %ebx,0x20(%eax)
80105755:	75 e9                	jne    80105740 <priority_wakeup+0x30>
      if(first){
80105757:	85 c9                	test   %ecx,%ecx
80105759:	75 35                	jne    80105790 <priority_wakeup+0x80>
        p_max_pid = p;
        first = 0;
      }
      else{
        if(p->pid > p_max_pid->pid){
8010575b:	8b 72 10             	mov    0x10(%edx),%esi
8010575e:	39 70 10             	cmp    %esi,0x10(%eax)
80105761:	0f 4f d0             	cmovg  %eax,%edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105764:	05 ac 05 00 00       	add    $0x5ac,%eax
80105769:	3d 94 ce 12 80       	cmp    $0x8012ce94,%eax
8010576e:	75 dc                	jne    8010574c <priority_wakeup+0x3c>
          p_max_pid = p;
        }
      }
    }
  }
  if (p_max_pid)
80105770:	85 d2                	test   %edx,%edx
80105772:	74 07                	je     8010577b <priority_wakeup+0x6b>
  {
      p_max_pid->state = RUNNABLE;
80105774:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)

    
  }
  
  release(&ptable.lock);
8010577b:	c7 45 08 60 63 11 80 	movl   $0x80116360,0x8(%ebp)
}
80105782:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105785:	5b                   	pop    %ebx
80105786:	5e                   	pop    %esi
80105787:	5d                   	pop    %ebp
  release(&ptable.lock);
80105788:	e9 d3 06 00 00       	jmp    80105e60 <release>
8010578d:	8d 76 00             	lea    0x0(%esi),%esi
80105790:	89 c2                	mov    %eax,%edx
        first = 0;
80105792:	31 c9                	xor    %ecx,%ecx
80105794:	eb aa                	jmp    80105740 <priority_wakeup+0x30>
80105796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010579d:	8d 76 00             	lea    0x0(%esi),%esi

801057a0 <compare_pid>:

int compare_pid(const void *a, const void *b) {
801057a0:	f3 0f 1e fb          	endbr32 
801057a4:	55                   	push   %ebp
801057a5:	89 e5                	mov    %esp,%ebp
  struct proc *procA = (struct proc *)a;
  struct proc *procB = (struct proc *)b;
  return procA->pid - procB->pid;
801057a7:	8b 45 08             	mov    0x8(%ebp),%eax
801057aa:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801057ad:	5d                   	pop    %ebp
  return procA->pid - procB->pid;
801057ae:	8b 40 10             	mov    0x10(%eax),%eax
801057b1:	2b 42 10             	sub    0x10(%edx),%eax
}
801057b4:	c3                   	ret    
801057b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057c0 <make_priority_queue>:


void make_priority_queue(void * chan) {
801057c0:	f3 0f 1e fb          	endbr32 
801057c4:	55                   	push   %ebp
801057c5:	89 e5                	mov    %esp,%ebp
801057c7:	57                   	push   %edi
    // Handle the allocation failure 
    release(&ptable.lock);
    return;
  }*/

  int first = 1;
801057c8:	bf 01 00 00 00       	mov    $0x1,%edi
void make_priority_queue(void * chan) {
801057cd:	56                   	push   %esi
801057ce:	53                   	push   %ebx
  int i = 0;
  cprintf("Queue: \n" );
  // Populate the queue with processes that match the channel
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801057cf:	bb 94 63 11 80       	mov    $0x80116394,%ebx
void make_priority_queue(void * chan) {
801057d4:	83 ec 18             	sub    $0x18,%esp
801057d7:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock); // Lock the ptable before making changes
801057da:	68 60 63 11 80       	push   $0x80116360
801057df:	e8 bc 05 00 00       	call   80105da0 <acquire>
  cprintf("Queue: \n" );
801057e4:	c7 04 24 7e a3 10 80 	movl   $0x8010a37e,(%esp)
801057eb:	e8 d0 b0 ff ff       	call   801008c0 <cprintf>
801057f0:	83 c4 10             	add    $0x10,%esp
  struct proc *proc_queue = 0;
801057f3:	31 d2                	xor    %edx,%edx
801057f5:	eb 17                	jmp    8010580e <make_priority_queue+0x4e>
801057f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057fe:	66 90                	xchg   %ax,%ax
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105800:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
80105806:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
8010580c:	74 42                	je     80105850 <make_priority_queue+0x90>
    if (p->state == SLEEPING && p->chan == chan) {
8010580e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80105812:	75 ec                	jne    80105800 <make_priority_queue+0x40>
80105814:	39 73 20             	cmp    %esi,0x20(%ebx)
80105817:	75 e7                	jne    80105800 <make_priority_queue+0x40>
      if(first){
80105819:	85 ff                	test   %edi,%edi
8010581b:	75 63                	jne    80105880 <make_priority_queue+0xc0>
8010581d:	8b 43 10             	mov    0x10(%ebx),%eax
        proc_queue = p ;
        first = 0;
        i ++;
        cprintf("Pid %d , Name: %s \n", p->pid , p->name );
      }
      else if(p->pid > proc_queue->pid){
80105820:	39 42 10             	cmp    %eax,0x10(%edx)
80105823:	7d db                	jge    80105800 <make_priority_queue+0x40>
        proc_queue = p ;
        i ++ ;
        cprintf("Pid %d , Name: %s \n", p->pid , p->name );
80105825:	83 ec 04             	sub    $0x4,%esp
80105828:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010582b:	52                   	push   %edx
8010582c:	50                   	push   %eax
8010582d:	68 87 a3 10 80       	push   $0x8010a387
80105832:	e8 89 b0 ff ff       	call   801008c0 <cprintf>
80105837:	89 da                	mov    %ebx,%edx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105839:	81 c3 ac 05 00 00    	add    $0x5ac,%ebx
        cprintf("Pid %d , Name: %s \n", p->pid , p->name );
8010583f:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105842:	81 fb 94 ce 12 80    	cmp    $0x8012ce94,%ebx
80105848:	75 c4                	jne    8010580e <make_priority_queue+0x4e>
8010584a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
    }
  }
  if(first){
80105850:	85 ff                	test   %edi,%edi
80105852:	74 4c                	je     801058a0 <make_priority_queue+0xe0>
    cprintf("Queue is empty\n");
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	68 9b a3 10 80       	push   $0x8010a39b
8010585c:	e8 5f b0 ff ff       	call   801008c0 <cprintf>
80105861:	83 c4 10             	add    $0x10,%esp
  // Sort the queue by pid using the comparison function
  //qsort(proc_queue, i, sizeof(struct proc), compare_pid);
  


  release(&ptable.lock); // Release the lock after modifications are done
80105864:	c7 45 08 60 63 11 80 	movl   $0x80116360,0x8(%ebp)
}
8010586b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010586e:	5b                   	pop    %ebx
8010586f:	5e                   	pop    %esi
80105870:	5f                   	pop    %edi
80105871:	5d                   	pop    %ebp
  release(&ptable.lock); // Release the lock after modifications are done
80105872:	e9 e9 05 00 00       	jmp    80105e60 <release>
80105877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010587e:	66 90                	xchg   %ax,%ax
        cprintf("Pid %d , Name: %s \n", p->pid , p->name );
80105880:	83 ec 04             	sub    $0x4,%esp
80105883:	8d 43 6c             	lea    0x6c(%ebx),%eax
        first = 0;
80105886:	31 ff                	xor    %edi,%edi
        cprintf("Pid %d , Name: %s \n", p->pid , p->name );
80105888:	50                   	push   %eax
80105889:	ff 73 10             	pushl  0x10(%ebx)
8010588c:	68 87 a3 10 80       	push   $0x8010a387
80105891:	e8 2a b0 ff ff       	call   801008c0 <cprintf>
80105896:	83 c4 10             	add    $0x10,%esp
80105899:	89 da                	mov    %ebx,%edx
8010589b:	e9 60 ff ff ff       	jmp    80105800 <make_priority_queue+0x40>
    cprintf("Now it is pid %d's turn\n");
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	68 ab a3 10 80       	push   $0x8010a3ab
801058a8:	e8 13 b0 ff ff       	call   801008c0 <cprintf>
801058ad:	83 c4 10             	add    $0x10,%esp
801058b0:	eb b2                	jmp    80105864 <make_priority_queue+0xa4>
801058b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058c0 <priorityLock_test>:


void priorityLock_test(){
801058c0:	f3 0f 1e fb          	endbr32 
801058c4:	55                   	push   %ebp
801058c5:	89 e5                	mov    %esp,%ebp
801058c7:	53                   	push   %ebx
801058c8:	83 ec 14             	sub    $0x14,%esp
  pushcli();
801058cb:	e8 d0 03 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
801058d0:	e8 0b e6 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
801058d5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801058db:	e8 10 04 00 00       	call   80105cf0 <popcli>
  cprintf("Process pid:%d want access to critical section\n" , myproc()->pid);
801058e0:	83 ec 08             	sub    $0x8,%esp
801058e3:	ff 73 10             	pushl  0x10(%ebx)
801058e6:	68 f8 a4 10 80       	push   $0x8010a4f8
801058eb:	e8 d0 af ff ff       	call   801008c0 <cprintf>
  acquirePriorityLock(&lock);
801058f0:	c7 04 24 e0 d5 10 80 	movl   $0x8010d5e0,(%esp)
801058f7:	e8 04 02 00 00       	call   80105b00 <acquirePriorityLock>
  pushcli();
801058fc:	e8 9f 03 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80105901:	e8 da e5 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80105906:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010590c:	e8 df 03 00 00       	call   80105cf0 <popcli>
  cprintf("Process pid:%d acquired access to critical section\n" , myproc()->pid);
80105911:	59                   	pop    %ecx
80105912:	58                   	pop    %eax
80105913:	ff 73 10             	pushl  0x10(%ebx)
80105916:	68 28 a5 10 80       	push   $0x8010a528
8010591b:	e8 a0 af ff ff       	call   801008c0 <cprintf>
  volatile long long temp = 0;
80105920:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80105927:	83 c4 10             	add    $0x10,%esp
8010592a:	31 c9                	xor    %ecx,%ecx
8010592c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for (long long l = 0; l < 200000000; l++){
80105933:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105937:	90                   	nop
    temp += 5 * 7 + 1;
80105938:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010593b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010593e:	83 c0 24             	add    $0x24,%eax
80105941:	83 d2 00             	adc    $0x0,%edx
80105944:	83 c1 01             	add    $0x1,%ecx
80105947:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010594a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  for (long long l = 0; l < 200000000; l++){
8010594d:	81 f9 00 c2 eb 0b    	cmp    $0xbebc200,%ecx
80105953:	75 e3                	jne    80105938 <priorityLock_test+0x78>
  }
            
  make_priority_queue(&lock);
80105955:	83 ec 0c             	sub    $0xc,%esp
80105958:	68 e0 d5 10 80       	push   $0x8010d5e0
8010595d:	e8 5e fe ff ff       	call   801057c0 <make_priority_queue>
  releasePriorityLock(&lock);
80105962:	c7 04 24 e0 d5 10 80 	movl   $0x8010d5e0,(%esp)
80105969:	e8 f2 01 00 00       	call   80105b60 <releasePriorityLock>
  pushcli();
8010596e:	e8 2d 03 00 00       	call   80105ca0 <pushcli>
  c = mycpu();
80105973:	e8 68 e5 ff ff       	call   80103ee0 <mycpu>
  p = c->proc;
80105978:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010597e:	e8 6d 03 00 00       	call   80105cf0 <popcli>
  cprintf("Process pid: %d exited from critical section\n" , myproc()->pid);
80105983:	58                   	pop    %eax
80105984:	5a                   	pop    %edx
80105985:	ff 73 10             	pushl  0x10(%ebx)
80105988:	68 5c a5 10 80       	push   $0x8010a55c
8010598d:	e8 2e af ff ff       	call   801008c0 <cprintf>
}
80105992:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105995:	83 c4 10             	add    $0x10,%esp
80105998:	c9                   	leave  
80105999:	c3                   	ret    
8010599a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801059a0 <init_queue_test>:

void
init_queue_test(void){
801059a0:	f3 0f 1e fb          	endbr32 
801059a4:	55                   	push   %ebp
801059a5:	89 e5                	mov    %esp,%ebp
801059a7:	83 ec 14             	sub    $0x14,%esp
  initPriorityLock(&lock);
801059aa:	68 e0 d5 10 80       	push   $0x8010d5e0
801059af:	e8 ec 01 00 00       	call   80105ba0 <initPriorityLock>
801059b4:	83 c4 10             	add    $0x10,%esp
801059b7:	c9                   	leave  
801059b8:	c3                   	ret    
801059b9:	66 90                	xchg   %ax,%ax
801059bb:	66 90                	xchg   %ax,%ax
801059bd:	66 90                	xchg   %ax,%ax
801059bf:	90                   	nop

801059c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801059c0:	f3 0f 1e fb          	endbr32 
801059c4:	55                   	push   %ebp
801059c5:	89 e5                	mov    %esp,%ebp
801059c7:	53                   	push   %ebx
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801059ce:	68 c4 a5 10 80       	push   $0x8010a5c4
801059d3:	8d 43 04             	lea    0x4(%ebx),%eax
801059d6:	50                   	push   %eax
801059d7:	e8 44 02 00 00       	call   80105c20 <initlock>
  lk->name = name;
801059dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801059df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801059e5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801059e8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801059ef:	89 43 38             	mov    %eax,0x38(%ebx)
}
801059f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059f5:	c9                   	leave  
801059f6:	c3                   	ret    
801059f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059fe:	66 90                	xchg   %ax,%ax

80105a00 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105a00:	f3 0f 1e fb          	endbr32 
80105a04:	55                   	push   %ebp
80105a05:	89 e5                	mov    %esp,%ebp
80105a07:	56                   	push   %esi
80105a08:	53                   	push   %ebx
80105a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a0c:	8d 73 04             	lea    0x4(%ebx),%esi
80105a0f:	83 ec 0c             	sub    $0xc,%esp
80105a12:	56                   	push   %esi
80105a13:	e8 88 03 00 00       	call   80105da0 <acquire>
  while (lk->locked) {
80105a18:	8b 13                	mov    (%ebx),%edx
80105a1a:	83 c4 10             	add    $0x10,%esp
80105a1d:	85 d2                	test   %edx,%edx
80105a1f:	74 1a                	je     80105a3b <acquiresleep+0x3b>
80105a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105a28:	83 ec 08             	sub    $0x8,%esp
80105a2b:	56                   	push   %esi
80105a2c:	53                   	push   %ebx
80105a2d:	e8 4e eb ff ff       	call   80104580 <sleep>
  while (lk->locked) {
80105a32:	8b 03                	mov    (%ebx),%eax
80105a34:	83 c4 10             	add    $0x10,%esp
80105a37:	85 c0                	test   %eax,%eax
80105a39:	75 ed                	jne    80105a28 <acquiresleep+0x28>
  }
  lk->locked = 1;
80105a3b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105a41:	e8 2a e5 ff ff       	call   80103f70 <myproc>
80105a46:	8b 40 10             	mov    0x10(%eax),%eax
80105a49:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105a4c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105a4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a52:	5b                   	pop    %ebx
80105a53:	5e                   	pop    %esi
80105a54:	5d                   	pop    %ebp
  release(&lk->lk);
80105a55:	e9 06 04 00 00       	jmp    80105e60 <release>
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a60 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	56                   	push   %esi
80105a68:	53                   	push   %ebx
80105a69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a6c:	8d 73 04             	lea    0x4(%ebx),%esi
80105a6f:	83 ec 0c             	sub    $0xc,%esp
80105a72:	56                   	push   %esi
80105a73:	e8 28 03 00 00       	call   80105da0 <acquire>
  lk->locked = 0;
80105a78:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105a7e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105a85:	89 1c 24             	mov    %ebx,(%esp)
80105a88:	e8 b3 ec ff ff       	call   80104740 <wakeup>
  release(&lk->lk);
80105a8d:	89 75 08             	mov    %esi,0x8(%ebp)
80105a90:	83 c4 10             	add    $0x10,%esp
}
80105a93:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a96:	5b                   	pop    %ebx
80105a97:	5e                   	pop    %esi
80105a98:	5d                   	pop    %ebp
  release(&lk->lk);
80105a99:	e9 c2 03 00 00       	jmp    80105e60 <release>
80105a9e:	66 90                	xchg   %ax,%ax

80105aa0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105aa0:	f3 0f 1e fb          	endbr32 
80105aa4:	55                   	push   %ebp
80105aa5:	89 e5                	mov    %esp,%ebp
80105aa7:	57                   	push   %edi
80105aa8:	31 ff                	xor    %edi,%edi
80105aaa:	56                   	push   %esi
80105aab:	53                   	push   %ebx
80105aac:	83 ec 18             	sub    $0x18,%esp
80105aaf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105ab2:	8d 73 04             	lea    0x4(%ebx),%esi
80105ab5:	56                   	push   %esi
80105ab6:	e8 e5 02 00 00       	call   80105da0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105abb:	8b 03                	mov    (%ebx),%eax
80105abd:	83 c4 10             	add    $0x10,%esp
80105ac0:	85 c0                	test   %eax,%eax
80105ac2:	75 1c                	jne    80105ae0 <holdingsleep+0x40>
  release(&lk->lk);
80105ac4:	83 ec 0c             	sub    $0xc,%esp
80105ac7:	56                   	push   %esi
80105ac8:	e8 93 03 00 00       	call   80105e60 <release>
  return r;
}
80105acd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ad0:	89 f8                	mov    %edi,%eax
80105ad2:	5b                   	pop    %ebx
80105ad3:	5e                   	pop    %esi
80105ad4:	5f                   	pop    %edi
80105ad5:	5d                   	pop    %ebp
80105ad6:	c3                   	ret    
80105ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ade:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80105ae0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105ae3:	e8 88 e4 ff ff       	call   80103f70 <myproc>
80105ae8:	39 58 10             	cmp    %ebx,0x10(%eax)
80105aeb:	0f 94 c0             	sete   %al
80105aee:	0f b6 c0             	movzbl %al,%eax
80105af1:	89 c7                	mov    %eax,%edi
80105af3:	eb cf                	jmp    80105ac4 <holdingsleep+0x24>
80105af5:	66 90                	xchg   %ax,%ax
80105af7:	66 90                	xchg   %ax,%ax
80105af9:	66 90                	xchg   %ax,%ax
80105afb:	66 90                	xchg   %ax,%ax
80105afd:	66 90                	xchg   %ax,%ax
80105aff:	90                   	nop

80105b00 <acquirePriorityLock>:
#include "proc.h"
#include "spinlock.h"
#include "priorityLock.h"

void acquirePriorityLock(struct PriorityLock *lock)
{
80105b00:	f3 0f 1e fb          	endbr32 
80105b04:	55                   	push   %ebp
80105b05:	89 e5                	mov    %esp,%ebp
80105b07:	53                   	push   %ebx
80105b08:	83 ec 10             	sub    $0x10,%esp
80105b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire(&lock->lock);
80105b0e:	53                   	push   %ebx
80105b0f:	e8 8c 02 00 00       	call   80105da0 <acquire>
	while(lock->is_lock){
80105b14:	8b 53 34             	mov    0x34(%ebx),%edx
80105b17:	83 c4 10             	add    $0x10,%esp
80105b1a:	85 d2                	test   %edx,%edx
80105b1c:	74 16                	je     80105b34 <acquirePriorityLock+0x34>
80105b1e:	66 90                	xchg   %ax,%ax
		sleep(lock, &lock->lock);
80105b20:	83 ec 08             	sub    $0x8,%esp
80105b23:	53                   	push   %ebx
80105b24:	53                   	push   %ebx
80105b25:	e8 56 ea ff ff       	call   80104580 <sleep>
	while(lock->is_lock){
80105b2a:	8b 43 34             	mov    0x34(%ebx),%eax
80105b2d:	83 c4 10             	add    $0x10,%esp
80105b30:	85 c0                	test   %eax,%eax
80105b32:	75 ec                	jne    80105b20 <acquirePriorityLock+0x20>
	}
	lock->is_lock = 1;
80105b34:	c7 43 34 01 00 00 00 	movl   $0x1,0x34(%ebx)
	lock->pid = myproc()->pid;	
80105b3b:	e8 30 e4 ff ff       	call   80103f70 <myproc>
80105b40:	8b 40 10             	mov    0x10(%eax),%eax
80105b43:	89 43 38             	mov    %eax,0x38(%ebx)
	release(&lock->lock);
80105b46:	89 5d 08             	mov    %ebx,0x8(%ebp)

}
80105b49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b4c:	c9                   	leave  
	release(&lock->lock);
80105b4d:	e9 0e 03 00 00       	jmp    80105e60 <release>
80105b52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b60 <releasePriorityLock>:


void releasePriorityLock(struct PriorityLock *lock)
{
80105b60:	f3 0f 1e fb          	endbr32 
80105b64:	55                   	push   %ebp
80105b65:	89 e5                	mov    %esp,%ebp
80105b67:	53                   	push   %ebx
80105b68:	83 ec 10             	sub    $0x10,%esp
80105b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
	acquire(&lock->lock);
80105b6e:	53                   	push   %ebx
80105b6f:	e8 2c 02 00 00       	call   80105da0 <acquire>
	lock->is_lock = 0;
80105b74:	c7 43 34 00 00 00 00 	movl   $0x0,0x34(%ebx)
	lock->pid = 0;
80105b7b:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
	priority_wakeup(lock);
80105b82:	89 1c 24             	mov    %ebx,(%esp)
80105b85:	e8 86 fb ff ff       	call   80105710 <priority_wakeup>
	release(&lock->lock);
80105b8a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105b8d:	83 c4 10             	add    $0x10,%esp
}
80105b90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b93:	c9                   	leave  
	release(&lock->lock);
80105b94:	e9 c7 02 00 00       	jmp    80105e60 <release>
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ba0 <initPriorityLock>:

void initPriorityLock(struct PriorityLock * lock){
80105ba0:	f3 0f 1e fb          	endbr32 
80105ba4:	55                   	push   %ebp
80105ba5:	89 e5                	mov    %esp,%ebp
80105ba7:	53                   	push   %ebx
80105ba8:	83 ec 0c             	sub    $0xc,%esp
80105bab:	8b 5d 08             	mov    0x8(%ebp),%ebx
	initlock(&lock->lock , "priority lock");
80105bae:	68 cf a5 10 80       	push   $0x8010a5cf
80105bb3:	53                   	push   %ebx
80105bb4:	e8 67 00 00 00       	call   80105c20 <initlock>
	lock->is_lock = 0;
80105bb9:	c7 43 34 00 00 00 00 	movl   $0x0,0x34(%ebx)
	lock->pid = 0;

}
80105bc0:	83 c4 10             	add    $0x10,%esp
	lock->pid = 0;
80105bc3:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
}
80105bca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bcd:	c9                   	leave  
80105bce:	c3                   	ret    
80105bcf:	90                   	nop

80105bd0 <holdingPriorityLock>:

int
holdingPriorityLock(struct PriorityLock * lock)
{
80105bd0:	f3 0f 1e fb          	endbr32 
80105bd4:	55                   	push   %ebp
80105bd5:	89 e5                	mov    %esp,%ebp
80105bd7:	57                   	push   %edi
80105bd8:	56                   	push   %esi
80105bd9:	31 f6                	xor    %esi,%esi
80105bdb:	53                   	push   %ebx
80105bdc:	83 ec 18             	sub    $0x18,%esp
80105bdf:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int ret = 0;
	acquire(&lock->lock);
80105be2:	53                   	push   %ebx
80105be3:	e8 b8 01 00 00       	call   80105da0 <acquire>
	ret = (lock->pid == myproc()->pid)&& lock->is_lock;
80105be8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105beb:	e8 80 e3 ff ff       	call   80103f70 <myproc>
80105bf0:	83 c4 10             	add    $0x10,%esp
80105bf3:	3b 78 10             	cmp    0x10(%eax),%edi
80105bf6:	75 0c                	jne    80105c04 <holdingPriorityLock+0x34>
80105bf8:	8b 53 34             	mov    0x34(%ebx),%edx
80105bfb:	31 c0                	xor    %eax,%eax
80105bfd:	85 d2                	test   %edx,%edx
80105bff:	0f 95 c0             	setne  %al
80105c02:	89 c6                	mov    %eax,%esi
	release(&lock->lock);
80105c04:	83 ec 0c             	sub    $0xc,%esp
80105c07:	53                   	push   %ebx
80105c08:	e8 53 02 00 00       	call   80105e60 <release>
	return ret;
80105c0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c10:	89 f0                	mov    %esi,%eax
80105c12:	5b                   	pop    %ebx
80105c13:	5e                   	pop    %esi
80105c14:	5f                   	pop    %edi
80105c15:	5d                   	pop    %ebp
80105c16:	c3                   	ret    
80105c17:	66 90                	xchg   %ax,%ax
80105c19:	66 90                	xchg   %ax,%ax
80105c1b:	66 90                	xchg   %ax,%ax
80105c1d:	66 90                	xchg   %ax,%ax
80105c1f:	90                   	nop

80105c20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105c20:	f3 0f 1e fb          	endbr32 
80105c24:	55                   	push   %ebp
80105c25:	89 e5                	mov    %esp,%ebp
80105c27:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105c2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105c2d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105c33:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105c36:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105c3d:	5d                   	pop    %ebp
80105c3e:	c3                   	ret    
80105c3f:	90                   	nop

80105c40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105c40:	f3 0f 1e fb          	endbr32 
80105c44:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105c45:	31 d2                	xor    %edx,%edx
{
80105c47:	89 e5                	mov    %esp,%ebp
80105c49:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105c4a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105c4d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105c50:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80105c53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c57:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105c58:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105c5e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105c64:	77 1a                	ja     80105c80 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105c66:	8b 58 04             	mov    0x4(%eax),%ebx
80105c69:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105c6c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105c6f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105c71:	83 fa 0a             	cmp    $0xa,%edx
80105c74:	75 e2                	jne    80105c58 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105c76:	5b                   	pop    %ebx
80105c77:	5d                   	pop    %ebp
80105c78:	c3                   	ret    
80105c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105c80:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105c83:	8d 51 28             	lea    0x28(%ecx),%edx
80105c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c8d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105c90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105c96:	83 c0 04             	add    $0x4,%eax
80105c99:	39 d0                	cmp    %edx,%eax
80105c9b:	75 f3                	jne    80105c90 <getcallerpcs+0x50>
}
80105c9d:	5b                   	pop    %ebx
80105c9e:	5d                   	pop    %ebp
80105c9f:	c3                   	ret    

80105ca0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105ca0:	f3 0f 1e fb          	endbr32 
80105ca4:	55                   	push   %ebp
80105ca5:	89 e5                	mov    %esp,%ebp
80105ca7:	53                   	push   %ebx
80105ca8:	83 ec 04             	sub    $0x4,%esp
80105cab:	9c                   	pushf  
80105cac:	5b                   	pop    %ebx
  asm volatile("cli");
80105cad:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105cae:	e8 2d e2 ff ff       	call   80103ee0 <mycpu>
80105cb3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105cb9:	85 c0                	test   %eax,%eax
80105cbb:	74 13                	je     80105cd0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105cbd:	e8 1e e2 ff ff       	call   80103ee0 <mycpu>
80105cc2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105cc9:	83 c4 04             	add    $0x4,%esp
80105ccc:	5b                   	pop    %ebx
80105ccd:	5d                   	pop    %ebp
80105cce:	c3                   	ret    
80105ccf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80105cd0:	e8 0b e2 ff ff       	call   80103ee0 <mycpu>
80105cd5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105cdb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105ce1:	eb da                	jmp    80105cbd <pushcli+0x1d>
80105ce3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cf0 <popcli>:

void
popcli(void)
{
80105cf0:	f3 0f 1e fb          	endbr32 
80105cf4:	55                   	push   %ebp
80105cf5:	89 e5                	mov    %esp,%ebp
80105cf7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105cfa:	9c                   	pushf  
80105cfb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105cfc:	f6 c4 02             	test   $0x2,%ah
80105cff:	75 31                	jne    80105d32 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105d01:	e8 da e1 ff ff       	call   80103ee0 <mycpu>
80105d06:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105d0d:	78 30                	js     80105d3f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105d0f:	e8 cc e1 ff ff       	call   80103ee0 <mycpu>
80105d14:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105d1a:	85 d2                	test   %edx,%edx
80105d1c:	74 02                	je     80105d20 <popcli+0x30>
    sti();
}
80105d1e:	c9                   	leave  
80105d1f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105d20:	e8 bb e1 ff ff       	call   80103ee0 <mycpu>
80105d25:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105d2b:	85 c0                	test   %eax,%eax
80105d2d:	74 ef                	je     80105d1e <popcli+0x2e>
  asm volatile("sti");
80105d2f:	fb                   	sti    
}
80105d30:	c9                   	leave  
80105d31:	c3                   	ret    
    panic("popcli - interruptible");
80105d32:	83 ec 0c             	sub    $0xc,%esp
80105d35:	68 dd a5 10 80       	push   $0x8010a5dd
80105d3a:	e8 51 a6 ff ff       	call   80100390 <panic>
    panic("popcli");
80105d3f:	83 ec 0c             	sub    $0xc,%esp
80105d42:	68 f4 a5 10 80       	push   $0x8010a5f4
80105d47:	e8 44 a6 ff ff       	call   80100390 <panic>
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d50 <holding>:
{
80105d50:	f3 0f 1e fb          	endbr32 
80105d54:	55                   	push   %ebp
80105d55:	89 e5                	mov    %esp,%ebp
80105d57:	56                   	push   %esi
80105d58:	53                   	push   %ebx
80105d59:	8b 75 08             	mov    0x8(%ebp),%esi
80105d5c:	31 db                	xor    %ebx,%ebx
  pushcli();
80105d5e:	e8 3d ff ff ff       	call   80105ca0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105d63:	8b 06                	mov    (%esi),%eax
80105d65:	85 c0                	test   %eax,%eax
80105d67:	75 0f                	jne    80105d78 <holding+0x28>
  popcli();
80105d69:	e8 82 ff ff ff       	call   80105cf0 <popcli>
}
80105d6e:	89 d8                	mov    %ebx,%eax
80105d70:	5b                   	pop    %ebx
80105d71:	5e                   	pop    %esi
80105d72:	5d                   	pop    %ebp
80105d73:	c3                   	ret    
80105d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80105d78:	8b 5e 08             	mov    0x8(%esi),%ebx
80105d7b:	e8 60 e1 ff ff       	call   80103ee0 <mycpu>
80105d80:	39 c3                	cmp    %eax,%ebx
80105d82:	0f 94 c3             	sete   %bl
  popcli();
80105d85:	e8 66 ff ff ff       	call   80105cf0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105d8a:	0f b6 db             	movzbl %bl,%ebx
}
80105d8d:	89 d8                	mov    %ebx,%eax
80105d8f:	5b                   	pop    %ebx
80105d90:	5e                   	pop    %esi
80105d91:	5d                   	pop    %ebp
80105d92:	c3                   	ret    
80105d93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105da0 <acquire>:
{
80105da0:	f3 0f 1e fb          	endbr32 
80105da4:	55                   	push   %ebp
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	56                   	push   %esi
80105da8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105da9:	e8 f2 fe ff ff       	call   80105ca0 <pushcli>
  if(holding(lk))
80105dae:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105db1:	83 ec 0c             	sub    $0xc,%esp
80105db4:	53                   	push   %ebx
80105db5:	e8 96 ff ff ff       	call   80105d50 <holding>
80105dba:	83 c4 10             	add    $0x10,%esp
80105dbd:	85 c0                	test   %eax,%eax
80105dbf:	0f 85 7f 00 00 00    	jne    80105e44 <acquire+0xa4>
80105dc5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105dc7:	ba 01 00 00 00       	mov    $0x1,%edx
80105dcc:	eb 05                	jmp    80105dd3 <acquire+0x33>
80105dce:	66 90                	xchg   %ax,%ax
80105dd0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105dd3:	89 d0                	mov    %edx,%eax
80105dd5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105dd8:	85 c0                	test   %eax,%eax
80105dda:	75 f4                	jne    80105dd0 <acquire+0x30>
  __sync_synchronize();
80105ddc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105de1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105de4:	e8 f7 e0 ff ff       	call   80103ee0 <mycpu>
80105de9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105dec:	89 e8                	mov    %ebp,%eax
80105dee:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105df0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80105df6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80105dfc:	77 22                	ja     80105e20 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80105dfe:	8b 50 04             	mov    0x4(%eax),%edx
80105e01:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80105e05:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105e08:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105e0a:	83 fe 0a             	cmp    $0xa,%esi
80105e0d:	75 e1                	jne    80105df0 <acquire+0x50>
}
80105e0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e12:	5b                   	pop    %ebx
80105e13:	5e                   	pop    %esi
80105e14:	5d                   	pop    %ebp
80105e15:	c3                   	ret    
80105e16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e1d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80105e20:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80105e24:	83 c3 34             	add    $0x34,%ebx
80105e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105e30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105e36:	83 c0 04             	add    $0x4,%eax
80105e39:	39 d8                	cmp    %ebx,%eax
80105e3b:	75 f3                	jne    80105e30 <acquire+0x90>
}
80105e3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e40:	5b                   	pop    %ebx
80105e41:	5e                   	pop    %esi
80105e42:	5d                   	pop    %ebp
80105e43:	c3                   	ret    
    panic("acquire");
80105e44:	83 ec 0c             	sub    $0xc,%esp
80105e47:	68 fb a5 10 80       	push   $0x8010a5fb
80105e4c:	e8 3f a5 ff ff       	call   80100390 <panic>
80105e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e5f:	90                   	nop

80105e60 <release>:
{
80105e60:	f3 0f 1e fb          	endbr32 
80105e64:	55                   	push   %ebp
80105e65:	89 e5                	mov    %esp,%ebp
80105e67:	53                   	push   %ebx
80105e68:	83 ec 10             	sub    $0x10,%esp
80105e6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105e6e:	53                   	push   %ebx
80105e6f:	e8 dc fe ff ff       	call   80105d50 <holding>
80105e74:	83 c4 10             	add    $0x10,%esp
80105e77:	85 c0                	test   %eax,%eax
80105e79:	74 22                	je     80105e9d <release+0x3d>
  lk->pcs[0] = 0;
80105e7b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105e82:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105e89:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105e8e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e97:	c9                   	leave  
  popcli();
80105e98:	e9 53 fe ff ff       	jmp    80105cf0 <popcli>
    panic("release");
80105e9d:	83 ec 0c             	sub    $0xc,%esp
80105ea0:	68 03 a6 10 80       	push   $0x8010a603
80105ea5:	e8 e6 a4 ff ff       	call   80100390 <panic>
80105eaa:	66 90                	xchg   %ax,%ax
80105eac:	66 90                	xchg   %ax,%ax
80105eae:	66 90                	xchg   %ax,%ax

80105eb0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105eb0:	f3 0f 1e fb          	endbr32 
80105eb4:	55                   	push   %ebp
80105eb5:	89 e5                	mov    %esp,%ebp
80105eb7:	57                   	push   %edi
80105eb8:	8b 55 08             	mov    0x8(%ebp),%edx
80105ebb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105ebe:	53                   	push   %ebx
80105ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80105ec2:	89 d7                	mov    %edx,%edi
80105ec4:	09 cf                	or     %ecx,%edi
80105ec6:	83 e7 03             	and    $0x3,%edi
80105ec9:	75 25                	jne    80105ef0 <memset+0x40>
    c &= 0xFF;
80105ecb:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105ece:	c1 e0 18             	shl    $0x18,%eax
80105ed1:	89 fb                	mov    %edi,%ebx
80105ed3:	c1 e9 02             	shr    $0x2,%ecx
80105ed6:	c1 e3 10             	shl    $0x10,%ebx
80105ed9:	09 d8                	or     %ebx,%eax
80105edb:	09 f8                	or     %edi,%eax
80105edd:	c1 e7 08             	shl    $0x8,%edi
80105ee0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105ee2:	89 d7                	mov    %edx,%edi
80105ee4:	fc                   	cld    
80105ee5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105ee7:	5b                   	pop    %ebx
80105ee8:	89 d0                	mov    %edx,%eax
80105eea:	5f                   	pop    %edi
80105eeb:	5d                   	pop    %ebp
80105eec:	c3                   	ret    
80105eed:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80105ef0:	89 d7                	mov    %edx,%edi
80105ef2:	fc                   	cld    
80105ef3:	f3 aa                	rep stos %al,%es:(%edi)
80105ef5:	5b                   	pop    %ebx
80105ef6:	89 d0                	mov    %edx,%eax
80105ef8:	5f                   	pop    %edi
80105ef9:	5d                   	pop    %ebp
80105efa:	c3                   	ret    
80105efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105eff:	90                   	nop

80105f00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105f00:	f3 0f 1e fb          	endbr32 
80105f04:	55                   	push   %ebp
80105f05:	89 e5                	mov    %esp,%ebp
80105f07:	56                   	push   %esi
80105f08:	8b 75 10             	mov    0x10(%ebp),%esi
80105f0b:	8b 55 08             	mov    0x8(%ebp),%edx
80105f0e:	53                   	push   %ebx
80105f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105f12:	85 f6                	test   %esi,%esi
80105f14:	74 2a                	je     80105f40 <memcmp+0x40>
80105f16:	01 c6                	add    %eax,%esi
80105f18:	eb 10                	jmp    80105f2a <memcmp+0x2a>
80105f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105f20:	83 c0 01             	add    $0x1,%eax
80105f23:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105f26:	39 f0                	cmp    %esi,%eax
80105f28:	74 16                	je     80105f40 <memcmp+0x40>
    if(*s1 != *s2)
80105f2a:	0f b6 0a             	movzbl (%edx),%ecx
80105f2d:	0f b6 18             	movzbl (%eax),%ebx
80105f30:	38 d9                	cmp    %bl,%cl
80105f32:	74 ec                	je     80105f20 <memcmp+0x20>
      return *s1 - *s2;
80105f34:	0f b6 c1             	movzbl %cl,%eax
80105f37:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105f39:	5b                   	pop    %ebx
80105f3a:	5e                   	pop    %esi
80105f3b:	5d                   	pop    %ebp
80105f3c:	c3                   	ret    
80105f3d:	8d 76 00             	lea    0x0(%esi),%esi
80105f40:	5b                   	pop    %ebx
  return 0;
80105f41:	31 c0                	xor    %eax,%eax
}
80105f43:	5e                   	pop    %esi
80105f44:	5d                   	pop    %ebp
80105f45:	c3                   	ret    
80105f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4d:	8d 76 00             	lea    0x0(%esi),%esi

80105f50 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105f50:	f3 0f 1e fb          	endbr32 
80105f54:	55                   	push   %ebp
80105f55:	89 e5                	mov    %esp,%ebp
80105f57:	57                   	push   %edi
80105f58:	8b 55 08             	mov    0x8(%ebp),%edx
80105f5b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105f5e:	56                   	push   %esi
80105f5f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105f62:	39 d6                	cmp    %edx,%esi
80105f64:	73 2a                	jae    80105f90 <memmove+0x40>
80105f66:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105f69:	39 fa                	cmp    %edi,%edx
80105f6b:	73 23                	jae    80105f90 <memmove+0x40>
80105f6d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105f70:	85 c9                	test   %ecx,%ecx
80105f72:	74 13                	je     80105f87 <memmove+0x37>
80105f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80105f78:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105f7c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105f7f:	83 e8 01             	sub    $0x1,%eax
80105f82:	83 f8 ff             	cmp    $0xffffffff,%eax
80105f85:	75 f1                	jne    80105f78 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105f87:	5e                   	pop    %esi
80105f88:	89 d0                	mov    %edx,%eax
80105f8a:	5f                   	pop    %edi
80105f8b:	5d                   	pop    %ebp
80105f8c:	c3                   	ret    
80105f8d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80105f90:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105f93:	89 d7                	mov    %edx,%edi
80105f95:	85 c9                	test   %ecx,%ecx
80105f97:	74 ee                	je     80105f87 <memmove+0x37>
80105f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105fa0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105fa1:	39 f0                	cmp    %esi,%eax
80105fa3:	75 fb                	jne    80105fa0 <memmove+0x50>
}
80105fa5:	5e                   	pop    %esi
80105fa6:	89 d0                	mov    %edx,%eax
80105fa8:	5f                   	pop    %edi
80105fa9:	5d                   	pop    %ebp
80105faa:	c3                   	ret    
80105fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105faf:	90                   	nop

80105fb0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105fb0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80105fb4:	eb 9a                	jmp    80105f50 <memmove>
80105fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbd:	8d 76 00             	lea    0x0(%esi),%esi

80105fc0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105fc0:	f3 0f 1e fb          	endbr32 
80105fc4:	55                   	push   %ebp
80105fc5:	89 e5                	mov    %esp,%ebp
80105fc7:	56                   	push   %esi
80105fc8:	8b 75 10             	mov    0x10(%ebp),%esi
80105fcb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105fce:	53                   	push   %ebx
80105fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80105fd2:	85 f6                	test   %esi,%esi
80105fd4:	74 32                	je     80106008 <strncmp+0x48>
80105fd6:	01 c6                	add    %eax,%esi
80105fd8:	eb 14                	jmp    80105fee <strncmp+0x2e>
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105fe0:	38 da                	cmp    %bl,%dl
80105fe2:	75 14                	jne    80105ff8 <strncmp+0x38>
    n--, p++, q++;
80105fe4:	83 c0 01             	add    $0x1,%eax
80105fe7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105fea:	39 f0                	cmp    %esi,%eax
80105fec:	74 1a                	je     80106008 <strncmp+0x48>
80105fee:	0f b6 11             	movzbl (%ecx),%edx
80105ff1:	0f b6 18             	movzbl (%eax),%ebx
80105ff4:	84 d2                	test   %dl,%dl
80105ff6:	75 e8                	jne    80105fe0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105ff8:	0f b6 c2             	movzbl %dl,%eax
80105ffb:	29 d8                	sub    %ebx,%eax
}
80105ffd:	5b                   	pop    %ebx
80105ffe:	5e                   	pop    %esi
80105fff:	5d                   	pop    %ebp
80106000:	c3                   	ret    
80106001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106008:	5b                   	pop    %ebx
    return 0;
80106009:	31 c0                	xor    %eax,%eax
}
8010600b:	5e                   	pop    %esi
8010600c:	5d                   	pop    %ebp
8010600d:	c3                   	ret    
8010600e:	66 90                	xchg   %ax,%ax

80106010 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80106010:	f3 0f 1e fb          	endbr32 
80106014:	55                   	push   %ebp
80106015:	89 e5                	mov    %esp,%ebp
80106017:	57                   	push   %edi
80106018:	56                   	push   %esi
80106019:	8b 75 08             	mov    0x8(%ebp),%esi
8010601c:	53                   	push   %ebx
8010601d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80106020:	89 f2                	mov    %esi,%edx
80106022:	eb 1b                	jmp    8010603f <strncpy+0x2f>
80106024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106028:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010602c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010602f:	83 c2 01             	add    $0x1,%edx
80106032:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80106036:	89 f9                	mov    %edi,%ecx
80106038:	88 4a ff             	mov    %cl,-0x1(%edx)
8010603b:	84 c9                	test   %cl,%cl
8010603d:	74 09                	je     80106048 <strncpy+0x38>
8010603f:	89 c3                	mov    %eax,%ebx
80106041:	83 e8 01             	sub    $0x1,%eax
80106044:	85 db                	test   %ebx,%ebx
80106046:	7f e0                	jg     80106028 <strncpy+0x18>
    ;
  while(n-- > 0)
80106048:	89 d1                	mov    %edx,%ecx
8010604a:	85 c0                	test   %eax,%eax
8010604c:	7e 15                	jle    80106063 <strncpy+0x53>
8010604e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80106050:	83 c1 01             	add    $0x1,%ecx
80106053:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80106057:	89 c8                	mov    %ecx,%eax
80106059:	f7 d0                	not    %eax
8010605b:	01 d0                	add    %edx,%eax
8010605d:	01 d8                	add    %ebx,%eax
8010605f:	85 c0                	test   %eax,%eax
80106061:	7f ed                	jg     80106050 <strncpy+0x40>
  return os;
}
80106063:	5b                   	pop    %ebx
80106064:	89 f0                	mov    %esi,%eax
80106066:	5e                   	pop    %esi
80106067:	5f                   	pop    %edi
80106068:	5d                   	pop    %ebp
80106069:	c3                   	ret    
8010606a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106070 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106070:	f3 0f 1e fb          	endbr32 
80106074:	55                   	push   %ebp
80106075:	89 e5                	mov    %esp,%ebp
80106077:	56                   	push   %esi
80106078:	8b 55 10             	mov    0x10(%ebp),%edx
8010607b:	8b 75 08             	mov    0x8(%ebp),%esi
8010607e:	53                   	push   %ebx
8010607f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80106082:	85 d2                	test   %edx,%edx
80106084:	7e 21                	jle    801060a7 <safestrcpy+0x37>
80106086:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010608a:	89 f2                	mov    %esi,%edx
8010608c:	eb 12                	jmp    801060a0 <safestrcpy+0x30>
8010608e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80106090:	0f b6 08             	movzbl (%eax),%ecx
80106093:	83 c0 01             	add    $0x1,%eax
80106096:	83 c2 01             	add    $0x1,%edx
80106099:	88 4a ff             	mov    %cl,-0x1(%edx)
8010609c:	84 c9                	test   %cl,%cl
8010609e:	74 04                	je     801060a4 <safestrcpy+0x34>
801060a0:	39 d8                	cmp    %ebx,%eax
801060a2:	75 ec                	jne    80106090 <safestrcpy+0x20>
    ;
  *s = 0;
801060a4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801060a7:	89 f0                	mov    %esi,%eax
801060a9:	5b                   	pop    %ebx
801060aa:	5e                   	pop    %esi
801060ab:	5d                   	pop    %ebp
801060ac:	c3                   	ret    
801060ad:	8d 76 00             	lea    0x0(%esi),%esi

801060b0 <strlen>:

int
strlen(const char *s)
{
801060b0:	f3 0f 1e fb          	endbr32 
801060b4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801060b5:	31 c0                	xor    %eax,%eax
{
801060b7:	89 e5                	mov    %esp,%ebp
801060b9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801060bc:	80 3a 00             	cmpb   $0x0,(%edx)
801060bf:	74 10                	je     801060d1 <strlen+0x21>
801060c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060c8:	83 c0 01             	add    $0x1,%eax
801060cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801060cf:	75 f7                	jne    801060c8 <strlen+0x18>
    ;
  return n;
}
801060d1:	5d                   	pop    %ebp
801060d2:	c3                   	ret    

801060d3 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801060d3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801060d7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801060db:	55                   	push   %ebp
  pushl %ebx
801060dc:	53                   	push   %ebx
  pushl %esi
801060dd:	56                   	push   %esi
  pushl %edi
801060de:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801060df:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801060e1:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801060e3:	5f                   	pop    %edi
  popl %esi
801060e4:	5e                   	pop    %esi
  popl %ebx
801060e5:	5b                   	pop    %ebx
  popl %ebp
801060e6:	5d                   	pop    %ebp
  ret
801060e7:	c3                   	ret    
801060e8:	66 90                	xchg   %ax,%ax
801060ea:	66 90                	xchg   %ax,%ax
801060ec:	66 90                	xchg   %ax,%ax
801060ee:	66 90                	xchg   %ax,%ax

801060f0 <fetchfloat>:
#include "x86.h"
#include "syscall.h"

int
fetchfloat(uint addr, float *fp)
{
801060f0:	f3 0f 1e fb          	endbr32 
801060f4:	55                   	push   %ebp
801060f5:	89 e5                	mov    %esp,%ebp
801060f7:	53                   	push   %ebx
801060f8:	83 ec 04             	sub    $0x4,%esp
801060fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801060fe:	e8 6d de ff ff       	call   80103f70 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106103:	8b 00                	mov    (%eax),%eax
80106105:	39 d8                	cmp    %ebx,%eax
80106107:	76 17                	jbe    80106120 <fetchfloat+0x30>
80106109:	8d 53 04             	lea    0x4(%ebx),%edx
8010610c:	39 d0                	cmp    %edx,%eax
8010610e:	72 10                	jb     80106120 <fetchfloat+0x30>
    return -1;
  *fp = *(float*)(addr);
80106110:	d9 03                	flds   (%ebx)
80106112:	8b 45 0c             	mov    0xc(%ebp),%eax
80106115:	d9 18                	fstps  (%eax)
  return 0;
80106117:	31 c0                	xor    %eax,%eax
}
80106119:	83 c4 04             	add    $0x4,%esp
8010611c:	5b                   	pop    %ebx
8010611d:	5d                   	pop    %ebp
8010611e:	c3                   	ret    
8010611f:	90                   	nop
    return -1;
80106120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106125:	eb f2                	jmp    80106119 <fetchfloat+0x29>
80106127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010612e:	66 90                	xchg   %ax,%ax

80106130 <argfloat>:


int
argfloat(int n, float *fp)
{
80106130:	f3 0f 1e fb          	endbr32 
80106134:	55                   	push   %ebp
80106135:	89 e5                	mov    %esp,%ebp
80106137:	56                   	push   %esi
80106138:	53                   	push   %ebx
  return fetchfloat((myproc()->tf->esp) + 4 + 4*n, fp);
80106139:	e8 32 de ff ff       	call   80103f70 <myproc>
8010613e:	8b 55 08             	mov    0x8(%ebp),%edx
80106141:	8b 40 18             	mov    0x18(%eax),%eax
80106144:	8b 40 44             	mov    0x44(%eax),%eax
80106147:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010614a:	e8 21 de ff ff       	call   80103f70 <myproc>
  return fetchfloat((myproc()->tf->esp) + 4 + 4*n, fp);
8010614f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106152:	8b 00                	mov    (%eax),%eax
80106154:	39 c6                	cmp    %eax,%esi
80106156:	73 18                	jae    80106170 <argfloat+0x40>
80106158:	8d 53 08             	lea    0x8(%ebx),%edx
8010615b:	39 d0                	cmp    %edx,%eax
8010615d:	72 11                	jb     80106170 <argfloat+0x40>
  *fp = *(float*)(addr);
8010615f:	d9 43 04             	flds   0x4(%ebx)
80106162:	8b 45 0c             	mov    0xc(%ebp),%eax
80106165:	d9 18                	fstps  (%eax)
  return 0;
80106167:	31 c0                	xor    %eax,%eax
}
80106169:	5b                   	pop    %ebx
8010616a:	5e                   	pop    %esi
8010616b:	5d                   	pop    %ebp
8010616c:	c3                   	ret    
8010616d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchfloat((myproc()->tf->esp) + 4 + 4*n, fp);
80106175:	eb f2                	jmp    80106169 <argfloat+0x39>
80106177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617e:	66 90                	xchg   %ax,%ax

80106180 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80106180:	f3 0f 1e fb          	endbr32 
80106184:	55                   	push   %ebp
80106185:	89 e5                	mov    %esp,%ebp
80106187:	53                   	push   %ebx
80106188:	83 ec 04             	sub    $0x4,%esp
8010618b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010618e:	e8 dd dd ff ff       	call   80103f70 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106193:	8b 00                	mov    (%eax),%eax
80106195:	39 d8                	cmp    %ebx,%eax
80106197:	76 17                	jbe    801061b0 <fetchint+0x30>
80106199:	8d 53 04             	lea    0x4(%ebx),%edx
8010619c:	39 d0                	cmp    %edx,%eax
8010619e:	72 10                	jb     801061b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801061a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801061a3:	8b 13                	mov    (%ebx),%edx
801061a5:	89 10                	mov    %edx,(%eax)
  return 0;
801061a7:	31 c0                	xor    %eax,%eax
}
801061a9:	83 c4 04             	add    $0x4,%esp
801061ac:	5b                   	pop    %ebx
801061ad:	5d                   	pop    %ebp
801061ae:	c3                   	ret    
801061af:	90                   	nop
    return -1;
801061b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b5:	eb f2                	jmp    801061a9 <fetchint+0x29>
801061b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061be:	66 90                	xchg   %ax,%ax

801061c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801061c0:	f3 0f 1e fb          	endbr32 
801061c4:	55                   	push   %ebp
801061c5:	89 e5                	mov    %esp,%ebp
801061c7:	53                   	push   %ebx
801061c8:	83 ec 04             	sub    $0x4,%esp
801061cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801061ce:	e8 9d dd ff ff       	call   80103f70 <myproc>

  if(addr >= curproc->sz)
801061d3:	39 18                	cmp    %ebx,(%eax)
801061d5:	76 31                	jbe    80106208 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
801061d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801061da:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801061dc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801061de:	39 d3                	cmp    %edx,%ebx
801061e0:	73 26                	jae    80106208 <fetchstr+0x48>
801061e2:	89 d8                	mov    %ebx,%eax
801061e4:	eb 11                	jmp    801061f7 <fetchstr+0x37>
801061e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ed:	8d 76 00             	lea    0x0(%esi),%esi
801061f0:	83 c0 01             	add    $0x1,%eax
801061f3:	39 c2                	cmp    %eax,%edx
801061f5:	76 11                	jbe    80106208 <fetchstr+0x48>
    if(*s == 0)
801061f7:	80 38 00             	cmpb   $0x0,(%eax)
801061fa:	75 f4                	jne    801061f0 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
801061fc:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
801061ff:	29 d8                	sub    %ebx,%eax
}
80106201:	5b                   	pop    %ebx
80106202:	5d                   	pop    %ebp
80106203:	c3                   	ret    
80106204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106208:	83 c4 04             	add    $0x4,%esp
    return -1;
8010620b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106210:	5b                   	pop    %ebx
80106211:	5d                   	pop    %ebp
80106212:	c3                   	ret    
80106213:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010621a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106220 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106220:	f3 0f 1e fb          	endbr32 
80106224:	55                   	push   %ebp
80106225:	89 e5                	mov    %esp,%ebp
80106227:	56                   	push   %esi
80106228:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106229:	e8 42 dd ff ff       	call   80103f70 <myproc>
8010622e:	8b 55 08             	mov    0x8(%ebp),%edx
80106231:	8b 40 18             	mov    0x18(%eax),%eax
80106234:	8b 40 44             	mov    0x44(%eax),%eax
80106237:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010623a:	e8 31 dd ff ff       	call   80103f70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010623f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106242:	8b 00                	mov    (%eax),%eax
80106244:	39 c6                	cmp    %eax,%esi
80106246:	73 18                	jae    80106260 <argint+0x40>
80106248:	8d 53 08             	lea    0x8(%ebx),%edx
8010624b:	39 d0                	cmp    %edx,%eax
8010624d:	72 11                	jb     80106260 <argint+0x40>
  *ip = *(int*)(addr);
8010624f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106252:	8b 53 04             	mov    0x4(%ebx),%edx
80106255:	89 10                	mov    %edx,(%eax)
  return 0;
80106257:	31 c0                	xor    %eax,%eax
}
80106259:	5b                   	pop    %ebx
8010625a:	5e                   	pop    %esi
8010625b:	5d                   	pop    %ebp
8010625c:	c3                   	ret    
8010625d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106265:	eb f2                	jmp    80106259 <argint+0x39>
80106267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626e:	66 90                	xchg   %ax,%ax

80106270 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106270:	f3 0f 1e fb          	endbr32 
80106274:	55                   	push   %ebp
80106275:	89 e5                	mov    %esp,%ebp
80106277:	56                   	push   %esi
80106278:	53                   	push   %ebx
80106279:	83 ec 10             	sub    $0x10,%esp
8010627c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010627f:	e8 ec dc ff ff       	call   80103f70 <myproc>
 
  if(argint(n, &i) < 0)
80106284:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80106287:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80106289:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010628c:	50                   	push   %eax
8010628d:	ff 75 08             	pushl  0x8(%ebp)
80106290:	e8 8b ff ff ff       	call   80106220 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106295:	83 c4 10             	add    $0x10,%esp
80106298:	85 c0                	test   %eax,%eax
8010629a:	78 24                	js     801062c0 <argptr+0x50>
8010629c:	85 db                	test   %ebx,%ebx
8010629e:	78 20                	js     801062c0 <argptr+0x50>
801062a0:	8b 16                	mov    (%esi),%edx
801062a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a5:	39 c2                	cmp    %eax,%edx
801062a7:	76 17                	jbe    801062c0 <argptr+0x50>
801062a9:	01 c3                	add    %eax,%ebx
801062ab:	39 da                	cmp    %ebx,%edx
801062ad:	72 11                	jb     801062c0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801062af:	8b 55 0c             	mov    0xc(%ebp),%edx
801062b2:	89 02                	mov    %eax,(%edx)
  return 0;
801062b4:	31 c0                	xor    %eax,%eax
}
801062b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801062b9:	5b                   	pop    %ebx
801062ba:	5e                   	pop    %esi
801062bb:	5d                   	pop    %ebp
801062bc:	c3                   	ret    
801062bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801062c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c5:	eb ef                	jmp    801062b6 <argptr+0x46>
801062c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ce:	66 90                	xchg   %ax,%ax

801062d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801062d0:	f3 0f 1e fb          	endbr32 
801062d4:	55                   	push   %ebp
801062d5:	89 e5                	mov    %esp,%ebp
801062d7:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801062da:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062dd:	50                   	push   %eax
801062de:	ff 75 08             	pushl  0x8(%ebp)
801062e1:	e8 3a ff ff ff       	call   80106220 <argint>
801062e6:	83 c4 10             	add    $0x10,%esp
801062e9:	85 c0                	test   %eax,%eax
801062eb:	78 13                	js     80106300 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801062ed:	83 ec 08             	sub    $0x8,%esp
801062f0:	ff 75 0c             	pushl  0xc(%ebp)
801062f3:	ff 75 f4             	pushl  -0xc(%ebp)
801062f6:	e8 c5 fe ff ff       	call   801061c0 <fetchstr>
801062fb:	83 c4 10             	add    $0x10,%esp
}
801062fe:	c9                   	leave  
801062ff:	c3                   	ret    
80106300:	c9                   	leave  
    return -1;
80106301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106306:	c3                   	ret    
80106307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010630e:	66 90                	xchg   %ax,%ax

80106310 <syscall>:

};

void
syscall(void)
{
80106310:	f3 0f 1e fb          	endbr32 
80106314:	55                   	push   %ebp
80106315:	89 e5                	mov    %esp,%ebp
80106317:	53                   	push   %ebx
80106318:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010631b:	e8 50 dc ff ff       	call   80103f70 <myproc>
80106320:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80106322:	8b 40 18             	mov    0x18(%eax),%eax
80106325:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106328:	8d 50 ff             	lea    -0x1(%eax),%edx
8010632b:	83 fa 22             	cmp    $0x22,%edx
8010632e:	77 20                	ja     80106350 <syscall+0x40>
80106330:	8b 14 85 40 a6 10 80 	mov    -0x7fef59c0(,%eax,4),%edx
80106337:	85 d2                	test   %edx,%edx
80106339:	74 15                	je     80106350 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010633b:	ff d2                	call   *%edx
8010633d:	89 c2                	mov    %eax,%edx
8010633f:	8b 43 18             	mov    0x18(%ebx),%eax
80106342:	89 50 1c             	mov    %edx,0x1c(%eax)
80106345:	eb 28                	jmp    8010636f <syscall+0x5f>
80106347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010634e:	66 90                	xchg   %ax,%ax
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80106350:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80106351:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80106354:	50                   	push   %eax
80106355:	ff 73 10             	pushl  0x10(%ebx)
80106358:	68 0b a6 10 80       	push   $0x8010a60b
8010635d:	e8 5e a5 ff ff       	call   801008c0 <cprintf>
    curproc->tf->eax = -1;
80106362:	8b 43 18             	mov    0x18(%ebx),%eax
80106365:	83 c4 10             	add    $0x10,%esp
80106368:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }

  pushcli();
8010636f:	e8 2c f9 ff ff       	call   80105ca0 <pushcli>
  mycpu()->syscalls_count++;
80106374:	e8 67 db ff ff       	call   80103ee0 <mycpu>
80106379:	83 80 b0 00 00 00 01 	addl   $0x1,0xb0(%eax)
  popcli();
80106380:	e8 6b f9 ff ff       	call   80105cf0 <popcli>
  count_shared_syscalls++;
80106385:	83 05 c0 d5 10 80 01 	addl   $0x1,0x8010d5c0
}
8010638c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010638f:	c9                   	leave  
80106390:	c3                   	ret    
80106391:	66 90                	xchg   %ax,%ax
80106393:	66 90                	xchg   %ax,%ax
80106395:	66 90                	xchg   %ax,%ax
80106397:	66 90                	xchg   %ax,%ax
80106399:	66 90                	xchg   %ax,%ax
8010639b:	66 90                	xchg   %ax,%ax
8010639d:	66 90                	xchg   %ax,%ax
8010639f:	90                   	nop

801063a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	57                   	push   %edi
801063a4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801063a5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801063a8:	53                   	push   %ebx
801063a9:	83 ec 34             	sub    $0x34,%esp
801063ac:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801063af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801063b2:	57                   	push   %edi
801063b3:	50                   	push   %eax
{
801063b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801063b7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801063ba:	e8 01 c2 ff ff       	call   801025c0 <nameiparent>
801063bf:	83 c4 10             	add    $0x10,%esp
801063c2:	85 c0                	test   %eax,%eax
801063c4:	0f 84 46 01 00 00    	je     80106510 <create+0x170>
    return 0;
  ilock(dp);
801063ca:	83 ec 0c             	sub    $0xc,%esp
801063cd:	89 c3                	mov    %eax,%ebx
801063cf:	50                   	push   %eax
801063d0:	e8 fb b8 ff ff       	call   80101cd0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801063d5:	83 c4 0c             	add    $0xc,%esp
801063d8:	6a 00                	push   $0x0
801063da:	57                   	push   %edi
801063db:	53                   	push   %ebx
801063dc:	e8 3f be ff ff       	call   80102220 <dirlookup>
801063e1:	83 c4 10             	add    $0x10,%esp
801063e4:	89 c6                	mov    %eax,%esi
801063e6:	85 c0                	test   %eax,%eax
801063e8:	74 56                	je     80106440 <create+0xa0>
    iunlockput(dp);
801063ea:	83 ec 0c             	sub    $0xc,%esp
801063ed:	53                   	push   %ebx
801063ee:	e8 7d bb ff ff       	call   80101f70 <iunlockput>
    ilock(ip);
801063f3:	89 34 24             	mov    %esi,(%esp)
801063f6:	e8 d5 b8 ff ff       	call   80101cd0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801063fb:	83 c4 10             	add    $0x10,%esp
801063fe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106403:	75 1b                	jne    80106420 <create+0x80>
80106405:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010640a:	75 14                	jne    80106420 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010640c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010640f:	89 f0                	mov    %esi,%eax
80106411:	5b                   	pop    %ebx
80106412:	5e                   	pop    %esi
80106413:	5f                   	pop    %edi
80106414:	5d                   	pop    %ebp
80106415:	c3                   	ret    
80106416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010641d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80106420:	83 ec 0c             	sub    $0xc,%esp
80106423:	56                   	push   %esi
    return 0;
80106424:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106426:	e8 45 bb ff ff       	call   80101f70 <iunlockput>
    return 0;
8010642b:	83 c4 10             	add    $0x10,%esp
}
8010642e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106431:	89 f0                	mov    %esi,%eax
80106433:	5b                   	pop    %ebx
80106434:	5e                   	pop    %esi
80106435:	5f                   	pop    %edi
80106436:	5d                   	pop    %ebp
80106437:	c3                   	ret    
80106438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010643f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80106440:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80106444:	83 ec 08             	sub    $0x8,%esp
80106447:	50                   	push   %eax
80106448:	ff 33                	pushl  (%ebx)
8010644a:	e8 01 b7 ff ff       	call   80101b50 <ialloc>
8010644f:	83 c4 10             	add    $0x10,%esp
80106452:	89 c6                	mov    %eax,%esi
80106454:	85 c0                	test   %eax,%eax
80106456:	0f 84 cd 00 00 00    	je     80106529 <create+0x189>
  ilock(ip);
8010645c:	83 ec 0c             	sub    $0xc,%esp
8010645f:	50                   	push   %eax
80106460:	e8 6b b8 ff ff       	call   80101cd0 <ilock>
  ip->major = major;
80106465:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80106469:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010646d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80106471:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80106475:	b8 01 00 00 00       	mov    $0x1,%eax
8010647a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010647e:	89 34 24             	mov    %esi,(%esp)
80106481:	e8 8a b7 ff ff       	call   80101c10 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80106486:	83 c4 10             	add    $0x10,%esp
80106489:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010648e:	74 30                	je     801064c0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80106490:	83 ec 04             	sub    $0x4,%esp
80106493:	ff 76 04             	pushl  0x4(%esi)
80106496:	57                   	push   %edi
80106497:	53                   	push   %ebx
80106498:	e8 43 c0 ff ff       	call   801024e0 <dirlink>
8010649d:	83 c4 10             	add    $0x10,%esp
801064a0:	85 c0                	test   %eax,%eax
801064a2:	78 78                	js     8010651c <create+0x17c>
  iunlockput(dp);
801064a4:	83 ec 0c             	sub    $0xc,%esp
801064a7:	53                   	push   %ebx
801064a8:	e8 c3 ba ff ff       	call   80101f70 <iunlockput>
  return ip;
801064ad:	83 c4 10             	add    $0x10,%esp
}
801064b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064b3:	89 f0                	mov    %esi,%eax
801064b5:	5b                   	pop    %ebx
801064b6:	5e                   	pop    %esi
801064b7:	5f                   	pop    %edi
801064b8:	5d                   	pop    %ebp
801064b9:	c3                   	ret    
801064ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801064c0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801064c3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801064c8:	53                   	push   %ebx
801064c9:	e8 42 b7 ff ff       	call   80101c10 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801064ce:	83 c4 0c             	add    $0xc,%esp
801064d1:	ff 76 04             	pushl  0x4(%esi)
801064d4:	68 ec a6 10 80       	push   $0x8010a6ec
801064d9:	56                   	push   %esi
801064da:	e8 01 c0 ff ff       	call   801024e0 <dirlink>
801064df:	83 c4 10             	add    $0x10,%esp
801064e2:	85 c0                	test   %eax,%eax
801064e4:	78 18                	js     801064fe <create+0x15e>
801064e6:	83 ec 04             	sub    $0x4,%esp
801064e9:	ff 73 04             	pushl  0x4(%ebx)
801064ec:	68 eb a6 10 80       	push   $0x8010a6eb
801064f1:	56                   	push   %esi
801064f2:	e8 e9 bf ff ff       	call   801024e0 <dirlink>
801064f7:	83 c4 10             	add    $0x10,%esp
801064fa:	85 c0                	test   %eax,%eax
801064fc:	79 92                	jns    80106490 <create+0xf0>
      panic("create dots");
801064fe:	83 ec 0c             	sub    $0xc,%esp
80106501:	68 df a6 10 80       	push   $0x8010a6df
80106506:	e8 85 9e ff ff       	call   80100390 <panic>
8010650b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010650f:	90                   	nop
}
80106510:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106513:	31 f6                	xor    %esi,%esi
}
80106515:	5b                   	pop    %ebx
80106516:	89 f0                	mov    %esi,%eax
80106518:	5e                   	pop    %esi
80106519:	5f                   	pop    %edi
8010651a:	5d                   	pop    %ebp
8010651b:	c3                   	ret    
    panic("create: dirlink");
8010651c:	83 ec 0c             	sub    $0xc,%esp
8010651f:	68 ee a6 10 80       	push   $0x8010a6ee
80106524:	e8 67 9e ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80106529:	83 ec 0c             	sub    $0xc,%esp
8010652c:	68 d0 a6 10 80       	push   $0x8010a6d0
80106531:	e8 5a 9e ff ff       	call   80100390 <panic>
80106536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010653d:	8d 76 00             	lea    0x0(%esi),%esi

80106540 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	56                   	push   %esi
80106544:	89 d6                	mov    %edx,%esi
80106546:	53                   	push   %ebx
80106547:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80106549:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010654c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010654f:	50                   	push   %eax
80106550:	6a 00                	push   $0x0
80106552:	e8 c9 fc ff ff       	call   80106220 <argint>
80106557:	83 c4 10             	add    $0x10,%esp
8010655a:	85 c0                	test   %eax,%eax
8010655c:	78 2a                	js     80106588 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010655e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106562:	77 24                	ja     80106588 <argfd.constprop.0+0x48>
80106564:	e8 07 da ff ff       	call   80103f70 <myproc>
80106569:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010656c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106570:	85 c0                	test   %eax,%eax
80106572:	74 14                	je     80106588 <argfd.constprop.0+0x48>
  if(pfd)
80106574:	85 db                	test   %ebx,%ebx
80106576:	74 02                	je     8010657a <argfd.constprop.0+0x3a>
    *pfd = fd;
80106578:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010657a:	89 06                	mov    %eax,(%esi)
  return 0;
8010657c:	31 c0                	xor    %eax,%eax
}
8010657e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106581:	5b                   	pop    %ebx
80106582:	5e                   	pop    %esi
80106583:	5d                   	pop    %ebp
80106584:	c3                   	ret    
80106585:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106588:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010658d:	eb ef                	jmp    8010657e <argfd.constprop.0+0x3e>
8010658f:	90                   	nop

80106590 <sys_dup>:
{
80106590:	f3 0f 1e fb          	endbr32 
80106594:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106595:	31 c0                	xor    %eax,%eax
{
80106597:	89 e5                	mov    %esp,%ebp
80106599:	56                   	push   %esi
8010659a:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
8010659b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010659e:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801065a1:	e8 9a ff ff ff       	call   80106540 <argfd.constprop.0>
801065a6:	85 c0                	test   %eax,%eax
801065a8:	78 1e                	js     801065c8 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801065aa:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801065ad:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801065af:	e8 bc d9 ff ff       	call   80103f70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801065b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801065b8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801065bc:	85 d2                	test   %edx,%edx
801065be:	74 20                	je     801065e0 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
801065c0:	83 c3 01             	add    $0x1,%ebx
801065c3:	83 fb 10             	cmp    $0x10,%ebx
801065c6:	75 f0                	jne    801065b8 <sys_dup+0x28>
}
801065c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801065cb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801065d0:	89 d8                	mov    %ebx,%eax
801065d2:	5b                   	pop    %ebx
801065d3:	5e                   	pop    %esi
801065d4:	5d                   	pop    %ebp
801065d5:	c3                   	ret    
801065d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065dd:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801065e0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801065e4:	83 ec 0c             	sub    $0xc,%esp
801065e7:	ff 75 f4             	pushl  -0xc(%ebp)
801065ea:	e8 f1 ad ff ff       	call   801013e0 <filedup>
  return fd;
801065ef:	83 c4 10             	add    $0x10,%esp
}
801065f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801065f5:	89 d8                	mov    %ebx,%eax
801065f7:	5b                   	pop    %ebx
801065f8:	5e                   	pop    %esi
801065f9:	5d                   	pop    %ebp
801065fa:	c3                   	ret    
801065fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065ff:	90                   	nop

80106600 <sys_read>:
{
80106600:	f3 0f 1e fb          	endbr32 
80106604:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106605:	31 c0                	xor    %eax,%eax
{
80106607:	89 e5                	mov    %esp,%ebp
80106609:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010660c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010660f:	e8 2c ff ff ff       	call   80106540 <argfd.constprop.0>
80106614:	85 c0                	test   %eax,%eax
80106616:	78 48                	js     80106660 <sys_read+0x60>
80106618:	83 ec 08             	sub    $0x8,%esp
8010661b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010661e:	50                   	push   %eax
8010661f:	6a 02                	push   $0x2
80106621:	e8 fa fb ff ff       	call   80106220 <argint>
80106626:	83 c4 10             	add    $0x10,%esp
80106629:	85 c0                	test   %eax,%eax
8010662b:	78 33                	js     80106660 <sys_read+0x60>
8010662d:	83 ec 04             	sub    $0x4,%esp
80106630:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106633:	ff 75 f0             	pushl  -0x10(%ebp)
80106636:	50                   	push   %eax
80106637:	6a 01                	push   $0x1
80106639:	e8 32 fc ff ff       	call   80106270 <argptr>
8010663e:	83 c4 10             	add    $0x10,%esp
80106641:	85 c0                	test   %eax,%eax
80106643:	78 1b                	js     80106660 <sys_read+0x60>
  return fileread(f, p, n);
80106645:	83 ec 04             	sub    $0x4,%esp
80106648:	ff 75 f0             	pushl  -0x10(%ebp)
8010664b:	ff 75 f4             	pushl  -0xc(%ebp)
8010664e:	ff 75 ec             	pushl  -0x14(%ebp)
80106651:	e8 0a af ff ff       	call   80101560 <fileread>
80106656:	83 c4 10             	add    $0x10,%esp
}
80106659:	c9                   	leave  
8010665a:	c3                   	ret    
8010665b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010665f:	90                   	nop
80106660:	c9                   	leave  
    return -1;
80106661:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106666:	c3                   	ret    
80106667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010666e:	66 90                	xchg   %ax,%ax

80106670 <sys_write>:
{
80106670:	f3 0f 1e fb          	endbr32 
80106674:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106675:	31 c0                	xor    %eax,%eax
{
80106677:	89 e5                	mov    %esp,%ebp
80106679:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010667c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010667f:	e8 bc fe ff ff       	call   80106540 <argfd.constprop.0>
80106684:	85 c0                	test   %eax,%eax
80106686:	78 48                	js     801066d0 <sys_write+0x60>
80106688:	83 ec 08             	sub    $0x8,%esp
8010668b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010668e:	50                   	push   %eax
8010668f:	6a 02                	push   $0x2
80106691:	e8 8a fb ff ff       	call   80106220 <argint>
80106696:	83 c4 10             	add    $0x10,%esp
80106699:	85 c0                	test   %eax,%eax
8010669b:	78 33                	js     801066d0 <sys_write+0x60>
8010669d:	83 ec 04             	sub    $0x4,%esp
801066a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066a3:	ff 75 f0             	pushl  -0x10(%ebp)
801066a6:	50                   	push   %eax
801066a7:	6a 01                	push   $0x1
801066a9:	e8 c2 fb ff ff       	call   80106270 <argptr>
801066ae:	83 c4 10             	add    $0x10,%esp
801066b1:	85 c0                	test   %eax,%eax
801066b3:	78 1b                	js     801066d0 <sys_write+0x60>
  return filewrite(f, p, n);
801066b5:	83 ec 04             	sub    $0x4,%esp
801066b8:	ff 75 f0             	pushl  -0x10(%ebp)
801066bb:	ff 75 f4             	pushl  -0xc(%ebp)
801066be:	ff 75 ec             	pushl  -0x14(%ebp)
801066c1:	e8 3a af ff ff       	call   80101600 <filewrite>
801066c6:	83 c4 10             	add    $0x10,%esp
}
801066c9:	c9                   	leave  
801066ca:	c3                   	ret    
801066cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801066cf:	90                   	nop
801066d0:	c9                   	leave  
    return -1;
801066d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066d6:	c3                   	ret    
801066d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066de:	66 90                	xchg   %ax,%ax

801066e0 <sys_close>:
{
801066e0:	f3 0f 1e fb          	endbr32 
801066e4:	55                   	push   %ebp
801066e5:	89 e5                	mov    %esp,%ebp
801066e7:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801066ea:	8d 55 f4             	lea    -0xc(%ebp),%edx
801066ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066f0:	e8 4b fe ff ff       	call   80106540 <argfd.constprop.0>
801066f5:	85 c0                	test   %eax,%eax
801066f7:	78 27                	js     80106720 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801066f9:	e8 72 d8 ff ff       	call   80103f70 <myproc>
801066fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80106701:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80106704:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010670b:	00 
  fileclose(f);
8010670c:	ff 75 f4             	pushl  -0xc(%ebp)
8010670f:	e8 1c ad ff ff       	call   80101430 <fileclose>
  return 0;
80106714:	83 c4 10             	add    $0x10,%esp
80106717:	31 c0                	xor    %eax,%eax
}
80106719:	c9                   	leave  
8010671a:	c3                   	ret    
8010671b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010671f:	90                   	nop
80106720:	c9                   	leave  
    return -1;
80106721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106726:	c3                   	ret    
80106727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010672e:	66 90                	xchg   %ax,%ax

80106730 <sys_fstat>:
{
80106730:	f3 0f 1e fb          	endbr32 
80106734:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106735:	31 c0                	xor    %eax,%eax
{
80106737:	89 e5                	mov    %esp,%ebp
80106739:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010673c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010673f:	e8 fc fd ff ff       	call   80106540 <argfd.constprop.0>
80106744:	85 c0                	test   %eax,%eax
80106746:	78 30                	js     80106778 <sys_fstat+0x48>
80106748:	83 ec 04             	sub    $0x4,%esp
8010674b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010674e:	6a 14                	push   $0x14
80106750:	50                   	push   %eax
80106751:	6a 01                	push   $0x1
80106753:	e8 18 fb ff ff       	call   80106270 <argptr>
80106758:	83 c4 10             	add    $0x10,%esp
8010675b:	85 c0                	test   %eax,%eax
8010675d:	78 19                	js     80106778 <sys_fstat+0x48>
  return filestat(f, st);
8010675f:	83 ec 08             	sub    $0x8,%esp
80106762:	ff 75 f4             	pushl  -0xc(%ebp)
80106765:	ff 75 f0             	pushl  -0x10(%ebp)
80106768:	e8 a3 ad ff ff       	call   80101510 <filestat>
8010676d:	83 c4 10             	add    $0x10,%esp
}
80106770:	c9                   	leave  
80106771:	c3                   	ret    
80106772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106778:	c9                   	leave  
    return -1;
80106779:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010677e:	c3                   	ret    
8010677f:	90                   	nop

80106780 <sys_link>:
{
80106780:	f3 0f 1e fb          	endbr32 
80106784:	55                   	push   %ebp
80106785:	89 e5                	mov    %esp,%ebp
80106787:	57                   	push   %edi
80106788:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106789:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010678c:	53                   	push   %ebx
8010678d:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106790:	50                   	push   %eax
80106791:	6a 00                	push   $0x0
80106793:	e8 38 fb ff ff       	call   801062d0 <argstr>
80106798:	83 c4 10             	add    $0x10,%esp
8010679b:	85 c0                	test   %eax,%eax
8010679d:	0f 88 ff 00 00 00    	js     801068a2 <sys_link+0x122>
801067a3:	83 ec 08             	sub    $0x8,%esp
801067a6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801067a9:	50                   	push   %eax
801067aa:	6a 01                	push   $0x1
801067ac:	e8 1f fb ff ff       	call   801062d0 <argstr>
801067b1:	83 c4 10             	add    $0x10,%esp
801067b4:	85 c0                	test   %eax,%eax
801067b6:	0f 88 e6 00 00 00    	js     801068a2 <sys_link+0x122>
  begin_op();
801067bc:	e8 df ca ff ff       	call   801032a0 <begin_op>
  if((ip = namei(old)) == 0){
801067c1:	83 ec 0c             	sub    $0xc,%esp
801067c4:	ff 75 d4             	pushl  -0x2c(%ebp)
801067c7:	e8 d4 bd ff ff       	call   801025a0 <namei>
801067cc:	83 c4 10             	add    $0x10,%esp
801067cf:	89 c3                	mov    %eax,%ebx
801067d1:	85 c0                	test   %eax,%eax
801067d3:	0f 84 e8 00 00 00    	je     801068c1 <sys_link+0x141>
  ilock(ip);
801067d9:	83 ec 0c             	sub    $0xc,%esp
801067dc:	50                   	push   %eax
801067dd:	e8 ee b4 ff ff       	call   80101cd0 <ilock>
  if(ip->type == T_DIR){
801067e2:	83 c4 10             	add    $0x10,%esp
801067e5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801067ea:	0f 84 b9 00 00 00    	je     801068a9 <sys_link+0x129>
  iupdate(ip);
801067f0:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801067f3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801067f8:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801067fb:	53                   	push   %ebx
801067fc:	e8 0f b4 ff ff       	call   80101c10 <iupdate>
  iunlock(ip);
80106801:	89 1c 24             	mov    %ebx,(%esp)
80106804:	e8 a7 b5 ff ff       	call   80101db0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106809:	58                   	pop    %eax
8010680a:	5a                   	pop    %edx
8010680b:	57                   	push   %edi
8010680c:	ff 75 d0             	pushl  -0x30(%ebp)
8010680f:	e8 ac bd ff ff       	call   801025c0 <nameiparent>
80106814:	83 c4 10             	add    $0x10,%esp
80106817:	89 c6                	mov    %eax,%esi
80106819:	85 c0                	test   %eax,%eax
8010681b:	74 5f                	je     8010687c <sys_link+0xfc>
  ilock(dp);
8010681d:	83 ec 0c             	sub    $0xc,%esp
80106820:	50                   	push   %eax
80106821:	e8 aa b4 ff ff       	call   80101cd0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106826:	8b 03                	mov    (%ebx),%eax
80106828:	83 c4 10             	add    $0x10,%esp
8010682b:	39 06                	cmp    %eax,(%esi)
8010682d:	75 41                	jne    80106870 <sys_link+0xf0>
8010682f:	83 ec 04             	sub    $0x4,%esp
80106832:	ff 73 04             	pushl  0x4(%ebx)
80106835:	57                   	push   %edi
80106836:	56                   	push   %esi
80106837:	e8 a4 bc ff ff       	call   801024e0 <dirlink>
8010683c:	83 c4 10             	add    $0x10,%esp
8010683f:	85 c0                	test   %eax,%eax
80106841:	78 2d                	js     80106870 <sys_link+0xf0>
  iunlockput(dp);
80106843:	83 ec 0c             	sub    $0xc,%esp
80106846:	56                   	push   %esi
80106847:	e8 24 b7 ff ff       	call   80101f70 <iunlockput>
  iput(ip);
8010684c:	89 1c 24             	mov    %ebx,(%esp)
8010684f:	e8 ac b5 ff ff       	call   80101e00 <iput>
  end_op();
80106854:	e8 b7 ca ff ff       	call   80103310 <end_op>
  return 0;
80106859:	83 c4 10             	add    $0x10,%esp
8010685c:	31 c0                	xor    %eax,%eax
}
8010685e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106861:	5b                   	pop    %ebx
80106862:	5e                   	pop    %esi
80106863:	5f                   	pop    %edi
80106864:	5d                   	pop    %ebp
80106865:	c3                   	ret    
80106866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010686d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80106870:	83 ec 0c             	sub    $0xc,%esp
80106873:	56                   	push   %esi
80106874:	e8 f7 b6 ff ff       	call   80101f70 <iunlockput>
    goto bad;
80106879:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010687c:	83 ec 0c             	sub    $0xc,%esp
8010687f:	53                   	push   %ebx
80106880:	e8 4b b4 ff ff       	call   80101cd0 <ilock>
  ip->nlink--;
80106885:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010688a:	89 1c 24             	mov    %ebx,(%esp)
8010688d:	e8 7e b3 ff ff       	call   80101c10 <iupdate>
  iunlockput(ip);
80106892:	89 1c 24             	mov    %ebx,(%esp)
80106895:	e8 d6 b6 ff ff       	call   80101f70 <iunlockput>
  end_op();
8010689a:	e8 71 ca ff ff       	call   80103310 <end_op>
  return -1;
8010689f:	83 c4 10             	add    $0x10,%esp
801068a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068a7:	eb b5                	jmp    8010685e <sys_link+0xde>
    iunlockput(ip);
801068a9:	83 ec 0c             	sub    $0xc,%esp
801068ac:	53                   	push   %ebx
801068ad:	e8 be b6 ff ff       	call   80101f70 <iunlockput>
    end_op();
801068b2:	e8 59 ca ff ff       	call   80103310 <end_op>
    return -1;
801068b7:	83 c4 10             	add    $0x10,%esp
801068ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068bf:	eb 9d                	jmp    8010685e <sys_link+0xde>
    end_op();
801068c1:	e8 4a ca ff ff       	call   80103310 <end_op>
    return -1;
801068c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068cb:	eb 91                	jmp    8010685e <sys_link+0xde>
801068cd:	8d 76 00             	lea    0x0(%esi),%esi

801068d0 <sys_unlink>:
{
801068d0:	f3 0f 1e fb          	endbr32 
801068d4:	55                   	push   %ebp
801068d5:	89 e5                	mov    %esp,%ebp
801068d7:	57                   	push   %edi
801068d8:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801068d9:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801068dc:	53                   	push   %ebx
801068dd:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801068e0:	50                   	push   %eax
801068e1:	6a 00                	push   $0x0
801068e3:	e8 e8 f9 ff ff       	call   801062d0 <argstr>
801068e8:	83 c4 10             	add    $0x10,%esp
801068eb:	85 c0                	test   %eax,%eax
801068ed:	0f 88 7d 01 00 00    	js     80106a70 <sys_unlink+0x1a0>
  begin_op();
801068f3:	e8 a8 c9 ff ff       	call   801032a0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801068f8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801068fb:	83 ec 08             	sub    $0x8,%esp
801068fe:	53                   	push   %ebx
801068ff:	ff 75 c0             	pushl  -0x40(%ebp)
80106902:	e8 b9 bc ff ff       	call   801025c0 <nameiparent>
80106907:	83 c4 10             	add    $0x10,%esp
8010690a:	89 c6                	mov    %eax,%esi
8010690c:	85 c0                	test   %eax,%eax
8010690e:	0f 84 66 01 00 00    	je     80106a7a <sys_unlink+0x1aa>
  ilock(dp);
80106914:	83 ec 0c             	sub    $0xc,%esp
80106917:	50                   	push   %eax
80106918:	e8 b3 b3 ff ff       	call   80101cd0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010691d:	58                   	pop    %eax
8010691e:	5a                   	pop    %edx
8010691f:	68 ec a6 10 80       	push   $0x8010a6ec
80106924:	53                   	push   %ebx
80106925:	e8 d6 b8 ff ff       	call   80102200 <namecmp>
8010692a:	83 c4 10             	add    $0x10,%esp
8010692d:	85 c0                	test   %eax,%eax
8010692f:	0f 84 03 01 00 00    	je     80106a38 <sys_unlink+0x168>
80106935:	83 ec 08             	sub    $0x8,%esp
80106938:	68 eb a6 10 80       	push   $0x8010a6eb
8010693d:	53                   	push   %ebx
8010693e:	e8 bd b8 ff ff       	call   80102200 <namecmp>
80106943:	83 c4 10             	add    $0x10,%esp
80106946:	85 c0                	test   %eax,%eax
80106948:	0f 84 ea 00 00 00    	je     80106a38 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010694e:	83 ec 04             	sub    $0x4,%esp
80106951:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106954:	50                   	push   %eax
80106955:	53                   	push   %ebx
80106956:	56                   	push   %esi
80106957:	e8 c4 b8 ff ff       	call   80102220 <dirlookup>
8010695c:	83 c4 10             	add    $0x10,%esp
8010695f:	89 c3                	mov    %eax,%ebx
80106961:	85 c0                	test   %eax,%eax
80106963:	0f 84 cf 00 00 00    	je     80106a38 <sys_unlink+0x168>
  ilock(ip);
80106969:	83 ec 0c             	sub    $0xc,%esp
8010696c:	50                   	push   %eax
8010696d:	e8 5e b3 ff ff       	call   80101cd0 <ilock>
  if(ip->nlink < 1)
80106972:	83 c4 10             	add    $0x10,%esp
80106975:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010697a:	0f 8e 23 01 00 00    	jle    80106aa3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106980:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106985:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106988:	74 66                	je     801069f0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010698a:	83 ec 04             	sub    $0x4,%esp
8010698d:	6a 10                	push   $0x10
8010698f:	6a 00                	push   $0x0
80106991:	57                   	push   %edi
80106992:	e8 19 f5 ff ff       	call   80105eb0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106997:	6a 10                	push   $0x10
80106999:	ff 75 c4             	pushl  -0x3c(%ebp)
8010699c:	57                   	push   %edi
8010699d:	56                   	push   %esi
8010699e:	e8 2d b7 ff ff       	call   801020d0 <writei>
801069a3:	83 c4 20             	add    $0x20,%esp
801069a6:	83 f8 10             	cmp    $0x10,%eax
801069a9:	0f 85 e7 00 00 00    	jne    80106a96 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
801069af:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801069b4:	0f 84 96 00 00 00    	je     80106a50 <sys_unlink+0x180>
  iunlockput(dp);
801069ba:	83 ec 0c             	sub    $0xc,%esp
801069bd:	56                   	push   %esi
801069be:	e8 ad b5 ff ff       	call   80101f70 <iunlockput>
  ip->nlink--;
801069c3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801069c8:	89 1c 24             	mov    %ebx,(%esp)
801069cb:	e8 40 b2 ff ff       	call   80101c10 <iupdate>
  iunlockput(ip);
801069d0:	89 1c 24             	mov    %ebx,(%esp)
801069d3:	e8 98 b5 ff ff       	call   80101f70 <iunlockput>
  end_op();
801069d8:	e8 33 c9 ff ff       	call   80103310 <end_op>
  return 0;
801069dd:	83 c4 10             	add    $0x10,%esp
801069e0:	31 c0                	xor    %eax,%eax
}
801069e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069e5:	5b                   	pop    %ebx
801069e6:	5e                   	pop    %esi
801069e7:	5f                   	pop    %edi
801069e8:	5d                   	pop    %ebp
801069e9:	c3                   	ret    
801069ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801069f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801069f4:	76 94                	jbe    8010698a <sys_unlink+0xba>
801069f6:	ba 20 00 00 00       	mov    $0x20,%edx
801069fb:	eb 0b                	jmp    80106a08 <sys_unlink+0x138>
801069fd:	8d 76 00             	lea    0x0(%esi),%esi
80106a00:	83 c2 10             	add    $0x10,%edx
80106a03:	39 53 58             	cmp    %edx,0x58(%ebx)
80106a06:	76 82                	jbe    8010698a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106a08:	6a 10                	push   $0x10
80106a0a:	52                   	push   %edx
80106a0b:	57                   	push   %edi
80106a0c:	53                   	push   %ebx
80106a0d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106a10:	e8 bb b5 ff ff       	call   80101fd0 <readi>
80106a15:	83 c4 10             	add    $0x10,%esp
80106a18:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80106a1b:	83 f8 10             	cmp    $0x10,%eax
80106a1e:	75 69                	jne    80106a89 <sys_unlink+0x1b9>
    if(de.inum != 0)
80106a20:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106a25:	74 d9                	je     80106a00 <sys_unlink+0x130>
    iunlockput(ip);
80106a27:	83 ec 0c             	sub    $0xc,%esp
80106a2a:	53                   	push   %ebx
80106a2b:	e8 40 b5 ff ff       	call   80101f70 <iunlockput>
    goto bad;
80106a30:	83 c4 10             	add    $0x10,%esp
80106a33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a37:	90                   	nop
  iunlockput(dp);
80106a38:	83 ec 0c             	sub    $0xc,%esp
80106a3b:	56                   	push   %esi
80106a3c:	e8 2f b5 ff ff       	call   80101f70 <iunlockput>
  end_op();
80106a41:	e8 ca c8 ff ff       	call   80103310 <end_op>
  return -1;
80106a46:	83 c4 10             	add    $0x10,%esp
80106a49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a4e:	eb 92                	jmp    801069e2 <sys_unlink+0x112>
    iupdate(dp);
80106a50:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106a53:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80106a58:	56                   	push   %esi
80106a59:	e8 b2 b1 ff ff       	call   80101c10 <iupdate>
80106a5e:	83 c4 10             	add    $0x10,%esp
80106a61:	e9 54 ff ff ff       	jmp    801069ba <sys_unlink+0xea>
80106a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a6d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a75:	e9 68 ff ff ff       	jmp    801069e2 <sys_unlink+0x112>
    end_op();
80106a7a:	e8 91 c8 ff ff       	call   80103310 <end_op>
    return -1;
80106a7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a84:	e9 59 ff ff ff       	jmp    801069e2 <sys_unlink+0x112>
      panic("isdirempty: readi");
80106a89:	83 ec 0c             	sub    $0xc,%esp
80106a8c:	68 10 a7 10 80       	push   $0x8010a710
80106a91:	e8 fa 98 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80106a96:	83 ec 0c             	sub    $0xc,%esp
80106a99:	68 22 a7 10 80       	push   $0x8010a722
80106a9e:	e8 ed 98 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80106aa3:	83 ec 0c             	sub    $0xc,%esp
80106aa6:	68 fe a6 10 80       	push   $0x8010a6fe
80106aab:	e8 e0 98 ff ff       	call   80100390 <panic>

80106ab0 <sys_open>:

int
sys_open(void)
{
80106ab0:	f3 0f 1e fb          	endbr32 
80106ab4:	55                   	push   %ebp
80106ab5:	89 e5                	mov    %esp,%ebp
80106ab7:	57                   	push   %edi
80106ab8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106ab9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106abc:	53                   	push   %ebx
80106abd:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106ac0:	50                   	push   %eax
80106ac1:	6a 00                	push   $0x0
80106ac3:	e8 08 f8 ff ff       	call   801062d0 <argstr>
80106ac8:	83 c4 10             	add    $0x10,%esp
80106acb:	85 c0                	test   %eax,%eax
80106acd:	0f 88 8a 00 00 00    	js     80106b5d <sys_open+0xad>
80106ad3:	83 ec 08             	sub    $0x8,%esp
80106ad6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ad9:	50                   	push   %eax
80106ada:	6a 01                	push   $0x1
80106adc:	e8 3f f7 ff ff       	call   80106220 <argint>
80106ae1:	83 c4 10             	add    $0x10,%esp
80106ae4:	85 c0                	test   %eax,%eax
80106ae6:	78 75                	js     80106b5d <sys_open+0xad>
    return -1;

  begin_op();
80106ae8:	e8 b3 c7 ff ff       	call   801032a0 <begin_op>

  if(omode & O_CREATE){
80106aed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106af1:	75 75                	jne    80106b68 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106af3:	83 ec 0c             	sub    $0xc,%esp
80106af6:	ff 75 e0             	pushl  -0x20(%ebp)
80106af9:	e8 a2 ba ff ff       	call   801025a0 <namei>
80106afe:	83 c4 10             	add    $0x10,%esp
80106b01:	89 c6                	mov    %eax,%esi
80106b03:	85 c0                	test   %eax,%eax
80106b05:	74 7e                	je     80106b85 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106b07:	83 ec 0c             	sub    $0xc,%esp
80106b0a:	50                   	push   %eax
80106b0b:	e8 c0 b1 ff ff       	call   80101cd0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106b10:	83 c4 10             	add    $0x10,%esp
80106b13:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106b18:	0f 84 c2 00 00 00    	je     80106be0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106b1e:	e8 4d a8 ff ff       	call   80101370 <filealloc>
80106b23:	89 c7                	mov    %eax,%edi
80106b25:	85 c0                	test   %eax,%eax
80106b27:	74 23                	je     80106b4c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106b29:	e8 42 d4 ff ff       	call   80103f70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106b2e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106b30:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106b34:	85 d2                	test   %edx,%edx
80106b36:	74 60                	je     80106b98 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106b38:	83 c3 01             	add    $0x1,%ebx
80106b3b:	83 fb 10             	cmp    $0x10,%ebx
80106b3e:	75 f0                	jne    80106b30 <sys_open+0x80>
    if(f)
      fileclose(f);
80106b40:	83 ec 0c             	sub    $0xc,%esp
80106b43:	57                   	push   %edi
80106b44:	e8 e7 a8 ff ff       	call   80101430 <fileclose>
80106b49:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106b4c:	83 ec 0c             	sub    $0xc,%esp
80106b4f:	56                   	push   %esi
80106b50:	e8 1b b4 ff ff       	call   80101f70 <iunlockput>
    end_op();
80106b55:	e8 b6 c7 ff ff       	call   80103310 <end_op>
    return -1;
80106b5a:	83 c4 10             	add    $0x10,%esp
80106b5d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106b62:	eb 6d                	jmp    80106bd1 <sys_open+0x121>
80106b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106b68:	83 ec 0c             	sub    $0xc,%esp
80106b6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b6e:	31 c9                	xor    %ecx,%ecx
80106b70:	ba 02 00 00 00       	mov    $0x2,%edx
80106b75:	6a 00                	push   $0x0
80106b77:	e8 24 f8 ff ff       	call   801063a0 <create>
    if(ip == 0){
80106b7c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80106b7f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106b81:	85 c0                	test   %eax,%eax
80106b83:	75 99                	jne    80106b1e <sys_open+0x6e>
      end_op();
80106b85:	e8 86 c7 ff ff       	call   80103310 <end_op>
      return -1;
80106b8a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106b8f:	eb 40                	jmp    80106bd1 <sys_open+0x121>
80106b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106b98:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106b9b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80106b9f:	56                   	push   %esi
80106ba0:	e8 0b b2 ff ff       	call   80101db0 <iunlock>
  end_op();
80106ba5:	e8 66 c7 ff ff       	call   80103310 <end_op>

  f->type = FD_INODE;
80106baa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106bb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106bb3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106bb6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106bb9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106bbb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106bc2:	f7 d0                	not    %eax
80106bc4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106bc7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106bca:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106bcd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106bd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bd4:	89 d8                	mov    %ebx,%eax
80106bd6:	5b                   	pop    %ebx
80106bd7:	5e                   	pop    %esi
80106bd8:	5f                   	pop    %edi
80106bd9:	5d                   	pop    %ebp
80106bda:	c3                   	ret    
80106bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106bdf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80106be0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106be3:	85 c9                	test   %ecx,%ecx
80106be5:	0f 84 33 ff ff ff    	je     80106b1e <sys_open+0x6e>
80106beb:	e9 5c ff ff ff       	jmp    80106b4c <sys_open+0x9c>

80106bf0 <sys_mkdir>:

int
sys_mkdir(void)
{
80106bf0:	f3 0f 1e fb          	endbr32 
80106bf4:	55                   	push   %ebp
80106bf5:	89 e5                	mov    %esp,%ebp
80106bf7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106bfa:	e8 a1 c6 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106bff:	83 ec 08             	sub    $0x8,%esp
80106c02:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c05:	50                   	push   %eax
80106c06:	6a 00                	push   $0x0
80106c08:	e8 c3 f6 ff ff       	call   801062d0 <argstr>
80106c0d:	83 c4 10             	add    $0x10,%esp
80106c10:	85 c0                	test   %eax,%eax
80106c12:	78 34                	js     80106c48 <sys_mkdir+0x58>
80106c14:	83 ec 0c             	sub    $0xc,%esp
80106c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c1a:	31 c9                	xor    %ecx,%ecx
80106c1c:	ba 01 00 00 00       	mov    $0x1,%edx
80106c21:	6a 00                	push   $0x0
80106c23:	e8 78 f7 ff ff       	call   801063a0 <create>
80106c28:	83 c4 10             	add    $0x10,%esp
80106c2b:	85 c0                	test   %eax,%eax
80106c2d:	74 19                	je     80106c48 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106c2f:	83 ec 0c             	sub    $0xc,%esp
80106c32:	50                   	push   %eax
80106c33:	e8 38 b3 ff ff       	call   80101f70 <iunlockput>
  end_op();
80106c38:	e8 d3 c6 ff ff       	call   80103310 <end_op>
  return 0;
80106c3d:	83 c4 10             	add    $0x10,%esp
80106c40:	31 c0                	xor    %eax,%eax
}
80106c42:	c9                   	leave  
80106c43:	c3                   	ret    
80106c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106c48:	e8 c3 c6 ff ff       	call   80103310 <end_op>
    return -1;
80106c4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c52:	c9                   	leave  
80106c53:	c3                   	ret    
80106c54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c5f:	90                   	nop

80106c60 <sys_mknod>:

int
sys_mknod(void)
{
80106c60:	f3 0f 1e fb          	endbr32 
80106c64:	55                   	push   %ebp
80106c65:	89 e5                	mov    %esp,%ebp
80106c67:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106c6a:	e8 31 c6 ff ff       	call   801032a0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106c6f:	83 ec 08             	sub    $0x8,%esp
80106c72:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106c75:	50                   	push   %eax
80106c76:	6a 00                	push   $0x0
80106c78:	e8 53 f6 ff ff       	call   801062d0 <argstr>
80106c7d:	83 c4 10             	add    $0x10,%esp
80106c80:	85 c0                	test   %eax,%eax
80106c82:	78 64                	js     80106ce8 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80106c84:	83 ec 08             	sub    $0x8,%esp
80106c87:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106c8a:	50                   	push   %eax
80106c8b:	6a 01                	push   $0x1
80106c8d:	e8 8e f5 ff ff       	call   80106220 <argint>
  if((argstr(0, &path)) < 0 ||
80106c92:	83 c4 10             	add    $0x10,%esp
80106c95:	85 c0                	test   %eax,%eax
80106c97:	78 4f                	js     80106ce8 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80106c99:	83 ec 08             	sub    $0x8,%esp
80106c9c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c9f:	50                   	push   %eax
80106ca0:	6a 02                	push   $0x2
80106ca2:	e8 79 f5 ff ff       	call   80106220 <argint>
     argint(1, &major) < 0 ||
80106ca7:	83 c4 10             	add    $0x10,%esp
80106caa:	85 c0                	test   %eax,%eax
80106cac:	78 3a                	js     80106ce8 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106cae:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80106cb2:	83 ec 0c             	sub    $0xc,%esp
80106cb5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106cb9:	ba 03 00 00 00       	mov    $0x3,%edx
80106cbe:	50                   	push   %eax
80106cbf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106cc2:	e8 d9 f6 ff ff       	call   801063a0 <create>
     argint(2, &minor) < 0 ||
80106cc7:	83 c4 10             	add    $0x10,%esp
80106cca:	85 c0                	test   %eax,%eax
80106ccc:	74 1a                	je     80106ce8 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106cce:	83 ec 0c             	sub    $0xc,%esp
80106cd1:	50                   	push   %eax
80106cd2:	e8 99 b2 ff ff       	call   80101f70 <iunlockput>
  end_op();
80106cd7:	e8 34 c6 ff ff       	call   80103310 <end_op>
  return 0;
80106cdc:	83 c4 10             	add    $0x10,%esp
80106cdf:	31 c0                	xor    %eax,%eax
}
80106ce1:	c9                   	leave  
80106ce2:	c3                   	ret    
80106ce3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ce7:	90                   	nop
    end_op();
80106ce8:	e8 23 c6 ff ff       	call   80103310 <end_op>
    return -1;
80106ced:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cf2:	c9                   	leave  
80106cf3:	c3                   	ret    
80106cf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106cff:	90                   	nop

80106d00 <sys_chdir>:

int
sys_chdir(void)
{
80106d00:	f3 0f 1e fb          	endbr32 
80106d04:	55                   	push   %ebp
80106d05:	89 e5                	mov    %esp,%ebp
80106d07:	56                   	push   %esi
80106d08:	53                   	push   %ebx
80106d09:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106d0c:	e8 5f d2 ff ff       	call   80103f70 <myproc>
80106d11:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106d13:	e8 88 c5 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106d18:	83 ec 08             	sub    $0x8,%esp
80106d1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d1e:	50                   	push   %eax
80106d1f:	6a 00                	push   $0x0
80106d21:	e8 aa f5 ff ff       	call   801062d0 <argstr>
80106d26:	83 c4 10             	add    $0x10,%esp
80106d29:	85 c0                	test   %eax,%eax
80106d2b:	78 73                	js     80106da0 <sys_chdir+0xa0>
80106d2d:	83 ec 0c             	sub    $0xc,%esp
80106d30:	ff 75 f4             	pushl  -0xc(%ebp)
80106d33:	e8 68 b8 ff ff       	call   801025a0 <namei>
80106d38:	83 c4 10             	add    $0x10,%esp
80106d3b:	89 c3                	mov    %eax,%ebx
80106d3d:	85 c0                	test   %eax,%eax
80106d3f:	74 5f                	je     80106da0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80106d41:	83 ec 0c             	sub    $0xc,%esp
80106d44:	50                   	push   %eax
80106d45:	e8 86 af ff ff       	call   80101cd0 <ilock>
  if(ip->type != T_DIR){
80106d4a:	83 c4 10             	add    $0x10,%esp
80106d4d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106d52:	75 2c                	jne    80106d80 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106d54:	83 ec 0c             	sub    $0xc,%esp
80106d57:	53                   	push   %ebx
80106d58:	e8 53 b0 ff ff       	call   80101db0 <iunlock>
  iput(curproc->cwd);
80106d5d:	58                   	pop    %eax
80106d5e:	ff 76 68             	pushl  0x68(%esi)
80106d61:	e8 9a b0 ff ff       	call   80101e00 <iput>
  end_op();
80106d66:	e8 a5 c5 ff ff       	call   80103310 <end_op>
  curproc->cwd = ip;
80106d6b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80106d6e:	83 c4 10             	add    $0x10,%esp
80106d71:	31 c0                	xor    %eax,%eax
}
80106d73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d76:	5b                   	pop    %ebx
80106d77:	5e                   	pop    %esi
80106d78:	5d                   	pop    %ebp
80106d79:	c3                   	ret    
80106d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80106d80:	83 ec 0c             	sub    $0xc,%esp
80106d83:	53                   	push   %ebx
80106d84:	e8 e7 b1 ff ff       	call   80101f70 <iunlockput>
    end_op();
80106d89:	e8 82 c5 ff ff       	call   80103310 <end_op>
    return -1;
80106d8e:	83 c4 10             	add    $0x10,%esp
80106d91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d96:	eb db                	jmp    80106d73 <sys_chdir+0x73>
80106d98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d9f:	90                   	nop
    end_op();
80106da0:	e8 6b c5 ff ff       	call   80103310 <end_op>
    return -1;
80106da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106daa:	eb c7                	jmp    80106d73 <sys_chdir+0x73>
80106dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106db0 <sys_exec>:

int
sys_exec(void)
{
80106db0:	f3 0f 1e fb          	endbr32 
80106db4:	55                   	push   %ebp
80106db5:	89 e5                	mov    %esp,%ebp
80106db7:	57                   	push   %edi
80106db8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106db9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80106dbf:	53                   	push   %ebx
80106dc0:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106dc6:	50                   	push   %eax
80106dc7:	6a 00                	push   $0x0
80106dc9:	e8 02 f5 ff ff       	call   801062d0 <argstr>
80106dce:	83 c4 10             	add    $0x10,%esp
80106dd1:	85 c0                	test   %eax,%eax
80106dd3:	0f 88 8b 00 00 00    	js     80106e64 <sys_exec+0xb4>
80106dd9:	83 ec 08             	sub    $0x8,%esp
80106ddc:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106de2:	50                   	push   %eax
80106de3:	6a 01                	push   $0x1
80106de5:	e8 36 f4 ff ff       	call   80106220 <argint>
80106dea:	83 c4 10             	add    $0x10,%esp
80106ded:	85 c0                	test   %eax,%eax
80106def:	78 73                	js     80106e64 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106df1:	83 ec 04             	sub    $0x4,%esp
80106df4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106dfa:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106dfc:	68 80 00 00 00       	push   $0x80
80106e01:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106e07:	6a 00                	push   $0x0
80106e09:	50                   	push   %eax
80106e0a:	e8 a1 f0 ff ff       	call   80105eb0 <memset>
80106e0f:	83 c4 10             	add    $0x10,%esp
80106e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106e18:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106e1e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106e25:	83 ec 08             	sub    $0x8,%esp
80106e28:	57                   	push   %edi
80106e29:	01 f0                	add    %esi,%eax
80106e2b:	50                   	push   %eax
80106e2c:	e8 4f f3 ff ff       	call   80106180 <fetchint>
80106e31:	83 c4 10             	add    $0x10,%esp
80106e34:	85 c0                	test   %eax,%eax
80106e36:	78 2c                	js     80106e64 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80106e38:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106e3e:	85 c0                	test   %eax,%eax
80106e40:	74 36                	je     80106e78 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106e42:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106e48:	83 ec 08             	sub    $0x8,%esp
80106e4b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106e4e:	52                   	push   %edx
80106e4f:	50                   	push   %eax
80106e50:	e8 6b f3 ff ff       	call   801061c0 <fetchstr>
80106e55:	83 c4 10             	add    $0x10,%esp
80106e58:	85 c0                	test   %eax,%eax
80106e5a:	78 08                	js     80106e64 <sys_exec+0xb4>
  for(i=0;; i++){
80106e5c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106e5f:	83 fb 20             	cmp    $0x20,%ebx
80106e62:	75 b4                	jne    80106e18 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80106e64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80106e67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e6c:	5b                   	pop    %ebx
80106e6d:	5e                   	pop    %esi
80106e6e:	5f                   	pop    %edi
80106e6f:	5d                   	pop    %ebp
80106e70:	c3                   	ret    
80106e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106e78:	83 ec 08             	sub    $0x8,%esp
80106e7b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80106e81:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106e88:	00 00 00 00 
  return exec(path, argv);
80106e8c:	50                   	push   %eax
80106e8d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80106e93:	e8 d8 a0 ff ff       	call   80100f70 <exec>
80106e98:	83 c4 10             	add    $0x10,%esp
}
80106e9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e9e:	5b                   	pop    %ebx
80106e9f:	5e                   	pop    %esi
80106ea0:	5f                   	pop    %edi
80106ea1:	5d                   	pop    %ebp
80106ea2:	c3                   	ret    
80106ea3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106eb0 <sys_pipe>:

int
sys_pipe(void)
{
80106eb0:	f3 0f 1e fb          	endbr32 
80106eb4:	55                   	push   %ebp
80106eb5:	89 e5                	mov    %esp,%ebp
80106eb7:	57                   	push   %edi
80106eb8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106eb9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106ebc:	53                   	push   %ebx
80106ebd:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106ec0:	6a 08                	push   $0x8
80106ec2:	50                   	push   %eax
80106ec3:	6a 00                	push   $0x0
80106ec5:	e8 a6 f3 ff ff       	call   80106270 <argptr>
80106eca:	83 c4 10             	add    $0x10,%esp
80106ecd:	85 c0                	test   %eax,%eax
80106ecf:	78 4e                	js     80106f1f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106ed1:	83 ec 08             	sub    $0x8,%esp
80106ed4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ed7:	50                   	push   %eax
80106ed8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106edb:	50                   	push   %eax
80106edc:	e8 8f ca ff ff       	call   80103970 <pipealloc>
80106ee1:	83 c4 10             	add    $0x10,%esp
80106ee4:	85 c0                	test   %eax,%eax
80106ee6:	78 37                	js     80106f1f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106ee8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106eeb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106eed:	e8 7e d0 ff ff       	call   80103f70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106ef8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106efc:	85 f6                	test   %esi,%esi
80106efe:	74 30                	je     80106f30 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80106f00:	83 c3 01             	add    $0x1,%ebx
80106f03:	83 fb 10             	cmp    $0x10,%ebx
80106f06:	75 f0                	jne    80106ef8 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106f08:	83 ec 0c             	sub    $0xc,%esp
80106f0b:	ff 75 e0             	pushl  -0x20(%ebp)
80106f0e:	e8 1d a5 ff ff       	call   80101430 <fileclose>
    fileclose(wf);
80106f13:	58                   	pop    %eax
80106f14:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f17:	e8 14 a5 ff ff       	call   80101430 <fileclose>
    return -1;
80106f1c:	83 c4 10             	add    $0x10,%esp
80106f1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f24:	eb 5b                	jmp    80106f81 <sys_pipe+0xd1>
80106f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f2d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106f30:	8d 73 08             	lea    0x8(%ebx),%esi
80106f33:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106f37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106f3a:	e8 31 d0 ff ff       	call   80103f70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106f3f:	31 d2                	xor    %edx,%edx
80106f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106f48:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106f4c:	85 c9                	test   %ecx,%ecx
80106f4e:	74 20                	je     80106f70 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80106f50:	83 c2 01             	add    $0x1,%edx
80106f53:	83 fa 10             	cmp    $0x10,%edx
80106f56:	75 f0                	jne    80106f48 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80106f58:	e8 13 d0 ff ff       	call   80103f70 <myproc>
80106f5d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106f64:	00 
80106f65:	eb a1                	jmp    80106f08 <sys_pipe+0x58>
80106f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f6e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106f70:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106f74:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106f77:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106f79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106f7c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106f7f:	31 c0                	xor    %eax,%eax
}
80106f81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f84:	5b                   	pop    %ebx
80106f85:	5e                   	pop    %esi
80106f86:	5f                   	pop    %edi
80106f87:	5d                   	pop    %ebp
80106f88:	c3                   	ret    
80106f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f90 <sys_copy_file>:

int 
sys_copy_file(void) {
80106f90:	f3 0f 1e fb          	endbr32 
80106f94:	55                   	push   %ebp
80106f95:	89 e5                	mov    %esp,%ebp
80106f97:	57                   	push   %edi
80106f98:	56                   	push   %esi
  struct inode* ip_dst;
  struct inode* ip_src;
  int bytesRead;
  char buf[1024];

  if (argstr(0, &src_path) < 0 || argstr(1, &dst_path) < 0)
80106f99:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
sys_copy_file(void) {
80106f9f:	53                   	push   %ebx
80106fa0:	81 ec 34 04 00 00    	sub    $0x434,%esp
  if (argstr(0, &src_path) < 0 || argstr(1, &dst_path) < 0)
80106fa6:	50                   	push   %eax
80106fa7:	6a 00                	push   $0x0
80106fa9:	e8 22 f3 ff ff       	call   801062d0 <argstr>
80106fae:	83 c4 10             	add    $0x10,%esp
80106fb1:	85 c0                	test   %eax,%eax
80106fb3:	0f 88 fa 00 00 00    	js     801070b3 <sys_copy_file+0x123>
80106fb9:	83 ec 08             	sub    $0x8,%esp
80106fbc:	8d 85 e4 fb ff ff    	lea    -0x41c(%ebp),%eax
80106fc2:	50                   	push   %eax
80106fc3:	6a 01                	push   $0x1
80106fc5:	e8 06 f3 ff ff       	call   801062d0 <argstr>
80106fca:	83 c4 10             	add    $0x10,%esp
80106fcd:	85 c0                	test   %eax,%eax
80106fcf:	0f 88 de 00 00 00    	js     801070b3 <sys_copy_file+0x123>
    return -1;
  begin_op();
80106fd5:	e8 c6 c2 ff ff       	call   801032a0 <begin_op>

  if ((ip_src = namei(src_path)) == 0) { // Check if source file exists
80106fda:	83 ec 0c             	sub    $0xc,%esp
80106fdd:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
80106fe3:	e8 b8 b5 ff ff       	call   801025a0 <namei>
80106fe8:	83 c4 10             	add    $0x10,%esp
80106feb:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
80106ff1:	85 c0                	test   %eax,%eax
80106ff3:	0f 84 b5 00 00 00    	je     801070ae <sys_copy_file+0x11e>
    end_op();
    return -1;
  }
 
  ip_dst = namei(dst_path);
80106ff9:	83 ec 0c             	sub    $0xc,%esp
80106ffc:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
80107002:	e8 99 b5 ff ff       	call   801025a0 <namei>
  if (ip_dst > 0) { // Check if destination file already exists
80107007:	83 c4 10             	add    $0x10,%esp
8010700a:	85 c0                	test   %eax,%eax
8010700c:	0f 85 9c 00 00 00    	jne    801070ae <sys_copy_file+0x11e>
    end_op();
    return -1;
  }
  ip_dst = create(dst_path, T_FILE, 0, 0);
80107012:	83 ec 0c             	sub    $0xc,%esp
80107015:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
8010701b:	31 c9                	xor    %ecx,%ecx
8010701d:	ba 02 00 00 00       	mov    $0x2,%edx
80107022:	6a 00                	push   $0x0

  int bytesWrote = 0;
  int readOffset = 0;
  int writeOffset = 0;
80107024:	31 f6                	xor    %esi,%esi
  int readOffset = 0;
80107026:	31 db                	xor    %ebx,%ebx
80107028:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
  ip_dst = create(dst_path, T_FILE, 0, 0);
8010702e:	e8 6d f3 ff ff       	call   801063a0 <create>
  ilock(ip_src);
80107033:	5a                   	pop    %edx
80107034:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
  ip_dst = create(dst_path, T_FILE, 0, 0);
8010703a:	89 85 d0 fb ff ff    	mov    %eax,-0x430(%ebp)
  ilock(ip_src);
80107040:	e8 8b ac ff ff       	call   80101cd0 <ilock>
  while ((bytesRead = readi(ip_src, buf, readOffset, sizeof(buf))) > 0) {
80107045:	83 c4 10             	add    $0x10,%esp
80107048:	eb 1f                	jmp    80107069 <sys_copy_file+0xd9>
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    readOffset += bytesRead;
    if ((bytesWrote = writei(ip_dst , buf,writeOffset,  bytesRead)) <= 0)
80107050:	50                   	push   %eax
    readOffset += bytesRead;
80107051:	01 c3                	add    %eax,%ebx
    if ((bytesWrote = writei(ip_dst , buf,writeOffset,  bytesRead)) <= 0)
80107053:	56                   	push   %esi
80107054:	57                   	push   %edi
80107055:	ff b5 d0 fb ff ff    	pushl  -0x430(%ebp)
8010705b:	e8 70 b0 ff ff       	call   801020d0 <writei>
80107060:	83 c4 10             	add    $0x10,%esp
80107063:	85 c0                	test   %eax,%eax
80107065:	7e 4c                	jle    801070b3 <sys_copy_file+0x123>
      return -1;
    writeOffset += bytesWrote;
80107067:	01 c6                	add    %eax,%esi
  while ((bytesRead = readi(ip_src, buf, readOffset, sizeof(buf))) > 0) {
80107069:	68 00 04 00 00       	push   $0x400
8010706e:	53                   	push   %ebx
8010706f:	57                   	push   %edi
80107070:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
80107076:	e8 55 af ff ff       	call   80101fd0 <readi>
8010707b:	83 c4 10             	add    $0x10,%esp
8010707e:	85 c0                	test   %eax,%eax
80107080:	7f ce                	jg     80107050 <sys_copy_file+0xc0>
   
}

  iunlock(ip_src);
80107082:	83 ec 0c             	sub    $0xc,%esp
80107085:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
8010708b:	e8 20 ad ff ff       	call   80101db0 <iunlock>
  iunlock(ip_dst);
80107090:	58                   	pop    %eax
80107091:	ff b5 d0 fb ff ff    	pushl  -0x430(%ebp)
80107097:	e8 14 ad ff ff       	call   80101db0 <iunlock>
  end_op();
8010709c:	e8 6f c2 ff ff       	call   80103310 <end_op>

  return 0;
801070a1:	83 c4 10             	add    $0x10,%esp
}
801070a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801070a7:	31 c0                	xor    %eax,%eax
}
801070a9:	5b                   	pop    %ebx
801070aa:	5e                   	pop    %esi
801070ab:	5f                   	pop    %edi
801070ac:	5d                   	pop    %ebp
801070ad:	c3                   	ret    
    end_op();
801070ae:	e8 5d c2 ff ff       	call   80103310 <end_op>
}
801070b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801070b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070bb:	5b                   	pop    %ebx
801070bc:	5e                   	pop    %esi
801070bd:	5f                   	pop    %edi
801070be:	5d                   	pop    %ebp
801070bf:	c3                   	ret    

801070c0 <sys_get_process_lifetime>:
    return -1;
  //cprintf("sysproc.h %d", pid);
  return get_process_lifetime(pid);
}*/

int sys_get_process_lifetime(void){
801070c0:	f3 0f 1e fb          	endbr32 
  return get_process_lifetime();
801070c4:	e9 97 d9 ff ff       	jmp    80104a60 <get_process_lifetime>
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070d0 <sys_get_uncle_count>:
}

int sys_get_uncle_count(void){
801070d0:	f3 0f 1e fb          	endbr32 
801070d4:	55                   	push   %ebp
801070d5:	89 e5                	mov    %esp,%ebp
801070d7:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid) < 0){
801070da:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070dd:	50                   	push   %eax
801070de:	6a 00                	push   $0x0
801070e0:	e8 3b f1 ff ff       	call   80106220 <argint>
801070e5:	83 c4 10             	add    $0x10,%esp
801070e8:	85 c0                	test   %eax,%eax
801070ea:	78 14                	js     80107100 <sys_get_uncle_count+0x30>
    return -1;
  }
  return get_uncle_count(pid);
801070ec:	83 ec 0c             	sub    $0xc,%esp
801070ef:	ff 75 f4             	pushl  -0xc(%ebp)
801070f2:	e8 49 d7 ff ff       	call   80104840 <get_uncle_count>
801070f7:	83 c4 10             	add    $0x10,%esp
}
801070fa:	c9                   	leave  
801070fb:	c3                   	ret    
801070fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107100:	c9                   	leave  
    return -1;
80107101:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107106:	c3                   	ret    
80107107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010710e:	66 90                	xchg   %ax,%ax

80107110 <sys_fork>:

int
sys_fork(void)
{
80107110:	f3 0f 1e fb          	endbr32 
  return fork();
80107114:	e9 17 db ff ff       	jmp    80104c30 <fork>
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107120 <sys_exit>:
}

int
sys_exit(void)
{
80107120:	f3 0f 1e fb          	endbr32 
80107124:	55                   	push   %ebp
80107125:	89 e5                	mov    %esp,%ebp
80107127:	83 ec 08             	sub    $0x8,%esp
  exit();
8010712a:	e8 91 d2 ff ff       	call   801043c0 <exit>
  return 0;  // not reached
}
8010712f:	31 c0                	xor    %eax,%eax
80107131:	c9                   	leave  
80107132:	c3                   	ret    
80107133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010713a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107140 <sys_wait>:

int
sys_wait(void)
{
80107140:	f3 0f 1e fb          	endbr32 
  return wait();
80107144:	e9 f7 d4 ff ff       	jmp    80104640 <wait>
80107149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107150 <sys_kill>:
}

int
sys_kill(void)
{
80107150:	f3 0f 1e fb          	endbr32 
80107154:	55                   	push   %ebp
80107155:	89 e5                	mov    %esp,%ebp
80107157:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010715a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010715d:	50                   	push   %eax
8010715e:	6a 00                	push   $0x0
80107160:	e8 bb f0 ff ff       	call   80106220 <argint>
80107165:	83 c4 10             	add    $0x10,%esp
80107168:	85 c0                	test   %eax,%eax
8010716a:	78 14                	js     80107180 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010716c:	83 ec 0c             	sub    $0xc,%esp
8010716f:	ff 75 f4             	pushl  -0xc(%ebp)
80107172:	e8 39 d6 ff ff       	call   801047b0 <kill>
80107177:	83 c4 10             	add    $0x10,%esp
}
8010717a:	c9                   	leave  
8010717b:	c3                   	ret    
8010717c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107180:	c9                   	leave  
    return -1;
80107181:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107186:	c3                   	ret    
80107187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010718e:	66 90                	xchg   %ax,%ax

80107190 <sys_getpid>:

int
sys_getpid(void)
{
80107190:	f3 0f 1e fb          	endbr32 
80107194:	55                   	push   %ebp
80107195:	89 e5                	mov    %esp,%ebp
80107197:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010719a:	e8 d1 cd ff ff       	call   80103f70 <myproc>
8010719f:	8b 40 10             	mov    0x10(%eax),%eax
}
801071a2:	c9                   	leave  
801071a3:	c3                   	ret    
801071a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071af:	90                   	nop

801071b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801071b0:	f3 0f 1e fb          	endbr32 
801071b4:	55                   	push   %ebp
801071b5:	89 e5                	mov    %esp,%ebp
801071b7:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801071b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801071bb:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801071be:	50                   	push   %eax
801071bf:	6a 00                	push   $0x0
801071c1:	e8 5a f0 ff ff       	call   80106220 <argint>
801071c6:	83 c4 10             	add    $0x10,%esp
801071c9:	85 c0                	test   %eax,%eax
801071cb:	78 23                	js     801071f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801071cd:	e8 9e cd ff ff       	call   80103f70 <myproc>
  if(growproc(n) < 0)
801071d2:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801071d5:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801071d7:	ff 75 f4             	pushl  -0xc(%ebp)
801071da:	e8 c1 cd ff ff       	call   80103fa0 <growproc>
801071df:	83 c4 10             	add    $0x10,%esp
801071e2:	85 c0                	test   %eax,%eax
801071e4:	78 0a                	js     801071f0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801071e6:	89 d8                	mov    %ebx,%eax
801071e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801071eb:	c9                   	leave  
801071ec:	c3                   	ret    
801071ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801071f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801071f5:	eb ef                	jmp    801071e6 <sys_sbrk+0x36>
801071f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071fe:	66 90                	xchg   %ax,%ax

80107200 <sys_sleep>:

int
sys_sleep(void)
{
80107200:	f3 0f 1e fb          	endbr32 
80107204:	55                   	push   %ebp
80107205:	89 e5                	mov    %esp,%ebp
80107207:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80107208:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010720b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010720e:	50                   	push   %eax
8010720f:	6a 00                	push   $0x0
80107211:	e8 0a f0 ff ff       	call   80106220 <argint>
80107216:	83 c4 10             	add    $0x10,%esp
80107219:	85 c0                	test   %eax,%eax
8010721b:	0f 88 86 00 00 00    	js     801072a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80107221:	83 ec 0c             	sub    $0xc,%esp
80107224:	68 a0 ce 12 80       	push   $0x8012cea0
80107229:	e8 72 eb ff ff       	call   80105da0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010722e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80107231:	8b 1d e0 d6 12 80    	mov    0x8012d6e0,%ebx
  while(ticks - ticks0 < n){
80107237:	83 c4 10             	add    $0x10,%esp
8010723a:	85 d2                	test   %edx,%edx
8010723c:	75 23                	jne    80107261 <sys_sleep+0x61>
8010723e:	eb 50                	jmp    80107290 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80107240:	83 ec 08             	sub    $0x8,%esp
80107243:	68 a0 ce 12 80       	push   $0x8012cea0
80107248:	68 e0 d6 12 80       	push   $0x8012d6e0
8010724d:	e8 2e d3 ff ff       	call   80104580 <sleep>
  while(ticks - ticks0 < n){
80107252:	a1 e0 d6 12 80       	mov    0x8012d6e0,%eax
80107257:	83 c4 10             	add    $0x10,%esp
8010725a:	29 d8                	sub    %ebx,%eax
8010725c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010725f:	73 2f                	jae    80107290 <sys_sleep+0x90>
    if(myproc()->killed){
80107261:	e8 0a cd ff ff       	call   80103f70 <myproc>
80107266:	8b 40 24             	mov    0x24(%eax),%eax
80107269:	85 c0                	test   %eax,%eax
8010726b:	74 d3                	je     80107240 <sys_sleep+0x40>
      release(&tickslock);
8010726d:	83 ec 0c             	sub    $0xc,%esp
80107270:	68 a0 ce 12 80       	push   $0x8012cea0
80107275:	e8 e6 eb ff ff       	call   80105e60 <release>
  }
  release(&tickslock);
  return 0;
}
8010727a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010727d:	83 c4 10             	add    $0x10,%esp
80107280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107285:	c9                   	leave  
80107286:	c3                   	ret    
80107287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010728e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80107290:	83 ec 0c             	sub    $0xc,%esp
80107293:	68 a0 ce 12 80       	push   $0x8012cea0
80107298:	e8 c3 eb ff ff       	call   80105e60 <release>
  return 0;
8010729d:	83 c4 10             	add    $0x10,%esp
801072a0:	31 c0                	xor    %eax,%eax
}
801072a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801072a5:	c9                   	leave  
801072a6:	c3                   	ret    
    return -1;
801072a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072ac:	eb f4                	jmp    801072a2 <sys_sleep+0xa2>
801072ae:	66 90                	xchg   %ax,%ax

801072b0 <sys_change_sched_Q>:
int
sys_change_sched_Q(void)
{
801072b0:	f3 0f 1e fb          	endbr32 
801072b4:	55                   	push   %ebp
801072b5:	89 e5                	mov    %esp,%ebp
801072b7:	83 ec 20             	sub    $0x20,%esp
  int queue_number, pid;
  if(argint(0, &pid) < 0 || argint(1, &queue_number) < 0)
801072ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
801072bd:	50                   	push   %eax
801072be:	6a 00                	push   $0x0
801072c0:	e8 5b ef ff ff       	call   80106220 <argint>
801072c5:	83 c4 10             	add    $0x10,%esp
801072c8:	85 c0                	test   %eax,%eax
801072ca:	78 34                	js     80107300 <sys_change_sched_Q+0x50>
801072cc:	83 ec 08             	sub    $0x8,%esp
801072cf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801072d2:	50                   	push   %eax
801072d3:	6a 01                	push   $0x1
801072d5:	e8 46 ef ff ff       	call   80106220 <argint>
801072da:	83 c4 10             	add    $0x10,%esp
801072dd:	85 c0                	test   %eax,%eax
801072df:	78 1f                	js     80107300 <sys_change_sched_Q+0x50>
    return -1;

  if(queue_number < ROUND_ROBIN || queue_number > BJF)
801072e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801072e4:	8d 50 ff             	lea    -0x1(%eax),%edx
801072e7:	83 fa 02             	cmp    $0x2,%edx
801072ea:	77 14                	ja     80107300 <sys_change_sched_Q+0x50>
    return -1;

  return change_Q(pid, queue_number);
801072ec:	83 ec 08             	sub    $0x8,%esp
801072ef:	50                   	push   %eax
801072f0:	ff 75 f4             	pushl  -0xc(%ebp)
801072f3:	e8 98 d7 ff ff       	call   80104a90 <change_Q>
801072f8:	83 c4 10             	add    $0x10,%esp
}
801072fb:	c9                   	leave  
801072fc:	c3                   	ret    
801072fd:	8d 76 00             	lea    0x0(%esi),%esi
80107300:	c9                   	leave  
    return -1;
80107301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107306:	c3                   	ret    
80107307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010730e:	66 90                	xchg   %ax,%ax

80107310 <sys_show_process_info>:

void sys_show_process_info(void) {
80107310:	f3 0f 1e fb          	endbr32 
  show_process_info();
80107314:	e9 17 dd ff ff       	jmp    80105030 <show_process_info>
80107319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107320 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80107320:	f3 0f 1e fb          	endbr32 
80107324:	55                   	push   %ebp
80107325:	89 e5                	mov    %esp,%ebp
80107327:	53                   	push   %ebx
80107328:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010732b:	68 a0 ce 12 80       	push   $0x8012cea0
80107330:	e8 6b ea ff ff       	call   80105da0 <acquire>
  xticks = ticks;
80107335:	8b 1d e0 d6 12 80    	mov    0x8012d6e0,%ebx
  release(&tickslock);
8010733b:	c7 04 24 a0 ce 12 80 	movl   $0x8012cea0,(%esp)
80107342:	e8 19 eb ff ff       	call   80105e60 <release>
  return xticks;
}
80107347:	89 d8                	mov    %ebx,%eax
80107349:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010734c:	c9                   	leave  
8010734d:	c3                   	ret    
8010734e:	66 90                	xchg   %ax,%ax

80107350 <sys_find_digital_root>:

int
sys_find_digital_root(void)
{
80107350:	f3 0f 1e fb          	endbr32 
80107354:	55                   	push   %ebp
80107355:	89 e5                	mov    %esp,%ebp
80107357:	53                   	push   %ebx
80107358:	83 ec 04             	sub    $0x4,%esp
  int n = myproc()->tf->ebx;
8010735b:	e8 10 cc ff ff       	call   80103f70 <myproc>
  cprintf("KERNEL: sys_find_digital_root(%d)\n", n);
80107360:	83 ec 08             	sub    $0x8,%esp
  int n = myproc()->tf->ebx;
80107363:	8b 40 18             	mov    0x18(%eax),%eax
80107366:	8b 58 10             	mov    0x10(%eax),%ebx
  cprintf("KERNEL: sys_find_digital_root(%d)\n", n);
80107369:	53                   	push   %ebx
8010736a:	68 34 a7 10 80       	push   $0x8010a734
8010736f:	e8 4c 95 ff ff       	call   801008c0 <cprintf>
  return find_digital_root(n);
80107374:	89 1c 24             	mov    %ebx,(%esp)
80107377:	e8 84 d6 ff ff       	call   80104a00 <find_digital_root>

}
8010737c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010737f:	c9                   	leave  
80107380:	c3                   	ret    
80107381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010738f:	90                   	nop

80107390 <sys_priorityLock_test>:


void
sys_priorityLock_test(void){
80107390:	f3 0f 1e fb          	endbr32 
  priorityLock_test();
80107394:	e9 27 e5 ff ff       	jmp    801058c0 <priorityLock_test>
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073a0 <sys_set_proc_bjf_params>:
//   return 0;
// }

int
sys_set_proc_bjf_params(void)
{
801073a0:	f3 0f 1e fb          	endbr32 
801073a4:	55                   	push   %ebp
801073a5:	89 e5                	mov    %esp,%ebp
801073a7:	83 ec 30             	sub    $0x30,%esp
  int pid;
  float priority_ratio, arrival_time_ratio, executed_cycle_ratio, process_size_ratio;
  if(argint(0, &pid) < 0 ||
801073aa:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801073ad:	50                   	push   %eax
801073ae:	6a 00                	push   $0x0
801073b0:	e8 6b ee ff ff       	call   80106220 <argint>
801073b5:	83 c4 10             	add    $0x10,%esp
801073b8:	85 c0                	test   %eax,%eax
801073ba:	78 74                	js     80107430 <sys_set_proc_bjf_params+0x90>
     argfloat(1, &priority_ratio) < 0 ||
801073bc:	83 ec 08             	sub    $0x8,%esp
801073bf:	8d 45 e8             	lea    -0x18(%ebp),%eax
801073c2:	50                   	push   %eax
801073c3:	6a 01                	push   $0x1
801073c5:	e8 66 ed ff ff       	call   80106130 <argfloat>
  if(argint(0, &pid) < 0 ||
801073ca:	83 c4 10             	add    $0x10,%esp
801073cd:	85 c0                	test   %eax,%eax
801073cf:	78 5f                	js     80107430 <sys_set_proc_bjf_params+0x90>
     argfloat(2, &arrival_time_ratio) < 0 ||
801073d1:	83 ec 08             	sub    $0x8,%esp
801073d4:	8d 45 ec             	lea    -0x14(%ebp),%eax
801073d7:	50                   	push   %eax
801073d8:	6a 02                	push   $0x2
801073da:	e8 51 ed ff ff       	call   80106130 <argfloat>
     argfloat(1, &priority_ratio) < 0 ||
801073df:	83 c4 10             	add    $0x10,%esp
801073e2:	85 c0                	test   %eax,%eax
801073e4:	78 4a                	js     80107430 <sys_set_proc_bjf_params+0x90>
     argfloat(3, &executed_cycle_ratio) < 0||
801073e6:	83 ec 08             	sub    $0x8,%esp
801073e9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801073ec:	50                   	push   %eax
801073ed:	6a 03                	push   $0x3
801073ef:	e8 3c ed ff ff       	call   80106130 <argfloat>
     argfloat(2, &arrival_time_ratio) < 0 ||
801073f4:	83 c4 10             	add    $0x10,%esp
801073f7:	85 c0                	test   %eax,%eax
801073f9:	78 35                	js     80107430 <sys_set_proc_bjf_params+0x90>
     argfloat(4, &process_size_ratio)<0 ){
801073fb:	83 ec 08             	sub    $0x8,%esp
801073fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107401:	50                   	push   %eax
80107402:	6a 04                	push   $0x4
80107404:	e8 27 ed ff ff       	call   80106130 <argfloat>
     argfloat(3, &executed_cycle_ratio) < 0||
80107409:	83 c4 10             	add    $0x10,%esp
8010740c:	85 c0                	test   %eax,%eax
8010740e:	78 20                	js     80107430 <sys_set_proc_bjf_params+0x90>
    return -1;
  }

  return set_proc_bjf_params(pid, priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio);
80107410:	83 ec 0c             	sub    $0xc,%esp
80107413:	ff 75 f4             	pushl  -0xc(%ebp)
80107416:	ff 75 f0             	pushl  -0x10(%ebp)
80107419:	ff 75 ec             	pushl  -0x14(%ebp)
8010741c:	ff 75 e8             	pushl  -0x18(%ebp)
8010741f:	ff 75 e4             	pushl  -0x1c(%ebp)
80107422:	e8 e9 da ff ff       	call   80104f10 <set_proc_bjf_params>
80107427:	83 c4 20             	add    $0x20,%esp
}
8010742a:	c9                   	leave  
8010742b:	c3                   	ret    
8010742c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107430:	c9                   	leave  
    return -1;
80107431:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107436:	c3                   	ret    
80107437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010743e:	66 90                	xchg   %ax,%ax

80107440 <sys_set_system_bjf_params>:

int
sys_set_system_bjf_params(void)
{
80107440:	f3 0f 1e fb          	endbr32 
80107444:	55                   	push   %ebp
80107445:	89 e5                	mov    %esp,%ebp
80107447:	83 ec 20             	sub    $0x20,%esp
  float priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio;
  if(argfloat(0, &priority_ratio) < 0 ||
8010744a:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010744d:	50                   	push   %eax
8010744e:	6a 00                	push   $0x0
80107450:	e8 db ec ff ff       	call   80106130 <argfloat>
80107455:	83 c4 10             	add    $0x10,%esp
80107458:	85 c0                	test   %eax,%eax
8010745a:	78 5c                	js     801074b8 <sys_set_system_bjf_params+0x78>
     argfloat(1, &arrival_time_ratio) < 0 ||
8010745c:	83 ec 08             	sub    $0x8,%esp
8010745f:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107462:	50                   	push   %eax
80107463:	6a 01                	push   $0x1
80107465:	e8 c6 ec ff ff       	call   80106130 <argfloat>
  if(argfloat(0, &priority_ratio) < 0 ||
8010746a:	83 c4 10             	add    $0x10,%esp
8010746d:	85 c0                	test   %eax,%eax
8010746f:	78 47                	js     801074b8 <sys_set_system_bjf_params+0x78>
     argfloat(2, &executed_cycle_ratio) < 0||
80107471:	83 ec 08             	sub    $0x8,%esp
80107474:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107477:	50                   	push   %eax
80107478:	6a 02                	push   $0x2
8010747a:	e8 b1 ec ff ff       	call   80106130 <argfloat>
     argfloat(1, &arrival_time_ratio) < 0 ||
8010747f:	83 c4 10             	add    $0x10,%esp
80107482:	85 c0                	test   %eax,%eax
80107484:	78 32                	js     801074b8 <sys_set_system_bjf_params+0x78>
     argfloat(3,&process_size_ratio)<0){
80107486:	83 ec 08             	sub    $0x8,%esp
80107489:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010748c:	50                   	push   %eax
8010748d:	6a 03                	push   $0x3
8010748f:	e8 9c ec ff ff       	call   80106130 <argfloat>
     argfloat(2, &executed_cycle_ratio) < 0||
80107494:	83 c4 10             	add    $0x10,%esp
80107497:	85 c0                	test   %eax,%eax
80107499:	78 1d                	js     801074b8 <sys_set_system_bjf_params+0x78>
    return -1;
  }

  set_system_bjf_params(priority_ratio, arrival_time_ratio, executed_cycle_ratio,process_size_ratio);
8010749b:	ff 75 f4             	pushl  -0xc(%ebp)
8010749e:	ff 75 f0             	pushl  -0x10(%ebp)
801074a1:	ff 75 ec             	pushl  -0x14(%ebp)
801074a4:	ff 75 e8             	pushl  -0x18(%ebp)
801074a7:	e8 04 db ff ff       	call   80104fb0 <set_system_bjf_params>
  return 0;
801074ac:	83 c4 10             	add    $0x10,%esp
801074af:	31 c0                	xor    %eax,%eax
}
801074b1:	c9                   	leave  
801074b2:	c3                   	ret    
801074b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074b7:	90                   	nop
801074b8:	c9                   	leave  
    return -1;
801074b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074be:	c3                   	ret    
801074bf:	90                   	nop

801074c0 <sys_init_queue_test>:

int sys_init_queue_test(void) {
801074c0:	f3 0f 1e fb          	endbr32 
801074c4:	55                   	push   %ebp
801074c5:	89 e5                	mov    %esp,%ebp
801074c7:	83 ec 08             	sub    $0x8,%esp
  init_queue_test();
801074ca:	e8 d1 e4 ff ff       	call   801059a0 <init_queue_test>
  return 0;
}
801074cf:	31 c0                	xor    %eax,%eax
801074d1:	c9                   	leave  
801074d2:	c3                   	ret    
801074d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074e0 <sys_syscalls_count>:

int sys_syscalls_count(void) {
801074e0:	f3 0f 1e fb          	endbr32 
801074e4:	55                   	push   %ebp
801074e5:	89 e5                	mov    %esp,%ebp
801074e7:	57                   	push   %edi
801074e8:	56                   	push   %esi
801074e9:	53                   	push   %ebx
801074ea:	83 ec 0c             	sub    $0xc,%esp
  int total_syscalls_count = 0;
  for(int i = 0 ; i < ncpu ; ++i) {
801074ed:	8b 0d 40 63 11 80    	mov    0x80116340,%ecx
801074f3:	85 c9                	test   %ecx,%ecx
801074f5:	7e 61                	jle    80107558 <sys_syscalls_count+0x78>
801074f7:	be 50 5e 11 80       	mov    $0x80115e50,%esi
801074fc:	31 db                	xor    %ebx,%ebx
  int total_syscalls_count = 0;
801074fe:	31 ff                	xor    %edi,%edi
    int syscalls_count = 0;
    syscalls_count += cpus[i].syscalls_count;
80107500:	8b 06                	mov    (%esi),%eax
    total_syscalls_count += syscalls_count;
    cprintf("cpus[%d].syscalls_count = %d\n", i, syscalls_count);
80107502:	83 ec 04             	sub    $0x4,%esp
80107505:	81 c6 b4 00 00 00    	add    $0xb4,%esi
8010750b:	50                   	push   %eax
    total_syscalls_count += syscalls_count;
8010750c:	01 c7                	add    %eax,%edi
    cprintf("cpus[%d].syscalls_count = %d\n", i, syscalls_count);
8010750e:	53                   	push   %ebx
  for(int i = 0 ; i < ncpu ; ++i) {
8010750f:	83 c3 01             	add    $0x1,%ebx
    cprintf("cpus[%d].syscalls_count = %d\n", i, syscalls_count);
80107512:	68 57 a7 10 80       	push   $0x8010a757
80107517:	e8 a4 93 ff ff       	call   801008c0 <cprintf>
  for(int i = 0 ; i < ncpu ; ++i) {
8010751c:	83 c4 10             	add    $0x10,%esp
8010751f:	39 1d 40 63 11 80    	cmp    %ebx,0x80116340
80107525:	7f d9                	jg     80107500 <sys_syscalls_count+0x20>
  }
  cprintf("total_syscalls_count = %d\n", total_syscalls_count);
80107527:	83 ec 08             	sub    $0x8,%esp
8010752a:	57                   	push   %edi
8010752b:	68 75 a7 10 80       	push   $0x8010a775
80107530:	e8 8b 93 ff ff       	call   801008c0 <cprintf>
  cprintf("Shared syscalls count = %d\n", count_shared_syscalls);
80107535:	58                   	pop    %eax
80107536:	5a                   	pop    %edx
80107537:	ff 35 c0 d5 10 80    	pushl  0x8010d5c0
8010753d:	68 90 a7 10 80       	push   $0x8010a790
80107542:	e8 79 93 ff ff       	call   801008c0 <cprintf>
  return total_syscalls_count;
}
80107547:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010754a:	89 f8                	mov    %edi,%eax
8010754c:	5b                   	pop    %ebx
8010754d:	5e                   	pop    %esi
8010754e:	5f                   	pop    %edi
8010754f:	5d                   	pop    %ebp
80107550:	c3                   	ret    
80107551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int total_syscalls_count = 0;
80107558:	31 ff                	xor    %edi,%edi
8010755a:	eb cb                	jmp    80107527 <sys_syscalls_count+0x47>
8010755c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107560 <sys_shmget>:
extern int shmctl(int, int, void*);

// system call handler for shmget
int
sys_shmget(void)
{
80107560:	f3 0f 1e fb          	endbr32 
80107564:	55                   	push   %ebp
80107565:	89 e5                	mov    %esp,%ebp
80107567:	83 ec 20             	sub    $0x20,%esp
  int key, size, shmflag;
  // check for valid arguments
  if(argint(0, &key) < 0)
8010756a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010756d:	50                   	push   %eax
8010756e:	6a 00                	push   $0x0
80107570:	e8 ab ec ff ff       	call   80106220 <argint>
80107575:	83 c4 10             	add    $0x10,%esp
80107578:	85 c0                	test   %eax,%eax
8010757a:	78 44                	js     801075c0 <sys_shmget+0x60>
    return -1;
  if(argint(1, &size) < 0)
8010757c:	83 ec 08             	sub    $0x8,%esp
8010757f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107582:	50                   	push   %eax
80107583:	6a 01                	push   $0x1
80107585:	e8 96 ec ff ff       	call   80106220 <argint>
8010758a:	83 c4 10             	add    $0x10,%esp
8010758d:	85 c0                	test   %eax,%eax
8010758f:	78 2f                	js     801075c0 <sys_shmget+0x60>
    return -1;
  if(argint(2, &shmflag) < 0)
80107591:	83 ec 08             	sub    $0x8,%esp
80107594:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107597:	50                   	push   %eax
80107598:	6a 02                	push   $0x2
8010759a:	e8 81 ec ff ff       	call   80106220 <argint>
8010759f:	83 c4 10             	add    $0x10,%esp
801075a2:	85 c0                	test   %eax,%eax
801075a4:	78 1a                	js     801075c0 <sys_shmget+0x60>
    return -1;
  return shmget((uint)key, (uint)size, shmflag);
801075a6:	83 ec 04             	sub    $0x4,%esp
801075a9:	ff 75 f4             	pushl  -0xc(%ebp)
801075ac:	ff 75 f0             	pushl  -0x10(%ebp)
801075af:	ff 75 ec             	pushl  -0x14(%ebp)
801075b2:	e8 59 1a 00 00       	call   80109010 <shmget>
801075b7:	83 c4 10             	add    $0x10,%esp
}
801075ba:	c9                   	leave  
801075bb:	c3                   	ret    
801075bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075c0:	c9                   	leave  
    return -1;
801075c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075c6:	c3                   	ret    
801075c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075ce:	66 90                	xchg   %ax,%ax

801075d0 <sys_shmdt>:

// system call handler for shmdt
int sys_shmdt(void)
{
801075d0:	f3 0f 1e fb          	endbr32 
801075d4:	55                   	push   %ebp
801075d5:	89 e5                	mov    %esp,%ebp
801075d7:	83 ec 20             	sub    $0x20,%esp
  int i;
  // check for valid argument
  if(argint(0,&i)<0)
801075da:	8d 45 f4             	lea    -0xc(%ebp),%eax
801075dd:	50                   	push   %eax
801075de:	6a 00                	push   $0x0
801075e0:	e8 3b ec ff ff       	call   80106220 <argint>
801075e5:	83 c4 10             	add    $0x10,%esp
801075e8:	89 c2                	mov    %eax,%edx
801075ea:	31 c0                	xor    %eax,%eax
801075ec:	85 d2                	test   %edx,%edx
801075ee:	78 0e                	js     801075fe <sys_shmdt+0x2e>
    return 0;
  return shmdt((void*)i);
801075f0:	83 ec 0c             	sub    $0xc,%esp
801075f3:	ff 75 f4             	pushl  -0xc(%ebp)
801075f6:	e8 e5 1c 00 00       	call   801092e0 <shmdt>
801075fb:	83 c4 10             	add    $0x10,%esp
}
801075fe:	c9                   	leave  
801075ff:	c3                   	ret    

80107600 <sys_shmat>:

// system call handler for shmat
void*
sys_shmat(void)
{
80107600:	f3 0f 1e fb          	endbr32 
80107604:	55                   	push   %ebp
80107605:	89 e5                	mov    %esp,%ebp
80107607:	83 ec 20             	sub    $0x20,%esp
  int shmid, shmflag;
  int i;
  // check for valid arguments
  if(argint(0, &shmid) < 0)
8010760a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010760d:	50                   	push   %eax
8010760e:	6a 00                	push   $0x0
80107610:	e8 0b ec ff ff       	call   80106220 <argint>
80107615:	83 c4 10             	add    $0x10,%esp
80107618:	85 c0                	test   %eax,%eax
8010761a:	78 44                	js     80107660 <sys_shmat+0x60>
    return (void*)0;
  if(argint(1,&i)<0)
8010761c:	83 ec 08             	sub    $0x8,%esp
8010761f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107622:	50                   	push   %eax
80107623:	6a 01                	push   $0x1
80107625:	e8 f6 eb ff ff       	call   80106220 <argint>
8010762a:	83 c4 10             	add    $0x10,%esp
8010762d:	85 c0                	test   %eax,%eax
8010762f:	78 2f                	js     80107660 <sys_shmat+0x60>
    return (void*)0;
  if(argint(2, &shmflag) < 0)
80107631:	83 ec 08             	sub    $0x8,%esp
80107634:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107637:	50                   	push   %eax
80107638:	6a 02                	push   $0x2
8010763a:	e8 e1 eb ff ff       	call   80106220 <argint>
8010763f:	83 c4 10             	add    $0x10,%esp
80107642:	85 c0                	test   %eax,%eax
80107644:	78 1a                	js     80107660 <sys_shmat+0x60>
    return (void*)0;
  return shmat(shmid, (void*)i, shmflag);
80107646:	83 ec 04             	sub    $0x4,%esp
80107649:	ff 75 f0             	pushl  -0x10(%ebp)
8010764c:	ff 75 f4             	pushl  -0xc(%ebp)
8010764f:	ff 75 ec             	pushl  -0x14(%ebp)
80107652:	e8 a9 1e 00 00       	call   80109500 <shmat>
80107657:	83 c4 10             	add    $0x10,%esp
}
8010765a:	c9                   	leave  
8010765b:	c3                   	ret    
8010765c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107660:	c9                   	leave  
    return (void*)0;
80107661:	31 c0                	xor    %eax,%eax
}
80107663:	c3                   	ret    
80107664:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010766b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010766f:	90                   	nop

80107670 <sys_shmctl>:

// system call handler for shmctl
int
sys_shmctl(void)
{
80107670:	f3 0f 1e fb          	endbr32 
80107674:	55                   	push   %ebp
80107675:	89 e5                	mov    %esp,%ebp
80107677:	83 ec 20             	sub    $0x20,%esp
  int shmid, cmd, buf;
  // check for valid arguments
  if(argint(0, &shmid) < 0)
8010767a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010767d:	50                   	push   %eax
8010767e:	6a 00                	push   $0x0
80107680:	e8 9b eb ff ff       	call   80106220 <argint>
80107685:	83 c4 10             	add    $0x10,%esp
80107688:	85 c0                	test   %eax,%eax
8010768a:	78 44                	js     801076d0 <sys_shmctl+0x60>
    return -1;
  if(argint(1, &cmd) < 0)
8010768c:	83 ec 08             	sub    $0x8,%esp
8010768f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107692:	50                   	push   %eax
80107693:	6a 01                	push   $0x1
80107695:	e8 86 eb ff ff       	call   80106220 <argint>
8010769a:	83 c4 10             	add    $0x10,%esp
8010769d:	85 c0                	test   %eax,%eax
8010769f:	78 2f                	js     801076d0 <sys_shmctl+0x60>
    return -1;
  if(argint(2, &buf) < 0)
801076a1:	83 ec 08             	sub    $0x8,%esp
801076a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801076a7:	50                   	push   %eax
801076a8:	6a 02                	push   $0x2
801076aa:	e8 71 eb ff ff       	call   80106220 <argint>
801076af:	83 c4 10             	add    $0x10,%esp
801076b2:	85 c0                	test   %eax,%eax
801076b4:	78 1a                	js     801076d0 <sys_shmctl+0x60>
    return -1;
  return shmctl(shmid, cmd, (void*)buf);
801076b6:	83 ec 04             	sub    $0x4,%esp
801076b9:	ff 75 f4             	pushl  -0xc(%ebp)
801076bc:	ff 75 f0             	pushl  -0x10(%ebp)
801076bf:	ff 75 ec             	pushl  -0x14(%ebp)
801076c2:	e8 69 22 00 00       	call   80109930 <shmctl>
801076c7:	83 c4 10             	add    $0x10,%esp
801076ca:	c9                   	leave  
801076cb:	c3                   	ret    
801076cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076d0:	c9                   	leave  
    return -1;
801076d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801076d6:	c3                   	ret    

801076d7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801076d7:	1e                   	push   %ds
  pushl %es
801076d8:	06                   	push   %es
  pushl %fs
801076d9:	0f a0                	push   %fs
  pushl %gs
801076db:	0f a8                	push   %gs
  pushal
801076dd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801076de:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801076e2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801076e4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801076e6:	54                   	push   %esp
  call trap
801076e7:	e8 c4 00 00 00       	call   801077b0 <trap>
  addl $4, %esp
801076ec:	83 c4 04             	add    $0x4,%esp

801076ef <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801076ef:	61                   	popa   
  popl %gs
801076f0:	0f a9                	pop    %gs
  popl %fs
801076f2:	0f a1                	pop    %fs
  popl %es
801076f4:	07                   	pop    %es
  popl %ds
801076f5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801076f6:	83 c4 08             	add    $0x8,%esp
  iret
801076f9:	cf                   	iret   
801076fa:	66 90                	xchg   %ax,%ax
801076fc:	66 90                	xchg   %ax,%ax
801076fe:	66 90                	xchg   %ax,%ax

80107700 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107700:	f3 0f 1e fb          	endbr32 
80107704:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107705:	31 c0                	xor    %eax,%eax
{
80107707:	89 e5                	mov    %esp,%ebp
80107709:	83 ec 08             	sub    $0x8,%esp
8010770c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107710:	8b 14 85 08 d0 10 80 	mov    -0x7fef2ff8(,%eax,4),%edx
80107717:	c7 04 c5 e2 ce 12 80 	movl   $0x8e000008,-0x7fed311e(,%eax,8)
8010771e:	08 00 00 8e 
80107722:	66 89 14 c5 e0 ce 12 	mov    %dx,-0x7fed3120(,%eax,8)
80107729:	80 
8010772a:	c1 ea 10             	shr    $0x10,%edx
8010772d:	66 89 14 c5 e6 ce 12 	mov    %dx,-0x7fed311a(,%eax,8)
80107734:	80 
  for(i = 0; i < 256; i++)
80107735:	83 c0 01             	add    $0x1,%eax
80107738:	3d 00 01 00 00       	cmp    $0x100,%eax
8010773d:	75 d1                	jne    80107710 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010773f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107742:	a1 08 d1 10 80       	mov    0x8010d108,%eax
80107747:	c7 05 e2 d0 12 80 08 	movl   $0xef000008,0x8012d0e2
8010774e:	00 00 ef 
  initlock(&tickslock, "time");
80107751:	68 ac a7 10 80       	push   $0x8010a7ac
80107756:	68 a0 ce 12 80       	push   $0x8012cea0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010775b:	66 a3 e0 d0 12 80    	mov    %ax,0x8012d0e0
80107761:	c1 e8 10             	shr    $0x10,%eax
80107764:	66 a3 e6 d0 12 80    	mov    %ax,0x8012d0e6
  initlock(&tickslock, "time");
8010776a:	e8 b1 e4 ff ff       	call   80105c20 <initlock>
}
8010776f:	83 c4 10             	add    $0x10,%esp
80107772:	c9                   	leave  
80107773:	c3                   	ret    
80107774:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010777b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010777f:	90                   	nop

80107780 <idtinit>:

void
idtinit(void)
{
80107780:	f3 0f 1e fb          	endbr32 
80107784:	55                   	push   %ebp
  pd[0] = size-1;
80107785:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010778a:	89 e5                	mov    %esp,%ebp
8010778c:	83 ec 10             	sub    $0x10,%esp
8010778f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107793:	b8 e0 ce 12 80       	mov    $0x8012cee0,%eax
80107798:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010779c:	c1 e8 10             	shr    $0x10,%eax
8010779f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801077a3:	8d 45 fa             	lea    -0x6(%ebp),%eax
801077a6:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801077a9:	c9                   	leave  
801077aa:	c3                   	ret    
801077ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077af:	90                   	nop

801077b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801077b0:	f3 0f 1e fb          	endbr32 
801077b4:	55                   	push   %ebp
801077b5:	89 e5                	mov    %esp,%ebp
801077b7:	57                   	push   %edi
801077b8:	56                   	push   %esi
801077b9:	53                   	push   %ebx
801077ba:	83 ec 1c             	sub    $0x1c,%esp
801077bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801077c0:	8b 43 30             	mov    0x30(%ebx),%eax
801077c3:	83 f8 40             	cmp    $0x40,%eax
801077c6:	0f 84 5c 02 00 00    	je     80107a28 <trap+0x278>
    if(myproc()->killed)
      exit();
    return;
  }
  int os_tick;
  switch(tf->trapno){
801077cc:	83 e8 0e             	sub    $0xe,%eax
801077cf:	83 f8 31             	cmp    $0x31,%eax
801077d2:	77 08                	ja     801077dc <trap+0x2c>
801077d4:	3e ff 24 85 8c a8 10 	notrack jmp *-0x7fef5774(,%eax,4)
801077db:	80 



    
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801077dc:	e8 8f c7 ff ff       	call   80103f70 <myproc>
801077e1:	85 c0                	test   %eax,%eax
801077e3:	0f 84 a6 02 00 00    	je     80107a8f <trap+0x2df>
801077e9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801077ed:	0f 84 9c 02 00 00    	je     80107a8f <trap+0x2df>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801077f3:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077f6:	8b 53 38             	mov    0x38(%ebx),%edx
801077f9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801077fc:	89 55 dc             	mov    %edx,-0x24(%ebp)
801077ff:	e8 4c c7 ff ff       	call   80103f50 <cpuid>
80107804:	8b 73 30             	mov    0x30(%ebx),%esi
80107807:	89 c7                	mov    %eax,%edi
80107809:	8b 43 34             	mov    0x34(%ebx),%eax
8010780c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010780f:	e8 5c c7 ff ff       	call   80103f70 <myproc>
80107814:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107817:	e8 54 c7 ff ff       	call   80103f70 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010781c:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010781f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107822:	51                   	push   %ecx
80107823:	52                   	push   %edx
80107824:	57                   	push   %edi
80107825:	ff 75 e4             	pushl  -0x1c(%ebp)
80107828:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80107829:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010782c:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010782f:	56                   	push   %esi
80107830:	ff 70 10             	pushl  0x10(%eax)
80107833:	68 1c a8 10 80       	push   $0x8010a81c
80107838:	e8 83 90 ff ff       	call   801008c0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010783d:	83 c4 20             	add    $0x20,%esp
80107840:	e8 2b c7 ff ff       	call   80103f70 <myproc>
80107845:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010784c:	e8 1f c7 ff ff       	call   80103f70 <myproc>
80107851:	85 c0                	test   %eax,%eax
80107853:	74 1d                	je     80107872 <trap+0xc2>
80107855:	e8 16 c7 ff ff       	call   80103f70 <myproc>
8010785a:	8b 50 24             	mov    0x24(%eax),%edx
8010785d:	85 d2                	test   %edx,%edx
8010785f:	74 11                	je     80107872 <trap+0xc2>
80107861:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107865:	83 e0 03             	and    $0x3,%eax
80107868:	66 83 f8 03          	cmp    $0x3,%ax
8010786c:	0f 84 06 02 00 00    	je     80107a78 <trap+0x2c8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107872:	e8 f9 c6 ff ff       	call   80103f70 <myproc>
80107877:	85 c0                	test   %eax,%eax
80107879:	74 0f                	je     8010788a <trap+0xda>
8010787b:	e8 f0 c6 ff ff       	call   80103f70 <myproc>
80107880:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107884:	0f 84 86 01 00 00    	je     80107a10 <trap+0x260>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010788a:	e8 e1 c6 ff ff       	call   80103f70 <myproc>
8010788f:	85 c0                	test   %eax,%eax
80107891:	74 1d                	je     801078b0 <trap+0x100>
80107893:	e8 d8 c6 ff ff       	call   80103f70 <myproc>
80107898:	8b 40 24             	mov    0x24(%eax),%eax
8010789b:	85 c0                	test   %eax,%eax
8010789d:	74 11                	je     801078b0 <trap+0x100>
8010789f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801078a3:	83 e0 03             	and    $0x3,%eax
801078a6:	66 83 f8 03          	cmp    $0x3,%ax
801078aa:	0f 84 a1 01 00 00    	je     80107a51 <trap+0x2a1>
    exit();
}
801078b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078b3:	5b                   	pop    %ebx
801078b4:	5e                   	pop    %esi
801078b5:	5f                   	pop    %edi
801078b6:	5d                   	pop    %ebp
801078b7:	c3                   	ret    
    ideintr();
801078b8:	e8 93 ae ff ff       	call   80102750 <ideintr>
    lapiceoi();
801078bd:	e8 6e b5 ff ff       	call   80102e30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801078c2:	e8 a9 c6 ff ff       	call   80103f70 <myproc>
801078c7:	85 c0                	test   %eax,%eax
801078c9:	75 8a                	jne    80107855 <trap+0xa5>
801078cb:	eb a5                	jmp    80107872 <trap+0xc2>
    if(strncmp(myproc()->name, "testShared", strlen(myproc()->name)) != 0) {
801078cd:	e8 9e c6 ff ff       	call   80103f70 <myproc>
801078d2:	83 ec 0c             	sub    $0xc,%esp
801078d5:	83 c0 6c             	add    $0x6c,%eax
801078d8:	50                   	push   %eax
801078d9:	e8 d2 e7 ff ff       	call   801060b0 <strlen>
801078de:	89 c6                	mov    %eax,%esi
801078e0:	e8 8b c6 ff ff       	call   80103f70 <myproc>
801078e5:	83 c4 0c             	add    $0xc,%esp
801078e8:	83 c0 6c             	add    $0x6c,%eax
801078eb:	56                   	push   %esi
801078ec:	68 b1 a7 10 80       	push   $0x8010a7b1
801078f1:	50                   	push   %eax
801078f2:	e8 c9 e6 ff ff       	call   80105fc0 <strncmp>
801078f7:	83 c4 10             	add    $0x10,%esp
801078fa:	85 c0                	test   %eax,%eax
801078fc:	0f 84 5e 01 00 00    	je     80107a60 <trap+0x2b0>
      if(myproc() == 0 || (tf->cs&3) == 0){
80107902:	e8 69 c6 ff ff       	call   80103f70 <myproc>
80107907:	8b 7b 38             	mov    0x38(%ebx),%edi
8010790a:	85 c0                	test   %eax,%eax
8010790c:	0f 84 a8 01 00 00    	je     80107aba <trap+0x30a>
80107912:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107916:	0f 84 9e 01 00 00    	je     80107aba <trap+0x30a>
8010791c:	0f 20 d1             	mov    %cr2,%ecx
8010791f:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("pid %d %s: trap %d err %d on cpu %d "
80107922:	e8 29 c6 ff ff       	call   80103f50 <cpuid>
80107927:	8b 73 30             	mov    0x30(%ebx),%esi
8010792a:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010792d:	8b 43 34             	mov    0x34(%ebx),%eax
80107930:	89 45 e4             	mov    %eax,-0x1c(%ebp)
              myproc()->pid, myproc()->name, tf->trapno,
80107933:	e8 38 c6 ff ff       	call   80103f70 <myproc>
80107938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010793b:	e8 30 c6 ff ff       	call   80103f70 <myproc>
      cprintf("pid %d %s: trap %d err %d on cpu %d "
80107940:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107943:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107946:	51                   	push   %ecx
80107947:	57                   	push   %edi
80107948:	52                   	push   %edx
80107949:	e9 d7 fe ff ff       	jmp    80107825 <trap+0x75>
    if(cpuid() == 0){
8010794e:	e8 fd c5 ff ff       	call   80103f50 <cpuid>
80107953:	85 c0                	test   %eax,%eax
80107955:	0f 85 62 ff ff ff    	jne    801078bd <trap+0x10d>
      acquire(&tickslock);
8010795b:	83 ec 0c             	sub    $0xc,%esp
8010795e:	68 a0 ce 12 80       	push   $0x8012cea0
80107963:	e8 38 e4 ff ff       	call   80105da0 <acquire>
      ticks++;
80107968:	a1 e0 d6 12 80       	mov    0x8012d6e0,%eax
      wakeup(&ticks);
8010796d:	c7 04 24 e0 d6 12 80 	movl   $0x8012d6e0,(%esp)
      ticks++;
80107974:	8d 70 01             	lea    0x1(%eax),%esi
80107977:	89 35 e0 d6 12 80    	mov    %esi,0x8012d6e0
      wakeup(&ticks);
8010797d:	e8 be cd ff ff       	call   80104740 <wakeup>
      release(&tickslock);
80107982:	c7 04 24 a0 ce 12 80 	movl   $0x8012cea0,(%esp)
80107989:	e8 d2 e4 ff ff       	call   80105e60 <release>
      ageprocs(os_tick);
8010798e:	89 34 24             	mov    %esi,(%esp)
80107991:	e8 5a d4 ff ff       	call   80104df0 <ageprocs>
80107996:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80107999:	e9 1f ff ff ff       	jmp    801078bd <trap+0x10d>
    uartintr();
8010799e:	e8 9d 02 00 00       	call   80107c40 <uartintr>
    lapiceoi();
801079a3:	e8 88 b4 ff ff       	call   80102e30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801079a8:	e8 c3 c5 ff ff       	call   80103f70 <myproc>
801079ad:	85 c0                	test   %eax,%eax
801079af:	0f 85 a0 fe ff ff    	jne    80107855 <trap+0xa5>
801079b5:	e9 b8 fe ff ff       	jmp    80107872 <trap+0xc2>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801079ba:	8b 7b 38             	mov    0x38(%ebx),%edi
801079bd:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801079c1:	e8 8a c5 ff ff       	call   80103f50 <cpuid>
801079c6:	57                   	push   %edi
801079c7:	56                   	push   %esi
801079c8:	50                   	push   %eax
801079c9:	68 c4 a7 10 80       	push   $0x8010a7c4
801079ce:	e8 ed 8e ff ff       	call   801008c0 <cprintf>
    lapiceoi();
801079d3:	e8 58 b4 ff ff       	call   80102e30 <lapiceoi>
    break;
801079d8:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801079db:	e8 90 c5 ff ff       	call   80103f70 <myproc>
801079e0:	85 c0                	test   %eax,%eax
801079e2:	0f 85 6d fe ff ff    	jne    80107855 <trap+0xa5>
801079e8:	e9 85 fe ff ff       	jmp    80107872 <trap+0xc2>
    kbdintr();
801079ed:	e8 fe b2 ff ff       	call   80102cf0 <kbdintr>
    lapiceoi();
801079f2:	e8 39 b4 ff ff       	call   80102e30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801079f7:	e8 74 c5 ff ff       	call   80103f70 <myproc>
801079fc:	85 c0                	test   %eax,%eax
801079fe:	0f 85 51 fe ff ff    	jne    80107855 <trap+0xa5>
80107a04:	e9 69 fe ff ff       	jmp    80107872 <trap+0xc2>
80107a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107a10:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80107a14:	0f 85 70 fe ff ff    	jne    8010788a <trap+0xda>
    yield();
80107a1a:	e8 11 cb ff ff       	call   80104530 <yield>
80107a1f:	e9 66 fe ff ff       	jmp    8010788a <trap+0xda>
80107a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107a28:	e8 43 c5 ff ff       	call   80103f70 <myproc>
80107a2d:	8b 70 24             	mov    0x24(%eax),%esi
80107a30:	85 f6                	test   %esi,%esi
80107a32:	75 54                	jne    80107a88 <trap+0x2d8>
    myproc()->tf = tf;
80107a34:	e8 37 c5 ff ff       	call   80103f70 <myproc>
80107a39:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107a3c:	e8 cf e8 ff ff       	call   80106310 <syscall>
    if(myproc()->killed)
80107a41:	e8 2a c5 ff ff       	call   80103f70 <myproc>
80107a46:	8b 48 24             	mov    0x24(%eax),%ecx
80107a49:	85 c9                	test   %ecx,%ecx
80107a4b:	0f 84 5f fe ff ff    	je     801078b0 <trap+0x100>
}
80107a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a54:	5b                   	pop    %ebx
80107a55:	5e                   	pop    %esi
80107a56:	5f                   	pop    %edi
80107a57:	5d                   	pop    %ebp
      exit();
80107a58:	e9 63 c9 ff ff       	jmp    801043c0 <exit>
80107a5d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("Segmentation fault (Core dumped) - Trap 14\n");
80107a60:	83 ec 0c             	sub    $0xc,%esp
80107a63:	68 60 a8 10 80       	push   $0x8010a860
80107a68:	e8 53 8e ff ff       	call   801008c0 <cprintf>
80107a6d:	83 c4 10             	add    $0x10,%esp
    myproc()->killed = 1;
80107a70:	e9 cb fd ff ff       	jmp    80107840 <trap+0x90>
80107a75:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80107a78:	e8 43 c9 ff ff       	call   801043c0 <exit>
80107a7d:	e9 f0 fd ff ff       	jmp    80107872 <trap+0xc2>
80107a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80107a88:	e8 33 c9 ff ff       	call   801043c0 <exit>
80107a8d:	eb a5                	jmp    80107a34 <trap+0x284>
80107a8f:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107a92:	8b 73 38             	mov    0x38(%ebx),%esi
80107a95:	e8 b6 c4 ff ff       	call   80103f50 <cpuid>
80107a9a:	83 ec 0c             	sub    $0xc,%esp
80107a9d:	57                   	push   %edi
80107a9e:	56                   	push   %esi
80107a9f:	50                   	push   %eax
80107aa0:	ff 73 30             	pushl  0x30(%ebx)
80107aa3:	68 e8 a7 10 80       	push   $0x8010a7e8
80107aa8:	e8 13 8e ff ff       	call   801008c0 <cprintf>
      panic("trap");
80107aad:	83 c4 14             	add    $0x14,%esp
80107ab0:	68 bc a7 10 80       	push   $0x8010a7bc
80107ab5:	e8 d6 88 ff ff       	call   80100390 <panic>
80107aba:	0f 20 d6             	mov    %cr2,%esi
        cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107abd:	e8 8e c4 ff ff       	call   80103f50 <cpuid>
80107ac2:	83 ec 0c             	sub    $0xc,%esp
80107ac5:	56                   	push   %esi
80107ac6:	57                   	push   %edi
80107ac7:	eb d6                	jmp    80107a9f <trap+0x2ef>
80107ac9:	66 90                	xchg   %ax,%ax
80107acb:	66 90                	xchg   %ax,%ax
80107acd:	66 90                	xchg   %ax,%ax
80107acf:	90                   	nop

80107ad0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80107ad0:	f3 0f 1e fb          	endbr32 
  if(!uart)
80107ad4:	a1 20 d6 10 80       	mov    0x8010d620,%eax
80107ad9:	85 c0                	test   %eax,%eax
80107adb:	74 1b                	je     80107af8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107add:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107ae2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107ae3:	a8 01                	test   $0x1,%al
80107ae5:	74 11                	je     80107af8 <uartgetc+0x28>
80107ae7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107aec:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107aed:	0f b6 c0             	movzbl %al,%eax
80107af0:	c3                   	ret    
80107af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107af8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107afd:	c3                   	ret    
80107afe:	66 90                	xchg   %ax,%ax

80107b00 <uartputc.part.0>:
uartputc(int c)
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	57                   	push   %edi
80107b04:	89 c7                	mov    %eax,%edi
80107b06:	56                   	push   %esi
80107b07:	be fd 03 00 00       	mov    $0x3fd,%esi
80107b0c:	53                   	push   %ebx
80107b0d:	bb 80 00 00 00       	mov    $0x80,%ebx
80107b12:	83 ec 0c             	sub    $0xc,%esp
80107b15:	eb 1b                	jmp    80107b32 <uartputc.part.0+0x32>
80107b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b1e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80107b20:	83 ec 0c             	sub    $0xc,%esp
80107b23:	6a 0a                	push   $0xa
80107b25:	e8 26 b3 ff ff       	call   80102e50 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107b2a:	83 c4 10             	add    $0x10,%esp
80107b2d:	83 eb 01             	sub    $0x1,%ebx
80107b30:	74 07                	je     80107b39 <uartputc.part.0+0x39>
80107b32:	89 f2                	mov    %esi,%edx
80107b34:	ec                   	in     (%dx),%al
80107b35:	a8 20                	test   $0x20,%al
80107b37:	74 e7                	je     80107b20 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107b39:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107b3e:	89 f8                	mov    %edi,%eax
80107b40:	ee                   	out    %al,(%dx)
}
80107b41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b44:	5b                   	pop    %ebx
80107b45:	5e                   	pop    %esi
80107b46:	5f                   	pop    %edi
80107b47:	5d                   	pop    %ebp
80107b48:	c3                   	ret    
80107b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107b50 <uartinit>:
{
80107b50:	f3 0f 1e fb          	endbr32 
80107b54:	55                   	push   %ebp
80107b55:	31 c9                	xor    %ecx,%ecx
80107b57:	89 c8                	mov    %ecx,%eax
80107b59:	89 e5                	mov    %esp,%ebp
80107b5b:	57                   	push   %edi
80107b5c:	56                   	push   %esi
80107b5d:	53                   	push   %ebx
80107b5e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80107b63:	89 da                	mov    %ebx,%edx
80107b65:	83 ec 0c             	sub    $0xc,%esp
80107b68:	ee                   	out    %al,(%dx)
80107b69:	bf fb 03 00 00       	mov    $0x3fb,%edi
80107b6e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80107b73:	89 fa                	mov    %edi,%edx
80107b75:	ee                   	out    %al,(%dx)
80107b76:	b8 0c 00 00 00       	mov    $0xc,%eax
80107b7b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107b80:	ee                   	out    %al,(%dx)
80107b81:	be f9 03 00 00       	mov    $0x3f9,%esi
80107b86:	89 c8                	mov    %ecx,%eax
80107b88:	89 f2                	mov    %esi,%edx
80107b8a:	ee                   	out    %al,(%dx)
80107b8b:	b8 03 00 00 00       	mov    $0x3,%eax
80107b90:	89 fa                	mov    %edi,%edx
80107b92:	ee                   	out    %al,(%dx)
80107b93:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107b98:	89 c8                	mov    %ecx,%eax
80107b9a:	ee                   	out    %al,(%dx)
80107b9b:	b8 01 00 00 00       	mov    $0x1,%eax
80107ba0:	89 f2                	mov    %esi,%edx
80107ba2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107ba3:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107ba8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107ba9:	3c ff                	cmp    $0xff,%al
80107bab:	74 52                	je     80107bff <uartinit+0xaf>
  uart = 1;
80107bad:	c7 05 20 d6 10 80 01 	movl   $0x1,0x8010d620
80107bb4:	00 00 00 
80107bb7:	89 da                	mov    %ebx,%edx
80107bb9:	ec                   	in     (%dx),%al
80107bba:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107bbf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107bc0:	83 ec 08             	sub    $0x8,%esp
80107bc3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80107bc8:	bb 54 a9 10 80       	mov    $0x8010a954,%ebx
  ioapicenable(IRQ_COM1, 0);
80107bcd:	6a 00                	push   $0x0
80107bcf:	6a 04                	push   $0x4
80107bd1:	e8 ca ad ff ff       	call   801029a0 <ioapicenable>
80107bd6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107bd9:	b8 78 00 00 00       	mov    $0x78,%eax
80107bde:	eb 04                	jmp    80107be4 <uartinit+0x94>
80107be0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80107be4:	8b 15 20 d6 10 80    	mov    0x8010d620,%edx
80107bea:	85 d2                	test   %edx,%edx
80107bec:	74 08                	je     80107bf6 <uartinit+0xa6>
    uartputc(*p);
80107bee:	0f be c0             	movsbl %al,%eax
80107bf1:	e8 0a ff ff ff       	call   80107b00 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80107bf6:	89 f0                	mov    %esi,%eax
80107bf8:	83 c3 01             	add    $0x1,%ebx
80107bfb:	84 c0                	test   %al,%al
80107bfd:	75 e1                	jne    80107be0 <uartinit+0x90>
}
80107bff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c02:	5b                   	pop    %ebx
80107c03:	5e                   	pop    %esi
80107c04:	5f                   	pop    %edi
80107c05:	5d                   	pop    %ebp
80107c06:	c3                   	ret    
80107c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c0e:	66 90                	xchg   %ax,%ax

80107c10 <uartputc>:
{
80107c10:	f3 0f 1e fb          	endbr32 
80107c14:	55                   	push   %ebp
  if(!uart)
80107c15:	8b 15 20 d6 10 80    	mov    0x8010d620,%edx
{
80107c1b:	89 e5                	mov    %esp,%ebp
80107c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80107c20:	85 d2                	test   %edx,%edx
80107c22:	74 0c                	je     80107c30 <uartputc+0x20>
}
80107c24:	5d                   	pop    %ebp
80107c25:	e9 d6 fe ff ff       	jmp    80107b00 <uartputc.part.0>
80107c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c30:	5d                   	pop    %ebp
80107c31:	c3                   	ret    
80107c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c40 <uartintr>:

void
uartintr(void)
{
80107c40:	f3 0f 1e fb          	endbr32 
80107c44:	55                   	push   %ebp
80107c45:	89 e5                	mov    %esp,%ebp
80107c47:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107c4a:	68 d0 7a 10 80       	push   $0x80107ad0
80107c4f:	e8 1c 8e ff ff       	call   80100a70 <consoleintr>
}
80107c54:	83 c4 10             	add    $0x10,%esp
80107c57:	c9                   	leave  
80107c58:	c3                   	ret    

80107c59 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107c59:	6a 00                	push   $0x0
  pushl $0
80107c5b:	6a 00                	push   $0x0
  jmp alltraps
80107c5d:	e9 75 fa ff ff       	jmp    801076d7 <alltraps>

80107c62 <vector1>:
.globl vector1
vector1:
  pushl $0
80107c62:	6a 00                	push   $0x0
  pushl $1
80107c64:	6a 01                	push   $0x1
  jmp alltraps
80107c66:	e9 6c fa ff ff       	jmp    801076d7 <alltraps>

80107c6b <vector2>:
.globl vector2
vector2:
  pushl $0
80107c6b:	6a 00                	push   $0x0
  pushl $2
80107c6d:	6a 02                	push   $0x2
  jmp alltraps
80107c6f:	e9 63 fa ff ff       	jmp    801076d7 <alltraps>

80107c74 <vector3>:
.globl vector3
vector3:
  pushl $0
80107c74:	6a 00                	push   $0x0
  pushl $3
80107c76:	6a 03                	push   $0x3
  jmp alltraps
80107c78:	e9 5a fa ff ff       	jmp    801076d7 <alltraps>

80107c7d <vector4>:
.globl vector4
vector4:
  pushl $0
80107c7d:	6a 00                	push   $0x0
  pushl $4
80107c7f:	6a 04                	push   $0x4
  jmp alltraps
80107c81:	e9 51 fa ff ff       	jmp    801076d7 <alltraps>

80107c86 <vector5>:
.globl vector5
vector5:
  pushl $0
80107c86:	6a 00                	push   $0x0
  pushl $5
80107c88:	6a 05                	push   $0x5
  jmp alltraps
80107c8a:	e9 48 fa ff ff       	jmp    801076d7 <alltraps>

80107c8f <vector6>:
.globl vector6
vector6:
  pushl $0
80107c8f:	6a 00                	push   $0x0
  pushl $6
80107c91:	6a 06                	push   $0x6
  jmp alltraps
80107c93:	e9 3f fa ff ff       	jmp    801076d7 <alltraps>

80107c98 <vector7>:
.globl vector7
vector7:
  pushl $0
80107c98:	6a 00                	push   $0x0
  pushl $7
80107c9a:	6a 07                	push   $0x7
  jmp alltraps
80107c9c:	e9 36 fa ff ff       	jmp    801076d7 <alltraps>

80107ca1 <vector8>:
.globl vector8
vector8:
  pushl $8
80107ca1:	6a 08                	push   $0x8
  jmp alltraps
80107ca3:	e9 2f fa ff ff       	jmp    801076d7 <alltraps>

80107ca8 <vector9>:
.globl vector9
vector9:
  pushl $0
80107ca8:	6a 00                	push   $0x0
  pushl $9
80107caa:	6a 09                	push   $0x9
  jmp alltraps
80107cac:	e9 26 fa ff ff       	jmp    801076d7 <alltraps>

80107cb1 <vector10>:
.globl vector10
vector10:
  pushl $10
80107cb1:	6a 0a                	push   $0xa
  jmp alltraps
80107cb3:	e9 1f fa ff ff       	jmp    801076d7 <alltraps>

80107cb8 <vector11>:
.globl vector11
vector11:
  pushl $11
80107cb8:	6a 0b                	push   $0xb
  jmp alltraps
80107cba:	e9 18 fa ff ff       	jmp    801076d7 <alltraps>

80107cbf <vector12>:
.globl vector12
vector12:
  pushl $12
80107cbf:	6a 0c                	push   $0xc
  jmp alltraps
80107cc1:	e9 11 fa ff ff       	jmp    801076d7 <alltraps>

80107cc6 <vector13>:
.globl vector13
vector13:
  pushl $13
80107cc6:	6a 0d                	push   $0xd
  jmp alltraps
80107cc8:	e9 0a fa ff ff       	jmp    801076d7 <alltraps>

80107ccd <vector14>:
.globl vector14
vector14:
  pushl $14
80107ccd:	6a 0e                	push   $0xe
  jmp alltraps
80107ccf:	e9 03 fa ff ff       	jmp    801076d7 <alltraps>

80107cd4 <vector15>:
.globl vector15
vector15:
  pushl $0
80107cd4:	6a 00                	push   $0x0
  pushl $15
80107cd6:	6a 0f                	push   $0xf
  jmp alltraps
80107cd8:	e9 fa f9 ff ff       	jmp    801076d7 <alltraps>

80107cdd <vector16>:
.globl vector16
vector16:
  pushl $0
80107cdd:	6a 00                	push   $0x0
  pushl $16
80107cdf:	6a 10                	push   $0x10
  jmp alltraps
80107ce1:	e9 f1 f9 ff ff       	jmp    801076d7 <alltraps>

80107ce6 <vector17>:
.globl vector17
vector17:
  pushl $17
80107ce6:	6a 11                	push   $0x11
  jmp alltraps
80107ce8:	e9 ea f9 ff ff       	jmp    801076d7 <alltraps>

80107ced <vector18>:
.globl vector18
vector18:
  pushl $0
80107ced:	6a 00                	push   $0x0
  pushl $18
80107cef:	6a 12                	push   $0x12
  jmp alltraps
80107cf1:	e9 e1 f9 ff ff       	jmp    801076d7 <alltraps>

80107cf6 <vector19>:
.globl vector19
vector19:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $19
80107cf8:	6a 13                	push   $0x13
  jmp alltraps
80107cfa:	e9 d8 f9 ff ff       	jmp    801076d7 <alltraps>

80107cff <vector20>:
.globl vector20
vector20:
  pushl $0
80107cff:	6a 00                	push   $0x0
  pushl $20
80107d01:	6a 14                	push   $0x14
  jmp alltraps
80107d03:	e9 cf f9 ff ff       	jmp    801076d7 <alltraps>

80107d08 <vector21>:
.globl vector21
vector21:
  pushl $0
80107d08:	6a 00                	push   $0x0
  pushl $21
80107d0a:	6a 15                	push   $0x15
  jmp alltraps
80107d0c:	e9 c6 f9 ff ff       	jmp    801076d7 <alltraps>

80107d11 <vector22>:
.globl vector22
vector22:
  pushl $0
80107d11:	6a 00                	push   $0x0
  pushl $22
80107d13:	6a 16                	push   $0x16
  jmp alltraps
80107d15:	e9 bd f9 ff ff       	jmp    801076d7 <alltraps>

80107d1a <vector23>:
.globl vector23
vector23:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $23
80107d1c:	6a 17                	push   $0x17
  jmp alltraps
80107d1e:	e9 b4 f9 ff ff       	jmp    801076d7 <alltraps>

80107d23 <vector24>:
.globl vector24
vector24:
  pushl $0
80107d23:	6a 00                	push   $0x0
  pushl $24
80107d25:	6a 18                	push   $0x18
  jmp alltraps
80107d27:	e9 ab f9 ff ff       	jmp    801076d7 <alltraps>

80107d2c <vector25>:
.globl vector25
vector25:
  pushl $0
80107d2c:	6a 00                	push   $0x0
  pushl $25
80107d2e:	6a 19                	push   $0x19
  jmp alltraps
80107d30:	e9 a2 f9 ff ff       	jmp    801076d7 <alltraps>

80107d35 <vector26>:
.globl vector26
vector26:
  pushl $0
80107d35:	6a 00                	push   $0x0
  pushl $26
80107d37:	6a 1a                	push   $0x1a
  jmp alltraps
80107d39:	e9 99 f9 ff ff       	jmp    801076d7 <alltraps>

80107d3e <vector27>:
.globl vector27
vector27:
  pushl $0
80107d3e:	6a 00                	push   $0x0
  pushl $27
80107d40:	6a 1b                	push   $0x1b
  jmp alltraps
80107d42:	e9 90 f9 ff ff       	jmp    801076d7 <alltraps>

80107d47 <vector28>:
.globl vector28
vector28:
  pushl $0
80107d47:	6a 00                	push   $0x0
  pushl $28
80107d49:	6a 1c                	push   $0x1c
  jmp alltraps
80107d4b:	e9 87 f9 ff ff       	jmp    801076d7 <alltraps>

80107d50 <vector29>:
.globl vector29
vector29:
  pushl $0
80107d50:	6a 00                	push   $0x0
  pushl $29
80107d52:	6a 1d                	push   $0x1d
  jmp alltraps
80107d54:	e9 7e f9 ff ff       	jmp    801076d7 <alltraps>

80107d59 <vector30>:
.globl vector30
vector30:
  pushl $0
80107d59:	6a 00                	push   $0x0
  pushl $30
80107d5b:	6a 1e                	push   $0x1e
  jmp alltraps
80107d5d:	e9 75 f9 ff ff       	jmp    801076d7 <alltraps>

80107d62 <vector31>:
.globl vector31
vector31:
  pushl $0
80107d62:	6a 00                	push   $0x0
  pushl $31
80107d64:	6a 1f                	push   $0x1f
  jmp alltraps
80107d66:	e9 6c f9 ff ff       	jmp    801076d7 <alltraps>

80107d6b <vector32>:
.globl vector32
vector32:
  pushl $0
80107d6b:	6a 00                	push   $0x0
  pushl $32
80107d6d:	6a 20                	push   $0x20
  jmp alltraps
80107d6f:	e9 63 f9 ff ff       	jmp    801076d7 <alltraps>

80107d74 <vector33>:
.globl vector33
vector33:
  pushl $0
80107d74:	6a 00                	push   $0x0
  pushl $33
80107d76:	6a 21                	push   $0x21
  jmp alltraps
80107d78:	e9 5a f9 ff ff       	jmp    801076d7 <alltraps>

80107d7d <vector34>:
.globl vector34
vector34:
  pushl $0
80107d7d:	6a 00                	push   $0x0
  pushl $34
80107d7f:	6a 22                	push   $0x22
  jmp alltraps
80107d81:	e9 51 f9 ff ff       	jmp    801076d7 <alltraps>

80107d86 <vector35>:
.globl vector35
vector35:
  pushl $0
80107d86:	6a 00                	push   $0x0
  pushl $35
80107d88:	6a 23                	push   $0x23
  jmp alltraps
80107d8a:	e9 48 f9 ff ff       	jmp    801076d7 <alltraps>

80107d8f <vector36>:
.globl vector36
vector36:
  pushl $0
80107d8f:	6a 00                	push   $0x0
  pushl $36
80107d91:	6a 24                	push   $0x24
  jmp alltraps
80107d93:	e9 3f f9 ff ff       	jmp    801076d7 <alltraps>

80107d98 <vector37>:
.globl vector37
vector37:
  pushl $0
80107d98:	6a 00                	push   $0x0
  pushl $37
80107d9a:	6a 25                	push   $0x25
  jmp alltraps
80107d9c:	e9 36 f9 ff ff       	jmp    801076d7 <alltraps>

80107da1 <vector38>:
.globl vector38
vector38:
  pushl $0
80107da1:	6a 00                	push   $0x0
  pushl $38
80107da3:	6a 26                	push   $0x26
  jmp alltraps
80107da5:	e9 2d f9 ff ff       	jmp    801076d7 <alltraps>

80107daa <vector39>:
.globl vector39
vector39:
  pushl $0
80107daa:	6a 00                	push   $0x0
  pushl $39
80107dac:	6a 27                	push   $0x27
  jmp alltraps
80107dae:	e9 24 f9 ff ff       	jmp    801076d7 <alltraps>

80107db3 <vector40>:
.globl vector40
vector40:
  pushl $0
80107db3:	6a 00                	push   $0x0
  pushl $40
80107db5:	6a 28                	push   $0x28
  jmp alltraps
80107db7:	e9 1b f9 ff ff       	jmp    801076d7 <alltraps>

80107dbc <vector41>:
.globl vector41
vector41:
  pushl $0
80107dbc:	6a 00                	push   $0x0
  pushl $41
80107dbe:	6a 29                	push   $0x29
  jmp alltraps
80107dc0:	e9 12 f9 ff ff       	jmp    801076d7 <alltraps>

80107dc5 <vector42>:
.globl vector42
vector42:
  pushl $0
80107dc5:	6a 00                	push   $0x0
  pushl $42
80107dc7:	6a 2a                	push   $0x2a
  jmp alltraps
80107dc9:	e9 09 f9 ff ff       	jmp    801076d7 <alltraps>

80107dce <vector43>:
.globl vector43
vector43:
  pushl $0
80107dce:	6a 00                	push   $0x0
  pushl $43
80107dd0:	6a 2b                	push   $0x2b
  jmp alltraps
80107dd2:	e9 00 f9 ff ff       	jmp    801076d7 <alltraps>

80107dd7 <vector44>:
.globl vector44
vector44:
  pushl $0
80107dd7:	6a 00                	push   $0x0
  pushl $44
80107dd9:	6a 2c                	push   $0x2c
  jmp alltraps
80107ddb:	e9 f7 f8 ff ff       	jmp    801076d7 <alltraps>

80107de0 <vector45>:
.globl vector45
vector45:
  pushl $0
80107de0:	6a 00                	push   $0x0
  pushl $45
80107de2:	6a 2d                	push   $0x2d
  jmp alltraps
80107de4:	e9 ee f8 ff ff       	jmp    801076d7 <alltraps>

80107de9 <vector46>:
.globl vector46
vector46:
  pushl $0
80107de9:	6a 00                	push   $0x0
  pushl $46
80107deb:	6a 2e                	push   $0x2e
  jmp alltraps
80107ded:	e9 e5 f8 ff ff       	jmp    801076d7 <alltraps>

80107df2 <vector47>:
.globl vector47
vector47:
  pushl $0
80107df2:	6a 00                	push   $0x0
  pushl $47
80107df4:	6a 2f                	push   $0x2f
  jmp alltraps
80107df6:	e9 dc f8 ff ff       	jmp    801076d7 <alltraps>

80107dfb <vector48>:
.globl vector48
vector48:
  pushl $0
80107dfb:	6a 00                	push   $0x0
  pushl $48
80107dfd:	6a 30                	push   $0x30
  jmp alltraps
80107dff:	e9 d3 f8 ff ff       	jmp    801076d7 <alltraps>

80107e04 <vector49>:
.globl vector49
vector49:
  pushl $0
80107e04:	6a 00                	push   $0x0
  pushl $49
80107e06:	6a 31                	push   $0x31
  jmp alltraps
80107e08:	e9 ca f8 ff ff       	jmp    801076d7 <alltraps>

80107e0d <vector50>:
.globl vector50
vector50:
  pushl $0
80107e0d:	6a 00                	push   $0x0
  pushl $50
80107e0f:	6a 32                	push   $0x32
  jmp alltraps
80107e11:	e9 c1 f8 ff ff       	jmp    801076d7 <alltraps>

80107e16 <vector51>:
.globl vector51
vector51:
  pushl $0
80107e16:	6a 00                	push   $0x0
  pushl $51
80107e18:	6a 33                	push   $0x33
  jmp alltraps
80107e1a:	e9 b8 f8 ff ff       	jmp    801076d7 <alltraps>

80107e1f <vector52>:
.globl vector52
vector52:
  pushl $0
80107e1f:	6a 00                	push   $0x0
  pushl $52
80107e21:	6a 34                	push   $0x34
  jmp alltraps
80107e23:	e9 af f8 ff ff       	jmp    801076d7 <alltraps>

80107e28 <vector53>:
.globl vector53
vector53:
  pushl $0
80107e28:	6a 00                	push   $0x0
  pushl $53
80107e2a:	6a 35                	push   $0x35
  jmp alltraps
80107e2c:	e9 a6 f8 ff ff       	jmp    801076d7 <alltraps>

80107e31 <vector54>:
.globl vector54
vector54:
  pushl $0
80107e31:	6a 00                	push   $0x0
  pushl $54
80107e33:	6a 36                	push   $0x36
  jmp alltraps
80107e35:	e9 9d f8 ff ff       	jmp    801076d7 <alltraps>

80107e3a <vector55>:
.globl vector55
vector55:
  pushl $0
80107e3a:	6a 00                	push   $0x0
  pushl $55
80107e3c:	6a 37                	push   $0x37
  jmp alltraps
80107e3e:	e9 94 f8 ff ff       	jmp    801076d7 <alltraps>

80107e43 <vector56>:
.globl vector56
vector56:
  pushl $0
80107e43:	6a 00                	push   $0x0
  pushl $56
80107e45:	6a 38                	push   $0x38
  jmp alltraps
80107e47:	e9 8b f8 ff ff       	jmp    801076d7 <alltraps>

80107e4c <vector57>:
.globl vector57
vector57:
  pushl $0
80107e4c:	6a 00                	push   $0x0
  pushl $57
80107e4e:	6a 39                	push   $0x39
  jmp alltraps
80107e50:	e9 82 f8 ff ff       	jmp    801076d7 <alltraps>

80107e55 <vector58>:
.globl vector58
vector58:
  pushl $0
80107e55:	6a 00                	push   $0x0
  pushl $58
80107e57:	6a 3a                	push   $0x3a
  jmp alltraps
80107e59:	e9 79 f8 ff ff       	jmp    801076d7 <alltraps>

80107e5e <vector59>:
.globl vector59
vector59:
  pushl $0
80107e5e:	6a 00                	push   $0x0
  pushl $59
80107e60:	6a 3b                	push   $0x3b
  jmp alltraps
80107e62:	e9 70 f8 ff ff       	jmp    801076d7 <alltraps>

80107e67 <vector60>:
.globl vector60
vector60:
  pushl $0
80107e67:	6a 00                	push   $0x0
  pushl $60
80107e69:	6a 3c                	push   $0x3c
  jmp alltraps
80107e6b:	e9 67 f8 ff ff       	jmp    801076d7 <alltraps>

80107e70 <vector61>:
.globl vector61
vector61:
  pushl $0
80107e70:	6a 00                	push   $0x0
  pushl $61
80107e72:	6a 3d                	push   $0x3d
  jmp alltraps
80107e74:	e9 5e f8 ff ff       	jmp    801076d7 <alltraps>

80107e79 <vector62>:
.globl vector62
vector62:
  pushl $0
80107e79:	6a 00                	push   $0x0
  pushl $62
80107e7b:	6a 3e                	push   $0x3e
  jmp alltraps
80107e7d:	e9 55 f8 ff ff       	jmp    801076d7 <alltraps>

80107e82 <vector63>:
.globl vector63
vector63:
  pushl $0
80107e82:	6a 00                	push   $0x0
  pushl $63
80107e84:	6a 3f                	push   $0x3f
  jmp alltraps
80107e86:	e9 4c f8 ff ff       	jmp    801076d7 <alltraps>

80107e8b <vector64>:
.globl vector64
vector64:
  pushl $0
80107e8b:	6a 00                	push   $0x0
  pushl $64
80107e8d:	6a 40                	push   $0x40
  jmp alltraps
80107e8f:	e9 43 f8 ff ff       	jmp    801076d7 <alltraps>

80107e94 <vector65>:
.globl vector65
vector65:
  pushl $0
80107e94:	6a 00                	push   $0x0
  pushl $65
80107e96:	6a 41                	push   $0x41
  jmp alltraps
80107e98:	e9 3a f8 ff ff       	jmp    801076d7 <alltraps>

80107e9d <vector66>:
.globl vector66
vector66:
  pushl $0
80107e9d:	6a 00                	push   $0x0
  pushl $66
80107e9f:	6a 42                	push   $0x42
  jmp alltraps
80107ea1:	e9 31 f8 ff ff       	jmp    801076d7 <alltraps>

80107ea6 <vector67>:
.globl vector67
vector67:
  pushl $0
80107ea6:	6a 00                	push   $0x0
  pushl $67
80107ea8:	6a 43                	push   $0x43
  jmp alltraps
80107eaa:	e9 28 f8 ff ff       	jmp    801076d7 <alltraps>

80107eaf <vector68>:
.globl vector68
vector68:
  pushl $0
80107eaf:	6a 00                	push   $0x0
  pushl $68
80107eb1:	6a 44                	push   $0x44
  jmp alltraps
80107eb3:	e9 1f f8 ff ff       	jmp    801076d7 <alltraps>

80107eb8 <vector69>:
.globl vector69
vector69:
  pushl $0
80107eb8:	6a 00                	push   $0x0
  pushl $69
80107eba:	6a 45                	push   $0x45
  jmp alltraps
80107ebc:	e9 16 f8 ff ff       	jmp    801076d7 <alltraps>

80107ec1 <vector70>:
.globl vector70
vector70:
  pushl $0
80107ec1:	6a 00                	push   $0x0
  pushl $70
80107ec3:	6a 46                	push   $0x46
  jmp alltraps
80107ec5:	e9 0d f8 ff ff       	jmp    801076d7 <alltraps>

80107eca <vector71>:
.globl vector71
vector71:
  pushl $0
80107eca:	6a 00                	push   $0x0
  pushl $71
80107ecc:	6a 47                	push   $0x47
  jmp alltraps
80107ece:	e9 04 f8 ff ff       	jmp    801076d7 <alltraps>

80107ed3 <vector72>:
.globl vector72
vector72:
  pushl $0
80107ed3:	6a 00                	push   $0x0
  pushl $72
80107ed5:	6a 48                	push   $0x48
  jmp alltraps
80107ed7:	e9 fb f7 ff ff       	jmp    801076d7 <alltraps>

80107edc <vector73>:
.globl vector73
vector73:
  pushl $0
80107edc:	6a 00                	push   $0x0
  pushl $73
80107ede:	6a 49                	push   $0x49
  jmp alltraps
80107ee0:	e9 f2 f7 ff ff       	jmp    801076d7 <alltraps>

80107ee5 <vector74>:
.globl vector74
vector74:
  pushl $0
80107ee5:	6a 00                	push   $0x0
  pushl $74
80107ee7:	6a 4a                	push   $0x4a
  jmp alltraps
80107ee9:	e9 e9 f7 ff ff       	jmp    801076d7 <alltraps>

80107eee <vector75>:
.globl vector75
vector75:
  pushl $0
80107eee:	6a 00                	push   $0x0
  pushl $75
80107ef0:	6a 4b                	push   $0x4b
  jmp alltraps
80107ef2:	e9 e0 f7 ff ff       	jmp    801076d7 <alltraps>

80107ef7 <vector76>:
.globl vector76
vector76:
  pushl $0
80107ef7:	6a 00                	push   $0x0
  pushl $76
80107ef9:	6a 4c                	push   $0x4c
  jmp alltraps
80107efb:	e9 d7 f7 ff ff       	jmp    801076d7 <alltraps>

80107f00 <vector77>:
.globl vector77
vector77:
  pushl $0
80107f00:	6a 00                	push   $0x0
  pushl $77
80107f02:	6a 4d                	push   $0x4d
  jmp alltraps
80107f04:	e9 ce f7 ff ff       	jmp    801076d7 <alltraps>

80107f09 <vector78>:
.globl vector78
vector78:
  pushl $0
80107f09:	6a 00                	push   $0x0
  pushl $78
80107f0b:	6a 4e                	push   $0x4e
  jmp alltraps
80107f0d:	e9 c5 f7 ff ff       	jmp    801076d7 <alltraps>

80107f12 <vector79>:
.globl vector79
vector79:
  pushl $0
80107f12:	6a 00                	push   $0x0
  pushl $79
80107f14:	6a 4f                	push   $0x4f
  jmp alltraps
80107f16:	e9 bc f7 ff ff       	jmp    801076d7 <alltraps>

80107f1b <vector80>:
.globl vector80
vector80:
  pushl $0
80107f1b:	6a 00                	push   $0x0
  pushl $80
80107f1d:	6a 50                	push   $0x50
  jmp alltraps
80107f1f:	e9 b3 f7 ff ff       	jmp    801076d7 <alltraps>

80107f24 <vector81>:
.globl vector81
vector81:
  pushl $0
80107f24:	6a 00                	push   $0x0
  pushl $81
80107f26:	6a 51                	push   $0x51
  jmp alltraps
80107f28:	e9 aa f7 ff ff       	jmp    801076d7 <alltraps>

80107f2d <vector82>:
.globl vector82
vector82:
  pushl $0
80107f2d:	6a 00                	push   $0x0
  pushl $82
80107f2f:	6a 52                	push   $0x52
  jmp alltraps
80107f31:	e9 a1 f7 ff ff       	jmp    801076d7 <alltraps>

80107f36 <vector83>:
.globl vector83
vector83:
  pushl $0
80107f36:	6a 00                	push   $0x0
  pushl $83
80107f38:	6a 53                	push   $0x53
  jmp alltraps
80107f3a:	e9 98 f7 ff ff       	jmp    801076d7 <alltraps>

80107f3f <vector84>:
.globl vector84
vector84:
  pushl $0
80107f3f:	6a 00                	push   $0x0
  pushl $84
80107f41:	6a 54                	push   $0x54
  jmp alltraps
80107f43:	e9 8f f7 ff ff       	jmp    801076d7 <alltraps>

80107f48 <vector85>:
.globl vector85
vector85:
  pushl $0
80107f48:	6a 00                	push   $0x0
  pushl $85
80107f4a:	6a 55                	push   $0x55
  jmp alltraps
80107f4c:	e9 86 f7 ff ff       	jmp    801076d7 <alltraps>

80107f51 <vector86>:
.globl vector86
vector86:
  pushl $0
80107f51:	6a 00                	push   $0x0
  pushl $86
80107f53:	6a 56                	push   $0x56
  jmp alltraps
80107f55:	e9 7d f7 ff ff       	jmp    801076d7 <alltraps>

80107f5a <vector87>:
.globl vector87
vector87:
  pushl $0
80107f5a:	6a 00                	push   $0x0
  pushl $87
80107f5c:	6a 57                	push   $0x57
  jmp alltraps
80107f5e:	e9 74 f7 ff ff       	jmp    801076d7 <alltraps>

80107f63 <vector88>:
.globl vector88
vector88:
  pushl $0
80107f63:	6a 00                	push   $0x0
  pushl $88
80107f65:	6a 58                	push   $0x58
  jmp alltraps
80107f67:	e9 6b f7 ff ff       	jmp    801076d7 <alltraps>

80107f6c <vector89>:
.globl vector89
vector89:
  pushl $0
80107f6c:	6a 00                	push   $0x0
  pushl $89
80107f6e:	6a 59                	push   $0x59
  jmp alltraps
80107f70:	e9 62 f7 ff ff       	jmp    801076d7 <alltraps>

80107f75 <vector90>:
.globl vector90
vector90:
  pushl $0
80107f75:	6a 00                	push   $0x0
  pushl $90
80107f77:	6a 5a                	push   $0x5a
  jmp alltraps
80107f79:	e9 59 f7 ff ff       	jmp    801076d7 <alltraps>

80107f7e <vector91>:
.globl vector91
vector91:
  pushl $0
80107f7e:	6a 00                	push   $0x0
  pushl $91
80107f80:	6a 5b                	push   $0x5b
  jmp alltraps
80107f82:	e9 50 f7 ff ff       	jmp    801076d7 <alltraps>

80107f87 <vector92>:
.globl vector92
vector92:
  pushl $0
80107f87:	6a 00                	push   $0x0
  pushl $92
80107f89:	6a 5c                	push   $0x5c
  jmp alltraps
80107f8b:	e9 47 f7 ff ff       	jmp    801076d7 <alltraps>

80107f90 <vector93>:
.globl vector93
vector93:
  pushl $0
80107f90:	6a 00                	push   $0x0
  pushl $93
80107f92:	6a 5d                	push   $0x5d
  jmp alltraps
80107f94:	e9 3e f7 ff ff       	jmp    801076d7 <alltraps>

80107f99 <vector94>:
.globl vector94
vector94:
  pushl $0
80107f99:	6a 00                	push   $0x0
  pushl $94
80107f9b:	6a 5e                	push   $0x5e
  jmp alltraps
80107f9d:	e9 35 f7 ff ff       	jmp    801076d7 <alltraps>

80107fa2 <vector95>:
.globl vector95
vector95:
  pushl $0
80107fa2:	6a 00                	push   $0x0
  pushl $95
80107fa4:	6a 5f                	push   $0x5f
  jmp alltraps
80107fa6:	e9 2c f7 ff ff       	jmp    801076d7 <alltraps>

80107fab <vector96>:
.globl vector96
vector96:
  pushl $0
80107fab:	6a 00                	push   $0x0
  pushl $96
80107fad:	6a 60                	push   $0x60
  jmp alltraps
80107faf:	e9 23 f7 ff ff       	jmp    801076d7 <alltraps>

80107fb4 <vector97>:
.globl vector97
vector97:
  pushl $0
80107fb4:	6a 00                	push   $0x0
  pushl $97
80107fb6:	6a 61                	push   $0x61
  jmp alltraps
80107fb8:	e9 1a f7 ff ff       	jmp    801076d7 <alltraps>

80107fbd <vector98>:
.globl vector98
vector98:
  pushl $0
80107fbd:	6a 00                	push   $0x0
  pushl $98
80107fbf:	6a 62                	push   $0x62
  jmp alltraps
80107fc1:	e9 11 f7 ff ff       	jmp    801076d7 <alltraps>

80107fc6 <vector99>:
.globl vector99
vector99:
  pushl $0
80107fc6:	6a 00                	push   $0x0
  pushl $99
80107fc8:	6a 63                	push   $0x63
  jmp alltraps
80107fca:	e9 08 f7 ff ff       	jmp    801076d7 <alltraps>

80107fcf <vector100>:
.globl vector100
vector100:
  pushl $0
80107fcf:	6a 00                	push   $0x0
  pushl $100
80107fd1:	6a 64                	push   $0x64
  jmp alltraps
80107fd3:	e9 ff f6 ff ff       	jmp    801076d7 <alltraps>

80107fd8 <vector101>:
.globl vector101
vector101:
  pushl $0
80107fd8:	6a 00                	push   $0x0
  pushl $101
80107fda:	6a 65                	push   $0x65
  jmp alltraps
80107fdc:	e9 f6 f6 ff ff       	jmp    801076d7 <alltraps>

80107fe1 <vector102>:
.globl vector102
vector102:
  pushl $0
80107fe1:	6a 00                	push   $0x0
  pushl $102
80107fe3:	6a 66                	push   $0x66
  jmp alltraps
80107fe5:	e9 ed f6 ff ff       	jmp    801076d7 <alltraps>

80107fea <vector103>:
.globl vector103
vector103:
  pushl $0
80107fea:	6a 00                	push   $0x0
  pushl $103
80107fec:	6a 67                	push   $0x67
  jmp alltraps
80107fee:	e9 e4 f6 ff ff       	jmp    801076d7 <alltraps>

80107ff3 <vector104>:
.globl vector104
vector104:
  pushl $0
80107ff3:	6a 00                	push   $0x0
  pushl $104
80107ff5:	6a 68                	push   $0x68
  jmp alltraps
80107ff7:	e9 db f6 ff ff       	jmp    801076d7 <alltraps>

80107ffc <vector105>:
.globl vector105
vector105:
  pushl $0
80107ffc:	6a 00                	push   $0x0
  pushl $105
80107ffe:	6a 69                	push   $0x69
  jmp alltraps
80108000:	e9 d2 f6 ff ff       	jmp    801076d7 <alltraps>

80108005 <vector106>:
.globl vector106
vector106:
  pushl $0
80108005:	6a 00                	push   $0x0
  pushl $106
80108007:	6a 6a                	push   $0x6a
  jmp alltraps
80108009:	e9 c9 f6 ff ff       	jmp    801076d7 <alltraps>

8010800e <vector107>:
.globl vector107
vector107:
  pushl $0
8010800e:	6a 00                	push   $0x0
  pushl $107
80108010:	6a 6b                	push   $0x6b
  jmp alltraps
80108012:	e9 c0 f6 ff ff       	jmp    801076d7 <alltraps>

80108017 <vector108>:
.globl vector108
vector108:
  pushl $0
80108017:	6a 00                	push   $0x0
  pushl $108
80108019:	6a 6c                	push   $0x6c
  jmp alltraps
8010801b:	e9 b7 f6 ff ff       	jmp    801076d7 <alltraps>

80108020 <vector109>:
.globl vector109
vector109:
  pushl $0
80108020:	6a 00                	push   $0x0
  pushl $109
80108022:	6a 6d                	push   $0x6d
  jmp alltraps
80108024:	e9 ae f6 ff ff       	jmp    801076d7 <alltraps>

80108029 <vector110>:
.globl vector110
vector110:
  pushl $0
80108029:	6a 00                	push   $0x0
  pushl $110
8010802b:	6a 6e                	push   $0x6e
  jmp alltraps
8010802d:	e9 a5 f6 ff ff       	jmp    801076d7 <alltraps>

80108032 <vector111>:
.globl vector111
vector111:
  pushl $0
80108032:	6a 00                	push   $0x0
  pushl $111
80108034:	6a 6f                	push   $0x6f
  jmp alltraps
80108036:	e9 9c f6 ff ff       	jmp    801076d7 <alltraps>

8010803b <vector112>:
.globl vector112
vector112:
  pushl $0
8010803b:	6a 00                	push   $0x0
  pushl $112
8010803d:	6a 70                	push   $0x70
  jmp alltraps
8010803f:	e9 93 f6 ff ff       	jmp    801076d7 <alltraps>

80108044 <vector113>:
.globl vector113
vector113:
  pushl $0
80108044:	6a 00                	push   $0x0
  pushl $113
80108046:	6a 71                	push   $0x71
  jmp alltraps
80108048:	e9 8a f6 ff ff       	jmp    801076d7 <alltraps>

8010804d <vector114>:
.globl vector114
vector114:
  pushl $0
8010804d:	6a 00                	push   $0x0
  pushl $114
8010804f:	6a 72                	push   $0x72
  jmp alltraps
80108051:	e9 81 f6 ff ff       	jmp    801076d7 <alltraps>

80108056 <vector115>:
.globl vector115
vector115:
  pushl $0
80108056:	6a 00                	push   $0x0
  pushl $115
80108058:	6a 73                	push   $0x73
  jmp alltraps
8010805a:	e9 78 f6 ff ff       	jmp    801076d7 <alltraps>

8010805f <vector116>:
.globl vector116
vector116:
  pushl $0
8010805f:	6a 00                	push   $0x0
  pushl $116
80108061:	6a 74                	push   $0x74
  jmp alltraps
80108063:	e9 6f f6 ff ff       	jmp    801076d7 <alltraps>

80108068 <vector117>:
.globl vector117
vector117:
  pushl $0
80108068:	6a 00                	push   $0x0
  pushl $117
8010806a:	6a 75                	push   $0x75
  jmp alltraps
8010806c:	e9 66 f6 ff ff       	jmp    801076d7 <alltraps>

80108071 <vector118>:
.globl vector118
vector118:
  pushl $0
80108071:	6a 00                	push   $0x0
  pushl $118
80108073:	6a 76                	push   $0x76
  jmp alltraps
80108075:	e9 5d f6 ff ff       	jmp    801076d7 <alltraps>

8010807a <vector119>:
.globl vector119
vector119:
  pushl $0
8010807a:	6a 00                	push   $0x0
  pushl $119
8010807c:	6a 77                	push   $0x77
  jmp alltraps
8010807e:	e9 54 f6 ff ff       	jmp    801076d7 <alltraps>

80108083 <vector120>:
.globl vector120
vector120:
  pushl $0
80108083:	6a 00                	push   $0x0
  pushl $120
80108085:	6a 78                	push   $0x78
  jmp alltraps
80108087:	e9 4b f6 ff ff       	jmp    801076d7 <alltraps>

8010808c <vector121>:
.globl vector121
vector121:
  pushl $0
8010808c:	6a 00                	push   $0x0
  pushl $121
8010808e:	6a 79                	push   $0x79
  jmp alltraps
80108090:	e9 42 f6 ff ff       	jmp    801076d7 <alltraps>

80108095 <vector122>:
.globl vector122
vector122:
  pushl $0
80108095:	6a 00                	push   $0x0
  pushl $122
80108097:	6a 7a                	push   $0x7a
  jmp alltraps
80108099:	e9 39 f6 ff ff       	jmp    801076d7 <alltraps>

8010809e <vector123>:
.globl vector123
vector123:
  pushl $0
8010809e:	6a 00                	push   $0x0
  pushl $123
801080a0:	6a 7b                	push   $0x7b
  jmp alltraps
801080a2:	e9 30 f6 ff ff       	jmp    801076d7 <alltraps>

801080a7 <vector124>:
.globl vector124
vector124:
  pushl $0
801080a7:	6a 00                	push   $0x0
  pushl $124
801080a9:	6a 7c                	push   $0x7c
  jmp alltraps
801080ab:	e9 27 f6 ff ff       	jmp    801076d7 <alltraps>

801080b0 <vector125>:
.globl vector125
vector125:
  pushl $0
801080b0:	6a 00                	push   $0x0
  pushl $125
801080b2:	6a 7d                	push   $0x7d
  jmp alltraps
801080b4:	e9 1e f6 ff ff       	jmp    801076d7 <alltraps>

801080b9 <vector126>:
.globl vector126
vector126:
  pushl $0
801080b9:	6a 00                	push   $0x0
  pushl $126
801080bb:	6a 7e                	push   $0x7e
  jmp alltraps
801080bd:	e9 15 f6 ff ff       	jmp    801076d7 <alltraps>

801080c2 <vector127>:
.globl vector127
vector127:
  pushl $0
801080c2:	6a 00                	push   $0x0
  pushl $127
801080c4:	6a 7f                	push   $0x7f
  jmp alltraps
801080c6:	e9 0c f6 ff ff       	jmp    801076d7 <alltraps>

801080cb <vector128>:
.globl vector128
vector128:
  pushl $0
801080cb:	6a 00                	push   $0x0
  pushl $128
801080cd:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801080d2:	e9 00 f6 ff ff       	jmp    801076d7 <alltraps>

801080d7 <vector129>:
.globl vector129
vector129:
  pushl $0
801080d7:	6a 00                	push   $0x0
  pushl $129
801080d9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801080de:	e9 f4 f5 ff ff       	jmp    801076d7 <alltraps>

801080e3 <vector130>:
.globl vector130
vector130:
  pushl $0
801080e3:	6a 00                	push   $0x0
  pushl $130
801080e5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801080ea:	e9 e8 f5 ff ff       	jmp    801076d7 <alltraps>

801080ef <vector131>:
.globl vector131
vector131:
  pushl $0
801080ef:	6a 00                	push   $0x0
  pushl $131
801080f1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801080f6:	e9 dc f5 ff ff       	jmp    801076d7 <alltraps>

801080fb <vector132>:
.globl vector132
vector132:
  pushl $0
801080fb:	6a 00                	push   $0x0
  pushl $132
801080fd:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80108102:	e9 d0 f5 ff ff       	jmp    801076d7 <alltraps>

80108107 <vector133>:
.globl vector133
vector133:
  pushl $0
80108107:	6a 00                	push   $0x0
  pushl $133
80108109:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010810e:	e9 c4 f5 ff ff       	jmp    801076d7 <alltraps>

80108113 <vector134>:
.globl vector134
vector134:
  pushl $0
80108113:	6a 00                	push   $0x0
  pushl $134
80108115:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010811a:	e9 b8 f5 ff ff       	jmp    801076d7 <alltraps>

8010811f <vector135>:
.globl vector135
vector135:
  pushl $0
8010811f:	6a 00                	push   $0x0
  pushl $135
80108121:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80108126:	e9 ac f5 ff ff       	jmp    801076d7 <alltraps>

8010812b <vector136>:
.globl vector136
vector136:
  pushl $0
8010812b:	6a 00                	push   $0x0
  pushl $136
8010812d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80108132:	e9 a0 f5 ff ff       	jmp    801076d7 <alltraps>

80108137 <vector137>:
.globl vector137
vector137:
  pushl $0
80108137:	6a 00                	push   $0x0
  pushl $137
80108139:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010813e:	e9 94 f5 ff ff       	jmp    801076d7 <alltraps>

80108143 <vector138>:
.globl vector138
vector138:
  pushl $0
80108143:	6a 00                	push   $0x0
  pushl $138
80108145:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
8010814a:	e9 88 f5 ff ff       	jmp    801076d7 <alltraps>

8010814f <vector139>:
.globl vector139
vector139:
  pushl $0
8010814f:	6a 00                	push   $0x0
  pushl $139
80108151:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80108156:	e9 7c f5 ff ff       	jmp    801076d7 <alltraps>

8010815b <vector140>:
.globl vector140
vector140:
  pushl $0
8010815b:	6a 00                	push   $0x0
  pushl $140
8010815d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80108162:	e9 70 f5 ff ff       	jmp    801076d7 <alltraps>

80108167 <vector141>:
.globl vector141
vector141:
  pushl $0
80108167:	6a 00                	push   $0x0
  pushl $141
80108169:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010816e:	e9 64 f5 ff ff       	jmp    801076d7 <alltraps>

80108173 <vector142>:
.globl vector142
vector142:
  pushl $0
80108173:	6a 00                	push   $0x0
  pushl $142
80108175:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
8010817a:	e9 58 f5 ff ff       	jmp    801076d7 <alltraps>

8010817f <vector143>:
.globl vector143
vector143:
  pushl $0
8010817f:	6a 00                	push   $0x0
  pushl $143
80108181:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80108186:	e9 4c f5 ff ff       	jmp    801076d7 <alltraps>

8010818b <vector144>:
.globl vector144
vector144:
  pushl $0
8010818b:	6a 00                	push   $0x0
  pushl $144
8010818d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80108192:	e9 40 f5 ff ff       	jmp    801076d7 <alltraps>

80108197 <vector145>:
.globl vector145
vector145:
  pushl $0
80108197:	6a 00                	push   $0x0
  pushl $145
80108199:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010819e:	e9 34 f5 ff ff       	jmp    801076d7 <alltraps>

801081a3 <vector146>:
.globl vector146
vector146:
  pushl $0
801081a3:	6a 00                	push   $0x0
  pushl $146
801081a5:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801081aa:	e9 28 f5 ff ff       	jmp    801076d7 <alltraps>

801081af <vector147>:
.globl vector147
vector147:
  pushl $0
801081af:	6a 00                	push   $0x0
  pushl $147
801081b1:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801081b6:	e9 1c f5 ff ff       	jmp    801076d7 <alltraps>

801081bb <vector148>:
.globl vector148
vector148:
  pushl $0
801081bb:	6a 00                	push   $0x0
  pushl $148
801081bd:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801081c2:	e9 10 f5 ff ff       	jmp    801076d7 <alltraps>

801081c7 <vector149>:
.globl vector149
vector149:
  pushl $0
801081c7:	6a 00                	push   $0x0
  pushl $149
801081c9:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801081ce:	e9 04 f5 ff ff       	jmp    801076d7 <alltraps>

801081d3 <vector150>:
.globl vector150
vector150:
  pushl $0
801081d3:	6a 00                	push   $0x0
  pushl $150
801081d5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801081da:	e9 f8 f4 ff ff       	jmp    801076d7 <alltraps>

801081df <vector151>:
.globl vector151
vector151:
  pushl $0
801081df:	6a 00                	push   $0x0
  pushl $151
801081e1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801081e6:	e9 ec f4 ff ff       	jmp    801076d7 <alltraps>

801081eb <vector152>:
.globl vector152
vector152:
  pushl $0
801081eb:	6a 00                	push   $0x0
  pushl $152
801081ed:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801081f2:	e9 e0 f4 ff ff       	jmp    801076d7 <alltraps>

801081f7 <vector153>:
.globl vector153
vector153:
  pushl $0
801081f7:	6a 00                	push   $0x0
  pushl $153
801081f9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801081fe:	e9 d4 f4 ff ff       	jmp    801076d7 <alltraps>

80108203 <vector154>:
.globl vector154
vector154:
  pushl $0
80108203:	6a 00                	push   $0x0
  pushl $154
80108205:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010820a:	e9 c8 f4 ff ff       	jmp    801076d7 <alltraps>

8010820f <vector155>:
.globl vector155
vector155:
  pushl $0
8010820f:	6a 00                	push   $0x0
  pushl $155
80108211:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80108216:	e9 bc f4 ff ff       	jmp    801076d7 <alltraps>

8010821b <vector156>:
.globl vector156
vector156:
  pushl $0
8010821b:	6a 00                	push   $0x0
  pushl $156
8010821d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80108222:	e9 b0 f4 ff ff       	jmp    801076d7 <alltraps>

80108227 <vector157>:
.globl vector157
vector157:
  pushl $0
80108227:	6a 00                	push   $0x0
  pushl $157
80108229:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010822e:	e9 a4 f4 ff ff       	jmp    801076d7 <alltraps>

80108233 <vector158>:
.globl vector158
vector158:
  pushl $0
80108233:	6a 00                	push   $0x0
  pushl $158
80108235:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
8010823a:	e9 98 f4 ff ff       	jmp    801076d7 <alltraps>

8010823f <vector159>:
.globl vector159
vector159:
  pushl $0
8010823f:	6a 00                	push   $0x0
  pushl $159
80108241:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80108246:	e9 8c f4 ff ff       	jmp    801076d7 <alltraps>

8010824b <vector160>:
.globl vector160
vector160:
  pushl $0
8010824b:	6a 00                	push   $0x0
  pushl $160
8010824d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80108252:	e9 80 f4 ff ff       	jmp    801076d7 <alltraps>

80108257 <vector161>:
.globl vector161
vector161:
  pushl $0
80108257:	6a 00                	push   $0x0
  pushl $161
80108259:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010825e:	e9 74 f4 ff ff       	jmp    801076d7 <alltraps>

80108263 <vector162>:
.globl vector162
vector162:
  pushl $0
80108263:	6a 00                	push   $0x0
  pushl $162
80108265:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
8010826a:	e9 68 f4 ff ff       	jmp    801076d7 <alltraps>

8010826f <vector163>:
.globl vector163
vector163:
  pushl $0
8010826f:	6a 00                	push   $0x0
  pushl $163
80108271:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80108276:	e9 5c f4 ff ff       	jmp    801076d7 <alltraps>

8010827b <vector164>:
.globl vector164
vector164:
  pushl $0
8010827b:	6a 00                	push   $0x0
  pushl $164
8010827d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80108282:	e9 50 f4 ff ff       	jmp    801076d7 <alltraps>

80108287 <vector165>:
.globl vector165
vector165:
  pushl $0
80108287:	6a 00                	push   $0x0
  pushl $165
80108289:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010828e:	e9 44 f4 ff ff       	jmp    801076d7 <alltraps>

80108293 <vector166>:
.globl vector166
vector166:
  pushl $0
80108293:	6a 00                	push   $0x0
  pushl $166
80108295:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010829a:	e9 38 f4 ff ff       	jmp    801076d7 <alltraps>

8010829f <vector167>:
.globl vector167
vector167:
  pushl $0
8010829f:	6a 00                	push   $0x0
  pushl $167
801082a1:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801082a6:	e9 2c f4 ff ff       	jmp    801076d7 <alltraps>

801082ab <vector168>:
.globl vector168
vector168:
  pushl $0
801082ab:	6a 00                	push   $0x0
  pushl $168
801082ad:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801082b2:	e9 20 f4 ff ff       	jmp    801076d7 <alltraps>

801082b7 <vector169>:
.globl vector169
vector169:
  pushl $0
801082b7:	6a 00                	push   $0x0
  pushl $169
801082b9:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801082be:	e9 14 f4 ff ff       	jmp    801076d7 <alltraps>

801082c3 <vector170>:
.globl vector170
vector170:
  pushl $0
801082c3:	6a 00                	push   $0x0
  pushl $170
801082c5:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801082ca:	e9 08 f4 ff ff       	jmp    801076d7 <alltraps>

801082cf <vector171>:
.globl vector171
vector171:
  pushl $0
801082cf:	6a 00                	push   $0x0
  pushl $171
801082d1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801082d6:	e9 fc f3 ff ff       	jmp    801076d7 <alltraps>

801082db <vector172>:
.globl vector172
vector172:
  pushl $0
801082db:	6a 00                	push   $0x0
  pushl $172
801082dd:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801082e2:	e9 f0 f3 ff ff       	jmp    801076d7 <alltraps>

801082e7 <vector173>:
.globl vector173
vector173:
  pushl $0
801082e7:	6a 00                	push   $0x0
  pushl $173
801082e9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801082ee:	e9 e4 f3 ff ff       	jmp    801076d7 <alltraps>

801082f3 <vector174>:
.globl vector174
vector174:
  pushl $0
801082f3:	6a 00                	push   $0x0
  pushl $174
801082f5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801082fa:	e9 d8 f3 ff ff       	jmp    801076d7 <alltraps>

801082ff <vector175>:
.globl vector175
vector175:
  pushl $0
801082ff:	6a 00                	push   $0x0
  pushl $175
80108301:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108306:	e9 cc f3 ff ff       	jmp    801076d7 <alltraps>

8010830b <vector176>:
.globl vector176
vector176:
  pushl $0
8010830b:	6a 00                	push   $0x0
  pushl $176
8010830d:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80108312:	e9 c0 f3 ff ff       	jmp    801076d7 <alltraps>

80108317 <vector177>:
.globl vector177
vector177:
  pushl $0
80108317:	6a 00                	push   $0x0
  pushl $177
80108319:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010831e:	e9 b4 f3 ff ff       	jmp    801076d7 <alltraps>

80108323 <vector178>:
.globl vector178
vector178:
  pushl $0
80108323:	6a 00                	push   $0x0
  pushl $178
80108325:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010832a:	e9 a8 f3 ff ff       	jmp    801076d7 <alltraps>

8010832f <vector179>:
.globl vector179
vector179:
  pushl $0
8010832f:	6a 00                	push   $0x0
  pushl $179
80108331:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80108336:	e9 9c f3 ff ff       	jmp    801076d7 <alltraps>

8010833b <vector180>:
.globl vector180
vector180:
  pushl $0
8010833b:	6a 00                	push   $0x0
  pushl $180
8010833d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80108342:	e9 90 f3 ff ff       	jmp    801076d7 <alltraps>

80108347 <vector181>:
.globl vector181
vector181:
  pushl $0
80108347:	6a 00                	push   $0x0
  pushl $181
80108349:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010834e:	e9 84 f3 ff ff       	jmp    801076d7 <alltraps>

80108353 <vector182>:
.globl vector182
vector182:
  pushl $0
80108353:	6a 00                	push   $0x0
  pushl $182
80108355:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
8010835a:	e9 78 f3 ff ff       	jmp    801076d7 <alltraps>

8010835f <vector183>:
.globl vector183
vector183:
  pushl $0
8010835f:	6a 00                	push   $0x0
  pushl $183
80108361:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80108366:	e9 6c f3 ff ff       	jmp    801076d7 <alltraps>

8010836b <vector184>:
.globl vector184
vector184:
  pushl $0
8010836b:	6a 00                	push   $0x0
  pushl $184
8010836d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80108372:	e9 60 f3 ff ff       	jmp    801076d7 <alltraps>

80108377 <vector185>:
.globl vector185
vector185:
  pushl $0
80108377:	6a 00                	push   $0x0
  pushl $185
80108379:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010837e:	e9 54 f3 ff ff       	jmp    801076d7 <alltraps>

80108383 <vector186>:
.globl vector186
vector186:
  pushl $0
80108383:	6a 00                	push   $0x0
  pushl $186
80108385:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010838a:	e9 48 f3 ff ff       	jmp    801076d7 <alltraps>

8010838f <vector187>:
.globl vector187
vector187:
  pushl $0
8010838f:	6a 00                	push   $0x0
  pushl $187
80108391:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108396:	e9 3c f3 ff ff       	jmp    801076d7 <alltraps>

8010839b <vector188>:
.globl vector188
vector188:
  pushl $0
8010839b:	6a 00                	push   $0x0
  pushl $188
8010839d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801083a2:	e9 30 f3 ff ff       	jmp    801076d7 <alltraps>

801083a7 <vector189>:
.globl vector189
vector189:
  pushl $0
801083a7:	6a 00                	push   $0x0
  pushl $189
801083a9:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801083ae:	e9 24 f3 ff ff       	jmp    801076d7 <alltraps>

801083b3 <vector190>:
.globl vector190
vector190:
  pushl $0
801083b3:	6a 00                	push   $0x0
  pushl $190
801083b5:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801083ba:	e9 18 f3 ff ff       	jmp    801076d7 <alltraps>

801083bf <vector191>:
.globl vector191
vector191:
  pushl $0
801083bf:	6a 00                	push   $0x0
  pushl $191
801083c1:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801083c6:	e9 0c f3 ff ff       	jmp    801076d7 <alltraps>

801083cb <vector192>:
.globl vector192
vector192:
  pushl $0
801083cb:	6a 00                	push   $0x0
  pushl $192
801083cd:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801083d2:	e9 00 f3 ff ff       	jmp    801076d7 <alltraps>

801083d7 <vector193>:
.globl vector193
vector193:
  pushl $0
801083d7:	6a 00                	push   $0x0
  pushl $193
801083d9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801083de:	e9 f4 f2 ff ff       	jmp    801076d7 <alltraps>

801083e3 <vector194>:
.globl vector194
vector194:
  pushl $0
801083e3:	6a 00                	push   $0x0
  pushl $194
801083e5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801083ea:	e9 e8 f2 ff ff       	jmp    801076d7 <alltraps>

801083ef <vector195>:
.globl vector195
vector195:
  pushl $0
801083ef:	6a 00                	push   $0x0
  pushl $195
801083f1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801083f6:	e9 dc f2 ff ff       	jmp    801076d7 <alltraps>

801083fb <vector196>:
.globl vector196
vector196:
  pushl $0
801083fb:	6a 00                	push   $0x0
  pushl $196
801083fd:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80108402:	e9 d0 f2 ff ff       	jmp    801076d7 <alltraps>

80108407 <vector197>:
.globl vector197
vector197:
  pushl $0
80108407:	6a 00                	push   $0x0
  pushl $197
80108409:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010840e:	e9 c4 f2 ff ff       	jmp    801076d7 <alltraps>

80108413 <vector198>:
.globl vector198
vector198:
  pushl $0
80108413:	6a 00                	push   $0x0
  pushl $198
80108415:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010841a:	e9 b8 f2 ff ff       	jmp    801076d7 <alltraps>

8010841f <vector199>:
.globl vector199
vector199:
  pushl $0
8010841f:	6a 00                	push   $0x0
  pushl $199
80108421:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80108426:	e9 ac f2 ff ff       	jmp    801076d7 <alltraps>

8010842b <vector200>:
.globl vector200
vector200:
  pushl $0
8010842b:	6a 00                	push   $0x0
  pushl $200
8010842d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80108432:	e9 a0 f2 ff ff       	jmp    801076d7 <alltraps>

80108437 <vector201>:
.globl vector201
vector201:
  pushl $0
80108437:	6a 00                	push   $0x0
  pushl $201
80108439:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010843e:	e9 94 f2 ff ff       	jmp    801076d7 <alltraps>

80108443 <vector202>:
.globl vector202
vector202:
  pushl $0
80108443:	6a 00                	push   $0x0
  pushl $202
80108445:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
8010844a:	e9 88 f2 ff ff       	jmp    801076d7 <alltraps>

8010844f <vector203>:
.globl vector203
vector203:
  pushl $0
8010844f:	6a 00                	push   $0x0
  pushl $203
80108451:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108456:	e9 7c f2 ff ff       	jmp    801076d7 <alltraps>

8010845b <vector204>:
.globl vector204
vector204:
  pushl $0
8010845b:	6a 00                	push   $0x0
  pushl $204
8010845d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80108462:	e9 70 f2 ff ff       	jmp    801076d7 <alltraps>

80108467 <vector205>:
.globl vector205
vector205:
  pushl $0
80108467:	6a 00                	push   $0x0
  pushl $205
80108469:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010846e:	e9 64 f2 ff ff       	jmp    801076d7 <alltraps>

80108473 <vector206>:
.globl vector206
vector206:
  pushl $0
80108473:	6a 00                	push   $0x0
  pushl $206
80108475:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
8010847a:	e9 58 f2 ff ff       	jmp    801076d7 <alltraps>

8010847f <vector207>:
.globl vector207
vector207:
  pushl $0
8010847f:	6a 00                	push   $0x0
  pushl $207
80108481:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108486:	e9 4c f2 ff ff       	jmp    801076d7 <alltraps>

8010848b <vector208>:
.globl vector208
vector208:
  pushl $0
8010848b:	6a 00                	push   $0x0
  pushl $208
8010848d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80108492:	e9 40 f2 ff ff       	jmp    801076d7 <alltraps>

80108497 <vector209>:
.globl vector209
vector209:
  pushl $0
80108497:	6a 00                	push   $0x0
  pushl $209
80108499:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010849e:	e9 34 f2 ff ff       	jmp    801076d7 <alltraps>

801084a3 <vector210>:
.globl vector210
vector210:
  pushl $0
801084a3:	6a 00                	push   $0x0
  pushl $210
801084a5:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801084aa:	e9 28 f2 ff ff       	jmp    801076d7 <alltraps>

801084af <vector211>:
.globl vector211
vector211:
  pushl $0
801084af:	6a 00                	push   $0x0
  pushl $211
801084b1:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801084b6:	e9 1c f2 ff ff       	jmp    801076d7 <alltraps>

801084bb <vector212>:
.globl vector212
vector212:
  pushl $0
801084bb:	6a 00                	push   $0x0
  pushl $212
801084bd:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801084c2:	e9 10 f2 ff ff       	jmp    801076d7 <alltraps>

801084c7 <vector213>:
.globl vector213
vector213:
  pushl $0
801084c7:	6a 00                	push   $0x0
  pushl $213
801084c9:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801084ce:	e9 04 f2 ff ff       	jmp    801076d7 <alltraps>

801084d3 <vector214>:
.globl vector214
vector214:
  pushl $0
801084d3:	6a 00                	push   $0x0
  pushl $214
801084d5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801084da:	e9 f8 f1 ff ff       	jmp    801076d7 <alltraps>

801084df <vector215>:
.globl vector215
vector215:
  pushl $0
801084df:	6a 00                	push   $0x0
  pushl $215
801084e1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801084e6:	e9 ec f1 ff ff       	jmp    801076d7 <alltraps>

801084eb <vector216>:
.globl vector216
vector216:
  pushl $0
801084eb:	6a 00                	push   $0x0
  pushl $216
801084ed:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801084f2:	e9 e0 f1 ff ff       	jmp    801076d7 <alltraps>

801084f7 <vector217>:
.globl vector217
vector217:
  pushl $0
801084f7:	6a 00                	push   $0x0
  pushl $217
801084f9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801084fe:	e9 d4 f1 ff ff       	jmp    801076d7 <alltraps>

80108503 <vector218>:
.globl vector218
vector218:
  pushl $0
80108503:	6a 00                	push   $0x0
  pushl $218
80108505:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010850a:	e9 c8 f1 ff ff       	jmp    801076d7 <alltraps>

8010850f <vector219>:
.globl vector219
vector219:
  pushl $0
8010850f:	6a 00                	push   $0x0
  pushl $219
80108511:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80108516:	e9 bc f1 ff ff       	jmp    801076d7 <alltraps>

8010851b <vector220>:
.globl vector220
vector220:
  pushl $0
8010851b:	6a 00                	push   $0x0
  pushl $220
8010851d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80108522:	e9 b0 f1 ff ff       	jmp    801076d7 <alltraps>

80108527 <vector221>:
.globl vector221
vector221:
  pushl $0
80108527:	6a 00                	push   $0x0
  pushl $221
80108529:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010852e:	e9 a4 f1 ff ff       	jmp    801076d7 <alltraps>

80108533 <vector222>:
.globl vector222
vector222:
  pushl $0
80108533:	6a 00                	push   $0x0
  pushl $222
80108535:	68 de 00 00 00       	push   $0xde
  jmp alltraps
8010853a:	e9 98 f1 ff ff       	jmp    801076d7 <alltraps>

8010853f <vector223>:
.globl vector223
vector223:
  pushl $0
8010853f:	6a 00                	push   $0x0
  pushl $223
80108541:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80108546:	e9 8c f1 ff ff       	jmp    801076d7 <alltraps>

8010854b <vector224>:
.globl vector224
vector224:
  pushl $0
8010854b:	6a 00                	push   $0x0
  pushl $224
8010854d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80108552:	e9 80 f1 ff ff       	jmp    801076d7 <alltraps>

80108557 <vector225>:
.globl vector225
vector225:
  pushl $0
80108557:	6a 00                	push   $0x0
  pushl $225
80108559:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010855e:	e9 74 f1 ff ff       	jmp    801076d7 <alltraps>

80108563 <vector226>:
.globl vector226
vector226:
  pushl $0
80108563:	6a 00                	push   $0x0
  pushl $226
80108565:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
8010856a:	e9 68 f1 ff ff       	jmp    801076d7 <alltraps>

8010856f <vector227>:
.globl vector227
vector227:
  pushl $0
8010856f:	6a 00                	push   $0x0
  pushl $227
80108571:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108576:	e9 5c f1 ff ff       	jmp    801076d7 <alltraps>

8010857b <vector228>:
.globl vector228
vector228:
  pushl $0
8010857b:	6a 00                	push   $0x0
  pushl $228
8010857d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80108582:	e9 50 f1 ff ff       	jmp    801076d7 <alltraps>

80108587 <vector229>:
.globl vector229
vector229:
  pushl $0
80108587:	6a 00                	push   $0x0
  pushl $229
80108589:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010858e:	e9 44 f1 ff ff       	jmp    801076d7 <alltraps>

80108593 <vector230>:
.globl vector230
vector230:
  pushl $0
80108593:	6a 00                	push   $0x0
  pushl $230
80108595:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010859a:	e9 38 f1 ff ff       	jmp    801076d7 <alltraps>

8010859f <vector231>:
.globl vector231
vector231:
  pushl $0
8010859f:	6a 00                	push   $0x0
  pushl $231
801085a1:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801085a6:	e9 2c f1 ff ff       	jmp    801076d7 <alltraps>

801085ab <vector232>:
.globl vector232
vector232:
  pushl $0
801085ab:	6a 00                	push   $0x0
  pushl $232
801085ad:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801085b2:	e9 20 f1 ff ff       	jmp    801076d7 <alltraps>

801085b7 <vector233>:
.globl vector233
vector233:
  pushl $0
801085b7:	6a 00                	push   $0x0
  pushl $233
801085b9:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801085be:	e9 14 f1 ff ff       	jmp    801076d7 <alltraps>

801085c3 <vector234>:
.globl vector234
vector234:
  pushl $0
801085c3:	6a 00                	push   $0x0
  pushl $234
801085c5:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801085ca:	e9 08 f1 ff ff       	jmp    801076d7 <alltraps>

801085cf <vector235>:
.globl vector235
vector235:
  pushl $0
801085cf:	6a 00                	push   $0x0
  pushl $235
801085d1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801085d6:	e9 fc f0 ff ff       	jmp    801076d7 <alltraps>

801085db <vector236>:
.globl vector236
vector236:
  pushl $0
801085db:	6a 00                	push   $0x0
  pushl $236
801085dd:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801085e2:	e9 f0 f0 ff ff       	jmp    801076d7 <alltraps>

801085e7 <vector237>:
.globl vector237
vector237:
  pushl $0
801085e7:	6a 00                	push   $0x0
  pushl $237
801085e9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801085ee:	e9 e4 f0 ff ff       	jmp    801076d7 <alltraps>

801085f3 <vector238>:
.globl vector238
vector238:
  pushl $0
801085f3:	6a 00                	push   $0x0
  pushl $238
801085f5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801085fa:	e9 d8 f0 ff ff       	jmp    801076d7 <alltraps>

801085ff <vector239>:
.globl vector239
vector239:
  pushl $0
801085ff:	6a 00                	push   $0x0
  pushl $239
80108601:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108606:	e9 cc f0 ff ff       	jmp    801076d7 <alltraps>

8010860b <vector240>:
.globl vector240
vector240:
  pushl $0
8010860b:	6a 00                	push   $0x0
  pushl $240
8010860d:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80108612:	e9 c0 f0 ff ff       	jmp    801076d7 <alltraps>

80108617 <vector241>:
.globl vector241
vector241:
  pushl $0
80108617:	6a 00                	push   $0x0
  pushl $241
80108619:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010861e:	e9 b4 f0 ff ff       	jmp    801076d7 <alltraps>

80108623 <vector242>:
.globl vector242
vector242:
  pushl $0
80108623:	6a 00                	push   $0x0
  pushl $242
80108625:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
8010862a:	e9 a8 f0 ff ff       	jmp    801076d7 <alltraps>

8010862f <vector243>:
.globl vector243
vector243:
  pushl $0
8010862f:	6a 00                	push   $0x0
  pushl $243
80108631:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80108636:	e9 9c f0 ff ff       	jmp    801076d7 <alltraps>

8010863b <vector244>:
.globl vector244
vector244:
  pushl $0
8010863b:	6a 00                	push   $0x0
  pushl $244
8010863d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80108642:	e9 90 f0 ff ff       	jmp    801076d7 <alltraps>

80108647 <vector245>:
.globl vector245
vector245:
  pushl $0
80108647:	6a 00                	push   $0x0
  pushl $245
80108649:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010864e:	e9 84 f0 ff ff       	jmp    801076d7 <alltraps>

80108653 <vector246>:
.globl vector246
vector246:
  pushl $0
80108653:	6a 00                	push   $0x0
  pushl $246
80108655:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
8010865a:	e9 78 f0 ff ff       	jmp    801076d7 <alltraps>

8010865f <vector247>:
.globl vector247
vector247:
  pushl $0
8010865f:	6a 00                	push   $0x0
  pushl $247
80108661:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108666:	e9 6c f0 ff ff       	jmp    801076d7 <alltraps>

8010866b <vector248>:
.globl vector248
vector248:
  pushl $0
8010866b:	6a 00                	push   $0x0
  pushl $248
8010866d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80108672:	e9 60 f0 ff ff       	jmp    801076d7 <alltraps>

80108677 <vector249>:
.globl vector249
vector249:
  pushl $0
80108677:	6a 00                	push   $0x0
  pushl $249
80108679:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010867e:	e9 54 f0 ff ff       	jmp    801076d7 <alltraps>

80108683 <vector250>:
.globl vector250
vector250:
  pushl $0
80108683:	6a 00                	push   $0x0
  pushl $250
80108685:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
8010868a:	e9 48 f0 ff ff       	jmp    801076d7 <alltraps>

8010868f <vector251>:
.globl vector251
vector251:
  pushl $0
8010868f:	6a 00                	push   $0x0
  pushl $251
80108691:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108696:	e9 3c f0 ff ff       	jmp    801076d7 <alltraps>

8010869b <vector252>:
.globl vector252
vector252:
  pushl $0
8010869b:	6a 00                	push   $0x0
  pushl $252
8010869d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801086a2:	e9 30 f0 ff ff       	jmp    801076d7 <alltraps>

801086a7 <vector253>:
.globl vector253
vector253:
  pushl $0
801086a7:	6a 00                	push   $0x0
  pushl $253
801086a9:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801086ae:	e9 24 f0 ff ff       	jmp    801076d7 <alltraps>

801086b3 <vector254>:
.globl vector254
vector254:
  pushl $0
801086b3:	6a 00                	push   $0x0
  pushl $254
801086b5:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801086ba:	e9 18 f0 ff ff       	jmp    801076d7 <alltraps>

801086bf <vector255>:
.globl vector255
vector255:
  pushl $0
801086bf:	6a 00                	push   $0x0
  pushl $255
801086c1:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801086c6:	e9 0c f0 ff ff       	jmp    801076d7 <alltraps>
801086cb:	66 90                	xchg   %ax,%ax
801086cd:	66 90                	xchg   %ax,%ax
801086cf:	90                   	nop

801086d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801086d0:	55                   	push   %ebp
801086d1:	89 e5                	mov    %esp,%ebp
801086d3:	57                   	push   %edi
801086d4:	56                   	push   %esi
801086d5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801086d7:	c1 ea 16             	shr    $0x16,%edx
{
801086da:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801086db:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801086de:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801086e1:	8b 1f                	mov    (%edi),%ebx
801086e3:	f6 c3 01             	test   $0x1,%bl
801086e6:	74 28                	je     80108710 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801086e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801086ee:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801086f4:	89 f0                	mov    %esi,%eax
}
801086f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801086f9:	c1 e8 0a             	shr    $0xa,%eax
801086fc:	25 fc 0f 00 00       	and    $0xffc,%eax
80108701:	01 d8                	add    %ebx,%eax
}
80108703:	5b                   	pop    %ebx
80108704:	5e                   	pop    %esi
80108705:	5f                   	pop    %edi
80108706:	5d                   	pop    %ebp
80108707:	c3                   	ret    
80108708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010870f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108710:	85 c9                	test   %ecx,%ecx
80108712:	74 2c                	je     80108740 <walkpgdir+0x70>
80108714:	e8 87 a4 ff ff       	call   80102ba0 <kalloc>
80108719:	89 c3                	mov    %eax,%ebx
8010871b:	85 c0                	test   %eax,%eax
8010871d:	74 21                	je     80108740 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010871f:	83 ec 04             	sub    $0x4,%esp
80108722:	68 00 10 00 00       	push   $0x1000
80108727:	6a 00                	push   $0x0
80108729:	50                   	push   %eax
8010872a:	e8 81 d7 ff ff       	call   80105eb0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010872f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108735:	83 c4 10             	add    $0x10,%esp
80108738:	83 c8 07             	or     $0x7,%eax
8010873b:	89 07                	mov    %eax,(%edi)
8010873d:	eb b5                	jmp    801086f4 <walkpgdir+0x24>
8010873f:	90                   	nop
}
80108740:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80108743:	31 c0                	xor    %eax,%eax
}
80108745:	5b                   	pop    %ebx
80108746:	5e                   	pop    %esi
80108747:	5f                   	pop    %edi
80108748:	5d                   	pop    %ebp
80108749:	c3                   	ret    
8010874a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108750 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108750:	55                   	push   %ebp
80108751:	89 e5                	mov    %esp,%ebp
80108753:	57                   	push   %edi
80108754:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108756:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010875a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010875b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80108760:	89 d6                	mov    %edx,%esi
{
80108762:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80108763:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80108769:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010876c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010876f:	8b 45 08             	mov    0x8(%ebp),%eax
80108772:	29 f0                	sub    %esi,%eax
80108774:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108777:	eb 1f                	jmp    80108798 <mappages+0x48>
80108779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80108780:	f6 00 01             	testb  $0x1,(%eax)
80108783:	75 45                	jne    801087ca <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80108785:	0b 5d 0c             	or     0xc(%ebp),%ebx
80108788:	83 cb 01             	or     $0x1,%ebx
8010878b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010878d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80108790:	74 2e                	je     801087c0 <mappages+0x70>
      break;
    a += PGSIZE;
80108792:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80108798:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010879b:	b9 01 00 00 00       	mov    $0x1,%ecx
801087a0:	89 f2                	mov    %esi,%edx
801087a2:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
801087a5:	89 f8                	mov    %edi,%eax
801087a7:	e8 24 ff ff ff       	call   801086d0 <walkpgdir>
801087ac:	85 c0                	test   %eax,%eax
801087ae:	75 d0                	jne    80108780 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801087b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801087b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801087b8:	5b                   	pop    %ebx
801087b9:	5e                   	pop    %esi
801087ba:	5f                   	pop    %edi
801087bb:	5d                   	pop    %ebp
801087bc:	c3                   	ret    
801087bd:	8d 76 00             	lea    0x0(%esi),%esi
801087c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801087c3:	31 c0                	xor    %eax,%eax
}
801087c5:	5b                   	pop    %ebx
801087c6:	5e                   	pop    %esi
801087c7:	5f                   	pop    %edi
801087c8:	5d                   	pop    %ebp
801087c9:	c3                   	ret    
      panic("remap");
801087ca:	83 ec 0c             	sub    $0xc,%esp
801087cd:	68 5c a9 10 80       	push   $0x8010a95c
801087d2:	e8 b9 7b ff ff       	call   80100390 <panic>
801087d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801087de:	66 90                	xchg   %ax,%ax

801087e0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801087e0:	55                   	push   %ebp
801087e1:	89 e5                	mov    %esp,%ebp
801087e3:	57                   	push   %edi
801087e4:	56                   	push   %esi
801087e5:	89 c6                	mov    %eax,%esi
801087e7:	53                   	push   %ebx
801087e8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801087ea:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801087f0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801087f6:	83 ec 1c             	sub    $0x1c,%esp
801087f9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801087fc:	39 da                	cmp    %ebx,%edx
801087fe:	73 5b                	jae    8010885b <deallocuvm.part.0+0x7b>
80108800:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80108803:	89 d7                	mov    %edx,%edi
80108805:	eb 14                	jmp    8010881b <deallocuvm.part.0+0x3b>
80108807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010880e:	66 90                	xchg   %ax,%ax
80108810:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108816:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80108819:	76 40                	jbe    8010885b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010881b:	31 c9                	xor    %ecx,%ecx
8010881d:	89 fa                	mov    %edi,%edx
8010881f:	89 f0                	mov    %esi,%eax
80108821:	e8 aa fe ff ff       	call   801086d0 <walkpgdir>
80108826:	89 c3                	mov    %eax,%ebx
    if(!pte)
80108828:	85 c0                	test   %eax,%eax
8010882a:	74 44                	je     80108870 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010882c:	8b 00                	mov    (%eax),%eax
8010882e:	a8 01                	test   $0x1,%al
80108830:	74 de                	je     80108810 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80108832:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108837:	74 47                	je     80108880 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80108839:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010883c:	05 00 00 00 80       	add    $0x80000000,%eax
80108841:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80108847:	50                   	push   %eax
80108848:	e8 93 a1 ff ff       	call   801029e0 <kfree>
      *pte = 0;
8010884d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80108853:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80108856:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80108859:	77 c0                	ja     8010881b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010885b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010885e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108861:	5b                   	pop    %ebx
80108862:	5e                   	pop    %esi
80108863:	5f                   	pop    %edi
80108864:	5d                   	pop    %ebp
80108865:	c3                   	ret    
80108866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010886d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80108870:	89 fa                	mov    %edi,%edx
80108872:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80108878:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010887e:	eb 96                	jmp    80108816 <deallocuvm.part.0+0x36>
        panic("kfree");
80108880:	83 ec 0c             	sub    $0xc,%esp
80108883:	68 be 9f 10 80       	push   $0x80109fbe
80108888:	e8 03 7b ff ff       	call   80100390 <panic>
8010888d:	8d 76 00             	lea    0x0(%esi),%esi

80108890 <seginit>:
{
80108890:	f3 0f 1e fb          	endbr32 
80108894:	55                   	push   %ebp
80108895:	89 e5                	mov    %esp,%ebp
80108897:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010889a:	e8 b1 b6 ff ff       	call   80103f50 <cpuid>
  pd[0] = size-1;
8010889f:	ba 2f 00 00 00       	mov    $0x2f,%edx
801088a4:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
801088aa:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801088ae:	c7 80 18 5e 11 80 ff 	movl   $0xffff,-0x7feea1e8(%eax)
801088b5:	ff 00 00 
801088b8:	c7 80 1c 5e 11 80 00 	movl   $0xcf9a00,-0x7feea1e4(%eax)
801088bf:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801088c2:	c7 80 20 5e 11 80 ff 	movl   $0xffff,-0x7feea1e0(%eax)
801088c9:	ff 00 00 
801088cc:	c7 80 24 5e 11 80 00 	movl   $0xcf9200,-0x7feea1dc(%eax)
801088d3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801088d6:	c7 80 28 5e 11 80 ff 	movl   $0xffff,-0x7feea1d8(%eax)
801088dd:	ff 00 00 
801088e0:	c7 80 2c 5e 11 80 00 	movl   $0xcffa00,-0x7feea1d4(%eax)
801088e7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801088ea:	c7 80 30 5e 11 80 ff 	movl   $0xffff,-0x7feea1d0(%eax)
801088f1:	ff 00 00 
801088f4:	c7 80 34 5e 11 80 00 	movl   $0xcff200,-0x7feea1cc(%eax)
801088fb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801088fe:	05 10 5e 11 80       	add    $0x80115e10,%eax
  pd[1] = (uint)p;
80108903:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108907:	c1 e8 10             	shr    $0x10,%eax
8010890a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010890e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108911:	0f 01 10             	lgdtl  (%eax)
}
80108914:	c9                   	leave  
80108915:	c3                   	ret    
80108916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010891d:	8d 76 00             	lea    0x0(%esi),%esi

80108920 <switchkvm>:
{
80108920:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108924:	a1 00 d7 12 80       	mov    0x8012d700,%eax
80108929:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010892e:	0f 22 d8             	mov    %eax,%cr3
}
80108931:	c3                   	ret    
80108932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108940 <switchuvm>:
{
80108940:	f3 0f 1e fb          	endbr32 
80108944:	55                   	push   %ebp
80108945:	89 e5                	mov    %esp,%ebp
80108947:	57                   	push   %edi
80108948:	56                   	push   %esi
80108949:	53                   	push   %ebx
8010894a:	83 ec 1c             	sub    $0x1c,%esp
8010894d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80108950:	85 f6                	test   %esi,%esi
80108952:	0f 84 cb 00 00 00    	je     80108a23 <switchuvm+0xe3>
  if(p->kstack == 0)
80108958:	8b 46 08             	mov    0x8(%esi),%eax
8010895b:	85 c0                	test   %eax,%eax
8010895d:	0f 84 da 00 00 00    	je     80108a3d <switchuvm+0xfd>
  if(p->pgdir == 0)
80108963:	8b 46 04             	mov    0x4(%esi),%eax
80108966:	85 c0                	test   %eax,%eax
80108968:	0f 84 c2 00 00 00    	je     80108a30 <switchuvm+0xf0>
  pushcli();
8010896e:	e8 2d d3 ff ff       	call   80105ca0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108973:	e8 68 b5 ff ff       	call   80103ee0 <mycpu>
80108978:	89 c3                	mov    %eax,%ebx
8010897a:	e8 61 b5 ff ff       	call   80103ee0 <mycpu>
8010897f:	89 c7                	mov    %eax,%edi
80108981:	e8 5a b5 ff ff       	call   80103ee0 <mycpu>
80108986:	83 c7 08             	add    $0x8,%edi
80108989:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010898c:	e8 4f b5 ff ff       	call   80103ee0 <mycpu>
80108991:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108994:	ba 67 00 00 00       	mov    $0x67,%edx
80108999:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801089a0:	83 c0 08             	add    $0x8,%eax
801089a3:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801089aa:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801089af:	83 c1 08             	add    $0x8,%ecx
801089b2:	c1 e8 18             	shr    $0x18,%eax
801089b5:	c1 e9 10             	shr    $0x10,%ecx
801089b8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801089be:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801089c4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801089c9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801089d0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801089d5:	e8 06 b5 ff ff       	call   80103ee0 <mycpu>
801089da:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801089e1:	e8 fa b4 ff ff       	call   80103ee0 <mycpu>
801089e6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801089ea:	8b 5e 08             	mov    0x8(%esi),%ebx
801089ed:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801089f3:	e8 e8 b4 ff ff       	call   80103ee0 <mycpu>
801089f8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801089fb:	e8 e0 b4 ff ff       	call   80103ee0 <mycpu>
80108a00:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108a04:	b8 28 00 00 00       	mov    $0x28,%eax
80108a09:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108a0c:	8b 46 04             	mov    0x4(%esi),%eax
80108a0f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108a14:	0f 22 d8             	mov    %eax,%cr3
}
80108a17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108a1a:	5b                   	pop    %ebx
80108a1b:	5e                   	pop    %esi
80108a1c:	5f                   	pop    %edi
80108a1d:	5d                   	pop    %ebp
  popcli();
80108a1e:	e9 cd d2 ff ff       	jmp    80105cf0 <popcli>
    panic("switchuvm: no process");
80108a23:	83 ec 0c             	sub    $0xc,%esp
80108a26:	68 62 a9 10 80       	push   $0x8010a962
80108a2b:	e8 60 79 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80108a30:	83 ec 0c             	sub    $0xc,%esp
80108a33:	68 8d a9 10 80       	push   $0x8010a98d
80108a38:	e8 53 79 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80108a3d:	83 ec 0c             	sub    $0xc,%esp
80108a40:	68 78 a9 10 80       	push   $0x8010a978
80108a45:	e8 46 79 ff ff       	call   80100390 <panic>
80108a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108a50 <inituvm>:
{
80108a50:	f3 0f 1e fb          	endbr32 
80108a54:	55                   	push   %ebp
80108a55:	89 e5                	mov    %esp,%ebp
80108a57:	57                   	push   %edi
80108a58:	56                   	push   %esi
80108a59:	53                   	push   %ebx
80108a5a:	83 ec 1c             	sub    $0x1c,%esp
80108a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a60:	8b 75 10             	mov    0x10(%ebp),%esi
80108a63:	8b 7d 08             	mov    0x8(%ebp),%edi
80108a66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108a69:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108a6f:	77 4b                	ja     80108abc <inituvm+0x6c>
  mem = kalloc();
80108a71:	e8 2a a1 ff ff       	call   80102ba0 <kalloc>
  memset(mem, 0, PGSIZE);
80108a76:	83 ec 04             	sub    $0x4,%esp
80108a79:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80108a7e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108a80:	6a 00                	push   $0x0
80108a82:	50                   	push   %eax
80108a83:	e8 28 d4 ff ff       	call   80105eb0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108a88:	58                   	pop    %eax
80108a89:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108a8f:	5a                   	pop    %edx
80108a90:	6a 06                	push   $0x6
80108a92:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108a97:	31 d2                	xor    %edx,%edx
80108a99:	50                   	push   %eax
80108a9a:	89 f8                	mov    %edi,%eax
80108a9c:	e8 af fc ff ff       	call   80108750 <mappages>
  memmove(mem, init, sz);
80108aa1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108aa4:	89 75 10             	mov    %esi,0x10(%ebp)
80108aa7:	83 c4 10             	add    $0x10,%esp
80108aaa:	89 5d 08             	mov    %ebx,0x8(%ebp)
80108aad:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80108ab0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108ab3:	5b                   	pop    %ebx
80108ab4:	5e                   	pop    %esi
80108ab5:	5f                   	pop    %edi
80108ab6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108ab7:	e9 94 d4 ff ff       	jmp    80105f50 <memmove>
    panic("inituvm: more than a page");
80108abc:	83 ec 0c             	sub    $0xc,%esp
80108abf:	68 a1 a9 10 80       	push   $0x8010a9a1
80108ac4:	e8 c7 78 ff ff       	call   80100390 <panic>
80108ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108ad0 <loaduvm>:
{
80108ad0:	f3 0f 1e fb          	endbr32 
80108ad4:	55                   	push   %ebp
80108ad5:	89 e5                	mov    %esp,%ebp
80108ad7:	57                   	push   %edi
80108ad8:	56                   	push   %esi
80108ad9:	53                   	push   %ebx
80108ada:	83 ec 1c             	sub    $0x1c,%esp
80108add:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ae0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80108ae3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80108ae8:	0f 85 99 00 00 00    	jne    80108b87 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
80108aee:	01 f0                	add    %esi,%eax
80108af0:	89 f3                	mov    %esi,%ebx
80108af2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108af5:	8b 45 14             	mov    0x14(%ebp),%eax
80108af8:	01 f0                	add    %esi,%eax
80108afa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80108afd:	85 f6                	test   %esi,%esi
80108aff:	75 15                	jne    80108b16 <loaduvm+0x46>
80108b01:	eb 6d                	jmp    80108b70 <loaduvm+0xa0>
80108b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108b07:	90                   	nop
80108b08:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80108b0e:	89 f0                	mov    %esi,%eax
80108b10:	29 d8                	sub    %ebx,%eax
80108b12:	39 c6                	cmp    %eax,%esi
80108b14:	76 5a                	jbe    80108b70 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108b16:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108b19:	8b 45 08             	mov    0x8(%ebp),%eax
80108b1c:	31 c9                	xor    %ecx,%ecx
80108b1e:	29 da                	sub    %ebx,%edx
80108b20:	e8 ab fb ff ff       	call   801086d0 <walkpgdir>
80108b25:	85 c0                	test   %eax,%eax
80108b27:	74 51                	je     80108b7a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80108b29:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108b2b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80108b2e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80108b33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80108b38:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80108b3e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108b41:	29 d9                	sub    %ebx,%ecx
80108b43:	05 00 00 00 80       	add    $0x80000000,%eax
80108b48:	57                   	push   %edi
80108b49:	51                   	push   %ecx
80108b4a:	50                   	push   %eax
80108b4b:	ff 75 10             	pushl  0x10(%ebp)
80108b4e:	e8 7d 94 ff ff       	call   80101fd0 <readi>
80108b53:	83 c4 10             	add    $0x10,%esp
80108b56:	39 f8                	cmp    %edi,%eax
80108b58:	74 ae                	je     80108b08 <loaduvm+0x38>
}
80108b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108b62:	5b                   	pop    %ebx
80108b63:	5e                   	pop    %esi
80108b64:	5f                   	pop    %edi
80108b65:	5d                   	pop    %ebp
80108b66:	c3                   	ret    
80108b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108b6e:	66 90                	xchg   %ax,%ax
80108b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108b73:	31 c0                	xor    %eax,%eax
}
80108b75:	5b                   	pop    %ebx
80108b76:	5e                   	pop    %esi
80108b77:	5f                   	pop    %edi
80108b78:	5d                   	pop    %ebp
80108b79:	c3                   	ret    
      panic("loaduvm: address should exist");
80108b7a:	83 ec 0c             	sub    $0xc,%esp
80108b7d:	68 bb a9 10 80       	push   $0x8010a9bb
80108b82:	e8 09 78 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80108b87:	83 ec 0c             	sub    $0xc,%esp
80108b8a:	68 6c aa 10 80       	push   $0x8010aa6c
80108b8f:	e8 fc 77 ff ff       	call   80100390 <panic>
80108b94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108b9f:	90                   	nop

80108ba0 <allocuvm>:
{
80108ba0:	f3 0f 1e fb          	endbr32 
80108ba4:	55                   	push   %ebp
80108ba5:	89 e5                	mov    %esp,%ebp
80108ba7:	57                   	push   %edi
80108ba8:	56                   	push   %esi
80108ba9:	53                   	push   %ebx
80108baa:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= HEAPLIMIT) // prev value: KERBASE
80108bad:	81 7d 10 ff ff ff 7e 	cmpl   $0x7effffff,0x10(%ebp)
{
80108bb4:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= HEAPLIMIT) // prev value: KERBASE
80108bb7:	0f 87 b3 00 00 00    	ja     80108c70 <allocuvm+0xd0>
  if(newsz < oldsz)
80108bbd:	8b 45 0c             	mov    0xc(%ebp),%eax
80108bc0:	39 45 10             	cmp    %eax,0x10(%ebp)
80108bc3:	0f 82 a9 00 00 00    	jb     80108c72 <allocuvm+0xd2>
  a = PGROUNDUP(oldsz);
80108bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80108bcc:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80108bd2:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80108bd8:	39 75 10             	cmp    %esi,0x10(%ebp)
80108bdb:	0f 86 9f 00 00 00    	jbe    80108c80 <allocuvm+0xe0>
80108be1:	8b 45 10             	mov    0x10(%ebp),%eax
80108be4:	83 e8 01             	sub    $0x1,%eax
80108be7:	29 f0                	sub    %esi,%eax
80108be9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108bee:	8d 84 06 00 10 00 00 	lea    0x1000(%esi,%eax,1),%eax
80108bf5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108bf8:	eb 41                	jmp    80108c3b <allocuvm+0x9b>
80108bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108c00:	83 ec 04             	sub    $0x4,%esp
80108c03:	68 00 10 00 00       	push   $0x1000
80108c08:	6a 00                	push   $0x0
80108c0a:	50                   	push   %eax
80108c0b:	e8 a0 d2 ff ff       	call   80105eb0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108c10:	58                   	pop    %eax
80108c11:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108c17:	5a                   	pop    %edx
80108c18:	6a 06                	push   $0x6
80108c1a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108c1f:	89 f2                	mov    %esi,%edx
80108c21:	50                   	push   %eax
80108c22:	89 f8                	mov    %edi,%eax
80108c24:	e8 27 fb ff ff       	call   80108750 <mappages>
80108c29:	83 c4 10             	add    $0x10,%esp
80108c2c:	85 c0                	test   %eax,%eax
80108c2e:	78 60                	js     80108c90 <allocuvm+0xf0>
  for(; a < newsz; a += PGSIZE){
80108c30:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108c36:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80108c39:	74 45                	je     80108c80 <allocuvm+0xe0>
    mem = kalloc();
80108c3b:	e8 60 9f ff ff       	call   80102ba0 <kalloc>
80108c40:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80108c42:	85 c0                	test   %eax,%eax
80108c44:	75 ba                	jne    80108c00 <allocuvm+0x60>
      cprintf("allocuvm out of memory\n");
80108c46:	83 ec 0c             	sub    $0xc,%esp
80108c49:	68 d9 a9 10 80       	push   $0x8010a9d9
80108c4e:	e8 6d 7c ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
80108c53:	8b 45 0c             	mov    0xc(%ebp),%eax
80108c56:	83 c4 10             	add    $0x10,%esp
80108c59:	39 45 10             	cmp    %eax,0x10(%ebp)
80108c5c:	74 12                	je     80108c70 <allocuvm+0xd0>
80108c5e:	8b 55 10             	mov    0x10(%ebp),%edx
80108c61:	89 c1                	mov    %eax,%ecx
80108c63:	89 f8                	mov    %edi,%eax
80108c65:	e8 76 fb ff ff       	call   801087e0 <deallocuvm.part.0>
80108c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return 0;
80108c70:	31 c0                	xor    %eax,%eax
}
80108c72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108c75:	5b                   	pop    %ebx
80108c76:	5e                   	pop    %esi
80108c77:	5f                   	pop    %edi
80108c78:	5d                   	pop    %ebp
80108c79:	c3                   	ret    
80108c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return newsz;
80108c80:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108c83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108c86:	5b                   	pop    %ebx
80108c87:	5e                   	pop    %esi
80108c88:	5f                   	pop    %edi
80108c89:	5d                   	pop    %ebp
80108c8a:	c3                   	ret    
80108c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108c8f:	90                   	nop
      cprintf("allocuvm out of memory (2)\n");
80108c90:	83 ec 0c             	sub    $0xc,%esp
80108c93:	68 f1 a9 10 80       	push   $0x8010a9f1
80108c98:	e8 23 7c ff ff       	call   801008c0 <cprintf>
  if(newsz >= oldsz)
80108c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ca0:	83 c4 10             	add    $0x10,%esp
80108ca3:	39 45 10             	cmp    %eax,0x10(%ebp)
80108ca6:	74 0c                	je     80108cb4 <allocuvm+0x114>
80108ca8:	8b 55 10             	mov    0x10(%ebp),%edx
80108cab:	89 c1                	mov    %eax,%ecx
80108cad:	89 f8                	mov    %edi,%eax
80108caf:	e8 2c fb ff ff       	call   801087e0 <deallocuvm.part.0>
      kfree(mem);
80108cb4:	83 ec 0c             	sub    $0xc,%esp
80108cb7:	53                   	push   %ebx
80108cb8:	e8 23 9d ff ff       	call   801029e0 <kfree>
      return 0;
80108cbd:	83 c4 10             	add    $0x10,%esp
}
80108cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80108cc3:	31 c0                	xor    %eax,%eax
}
80108cc5:	5b                   	pop    %ebx
80108cc6:	5e                   	pop    %esi
80108cc7:	5f                   	pop    %edi
80108cc8:	5d                   	pop    %ebp
80108cc9:	c3                   	ret    
80108cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108cd0 <deallocuvm>:
{
80108cd0:	f3 0f 1e fb          	endbr32 
80108cd4:	55                   	push   %ebp
80108cd5:	89 e5                	mov    %esp,%ebp
80108cd7:	8b 55 0c             	mov    0xc(%ebp),%edx
80108cda:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80108ce0:	39 d1                	cmp    %edx,%ecx
80108ce2:	73 0c                	jae    80108cf0 <deallocuvm+0x20>
}
80108ce4:	5d                   	pop    %ebp
80108ce5:	e9 f6 fa ff ff       	jmp    801087e0 <deallocuvm.part.0>
80108cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108cf0:	89 d0                	mov    %edx,%eax
80108cf2:	5d                   	pop    %ebp
80108cf3:	c3                   	ret    
80108cf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108cff:	90                   	nop

80108d00 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108d00:	f3 0f 1e fb          	endbr32 
80108d04:	55                   	push   %ebp
80108d05:	89 e5                	mov    %esp,%ebp
80108d07:	57                   	push   %edi
80108d08:	56                   	push   %esi
80108d09:	53                   	push   %ebx
80108d0a:	83 ec 0c             	sub    $0xc,%esp
80108d0d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80108d10:	85 f6                	test   %esi,%esi
80108d12:	74 55                	je     80108d69 <freevm+0x69>
  if(newsz >= oldsz)
80108d14:	31 c9                	xor    %ecx,%ecx
80108d16:	ba 00 00 00 7f       	mov    $0x7f000000,%edx
80108d1b:	89 f0                	mov    %esi,%eax
80108d1d:	89 f3                	mov    %esi,%ebx
80108d1f:	e8 bc fa ff ff       	call   801087e0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  // deallocuvm(pgdir, KERNBASE, 0);
  deallocuvm(pgdir, HEAPLIMIT, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108d24:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108d2a:	eb 0b                	jmp    80108d37 <freevm+0x37>
80108d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108d30:	83 c3 04             	add    $0x4,%ebx
80108d33:	39 df                	cmp    %ebx,%edi
80108d35:	74 23                	je     80108d5a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108d37:	8b 03                	mov    (%ebx),%eax
80108d39:	a8 01                	test   $0x1,%al
80108d3b:	74 f3                	je     80108d30 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108d3d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108d42:	83 ec 0c             	sub    $0xc,%esp
80108d45:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108d48:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80108d4d:	50                   	push   %eax
80108d4e:	e8 8d 9c ff ff       	call   801029e0 <kfree>
80108d53:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108d56:	39 df                	cmp    %ebx,%edi
80108d58:	75 dd                	jne    80108d37 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108d5a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108d5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108d60:	5b                   	pop    %ebx
80108d61:	5e                   	pop    %esi
80108d62:	5f                   	pop    %edi
80108d63:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108d64:	e9 77 9c ff ff       	jmp    801029e0 <kfree>
    panic("freevm: no pgdir");
80108d69:	83 ec 0c             	sub    $0xc,%esp
80108d6c:	68 0d aa 10 80       	push   $0x8010aa0d
80108d71:	e8 1a 76 ff ff       	call   80100390 <panic>
80108d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108d7d:	8d 76 00             	lea    0x0(%esi),%esi

80108d80 <setupkvm>:
{
80108d80:	f3 0f 1e fb          	endbr32 
80108d84:	55                   	push   %ebp
80108d85:	89 e5                	mov    %esp,%ebp
80108d87:	56                   	push   %esi
80108d88:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108d89:	e8 12 9e ff ff       	call   80102ba0 <kalloc>
80108d8e:	89 c6                	mov    %eax,%esi
80108d90:	85 c0                	test   %eax,%eax
80108d92:	74 42                	je     80108dd6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80108d94:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108d97:	bb 20 d4 10 80       	mov    $0x8010d420,%ebx
  memset(pgdir, 0, PGSIZE);
80108d9c:	68 00 10 00 00       	push   $0x1000
80108da1:	6a 00                	push   $0x0
80108da3:	50                   	push   %eax
80108da4:	e8 07 d1 ff ff       	call   80105eb0 <memset>
80108da9:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108dac:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108daf:	83 ec 08             	sub    $0x8,%esp
80108db2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108db5:	ff 73 0c             	pushl  0xc(%ebx)
80108db8:	8b 13                	mov    (%ebx),%edx
80108dba:	50                   	push   %eax
80108dbb:	29 c1                	sub    %eax,%ecx
80108dbd:	89 f0                	mov    %esi,%eax
80108dbf:	e8 8c f9 ff ff       	call   80108750 <mappages>
80108dc4:	83 c4 10             	add    $0x10,%esp
80108dc7:	85 c0                	test   %eax,%eax
80108dc9:	78 15                	js     80108de0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108dcb:	83 c3 10             	add    $0x10,%ebx
80108dce:	81 fb 60 d4 10 80    	cmp    $0x8010d460,%ebx
80108dd4:	75 d6                	jne    80108dac <setupkvm+0x2c>
}
80108dd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108dd9:	89 f0                	mov    %esi,%eax
80108ddb:	5b                   	pop    %ebx
80108ddc:	5e                   	pop    %esi
80108ddd:	5d                   	pop    %ebp
80108dde:	c3                   	ret    
80108ddf:	90                   	nop
      freevm(pgdir);
80108de0:	83 ec 0c             	sub    $0xc,%esp
80108de3:	56                   	push   %esi
      return 0;
80108de4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108de6:	e8 15 ff ff ff       	call   80108d00 <freevm>
      return 0;
80108deb:	83 c4 10             	add    $0x10,%esp
}
80108dee:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108df1:	89 f0                	mov    %esi,%eax
80108df3:	5b                   	pop    %ebx
80108df4:	5e                   	pop    %esi
80108df5:	5d                   	pop    %ebp
80108df6:	c3                   	ret    
80108df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108dfe:	66 90                	xchg   %ax,%ax

80108e00 <kvmalloc>:
{
80108e00:	f3 0f 1e fb          	endbr32 
80108e04:	55                   	push   %ebp
80108e05:	89 e5                	mov    %esp,%ebp
80108e07:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108e0a:	e8 71 ff ff ff       	call   80108d80 <setupkvm>
80108e0f:	a3 00 d7 12 80       	mov    %eax,0x8012d700
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108e14:	05 00 00 00 80       	add    $0x80000000,%eax
80108e19:	0f 22 d8             	mov    %eax,%cr3
}
80108e1c:	c9                   	leave  
80108e1d:	c3                   	ret    
80108e1e:	66 90                	xchg   %ax,%ax

80108e20 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108e20:	f3 0f 1e fb          	endbr32 
80108e24:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108e25:	31 c9                	xor    %ecx,%ecx
{
80108e27:	89 e5                	mov    %esp,%ebp
80108e29:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108e2c:	8b 55 0c             	mov    0xc(%ebp),%edx
80108e2f:	8b 45 08             	mov    0x8(%ebp),%eax
80108e32:	e8 99 f8 ff ff       	call   801086d0 <walkpgdir>
  if(pte == 0)
80108e37:	85 c0                	test   %eax,%eax
80108e39:	74 05                	je     80108e40 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108e3b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80108e3e:	c9                   	leave  
80108e3f:	c3                   	ret    
    panic("clearpteu");
80108e40:	83 ec 0c             	sub    $0xc,%esp
80108e43:	68 1e aa 10 80       	push   $0x8010aa1e
80108e48:	e8 43 75 ff ff       	call   80100390 <panic>
80108e4d:	8d 76 00             	lea    0x0(%esi),%esi

80108e50 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108e50:	f3 0f 1e fb          	endbr32 
80108e54:	55                   	push   %ebp
80108e55:	89 e5                	mov    %esp,%ebp
80108e57:	57                   	push   %edi
80108e58:	56                   	push   %esi
80108e59:	53                   	push   %ebx
80108e5a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108e5d:	e8 1e ff ff ff       	call   80108d80 <setupkvm>
80108e62:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108e65:	85 c0                	test   %eax,%eax
80108e67:	0f 84 9b 00 00 00    	je     80108f08 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108e6d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108e70:	85 c9                	test   %ecx,%ecx
80108e72:	0f 84 90 00 00 00    	je     80108f08 <copyuvm+0xb8>
80108e78:	31 f6                	xor    %esi,%esi
80108e7a:	eb 46                	jmp    80108ec2 <copyuvm+0x72>
80108e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108e80:	83 ec 04             	sub    $0x4,%esp
80108e83:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108e89:	68 00 10 00 00       	push   $0x1000
80108e8e:	57                   	push   %edi
80108e8f:	50                   	push   %eax
80108e90:	e8 bb d0 ff ff       	call   80105f50 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108e95:	58                   	pop    %eax
80108e96:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108e9c:	5a                   	pop    %edx
80108e9d:	ff 75 e4             	pushl  -0x1c(%ebp)
80108ea0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108ea5:	89 f2                	mov    %esi,%edx
80108ea7:	50                   	push   %eax
80108ea8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108eab:	e8 a0 f8 ff ff       	call   80108750 <mappages>
80108eb0:	83 c4 10             	add    $0x10,%esp
80108eb3:	85 c0                	test   %eax,%eax
80108eb5:	78 61                	js     80108f18 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80108eb7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108ebd:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108ec0:	76 46                	jbe    80108f08 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108ec2:	8b 45 08             	mov    0x8(%ebp),%eax
80108ec5:	31 c9                	xor    %ecx,%ecx
80108ec7:	89 f2                	mov    %esi,%edx
80108ec9:	e8 02 f8 ff ff       	call   801086d0 <walkpgdir>
80108ece:	85 c0                	test   %eax,%eax
80108ed0:	74 61                	je     80108f33 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80108ed2:	8b 00                	mov    (%eax),%eax
80108ed4:	a8 01                	test   $0x1,%al
80108ed6:	74 4e                	je     80108f26 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80108ed8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108eda:	25 ff 0f 00 00       	and    $0xfff,%eax
80108edf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80108ee2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108ee8:	e8 b3 9c ff ff       	call   80102ba0 <kalloc>
80108eed:	89 c3                	mov    %eax,%ebx
80108eef:	85 c0                	test   %eax,%eax
80108ef1:	75 8d                	jne    80108e80 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80108ef3:	83 ec 0c             	sub    $0xc,%esp
80108ef6:	ff 75 e0             	pushl  -0x20(%ebp)
80108ef9:	e8 02 fe ff ff       	call   80108d00 <freevm>
  return 0;
80108efe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108f05:	83 c4 10             	add    $0x10,%esp
}
80108f08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108f0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108f0e:	5b                   	pop    %ebx
80108f0f:	5e                   	pop    %esi
80108f10:	5f                   	pop    %edi
80108f11:	5d                   	pop    %ebp
80108f12:	c3                   	ret    
80108f13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108f17:	90                   	nop
      kfree(mem);
80108f18:	83 ec 0c             	sub    $0xc,%esp
80108f1b:	53                   	push   %ebx
80108f1c:	e8 bf 9a ff ff       	call   801029e0 <kfree>
      goto bad;
80108f21:	83 c4 10             	add    $0x10,%esp
80108f24:	eb cd                	jmp    80108ef3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80108f26:	83 ec 0c             	sub    $0xc,%esp
80108f29:	68 42 aa 10 80       	push   $0x8010aa42
80108f2e:	e8 5d 74 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80108f33:	83 ec 0c             	sub    $0xc,%esp
80108f36:	68 28 aa 10 80       	push   $0x8010aa28
80108f3b:	e8 50 74 ff ff       	call   80100390 <panic>

80108f40 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108f40:	f3 0f 1e fb          	endbr32 
80108f44:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108f45:	31 c9                	xor    %ecx,%ecx
{
80108f47:	89 e5                	mov    %esp,%ebp
80108f49:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108f4c:	8b 55 0c             	mov    0xc(%ebp),%edx
80108f4f:	8b 45 08             	mov    0x8(%ebp),%eax
80108f52:	e8 79 f7 ff ff       	call   801086d0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108f57:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108f59:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80108f5a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108f5c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108f61:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108f64:	05 00 00 00 80       	add    $0x80000000,%eax
80108f69:	83 fa 05             	cmp    $0x5,%edx
80108f6c:	ba 00 00 00 00       	mov    $0x0,%edx
80108f71:	0f 45 c2             	cmovne %edx,%eax
}
80108f74:	c3                   	ret    
80108f75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108f80 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108f80:	f3 0f 1e fb          	endbr32 
80108f84:	55                   	push   %ebp
80108f85:	89 e5                	mov    %esp,%ebp
80108f87:	57                   	push   %edi
80108f88:	56                   	push   %esi
80108f89:	53                   	push   %ebx
80108f8a:	83 ec 0c             	sub    $0xc,%esp
80108f8d:	8b 75 14             	mov    0x14(%ebp),%esi
80108f90:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108f93:	85 f6                	test   %esi,%esi
80108f95:	75 3c                	jne    80108fd3 <copyout+0x53>
80108f97:	eb 67                	jmp    80109000 <copyout+0x80>
80108f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
80108fa3:	89 fb                	mov    %edi,%ebx
80108fa5:	29 d3                	sub    %edx,%ebx
80108fa7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80108fad:	39 f3                	cmp    %esi,%ebx
80108faf:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108fb2:	29 fa                	sub    %edi,%edx
80108fb4:	83 ec 04             	sub    $0x4,%esp
80108fb7:	01 c2                	add    %eax,%edx
80108fb9:	53                   	push   %ebx
80108fba:	ff 75 10             	pushl  0x10(%ebp)
80108fbd:	52                   	push   %edx
80108fbe:	e8 8d cf ff ff       	call   80105f50 <memmove>
    len -= n;
    buf += n;
80108fc3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80108fc6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80108fcc:	83 c4 10             	add    $0x10,%esp
80108fcf:	29 de                	sub    %ebx,%esi
80108fd1:	74 2d                	je     80109000 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80108fd3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80108fd5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80108fd8:	89 55 0c             	mov    %edx,0xc(%ebp)
80108fdb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80108fe1:	57                   	push   %edi
80108fe2:	ff 75 08             	pushl  0x8(%ebp)
80108fe5:	e8 56 ff ff ff       	call   80108f40 <uva2ka>
    if(pa0 == 0)
80108fea:	83 c4 10             	add    $0x10,%esp
80108fed:	85 c0                	test   %eax,%eax
80108fef:	75 af                	jne    80108fa0 <copyout+0x20>
  }
  return 0;
}
80108ff1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108ff9:	5b                   	pop    %ebx
80108ffa:	5e                   	pop    %esi
80108ffb:	5f                   	pop    %edi
80108ffc:	5d                   	pop    %ebp
80108ffd:	c3                   	ret    
80108ffe:	66 90                	xchg   %ax,%ax
80109000:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80109003:	31 c0                	xor    %eax,%eax
}
80109005:	5b                   	pop    %ebx
80109006:	5e                   	pop    %esi
80109007:	5f                   	pop    %edi
80109008:	5d                   	pop    %ebp
80109009:	c3                   	ret    
8010900a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80109010 <shmget>:
/*
  Creates a shared memory region with given key,
  and size depending upon flag provided
*/
int
shmget(uint key, uint size, int shmflag) {
80109010:	f3 0f 1e fb          	endbr32 
80109014:	55                   	push   %ebp
80109015:	89 e5                	mov    %esp,%ebp
80109017:	57                   	push   %edi
80109018:	56                   	push   %esi
80109019:	53                   	push   %ebx
8010901a:	83 ec 28             	sub    $0x28,%esp
8010901d:	8b 75 10             	mov    0x10(%ebp),%esi
80109020:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // as Xv6 has only single user, else lower 9 bits would be considered
  int lowerBits = shmflag & 7, permission = -1;

  acquire(&shmTable.lock);
80109023:	68 20 d7 12 80       	push   $0x8012d720
  int lowerBits = shmflag & 7, permission = -1;
80109028:	89 f0                	mov    %esi,%eax
8010902a:	83 e0 07             	and    $0x7,%eax
8010902d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80109030:	89 c7                	mov    %eax,%edi
  acquire(&shmTable.lock);
80109032:	e8 69 cd ff ff       	call   80105da0 <acquire>
  
  // separate correct permissions and shmflag
  if(lowerBits == (int)READ_SHM) {
    permission = READ_SHM;
    shmflag ^= READ_SHM;
80109037:	89 f2                	mov    %esi,%edx
  if(lowerBits == (int)READ_SHM) {
80109039:	83 c4 10             	add    $0x10,%esp
    shmflag ^= READ_SHM;
8010903c:	83 f2 04             	xor    $0x4,%edx
  if(lowerBits == (int)READ_SHM) {
8010903f:	83 ff 04             	cmp    $0x4,%edi
80109042:	74 24                	je     80109068 <shmget+0x58>
  }
  else if(lowerBits == (int)RW_SHM) {
    permission = RW_SHM;
    shmflag ^= RW_SHM;
80109044:	89 f2                	mov    %esi,%edx
80109046:	83 f2 06             	xor    $0x6,%edx
  else if(lowerBits == (int)RW_SHM) {
80109049:	83 7d e0 06          	cmpl   $0x6,-0x20(%ebp)
8010904d:	74 19                	je     80109068 <shmget+0x58>
  } else {
    if(!((shmflag == 0) && (key != IPC_PRIVATE))) {
8010904f:	85 f6                	test   %esi,%esi
80109051:	0f 85 d6 01 00 00    	jne    8010922d <shmget+0x21d>
80109057:	85 db                	test   %ebx,%ebx
80109059:	0f 84 ce 01 00 00    	je     8010922d <shmget+0x21d>
  int lowerBits = shmflag & 7, permission = -1;
8010905f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80109066:	31 d2                	xor    %edx,%edx
      release(&shmTable.lock);
      return -1;
    }
  }
  // check for requested size
  if(size <= 0) {
80109068:	8b 45 0c             	mov    0xc(%ebp),%eax
8010906b:	85 c0                	test   %eax,%eax
8010906d:	0f 84 ba 01 00 00    	je     8010922d <shmget+0x21d>
    release(&shmTable.lock);
    return -1;
  }
  // calculate no of requested pages, from entered size
  int noOfPages = (size / PGSIZE) + 1;
80109073:	8b 7d 0c             	mov    0xc(%ebp),%edi
80109076:	c1 ef 0c             	shr    $0xc,%edi
80109079:	8d 47 01             	lea    0x1(%edi),%eax
8010907c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  // check if no of pages is more than decided limit
  if(noOfPages > SHAREDREGIONS) {
8010907f:	83 f8 40             	cmp    $0x40,%eax
80109082:	0f 87 a5 01 00 00    	ja     8010922d <shmget+0x21d>
80109088:	b8 54 d7 12 80       	mov    $0x8012d754,%eax
    release(&shmTable.lock);
    return -1;
  }
  int index = -1;
  // check if key already exists
  for(int i = 0; i < SHAREDREGIONS; i++) {
8010908d:	31 f6                	xor    %esi,%esi
  if(noOfPages > SHAREDREGIONS) {
8010908f:	89 c1                	mov    %eax,%ecx
80109091:	eb 17                	jmp    801090aa <shmget+0x9a>
80109093:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80109097:	90                   	nop
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109098:	83 c6 01             	add    $0x1,%esi
8010909b:	81 c1 28 01 00 00    	add    $0x128,%ecx
801090a1:	83 fe 40             	cmp    $0x40,%esi
801090a4:	0f 84 7e 00 00 00    	je     80109128 <shmget+0x118>
    if(shmTable.allRegions[i].key == key) {
801090aa:	39 19                	cmp    %ebx,(%ecx)
801090ac:	75 ea                	jne    80109098 <shmget+0x88>
      // if wrong size is requested with existing region
      if(shmTable.allRegions[i].size != noOfPages) {
801090ae:	69 c6 28 01 00 00    	imul   $0x128,%esi,%eax
801090b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801090b7:	8d b8 20 d7 12 80    	lea    -0x7fed28e0(%eax),%edi
801090bd:	3b 88 58 d7 12 80    	cmp    -0x7fed28a8(%eax),%ecx
801090c3:	0f 85 64 01 00 00    	jne    8010922d <shmget+0x21d>
        release(&shmTable.lock);
        return -1;
      }
      // IPC_CREAT | IPC_EXCL, for region that exists
      if(shmflag == (IPC_CREAT | IPC_EXCL)) {
801090c9:	81 fa 00 06 00 00    	cmp    $0x600,%edx
801090cf:	0f 84 58 01 00 00    	je     8010922d <shmget+0x21d>
        release(&shmTable.lock);
        return -1;
      }
      // get region permissions
      int checkPerm = shmTable.allRegions[i].buffer.shm_perm.mode;
      if(checkPerm == READ_SHM || checkPerm == RW_SHM) {
801090d5:	8b 80 68 d8 12 80    	mov    -0x7fed2798(%eax),%eax
801090db:	83 e0 fd             	and    $0xfffffffd,%eax
801090de:	83 f8 04             	cmp    $0x4,%eax
801090e1:	0f 85 46 01 00 00    	jne    8010922d <shmget+0x21d>
        // condition for IPC_PRIVATE, with existing region
        if((shmflag == 0) && (key != IPC_PRIVATE)) {
801090e7:	85 d2                	test   %edx,%edx
801090e9:	75 08                	jne    801090f3 <shmget+0xe3>
801090eb:	85 db                	test   %ebx,%ebx
801090ed:	0f 85 1d 01 00 00    	jne    80109210 <shmget+0x200>
          release(&shmTable.lock);
          return shmTable.allRegions[i].shmid;
        }
        if(shmflag == IPC_CREAT) {
801090f3:	81 fa 00 02 00 00    	cmp    $0x200,%edx
801090f9:	0f 85 2e 01 00 00    	jne    8010922d <shmget+0x21d>
          release(&shmTable.lock);
801090ff:	83 ec 0c             	sub    $0xc,%esp
          return shmTable.allRegions[i].shmid;
80109102:	69 f6 28 01 00 00    	imul   $0x128,%esi,%esi
          release(&shmTable.lock);
80109108:	68 20 d7 12 80       	push   $0x8012d720
8010910d:	e8 4e cd ff ff       	call   80105e60 <release>
          return shmTable.allRegions[i].shmid;
80109112:	8b be 5c d7 12 80    	mov    -0x7fed28a4(%esi),%edi
80109118:	83 c4 10             	add    $0x10,%esp
    return index; // valid shmid
  } else {
    release(&shmTable.lock);
    return -1;
  }  
}
8010911b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010911e:	89 f8                	mov    %edi,%eax
80109120:	5b                   	pop    %ebx
80109121:	5e                   	pop    %esi
80109122:	5f                   	pop    %edi
80109123:	5d                   	pop    %ebp
80109124:	c3                   	ret    
80109125:	8d 76 00             	lea    0x0(%esi),%esi
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109128:	31 ff                	xor    %edi,%edi
8010912a:	eb 15                	jmp    80109141 <shmget+0x131>
8010912c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80109130:	83 c7 01             	add    $0x1,%edi
80109133:	05 28 01 00 00       	add    $0x128,%eax
80109138:	83 ff 40             	cmp    $0x40,%edi
8010913b:	0f 84 ec 00 00 00    	je     8010922d <shmget+0x21d>
    if(shmTable.allRegions[i].key == -1) {
80109141:	83 38 ff             	cmpl   $0xffffffff,(%eax)
80109144:	75 ea                	jne    80109130 <shmget+0x120>
  if((key == IPC_PRIVATE) || (shmflag == IPC_CREAT) || (shmflag == (IPC_CREAT | IPC_EXCL))) {
80109146:	80 e6 fb             	and    $0xfb,%dh
80109149:	81 fa 00 02 00 00    	cmp    $0x200,%edx
8010914f:	74 08                	je     80109159 <shmget+0x149>
80109151:	85 db                	test   %ebx,%ebx
80109153:	0f 85 d4 00 00 00    	jne    8010922d <shmget+0x21d>
80109159:	69 c7 28 01 00 00    	imul   $0x128,%edi,%eax
  int noOfPages = (size / PGSIZE) + 1;
8010915f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80109162:	31 f6                	xor    %esi,%esi
80109164:	89 7d dc             	mov    %edi,-0x24(%ebp)
80109167:	89 c7                	mov    %eax,%edi
80109169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      char *newPage = kalloc();
80109170:	e8 2b 9a ff ff       	call   80102ba0 <kalloc>
80109175:	89 c3                	mov    %eax,%ebx
      if(newPage == 0){
80109177:	85 c0                	test   %eax,%eax
80109179:	0f 84 c8 00 00 00    	je     80109247 <shmget+0x237>
      memset(newPage, 0, PGSIZE);
8010917f:	83 ec 04             	sub    $0x4,%esp
80109182:	68 00 10 00 00       	push   $0x1000
80109187:	6a 00                	push   $0x0
80109189:	50                   	push   %eax
8010918a:	e8 21 cd ff ff       	call   80105eb0 <memset>
      shmTable.allRegions[index].physicalAddr[i] = (void *)V2P(newPage);
8010918f:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
    for(int i = 0; i < noOfPages; i++) {
80109195:	83 c4 10             	add    $0x10,%esp
      shmTable.allRegions[index].physicalAddr[i] = (void *)V2P(newPage);
80109198:	89 94 b7 64 d7 12 80 	mov    %edx,-0x7fed289c(%edi,%esi,4)
    for(int i = 0; i < noOfPages; i++) {
8010919f:	83 c6 01             	add    $0x1,%esi
801091a2:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801091a5:	75 c9                	jne    80109170 <shmget+0x160>
801091a7:	8b 7d dc             	mov    -0x24(%ebp),%edi
    shmTable.allRegions[index].size = noOfPages;
801091aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801091ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
801091b0:	69 f7 28 01 00 00    	imul   $0x128,%edi,%esi
801091b6:	89 86 58 d7 12 80    	mov    %eax,-0x7fed28a8(%esi)
    shmTable.allRegions[index].buffer.shm_segsz = size;
801091bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    shmTable.allRegions[index].key = key;
801091bf:	89 9e 54 d7 12 80    	mov    %ebx,-0x7fed28ac(%esi)
    shmTable.allRegions[index].buffer.shm_segsz = size;
801091c5:	89 86 6c d8 12 80    	mov    %eax,-0x7fed2794(%esi)
    shmTable.allRegions[index].buffer.shm_perm.mode = permission;
801091cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    shmTable.allRegions[index].buffer.shm_perm.__key = key;
801091ce:	89 9e 64 d8 12 80    	mov    %ebx,-0x7fed279c(%esi)
    shmTable.allRegions[index].buffer.shm_perm.mode = permission;
801091d4:	89 86 68 d8 12 80    	mov    %eax,-0x7fed2798(%esi)
    shmTable.allRegions[index].buffer.shm_cpid = myproc()->pid;
801091da:	e8 91 ad ff ff       	call   80103f70 <myproc>
    release(&shmTable.lock);
801091df:	83 ec 0c             	sub    $0xc,%esp
    shmTable.allRegions[index].buffer.shm_cpid = myproc()->pid;
801091e2:	8b 40 10             	mov    0x10(%eax),%eax
    release(&shmTable.lock);
801091e5:	68 20 d7 12 80       	push   $0x8012d720
    shmTable.allRegions[index].shmid = index;
801091ea:	89 be 5c d7 12 80    	mov    %edi,-0x7fed28a4(%esi)
    shmTable.allRegions[index].buffer.shm_cpid = myproc()->pid;
801091f0:	89 86 74 d8 12 80    	mov    %eax,-0x7fed278c(%esi)
    release(&shmTable.lock);
801091f6:	e8 65 cc ff ff       	call   80105e60 <release>
    return index; // valid shmid
801091fb:	83 c4 10             	add    $0x10,%esp
}
801091fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109201:	89 f8                	mov    %edi,%eax
80109203:	5b                   	pop    %ebx
80109204:	5e                   	pop    %esi
80109205:	5f                   	pop    %edi
80109206:	5d                   	pop    %ebp
80109207:	c3                   	ret    
80109208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010920f:	90                   	nop
          release(&shmTable.lock);
80109210:	83 ec 0c             	sub    $0xc,%esp
80109213:	68 20 d7 12 80       	push   $0x8012d720
80109218:	e8 43 cc ff ff       	call   80105e60 <release>
          return shmTable.allRegions[i].shmid;
8010921d:	8b 7f 3c             	mov    0x3c(%edi),%edi
80109220:	83 c4 10             	add    $0x10,%esp
}
80109223:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109226:	5b                   	pop    %ebx
80109227:	5e                   	pop    %esi
80109228:	89 f8                	mov    %edi,%eax
8010922a:	5f                   	pop    %edi
8010922b:	5d                   	pop    %ebp
8010922c:	c3                   	ret    
      release(&shmTable.lock);
8010922d:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80109230:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      release(&shmTable.lock);
80109235:	68 20 d7 12 80       	push   $0x8012d720
8010923a:	e8 21 cc ff ff       	call   80105e60 <release>
      return -1;
8010923f:	83 c4 10             	add    $0x10,%esp
80109242:	e9 d4 fe ff ff       	jmp    8010911b <shmget+0x10b>
        cprintf("shmget: failed to allocate a page (out of memory)\n");
80109247:	83 ec 0c             	sub    $0xc,%esp
        return -1;
8010924a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
        cprintf("shmget: failed to allocate a page (out of memory)\n");
8010924f:	68 90 aa 10 80       	push   $0x8010aa90
80109254:	e8 67 76 ff ff       	call   801008c0 <cprintf>
        release(&shmTable.lock);
80109259:	c7 04 24 20 d7 12 80 	movl   $0x8012d720,(%esp)
80109260:	e8 fb cb ff ff       	call   80105e60 <release>
        return -1;
80109265:	83 c4 10             	add    $0x10,%esp
}
80109268:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010926b:	89 f8                	mov    %edi,%eax
8010926d:	5b                   	pop    %ebx
8010926e:	5e                   	pop    %esi
8010926f:	5f                   	pop    %edi
80109270:	5d                   	pop    %ebp
80109271:	c3                   	ret    
80109272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80109280 <getLeastvaidx>:

// finds the least starting address of a segment greater than curr_va which is attached 
// to the virtual address space of the current process. Returns the index from the pages  
// array corresponding to this address if found; -1 otherwise
int 
getLeastvaidx(void* curr_va, struct proc *process) {
80109280:	f3 0f 1e fb          	endbr32 
80109284:	55                   	push   %ebp
  
  //maximum virtual address available in range
  void* leastva = (void*)(KERNBASE - 1);

  int idx = -1;
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109285:	31 d2                	xor    %edx,%edx
getLeastvaidx(void* curr_va, struct proc *process) {
80109287:	89 e5                	mov    %esp,%ebp
80109289:	57                   	push   %edi
  int idx = -1;
8010928a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010928f:	8b 45 0c             	mov    0xc(%ebp),%eax
getLeastvaidx(void* curr_va, struct proc *process) {
80109292:	56                   	push   %esi
  void* leastva = (void*)(KERNBASE - 1);
80109293:	be ff ff ff 7f       	mov    $0x7fffffff,%esi
getLeastvaidx(void* curr_va, struct proc *process) {
80109298:	53                   	push   %ebx
80109299:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010929c:	05 ac 00 00 00       	add    $0xac,%eax
801092a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr >= (uint)curr_va && (uint)leastva >= (uint)process->pages[i].virtualAddr) {  
801092a8:	83 38 ff             	cmpl   $0xffffffff,(%eax)
801092ab:	74 13                	je     801092c0 <getLeastvaidx+0x40>
801092ad:	8b 48 10             	mov    0x10(%eax),%ecx
801092b0:	39 cb                	cmp    %ecx,%ebx
801092b2:	77 0c                	ja     801092c0 <getLeastvaidx+0x40>
801092b4:	39 ce                	cmp    %ecx,%esi
801092b6:	72 08                	jb     801092c0 <getLeastvaidx+0x40>
801092b8:	89 d7                	mov    %edx,%edi
      // store address if greater than curr_va and smaller than the existing least_va.
      leastva = process->pages[i].virtualAddr;
801092ba:	89 ce                	mov    %ecx,%esi
801092bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < SHAREDREGIONS; i++) {
801092c0:	83 c2 01             	add    $0x1,%edx
801092c3:	83 c0 14             	add    $0x14,%eax
801092c6:	83 fa 40             	cmp    $0x40,%edx
801092c9:	75 dd                	jne    801092a8 <getLeastvaidx+0x28>

      idx = i;
    }
  }  
  return idx;
}
801092cb:	5b                   	pop    %ebx
801092cc:	89 f8                	mov    %edi,%eax
801092ce:	5e                   	pop    %esi
801092cf:	5f                   	pop    %edi
801092d0:	5d                   	pop    %ebp
801092d1:	c3                   	ret    
801092d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801092d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801092e0 <shmdt>:

// detaches the shared memory segment starting at shmaddr from virtual address space of the process
// returns 0 if successful and -1 in case of a failure
int 
shmdt(void* shmaddr) {
801092e0:	f3 0f 1e fb          	endbr32 
801092e4:	55                   	push   %ebp
801092e5:	89 e5                	mov    %esp,%ebp
801092e7:	57                   	push   %edi
801092e8:	56                   	push   %esi
801092e9:	53                   	push   %ebx
  acquire(&shmTable.lock);
  struct proc *process = myproc();
  void* va = (void*)0;
  uint size;
  int index,shmid;
  for(int i = 0; i < SHAREDREGIONS; i++) {
801092ea:	31 db                	xor    %ebx,%ebx
shmdt(void* shmaddr) {
801092ec:	83 ec 28             	sub    $0x28,%esp
801092ef:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&shmTable.lock);
801092f2:	68 20 d7 12 80       	push   $0x8012d720
801092f7:	e8 a4 ca ff ff       	call   80105da0 <acquire>
  struct proc *process = myproc();
801092fc:	e8 6f ac ff ff       	call   80103f70 <myproc>
80109301:	83 c4 10             	add    $0x10,%esp
80109304:	89 c7                	mov    %eax,%edi
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109306:	8d 80 ac 00 00 00    	lea    0xac(%eax),%eax
8010930c:	eb 0d                	jmp    8010931b <shmdt+0x3b>
8010930e:	66 90                	xchg   %ax,%ax
80109310:	83 c3 01             	add    $0x1,%ebx
80109313:	83 c0 14             	add    $0x14,%eax
80109316:	83 fb 40             	cmp    $0x40,%ebx
80109319:	74 59                	je     80109374 <shmdt+0x94>
    // find the index from pages array which is attached at the provided shmaddr
    if(process->pages[i].key != -1 && process->pages[i].virtualAddr == shmaddr) {
8010931b:	83 38 ff             	cmpl   $0xffffffff,(%eax)
8010931e:	74 f0                	je     80109310 <shmdt+0x30>
80109320:	39 70 10             	cmp    %esi,0x10(%eax)
80109323:	75 eb                	jne    80109310 <shmdt+0x30>
        va =  process->pages[i].virtualAddr;
        index = i;
        shmid = process->pages[i].shmid;
80109325:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
80109328:	8d 04 87             	lea    (%edi,%eax,4),%eax
8010932b:	8b 88 b4 00 00 00    	mov    0xb4(%eax),%ecx
        size = process->pages[index].size;
80109331:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
        shmid = process->pages[i].shmid;
80109337:	89 4d e0             	mov    %ecx,-0x20(%ebp)
        size = process->pages[index].size;
8010933a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        break;
    }
  }
  if(va) {
8010933d:	85 f6                	test   %esi,%esi
8010933f:	74 33                	je     80109374 <shmdt+0x94>
    for(int i = 0; i < size; i++) {
80109341:	89 f2                	mov    %esi,%edx
80109343:	31 f6                	xor    %esi,%esi
80109345:	85 c0                	test   %eax,%eax
80109347:	74 52                	je     8010939b <shmdt+0xbb>
80109349:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010934c:	89 d3                	mov    %edx,%ebx
8010934e:	eb 14                	jmp    80109364 <shmdt+0x84>
      pte_t* pte = walkpgdir(process->pgdir, (void*)((uint)va + i*PGSIZE), 0);
      if(pte == 0) {
        release(&shmTable.lock);
        return -1;
      }
		  *pte = 0;
80109350:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for(int i = 0; i < size; i++) {
80109356:	83 c6 01             	add    $0x1,%esi
80109359:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010935f:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80109362:	74 34                	je     80109398 <shmdt+0xb8>
      pte_t* pte = walkpgdir(process->pgdir, (void*)((uint)va + i*PGSIZE), 0);
80109364:	8b 47 04             	mov    0x4(%edi),%eax
80109367:	31 c9                	xor    %ecx,%ecx
80109369:	89 da                	mov    %ebx,%edx
8010936b:	e8 60 f3 ff ff       	call   801086d0 <walkpgdir>
      if(pte == 0) {
80109370:	85 c0                	test   %eax,%eax
80109372:	75 dc                	jne    80109350 <shmdt+0x70>
        release(&shmTable.lock);
80109374:	83 ec 0c             	sub    $0xc,%esp
80109377:	68 20 d7 12 80       	push   $0x8012d720
8010937c:	e8 df ca ff ff       	call   80105e60 <release>
        return -1;
80109381:	83 c4 10             	add    $0x10,%esp
  } else {
    release(&shmTable.lock);
    return -1;
  }
  
}
80109384:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80109387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010938c:	5b                   	pop    %ebx
8010938d:	5e                   	pop    %esi
8010938e:	5f                   	pop    %edi
8010938f:	5d                   	pop    %ebp
80109390:	c3                   	ret    
80109391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109398:	8b 5d dc             	mov    -0x24(%ebp),%ebx
    if(shmTable.allRegions[shmid].buffer.shm_nattch > 0) {
8010939b:	69 55 e0 28 01 00 00 	imul   $0x128,-0x20(%ebp),%edx
    process->pages[index].shmid = -1;  
801093a2:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
801093a5:	8d 04 87             	lea    (%edi,%eax,4),%eax
801093a8:	c7 80 b4 00 00 00 ff 	movl   $0xffffffff,0xb4(%eax)
801093af:	ff ff ff 
    process->pages[index].key = -1;
801093b2:	c7 80 ac 00 00 00 ff 	movl   $0xffffffff,0xac(%eax)
801093b9:	ff ff ff 
    if(shmTable.allRegions[shmid].buffer.shm_nattch > 0) {
801093bc:	81 c2 20 d7 12 80    	add    $0x8012d720,%edx
    process->pages[index].size =  0;
801093c2:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801093c9:	00 00 00 
    process->pages[index].virtualAddr = (void*)0;
801093cc:	c7 80 bc 00 00 00 00 	movl   $0x0,0xbc(%eax)
801093d3:	00 00 00 
    if(shmTable.allRegions[shmid].buffer.shm_nattch > 0) {
801093d6:	8b 82 50 01 00 00    	mov    0x150(%edx),%eax
801093dc:	85 c0                	test   %eax,%eax
801093de:	7e 09                	jle    801093e9 <shmdt+0x109>
      shmTable.allRegions[shmid].buffer.shm_nattch -= 1;
801093e0:	83 e8 01             	sub    $0x1,%eax
801093e3:	89 82 50 01 00 00    	mov    %eax,0x150(%edx)
    if(shmTable.allRegions[shmid].buffer.shm_nattch == 0 && shmTable.allRegions[shmid].toBeDeleted == 1) {
801093e9:	85 c0                	test   %eax,%eax
801093eb:	74 33                	je     80109420 <shmdt+0x140>
    release(&shmTable.lock);
801093ed:	83 ec 0c             	sub    $0xc,%esp
    shmTable.allRegions[shmid].buffer.shm_lpid = process->pid;
801093f0:	69 45 e0 28 01 00 00 	imul   $0x128,-0x20(%ebp),%eax
801093f7:	8b 57 10             	mov    0x10(%edi),%edx
    release(&shmTable.lock);
801093fa:	68 20 d7 12 80       	push   $0x8012d720
    shmTable.allRegions[shmid].buffer.shm_lpid = process->pid;
801093ff:	89 90 78 d8 12 80    	mov    %edx,-0x7fed2788(%eax)
    release(&shmTable.lock);
80109405:	e8 56 ca ff ff       	call   80105e60 <release>
    return 0;
8010940a:	83 c4 10             	add    $0x10,%esp
}
8010940d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80109410:	31 c0                	xor    %eax,%eax
}
80109412:	5b                   	pop    %ebx
80109413:	5e                   	pop    %esi
80109414:	5f                   	pop    %edi
80109415:	5d                   	pop    %ebp
80109416:	c3                   	ret    
80109417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010941e:	66 90                	xchg   %ax,%ax
    if(shmTable.allRegions[shmid].buffer.shm_nattch == 0 && shmTable.allRegions[shmid].toBeDeleted == 1) {
80109420:	69 55 e0 28 01 00 00 	imul   $0x128,-0x20(%ebp),%edx
80109427:	83 ba 60 d7 12 80 01 	cmpl   $0x1,-0x7fed28a0(%edx)
8010942e:	75 bd                	jne    801093ed <shmdt+0x10d>
      for(int i = 0; i < shmTable.allRegions[index].size; i++) {
80109430:	69 f3 28 01 00 00    	imul   $0x128,%ebx,%esi
80109436:	8d 96 20 d7 12 80    	lea    -0x7fed28e0(%esi),%edx
8010943c:	89 d1                	mov    %edx,%ecx
8010943e:	8b 96 58 d7 12 80    	mov    -0x7fed28a8(%esi),%edx
80109444:	85 d2                	test   %edx,%edx
80109446:	74 42                	je     8010948a <shmdt+0x1aa>
80109448:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010944b:	89 f7                	mov    %esi,%edi
8010944d:	89 ce                	mov    %ecx,%esi
8010944f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80109452:	89 c3                	mov    %eax,%ebx
80109454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
80109458:	8b 84 9f 64 d7 12 80 	mov    -0x7fed289c(%edi,%ebx,4),%eax
        kfree(addr);
8010945f:	83 ec 0c             	sub    $0xc,%esp
        char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
80109462:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
        kfree(addr);
80109468:	52                   	push   %edx
80109469:	e8 72 95 ff ff       	call   801029e0 <kfree>
      for(int i = 0; i < shmTable.allRegions[index].size; i++) {
8010946e:	83 c4 10             	add    $0x10,%esp
        shmTable.allRegions[index].physicalAddr[i] = (void *)0;
80109471:	c7 84 9f 64 d7 12 80 	movl   $0x0,-0x7fed289c(%edi,%ebx,4)
80109478:	00 00 00 00 
      for(int i = 0; i < shmTable.allRegions[index].size; i++) {
8010947c:	83 c3 01             	add    $0x1,%ebx
8010947f:	39 5e 38             	cmp    %ebx,0x38(%esi)
80109482:	77 d4                	ja     80109458 <shmdt+0x178>
80109484:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80109487:	8b 5d dc             	mov    -0x24(%ebp),%ebx
      shmTable.allRegions[index].size = 0;
8010948a:	69 c3 28 01 00 00    	imul   $0x128,%ebx,%eax
80109490:	c7 80 58 d7 12 80 00 	movl   $0x0,-0x7fed28a8(%eax)
80109497:	00 00 00 
      shmTable.allRegions[index].key = shmTable.allRegions[index].shmid = -1;
8010949a:	c7 80 5c d7 12 80 ff 	movl   $0xffffffff,-0x7fed28a4(%eax)
801094a1:	ff ff ff 
801094a4:	c7 80 54 d7 12 80 ff 	movl   $0xffffffff,-0x7fed28ac(%eax)
801094ab:	ff ff ff 
      shmTable.allRegions[index].toBeDeleted = 0;
801094ae:	c7 80 60 d7 12 80 00 	movl   $0x0,-0x7fed28a0(%eax)
801094b5:	00 00 00 
      shmTable.allRegions[index].buffer.shm_nattch = 0;
801094b8:	c7 80 70 d8 12 80 00 	movl   $0x0,-0x7fed2790(%eax)
801094bf:	00 00 00 
      shmTable.allRegions[index].buffer.shm_segsz = 0;
801094c2:	c7 80 6c d8 12 80 00 	movl   $0x0,-0x7fed2794(%eax)
801094c9:	00 00 00 
      shmTable.allRegions[index].buffer.shm_perm.__key = -1;
801094cc:	c7 80 64 d8 12 80 ff 	movl   $0xffffffff,-0x7fed279c(%eax)
801094d3:	ff ff ff 
      shmTable.allRegions[index].buffer.shm_perm.mode = 0;
801094d6:	c7 80 68 d8 12 80 00 	movl   $0x0,-0x7fed2798(%eax)
801094dd:	00 00 00 
      shmTable.allRegions[index].buffer.shm_cpid = -1;
801094e0:	c7 80 74 d8 12 80 ff 	movl   $0xffffffff,-0x7fed278c(%eax)
801094e7:	ff ff ff 
      shmTable.allRegions[index].buffer.shm_lpid = -1;
801094ea:	c7 80 78 d8 12 80 ff 	movl   $0xffffffff,-0x7fed2788(%eax)
801094f1:	ff ff ff 
801094f4:	e9 f4 fe ff ff       	jmp    801093ed <shmdt+0x10d>
801094f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80109500 <shmat>:

// attaches shared memory segment identified by shmid to the virtual address shmaddr 
// if provided; otherwise attach at the first fitting address 
void*
shmat(int shmid, void* shmaddr, int shmflag) {
80109500:	f3 0f 1e fb          	endbr32 
80109504:	55                   	push   %ebp
80109505:	89 e5                	mov    %esp,%ebp
80109507:	57                   	push   %edi
80109508:	56                   	push   %esi
80109509:	53                   	push   %ebx
8010950a:	83 ec 2c             	sub    $0x2c,%esp
  if(shmid < 0 || shmid > 64) {
8010950d:	83 7d 08 40          	cmpl   $0x40,0x8(%ebp)
shmat(int shmid, void* shmaddr, int shmflag) {
80109511:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(shmid < 0 || shmid > 64) {
80109514:	76 0f                	jbe    80109525 <shmat+0x25>
    return (void*)-1;
80109516:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    release(&shmTable.lock);
    return (void*)-1; // all page regions exhausted
  }
  release(&shmTable.lock);
  return va;
}
8010951b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010951e:	89 f8                	mov    %edi,%eax
80109520:	5b                   	pop    %ebx
80109521:	5e                   	pop    %esi
80109522:	5f                   	pop    %edi
80109523:	5d                   	pop    %ebp
80109524:	c3                   	ret    
  acquire(&shmTable.lock);
80109525:	83 ec 0c             	sub    $0xc,%esp
80109528:	68 20 d7 12 80       	push   $0x8012d720
8010952d:	e8 6e c8 ff ff       	call   80105da0 <acquire>
  struct proc *process = myproc();
80109532:	e8 39 aa ff ff       	call   80103f70 <myproc>
  if(index == -1) {
80109537:	83 c4 10             	add    $0x10,%esp
  struct proc *process = myproc();
8010953a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  index = shmTable.allRegions[shmid].shmid;
8010953d:	69 45 08 28 01 00 00 	imul   $0x128,0x8(%ebp),%eax
80109544:	8b 80 5c d7 12 80    	mov    -0x7fed28a4(%eax),%eax
8010954a:	89 45 cc             	mov    %eax,-0x34(%ebp)
  if(index == -1) {
8010954d:	83 f8 ff             	cmp    $0xffffffff,%eax
80109550:	0f 84 19 02 00 00    	je     8010976f <shmat+0x26f>
  if(shmaddr) {
80109556:	85 db                	test   %ebx,%ebx
80109558:	0f 84 70 02 00 00    	je     801097ce <shmat+0x2ce>
    if((uint)shmaddr >= KERNBASE || (uint)shmaddr < HEAPLIMIT) {
8010955e:	0f 88 0b 02 00 00    	js     8010976f <shmat+0x26f>
80109564:	81 fb ff ff ff 7e    	cmp    $0x7effffff,%ebx
8010956a:	0f 86 ff 01 00 00    	jbe    8010976f <shmat+0x26f>
    uint rounded = ((uint)shmaddr & ~(SHMLBA-1));  
80109570:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
80109577:	89 de                	mov    %ebx,%esi
80109579:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
8010957f:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if(shmflag & SHM_RND) {
80109582:	8b b8 58 d7 12 80    	mov    -0x7fed28a8(%eax),%edi
80109588:	89 f8                	mov    %edi,%eax
8010958a:	c1 e0 0c             	shl    $0xc,%eax
8010958d:	f7 45 10 00 20 00 00 	testl  $0x2000,0x10(%ebp)
80109594:	0f 85 f4 01 00 00    	jne    8010978e <shmat+0x28e>
      if(rounded == (uint)shmaddr) {  
8010959a:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
8010959d:	0f 84 7b 03 00 00    	je     8010991e <shmat+0x41e>
801095a3:	05 00 00 00 7f       	add    $0x7f000000,%eax
801095a8:	c7 45 e4 00 00 00 7f 	movl   $0x7f000000,-0x1c(%ebp)
  void *va = (void*)HEAPLIMIT, *least_va;
801095af:	bf 00 00 00 7f       	mov    $0x7f000000,%edi
801095b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if((uint)va + shmTable.allRegions[index].size*PGSIZE >= KERNBASE) {
801095b7:	8b 55 dc             	mov    -0x24(%ebp),%edx
801095ba:	85 d2                	test   %edx,%edx
801095bc:	0f 88 ad 01 00 00    	js     8010976f <shmat+0x26f>
801095c2:	8b 75 e0             	mov    -0x20(%ebp),%esi
801095c5:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801095c8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801095cb:	8d 86 ac 00 00 00    	lea    0xac(%esi),%eax
801095d1:	8d 8e ac 05 00 00    	lea    0x5ac(%esi),%ecx
801095d7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801095da:	eb 0f                	jmp    801095eb <shmat+0xeb>
801095dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < SHAREDREGIONS; i++) {
801095e0:	83 c0 14             	add    $0x14,%eax
801095e3:	39 c1                	cmp    %eax,%ecx
801095e5:	0f 84 af 01 00 00    	je     8010979a <shmat+0x29a>
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr + process->pages[i].size*PGSIZE > (uint)va && (uint)va >= (uint)process->pages[i].virtualAddr)  {
801095eb:	83 38 ff             	cmpl   $0xffffffff,(%eax)
801095ee:	74 f0                	je     801095e0 <shmat+0xe0>
801095f0:	8b 58 04             	mov    0x4(%eax),%ebx
801095f3:	8b 70 10             	mov    0x10(%eax),%esi
801095f6:	89 da                	mov    %ebx,%edx
801095f8:	c1 e2 0c             	shl    $0xc,%edx
801095fb:	01 f2                	add    %esi,%edx
801095fd:	39 fa                	cmp    %edi,%edx
801095ff:	76 df                	jbe    801095e0 <shmat+0xe0>
80109601:	39 fe                	cmp    %edi,%esi
80109603:	77 db                	ja     801095e0 <shmat+0xe0>
80109605:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    if(shmflag & SHM_REMAP) {
80109608:	f7 45 10 00 40 00 00 	testl  $0x4000,0x10(%ebp)
8010960f:	0f 84 5a 01 00 00    	je     8010976f <shmat+0x26f>
      while(segment < (uint)va + shmTable.allRegions[index].size*PGSIZE) { 
80109615:	3b 75 dc             	cmp    -0x24(%ebp),%esi
80109618:	0f 83 7f 01 00 00    	jae    8010979d <shmat+0x29d>
8010961e:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
80109625:	89 7d d0             	mov    %edi,-0x30(%ebp)
80109628:	05 20 d7 12 80       	add    $0x8012d720,%eax
8010962d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        release(&shmTable.lock);
80109630:	83 ec 0c             	sub    $0xc,%esp
80109633:	68 20 d7 12 80       	push   $0x8012d720
80109638:	e8 23 c8 ff ff       	call   80105e60 <release>
        if(shmdt((void*)segment) == -1) {
8010963d:	89 34 24             	mov    %esi,(%esp)
80109640:	e8 9b fc ff ff       	call   801092e0 <shmdt>
80109645:	83 c4 10             	add    $0x10,%esp
80109648:	83 f8 ff             	cmp    $0xffffffff,%eax
8010964b:	0f 84 c5 fe ff ff    	je     80109516 <shmat+0x16>
        acquire(&shmTable.lock);        
80109651:	83 ec 0c             	sub    $0xc,%esp
        idx = getLeastvaidx((void*)(segment + size*PGSIZE),process);
80109654:	c1 e3 0c             	shl    $0xc,%ebx
  int idx = -1;
80109657:	bf ff ff ff ff       	mov    $0xffffffff,%edi
        acquire(&shmTable.lock);        
8010965c:	68 20 d7 12 80       	push   $0x8012d720
        idx = getLeastvaidx((void*)(segment + size*PGSIZE),process);
80109661:	01 f3                	add    %esi,%ebx
  void* leastva = (void*)(KERNBASE - 1);
80109663:	be ff ff ff 7f       	mov    $0x7fffffff,%esi
        acquire(&shmTable.lock);        
80109668:	e8 33 c7 ff ff       	call   80105da0 <acquire>
        idx = getLeastvaidx((void*)(segment + size*PGSIZE),process);
8010966d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80109670:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109673:	31 d2                	xor    %edx,%edx
80109675:	8d 76 00             	lea    0x0(%esi),%esi
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr >= (uint)curr_va && (uint)leastva >= (uint)process->pages[i].virtualAddr) {  
80109678:	83 38 ff             	cmpl   $0xffffffff,(%eax)
8010967b:	74 13                	je     80109690 <shmat+0x190>
8010967d:	8b 48 10             	mov    0x10(%eax),%ecx
80109680:	39 cb                	cmp    %ecx,%ebx
80109682:	77 0c                	ja     80109690 <shmat+0x190>
80109684:	39 ce                	cmp    %ecx,%esi
80109686:	72 08                	jb     80109690 <shmat+0x190>
80109688:	89 d7                	mov    %edx,%edi
      leastva = process->pages[i].virtualAddr;
8010968a:	89 ce                	mov    %ecx,%esi
8010968c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109690:	83 c2 01             	add    $0x1,%edx
80109693:	83 c0 14             	add    $0x14,%eax
80109696:	83 fa 40             	cmp    $0x40,%edx
80109699:	75 dd                	jne    80109678 <shmat+0x178>
        if(idx == -1)
8010969b:	83 ff ff             	cmp    $0xffffffff,%edi
8010969e:	0f 84 d8 01 00 00    	je     8010987c <shmat+0x37c>
        segment = (uint)process->pages[idx].virtualAddr;
801096a4:	8b 75 e0             	mov    -0x20(%ebp),%esi
801096a7:	8d 04 bf             	lea    (%edi,%edi,4),%eax
801096aa:	8d 14 86             	lea    (%esi,%eax,4),%edx
      while(segment < (uint)va + shmTable.allRegions[index].size*PGSIZE) { 
801096ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        segment = (uint)process->pages[idx].virtualAddr;
801096b0:	8b b2 bc 00 00 00    	mov    0xbc(%edx),%esi
      while(segment < (uint)va + shmTable.allRegions[index].size*PGSIZE) { 
801096b6:	8b 40 38             	mov    0x38(%eax),%eax
801096b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
801096bc:	c1 e0 0c             	shl    $0xc,%eax
801096bf:	03 45 e4             	add    -0x1c(%ebp),%eax
801096c2:	39 f0                	cmp    %esi,%eax
801096c4:	0f 86 b2 01 00 00    	jbe    8010987c <shmat+0x37c>
801096ca:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
801096d0:	e9 5b ff ff ff       	jmp    80109630 <shmat+0x130>
    permflag = PTE_U;
801096d5:	c7 45 dc 04 00 00 00 	movl   $0x4,-0x24(%ebp)
  for (int k = 0; k < shmTable.allRegions[index].size; k++) {
801096dc:	69 4d cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%ecx
801096e3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801096e6:	31 db                	xor    %ebx,%ebx
801096e8:	8d 81 20 d7 12 80    	lea    -0x7fed28e0(%ecx),%eax
801096ee:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
801096f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
801096f4:	8b 81 58 d7 12 80    	mov    -0x7fed28a8(%ecx),%eax
801096fa:	85 c0                	test   %eax,%eax
801096fc:	0f 84 8d 01 00 00    	je     8010988f <shmat+0x38f>
80109702:	89 7d c8             	mov    %edi,-0x38(%ebp)
80109705:	8b 7d e0             	mov    -0x20(%ebp),%edi
80109708:	eb 1b                	jmp    80109725 <shmat+0x225>
8010970a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80109710:	8b 45 d0             	mov    -0x30(%ebp),%eax
80109713:	83 c3 01             	add    $0x1,%ebx
80109716:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010971c:	39 58 38             	cmp    %ebx,0x38(%eax)
8010971f:	0f 86 67 01 00 00    	jbe    8010988c <shmat+0x38c>
		if(mappages(process->pgdir, (void*)((uint)va + (k*PGSIZE)), PGSIZE, (uint)shmTable.allRegions[index].physicalAddr[k], permflag) < 0) {
80109725:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80109728:	83 ec 08             	sub    $0x8,%esp
8010972b:	8b 47 04             	mov    0x4(%edi),%eax
8010972e:	ff 75 dc             	pushl  -0x24(%ebp)
80109731:	89 f2                	mov    %esi,%edx
80109733:	ff b4 99 64 d7 12 80 	pushl  -0x7fed289c(%ecx,%ebx,4)
8010973a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010973f:	e8 0c f0 ff ff       	call   80108750 <mappages>
80109744:	83 c4 10             	add    $0x10,%esp
80109747:	85 c0                	test   %eax,%eax
80109749:	79 c5                	jns    80109710 <shmat+0x210>
      deallocuvm(process->pgdir,(uint)va,(uint)(va + shmTable.allRegions[index].size));
8010974b:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
  if(newsz >= oldsz)
80109752:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109755:	8b 7d c8             	mov    -0x38(%ebp),%edi
      deallocuvm(process->pgdir,(uint)va,(uint)(va + shmTable.allRegions[index].size));
80109758:	03 b8 58 d7 12 80    	add    -0x7fed28a8(%eax),%edi
8010975e:	89 f9                	mov    %edi,%ecx
  if(newsz >= oldsz)
80109760:	39 d7                	cmp    %edx,%edi
80109762:	73 0b                	jae    8010976f <shmat+0x26f>
80109764:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109767:	8b 40 04             	mov    0x4(%eax),%eax
8010976a:	e8 71 f0 ff ff       	call   801087e0 <deallocuvm.part.0>
    release(&shmTable.lock);
8010976f:	83 ec 0c             	sub    $0xc,%esp
    return (void*)-1;
80109772:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    release(&shmTable.lock);
80109777:	68 20 d7 12 80       	push   $0x8012d720
8010977c:	e8 df c6 ff ff       	call   80105e60 <release>
    return (void*)-1;
80109781:	83 c4 10             	add    $0x10,%esp
}
80109784:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109787:	89 f8                	mov    %edi,%eax
80109789:	5b                   	pop    %ebx
8010978a:	5e                   	pop    %esi
8010978b:	5f                   	pop    %edi
8010978c:	5d                   	pop    %ebp
8010978d:	c3                   	ret    
      va = (void*)rounded;
8010978e:	01 f0                	add    %esi,%eax
80109790:	89 f7                	mov    %esi,%edi
80109792:	89 45 dc             	mov    %eax,-0x24(%ebp)
80109795:	e9 1d fe ff ff       	jmp    801095b7 <shmat+0xb7>
8010979a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  if((shmflag & SHM_RDONLY) || (shmTable.allRegions[index].buffer.shm_perm.mode == READ_SHM)){
8010979d:	f7 45 10 00 10 00 00 	testl  $0x1000,0x10(%ebp)
801097a4:	0f 85 2b ff ff ff    	jne    801096d5 <shmat+0x1d5>
801097aa:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
801097b1:	8b 80 68 d8 12 80    	mov    -0x7fed2798(%eax),%eax
801097b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801097ba:	83 f8 04             	cmp    $0x4,%eax
801097bd:	0f 84 19 ff ff ff    	je     801096dc <shmat+0x1dc>
  else if (shmTable.allRegions[index].buffer.shm_perm.mode == RW_SHM) {
801097c3:	83 f8 06             	cmp    $0x6,%eax
801097c6:	0f 84 10 ff ff ff    	je     801096dc <shmat+0x1dc>
801097cc:	eb a1                	jmp    8010976f <shmat+0x26f>
801097ce:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
  if(shmaddr) {
801097d5:	c7 45 d4 40 00 00 00 	movl   $0x40,-0x2c(%ebp)
  void *va = (void*)HEAPLIMIT, *least_va;
801097dc:	bf 00 00 00 7f       	mov    $0x7f000000,%edi
801097e1:	8b 80 58 d7 12 80    	mov    -0x7fed28a8(%eax),%eax
801097e7:	c1 e0 0c             	shl    $0xc,%eax
801097ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
801097ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
801097f0:	05 ac 00 00 00       	add    $0xac,%eax
801097f5:	89 45 d8             	mov    %eax,-0x28(%ebp)
801097f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801097ff:	90                   	nop
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109800:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80109803:	8b 45 d8             	mov    -0x28(%ebp),%eax
  int idx = -1;
80109806:	be ff ff ff ff       	mov    $0xffffffff,%esi
  void* leastva = (void*)(KERNBASE - 1);
8010980b:	bb ff ff ff 7f       	mov    $0x7fffffff,%ebx
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109810:	31 d2                	xor    %edx,%edx
80109812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(process->pages[i].key != -1 && (uint)process->pages[i].virtualAddr >= (uint)curr_va && (uint)leastva >= (uint)process->pages[i].virtualAddr) {  
80109818:	83 38 ff             	cmpl   $0xffffffff,(%eax)
8010981b:	74 13                	je     80109830 <shmat+0x330>
8010981d:	8b 48 10             	mov    0x10(%eax),%ecx
80109820:	39 f9                	cmp    %edi,%ecx
80109822:	72 0c                	jb     80109830 <shmat+0x330>
80109824:	39 cb                	cmp    %ecx,%ebx
80109826:	72 08                	jb     80109830 <shmat+0x330>
80109828:	89 d6                	mov    %edx,%esi
      leastva = process->pages[i].virtualAddr;
8010982a:	89 cb                	mov    %ecx,%ebx
8010982c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109830:	83 c2 01             	add    $0x1,%edx
80109833:	83 c0 14             	add    $0x14,%eax
80109836:	83 fa 40             	cmp    $0x40,%edx
80109839:	75 dd                	jne    80109818 <shmat+0x318>
      if(idx != -1) {
8010983b:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010983e:	8d 14 07             	lea    (%edi,%eax,1),%edx
80109841:	83 fe ff             	cmp    $0xffffffff,%esi
80109844:	74 3e                	je     80109884 <shmat+0x384>
        least_va = process->pages[idx].virtualAddr;
80109846:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80109849:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010984c:	8d 0c 86             	lea    (%esi,%eax,4),%ecx
        if((uint)va + shmTable.allRegions[index].size*PGSIZE <=  (uint)least_va)        
8010984f:	8b 81 bc 00 00 00    	mov    0xbc(%ecx),%eax
80109855:	39 d0                	cmp    %edx,%eax
80109857:	73 2b                	jae    80109884 <shmat+0x384>
          va = (void*)((uint)least_va + process->pages[idx].size*PGSIZE);
80109859:	8b 91 b0 00 00 00    	mov    0xb0(%ecx),%edx
8010985f:	c1 e2 0c             	shl    $0xc,%edx
80109862:	01 d0                	add    %edx,%eax
    for(int i = 0; i < SHAREDREGIONS; i++) {
80109864:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
          va = (void*)((uint)least_va + process->pages[idx].size*PGSIZE);
80109868:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010986b:	89 c7                	mov    %eax,%edi
    for(int i = 0; i < SHAREDREGIONS; i++) {
8010986d:	75 91                	jne    80109800 <shmat+0x300>
8010986f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80109872:	01 f8                	add    %edi,%eax
80109874:	89 45 dc             	mov    %eax,-0x24(%ebp)
80109877:	e9 3b fd ff ff       	jmp    801095b7 <shmat+0xb7>
8010987c:	8b 7d d0             	mov    -0x30(%ebp),%edi
8010987f:	e9 19 ff ff ff       	jmp    8010979d <shmat+0x29d>
80109884:	89 55 dc             	mov    %edx,-0x24(%ebp)
80109887:	e9 2b fd ff ff       	jmp    801095b7 <shmat+0xb7>
8010988c:	8b 7d c8             	mov    -0x38(%ebp),%edi
8010988f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109892:	31 c0                	xor    %eax,%eax
80109894:	eb 19                	jmp    801098af <shmat+0x3af>
80109896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010989d:	8d 76 00             	lea    0x0(%esi),%esi
801098a0:	83 c0 01             	add    $0x1,%eax
801098a3:	83 c2 14             	add    $0x14,%edx
801098a6:	83 f8 40             	cmp    $0x40,%eax
801098a9:	0f 84 c0 fe ff ff    	je     8010976f <shmat+0x26f>
    if(process->pages[i].key == -1) {
801098af:	83 3a ff             	cmpl   $0xffffffff,(%edx)
801098b2:	75 ec                	jne    801098a0 <shmat+0x3a0>
    process->pages[idx].shmid = shmid;  
801098b4:	8b 75 e0             	mov    -0x20(%ebp),%esi
801098b7:	8d 04 80             	lea    (%eax,%eax,4),%eax
    process->pages[idx].perm = permflag;
801098ba:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  release(&shmTable.lock);
801098bd:	83 ec 0c             	sub    $0xc,%esp
    process->pages[idx].shmid = shmid;  
801098c0:	8d 14 86             	lea    (%esi,%eax,4),%edx
801098c3:	8b 45 08             	mov    0x8(%ebp),%eax
    process->pages[idx].virtualAddr = va;
801098c6:	89 ba bc 00 00 00    	mov    %edi,0xbc(%edx)
    process->pages[idx].shmid = shmid;  
801098cc:	89 82 b4 00 00 00    	mov    %eax,0xb4(%edx)
    process->pages[idx].key = shmTable.allRegions[index].key;
801098d2:	69 45 cc 28 01 00 00 	imul   $0x128,-0x34(%ebp),%eax
801098d9:	8b 88 54 d7 12 80    	mov    -0x7fed28ac(%eax),%ecx
801098df:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
    process->pages[idx].size = shmTable.allRegions[index].size;
801098e5:	8b 88 58 d7 12 80    	mov    -0x7fed28a8(%eax),%ecx
    process->pages[idx].key = shmTable.allRegions[index].key;
801098eb:	05 20 d7 12 80       	add    $0x8012d720,%eax
    process->pages[idx].perm = permflag;
801098f0:	89 9a b8 00 00 00    	mov    %ebx,0xb8(%edx)
    process->pages[idx].size = shmTable.allRegions[index].size;
801098f6:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
    shmTable.allRegions[index].buffer.shm_nattch += 1;
801098fc:	83 80 50 01 00 00 01 	addl   $0x1,0x150(%eax)
    shmTable.allRegions[index].buffer.shm_lpid = process->pid;
80109903:	8b 56 10             	mov    0x10(%esi),%edx
80109906:	89 90 58 01 00 00    	mov    %edx,0x158(%eax)
  release(&shmTable.lock);
8010990c:	68 20 d7 12 80       	push   $0x8012d720
80109911:	e8 4a c5 ff ff       	call   80105e60 <release>
  return va;
80109916:	83 c4 10             	add    $0x10,%esp
80109919:	e9 fd fb ff ff       	jmp    8010951b <shmat+0x1b>
        va = shmaddr;    
8010991e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80109921:	01 f8                	add    %edi,%eax
80109923:	89 45 dc             	mov    %eax,-0x24(%ebp)
80109926:	e9 8c fc ff ff       	jmp    801095b7 <shmat+0xb7>
8010992b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010992f:	90                   	nop

80109930 <shmctl>:
  Controls the shared memory regions corresponding to shmid,
  depending upon the cmd (command) provided and buf parameter,
  which is user equivalent of shmid_ds data structure
*/
int
shmctl(int shmid, int cmd, void *buf) {
80109930:	f3 0f 1e fb          	endbr32 
80109934:	55                   	push   %ebp
80109935:	89 e5                	mov    %esp,%ebp
80109937:	57                   	push   %edi
80109938:	56                   	push   %esi
80109939:	53                   	push   %ebx
8010993a:	83 ec 1c             	sub    $0x1c,%esp
8010993d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80109940:	8b 7d 0c             	mov    0xc(%ebp),%edi
80109943:	8b 75 10             	mov    0x10(%ebp),%esi
  // check shmid bound
  if(shmid < 0 || shmid > 64){
80109946:	83 fb 40             	cmp    $0x40,%ebx
80109949:	0f 87 e9 01 00 00    	ja     80109b38 <shmctl+0x208>
    return -1;
  }

  acquire(&shmTable.lock);
8010994f:	83 ec 0c             	sub    $0xc,%esp

  struct shmid_ds *buffer = (struct shmid_ds *)buf;

  int index = -1;
  index = shmTable.allRegions[shmid].shmid;
80109952:	69 db 28 01 00 00    	imul   $0x128,%ebx,%ebx
  acquire(&shmTable.lock);
80109958:	68 20 d7 12 80       	push   $0x8012d720
8010995d:	e8 3e c4 ff ff       	call   80105da0 <acquire>
  index = shmTable.allRegions[shmid].shmid;
80109962:	8b 9b 5c d7 12 80    	mov    -0x7fed28a4(%ebx),%ebx
  // check for valid shmid
  if(index == -1) {
80109968:	83 c4 10             	add    $0x10,%esp
8010996b:	83 fb ff             	cmp    $0xffffffff,%ebx
8010996e:	0f 84 6c 01 00 00    	je     80109ae0 <shmctl+0x1b0>
    release(&shmTable.lock);
    return -1;
  } else {
    // get permissions on region with provided shmid
    int checkPerm = shmTable.allRegions[index].buffer.shm_perm.mode;
    switch(cmd) {
80109974:	83 ff 01             	cmp    $0x1,%edi
80109977:	0f 84 83 01 00 00    	je     80109b00 <shmctl+0x1d0>
8010997d:	0f 8e 85 00 00 00    	jle    80109a08 <shmctl+0xd8>
80109983:	83 ff 02             	cmp    $0x2,%edi
80109986:	74 09                	je     80109991 <shmctl+0x61>
80109988:	83 ff 0d             	cmp    $0xd,%edi
8010998b:	0f 85 4f 01 00 00    	jne    80109ae0 <shmctl+0x1b0>
        both will have same check on xv6 as there is only a single user
      */
      case SHM_STAT:
      case IPC_STAT:
        // check valid permissions
        if(buffer && (checkPerm == READ_SHM || checkPerm == RW_SHM)) {
80109991:	85 f6                	test   %esi,%esi
80109993:	0f 84 47 01 00 00    	je     80109ae0 <shmctl+0x1b0>
    int checkPerm = shmTable.allRegions[index].buffer.shm_perm.mode;
80109999:	69 db 28 01 00 00    	imul   $0x128,%ebx,%ebx
8010999f:	8b 83 68 d8 12 80    	mov    -0x7fed2798(%ebx),%eax
801099a5:	81 c3 20 d7 12 80    	add    $0x8012d720,%ebx
        if(buffer && (checkPerm == READ_SHM || checkPerm == RW_SHM)) {
801099ab:	89 c2                	mov    %eax,%edx
801099ad:	83 e2 fd             	and    $0xfffffffd,%edx
801099b0:	83 fa 04             	cmp    $0x4,%edx
801099b3:	0f 85 27 01 00 00    	jne    80109ae0 <shmctl+0x1b0>
          buffer->shm_nattch = shmTable.allRegions[index].buffer.shm_nattch;
801099b9:	8b 93 50 01 00 00    	mov    0x150(%ebx),%edx
801099bf:	89 56 0c             	mov    %edx,0xc(%esi)
          buffer->shm_segsz = shmTable.allRegions[index].buffer.shm_segsz;
801099c2:	8b 93 4c 01 00 00    	mov    0x14c(%ebx),%edx
801099c8:	89 56 08             	mov    %edx,0x8(%esi)
          buffer->shm_perm.__key = shmTable.allRegions[index].buffer.shm_perm.__key;
801099cb:	8b 93 44 01 00 00    	mov    0x144(%ebx),%edx
          buffer->shm_perm.mode = checkPerm;
801099d1:	89 46 04             	mov    %eax,0x4(%esi)
          buffer->shm_perm.__key = shmTable.allRegions[index].buffer.shm_perm.__key;
801099d4:	89 16                	mov    %edx,(%esi)
          buffer->shm_cpid = shmTable.allRegions[index].buffer.shm_cpid;
801099d6:	8b 83 54 01 00 00    	mov    0x154(%ebx),%eax
801099dc:	89 46 10             	mov    %eax,0x10(%esi)
          buffer->shm_lpid = shmTable.allRegions[index].buffer.shm_lpid;
801099df:	8b 83 58 01 00 00    	mov    0x158(%ebx),%eax
801099e5:	89 46 14             	mov    %eax,0x14(%esi)
          shmTable.allRegions[index].buffer.shm_lpid = -1;
        } else {
          // mark the segment to be destroyed
          shmTable.allRegions[index].toBeDeleted = 1;
        }
        release(&shmTable.lock);
801099e8:	83 ec 0c             	sub    $0xc,%esp
801099eb:	68 20 d7 12 80       	push   $0x8012d720
801099f0:	e8 6b c4 ff ff       	call   80105e60 <release>
        return 0;
801099f5:	83 c4 10             	add    $0x10,%esp
801099f8:	31 c0                	xor    %eax,%eax
        release(&shmTable.lock);
        return -1;
        break;
    }
  } 
}
801099fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801099fd:	5b                   	pop    %ebx
801099fe:	5e                   	pop    %esi
801099ff:	5f                   	pop    %edi
80109a00:	5d                   	pop    %ebp
80109a01:	c3                   	ret    
80109a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(cmd) {
80109a08:	85 ff                	test   %edi,%edi
80109a0a:	0f 85 d0 00 00 00    	jne    80109ae0 <shmctl+0x1b0>
        if(shmTable.allRegions[index].buffer.shm_nattch == 0) {
80109a10:	69 d3 28 01 00 00    	imul   $0x128,%ebx,%edx
80109a16:	8d ba 20 d7 12 80    	lea    -0x7fed28e0(%edx),%edi
80109a1c:	8b b7 50 01 00 00    	mov    0x150(%edi),%esi
80109a22:	85 f6                	test   %esi,%esi
80109a24:	0f 85 fe 00 00 00    	jne    80109b28 <shmctl+0x1f8>
          for(int i = 0; i < shmTable.allRegions[index].size; i++) {
80109a2a:	8b 47 38             	mov    0x38(%edi),%eax
80109a2d:	85 c0                	test   %eax,%eax
80109a2f:	74 38                	je     80109a69 <shmctl+0x139>
80109a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
80109a38:	8b 84 b2 64 d7 12 80 	mov    -0x7fed289c(%edx,%esi,4),%eax
            kfree(addr);
80109a3f:	83 ec 0c             	sub    $0xc,%esp
            char *addr = (char *)P2V(shmTable.allRegions[index].physicalAddr[i]);
80109a42:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80109a45:	05 00 00 00 80       	add    $0x80000000,%eax
            kfree(addr);
80109a4a:	50                   	push   %eax
80109a4b:	e8 90 8f ff ff       	call   801029e0 <kfree>
            shmTable.allRegions[index].physicalAddr[i] = (void *)0;
80109a50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
          for(int i = 0; i < shmTable.allRegions[index].size; i++) {
80109a53:	83 c4 10             	add    $0x10,%esp
            shmTable.allRegions[index].physicalAddr[i] = (void *)0;
80109a56:	c7 84 b2 64 d7 12 80 	movl   $0x0,-0x7fed289c(%edx,%esi,4)
80109a5d:	00 00 00 00 
          for(int i = 0; i < shmTable.allRegions[index].size; i++) {
80109a61:	83 c6 01             	add    $0x1,%esi
80109a64:	39 77 38             	cmp    %esi,0x38(%edi)
80109a67:	77 cf                	ja     80109a38 <shmctl+0x108>
          shmTable.allRegions[index].size = 0;
80109a69:	69 db 28 01 00 00    	imul   $0x128,%ebx,%ebx
80109a6f:	c7 83 58 d7 12 80 00 	movl   $0x0,-0x7fed28a8(%ebx)
80109a76:	00 00 00 
          shmTable.allRegions[index].key = shmTable.allRegions[index].shmid = -1;
80109a79:	c7 83 5c d7 12 80 ff 	movl   $0xffffffff,-0x7fed28a4(%ebx)
80109a80:	ff ff ff 
80109a83:	c7 83 54 d7 12 80 ff 	movl   $0xffffffff,-0x7fed28ac(%ebx)
80109a8a:	ff ff ff 
          shmTable.allRegions[index].toBeDeleted = 0;
80109a8d:	c7 83 60 d7 12 80 00 	movl   $0x0,-0x7fed28a0(%ebx)
80109a94:	00 00 00 
          shmTable.allRegions[index].buffer.shm_nattch = 0;
80109a97:	c7 83 70 d8 12 80 00 	movl   $0x0,-0x7fed2790(%ebx)
80109a9e:	00 00 00 
          shmTable.allRegions[index].buffer.shm_segsz = 0;
80109aa1:	c7 83 6c d8 12 80 00 	movl   $0x0,-0x7fed2794(%ebx)
80109aa8:	00 00 00 
          shmTable.allRegions[index].buffer.shm_perm.__key = -1;
80109aab:	c7 83 64 d8 12 80 ff 	movl   $0xffffffff,-0x7fed279c(%ebx)
80109ab2:	ff ff ff 
          shmTable.allRegions[index].buffer.shm_perm.mode = 0;
80109ab5:	c7 83 68 d8 12 80 00 	movl   $0x0,-0x7fed2798(%ebx)
80109abc:	00 00 00 
          shmTable.allRegions[index].buffer.shm_cpid = -1;
80109abf:	c7 83 74 d8 12 80 ff 	movl   $0xffffffff,-0x7fed278c(%ebx)
80109ac6:	ff ff ff 
          shmTable.allRegions[index].buffer.shm_lpid = -1;
80109ac9:	c7 83 78 d8 12 80 ff 	movl   $0xffffffff,-0x7fed2788(%ebx)
80109ad0:	ff ff ff 
80109ad3:	e9 10 ff ff ff       	jmp    801099e8 <shmctl+0xb8>
80109ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109adf:	90                   	nop
        release(&shmTable.lock);
80109ae0:	83 ec 0c             	sub    $0xc,%esp
80109ae3:	68 20 d7 12 80       	push   $0x8012d720
80109ae8:	e8 73 c3 ff ff       	call   80105e60 <release>
        return -1;
80109aed:	83 c4 10             	add    $0x10,%esp
}
80109af0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80109af3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80109af8:	5b                   	pop    %ebx
80109af9:	5e                   	pop    %esi
80109afa:	5f                   	pop    %edi
80109afb:	5d                   	pop    %ebp
80109afc:	c3                   	ret    
80109afd:	8d 76 00             	lea    0x0(%esi),%esi
        if(buffer) {
80109b00:	85 f6                	test   %esi,%esi
80109b02:	74 dc                	je     80109ae0 <shmctl+0x1b0>
          if((buffer->shm_perm.mode == READ_SHM) || (buffer->shm_perm.mode == RW_SHM)) {
80109b04:	8b 46 04             	mov    0x4(%esi),%eax
80109b07:	89 c2                	mov    %eax,%edx
80109b09:	83 e2 fd             	and    $0xfffffffd,%edx
80109b0c:	83 fa 04             	cmp    $0x4,%edx
80109b0f:	75 cf                	jne    80109ae0 <shmctl+0x1b0>
            shmTable.allRegions[index].buffer.shm_perm.mode = buffer->shm_perm.mode;
80109b11:	69 db 28 01 00 00    	imul   $0x128,%ebx,%ebx
80109b17:	89 83 68 d8 12 80    	mov    %eax,-0x7fed2798(%ebx)
            release(&shmTable.lock);
80109b1d:	e9 c6 fe ff ff       	jmp    801099e8 <shmctl+0xb8>
80109b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          shmTable.allRegions[index].toBeDeleted = 1;
80109b28:	c7 47 40 01 00 00 00 	movl   $0x1,0x40(%edi)
80109b2f:	e9 b4 fe ff ff       	jmp    801099e8 <shmctl+0xb8>
80109b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80109b38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        break;
80109b3d:	e9 b8 fe ff ff       	jmp    801099fa <shmctl+0xca>
80109b42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80109b50 <sharedMemoryInit>:

// to initialize shared memory table
void
sharedMemoryInit(void) {
80109b50:	f3 0f 1e fb          	endbr32 
80109b54:	55                   	push   %ebp
80109b55:	89 e5                	mov    %esp,%ebp
80109b57:	83 ec 10             	sub    $0x10,%esp
  // initialize shmtable lock
  initlock(&shmTable.lock, "Shared Memory");
80109b5a:	68 5c aa 10 80       	push   $0x8010aa5c
80109b5f:	68 20 d7 12 80       	push   $0x8012d720
80109b64:	e8 b7 c0 ff ff       	call   80105c20 <initlock>
  acquire(&shmTable.lock);
80109b69:	c7 04 24 20 d7 12 80 	movl   $0x8012d720,(%esp)
80109b70:	e8 2b c2 ff ff       	call   80105da0 <acquire>
  // initialize all shmtable values
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109b75:	ba 64 d8 12 80       	mov    $0x8012d864,%edx
80109b7a:	83 c4 10             	add    $0x10,%esp
80109b7d:	8d 76 00             	lea    0x0(%esi),%esi
    shmTable.allRegions[i].key = shmTable.allRegions[i].shmid = -1;
80109b80:	c7 82 f8 fe ff ff ff 	movl   $0xffffffff,-0x108(%edx)
80109b87:	ff ff ff 
80109b8a:	8d 82 00 ff ff ff    	lea    -0x100(%edx),%eax
80109b90:	c7 82 f0 fe ff ff ff 	movl   $0xffffffff,-0x110(%edx)
80109b97:	ff ff ff 
    shmTable.allRegions[i].size = 0;
80109b9a:	c7 82 f4 fe ff ff 00 	movl   $0x0,-0x10c(%edx)
80109ba1:	00 00 00 
    shmTable.allRegions[i].toBeDeleted = 0;
80109ba4:	c7 82 fc fe ff ff 00 	movl   $0x0,-0x104(%edx)
80109bab:	00 00 00 
    shmTable.allRegions[i].buffer.shm_nattch = 0;
80109bae:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    shmTable.allRegions[i].buffer.shm_segsz = 0;
80109bb5:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    shmTable.allRegions[i].buffer.shm_perm.__key = -1;
80109bbc:	c7 02 ff ff ff ff    	movl   $0xffffffff,(%edx)
    shmTable.allRegions[i].buffer.shm_perm.mode = 0;
80109bc2:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
    shmTable.allRegions[i].buffer.shm_cpid = -1;
80109bc9:	c7 42 10 ff ff ff ff 	movl   $0xffffffff,0x10(%edx)
    shmTable.allRegions[i].buffer.shm_lpid = -1;
80109bd0:	c7 42 14 ff ff ff ff 	movl   $0xffffffff,0x14(%edx)
    for(int j = 0; j < SHAREDREGIONS; j++) {
80109bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109bde:	66 90                	xchg   %ax,%ax
      shmTable.allRegions[i].physicalAddr[j] = (void *)0;
80109be0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for(int j = 0; j < SHAREDREGIONS; j++) {
80109be6:	83 c0 04             	add    $0x4,%eax
80109be9:	39 d0                	cmp    %edx,%eax
80109beb:	75 f3                	jne    80109be0 <sharedMemoryInit+0x90>
  for(int i = 0; i < SHAREDREGIONS; i++) {
80109bed:	8d 90 28 01 00 00    	lea    0x128(%eax),%edx
80109bf3:	3d 3c 21 13 80       	cmp    $0x8013213c,%eax
80109bf8:	75 86                	jne    80109b80 <sharedMemoryInit+0x30>
    }
  }
  release(&shmTable.lock);
80109bfa:	83 ec 0c             	sub    $0xc,%esp
80109bfd:	68 20 d7 12 80       	push   $0x8012d720
80109c02:	e8 59 c2 ff ff       	call   80105e60 <release>
}
80109c07:	83 c4 10             	add    $0x10,%esp
80109c0a:	c9                   	leave  
80109c0b:	c3                   	ret    
80109c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80109c10 <getShmidIndex>:

// to return shmid index from shmtable
int
getShmidIndex(int shmid) {
80109c10:	f3 0f 1e fb          	endbr32 
80109c14:	55                   	push   %ebp
80109c15:	89 e5                	mov    %esp,%ebp
80109c17:	8b 45 08             	mov    0x8(%ebp),%eax
  if(shmid < 0 || shmid > 64) {
80109c1a:	83 f8 40             	cmp    $0x40,%eax
80109c1d:	77 11                	ja     80109c30 <getShmidIndex+0x20>
    return -1;
  }
  return shmTable.allRegions[shmid].shmid;
80109c1f:	69 c0 28 01 00 00    	imul   $0x128,%eax,%eax
}
80109c25:	5d                   	pop    %ebp
  return shmTable.allRegions[shmid].shmid;
80109c26:	8b 80 5c d7 12 80    	mov    -0x7fed28a4(%eax),%eax
}
80109c2c:	c3                   	ret    
80109c2d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80109c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80109c35:	5d                   	pop    %ebp
80109c36:	c3                   	ret    
80109c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109c3e:	66 90                	xchg   %ax,%ax

80109c40 <mappagesWrapper>:

void mappagesWrapper(struct proc *process, int shmIndex, int index) {
80109c40:	f3 0f 1e fb          	endbr32 
80109c44:	55                   	push   %ebp
80109c45:	89 e5                	mov    %esp,%ebp
80109c47:	57                   	push   %edi
80109c48:	56                   	push   %esi
80109c49:	53                   	push   %ebx
80109c4a:	83 ec 1c             	sub    $0x1c,%esp
80109c4d:	8b 45 10             	mov    0x10(%ebp),%eax
80109c50:	8b 7d 08             	mov    0x8(%ebp),%edi
80109c53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  for(int i = 0; i < process->pages[index].size; i++) {
80109c56:	8d 04 80             	lea    (%eax,%eax,4),%eax
80109c59:	8d 34 87             	lea    (%edi,%eax,4),%esi
void mappagesWrapper(struct proc *process, int shmIndex, int index) {
80109c5c:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  for(int i = 0; i < process->pages[index].size; i++) {
80109c5f:	8b 86 b0 00 00 00    	mov    0xb0(%esi),%eax
80109c65:	85 c0                	test   %eax,%eax
80109c67:	74 6b                	je     80109cd4 <mappagesWrapper+0x94>
80109c69:	69 c1 28 01 00 00    	imul   $0x128,%ecx,%eax
80109c6f:	31 db                	xor    %ebx,%ebx
80109c71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80109c74:	eb 15                	jmp    80109c8b <mappagesWrapper+0x4b>
80109c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80109c7d:	8d 76 00             	lea    0x0(%esi),%esi
80109c80:	83 c3 01             	add    $0x1,%ebx
80109c83:	39 9e b0 00 00 00    	cmp    %ebx,0xb0(%esi)
80109c89:	76 49                	jbe    80109cd4 <mappagesWrapper+0x94>
    uint va = (uint)process->pages[index].virtualAddr;
80109c8b:	8b 86 bc 00 00 00    	mov    0xbc(%esi),%eax
    if(mappages(process->pgdir, (void*)(va + (i * PGSIZE)), PGSIZE, (uint)shmTable.allRegions[shmIndex].physicalAddr[i], process->pages[index].perm) < 0) {
80109c91:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80109c94:	89 da                	mov    %ebx,%edx
80109c96:	83 ec 08             	sub    $0x8,%esp
80109c99:	c1 e2 0c             	shl    $0xc,%edx
    uint va = (uint)process->pages[index].virtualAddr;
80109c9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(mappages(process->pgdir, (void*)(va + (i * PGSIZE)), PGSIZE, (uint)shmTable.allRegions[shmIndex].physicalAddr[i], process->pages[index].perm) < 0) {
80109c9f:	01 c2                	add    %eax,%edx
80109ca1:	8b 47 04             	mov    0x4(%edi),%eax
80109ca4:	ff b6 b8 00 00 00    	pushl  0xb8(%esi)
80109caa:	ff b4 99 64 d7 12 80 	pushl  -0x7fed289c(%ecx,%ebx,4)
80109cb1:	b9 00 10 00 00       	mov    $0x1000,%ecx
80109cb6:	e8 95 ea ff ff       	call   80108750 <mappages>
80109cbb:	83 c4 10             	add    $0x10,%esp
80109cbe:	85 c0                	test   %eax,%eax
80109cc0:	79 be                	jns    80109c80 <mappagesWrapper+0x40>
      deallocuvm(process->pgdir, va, (uint)(va + shmTable.allRegions[shmIndex].size));
80109cc2:	69 45 dc 28 01 00 00 	imul   $0x128,-0x24(%ebp),%eax
80109cc9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80109ccc:	03 88 58 d7 12 80    	add    -0x7fed28a8(%eax),%ecx
80109cd2:	72 08                	jb     80109cdc <mappagesWrapper+0x9c>
      return;
    }
  }
}
80109cd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109cd7:	5b                   	pop    %ebx
80109cd8:	5e                   	pop    %esi
80109cd9:	5f                   	pop    %edi
80109cda:	5d                   	pop    %ebp
80109cdb:	c3                   	ret    
80109cdc:	8b 47 04             	mov    0x4(%edi),%eax
80109cdf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80109ce2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109ce5:	5b                   	pop    %ebx
80109ce6:	5e                   	pop    %esi
80109ce7:	5f                   	pop    %edi
80109ce8:	5d                   	pop    %ebp
80109ce9:	e9 f2 ea ff ff       	jmp    801087e0 <deallocuvm.part.0>
80109cee:	66 90                	xchg   %ax,%ax

80109cf0 <shmdtWrapper>:

void shmdtWrapper(void *addr) {
80109cf0:	f3 0f 1e fb          	endbr32 
  // call shmdt
  shmdt(addr);
80109cf4:	e9 e7 f5 ff ff       	jmp    801092e0 <shmdt>
