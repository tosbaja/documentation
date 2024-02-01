FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
        doxygen \
        git \
        graphviz \
        make \
        openjdk-8-jre \
        openssh-server \
        python3-pip \
        ttf-dejavu \
        python3-sphinx

ARG USERNAME=docsphinx
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --create-home -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && mkdir /home/$USERNAME/.config && chown $USER_UID:$USER_GID /home/$USERNAME/.config
# Set up sudo
RUN apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && rm -rf /var/lib/apt/lists/*

USER $USERNAME
WORKDIR /home/$USERNAME
RUN mkdir deps
COPY requirements.txt ./deps
RUN pip3 install -r ./deps/requirements.txt