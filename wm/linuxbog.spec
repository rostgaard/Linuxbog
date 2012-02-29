
Url:		http://www.linuxbog.dk/
Group:		Books/Computer books
Copyright:	Åben dokumentlicens (ÅDL)
Source:		%{name}-%{version}.html.tar.gz
BuildRoot:	%{_tmppath}/%{name}-%{version}-root
Prefix:		%{_prefix}

%description -l da
Bogen er en del af en serie der kan findes samlet på http://www.linuxbog.dk/.
* Linux - Friheden til at vælge - En god bog til at komme i gang med Linux.
* Linux - Friheden til at vælge distribution - Hjælp til at vælge open source-distribution.
* Linux - Friheden til at lære Unix - Lær elementær Unix.
* Linux - Friheden til at vælge grafisk brugergrænseflade -  Lær hvilken grafisk brugergrænseflade som passer dig bedst.
* Linux - Friheden til at vælge programmer - Om de programmer du kan få til Linux.
* Linux - Friheden til at vælge kontorprogrammer -  Basal anvendelse af Linux-programmer.
* Linux - Friheden til systemadministration - Om at administre sin egen Linux-server
* Linux - Friheden til at programmere - Programmering på Linux
* Linux - Friheden til at programmere i C - Programmering i C
* Linux - Friheden til at programmere i Java - Programmering i Java
* Linux - Friheden til at programmere i Python -  En begynderbog om Python
* Linux - Friheden til sikkerhed på internettet - Sikkerhed omkring din Linux-boks
* Linux - Friheden til egen webserver - Web og databaser
* Linux - Friheden til at skrive dokumentation -  Skrive dokumentation under Linux
* Linux - Friheden til at vælge OpenOffice.org - Kontorpakken OpenOffice.org

%prep
%setup -q -n %{buildname}

%install
mkdir -p $RPM_BUILD_ROOT/usr/share/doc/linuxbog/%{buildname}
if [ -d ./%{buildname} ]; then
	(cd %{buildname}; cp -r * $RPM_BUILD_ROOT/usr/share/doc/linuxbog/%{buildname})
else
	(cp -r * $RPM_BUILD_ROOT/usr/share/doc/linuxbog/%{buildname})
fi

if [ -d ./eksempler ]; then
	mkdir -p $RPM_BUILD_ROOT/usr/share/doc/linuxbog/%{buildname}/eksempler
	(cd ./eksempler; cp -r * $RPM_BUILD_ROOT/usr/share/doc/linuxbog/%{buildname}/eksempler)
fi

%clean
rm -rf $RPM_BUILD_ROOT

%files
%attr(-,root,root) 
%{_prefix}/share/doc/*

%changelog
* Sun Jan 25 2004 Henrik Christian Grove <grove@sslug.dk>
- Rettede licensen til ÅDL og opdaterede listen af bøger.

* Tue Apr 16 2002 Troels Liebe Bentsen <tlb@rapanden.dk>
- Rettede /usr/share/books til /usr/share/doc, hint fra Torkil Zachariassen <torkil\@flug.fo>. 

* Sat Apr 14 2001 Troels Liebe Bentsen <tlb@rapanden.dk>
- Første udgave.

