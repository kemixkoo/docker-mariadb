FROM mariadb
MAINTAINER Kemix Koo <kemix_koo@163.com>

ENV DEBIAN_FRONTEND noninteractive

#set time zone
ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY conf/utf8mb4.cnf /etc/mysql/conf.d/







