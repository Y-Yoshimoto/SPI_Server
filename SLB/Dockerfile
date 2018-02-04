FROM centos
MAINTAINER nginx-test hoge@hoge.com
RUN yum install -y epel-release
RUN yum install -y nginx
COPY index.html /usr/share/nginx/html/
COPY server.conf /etc/nginx/conf.d/server.conf

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
