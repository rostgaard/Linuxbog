/* dirlist1.c læser alle filnavne i et directory */

#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int showdir(char *dirname);

main(int argc, char *argv[])
{
	char *dirname;
	if (argc<2)
		dirname = ".";
	else
		dirname = argv[1];

	return showdir(dirname);
}

int showdir(char *name)
{
	DIR *d;
	struct dirent *dent;

	if ((d=opendir(name)) == NULL)
		return 1;
	while (dent = readdir(d))
		printf("Return from readdir: %s\n",dent->d_name);
	closedir(d);
	return 0;

}

