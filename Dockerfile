FROM ubuntu:latest

MAINTAINER amine <amine.bc@hotmail.com>

RUN apt-get update && \
    apt-get install -y python3-pip \
                       nano \
                       sudo && \
    apt-get clean

ARG USR="jupy"
ARG GRP="jupy"
ARG USER_DIR="/home/jupy"
ARG DATA_DIR="${USER_DIR}/data"


RUN groupadd --gid 2000 ${GRP} && \
    useradd -m -d /home/${USR} --uid 2000 --gid ${GRP} -p '' ${USR} && \
    chown -R ${USR} /home/${USR} && \
    adduser ${USR} sudo

USER ${USR}

RUN sudo mkdir -p ${USER_DIR} && \
    sudo pip3 install jupyterlab && \
    sudo apt-get remove -y python-pip && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY script/entrypoint/run.sh ${USER_DIR}/run.sh

RUN sudo chown -R ${USR}:${GRP} /home/jupy/* && \
    sudo chmod -R 770 /home/jupy/*

WORKDIR ${USER_DIR}/workdir

ENTRYPOINT ["su","jupy","/home/jupy/run.sh"]


