#!/bin/bash

iris start $ISC_PACKAGE_INSTANCENAME quietly
 
cat << EOF | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS
do ##class(%SYSTEM.Process).CurrentDirectory("$PWD")
$@
if '\$Get(sc) do ##class(%SYSTEM.Process).Terminate(, 1)
zn "%SYS"
do ##class(SYS.Container).QuiesceForBundling()
Do ##class(Security.Users).UnExpireUserPasswords("*")
write \$system.Process.CurrentDirectory()
write \$c(13,10)
s db=##class(SYS.Database).%OpenId("irislib") 
s oldstatus=db.ReadOnly
s db.ReadOnly=0 
w db.%Save()
d \$system.OBJ.Load("/usr/irissys/mgr/SMWrap.xml","c")
d \$system.OBJ.Load("/usr/irissys/mgr/ZSTU.xml","c")
d \$system.OBJ.LoadDir("/opt/irisapp/src","c")
s db.ReadOnly=oldstatus
w db.%Save()
do RUN^%ZMRPMD
halt
EOF

exit=$?

iris stop $ISC_PACKAGE_INSTANCENAME quietly

exit $exit