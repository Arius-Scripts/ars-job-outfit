--#--
--Fx info--
--#--
fx_version   "cerulean"
use_fxv2_oal "yes"
lua54        "yes"
game         "gta5"
version      "1.0.3"

--#--
--Resource info--
--#--
name "ars-job-outfit"
author  "Arius Development"
version      "1.0.0"
repository "https://github.com/Arius-Development/ars-job-outfit"
description "Simple script for fivem-appearance that manages job outfits"

--#--
--Manifest--
--#--
client_scripts   {
    "client/*.lua"
}

server_scripts   {
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua"
}

shared_scripts  {
    "@ox_lib/init.lua",
    "shared/*.lua",
}


