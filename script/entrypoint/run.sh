#!/bin/bash
#/
############################################################################
#                                                                          #
# Script_name:  launch.sh                                                  #
# Description:  launch jupyter container                                   #
# Args:         N/A                                                        #
# Author:       amine                                                      #
# email:        amine.bc@hotmail.com                                       #
#                                                                          #
############################################################################
#/

USER_GRP="jupy"
USER_NAME="jupy"
USER_PATH="/home/jupy"
DATA_PATH="${USER_PATH}/data"
WORK_DIR="${USER_PATH}/workdir"

#creating all volume directory
sudo mkdir -p \
    ${WORK_DIR} \
    ${DATA_PATH}/dat \
    ${DATA_PATH}/conf \
    ${DATA_PATH}/runtime 

sudo chown ${USER_NAME}:${USER_GRP} \
    ${USER_PATH} \
    ${WORK_DIR} \
    ${DATA_PATH}/dat \
    ${DATA_PATH}/conf \
    ${DATA_PATH}/runtime

#changing owner
test () {
     echo "the current user is $(whoami) at the current folder $(pwd)"
     ls -la
}

# moving and simlinkink all jupy file to the new volume

symconf () {
#     sudo mv -f /home/jupy/.jupyter/  ${DATA_PATH}/conf/homejupy && \
#     sudo rm -f /home/jupy/.jupyter/ && \
#     sudo ln -s ${DATA_PATH}/conf/homejupy /home/jupy/.jupyter

#     sudo mv -f /home/jupy/.local/etc/jupyter  ${DATA_PATH}/conf/homelocal && \
#     sudo rm -f /home/jupy/.jupyter/ && \
#     sudo ln -s ${DATA_PATH}/conf/homelocal /home/jupy/.local/etc/jupyter


#     sudo mv -f /usr/etc/jupyter  ${DATA_PATH}/conf/useretc && \
#     sudo rm -f /usr/etc/jupyter && \
#     sudo ln -s ${DATA_PATH}/conf/useretc /usr/etc/jupyter


     sudo mv -f /usr/local/etc/jupyter  ${DATA_PATH}/conf/userlocal && \
     sudo rm -f /usr/local/etc/jupyter && \
     sudo ln -s ${DATA_PATH}/conf/userlocal /usr/local/etc/jupyter


#     sudo mv -f /etc/jupyter  ${DATA_PATH}/conf/etc && \
#     sudo rm -f /etc/jupyter && \
#     sudo ln -s ${DATA_PATH}/conf/etc /etc/jupyter
}


symdata () {
#     sudo mv -f /home/jupy/.local/share/jupyter  ${DATA_PATH}/dat/homelocal && \
#     sudo rm -f /home/jupy/.local/share/jupyter && \
#     sudo ln -s ${DATA_PATH}/dat/homelocal /home/jupy/.local/share/jupyter


     sudo mv -f /usr/local/share/jupyter  ${DATA_PATH}/dat/usrlocal && \
     sudo rm -f /usr/local/share/jupyter && \
     sudo ln -s ${DATA_PATH}/dat/usrlocal /usr/local/share/jupyter


#     sudo mv -f /usr/share/jupyter  ${DATA_PATH}/dat/usrshare && \
#     sudo rm -f /usr/share/jupyter/ && \
#     sudo ln -s ${DATA_PATH}/dat/usrshare /usr/share/jupyter

}

symruntime () {
#     sudo chmod -R 770 /home/jupy/.local/share/jupyter/runtime && \
     sudo  mv -f /home/jupy/.local/share/jupyter/runtime  ${DATA_PATH}/runtime/homeruntime && \
     sudo rm -f /home/jupy/.local/share/jupyter/runtime && \
     sudo ln -s ${DATA_PATH}/runtime/homeruntime /home/jupy/.local/share/jupyter/runtime
}

runjupy () {
    sudo chmod  -R 740 /home/jupy/*
    sudo -u jupy nohup  jupyter-lab --ip='0.0.0.0' --no-browser > jupy.log
    sudo cp ${USER_PATH}/jupy.log ${WORK_DIR}/
}

main () {
  test
  symconf
  symdata
  symruntime
  runjupy
}

main
#sudo cp nohuo.log /home/jupy/data/log.txt
#sudo tail -n 2  /home/jupy/data/nohup.out
