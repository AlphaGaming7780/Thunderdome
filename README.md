
# Titanfall Legends

A Titanfall Northstar mod, that add a battle royal game mode to the game


## Documentation

It is possible to customize the game mode, by executing commands when starting the server, see the [Northstar documentation](https://r2northstar.gitbook.io/r2northstar-wiki/hosting-a-server-with-northstar/dedicated-server#playlist-overrides)

#### Get all items

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.