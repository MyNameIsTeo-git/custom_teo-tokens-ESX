Teo = {}

-- SEARCH IDENTIFIER
function Teo:GetSteamID(src)
	local identifier = GetPlayerIdentifiers(src)[1]

	if (identifier == false or identifier:sub(1, 5) ~= 'steam') then
        
        return 'No results'
    else
       
        return identifier
	end
end