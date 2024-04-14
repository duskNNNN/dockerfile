# 带有ssh的python容器
基于python官方docker hub镜像打造 \
用户和密码均为当前系统登录的用户名 \
`ssh`端口为22，`-p`指定即可 \
已修改时区为`Asia/Shanghai` \
自带软件包有`curl`，`tzdata`，`openssh-server` \
带有`root`权限，可使用`sudo`自行下载软件包 \
启动命令: 
```
docker run -d -e LOCAL_USER_ID=$UID -e LOCAL_USER_NAME=$(whoami) --gpus all -v /home/taper/Codes/python:/project --shm-size=16g -p 8022:22 canetaper/python:<version>  /usr/sbin/sshd -D
```