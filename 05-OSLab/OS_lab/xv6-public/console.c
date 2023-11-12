// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

static void consputc(int);



static int panicked = 0;

static int backs = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void pull_back(int pos ){
  for (int i = pos - 1; i < pos + backs; i++)
      crt[i] = crt[i + 1];
}

static void push_forward(int pos) {
  for (int i = pos + backs; i > pos; i--)
    crt[i] = crt[i - 1];
}


static void
cgaputc(int c) // Important function
{
  int pos;
 
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n'){
    pos += 80 - pos%80;
    backs = 0;
  }
  else if(c == BACKSPACE){
    pull_back(pos);
    if(pos > 0) --pos;
  }
  
   else {
    push_forward(pos);
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
   }

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos + backs] = ' ' | 0x0700; //
}

void
consputc(int c) // Important function 
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');      
  }
  else
    uartputc(c);
  cgaputc(c);
  
}

#define INPUT_BUF 128


struct Input {
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
 
} input;

struct 
{
  struct Input hist[10];
  int index;
  int count;
  int last;
}history;




/*static void update_history() {
  if (history.count < 9) {
    for (int i = input.r; i < input.e; i++) 
      history.hist[i] = input;
    history.count++;
    history.index++;
  } else {
    for (int h = 0; h < 9; h++) {
        history.hist[h] = history.hist[h+1]; 
    }
    for (int i = input.r; i < input.e; i++) 
      history.hist[9] = input;
    history.index = 9;
  }
}*/


#define SCREEN_SIZE 25*80

static void clear_terminal()
{
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT + 1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT + 1);

  

  for (int pos = 0; pos < SCREEN_SIZE ; pos++){
      consputc(BACKSPACE);
  }
  backs = 0;
  input.e = input.w = input.r = 0;
  consputc('$');
  consputc(' ');
  pos = 2;

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT + 1, pos >> 8);
  outb(CRTPORT, 15);
  outb(CRTPORT + 1, pos);
}

enum curs_act {
  BACK,
  FORWARD
};

enum Arrow {
  UP,
  DOWN
};



static void curs_action(enum curs_act act)
{
  int pos;

  // get cursor position
  outb(CRTPORT, 14);
  pos = inb(CRTPORT + 1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT + 1);

  //if
  switch (act)
  {
  case BACK:
    pos--;
    break;
  case FORWARD:
    pos++;
    break;
  default:
    break;
  }

  // reset cursor
  outb(CRTPORT, 14);
  outb(CRTPORT + 1, pos >> 8);
  outb(CRTPORT, 15);
  outb(CRTPORT + 1, pos);
}



#define C(x)  ((x)-'@')  // Control-x

static void arrow(enum Arrow arr){
  for (int i= 0 ; i < backs ; i ++){
    curs_action(FORWARD);
  }
  backs = 0;
  for ( int i = input.e ; i > input.w ; i-- ){
    if (input.buf[i - 1] != '\n'){
      consputc(BACKSPACE);
    }
  }
  if (arr == UP){
    input = history.hist[history.index ];
    history.index -- ;
    input.e -- ;
    input.buf[input.e] = '\0';
  }
  if ((arr == DOWN)&&(history.index < 9)&&(history.index + 1 < history.last )){
    input = history.hist[history.index + 2 ];
    history.index ++ ;
    input.e -- ;
    input.buf[input.e] = '\0';
  }
  
  for (int i = input.w ; i < input.e; i++)
  {
    consputc(input.buf[i]);
  }
}




void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;  
        consputc(BACKSPACE);
      }
      break;
    case C('L'):
      clear_terminal();
    	break;
    case C('B'):
      if ((input.e - backs) > input.w)
      {
        curs_action(BACK);
        backs++;
      }
      break;
    case C('F'):
      if (backs > 0) {
        curs_action(FORWARD);
        backs--;
      }
      break;
    case 226:  
      if ((history.count != 0)  && (history.last - history.index < history.count))
        arrow(UP);
      break;
    case 227:
      if ((history.count != 0 ) && (history.last - history.index > 0))
        arrow(DOWN);
    break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          if (history.count < 9){
            history.hist[history.last + 1] = input;
            history.last ++ ;
            history.index = history.last;
            history.count ++ ;
          }
          else{
            for (int h = 0; h < 9; h++) {
              history.hist[h] = history.hist[h+1]; 
            }
            history.hist[9] = input;
            history.index = 9;
            history.last = 9;
            history.count = 10;
          }
          input.w = input.e;
          backs = 0;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}
