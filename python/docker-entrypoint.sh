#!/bin/bash
# 获取主机用户id
USER_ID=${LOCAL_USER_ID}
# 获取主机用户名
USER_NAME=${LOCAL_USER_NAME}
# 给主机用户授权制定的非绑定挂载目录
chown -R $USER_ID /project

# 创建和主机用户相同uid的用户，名为user
# 此处判断是否存在此用户
USER_IS_EXITS=$(id $USER_NAME)
if [[ -z $USER_IS_EXITS ]]
then
    echo "用户不存在"
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER_NAME
    usermod -a -G root $USER_NAME
    export HOME=/home/$USER_NAME
    echo "$USER_NAME:$USER_NAME" | chpasswd
    gpasswd -a $USER_NAME sudo
    echo "$USER_NAME ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
else
    echo "用户已存在，无需创建"
fi

exec "$@"