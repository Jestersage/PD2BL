--Blacklist players in PAYDAY 2
 
--Edit 'Name1' and 'Name2' below to a user's in-game name or SteamID64 (community ID or friend ID), or add to them, to automatically block a player from joining your game (as if you have kicked them previously).
local Ban_list = {}
 
local HostNetworkSession_init_orig = HostNetworkSession.init

--function is_in_banlist(peer)
function is_in_banlist(...)
	local file = io.open("./data/blacklist.txt", "r")
	--local ban_data = {}
	local u_name = managers.network.account:username()

	for line in file:lines() do
		table.insert (Ban_list, line);
	end

    --[[
	for i = 1, #Ban_list do
		if (peer:user_id() == Ban_list[i]) then
			managers.chat:send_message(ChatManager.GAME, u_name or "Offline", peer:name() .. "(" .. peer:user_id() .. ") is in blacklist.")
			return true
		end
	end
	return false
    --]]
end

function HostNetworkSession:init(...)
    is_in_banlist() --not from original code
    HostNetworkSession_init_orig(self, ...)
    for k, v in ipairs(Ban_list or {}) do
        self._kicked_list[v] = true
    end
end

--[[
--Original
local Ban_list = {
    "name1",
    "name2",
   }
 
local HostNetworkSession_init_orig = HostNetworkSession.init

function HostNetworkSession:init(...)
    HostNetworkSession_init_orig(self, ...)
    for k, v in ipairs(Ban_list or {}) do
        self._kicked_list[v] = true
    end
end

]]--