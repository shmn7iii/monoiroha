FROM nginx:alpine

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/monoiroha.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
