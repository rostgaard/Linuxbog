all: clean html pdf mail

html:
	make -C friheden html
	make -C admin html 
	make -C program html
	make -C web html 
	make -C sikkerhed html 
	       
	       
pdf:	       
	make -C friheden pdf
	make -C admin pdf 
	make -C program pdf
	make -C web pdf 
	make -C sikkerhed pdf 
	       
	       
clean:	       
	make -C friheden clean
	make -C admin clean 
	make -C program clean
	make -C web clean 
	make -C sikkerhed clean 

cvs2html:
	chmod +x /home/pto/utils/cvs2html
	rm -rf /home/www/www.sslug.dk/bog/cvshtml
	mkdir /home/www/www.sslug.dk/bog/cvshtml
	/home/pto/utils/cvs2html  -l http://www.sslug.dk/bog -f -p -o /home/www/www.sslug.dk/bog/cvshtml/index.html -v -a -b -n 6 -C cvs_crono.html


mail:
	echo "Done bøger" | mail pto-mobil
