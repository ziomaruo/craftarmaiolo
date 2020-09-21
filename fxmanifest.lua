fx_version 'adamant'
games { 'rdr3', 'gta5' }
author 'ZioMaruo'
description 'Attività per armaiolo Crafting armi'
version '1.0.0'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/index.css',
  'html/fonts/SignPainter.ttf',
  'html/item-quantity-dropdown.js',

}

client_scripts {
	"config.lua",
	"client.lua"
}

server_scripts {
	"config.lua",
	"server.lua"
}