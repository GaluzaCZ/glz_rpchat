RegisterNetEvent('sendMe')
AddEventHandler('sendMe', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target ~= -1 and (target == source or GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20) then
		TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(202, 83, 220, 0.6); border-radius: 10px;"><i class="fas fa-user-circle"></i> {0}: {1}</div>',
            args = { title, message }
        })
	end
end)


RegisterNetEvent('sendDo')
AddEventHandler('sendDo', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target ~= -1 and (target == source or GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20) then
		TriggerEvent('chat:addMessage', {
      	    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(220, 173, 17, 0.6); border-radius: 10px;"><i class="fas fa-users"></i> {0}: {1}</div>',
            args = { title, message }
        })
	end
end)

RegisterNetEvent('LocalOOC')
AddEventHandler('LocalOOC', function(playerId, title, message, color)
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target ~= -1 and (target == PlayerId() or GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20) then
		TriggerEvent('chat:addMessage', {
    	    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(99, 99, 99, 0.3); border-radius: 10px;"><i class="fas fa-street-view"></i> {0}: {1}</div>',
            args = { title, message }
        })
	end
end)

-- GPS
RegisterCommand('gps', function()
	local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local msg = tostring("X: " .. math.floor(coords.x) .. " Y: " .. math.floor(coords.y) .. " Z: " .. math.floor(coords.z))
	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 90, 90, 0.6); border-radius: 10px;"><i class="fas fa-map-marker-alt"></i> GPS: {0}</div>',
		args = { msg }
	})
end,false)

-- Coin / Roll
RegisterCommand('roll', function(source, args, rawCommand)
    local number = math.random(1,6)
    ExecuteCommand('me '.._U('roll_throwing',""))
    Citizen.Wait(1000)
    ExecuteCommand('doc 2')
    Citizen.Wait(4000)
    ExecuteCommand('do '.._U('roll_thrown',"")..number)
end)

RegisterCommand('coin', function(source, args, rawCommand)
  local luck = math.random(1,2)
  if luck == 2 then
      ExecuteCommand('me '.._U('coin_throwing',""))
      Citizen.Wait(1000)
      ExecuteCommand('doc 2')
      Citizen.Wait(4000)
      ExecuteCommand('do '.._U('coin_heads',""))
  elseif luck == 1 then
      ExecuteCommand('me '.._U('coin_throwing',""))
      Citizen.Wait(1000)
      ExecuteCommand('doc 2')
      Citizen.Wait(4000)
      ExecuteCommand('do '.._U('coin_tails',""))
  end
end)


-- /alert command
function Initialize(scaleform, msg)
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(10)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(_U("alert_help"))
    PushScaleformMovieFunctionParameterString(msg)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

RegisterNetEvent('alert')
AddEventHandler('alert', function(msg)
	local announce = true
	PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
    Citizen.CreateThread(function()
        while announce == true do
            Citizen.Wait(0)
            if msg then
                local scaleform = Initialize("mp_big_message_freemode", msg)
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
        end
    end)
	Citizen.Wait(Config.AlertDuration * 1000)
	announce = false
end)

-- Suggestions
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/tweet',  _U('twt_help'),  {{ name = _U('generic_argument_name'), help = _U('generic_argument_help') }} )
    TriggerEvent('chat:addSuggestion', '/twt',  _U('twt_help'),  {{ name = _U('generic_argument_name'), help = _U('generic_argument_help') }} )
    TriggerEvent('chat:addSuggestion', '/anontwt',  _U('anontwt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/me',   _U('me_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/do',   _U('do_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/ooc', _U('ooc_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/ad', _U('ad_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/police', _U('police_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/ems', _U('ems_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/gps', _U('gps_help'))
    TriggerEvent('chat:addSuggestion', '/doc', _U('doc_help'), { { name = _U("int"), help = _U("int_help") } } )
    TriggerEvent('chat:addSuggestion', '/bm',   _U('bm_prefix'),   {{ name = _U('generic_argument_name'), help = _U('generic_argument_help') }} )
    TriggerEvent('chat:addSuggestion', '/roll', _U('roll_help'))
    TriggerEvent('chat:addSuggestion', '/coin', _U('coin_help'))
    TriggerEvent('chat:addSuggestion', '/rob', _U('rob_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
end)



-- 3d stuff /me /do
-- Not mine!!
local nbrDisplaying = 1
RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offsetme = 2.04 + (nbrDisplaying*0.15)
    DisplayMe(GetPlayerFromServerId(source), text, offsetme)
end)

RegisterNetEvent('3ddo:triggerDisplay')
AddEventHandler('3ddo:triggerDisplay', function(text, source)
    local offsetdo = 2.34 + (nbrDisplaying*0.15)
    DisplayDo(GetPlayerFromServerId(source), text, offsetdo)
end)

RegisterNetEvent('3ddoc:triggerDisplay')
AddEventHandler('3ddoc:triggerDisplay', function(text, source)
    local offsetdoa = 2.34 + (nbrDisplaying*0.15)
    DisplayDoc(GetPlayerFromServerId(source), text, offsetdoa)
end)

function DisplayMe(mePlayer, text, offsetme)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)

    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if mePlayer ~= -1 and dist < 500 then
                DrawText3Dme(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetme-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDo(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)

    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if mePlayer ~= -1 and dist < 500 then
                DrawText3Ddo(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdo-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDoc(mePlayer, text, offsetdoa)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(1900)
        displaying = false
    end)

    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if mePlayer ~= -1 and dist < 500 then
                DrawText3Ddo(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdoa-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3Dme(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  scale = scale * fov
  if onScreen then
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 235, 101, 255, 68)
    end
end

function DrawText3Ddo(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  scale = scale * fov
  if onScreen then
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 232, 185, 32, 68)
    end
end