#!/bin/bash
docker run -d --name fwq -p 10000:22 -p 10001:8888 -p 10002:7860 -p 10003:6006 -v /home/taper/.Codes/Codes/python/fwq:/project \
-e LOCAL_USER_ID=$UID -e LOCAL_USER_NAME=$(whoami) \
--shm-size=32g \
--cpuset-cpus="0-8" \
--gpus all 01cf4c8645aa /usr/sbin/sshd -D