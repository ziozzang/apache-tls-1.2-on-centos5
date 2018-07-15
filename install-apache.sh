#!/bin/bash
CWD=`pwd`
WORKING_PATH="/opt/src"
# - both 1.0.2 and 1.0.1 works well...
#OPENSSL_VERSION="1.0.2d"
OPENSSL_VERSION="1.1.1-pre8"
# - Tested apache 2.2.31 (current, newest version)
APACHE_APR_VERSION="1.6.3"
APACHE_APR_UTIL_VERSION="1.6.1"
APACHE_VERSION="2.4.34"
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
wget http://www-us.apache.org/dist/apr/apr-${APACHE_APR_VERSION}.tar.gz
wget http://www-us.apache.org/dist/apr/apr-util-${APACHE_APR_UTIL_VERSION}.tar.gz
tar -xzvf httpd-${APACHE_VERSION}.tar.gz
mkdir -p ${WORKING_PATH}/httpd-${APACHE_VERSION}/srclib/apri/
mkdir -p ${WORKING_PATH}/httpd-${APACHE_VERSION}/srclib/apr-util/
tar -xzvf apr-${APACHE_APR_VERSION}.tar.gz --strip-components 1 -C ${WORKING_PATH}/httpd-${APACHE_VERSION}/srclib/apr

tar -xzvf apr-util-${APACHE_APR_UTIL_VERSION}.tar.gz --strip-components 1 -C ${WORKING_PATH}/httpd-${APACHE_VERSION}/srclib/apr-util

# -- this makes link of openssl header accessable. (Very important)
#ln -s ${PREFIX}/include ${PREFIX}/openssl/include

cd ${WORKING_PATH}/httpd-${APACHE_VERSION}/

./configure \
  --enable-so --enable-ssl \
  --with-ssl=${PREFIX}/openssl \
  --prefix=${PREFIX}${APACHE_PATH} \
  --with-included-apr

# -- this makes link of openssl library accessable. (Very important)
#    this code !!!!!must run after ./configuration !!!!! (veeeeery important) 
#    this is tricky code. but this works.
#ln -s ${PREFIX}/lib ${PREFIX}/openssl/lib

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
