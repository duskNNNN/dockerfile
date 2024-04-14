FROM debian:bullseye
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive
ENV INSTALL_DIR=/opt/miniconda
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list\
&& apt update -y \
&& apt install openssh-server sudo tzdata curl wget libgl1 locales -y \
&& true > /etc/locale.gen \
&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
&& echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen \
&& locale-gen \
&& echo 'LANG=en_US.UTF-8'  > /etc/locale.conf \
&& wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/Miniconda3-latest-Linux-x86_64.sh \
&& chmod +x /root/Miniconda3-latest-Linux-x86_64.sh \
&& /root/Miniconda3-latest-Linux-x86_64.sh -b -p ${INSTALL_DIR} \
&& mkdir /var/run/sshd \
&& mkdir /project \
&& ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
&& echo ${TZ} > /etc/timezone \
&& dpkg-reconfigure --frontend noninteractive tzdata \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* \
&& chmod +x /usr/local/bin/docker-entrypoint.sh \
&& rm -rf /root/Miniconda3-latest-Linux-x86_64.sh \
&& ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

EXPOSE 22
WORKDIR /project
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]