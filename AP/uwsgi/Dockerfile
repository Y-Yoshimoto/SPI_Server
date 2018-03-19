FROM centos
MAINTAINER APIServer_uwsgi

# uwsgiインストール
RUN yum install -y epel-release
RUN yum install -y python-pip
RUN yum install -y gcc
RUN yum install -y python-devel
RUN pip install --upgrade pip
RUN pip install uwsgi

# uwsgi動作用ファイルの準備
RUN mkdir -p /etc/uwsgi
RUN touch /etc/uwsgi/uwsgi.pid
RUN touch /etc/uwsgi/uwsgi.sock
RUN mkdir -p /var/log/uwsgi
RUN touch /var/log/uwsgi/uwsgi.log

# アプリケーションを配置
RUN mkdir -p /var/www/uwsgi
COPY uwsgi.ini /var/www/uwsgi/
COPY index.py /var/www/uwsgi/
# ENTRYPOINT ["/usr/bin/uwsgi", "--ini", "--uid", "/etc/uwsgi/emperor.ini"]
ENTRYPOINT ["/usr/bin/uwsgi", "--ini", "/var/www/uwsgi/uwsgi.ini", "--die-on-term"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/apiuwsgi:0.1" .
## docker build -f ./Dockerfile -t centos/apiuwsgi:0.1 --no-cache .
## docker run -d --name apiuwsgi -i -t -p 3031:3031  centos/apiuwsgi:0.1
## docker exec -it apiuwsgi /bin/bash
