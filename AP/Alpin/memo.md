docker run -d --name alpinetest -i -t -p 80:80 alpine
docker exec -it alpinetest /bin/sh
# nginx
apk update
apk add nginx