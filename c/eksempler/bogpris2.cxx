/* bogpris2.cxx er en minimal demonstration af, hvordan man kan
 * indføre en ny taltype i C++, således at den - nogenlunde - kan
 * fungere på linie med de indbyggede taltyper.
 */

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

int min(int a, int b)
{
    return a>b? b: a;
}

struct broek {
   int t,d;
   char s[80];
 public:
   broek(int a, int b) { t=a;d=b; }
   broek(int a) { t=a;d=1; }
   char * broek_sz() { sprintf(s,"%d/%d",t,d); return s; }
   friend broek operator*(broek x, broek y) {
       broek r(x.t * y.t, x.d * y.d);
       { int x = 0;
         int maxx = min(r.t, r.d);
           while (1) {
               if (x == maxx) break;
               if (x < maxx/2) ++x;
               else x = maxx;
               if (r.t % x == 0 && r.d % x == 0) {
                   r.t /= x;
                   r.d /= x;
               }
           }
       }
       return r;
   }
};

int main()
{
    broek afgift(1,3);
    int bogpris = 360;
    broek andel = bogpris * afgift;
    printf("andel: %s\n",andel.broek_sz());
    return 0;
}


