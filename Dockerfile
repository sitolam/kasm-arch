FROM lscr.io/linuxserver/webtop:arch-xfce

ENV HOME /home/kasm-user
WORKDIR $HOME

USER 1000

COPY ./dbus/system.conf /etc/dbus-1/
COPY ./dbus/run.sh /etc/init/
RUN sudo pacman -Syu --noconfirm dbus
ENTRYPOINT ["/etc/init/run.sh"]


RUN sudo pacman -Syu --noconfirm --needed \
    git \
    base-devel

RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -si --noconfirm \
    && cd .. \
    && rm -rf yay

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

RUN xfconf-query -c xsettings -p /Net/ThemeName -s Everblush