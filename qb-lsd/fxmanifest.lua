fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'QBCore Acid & LSD Drug Script with qb-target'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Only needed if you plan to save/load data to DB
    'server.lua'
}

lua54 'yes'
