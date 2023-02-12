
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
| :-------- | :--------| :------------------------- |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.
