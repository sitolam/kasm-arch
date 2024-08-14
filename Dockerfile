FROM lscr.io/linuxserver/webtop:arch-xfce
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install


ENV HOME /home/kasm-user
WORKDIR $HOME

USER 1000

RUN sudo pacman -Syu --noconfirm --needed \
    git \
    base-devel

RUN echo $(pwd)
RUN git clone https://aur.archlinux.org/yay.git ${HOME}/yay \
    && cd ${HOME}/yay \
    && makepkg -si --noconfirm \
    && cd .. \
    && sudo rm -rf ${HOME}/yay

WORKDIR $HOME

RUN sudo pacman -Syu --noconfirm \
    xfce4-terminal
RUN yay -Syu --noconfirm \
    mugshot

RUN mkdir ${HOME}/.themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush ${HOME}/.themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush-xfwm ${HOME}/.themes

RUN mkdir -p ${HOME}/.local/share/icons
COPY ./src/files/Nordzy-cyan-dark-MOD ${HOME}/.local/share/icons

COPY ./src/files/fonts ${HOME}/.local/share

RUN sudo pacman -Syu --noconfirm \
    kvantum-qt5
COPY ./src/files/Kvantum ${HOME}/.config

COPY ./src/configs/xfce4 ${HOME}/.config


USER 1000