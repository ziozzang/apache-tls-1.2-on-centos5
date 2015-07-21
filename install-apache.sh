#!/bin/bash
CWD=`pwd`
WORKING_PATH="/opt/src"
# - both 1.0.2 and 1.0.1 works well...
#OPENSSL_VERSION="1.0.2d"
OPENSSL_VERSION="1.0.1p"
# - Tested apache 2.2.31 (current, newest version)
APACHE_VERSION="2.2.31"
# - prefix of openssl & apache...
PREFIX="/opt"
# - Target apache path. this will be /opt/apache
APACHE_PATH="/apache"

##############################################
# prerequisit :
#   you must backup preinstalled openssl.
#   because of issue on libtool with apache source, -with-ssl doesn't work well..


# - download and install OpenSSL...
mkdir -p ${PREFIX}
mkdir -p ${WORKING_PATH}
cd ${WORKING_PATH}
wget --no-check-certificate https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz

tar -xzvf openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
./config --prefix=${PREFIX} --openssldir=${PREFIX}/openssl && make install

# - download and install Apache 2.2.X
cd ${WORKING_PATH}
wget http://apache.mirror.cdnetworks.com//httpd/httpd-${APACHE_VERSION}.tar.gz
tar -xzvf httpd-${APACHE_VERSION}.tar.gz
cd httpd-${APACHE_VERSION}

# -- this makes link of openssl header accessable. (Very important)
ln -s ${PREFIX}/include ${PREFIX}/openssl/include

./configure \
  --enable-so --enable-ssl \
  --with-ssl=${PREFIX}/openssl \
  --prefix=${PREFIX}${APACHE_PATH}

# -- this makes link of openssl library accessable. (Very important)
#    this code !!!!!must run after ./configuration !!!!! (veeeeery important) 
#    this is tricky code. but this works.
ln -s ${PREFIX}/lib ${PREFIX}/openssl/lib

# -- build apache.
make install

exit 0

# below codes are for configuration.
# to enable default ssl, you must uncomment ssl configuration line.
sed -i -e "s,^#\(Include conf/extra/httpd-ssl.conf\),\1,g" ${PREFIX}${APACHE_PATH}/conf/httpd.conf

# copy your own SSL certifications.
cp server.csr  ${PREFIX}${APACHE_PATH}/conf/
cp server.key  ${PREFIX}${APACHE_PATH}/conf/
cp server.crt  ${PREFIX}${APACHE_PATH}/conf/
