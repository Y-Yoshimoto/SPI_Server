FROM centos
MAINTAINER nginxtest
RUN yum install -y epel-release
RUN yum install -y nginx
COPY index.html /usr/share/nginx/html/
# COPY server.conf /etc/nginx/conf.d/server.conf

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

# Dockerfileのビルド, 実行, コンテナ内操作
# docker build -f ./Dockerfile -t nginx:nginx0.1 --no-cache .
# docker run -d --name nginxtest -i -t -p 80:80 nginx:nginx0.1
#
