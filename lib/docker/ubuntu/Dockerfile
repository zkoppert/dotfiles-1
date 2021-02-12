FROM ubuntu:latest

ARG USERNAME=user
ARG PASSWORD=user

ENV HOME /home/${USERNAME}
ARG TERM
ENV TERM ${TERM}
# Update && install common dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -yq \
    ncurses-dev man telnet unzip zsh git subversion curl make sudo locales \
    autoconf automake python3 python3-pip golang-go \
    nano micro htop

RUN apt -y autoremove \
    && apt clean

RUN echo 'en_GB.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen \
    && useradd -m -r -G sudo -s /bin/zsh ${USERNAME} 

ENV HOME /home/${USERNAME}
WORKDIR /home/${USERNAME}
USER ${USERNAME}

RUN mkdir -p .ssh \
    && ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -P ${PASSWORD}

RUN git clone https://github.com/ss-o/dotfiles .dotfiles
RUN bash -c ' \
    cd .dotfiles \
    && ./install'

CMD ["/bin/bash"]