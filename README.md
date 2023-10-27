# ARK: Survival Ascended Server

> THIS IS A WORK IN PROGRESS AND NOT FUNCTIONING YET

This Dockerfile is designed to set up a dedicated server in a Docker container on TrueNAS Scale primarily.

## Setting Environment Variables

You can customize your server by setting the appropriate environment variables. Here are the variables available:

- **STEAM_USERNAME**: Steam username that owns the game.
- **STEAM_PASSWORD**: Steam password.
- **SERVER_NAME**: Server name to display in the server browser (default: `ArkContainer`).
- **WORLD_TYPE**: Defines the world type (default: `TheIsland_WP`).
- **MAX_PLAYERS**: Max number of players (default: `20`).
- **STEAM_PORT**: Steam port (default: `27015`).
- **QUERY_PORT**: Query port (default: `27017`).
- **SERVER_ADMIN_PASSWORD**: Admin password (default: `letmein`).
- **NO_BATTLEYE**: Disable BattleEye (default: `True`).
- **SERVER_PASSWORD**: (Optional) Server password.
- **ADDITIONAL_ARGS**: (Optional) Additional arguments.

## Port forwarding (TCP and UDP)

> Exposed and forwarded ports must be the same, no remapping.

Make sure to port expose and forward;
- STEAM_PORT
- STEAM_PORT + 1
- QUERY_PORT

## Persistence

Mount the persistence directory to `/persistence`
Make sure the directory on TrueNAS is owned by the user and group `apps`
