local variant = Tracker.ActiveVariantUID

-- Items
Tracker:AddItems("items/events.json")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/trainers.json")
                

-- Logic
ScriptHost:LoadScript("scripts/logic/utils.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")
ScriptHost:LoadScript("scripts/custom_items.lua")

-- Maps
Tracker:AddMaps("maps/errors.json")
Tracker:AddMaps("maps/maps.json")
Tracker:AddMaps("maps/route212north.json")
Tracker:AddMaps("maps/route214north.json")
Tracker:AddMaps("maps/pokedex.json")

-- Layout
Tracker:AddLayouts("layouts/settings_popup.json")
Tracker:AddLayouts("layouts/items/items_hmreader_marshpass_storagekey_unownfile.json")
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/submaps.json")
Tracker:AddLayouts("layouts/pokedex.json")
Tracker:AddLayouts("layouts/tabs_single.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/quick_settings.json")

-- Locations
Tracker:AddLocations("locations/access.json")
Tracker:AddLocations("locations/overworldmap.json")
Tracker:AddLocations("locations/submaps_singles.json")
Tracker:AddLocations("locations/submaps_groups.json")

-- AutoTracking for Poptracker
require("scripts/autotracking/archipelago")
require("scripts/toggles")
require("scripts/watches")
