local variant = Tracker.ActiveVariantUID

-- Items
Tracker:AddItems("items/events.json")
Tracker:AddItems("items/events_hosted.json")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/items_hosted.json")
Tracker:AddItems("items/items_hosted_specific.json")
Tracker:AddItems("items/flyunlock.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/settings_pokemon.json")
Tracker:AddItems("items/tools.json")
Tracker:AddItems("items/trainers.json")
Tracker:AddItems("items/pokemon.json")
Tracker:AddItems("items/dexsanity_visibility.json")
Tracker:AddItems("items/dexsanity_sent.json")

-- Logic
ScriptHost:LoadScript("scripts/logic/utils.lua")
ScriptHost:LoadScript("scripts/logic/utils_pokemon.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")
ScriptHost:LoadScript("scripts/logic/logic_pokemon.lua")
ScriptHost:LoadScript("scripts/hide_cleared.lua")
ScriptHost:LoadScript("scripts/custom_items.lua")

-- Maps
Tracker:AddMaps("maps/errors.json")
Tracker:AddMaps("maps/maps.json")
Tracker:AddMaps("maps/pastoria_off.json")
Tracker:AddMaps("maps/route210south/route210south.json")
Tracker:AddMaps("maps/route207/route207.json")
Tracker:AddMaps("maps/route215west/route215west.json")
Tracker:AddMaps("maps/pokedex.json")

-- Layout
Tracker:AddLayouts("layouts/settings_popup.json")
Tracker:AddLayouts("layouts/items/items_hmreader_marshpass_storagekey_unownfile.json")
Tracker:AddLayouts("layouts/items/encounter_items.json")
Tracker:AddLayouts("layouts/items/evolution_items.json")
Tracker:AddLayouts("layouts/flyunlock.json")
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/submaps.json")
Tracker:AddLayouts("layouts/pokedex.json")
Tracker:AddLayouts("layouts/tabs_single.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/quick_settings.json")
Tracker:AddLayouts("layouts/dexsearch.json")

-- Locations
Tracker:AddLocations("locations/access.jsonc")
Tracker:AddLocations("locations/overworldmap.jsonc")
Tracker:AddLocations("locations/submaps_singles.json")
Tracker:AddLocations("locations/submaps_groups.json")
Tracker:AddLocations("locations/submaps_encounters.json")
Tracker:AddLocations("locations/pokedex.json")
Tracker:AddLocations("locations/dexsanity.json")

-- AutoTracking for Poptracker
require("scripts/autotracking/archipelago")
require("scripts/toggles")
require("scripts/watches")
