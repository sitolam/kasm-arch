FROM lscr.io/linuxserver/webtop:arch-xfce

ENV HOME /home/kasm-default-profile
WORKDIR $HOME

USER root

RUN sudo pacman -Syu --noconfirm --needed \
    git \
    base-devel

RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay 

USER 1000
RUN makepkg -si --noconfirm \
    && cd .. \
    && rm -rf yay
USER root

RUN sudo pacman -Syu --noconfirm \
    xfce4-terminal
RUN yay -Syu --noconfirm \
    mugshot

RUN mkdir .themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush .themes
COPY ./src/files/GTK-XFWM-Everblush-Theme/Everblush-xfwm .themes

RUN mkdir .local/share/icons
COPY ./src/files/Nordzy-cyan-dark-MOD .local/share/icons

COPY ./src/files/fonts .local/share

RUN sudo pacman -Syu --noconfirm \
    kvantum-qt5
COPY ./src/files/Kvantum .config

RUN xfconf-query -c xsettings -p /Net/ThemeName -s Everblush