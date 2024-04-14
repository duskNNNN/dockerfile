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
    chown -R $USER_ID /opt/miniconda
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> /home/$USER_NAME/.bashrc
    echo "conda activate base" >> /home/$USER_NAME/.bashrc
    echo "LC_ALL=zh_CN.UTF-8" >> /home/$USER_NAME/.bashrc
    gpasswd -a $USER_NAME sudo
    echo "$USER_NAME ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
else
    echo "用户已存在，无需创建"
fi
cat>/home/$USER_NAME/.condarc<<EOF
channels:
- defaults
show_channel_urls: true
default_channels:
- https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
- https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
- https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
deepmodeling: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
EOF

exec "$@"