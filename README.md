# [ESX] custom_teo-tokens

Custom Tokens System ESX by MyNameIsTeo__
This script is a kind of money system that allows you to add/remove tokens from players via commands or events.

### Commands:

- To add Tokens to a Player:
`/addtokens <id> <amount>`
- To remove Tokens from a Player:
`/removetokens <id> <amount>`
- To see how many Tokens a Player has:
`/gettokens <id>`

### Events:

- To add Tokens to a Player:
`TriggerServerEvent("custom_teo-tokens:AddTokensEvent", amount)`
- To remove Tokens from a Player:
`TriggerServerEvent("custom_teo-tokens:RemoveTokensEvent", amount)`

### Requirements:

- [mysql-async](https://github.com/brouznouf/fivem-mysql-async)

### Installation

- Download the version you need (vRP or ESX)
- Put the `custom_teo-tokens` folder in your server's resource folder 
- Import `tokens_table.sql` to your database
- Add this in your `server.cfg`:

```
start custom_teo-tokens
```

### Need help?

Contact me on my [Discord](https://discord.gg/xe4UVMZ)

### Versions

- [vRP-Version](https://github.com/Teo815)
- [ESX-Version](https://github.com/Teo815)