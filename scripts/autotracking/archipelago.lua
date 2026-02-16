require("scripts/autotracking/item_mapping")
require("scripts/autotracking/location_mapping")
require("scripts/autotracking/option_mapping")
require("scripts/autotracking/flag_mapping")

CUR_INDEX = -1
SLOT_DATA = nil

SLOT_DATA = {}

ROOM_SEED = "default"

if Highlight then
    HIGHLIGHT_LEVEL= {
        [0] = Highlight.None,
        [1] = Highlight.Priority,
        [2] = Highlight.NoPriority,
        [3] = Highlight.Avoid
    }
end

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
    
    resetLocations()
    resetItems()

    for k, v in pairs(slot_data) do
        if SLOT_CODES[k] then
            Tracker:FindObjectForCode(SLOT_CODES[k].code).CurrentStage = (SLOT_CODES[k].mapping and SLOT_CODES[k].mapping[v] or v)
        elseif k == "regional_dex_goal" then
            Tracker:FindObjectForCode("regional_dex_goal").AcquiredCount = v
        elseif k == "hm_badge_requirement" then
            local stage = (tonumber(v) == 1) and 0 or 1
            for _, code in pairs(HM_CODES) do
                Tracker:FindObjectForCode(code).CurrentStage = stage
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
    --updateVanillaKeyItems1(0)
    --updateVanillaKeyItems2(0)
    
    if Archipelago.PlayerNumber > -1 then
        HINT_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({HINT_ID})
        Archipelago:Get({HINT_ID})
        
        EVENT_ID = "pokemon_platinum_tracked_events_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({EVENT_ID})
        Archipelago:Get({EVENT_ID})
        
        KEY1_ID = "pokemon_platinum_tracked_unrandomized_required_locations_"..TEAM_NUMBER.."_"..PLAYER_ID.."_0"
        Archipelago:SetNotify({KEY1_ID})
        Archipelago:Get({KEY1_ID})
        
        KEY2_ID = "pokemon_platinum_tracked_unrandomized_required_locations_"..TEAM_NUMBER.."_"..PLAYER_ID.."_1"
        Archipelago:SetNotify({KEY2_ID})
        Archipelago:Get({KEY2_ID})
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
        if key == EVENT_ID then
            updateEvents(value)
        elseif key == KEY1_ID then
            updateVanillaKeyItems1(value)
        elseif key == KEY2_ID then
            updateVanillaKeyItems2(value)
        elseif key == HINT_ID then
            updateHints(value)
        end
    end
end


function onNotifyLaunch(key, value)
    if value ~= nil and value ~= 0 then
        if key == EVENT_ID then
            updateEvents(value)
        elseif key == KEY1_ID then
            updateVanillaKeyItems1(value)
        elseif key == KEY2_ID then
            updateVanillaKeyItems2(value)
        elseif key == HINT_ID then
            updateHints(value)
        end
    end
end


function updateEvents(value)
    if value ~= nil then
        for i, code in ipairs(FLAG_EVENT_CODES) do
            local obj = Tracker:FindObjectForCode(code)
            if obj ~= nil then
                obj.Active = false
            end
            local bit = value >> (i - 1) & 1
            if #code > 0 then
                local obj = Tracker:FindObjectForCode(code)
                obj.Active = obj.Active or bit == 1
            end
        end
    end
end

function updateVanillaKeyItems1(value)
    if value ~= nil then        
        -- reset progressive & consumable item codes
        Tracker:FindObjectForCode("pokedex").CurrentStage = 0
        Tracker:FindObjectForCode("coupons").AcquiredCount = 0
        
        for i, obj in ipairs(FLAG_ITEM1_CODES) do
            local bit = value >> (i - 1) & 1
            if obj.codes and (obj.option == nil or has(obj.option)) then
                for j, code in ipairs(obj.codes) do
                    local item = Tracker:FindObjectForCode(code)
                    if item then
                        if code == "pokedex" then
                            if bit == 1 then
                                item.CurrentStage = (item.CurrentStage or 0) + 1
                            end
                        elseif code == "coupons" then
                            if bit == 1 then
                                item.AcquiredCount = (item.AcquiredCount or 0) + 1
                            end
                        else
                            item.Active = item.Active or bit
                        end
                    end
                end
            end
        end
    end
end


function updateVanillaKeyItems2(value)
    if value ~= nil then        
        -- reset consumable item codes
        Tracker:FindObjectForCode("unownfile").AcquiredCount = 0
        
        for i, obj in ipairs(FLAG_ITEM2_CODES) do
            local bit = value >> (i - 1) & 1
            if obj.codes and (obj.option == nil or has(obj.option)) then
                for j, code in ipairs(obj.codes) do
                    local item = Tracker:FindObjectForCode(code)
                    if item then
                        if code == "unownfile" then
                            if bit == 1 then
                                item.AcquiredCount = (item.AcquiredCount or 0) + 1
                            end
                        else
                            item.Active = item.Active or bit
                        end
                    end
                end
            end
        end
    end
end

function updateHints(value)
    if not Highlight then
        return
    end
    
    for _, hint in ipairs(value) do
        if hint.finding_player == PLAYER_ID then
            local mapped = LOCATION_MAPPING[hint.location]
            local locations = (type(mapped) == "table") and mapped or { mapped }
    
            
            for _, location in ipairs(locations) do
                -- Only sections (items don't support Highlight)
                if type(location) == "string" and location:sub(1, 1) == "@" and Tracker:FindObjectForCode(location).ChestCount == 1 then
                    Tracker:FindObjectForCode(location).Highlight = HIGHLIGHT_LEVEL[hint.item_flags]
                end
            end
        end
    end
end

function onMap(value)
    --print(value)
    --print(dump_table(value))
end