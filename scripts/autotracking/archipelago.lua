require("scripts/autotracking/item_mapping")
require("scripts/autotracking/location_mapping")
require("scripts/autotracking/option_mapping")
require("scripts/autotracking/flag_mapping")
require("scripts/autotracking/map_mapping")
require("scripts/autotracking/encounter_mapping")

CUR_INDEX = -1
SLOT_DATA = nil

SLOT_DATA = {}
ENCOUNTERS_GROUPED = {}
ROOM_SEED = "default"
SAVED_HINTS = {}

if Highlight then
    HIGHLIGHT_LEVEL= {
        [10] = Highlight.Unspecified,
        [20] = Highlight.Avoid,
        [30] = Highlight.Priority,
        [40] = Highlight.None,
        [100] = Highlight.Unspecified,
        [101] = Highlight.Priority,
        [102] = Highlight.NoPriority,
        [103] = Highlight.Priority,
        [104] = Highlight.Avoid,
        [105] = Highlight.Priority,
        [106] = Highlight.NoPriority,
        [107] = Highlight.Priority,
    }
end

HIGHLIGHT_PRIORITY =  {
    [Highlight.Priority] = 1, -- priority
    [Highlight.NoPriority] = 2, -- useful
    [Highlight.Avoid] = 3, -- trap
    [Highlight.Unspecified] = 4, -- filler
    [Highlight.None] = 5 -- none
}

function onClear(slot_data)
    print(dump_table(slot_data))
    CUR_INDEX = -1
    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0
    SLOT_DATA = slot_data
    GAME = Archipelago:GetPlayerGame(PLAYER_ID)
    
    -- we check for correct game, version, and non manual
    if GAME == "Manual_PokemonPlatinum_Linneus" then
        Tracker:AddLayouts("layouts/errors/error_manual.json")
        return
    elseif GAME == "Pokemon Platinum" then
        if slot_data["version"] == nil then
            Tracker:AddLocations("locations/oldversionsupport.json")
            -- pass
        else
            local version = tostring(slot_data["version"])
            local major_version = version:match("^([^.]+%.[^.]+)%.")
            if major_version == "0.1" then
                -- yey. pass.
            else
                Tracker:AddLayouts("layouts/errors/error_version.json")
            end
        end
    else
        Tracker:AddLayouts("layouts/errors/error_game.json")
        return
    end
    
    -------------------------------------------------
    -- RESET AREA
    resetLocations()
    resetItems()
    -------------------------------------------------


    for k, v in pairs(slot_data) do
        if SLOT_CODES[k] then
            Tracker:FindObjectForCode(SLOT_CODES[k].code).CurrentStage = (SLOT_CODES[k].mapping and SLOT_CODES[k].mapping[v] or v)
        elseif k == "regional_dex_goal" then
            Tracker:FindObjectForCode("regional_dex_goal").AcquiredCount = v
        elseif k == "hm_badge_requirement" then
            if v == 0 then
                for _, code in pairs(HM_CODES) do
                    Tracker:FindObjectForCode(code).CurrentStage = 1
                end
            end
        elseif k == "remove_badge_requirements" then
            for _, hm in pairs(v) do
                if HM_CODES[hm] then
                    Tracker:FindObjectForCode(HM_CODES[hm]).CurrentStage = 1
                end
            end
        end
    end
    
    updateEvents(0)
    
    if Archipelago.PlayerNumber > -1 then 
        local suffix = TEAM_NUMBER .. "_" .. PLAYER_ID
        local function makeID(s) return "pokemon_platinum_" .. s .. suffix end
        IDs = {
            EVENT      = makeID("tracked_events_"),
            KEY1       = "pokemon_platinum_tracked_unrandomized_required_locations_"..suffix.."_0",
            KEY2       = "pokemon_platinum_tracked_unrandomized_required_locations_"..suffix.."_1",
            HINT       = "_read_hints_" .. suffix,
        }
        
        for _, id in pairs(IDs) do
            Archipelago:SetNotify({id})
            Archipelago:Get({id})
        end
    end
