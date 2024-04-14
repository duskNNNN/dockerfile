#!/bin/bash
docker run -d --name point2 -p 9022:22 -v /home/taper/Codes/python/Pointnet_Pointnet2_pytorch:/project \
-e LOCAL_USER_ID=$UID -e LOCAL_USER_NAME=$(whoami) \
--shm-size=16g \
--gpus 0 c2c4b57c142b /usr/sbin/sshd -D