FROM archlinux:latest

# Copy the startup script to the container
COPY start_server.sh /start_server.sh

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
    pacman -Syu --noconfirm && \
    pacman -S wget wine winetricks lib32-libunwind --noconfirm && \
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    mkdir -p /opt/steamcmd && \
    tar -xvzf steamcmd_linux.tar.gz -C /opt/steamcmd && \
    rm steamcmd_linux.tar.gz && \
    groupadd -g 568 apps && \
    useradd -u 568 -g 568 apps && \
    mkdir -p /home/apps && \
    mkdir -p /persistence && \
    chmod +x /start_server.sh && \
    chmod +x /opt/steamcmd/linux32/steamcmd && \
    chmod +x /opt/steamcmd/steamcmd.sh && \
    chown -R apps:apps /home/apps && \
    chown -R apps:apps /opt/steamcmd && \
    chown -R apps:apps /persistence

# Set environment variables with default values
ENV SERVER_NAME=ArkContainer
ENV WORLD_TYPE=TheIsland_WP
ENV MAX_PLAYERS=100
ENV SERVER_ADMIN_PASSWORD=letmein
ENV NO_BATTLEYE=True
# ENV SERVER_PASSWORD=letmein
# ENV ADDITIONAL_ARGS=

# Ports
ENV STEAM_PORT=27015
ENV QUERY_PORT=27016
ENV RCON_PORT=27017

# Switch to 'apps' user for the container runtime
USER apps

# Wine configuration
ENV WINEDEBUG=-all
ENV WINEPREFIX=/persistence/.wine

# Prepare wine
RUN wineboot --init && \
    WINEPREFIX=/persistence/.wine winetricks -q --force vcrun2019

# Use the startup script as the command
CMD ["/start_server.sh"]
