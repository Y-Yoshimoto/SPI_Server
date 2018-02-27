FROM centos
MAINTAINER APIServer_nginx

# nginxのインストール
RUN yum install -y epel-release
RUN yum install -y nginx

# コンテツファイルの設置
COPY index.html /var/www/html

# nginx設定ファイルの設置
COPY nginx.conf /etc/nginx/nginx.conf
COPY server.conf /etc/nginx/conf.d/server.conf

# コンテナ実行時の動作設定
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/nginx" .
## docker build -f ./Dockerfile -t centos/nginx --no-cache .
## docker run -d --name nginxtest -i -t -p 80:80 centos/nginx
## docker exec -it nginxtest /bin/bash
