
/* At aendre en konstant ... */
#include <stdio.h>

char * ms1 = "Hello, ever changing world!\n";

int main()
{
     *ms1 = 'A'; /* segmentation violation, signal 11 */
     return 0;   /* abort forinden ... */
}

