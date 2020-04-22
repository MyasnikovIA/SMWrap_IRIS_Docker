docker-compose stop
docker system prune --volumes  
docker rmi smwrap_iris_docker_iris:latest
docker-compose build
docker-compose up -d
pause
rem Run iris terminal
rem docker-compose exec iris iris session iris