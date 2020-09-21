ESX = nil

local PlayersHarvestingpolimero    = {}
local PlayersHarvestingacciaio    = {}
local PlayersHarvestingergal    = {}
local PlayersHarvestingradica    = {}
local PlayersHarvestingminuteria    = {}



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('craftarmaiolo:getPlayerInventory')
AddEventHandler('craftarmaiolo:getPlayerInventory', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		TriggerClientEvent('craftarmaiolo:openMenu', _source, xPlayer.inventory)
	end
end)

function findRecipe(list)
	for item, ingredients in pairs(Config.Recipes) do
		if #ingredients == #list then
			-- same length, let's compare
			local found = 0
			for i=1, #ingredients, 1 do
				for j=1, #list, 1 do
					if ingredients[i].item == list[j].item and ingredients[i].quantity == list[j].quantity then
						found = found + 1
					end
				end
			end
			if found == #list then
				return item
			end
		end
	end
	return false
end

function hasAllIngredients(inventory, ingredients)
	for i=1, #ingredients, 1 do
		for j=1, #inventory, 1 do
			if ingredients[i].name == inventory[j].name then
				if inventory[j].count < ingredients[i].quantity then
					return false
				end
			end
		end
	end
	return true
end

function itemLabel(name, inventory)
	if string.match(string.lower(name), "weapon_") then
		return ESX.GetWeaponLabel(name)
	else
		for i=1, #inventory, 1 do
			if inventory[i].name == name then
				return inventory[i].label
			end
		end
	end
	return "unknown item"
end

RegisterServerEvent('craftarmaiolo:craftItem')
AddEventHandler('craftarmaiolo:craftItem', function(ingredients)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = findRecipe(ingredients)
	if not item then
		TriggerClientEvent('esx:showNotification', _source, 'Nessuna ricetta trovata')
	else
		if xPlayer ~= nil then
			if hasAllIngredients(xPlayer.inventory, Config.Recipes[item]) then
				for _,ingredient in pairs(Config.Recipes[item]) do
					if (ingredient.remove ~= nil and ingredient.remove) or (ingredient.remove == nil) then
						xPlayer.removeInventoryItem(ingredient.item, ingredient.quantity)
					end
				end
				--if string.match(string.lower(item), "weapon_") then
				
				if 	(string.lower(item) == "weapon_musket") then
					xPlayer.addWeapon(item, Config.WeaponAmmoFucili)
				
				elseif 	(string.lower(item) == "weapon_pistol") or
					(string.lower(item) == "weapon_combatpistol") or
					(string.lower(item) == "weapon_snspistol_mk2") then
					xPlayer.addWeapon(item, Config.WeaponAmmoPistole)
					
				
				
				--else
				--	xPlayer.addInventoryItem(item, 1)
				end
				TriggerClientEvent('esx:showNotification', _source, '~y~Arma realizzata: ~w~' .. itemLabel(item, xPlayer.inventory))
			else
				TriggerClientEvent('esx:showNotification', _source, 'Non hai tutti i componenti')
			end
		end
	end
end)

------------- RACCOLTA

RegisterServerEvent('craftarmaiolo:GetUserInventory')
AddEventHandler('craftarmaiolo:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('craftarmaiolo:ReturnInventory', 
		_source, 
		xPlayer.getInventoryItem('polimero').count,
		xPlayer.getInventoryItem('acciaio').count, 
		xPlayer.getInventoryItem('ergal').count,
		xPlayer.getInventoryItem('radica').count, 
		xPlayer.getInventoryItem('minuteria').count, 
				
		xPlayer.job.name, 
		currentZone
	)
end)

RegisterServerEvent('craftarmaiolo:startraccoltapolimero')
AddEventHandler('craftarmaiolo:startraccoltapolimero', function()

	local _source = source

	PlayersHarvestingpolimero[_source] = true

	TriggerClientEvent('esx:showNotification', _source, "Sto prendendo i componenti")

	raccoltapolimero(_source)

end)

RegisterServerEvent('craftarmaiolo:startraccoltaacciaio')
AddEventHandler('craftarmaiolo:startraccoltaacciaio', function()

	local _source = source

	PlayersHarvestingacciaio[_source] = true

	TriggerClientEvent('esx:showNotification', _source, "Sto prendendo i componenti")

	raccoltaacciaio(_source)

end)

