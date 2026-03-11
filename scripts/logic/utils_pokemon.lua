REGIONAL_IDS = {
    [25] = true,
    [26] = true,
    [35] = true,
    [36] = true,
    [41] = true,
    [42] = true,
    [54] = true,
    [55] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [72] = true,
    [73] = true,
    [74] = true,
    [75] = true,
    [76] = true,
    [77] = true,
    [78] = true,
    [81] = true,
    [82] = true,
    [92] = true,
    [93] = true,
    [94] = true,
    [95] = true,
    [108] = true,
    [111] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [119] = true,
    [122] = true,
    [123] = true,
    [125] = true,
    [126] = true,
    [129] = true,
    [130] = true,
    [133] = true,
    [134] = true,
    [135] = true,
    [136] = true,
    [137] = true,
    [143] = true,
    [163] = true,
    [164] = true,
    [169] = true,
    [172] = true,
    [173] = true,
    [175] = true,
    [176] = true,
    [183] = true,
    [184] = true,
    [185] = true,
    [190] = true,
    [193] = true,
    [194] = true,
    [195] = true,
    [196] = true,
    [197] = true,
    [198] = true,
    [200] = true,
    [201] = true,
    [203] = true,
    [207] = true,
    [208] = true,
    [212] = true,
    [214] = true,
    [215] = true,
    [220] = true,
    [221] = true,
    [223] = true,
    [224] = true,
    [226] = true,
    [228] = true,
    [229] = true,
    [233] = true,
    [239] = true,
    [240] = true,
    [242] = true,
    [265] = true,
    [266] = true,
    [267] = true,
    [268] = true,
    [269] = true,
    [278] = true,
    [279] = true,
    [280] = true,
    [281] = true,
    [282] = true,
    [298] = true,
    [299] = true,
    [307] = true,
    [308] = true,
    [315] = true,
    [333] = true,
    [334] = true,
    [339] = true,
    [340] = true,
    [349] = true,
    [350] = true,
    [355] = true,
    [356] = true,
    [357] = true,
    [358] = true,
    [359] = true,
    [361] = true,
    [362] = true,
    [387] = true,
    [388] = true,
    [389] = true,
    [390] = true,
    [391] = true,
    [392] = true,
    [393] = true,
    [394] = true,
    [395] = true,
    [396] = true,
    [397] = true,
    [398] = true,
    [399] = true,
    [400] = true,
    [401] = true,
    [402] = true,
    [403] = true,
    [404] = true,
    [405] = true,
    [406] = true,
    [407] = true,
    [408] = true,
    [409] = true,
    [410] = true,
    [411] = true,
    [412] = true,
    [413] = true,
    [414] = true,
    [415] = true,
    [416] = true,
    [417] = true,
    [418] = true,
    [419] = true,
    [420] = true,
    [421] = true,
    [422] = true,
    [423] = true,
    [424] = true,
    [425] = true,
    [426] = true,
    [427] = true,
    [428] = true,
    [429] = true,
    [430] = true,
    [431] = true,
    [432] = true,
    [433] = true,
    [434] = true,
    [435] = true,
    [436] = true,
    [437] = true,
    [438] = true,
    [439] = true,
    [440] = true,
    [441] = true,
    [442] = true,
    [443] = true,
    [444] = true,
    [445] = true,
    [446] = true,
    [447] = true,
    [448] = true,
    [449] = true,
    [450] = true,
    [451] = true,
    [452] = true,
    [453] = true,
    [454] = true,
    [455] = true,
    [456] = true,
    [457] = true,
    [458] = true,
    [459] = true,
    [460] = true,
    [461] = true,
    [462] = true,
    [463] = true,
    [464] = true,
    [465] = true,
    [466] = true,
    [467] = true,
    [468] = true,
    [469] = true,
    [470] = true,
    [471] = true,
    [472] = true,
    [473] = true,
    [474] = true,
    [475] = true,
    [476] = true,
    [477] = true,
    [478] = true,
    [479] = true,
    [480] = true,
    [481] = true,
    [482] = true,
    [483] = true,
    [484] = true,
    [487] = true,
    [490] = true,
}

function updateCaught(value)
    CAUGHT = value
    Tracker:FindObjectForCode("num_caught").AcquiredCount = #CAUGHT
    for i = 1, 493 do
        if table_contains(value, i) then
            Tracker:FindObjectForCode("caught_"..i).Active = true
        else
            Tracker:FindObjectForCode("caught_"..i).Active = false
        end
    end
    updatePokemon()
