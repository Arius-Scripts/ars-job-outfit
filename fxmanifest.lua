fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'


author          '🔪 | Ali#0169'
description     'Job clothing system for fivem-appearance!'


client_script   "client/*.lua"
server_script   "server/*.lua"

shared_scripts  {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua',
}



dependencies {
    "fivem-appearance",
    "ox_lib",
    "ox_appearance"
}

