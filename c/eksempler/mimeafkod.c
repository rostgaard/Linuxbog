#include <stdio.h>

static char str[3];

int main(int argc, char *argv[])
{
    int c, c2;
    char *ptr;

    while ( (c=getchar()) != EOF) {
        if (c != '=')
            putchar(c);
        else {
            if ( (c2 = getchar()) == '\n')  /* ok, a continuation request */
                continue;                   /* donot print a newline */
            else {
                if (feof(stdin)) exit(1);
                str[1] = getchar();
                if (feof(stdin)) exit(1);
                str[0] = c2;
                c = strtol(str, &ptr, 16);
                putchar(c);
            }
        }
    }

    return 0;
}

