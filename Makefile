all: clean Makefiler filer

release : all cvs2html mail

Makefiler:
	cp Makefile.subdir friheden/Makefile
	cp Makefile.subdir applikationer/Makefile
	cp Makefile.subdir admin/Makefile
	cp Makefile.subdir program/Makefile
	cp Makefile.subdir web/Makefile
	cp Makefile.subdir sikkerhed/Makefile
	cp misc/collateindex.pl friheden
	cp misc/collateindex.pl applikationer
	cp misc/collateindex.pl admin
	cp misc/collateindex.pl program
	cp misc/collateindex.pl web
	cp misc/collateindex.pl sikkerhed

filer:  Makefiler
	make Makefiler
	make -C friheden
	make -C applikationer
	make -C admin
	make -C program
	make -C web
	make -C sikkerhed
	(cd misc;plucker-build -v -P . -f Friheden;tar cvzf ../Friheden_palm.tgz viewer_en.prc Friheden.pdb SysZLib.prc; rm Friheden.pdb)

clean: Makefiler
	make -C friheden clean
	make -C applikationer clean
	make -C admin clean 
	make -C program clean
	make -C web clean 
	make -C sikkerhed clean 
	rm -f friheden/Makefile
	rm -f applikationer/Makefile
	rm -f admin/Makefile
	rm -f web/Makefile
	rm -f program/Makefile
	rm -f sikkerhed/Makefile
	rm -rf cvs2html

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf /home/www/www.sslug.dk/bog/cvs2html
	mkdir /home/www/www.sslug.dk/bog/cvs2html
	/home/pto/utils/cvs2html  -l http://www.sslug.dk/bog -f -p -o /home/www/www.sslug.dk/bog/cvs2html/index.html -v -a -b -n 6 -C cvs_crono.html


mail:
	echo "Done bøger" | mail $(USER)-mobil
