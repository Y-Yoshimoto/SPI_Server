FROM centos
MAINTAINER APIServer_nginx

# nginxのインストール
RUN yum install -y epel-release
RUN yum install -y nginx

# コンテツファイルの設置
COPY index.html /usr/share/nginx/html/

# nginx設定ファイルの設置
COPY nginx.conf /etc/nginx/nginx.conf
COPY server.conf /etc/nginx/conf.d/server.conf

# コンテナ実行時の動作設定
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/apinginx:0.1" .
## docker build -f ./Dockerfile -t centos/apinginx --no-cache .
## docker run -d --name apinginx -i -t -p 80:80 centos/apinginx:0.1
## docker exec -it apinginx /bin/bash
