#!/bin/bash
#/
############################################################################
#                                                                          #
# Script_name:  run_jupyter.sh                                             #
# Description:  launch the container with nginx                            #
# Args:         N/A                                                        #
# Author:       amine                                                      #
# email:        amine.bc@hotmail.com                                       #
#                                                                          #
############################################################################
#/

DATA_DIR="${PWD}/data"
WORK_DIR="${PWD}/workdir"
ENTRY_DIR="/home/jupy"

docker rm -f jupy
#rm -r ${DATA_DIR} ${WORK_DIR}

#docker network create nginx_default

docker run -tid \
       --restart unless-stopped \
       --name jupy \
       --workdir "/home/jupy/workdir" \
       -u jupy \
       -p 8888:8888 \
       -v ${DATA_DIR}:${ENTRY_DIR}/data \
       -v ${WORK_DIR}:${ENTRY_DIR}/workdir \
       jupy:latest && \
       sleep 2

docker exec -ti jupy tail -n 1 jupy.log |grep token |cut -d'=' -f2


