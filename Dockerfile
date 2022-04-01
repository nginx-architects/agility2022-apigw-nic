FROM nginx:mainline-alpine
RUN rm /etc/nginx/conf.d/*

# COPY Markdown files
COPY modules /usr/share/nginx/html

RUN chown -R nginx:nginx /usr/share/nginx/html 
ADD user-guide/conf.d /etc/nginx/conf.d/
RUN chown -R nginx:nginx /etc/nginx \
 # Forward request logs to docker log collector
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 # Raise the limits to successfully run benchmarks
 && ulimit -c -m -s -t unlimited

# EXPOSE port 9999
EXPOSE 9999
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]