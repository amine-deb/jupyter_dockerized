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
# setting text formating
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

DATA_DIR="${PWD}/data"
WORK_DIR="${PWD}/workdir"
ENTRY_DIR="/home/jupy"

#build the image
docker build -t jupy:latest .

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

echo "${GREEN}Here after the token necessary to login"
echo "${RED}"
docker exec -ti jupy tail -n 1 jupy.log |grep token |cut -d'=' -f2
echo "${GREEN}" 
echo "the token is newly generated at each run, but if you need to show it again,"
echo "run the following command:"
echo '        docker exec -ti jupy tail -n 1 jupy.log |grep token |cut -d'=' -f2' 
echo "${RESET}"