end

function resetLocations()
    for _, location_array in pairs(LOCATION_MAPPING) do
        for _, location in pairs(location_array) do
            if location then
                local location_obj = Tracker:FindObjectForCode(location)
                if location_obj then
                    if location:sub(1, 1) == "@" then
                        location_obj.AvailableChestCount = location_obj.ChestCount
                    else
                        location_obj.Active = false
                    end
                end
            end
        end
    end
end

function resetItems()
    for _, item_array in pairs(ITEM_MAPPING) do
        for _, item_pair in pairs(item_array) do
            item_code = item_pair[1]
            item_type = item_pair[2]
            -- print("on clear", item_code, item_type)
            local item_obj = Tracker:FindObjectForCode(item_code)
            if item_obj then
                if item_obj.Type == "toggle" then
                    item_obj.Active = false
                elseif item_obj.Type == "progressive" then
                    item_obj.CurrentStage = 0
                elseif item_obj.Type == "consumable" then
                    if item_obj.MinCount then
                        item_obj.AcquiredCount = item_obj.MinCount
                    else
                        item_obj.AcquiredCount = 0
                    end
                elseif item_obj.Type == "progressive_toggle" then
                    item_obj.CurrentStage = 0
                    item_obj.Active = false
                end
            end
        end
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local item = ITEM_MAPPING[item_id]
    if not item or not item[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    for _, item_pair in pairs(item) do
        item_code = item_pair[1]
        item_type = item_pair[2]
        local item_obj = Tracker:FindObjectForCode(item_code)
        if item_obj then
            if item_obj.Type == "toggle" then
                -- print("toggle")
                item_obj.Active = true
            elseif item_obj.Type == "progressive" then
                -- print("progressive")
                if item_obj.Active == true then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            elseif item_obj.Type == "consumable" then
                -- print("consumable")
                item_obj.AcquiredCount = item_obj.AcquiredCount + item_obj.Increment * (tonumber(item_pair[3]) or 1)
            elseif item_obj.Type == "progressive_toggle" then
                -- print("progressive_toggle")
                if item_obj.Active then
                    item_obj.CurrentStage = item_obj.CurrentStage + 1
                else
                    item_obj.Active = true
                end
            end
        else
            print(string.format("onItem: could not find object for code %s", item_code[1]))
        end
    end
end

-- This is a debug to be used so you can check if there's locations that exist in either
-- the pack or the game (fullsanity seed) that don't in the tracker
------ tables to track usage
----local missing_mappings = {}   -- location_ids passed to function but not in LOCATION_MAPPING
----local called_mappings  = {}   -- mappings that were actually used
----
----function onLocation(location_id, location_name)
----    local location_array = LOCATION_MAPPING[location_id]
----
----    -- mark this id as called
----    called_mappings[location_id] = true
----
----    -- no mapping exists
----    if not location_array then
----        missing_mappings[location_id] = true
----        return
----    end
----
----    for _, location in pairs(location_array) do
----        -- (code)
----    end
----end
----
------ call this when processing is finished
----function printLocationReport()
----    print("=== Missing LOCATION_MAPPING ===")
----    for id, _ in pairs(missing_mappings) do
----        print(id)
----    end
----
----    print("=== LOCATION_MAPPING never called ===")
----    for id, _ in pairs(LOCATION_MAPPING) do
----        if not called_mappings[id] then
----            print(id)
----        end
----    end
----end

---- we use this for hint tracking
CLEARED_LOCATIONS = {}
--called when a location gets cleared
function onLocation(location_id, location_name)
    local location_array = LOCATION_MAPPING[location_id]
    if not location_array or not location_array[1] then
        print(string.format("onLocation: could not find location mapping for id %s", location_id))
        return
    end

    for _, location in pairs(location_array) do
        local location_obj = Tracker:FindObjectForCode(location)
        -- print(location, location_obj)
        if location_obj then
            if location:sub(1, 1) == "@" then
                location_obj.AvailableChestCount = location_obj.AvailableChestCount - 1
                local current_total = CLEARED_LOCATIONS[location_id] or 0
                CLEARED_LOCATIONS[location_id] = current_total + 1
            else
                location_obj.Active = true
            end
        else
            print(string.format("onLocation: could not find location_object for code %s", location))
        end
    end
end

function onNotify(key, value, old_value)
    if value ~= nil and value ~= 0 and old_value ~= value then
        if key == IDs.EVENT then
            updateEvents(value)
        elseif key == IDs.KEY1 then
            updateVanillaKeyItems(1, value)
        elseif key == IDs.KEY2 then
            updateVanillaKeyItems(2, value)
        elseif key == IDs.HINT then
            SAVED_HINTS = value
            updateHints()
        elseif key == IDs.CAUGHT then
            updateCaught(value)
        elseif key == IDs.SEEN then
            updateSeen(value)
        end
    end
end

function updateEvents(value)
    if value ~= nil then
        for i, code in ipairs(FLAG_EVENT_CODES) do
            local bit = (value >> (i - 1)) & 1
            Tracker:FindObjectForCode(code).Active = (bit == 1)
        end
    end
end

function updateVanillaKeyItems(register, value)
    if value == nil then return end

    local list = _G["FLAG_ITEM" .. tostring(register) .. "_CODES"]

    for i, obj in ipairs(list) do
        local bit = (value >> (i - 1)) & 1
        if obj.codes and (not obj.option or has(obj.option)) then
            for _, code in ipairs(obj.codes) do
                Tracker:FindObjectForCode(code).Active = (bit == 1)
            end
        end
    end

    syncCoupons()
    syncUnownFile()
    syncPokedex()
end

function toggleHints()
    if has("hint_tracking_off") then
        updatePokemon()
        resetHints()
    elseif has("hint_tracking_on") then
        resetHints()
        updateHints()
        updatePokemon()
    elseif has("hint_tracking_on_plus") then
        updateHints()
        updatePokemon()
    end
end

function resetHints()
    CLEARED_HINTS = {}
    for _, hint in ipairs(SAVED_HINTS) do
        if hint.finding_player == PLAYER_ID then
            local mapped = LOCATION_MAPPING[hint.location]
            local locations = (type(mapped) == "table") and mapped or { mapped }
    
            for _, location in ipairs(locations) do
                -- Only sections (items don't support Highlight)
                if location:sub(1, 1) == "@" then
                    local obj = Tracker:FindObjectForCode(location)
                    local final_value = obj.ChestCount
                    local cleared = CLEARED_LOCATIONS[location] or 0
                    final_value = final_value - cleared
                    obj.AvailableChestCount = final_value
                    obj.Highlight = 0
                end
            end
        end
    end
    
    for _, location in pairs(ENCOUNTER_MAPPING) do
        if location and location:sub(1, 1) == "@" then
            local obj = Tracker:FindObjectForCode(location)
            obj.Highlight = 0
        end
    end
end

CLEARED_HINTS = {}
function updateHints()
    if not Highlight then return end
    if has("hint_tracking_off") then return end

    CLEARED_HINTS = {}

    for _, locations in pairs(LOCATION_MAPPING) do
        for _, location in pairs(locations) do
            if location:sub(1, 1) == "@" then
                local obj = Tracker:FindObjectForCode(location)
                obj.Highlight = 0
            end
        end
    end
    for _, location in pairs(ENCOUNTER_MAPPING) do
        if location:sub(1, 1) == "@" then
            local obj = Tracker:FindObjectForCode(location)
            obj.Highlight = 0
        end
    end
    
    local tracking_plus = has("hint_tracking_on_plus")
    for _, hint in ipairs(SAVED_HINTS) do
        if hint.finding_player == PLAYER_ID then
            local mapped = LOCATION_MAPPING[hint.location]
            local incoming_val = 0
            
            if hint.status == 0 then
                incoming_val = HIGHLIGHT_LEVEL[100 + hint.item_flags]
            else
                incoming_val = HIGHLIGHT_LEVEL[hint.status]
            end

            -- Special handling for Pokémon locations (262145–262637)
            if hint.location >= 262145 and hint.location <= 262637 then
                local poke_id = hint.location - 262144
                local poke_locations = POKEMON_TO_LOCATIONS[poke_id]

                if poke_locations then
                    for _, encounter_key in pairs(poke_locations) do
                        local mapped_location = ENCOUNTER_MAPPING[encounter_key]
                        if mapped_location and mapped_location:sub(1, 1) == "@" then
                            local obj = Tracker:FindObjectForCode(mapped_location)
    
                            if tracking_plus then
                                if hint.found == false then
                                    if incoming_val == Highlight.Priority then
                                        obj.Highlight = incoming_val
                                    end
                                end
                            else
                                local current_val = obj.Highlight
                                if current_val == nil or HIGHLIGHT_PRIORITY[incoming_val] < HIGHLIGHT_PRIORITY[current_val] then
                                    obj.Highlight = incoming_val
                                end
                            end
                        end
                    end
                end

                goto continue_hint
            end

            local locations = (type(mapped) == "table") and mapped or { mapped }

            for _, location in ipairs(locations) do
                if location:sub(1, 1) == "@" then
                    local obj = Tracker:FindObjectForCode(location)
    
                    if tracking_plus then
                        if hint.found == false then
                            if incoming_val == Highlight.Priority then
                                obj.Highlight = incoming_val
                            else
                                local current_total = CLEARED_HINTS[location] or 0
                                CLEARED_HINTS[location] = current_total + 1
                            end
                        end
                    else
                        local current_val = obj.Highlight
                        if current_val == nil or HIGHLIGHT_PRIORITY[incoming_val] < HIGHLIGHT_PRIORITY[current_val] then
                            obj.Highlight = incoming_val
                        end
                    end
                end
            end

            ::continue_hint::
        end
    end

    if tracking_plus then
        for location, count in pairs(CLEARED_HINTS) do
            local obj = Tracker:FindObjectForCode(location)
            local cleared = CLEARED_LOCATIONS[location] or 0
            obj.AvailableChestCount = obj.ChestCount - count - cleared
            if obj.AvailableChestCount == 0 then
                obj.Highlight = 0
            end
        end
    end
end

function onMap(mapBounce)
    if has("automap_on") and mapBounce.data ~= nil then
        local mapID = mapBounce.data.mapNumber
        
        if MAP_XZYSPLIT_MAPPING[mapID] ~= nil then
            local matrixX = mapBounce.data.matrixX
            local matrixZ = mapBounce.data.matrixZ
            local playerY = mapBounce.data.playerY
            local tabs = MAP_XZYSPLIT_MAPPING[mapID] and MAP_XZYSPLIT_MAPPING[mapID][matrixX] and MAP_XZYSPLIT_MAPPING[mapID][matrixX][matrixZ] and MAP_XZYSPLIT_MAPPING[mapID][matrixX][matrixZ][playerY]
            if tabs then
                for i, tab in ipairs(tabs) do
                    Tracker:UiHint("ActivateTab", tab)
                end
            end
        elseif MAP_SPLIT_MAPPING[mapID] ~= nil then
            local matrixX = mapBounce.data.matrixX
            local matrixZ = mapBounce.data.matrixZ
            local tabs = MAP_SPLIT_MAPPING[mapID] and MAP_SPLIT_MAPPING[mapID][matrixX] and MAP_SPLIT_MAPPING[mapID][matrixX][matrixZ]
            if tabs then
                for i, tab in ipairs(tabs) do
                    Tracker:UiHint("ActivateTab", tab)
                end
            end
        elseif MAP_MAPPING[mapID] ~= nil then    
            local tabs = MAP_MAPPING[mapID]
            if tabs then
                for _, tab in ipairs(tabs) do
                    Tracker:UiHint("ActivateTab", tab)
                end
            end
        else
            --print("No Mapping found for:")
            --print(dump_table(mapBounce))
        end
    end
end
