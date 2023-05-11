# 基础镜像
FROM php:7.4-apache

# 将当前目录下的代码复制到容器中的 /var/www/html 目录下
COPY . /var/www/html

# 安装所需的扩展和工具
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    && docker-php-ext-install pdo_mysql mysqli gd

# 配置 Apache
RUN a2enmod rewrite
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# 设置工作目录
WORKDIR /var/www/html

# 暴露端口
EXPOSE 80

# 容器启动时运行 Apache 服务器
CMD ["apache2-foreground"]
