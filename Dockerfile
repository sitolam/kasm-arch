FROM lscr.io/linuxserver/webtop:arch-xfce
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

ENV home /home/kasm-user
WORKDIR $home

USER 1000

RUN sudo pacman -Syu --noconfirm --needed \
    git \
    base-devel

RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -si --noconfirm \
    && cd .. \
    && sudo rm -rf yay

WORKDIR $home

RUN sudo pacman -Syu --noconfirm \
    xfce4-terminal
RUN yay -Syu --noconfirm \
    mugshot

RUN mkdir ${home}/.themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush ${home}/.themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush-xfwm ${home}/.themes

RUN mkdir -p ${home}/.local/share/icons
COPY ./src/files/Nordzy-cyan-dark-MOD ${home}/.local/share/icons

COPY ./src/files/fonts ${home}/.local/share

RUN sudo pacman -Syu --noconfirm \
    kvantum-qt5
COPY ./src/files/Kvantum ${home}/.config

COPY ./src/configs/xfce4 ${home}/.config




RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000