end

function updateSeen(value)
    SEEN = value
    
    NUM_SEEN_NAT = 0
    NUM_SEEN_REG = 0
    
    Tracker:FindObjectForCode("num_seen_nat").AcquiredCount = #SEEN
    
    for _, v in ipairs(SEEN) do
        if REGIONAL_IDS[v] then
            NUM_SEEN_REG = NUM_SEEN_REG + 1
        end
    end
    
    Tracker:FindObjectForCode("num_seen_reg").AcquiredCount = NUM_SEEN_REG
    
    updatePokemon()
end


function updatePokemon()
    --This is for when Static & Trades are in logic
    --Tracker:FindObjectForCode("static_visibility").CurrentStage = 1
    
    if CAUGHT == nil or SEEN == nil then
        return
    end
    
    if has("encounter_tracking_off") then
        return
    end
    
    local regionObjects = {}
    local baseCounts = {}
    local pendingDecrements = {}
    
    for region_key, location in pairs(ENCOUNTER_MAPPING) do
        regionObjects[region_key] = Tracker:FindObjectForCode(location)
        baseCounts[region_key] = #ENCOUNTERS_GROUPED[region_key]
        pendingDecrements[region_key] = 0
    end
    
    for dex_number, locations in pairs(POKEMON_TO_LOCATIONS) do
        local dexVisibilityCode = Tracker:FindObjectForCode("dexsanity_visibility_" .. dex_number).Active
        local dexSentCode = Tracker:FindObjectForCode("dexsanity_sent_" .. dex_number).Active
        
        local is_caught = table_contains(CAUGHT, dex_number)
        local is_seen = table_contains(SEEN, dex_number)
        
        local should_decrement = false
        if is_caught then
            should_decrement = true
        elseif has("encounter_tracking_minimal") and (dexSentCode or not dexVisibilityCode) then
            should_decrement = true
        elseif has("encounter_tracking_seen") and not dexVisibilityCode and is_seen then
            should_decrement = true
        end
        
        if should_decrement then
            for _, location in pairs(locations) do
                local object_name = ENCOUNTER_MAPPING[location]
                if object_name ~= nil then
                    local object = Tracker:FindObjectForCode(object_name)
                    if object then
                        pendingDecrements[location] = pendingDecrements[location] + 1
                    end
                end
            end
        end
    end
    for region_key, object in pairs(regionObjects) do
        object.AvailableChestCount = baseCounts[region_key] - pendingDecrements[region_key]
    end
end


function searchMon()
    if POKEMON_TO_LOCATIONS ~= nil then
	    Tracker:FindObjectForCode("location_visibility").CurrentStage = 2
        --Tracker:FindObjectForCode("static_visibility").CurrentStage = 0
        Tracker:FindObjectForCode("no_wild_encounters_found").Active = false
        
        for region_key, location in pairs(ENCOUNTER_MAPPING) do
            local object = Tracker:FindObjectForCode(location)
            object.AvailableChestCount = 0
        end
        
        local dex1 = Tracker:FindObjectForCode("dexsearch_digit1").CurrentStage
        local dex2 = Tracker:FindObjectForCode("dexsearch_digit2").CurrentStage
        local dex3 = Tracker:FindObjectForCode("dexsearch_digit3").CurrentStage
        local dexID = dex1 * 100 + dex2 * 10 + dex3
        
        Tracker:FindObjectForCode("search_ID_result").CurrentStage = dexID
        
        local locations = POKEMON_TO_LOCATIONS[dexID]
        
        if not locations then
            if dexID == 0 then
                updatePokemon()
                Tracker:FindObjectForCode("go").CurrentStage = 0
                return
            else
                print("The Pokemon with the ID "..dexID.." cannot be caught in the wild!")
                Tracker:FindObjectForCode("go").CurrentStage = 0
                Tracker:FindObjectForCode("no_wild_encounters_found").Active = true
                return
            end
        end
    
        for _, location in ipairs(locations) do
            local object_name = ENCOUNTER_MAPPING[location]
            print(object_name)
            if object_name then
                local object = Tracker:FindObjectForCode(object_name)
                if object then
                    object.AvailableChestCount = object.AvailableChestCount + 1
                end
            end
        end
    end
    
    Tracker:FindObjectForCode("go").CurrentStage = 0
end