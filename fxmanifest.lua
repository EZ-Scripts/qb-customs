-- ReaperAC | Do not touch this
shared_script "@ReaperAC/await.lua"
shared_script "@ReaperAC/reaper.lua"
lua54 'yes' -- needed for reaper
fx_version 'cerulean'
game 'gta5'
version '1.2.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/menu.css',
    'html/js/ui.js',
    'html/sounds/wrench.ogg',
    'html/sounds/respray.ogg',
    "stream/carcols_gen9.meta", "stream/carmodcols_gen9.meta",
    'turn/vehicles.meta',
    'turn/carvariations.meta',
    'turn/carcols.meta',
    'turn/handling.meta',
    'turn/vehiclelayouts.meta',
}

shared_scripts {
    'config.lua',
    'shared/locations.lua',
}

client_scripts {
    '@PolyZone/client.lua','@PolyZone/BoxZone.lua','@PolyZone/EntityZone.lua', '@PolyZone/CircleZone.lua', '@PolyZone/ComboZone.lua',
    'client/cl_ui.lua',
    'client/cl_bennys.lua',
    'client/cl_main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_bennys.lua'
}

data_file 'HANDLING_FILE' 'turn/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'turn/vehicles.meta'
data_file 'CARCOLS_FILE' 'turn/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'turn/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'turn/vehiclelayouts.meta'

lua54 'yes'

data_file "CARCOLS_GEN9_FILE" "stream/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "stream/carmodcols_gen9.meta"


