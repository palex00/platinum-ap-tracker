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

function toggle_flygrid()
    if not has("opt_randomize_fly_items_all") then
        Tracker:AddLayouts("layouts/flyunlock_no_e4.json")
    else
        Tracker:AddLayouts("layouts/flyunlock.json")
    end
end

function toggle_trackerlayout()
    local suffix = ""

    if not has("opt_randomize_fly_items_off") then
        suffix = suffix.."_flyunlock"
    end

        Tracker:AddLayouts("layouts/tracker"..suffix..".json")
end


function toggle_pastoriabarriers()
    if has("opt_pastoria_barriers_on") then
        Tracker:AddMaps("maps/pastoria_barriers.json")
    elseif has("opt_pastoria_barriers_off") then
        Tracker:AddMaps("maps/pastoria_off.json")
    elseif has("opt_pastoria_barriers_unknown") then
        Tracker:AddMaps("maps/pastoria_unknown.json")
	end

	if CACHED_MAP ~= nil then
		onMap(CACHED_MAP)
	end
end

function toggle_route207roadblock()
    if has("opt_route_207_barricade_none") then
        Tracker:AddMaps("maps/route207/none.json")

    elseif has("opt_route_207_barricade_bicycle_slope") then
        Tracker:AddMaps("maps/route207/route207.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        Tracker:AddMaps("maps/route207/bicycle_slope_and_cut_tree.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        Tracker:AddMaps("maps/route207/bicycle_slope_and_psyduck.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        Tracker:AddMaps("maps/route207/bicycle_slope_and_rock_smash.json")

    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        Tracker:AddMaps("maps/route207/bicycle_slope_and_strength_boulder.json")

    elseif has("opt_route_207_barricade_cut_tree") then
        Tracker:AddMaps("maps/route207/cut_tree.json")

    elseif has("opt_route_207_barricade_impassable") then
        Tracker:AddMaps("maps/route207/impassable.json")

    elseif has("opt_route_207_barricade_psyduck") then
        Tracker:AddMaps("maps/route207/psyduck.json")

    elseif has("opt_route_207_barricade_rock_climb") then
        Tracker:AddMaps("maps/route207/rock_climb.json")

    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route207/rock_climb_and_cut_tree.json")

    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route207/rock_climb_and_psyduck.json")

    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route207/rock_climb_and_rock_smash.json")

    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route207/rock_climb_and_strength_boulder.json")

    elseif has("opt_route_207_barricade_rock_smash") then
        Tracker:AddMaps("maps/route207/rock_smash.json")

    elseif has("opt_route_207_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route207/strength_boulder.json")

    elseif has("opt_route_207_barricade_unknown") then
        Tracker:AddMaps("maps/route207/unknown.json")
	end

	if CACHED_MAP ~= nil then
		onMap(CACHED_MAP)
	end
end

function toggle_route210roadblock()
    if has("opt_route_210_lower_barricade_none") then
        Tracker:AddMaps("maps/route210south/route210south.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope") then
        Tracker:AddMaps("maps/route210south/bike_slope.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_cut_tree") then
        Tracker:AddMaps("maps/route210south/bike_slope_cut.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_psyduck") then
        Tracker:AddMaps("maps/route210south/bike_slope_psyduck.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_rock_smash") then
        Tracker:AddMaps("maps/route210south/bike_slope_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_bicycle_slope_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south/bike_slope_strength.json")

    elseif has("opt_route_210_lower_barricade_cut_tree") then
        Tracker:AddMaps("maps/route210south/cut.json")

    elseif has("opt_route_210_lower_barricade_impassable") then
        Tracker:AddMaps("maps/route210south/impassable.json")

    elseif has("opt_route_210_lower_barricade_psyduck") then
        Tracker:AddMaps("maps/route210south/psyduck.json")

    elseif has("opt_route_210_lower_barricade_rock_climb") then
        Tracker:AddMaps("maps/route210south/rock_climb.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route210south/rock_climb_cut.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route210south/rock_climb_psyduck.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route210south/rock_climb_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south/rock_climb_strength.json")

    elseif has("opt_route_210_lower_barricade_rock_smash") then
        Tracker:AddMaps("maps/route210south/rock_smash.json")

    elseif has("opt_route_210_lower_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route210south/strength.json")

    elseif has("opt_route_210_lower_barricade_surf") then
        Tracker:AddMaps("maps/route210south/surf.json")

    elseif has("opt_route_210_lower_barricade_surf_and_cut_tree") then
        Tracker:AddMaps("maps/route210south/surf_cut.json")

    elseif has("opt_route_210_lower_barricade_surf_and_psyduck") then
        Tracker:AddMaps("maps/route210south/surf_psyduck.json") 

    elseif has("opt_route_210_lower_barricade_surf_and_rock_smash") then
        Tracker:AddMaps("maps/route210south/surf_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_surf_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south/surf_strength.json")

    elseif has("opt_route_210_lower_barricade_waterfall") then
        Tracker:AddMaps("maps/route210south/waterfall.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_cut_tree") then
        Tracker:AddMaps("maps/route210south/waterfall_cut.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_psyduck") then
        Tracker:AddMaps("maps/route210south/waterfall_psyduck.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_rock_smash") then
        Tracker:AddMaps("maps/route210south/waterfall_rock_smash.json")

    elseif has("opt_route_210_lower_barricade_waterfall_and_strength_boulder") then
        Tracker:AddMaps("maps/route210south/waterfall_strength.json")

    elseif has("opt_route_210_lower_barricade_unknown") then
        Tracker:AddMaps("maps/route210south/unknown.json")
	end

	if CACHED_MAP ~= nil then
		onMap(CACHED_MAP)
	end
end

function r210trainerlocnormal()
    return has("opt_route_210_lower_barricade_none")
    or has("opt_route_210_lower_barricade_unknown")
end

function r210trainerlocchanged()
    return not (has("opt_route_210_lower_barricade_none")
    or has("opt_route_210_lower_barricade_unknown"))
end

function r210itemlocnormal()
    return has("opt_route_210_lower_barricade_none")
    or has("opt_route_210_lower_barricade_unknown")
    or has("opt_route_210_lower_barricade_impassable")
    or has("opt_route_210_lower_barricade_cut_tree")
    or has("opt_route_210_lower_barricade_rock_smash")
    or has("opt_route_210_lower_barricade_strength_boulder")
    or has("opt_route_210_lower_barricade_psyduck") 
end

function r210itemlochill()
    return has("opt_route_210_lower_barricade_bicycle_slope")
    or has("opt_route_210_lower_barricade_rock_climb")
    or has("opt_route_210_lower_barricade_bicycle_slope_and_cut_tree")
    or has("opt_route_210_lower_barricade_bicycle_slope_and_rock_smash")
    or has("opt_route_210_lower_barricade_bicycle_slope_and_psyduck")
    or has("opt_route_210_lower_barricade_rock_climb_and_rock_smash")
    or has("opt_route_210_lower_barricade_rock_climb_and_strength_boulder")
    or has("opt_route_210_lower_barricade_rock_climb_and_psyduck")
end

function r210itemlocwater()
    return not (r210itemlocnormal() or r210itemlochill())
end

function toggle_route215roadblock()
    if has("opt_route_215_barricade_none") then
        Tracker:AddMaps("maps/route215west/route215west.json")

    elseif has("opt_route_215_barricade_bicycle_bridge") then
        Tracker:AddMaps("maps/route215west/bike_bridge.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_cut_tree") then
        Tracker:AddMaps("maps/route215west/bike_bridge_cut.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_psyduck") then
        Tracker:AddMaps("maps/route215west/bike_bridge_psyduck.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_rock_smash") then
        Tracker:AddMaps("maps/route215west/bike_bridge_rock_smash.json")

    elseif has("opt_route_215_barricade_bicycle_bridge_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west/bike_bridge_strength.json")

    elseif has("opt_route_215_barricade_cut_tree") then
        Tracker:AddMaps("maps/route215west/cut.json")

    elseif has("opt_route_215_barricade_impassable") then
        Tracker:AddMaps("maps/route215west/impassable.json")

    elseif has("opt_route_215_barricade_psyduck") then
        Tracker:AddMaps("maps/route215west/psyduck.json")

    elseif has("opt_route_215_barricade_rock_climb") then
        Tracker:AddMaps("maps/route215west/rock_climb.json")

    elseif has("opt_route_215_barricade_rock_climb_and_cut_tree") then
        Tracker:AddMaps("maps/route215west/rock_climb_cut.json")

    elseif has("opt_route_215_barricade_rock_climb_and_psyduck") then
        Tracker:AddMaps("maps/route215west/rock_climb_psyduck.json")

    elseif has("opt_route_215_barricade_rock_climb_and_rock_smash") then
        Tracker:AddMaps("maps/route215west/rock_climb_rock_smash.json")

    elseif has("opt_route_215_barricade_rock_climb_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west/rock_climb_strength.json")

    elseif has("opt_route_215_barricade_rock_smash") then
        Tracker:AddMaps("maps/route215west/rock_smash.json")

    elseif has("opt_route_215_barricade_strength_boulder") then
        Tracker:AddMaps("maps/route215west/strength.json")

    elseif has("opt_route_215_barricade_surf") then
        Tracker:AddMaps("maps/route215west/surf.json")

    elseif has("opt_route_215_barricade_surf_and_cut_tree") then
        Tracker:AddMaps("maps/route215west/surf_cut.json")

    elseif has("opt_route_215_barricade_surf_and_psyduck") then
        Tracker:AddMaps("maps/route215west/surf_psyduck.json") 

    elseif has("opt_route_215_barricade_surf_and_rock_smash") then
        Tracker:AddMaps("maps/route215west/surf_rock_smash.json")

    elseif has("opt_route_215_barricade_surf_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west/surf_strength.json")

    elseif has("opt_route_215_barricade_waterfall") then
        Tracker:AddMaps("maps/route215west/waterfall.json")

    elseif has("opt_route_215_barricade_waterfall_and_cut_tree") then
        Tracker:AddMaps("maps/route215west/waterfall_cut.json")

    elseif has("opt_route_215_barricade_waterfall_and_psyduck") then
        Tracker:AddMaps("maps/route215west/waterfall_psyduck.json")

    elseif has("opt_route_215_barricade_waterfall_and_rock_smash") then
        Tracker:AddMaps("maps/route215west/waterfall_rock_smash.json")

    elseif has("opt_route_215_barricade_waterfall_and_strength_boulder") then
        Tracker:AddMaps("maps/route215west/waterfall_strength.json")

    elseif has("opt_route_215_barricade_unknown") then
        Tracker:AddMaps("maps/route215west/unknown.json")
	end

	if CACHED_MAP ~= nil then
		onMap(CACHED_MAP)
	end
end

function syncCoupons()
    if not has("opt_keyitems_off") then return end
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

function syncHostedFromBase(code)
    Tracker:FindObjectForCode(code.."_hosted").Active = Tracker:FindObjectForCode(code).Active
end

function syncBaseFromHosted(code)
    local base = code:gsub("_hosted", "")
    Tracker:FindObjectForCode(base).Active = Tracker:FindObjectForCode(code).Active
end
