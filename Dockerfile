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

COPY ./src/files/gtk-3.0 ${HOME}/.config/gtk-3.0

COPY ./src/files/genmon-scripts ${HOME}/genmon-scripts

RUN sudo pacman -Syu --noconfirm \
    xfce4-whiskermenu-plugin \
    xfce4-genmon-plugin
RUN yay -Syu --noconfirm \
    xfce4-docklike-plugin-ng-git

RUN sudo pacman -Syu --noconfirm \
    alsa-utils \
    brightnessctl \
    jq \
    playerctl
RUN yay -Syu --noconfirm \
    rustup \
    eww
COPY ./src/files/eww ${HOME}/.config/eww

RUN yay -Syu --noconfirm \
    findex-bin	
COPY ./src/files/findex ${HOME}/.config/findex

RUN sudo pacman -Syu --noconfirm \
    neofetch
COPY ./src/files/neofetch ${HOME}/.config/neofetch

RUN yay -Syu --noconfirm \
    thorium-browser-bin \
    flowtime \
    visual-studio-code-bin \
    anki-bin \
    mpv

RUN sudo pacman -Syu --noconfirm \
    neovim
COPY ./src/configs/nvim ${HOME}/.config/nvim

COPY ./src/configs/.bashrc ${HOME}/.bashrc

RUN sudo pacman -Syu --noconfirm \
    fish
COPY ./src/configs/fish/config.fish ${HOME}/.config/fish/config.fish
RUN sudo chsh -s /usr/bin/fish kasm-user

RUN sudo pacman -Syu --noconfirm \
    fastfetch
COPY ./src/configs/fastfetch ${HOME}/.config/fastfetch

RUN sudo pacman -Syu --noconfirm \
    ttf-jetbrains-mono-nerd 


COPY ./src/configs/autostart ${HOME}/.config/autostart
RUN sudo chmod +x ${HOME}/.config/autostart/*


COPY ./src/configs/Anki2 ${HOME}/.local/share/Anki2

COPY ./src/configs/xfce4 ${HOME}/.config/xfce4

RUN sudo chown -R 1000:1000 ${HOME}

RUN yay -Sc --noconfirm
RUN sudo rm -rf \
    /config/.cache \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/* \
    ${HOME}/.cache