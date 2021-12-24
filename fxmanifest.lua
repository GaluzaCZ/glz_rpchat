fx_version 'cerulean'

game 'gta5'

author 'GalužaCZ#8828'

description "Simple RP stuff for chat."

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	"chat"
}