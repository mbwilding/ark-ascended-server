#!/bin/bash

# Log in to Steam anonymously and download the dedicated server
/opt/steamcmd/steamcmd.sh +force_install_dir /persistence +@sSteamCmdForcePlatformType windows +login $STEAM_USERNAME $STEAM_PASSWORD +app_update 2430930 validate +quit

# Start command, preparing for command building
CMD_START="wine64 /persistence/ShooterGame/Binaries/Win64/ArkAscendedServer.exe"
CMD_START="${CMD_START} ${WORLD_TYPE}"

# Append the settings based on ? parameters
[ -n "$SERVER_NAME" ] && CMD_START="${CMD_START}?SessionName=${SERVER_NAME}"
[ -n "$SERVER_PASSWORD" ] && CMD_START="${CMD_START}?ServerPassword=${SERVER_PASSWORD}"
[ -n "$SERVER_ADMIN_PASSWORD" ] && CMD_START="${CMD_START}?ServerAdminPassword=${SERVER_ADMIN_PASSWORD}"
[ -n "$MAX_PLAYERS" ] && CMD_START="${CMD_START}?MaxPlayers=${MAX_PLAYERS}"
[ -n "$STEAM_PORT" ] && CMD_START="${CMD_START}?Port=${STEAM_PORT}"
[ -n "$QUERY_PORT" ] && CMD_START="${CMD_START}?QueryPort=${QUERY_PORT}"
[ -n "$RCON_PORT" ] && CMD_START="${CMD_START}?RCONPort=${RCON_PORT}"

# Append the settings based on - parameters
[ "$NO_BATTLEYE" == "True" ] && CMD_START="${CMD_START} -NoBattlEye"
[ -n "$ADDITIONAL_ARGS" ] && CMD_START="${CMD_START} ${ADDITIONAL_ARGS}"

# Execute the command
exec $CMD_START
