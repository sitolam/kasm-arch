FROM lscr.io/linuxserver/webtop:arch-xfce

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
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush ${HOME}/.themes/Everblush
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush-xfwm ${HOME}/.themes/Everblush

RUN mkdir -p ${HOME}/.local/share/icons
COPY ./src/files/Nordzy-cyan-dark-MOD ${HOME}/.local/share/icons/Nordzy-cyan-dark-MOD

COPY ./src/files/fonts ${HOME}/.local/share/fonts

RUN sudo pacman -Syu --noconfirm \
    kvantum-qt5
COPY ./src/files/Kvantum ${HOME}/.config/Kvantum


RUN git clone https://github.com/vinceliuice/McMojave-cursors ${HOME}/McMojave-cursors \
    && cd ${HOME}/McMojave-cursors \
    && sudo ./install.sh \
    && cd .. \
    && sudo rm -rf ${HOME}/McMojave-cursors



COPY ./src/configs/xfce4 ${HOME}/.config/xfce4
