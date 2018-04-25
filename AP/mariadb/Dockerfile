FROM mariadb
MAINTAINER APIServer_mariadb

# コンテナ実行時の動作設定
EXPOSE 3306
#ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/apimariadb:0.1" .
## docker build -f ./Dockerfile -t centos/apimariadb --no-cache .
## docker run --name apimariadb -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mariadb
##  mysql -h 127.0.0.1 -u root -p
## docker exec -it apinginx /bin/bash
