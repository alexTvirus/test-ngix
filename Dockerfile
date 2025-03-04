# Sử dụng image Nginx chính thức từ Docker Hub
FROM nginx:stable

# Xóa file cấu hình mặc định của Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Tạo file cấu hình mới cho reverse proxy
COPY nginx.conf /etc/nginx/conf.d/

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Tạo và cấp quyền cho các thư mục mà Nginx cần


RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp && \
    mkdir -p /var/run && \
    chown -R nginx:nginx /var/cache/nginx /var/log/nginx /var/run && \
    chmod -R 755 /var/cache/nginx /var/log/nginx /var/run

# Tạo thư mục log tùy chỉnh
RUN mkdir -p /var/log/nginx/proxy && \
    chown -R nginx:nginx /var/log/nginx/proxy
	
USER root

RUN chmod -R 777 /var/run

# Expose port 80 để nhận request
EXPOSE 7860

# Khởi động Nginx
CMD ["nginx", "-g", "daemon off;"]