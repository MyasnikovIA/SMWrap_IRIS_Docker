#!/bin/bash

iris start $ISC_PACKAGE_INSTANCENAME quietly
 
cat << EOF | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS
  d RUN^%ZMRPMD
halt
EOF
exit=$?

iris stop $ISC_PACKAGE_INSTANCENAME quietly

exit $exit