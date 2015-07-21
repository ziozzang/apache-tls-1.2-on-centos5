#!/bin/bash
# After Compile of apache, you must rollback/restore preinstalled openssl (0.9.x)

mv /usr/include/openssl-old /usr/include/openssl
mv /usr/lib/openssl-old /usr/lib/openssl
mv /usr/lib64/openssl-old /usr/lib64/openssl
mv /usr/lib/libcrypt.a-old /usr/lib/libcrypt.a
mv /usr/lib/libssl.a-old /usr/lib/libssl.a
mv /usr/lib64/libcrypt.a-old /usr/lib64/libcrypt.a
mv /usr/lib64/libssl.a-old /usr/lib64/libssl.a
mv /usr/bin/openssl-old /usr/bin/openssl
