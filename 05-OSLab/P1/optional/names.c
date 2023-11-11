#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");

int init_module(void)
{
  printk(KERN_INFO "Group 22:\n- Mohammad Amanlou : 810100084\n- Shahzad Momayez : 810100272\n- Pardis ZandKarimi : 810101081\n");
  return 0;
}

void cleanup_module(void) {};
