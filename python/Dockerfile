FROM python:3.7-slim-bullseye
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list\
&& apt update -y \
&& apt install openssh-server sudo tzdata curl -y \
&& mkdir  /var/run/sshd \
&& mkdir /project \
&& ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
&& echo ${TZ} > /etc/timezone \
&& dpkg-reconfigure --frontend noninteractive tzdata \
&& apt clean \
&& chmod +x /usr/local/bin/docker-entrypoint.sh
EXPOSE 22
WORKDIR /project
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]