Summary: Secure Shell - secure network communications
Name: ssh
Version: 1.2.25
Release: 2
Copyright: GPL
Group: Utilities/Networking
Source: ftp://sunsite.auc.dk/pub/security/ssh/ssh-1.2.25.tar.gz
Patch: ssh-1.2.25-Makefile.patch
URL: http://www.cs.hut.fi/ssh/
BuildRoot: /tmp/ssh-build

%description
Secure Shell enables you to communicate securely across on unsafe
network such as the Internet. Communication is transparently 
encrypted, and thus secured against eavesdropping. The package 
includes drop-in replacements for telnet, rlogin, rsh, rcp and
other standard networking tools.

%prep

%setup
%patch -p1
./configure --prefix=/usr

%build
make CFLAGS="$RPM_OPT_FLAGS" LDFLAGS="-s"

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
make install

%post
if [ ! -f /etc/ssh_host_key ]; then
   echo "Generating ssh host key"
   umask 022
   /usr/bin/ssh-keygen -b 1024 -f /etc/ssh_host_key -N ''
fi


%files
%config /etc/ssh_config 
%config /etc/sshd_config

/usr/bin/make-ssh-known-hosts
/usr/bin/make-ssh-known-hosts1
/usr/bin/ssh
/usr/bin/ssh-add
/usr/bin/ssh-add1
/usr/bin/ssh-agent
/usr/bin/ssh-agent1
/usr/bin/ssh-askpass
/usr/bin/ssh-askpass1
/usr/bin/ssh-keygen
/usr/bin/ssh-keygen1
/usr/bin/ssh1
/usr/sbin/sshd
/usr/sbin/sshd1

/usr/man/man1/make-ssh-known-hosts.1
/usr/man/man1/make-ssh-known-hosts1.1
/usr/man/man1/ssh-add.1
/usr/man/man1/ssh-add1.1
/usr/man/man1/ssh-agent.1
/usr/man/man1/ssh-agent1.1
/usr/man/man1/ssh-keygen.1
/usr/man/man1/ssh-keygen1.1
/usr/man/man1/ssh.1
/usr/man/man1/ssh1.1
/usr/man/man1/scp.1
/usr/man/man1/scp1.1
/usr/man/man1/slogin.1
/usr/man/man1/slogin1.1
/usr/man/man8/sshd.8
/usr/man/man8/sshd1.8

%doc COPYING INSTALL OVERVIEW TODO
%doc README README.CIPHERS README.SECURERPC README.SECURID README.TIS RFC TODO

%clean
rm -rf $RPM_BUILD_ROOT


