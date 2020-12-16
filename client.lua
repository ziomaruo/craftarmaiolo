ESX = nil

local PlayerData				= {}

local display = false

local polimeroQTE 	= 0
local acciaioQTE	= 0
local ergalQTE 		= 0
local radicaQTE 	= 0
local minuteriaQTE 	= 0
local showblip = false	

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

	PlayerData = ESX.GetPlayerData()
	showblip = true
end)


function isWeapon(item)
	local weaponList = ESX.GetWeaponList()
	for i=1, #weaponList, 1 do
		if weaponList[i].label == item then
			return true
		end
	end
	return false
end

local function craftItem(ingredients)
	local ingredientsPrepped = {}
	for name, count in pairs(ingredients) do
		if count > 0 then
			table.insert(ingredientsPrepped, { item = name , quantity = count})
		end
	end
	TriggerServerEvent('craftarmaiolo:craftItem', ingredientsPrepped)
end

RegisterNetEvent('craftarmaiolo:openMenu')
AddEventHandler('craftarmaiolo:openMenu', function(playerInventory)
	SetNuiFocus(true,true)
	local preppedInventory = {}
	for i=1, #playerInventory, 1 do
		if playerInventory[i].count > 0 and not isWeapon(playerInventory[i].label) then
			table.insert(preppedInventory, playerInventory[i])
		end
	end
	SendNUIMessage({
		inventory = preppedInventory,
		display = true
	})
	display = true
end)

RegisterNUICallback('craftItemNUI', function(data, cb)
	craftItem(data)
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		display = false
	})
	display = false
end)

if Config.Keyboard.useKeyboard then
	-- Handle menu input
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(1, Config.Keyboard.keyCode) and GetLastInputMethod(2) then
				TriggerServerEvent('craftarmaiolo:getPlayerInventory')
			end
		end
	end)
end

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'ammu' then
			
			local coords = GetEntityCoords(GetPlayerPed(-1))
	
			for k,v in pairs(Config.Shop.shopCoordinates) do
					
				if not display and (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5) then
					DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				
					SetTextComponentFormat('STRING')
					AddTextComponentString("Premi ~INPUT_CONTEXT~ per fabbricare un arma")
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					if IsControlJustReleased(1, 38) then
						TriggerServerEvent('craftarmaiolo:getPlayerInventory')
					end
				end
			end

		end

	end
end)

--[[
Citizen.CreateThread(function()
	
	Citizen.Wait(0)
	
	for i=1, #Config.Shop.shopCoordinates, 1 do
		local blip = AddBlipForCoord(Config.Shop.shopCoordinates[i].x, Config.Shop.shopCoordinates[i].y, Config.Shop.shopCoordinates[i].z)
			SetBlipSprite (blip, Config.Shop.shopBlipID)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Shop.shopName)
			EndTextCommandSetBlipName(blip)
	end
		
end)
--]]
-----------PRENDERE MATERIALI

Citizen.CreateThread(function()
	
	while not showblip do
        Citizen.Wait(10)
    end
	
    if PlayerData.job.name == 'ammu' then
		for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, Config.Shop.shopBlipID2)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Shop.shopName2)
			EndTextCommandSetBlipName(blip)
			showblip = true
		end

	end
	
end)


Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'ammu' then
			
			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'ammu' then
			
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone				= currentZone
				TriggerServerEvent('craftarmaiolo:GetUserInventory', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('craftarmaiolo:hasExitedMarker', lastZone)
			end

			if isInMarker and isInZone then
				TriggerEvent('craftarmaiolo:hasEnteredMarker', 'exitMarker')
			end
		end
	end
end)


AddEventHandler('craftarmaiolo:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	TriggerServerEvent('craftarmaiolo:stopraccoltapolimero')
	TriggerServerEvent('craftarmaiolo:stopraccoltaacciaio')
	TriggerServerEvent('craftarmaiolo:stopraccoltaergal')
	TriggerServerEvent('craftarmaiolo:stopraccoltaradica')
	TriggerServerEvent('craftarmaiolo:stopraccoltaminuteria')
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('craftarmaiolo:ReturnInventory')
AddEventHandler('craftarmaiolo:ReturnInventory', function(polimero, acciaio, ergal, radica, minuteria, jobName, currentZone)
	polimeroQTE 	= polimero
	acciaioQTE 		= acciaio
	ergalQTE 		= ergal
	radicaQTE 		= radica
	minuteriaQTE 	= minuteria
	myJob		 	= jobName
	TriggerEvent('craftarmaiolo:hasEnteredMarker', currentZone)
end)

AddEventHandler('craftarmaiolo:hasEnteredMarker', function(zone)

	ESX.UI.Menu.CloseAll()
	
	if zone == 'startraccoltapolimero' then
			CurrentAction     = zone
			CurrentActionMsg  = "Premi E per raccogliere"
			CurrentActionData = {}
	end
	
	if zone == 'startraccoltaacciaio' then
			CurrentAction     = zone
			CurrentActionMsg  = "Premi E per raccogliere"
			CurrentActionData = {}
	end
	
	if zone == 'startraccoltaergal' then
			CurrentAction     = zone
			CurrentActionMsg  = "Premi E per raccogliere"
			CurrentActionData = {}
	end
	
	if zone == 'startraccoltaradica' then
			CurrentAction     = zone
			CurrentActionMsg  = "Premi E per raccogliere"
			CurrentActionData = {}
	end
	
	if zone == 'startraccoltaminuteria' then
			CurrentAction     = zone
			CurrentActionMsg  = "Premi E per raccogliere"
			CurrentActionData = {}
	end
	
	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = "Premi E per smettere"
		CurrentActionData = {}
	end
	

end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, 38) then
			
				isInZone = true 
				if CurrentAction == 'exitMarker' then
					isInZone = false 
					TriggerEvent('craftarmaiolo:freezePlayer', false)
					TriggerEvent('craftarmaiolo:hasExitedMarker', lastZone)
					Citizen.Wait(15000)
				elseif CurrentAction == 'startraccoltapolimero' then
					TriggerServerEvent('craftarmaiolo:startraccoltapolimero')
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				
				elseif CurrentAction == 'startraccoltaacciaio' then
					TriggerServerEvent('craftarmaiolo:startraccoltaacciaio')
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				elseif CurrentAction == 'startraccoltaergal' then
					TriggerServerEvent('craftarmaiolo:startraccoltaergal')
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				elseif CurrentAction == 'startraccoltaradica' then
					TriggerServerEvent('craftarmaiolo:startraccoltaradica')
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				elseif CurrentAction == 'startraccoltaminuteria' then
					TriggerServerEvent('craftarmaiolo:startraccoltaminuteria')
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				else
					isInZone = false 
				end
				
				if isInZone then
					TriggerEvent('craftarmaiolo:freezePlayer', true)
				end
				
				CurrentAction = nil
			end
		end
	end
end)

RegisterNetEvent('craftarmaiolo:freezePlayer')
AddEventHandler('craftarmaiolo:freezePlayer', function(freeze)
	FreezeEntityPosition(GetPlayerPed(-1), freeze)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)