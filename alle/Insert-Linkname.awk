#!/bin/gawk -f

BEGIN {
    "basename $PWD" | getline currentDir;
    if (currentDir != "alle") {
       fatal_dir();
    }
    "basename $(dirname $PWD)" | getline parentDir;
    if (parentDir != "linuxbog"){
       fatal_parentDir();
    }
    iostat = getline < "bog/index.html.php-1";
    if (iostat > 0)
       fatal_already();
    x = 1;
    while (x) {
       x = getline lina < "bog/index.html.php" ;
       if (lina ~ "alle-stikord.html")
          printf("<DT><A href=\"alle-stikord.html\">Stikordsregister</A></DT>\n") > "bog/nyt-index.html.php";
       else
          print lina >> "bog/nyt-index.html.php";
    }
    close("bog/index.html.php");
    system("cd bog && mv index.html.php index.html.php-1 && mv nyt-index.html.php index.html.php");
}

function fatal_dir()
{
    printf("Current directory must be alle/ \n");
    exit (101);
}

function fatal_parentDir()
{
    printf("Current directory must be alle/ \n");
    exit (102);
}

function fatal_already()
{
    printf("File index.html.php-1 exists, cannot run this script twice!\n");
    exit (105);
}

