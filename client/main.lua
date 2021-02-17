------------
-- EVENTS --
------------

AddEventHandler("playerSpawned",function(name, setMessage, deferrals)

    TriggerServerEvent("custom_teo-tokens:CreateRow")
end)

-----------------
-- SUGGESTIONS --
-----------------

Citizen.CreateThread(function()

    TriggerEvent("chat:addSuggestion", "/addtokens", "Add Tokens to a Player", {
        {name = "Player ID", help = "ID of the Player you want to add Tokens to"},
        {name = "Amount of Tokens", help = "Amount of Tokens to be added to the Player"}
    })

    TriggerEvent("chat:addSuggestion", "/removetokens", "Rimuovi Tokens ad un Giocatore", {
        {name = "Player ID", help = "ID of the Player you want to remove Tokens to"},
        {name = "Amount of Tokens", help = "Amount of Tokens to be removed to the Player"}
    })

    TriggerEvent("chat:addSuggestion", "/gettokens", "Mostra Tokens di un Giocatore", {
        {name = "Player ID", help = "ID of the Player whose Tokens you want to see"}
    })

end)