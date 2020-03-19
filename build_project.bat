docker-compose stop
docker system prune --volumes  
docker rmi smwrap_iris_docker_iris
docker-compose build
docker-compose up -d
echo " Install class:  d ##class(%%ZUser.Installer).installSmwrap()"
echo " Close terminal:    d $zu(4,$job) "
pause
docker-compose exec iris iris session iris