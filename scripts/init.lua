local variant = Tracker.ActiveVariantUID

-- Items
Tracker:AddItems("items/events.json")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings.json")
                

-- Logic
require("scripts/logic/utils")
require("scripts/logic/logic")

-- Maps
Tracker:AddMaps("maps/maps.json")  

-- Layout
Tracker:AddLayouts("layouts/settings_popup.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/tabs_single.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- Locations
Tracker:AddLocations("locations/access.json")
Tracker:AddLocations("locations/overworldmap.json")
Tracker:AddLocations("locations/submaps_singles.json")
Tracker:AddLocations("locations/submaps_groups.json")

-- AutoTracking for Poptracker
require("scripts/autotracking/archipelago")
require("scripts/watches")
