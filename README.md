
# Titanfall Legends

A Titanfall Northstar mod, that add a battle royal game mode to the game


## Documentation

It is possible to customize the game mode, by executing a commands when starting the server, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides)

#### Exemple:

```
  +setplaylistvaroverrides "run_epilogue 0 featured_mode_amped_tacticals 1"
```

| PlaylistOverrides | Accepted Values | Default Value | Description |
| :---------------- | :-------------- | :------------ | :---------- |
| `max_players`     | `Int`           | `20`          | Determine the amount of player max on the server |
| `max_teams`       | `Int` | `20` | Need to be the **same** as `max_players`|
| `min_players` | `Int` | `2` | The min player needed to start the game (try to don't change, don't know what would append) |
| `waitingPlayerTime` | `Int` | `30` | The time the server wait for player, befor the allow them to spawn |
| `TBR_canSpawnTitan` | `Int` | `0` | Allowed player to summon their titan \n `0` : False \n `1` : True |
| `TBR_canUseBoost` | `Int` | `0` | Allowed player to use their boost \n `0` : False \n `1`|

#### add(num1, num2)

Takes two numbers and returns the sum.
