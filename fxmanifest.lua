fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'
version      '1.0.3'

author          '🔪 | Ali#0169'
description     'Job clothing system for illenium-appearance!'


client_script   "client/*.lua"
server_script   "server/*.lua"

shared_scripts  {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua',
}


dependencies {
    "illenium-appearance",
    "ox_lib",
}

