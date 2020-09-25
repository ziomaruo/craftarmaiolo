Config = {}

Config.MarkerType   = 27
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 1.9, y = 1.9, z = 1.5}
Config.MarkerColor  = {r = 255, g = 0, b = 0}

-- Tempo di raccolta
Config.TimeToFarm    = 10 * 500

-- Zone raccolta materiali
Config.Zones = {
	startraccoltapolimero = {x = 2565.91, y = 292.45,    z = 108.73, name = "Polimero", sprite = 437, color = 75},
	startraccoltaacciaio = {x = 24.53, y = -1105.9,    z = 29.8, name = "Acciaio", sprite = 437, color = 75},
	startraccoltaergal = {x = -1304.48, y = -396.52,    z = 36.7, name = "Ergal", sprite = 437, color = 75},
	startraccoltaradica = {x = -330.37, y = 6086.53,    z = 31.45, name = "radica", sprite = 437, color = 75},
	startraccoltaminuteria= {x = 1693.5, y = 3762.91,    z = 34.71, name = "minuteria", sprite = 437, color = 75},
}


-- Munizioni default caricate su arma craftata
Config.WeaponAmmoFucili = 50
Config.WeaponAmmoPistole = 120

-- Ricette per crafting
Config.Recipes = {
	
	["weapon_musket"] = { 
        {item = "acciaio", quantity = 20 }, 
        {item = "radica", quantity = 20 }, 
        {item = "ergal", quantity = 20 }, 
        {item = "minuteria", quantity = 20 },
    },
	
	["weapon_pistol"] = { 
        {item = "acciaio", quantity = 20 }, 
        {item = "polimero", quantity = 20 }, 
        {item = "ergal", quantity = 20 },
        {item = "minuteria", quantity = 20 }, 
    },
	
	["weapon_combatpistol"] = { 
        {item = "acciaio", quantity = 20 },
        {item = "polimero", quantity = 20 }, 
        {item = "ergal", quantity = 20 },
        {item = "minuteria", quantity = 20 },
    },
	
	["weapon_snspistol_mk2"] = { 
        {item = "acciaio", quantity = 20 },
        {item = "polimero", quantity = 20 }, 
        {item = "radica", quantity = 20 },
        {item = "minuteria", quantity = 20 }, 
    },
}

-- Abilita blip negozio x crafting
Config.Shop = {
	useShop = true,
	shopCoordinates = {
		{ x=816.55, y=-2154.07, z=28.80 },
	},
	
	shopName = "Zona Crafting Armi",
	shopBlipID = 556,
	shopBlipID2 = 313,
}

-- Abilita crafting attraverso un collegamento tastiera
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}
