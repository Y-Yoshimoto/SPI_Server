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
RUN touch /var/log/uwsgi.log

# アプリケーションを配置
RUN mkdir -p /var/www/uwsgi
COPY uwsgi.ini /var/www/uwsgi/
COPY index.py /var/www/uwsgi/
ENTRYPOINT ["/usr/bin/uwsgi", "--ini", "/etc/uwsgi/emperor.ini"]

# Dockerfileのビルド, 実行, コンテナ内操作
## docker build --tag="centos/uwsgi" .
## docker build -f ./Dockerfile -t centos/uwsgi --no-cache .
## docker run -d --name uwsgitest -i -t -p 80:80 centos/uwsgi
## docker exec -it uwsgitest /bin/bash
