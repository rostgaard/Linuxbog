
Url:		http://www.sslug.dk/linuxbog/
Group:		Books/Computer books
Copyright:	GNU GPL version 2
Source:		%{name}-%{version}.html.tar.gz
BuildRoot:	%{_tmppath}/%{name}-%{version}-root
Prefix:		%{_prefix}

%description -l da
Bogen er en del af en serie der kan findes samlet på http://www.sslug.dk/linuxbog/.
* Linux - Friheden til at vælge - En god bog til at komme i gang med Linux.
* Linux - Friheden til at vælge programmer - Om de programmer du kan få til Linux.
* Linux - Friheden til systemadministration - Om at administre sin egen Linux-server
* Linux - Friheden til at programmere - Programmering på Linux
* Linux - Friheden til at programmere i C - C-programmering
* Linux - Friheden til sikkerhed på internettet - Sikkerhed omkring din Linux-boks
* Linux - Friheden til egen webserver - Web og databaser
* Linux - Friheden til at skrive i SGML/DocBook - Kom i gang med at skrive bøger i SGML/DocBook
* Linux - Friheden til at bruge kontorprogrammer - Kontorfunktioner på en Linux/KDE/Star Office-maskine.

%prep
%setup -q -n %{buildname}

%install
mkdir -p $RPM_BUILD_ROOT/usr/share/books/linuxbog/%{buildname}
if [ -d ./%{buildname} ]; then
	(cd %{buildname}; cp -r * $RPM_BUILD_ROOT/usr/share/books/linuxbog/%{buildname})
else
	(cp -r * $RPM_BUILD_ROOT/usr/share/books/linuxbog/%{buildname})
fi

if [ -d ./eksempler ]; then
	mkdir -p $RPM_BUILD_ROOT/usr/share/books/linuxbog/%{buildname}/eksempler
	(cd ./eksempler; cp -r * $RPM_BUILD_ROOT/usr/share/books/linuxbog/%{buildname}/eksempler)
fi

%clean
rm -rf $RPM_BUILD_ROOT

%files
%attr(-,root,root) 
%{_prefix}/share/books/*

%changelog
* Sat Apr 14 2001 Troels Liebe Bentsen <tlb@rapanden.dk>
- Første udgave.

