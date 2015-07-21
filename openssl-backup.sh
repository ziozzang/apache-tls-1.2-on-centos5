#!/bin/bash
# Pre-Installed openssl backup/rename for compiling of apache.
# - apache libtool has issue to find installed openssl.
# - so, this must be done before complie...

mv /usr/bin/openssl /usr/bin/openssl-old
mv /usr/include/openssl /usr/include/openssl-old
mv /usr/lib/libcrypt.a /usr/lib/libcrypt.a-old
mv /usr/lib/libssl.a /usr/lib/libssl.a-old
mv /usr/lib/openssl /usr/lib/openssl-old
mv /usr/lib64/libcrypt.a /usr/lib64/libcrypt.a-old
mv /usr/lib64/libssl.a /usr/lib64/libssl.a-old
mv /usr/lib64/openssl /usr/lib64/openssl-old
