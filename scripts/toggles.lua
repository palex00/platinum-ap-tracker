function toggle_itemgrid()
    suffix = ""
    
    if not has("opt_hmreader_off") then
        suffix = suffix.."_hmreader"
    end
    
    if has("opt_marsh_pass_on") then
        suffix = suffix.."_marshpass"
    end
    
    if has("opt_storage_key_on") then
        suffix = suffix.."_storagekey"
    end
    
    if has("opt_unown_item") then
        suffix = suffix.."_unownfile"
    end
    
    Tracker:AddLayouts("layouts/items/items"..suffix..".json")
end

function toggle_splitmap()
    if has("splitmap_off") then
        Tracker:AddLayouts("layouts/tabs_single.json")
    elseif has("splitmap_on") then
        Tracker:AddLayouts("layouts/tabs_split.json")
    elseif has("splitmap_reverse") then
        Tracker:AddLayouts("layouts/tabs_reverse.json")
    end
end

function toggle_trackerlayout()
    suffix = ""
   
    if not has("opt_randomize_fly_items_off") then
        suffix = suffix.."_flyunlock"
    end

    Tracker:AddLayouts("layouts/tracker"..suffix..".json")
end


function toggle_pastoriabarriers()
    if has("opt_pastoria_barriers_on") then
        Tracker:AddMaps("maps/route212north_barriers.json")
        Tracker:AddMaps("maps/route214north_barriers.json")
    elseif has("opt_pastoria_barriers_off") then
        Tracker:AddMaps("maps/route212north.json")
        Tracker:AddMaps("maps/route214north.json")
	end
end

function syncCoupons()
    if not has("opt_coupons_off") then return end
    local count = 0
    for _, code in ipairs({"coupon_1", "coupon_2", "coupon_3"}) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("coupons").AcquiredCount = count
end

function syncUnownFile()
    if not has("opt_hidden_off") then return end
    local count = 0
    for _, code in ipairs(UNOWN_ITEMS) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("unownfile").AcquiredCount = count
end

function syncPokedex()
    if not has("opt_pokedex_off") then return end
    local count = 0
    for _, code in ipairs({"pokedex_1", "pokedex_2", "pokedex_3"}) do
        if Tracker:FindObjectForCode(code).Active then
            count = count + 1
        end
    end
    Tracker:FindObjectForCode("pokedex").CurrentStage = count
end
