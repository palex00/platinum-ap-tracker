function toggle_itemgrid()
    suffix = ""
    
    if has("opt_hmreader_on_reqmon") or has("opt_hmreader_on_free") or has("opt_hmreader_on_reqmon") or has("opt_hmreader_precollect_reqmon") or has("opt_hmreader_precollect_free") then
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

function toggle_pastoriabarriers()
    if has("opt_pastoria_barriers_off") then
        Tracker:AddMaps("maps/route212north.json")
        Tracker:AddMaps("maps/route214north.json")
    elseif has("opt_pastoria_barriers_on") then
        Tracker:AddMaps("maps/route212north_barriers.json")
        Tracker:AddMaps("maps/route214north_barriers.json")
	end
end