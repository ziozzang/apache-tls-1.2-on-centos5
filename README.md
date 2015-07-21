# apache-tls-1.2-on-centos5
apache httpd server with TLS 1.2 supported compiled version for Centos/RHEL 5

Why this code?
==============
because of apache build script has bug on libtool, you cannot build apache with newest openssl on Centos/RHEL 5.
with preinstalled openssl, your trial of compiling of apache will go to the heaven. lol.
anyway, with legacy system, you can get hint of installation of apache with TLS v1.2.

Procedure
=========
just browse code of ```install-apache.sh```

There are many tricky codes. it's totally because of finding correct header and symbol issue...
I just show sample how to avoid that...

Testing
=======
you can test with this site

* https://www.ssllabs.com/ssltest/index.html

Comment
=======
I don't recommand this procedure. this works doesn't safe for future....
you have better ways with precompiled package system. upgrade your os environment.
for example yum(centos/rhel) or apt-get(debian/ubuntu). there's will be update for security patch or something... :)

