local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Local ooc
AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		TriggerClientEvent('LocalOOC', -1, source, name, message, {30, 144, 255});
	end
end)

-- OOC command
RegisterCommand('ooc', function(source, args, rawCommand)
	local playerName = GetPlayerName(source)
	local msg = rawCommand:sub(5)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(200, 200, 200, 0.80); border-radius: 10px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
		args = { playerName, msg }
	})
end, false)

-- ME command
RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	if args[1] == nil then
		return
	end

	args = table.concat(args, ' ')
	local name = GetCharacterName(source)

	TriggerClientEvent('sendMe', -1, source, name, args, { 196, 33, 246 })
	TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
	--print(('%s: %s'):format(name, args))
end, false)

-- DO command
RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	if args[1] == nil then
		return
	end

	args = table.concat(args, ' ')
	local name = GetCharacterName(source)

	TriggerClientEvent('sendDo', -1, source, name, args, { 255, 198, 0 })
	TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('doc', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	if args[1] == nil then
		return
	end
	local name = GetCharacterName(source)
	local counter_doc = 0
	local pocetOpakovani = tonumber(args[1])
	if pocetOpakovani < 21 then
		while counter_doc < pocetOpakovani do
			counter_doc = counter_doc + 1 
			TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, counter_doc .. "/" .. pocetOpakovani , { 255, 198, 0 })
			TriggerClientEvent('3ddoc:triggerDisplay', -1, counter_doc .. "/" .. pocetOpakovani, source)
			Citizen.Wait(2000)
		end
	end
end, false)

RegisterCommand('alert', function(source, args, rawCommand)
	local msg = table.concat(args, ' ')
	TriggerClientEvent("alert", -1, msg)
end, true)

-- TWEET
RegisterCommand('tweet', function(source, args, rawCommand)
	local playerName = GetCharacterName(source)
	local msg = rawCommand:sub(6)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 10px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
		args = { playerName, msg }
	})
end, false)

-- TWEET
RegisterCommand('twt', function(source, args, rawCommand)
	local playerName = GetCharacterName(source)
	local msg = rawCommand:sub(4)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 10px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
		args = { playerName, msg }
	})
end, false)

-- Reklama
RegisterCommand('ad', function(source, args, rawCommand)
	local playerName = GetCharacterName(source)
	local msg = rawCommand:sub(3)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255 , 255, 0, 0.35); border-radius: 10px;"><i class="fas fa-ad"></i> {2}: {0}<br> {1}</div>',
		args = { playerName, msg, _U("ad")}
	})
end, false)

-- Anontwt
RegisterCommand('anontwt', function(source, args, rawCommand)
	local msg = rawCommand:sub(8)

	TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 10px;"><i class="fab fa-twitter"></i> @Anonym:<br> {0}</div>',
			args = { msg }
	})
end, false)

-- BLACKMARKET
RegisterCommand('bm', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local toSay = table.concat(args, ' ')

	if xPlayer.getJob().name ~= 'police' and xPlayer.getJob().name ~= 'offpolice' then
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw 0.5vw; margin: 0.5vw 0.5vw 0.5vw 0; border-radius:10px; background-color: rgba(202,40,40, 0.6);"><i class="fas fa-money-check-alt"></i> BlackMarket:<br> {0}</div>',
			args = {toSay}
		})
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;"><i class="fas fa-exclamation"></i>  '.._U('not_allowed')..'  <i class="fas fa-exclamation"></i></div>',
			args = {}
		})
	end
end, false)

-- Robber
RegisterCommand('rob', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local msg = rawCommand:sub(4)

	if xPlayer.getJob().name ~= 'police' and xPlayer.getJob().name ~= 'offpolice' then
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(66, 66, 66, 0.8); border-radius: 10px;"><i class="fas fa-money-check-alt"></i> Robber:<br> {0}</div>',
			args = { msg, _U("robber")}
		})
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;"><i class="fas fa-exclamation"></i>  '.._U('not_allowed')..'  <i class="fas fa-exclamation"></i></div>',
			args = {}
		})
	end
end, false)

-- POLICE
RegisterCommand('police', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local toSay = table.concat(args, ' ')

	if xPlayer.getJob().name == 'police' or xPlayer.getJob().name == 'sheriff' then 
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(50, 71, 202, 0.9); border-radius: 10px;"><i class="fas fa-bullhorn"></i> Police: {0}</div>',
			args = {toSay}
		})
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;"><i class="fas fa-exclamation"></i>  '.._U('not_police')..'  <i class="fas fa-exclamation"></i></div>',
			args = {}
		})
	end
end, false)

-- Ambulance
RegisterCommand('ems', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local toSay = ''
	for i=1,#args do
		toSay = toSay .. args[i] .. ' ' -- Concats two strings together
	end

	if xPlayer.getJob().name == 'ambulance' then 
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 1); border-radius: 10px;"><i class="fas fa-ambulance"></i> Ambulance: {0}</div>',
			args = {toSay}
		})
	else 
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 10px;"><i class="fas fa-exclamation"></i>  '.._U('not_ems')..'  <i class="fas fa-exclamation"></i></div>',
			args = {}
		})
	end
end, false)

-- Get Character name
function GetCharacterName(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.ESX then
		return xPlayer.getName()
	else
		return GetPlayerName(source)
	end
end