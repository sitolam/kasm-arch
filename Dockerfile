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

COPY ./src/files/wallpapers ${HOME}/.local/share/wallpapers

COPY ./src/files/home-config ${HOME}

RUN mkdir ${HOME}/.config/gtk-3.0
COPY ./src/files/gtk-3.0/gtk.css ${HOME}/.config/gtk-3.0/gtk.css

COPY ./src/files/genmon-scripts ${HOME}/genmon-scripts

RUN sudo pacman -Syu \
    xfce4-whiskermenu-plugin 
RUN yay -Syu \
    xfce4-panel-genmon-ng-git \
    xfce4-docklike-plugin-ng-git



COPY ./src/configs/xfce4 ${HOME}/.config/xfce4

RUN sudo chown -R 1000:1000 ${HOME}

RUN sudo rm -rf \
    /config/.cache \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*