RegisterServerEvent('craftarmaiolo:startraccoltaergal')
AddEventHandler('craftarmaiolo:startraccoltaergal', function()

	local _source = source

	PlayersHarvestingergal[_source] = true

	TriggerClientEvent('esx:showNotification', _source, "Sto prendendo i componenti")

	raccoltaergal(_source)

end)

RegisterServerEvent('craftarmaiolo:startraccoltaradica')
AddEventHandler('craftarmaiolo:startraccoltaradica', function()

	local _source = source

	PlayersHarvestingradica[_source] = true

	TriggerClientEvent('esx:showNotification', _source, "Sto prendendo i componenti")

	raccoltaradica(_source)

end)

RegisterServerEvent('craftarmaiolo:startraccoltaminuteria')
AddEventHandler('craftarmaiolo:startraccoltaminuteria', function()

	local _source = source

	PlayersHarvestingminuteria[_source] = true

	TriggerClientEvent('esx:showNotification', _source, "Sto prendendo i componenti")

	raccoltaminuteria(_source)

end)

RegisterServerEvent('craftarmaiolo:stopraccoltapolimero')
AddEventHandler('craftarmaiolo:stopraccoltapolimero', function()

	local _source = source

	PlayersHarvestingpolimero[_source] = false

end)

RegisterServerEvent('craftarmaiolo:stopraccoltaacciaio')
AddEventHandler('craftarmaiolo:stopraccoltaacciaio', function()

	local _source = source

	PlayersHarvestingacciaio[_source] = false

end)

RegisterServerEvent('craftarmaiolo:stopraccoltaergal')
AddEventHandler('craftarmaiolo:stopraccoltaergal', function()

	local _source = source

	PlayersHarvestingergal[_source] = false

end)

RegisterServerEvent('craftarmaiolo:stopraccoltaradica')
AddEventHandler('craftarmaiolo:stopraccoltaradica', function()

	local _source = source

	PlayersHarvestingradica[_source] = false

end)

RegisterServerEvent('craftarmaiolo:stopraccoltaminuteria')
AddEventHandler('craftarmaiolo:stopraccoltaminuteria', function()

	local _source = source

	PlayersHarvestingminuteria[_source] = false

end)

function raccoltapolimero(source)

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingpolimero[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local polimero = xPlayer.getInventoryItem('polimero')

			if polimero.limit ~= -1 and polimero.count >= polimero.limit then
				TriggerClientEvent('esx:showNotification', source, "Inventario pieno di questo materiale")
			else
				xPlayer.addInventoryItem('polimero', 1)
				raccoltapolimero(source)
			end

		end
	end)
end

function raccoltaacciaio(source)

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingacciaio[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local acciaio = xPlayer.getInventoryItem('acciaio')

			if acciaio.limit ~= -1 and acciaio.count >= acciaio.limit then
				TriggerClientEvent('esx:showNotification', source, "Inventario pieno di questo materiale")
			else
				xPlayer.addInventoryItem('acciaio', 1)
				raccoltaacciaio(source)
			end

		end
	end)
end

function raccoltaergal(source)

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingergal[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local ergal = xPlayer.getInventoryItem('ergal')

			if ergal.limit ~= -1 and ergal.count >= ergal.limit then
				TriggerClientEvent('esx:showNotification', source, "Inventario pieno di questo materiale")
			else
				xPlayer.addInventoryItem('ergal', 1)
				raccoltaergal(source)
			end

		end
	end)
end

function raccoltaradica(source)

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingradica[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local radica = xPlayer.getInventoryItem('radica')

			if radica.limit ~= -1 and radica.count >= radica.limit then
				TriggerClientEvent('esx:showNotification', source, "Inventario pieno di questo materiale")
			else
				xPlayer.addInventoryItem('radica', 1)
				raccoltaradica(source)
			end

		end
	end)
end

function raccoltaminuteria(source)

	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingminuteria[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local minuteria = xPlayer.getInventoryItem('minuteria')

			if minuteria.limit ~= -1 and minuteria.count >= minuteria.limit then
				TriggerClientEvent('esx:showNotification', source, "Inventario pieno di questo materiale")
			else
				xPlayer.addInventoryItem('minuteria', 1)
				raccoltaminuteria(source)
			end

		end
	end)
end