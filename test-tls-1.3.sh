#!/bin/bash

# RUN INSTALLED  HTTPd.
/opt/apache/bin/httpd
sleep 1
# TEST with openssl client.
/opt/bin/openssl s_client -connect 127.0.0.1:443 -tls1_3
# KILL httpd.
killall -9 httpd

# or you can test with your server -> https://www.ssllabs.com/ssltest/index.html
