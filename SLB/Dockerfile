FROM centos
MAINTAINER nginxtest

# nginxのインストール
RUN yum install -y epel-release
RUN yum install -y nginx

# コンテツファイルの設置
COPY index.html /usr/share/nginx/html/

# nginx設定ファイルの設置
COPY nginx.conf /etc/nginx/nginx.conf
COPY server.conf /etc/nginx/conf.d/server.conf
COPY upstream.conf /etc/nginx/conf.d/upstream.conf
COPY serverTSL.conf /etc/nginx/conf.d/serverTSL.conf

# コンテナ実行時の動作設定
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build -f ./Dockerfile -t nginx:nginx0.2 .
## docker run -d --name nginxtest -i -t -p 80:80 nginx:nginx0.2
## docker exec -it nginx0.2 /bin/bash
