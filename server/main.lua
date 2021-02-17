ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--------------
-- COMMANDS --
--------------

-- COMMAND TO ADD TOKENS
RegisterCommand("addtokens", function (source, args, rawCommand)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if args[1] ~= nil and args[2] ~= nil then
		local id = tonumber(args[1])
		local amount = tonumber(args[2])

		if id > 0 and amount > 0 then

			TriggerEvent("custom_teo-tokens:AddTokensFromDatabase", _source, id, amount)
		else

			xPlayer.showNotification("Enter a valid value!")
		end
	else

		xPlayer.showNotification("You have not completed a field!")
	end
end, true)

-- COMMAND TO REMOVE TOKENS
RegisterCommand("removetokens", function (source, args, rawCommand)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if args[1] ~= nil and args[2] ~= nil then
		local id = tonumber(args[1])
		local amount = tonumber(args[2])

		if id > 0 and amount > 0 then

			TriggerEvent("custom_teo-tokens:RemoveTokensFromDatabase", _source, id, amount)
		else

			xPlayer.showNotification("Enter a valid value!")
		end
	else

		xPlayer.showNotification("You have not completed a field!")
	end
end, true)

-- COMMAND TO GET TOKENS
RegisterCommand("gettokens", function (source, args, rawCommand)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if args[1] ~= nil then
		local id = tonumber(args[1]) 

		if id > 0 then

			TriggerEvent("custom_teo-tokens:GetTokensFromDatabase", _source, id)
		else

			xPlayer.showNotification("Enter a valid value!")
		end
	elseif args[1] == nil or args[1] == "" then

		TriggerEvent("custom_teo-tokens:GetTokensFromDatabase", _source)
	end
end, false)

------------
-- EVENTS --
------------

-- CREATE ROW WHEN SPAWN
RegisterServerEvent('custom_teo-tokens:CreateRow')
AddEventHandler('custom_teo-tokens:CreateRow', function()
	local _source = source
	local name = GetPlayerName(_source)
	local identifier = Teo:GetSteamID(_source)

    local result = MySQL.Sync.fetchAll('SELECT `identifier` FROM tokens WHERE `identifier` = @identifier', {
        ['@identifier'] = identifier
    })

	if result then
		if result[1] == nil then
			MySQL.Async.execute('INSERT INTO tokens (`identifier`) VALUES (@identifier)', {
				['@identifier'] = identifier
			})
		end

		MySQL.Sync.execute('UPDATE tokens SET `name` = @name WHERE `identifier` = @identifier', { 
			['@identifier'] = identifier,
			['@name'] = name
		})
	end

	print(" \27[31mTokens\27[0m - Row Updated for [USER: " .. name .. "]")
end)

-- ADD TOKENS WITH COMMAND
RegisterServerEvent("custom_teo-tokens:AddTokensFromDatabase")
AddEventHandler("custom_teo-tokens:AddTokensFromDatabase", function(_source, id, amount)
	local name = GetPlayerName(id)
	local adminName = GetPlayerName(_source)
	local identifier = Teo:GetSteamID(id)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(id)

	MySQL.Async.fetchAll('SELECT `n_tokens` FROM tokens WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result then
			if result[1] then
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = result[1].n_tokens + amount
				})
			end
		end
	end)
	
    xPlayer.showNotification("You have added " .. amount .. " Tokens to ID " .. id)
    xTarget.showNotification("You have had " .. amount .. " Tokens added!")

	print(" \27[31mTokens\27[0m - Row Updated for [USER: " .. name .. "] by [ADMIN: " .. adminName .. "] | [COMMAND: Adding Tokens]")
end)

-- REMOVE TOKENS WITH COMMAND
RegisterServerEvent("custom_teo-tokens:RemoveTokensFromDatabase")
AddEventHandler("custom_teo-tokens:RemoveTokensFromDatabase", function(_source, id, amount)
	local name = GetPlayerName(id)
	local adminName = GetPlayerName(_source)
	local identifier = Teo:GetSteamID(id)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(id)

	MySQL.Async.fetchAll('SELECT `n_tokens` FROM tokens WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result then
			if result[1].n_tokens < amount then
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = 0
				})
			else
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = result[1].n_tokens - amount
				})
			end
		end
	end)

    xPlayer.showNotification("You have removed " .. amount .. " Tokens to ID " .. id)
    xTarget.showNotification("You have had " .. amount .. " Tokens removed!")

	print(" \27[31mTokens\27[0m - Row Updated for [USER: " .. name .. "] by [ADMIN: " .. adminName .. "] | [COMMAND: Removing Tokens]")
end)

-- GET TOKENS WITH COMMAND
RegisterServerEvent("custom_teo-tokens:GetTokensFromDatabase")
AddEventHandler("custom_teo-tokens:GetTokensFromDatabase", function(_source, id)
	local name = GetPlayerName(id)
	local identifier = Teo:GetSteamID(id)
    local xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.Sync.fetchAll('SELECT `n_tokens` FROM tokens WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	})

	if result then
		if result[1] ~= nil then
			local n_tokens = result[1].n_tokens
	
            xPlayer.showNotification(name .. " has " .. n_tokens .. " Tokens!")
		end
	end
end)

-- ADD TOKENS WITH EVENT
RegisterServerEvent("custom_teo-tokens:AddTokensEvent")
AddEventHandler("custom_teo-tokens:AddTokensEvent", function(amount)
	local _source = source
	local identifier = Teo:GetSteamID(_source)
    local xTarget = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT `n_tokens` FROM tokens WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result then
			if result[1] then
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = result[1].n_tokens + amount
				})
			end
		end
	end)
	
    xTarget.showNotification("You have earned " .. amount .. " Tokens!")
end)

-- REMOVE TOKENS WITH EVENT
RegisterServerEvent("custom_teo-tokens:RemoveTokensEvent")
AddEventHandler("custom_teo-tokens:RemoveTokensEvent", function(amount)
	local _source = source
	local identifier = Teo:GetSteamID(_source)
    local xTarget = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT `n_tokens` FROM tokens WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result then
			if result[1].n_tokens < amount then
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = 0
				})
			else
				MySQL.Sync.execute('UPDATE tokens SET `n_tokens` = @n_tokens WHERE `identifier` = @identifier', { 
					['@identifier'] = identifier,
					['@n_tokens'] = result[1].n_tokens - amount
				})
			end
		end
	end)
	
    xTarget.showNotification("You have lost " .. amount .. " Tokens!")
end)