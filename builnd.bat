docker stop smwrap_iris
docker rmi smwrap_iris
docker build -t smwrap_iris .
docker run -d -p 9091:51773 -p 9092:52773 -p 9093:53773 -p 7200:7200 -v ./DB:/opt/irisapp/DB -v ~/iris.key:/usr/irissys/mgr/iris.key  -v ./src:/usr/irissys/mgr/src  smwrap_iris
