resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

author "MyNameIsTeo__"
description "Custom Token System [ESX]"
version "1.0.0"
dependency "mysql-async"

client_script {
	"config.lua",
	"client/functions.lua",
	"client/main.lua"
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/functions.lua",
	"server/main.lua"
}