# 带有ssh的miniconda容器
基于debian官方docker hub镜像打造 \
用户和密码均为登录的用户名 \
此用户有sudo权限，并设置免密 \
`ssh`端口为22，`-p`指定即可 \
已修改时区为`Asia/Shanghai` \
自带软件包有`curl`，`tzdata`，`openssh-server` \
建议搭配`vscode`使用，力荐 \
 \
启动命令:
```
 docker run -d --name miniconda -p 8022:22 -e LOCAL_USER_ID=$UID -e LOCAL_USER_NAME=$(whoami)  --gpus all -v <local>:/project --shm-size=<本机内存>  canetaper/miniconda:latest /usr/sbin/sshd -D
```