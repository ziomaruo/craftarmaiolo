Config = {}

Config.MarkerType   = 27
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 1.9, y = 1.9, z = 1.5}
Config.MarkerColor  = {r = 255, g = 0, b = 0}

Config.TimeToFarm    = 10 * 500

Config.Zones = {
	--startraccoltapolimero = {x = 824.36, y = -2155.55,	z = 29.00,	name = "Lana", sprite = 437, color = 75},

	startraccoltapolimero = {x = 2565.91, y = 292.45,    z = 108.73, name = "Polimero", sprite = 437, color = 75},
	startraccoltaacciaio = {x = 24.53, y = -1105.9,    z = 29.8, name = "Acciaio", sprite = 437, color = 75},
	startraccoltaergal = {x = -1304.48, y = -396.52,    z = 36.7, name = "Ergal", sprite = 437, color = 75},
	startraccoltaradica = {x = -330.37, y = 6086.53,    z = 31.45, name = "radica", sprite = 437, color = 75},
	startraccoltaminuteria= {x = 1693.5, y = 3762.91,    z = 34.71, name = "minuteria", sprite = 437, color = 75},



}


-- Ammo given by default to crafted weapons
Config.WeaponAmmoFucili = 50
Config.WeaponAmmoPistole = 120


Config.Recipes = {
	
	["weapon_musket"] = { 
        {item = "acciaio", quantity = 20 }, --ACCIAIO--
        {item = "radica", quantity = 15 }, --RADICA DI NOCE--
        {item = "ergal", quantity = 10 }, --ERGAL--
        {item = "minuteria", quantity = 20 }, --MINUTERIA--
    },
	
	["weapon_pistol"] = { 
        {item = "acciaio", quantity = 15 }, --ACCIAIO--
        {item = "polimero", quantity = 10 }, --POLIMERO--
        {item = "ergal", quantity = 8 }, --ERGAL--
        {item = "minuteria", quantity = 10 }, --MINUTERIA--
    },
	
	["weapon_combatpistol"] = { 
        {item = "acciaio", quantity = 15 }, --ACCIAIO--
        {item = "polimero", quantity = 15 }, --POLIMERO--
        {item = "ergal", quantity = 10 }, --ERGAL--
        {item = "minuteria", quantity = 15 }, --MINUTERIA--
    },
	
	["weapon_snspistol_mk2"] = { 
        {item = "acciaio", quantity = 10 }, --ACCIAIO--
        {item = "polimero", quantity = 15 }, --POLIMERO--
        {item = "radica", quantity = 10 }, --RADICA DI NOCE--
        {item = "minuteria", quantity = 10 }, --MINUTERIA--
    },


}

-- Enable a shop to access the crafting menu
Config.Shop = {
	useShop = true,
	shopCoordinates = {
	{ x=826.47, y=-2156.44, z=28.80 }, --ARMERIA
	},
	
	shopName = "Zona Crafting Armi",
	shopName2 = "Zona Raccolta materiale Armi",
	shopBlipID = 556,
	shopBlipID2 = 313,
	--zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	--zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- Enable crafting menu through a keyboard shortcut
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}