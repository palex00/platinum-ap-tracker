function land_encounters()
    return AccessibilityLevel.Normal
end

function day_encounters()
    if not day() then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_timeofday_on"), AccessibilityLevel.SequenceBreak)
end

function night_encounters()
    if not night() then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_timeofday_on"), AccessibilityLevel.SequenceBreak)
end

function radar_encounters()
    if not has("radar") or not has("bag") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_radar_on"), AccessibilityLevel.SequenceBreak)
end

function firered_encounters()
    if not has("fireredcartridge") or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end

function leafgreen_encounters()
    if not has("leafgreencartridge") or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end

function ruby_encounters()
    if not has("rubycartridge") or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end

function sapphire_encounters()
    if not has("sapphirecartridge") or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end

function emerald_encounters()
    if not has("emeraldcartridge") or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end

function any_cartridge_encounters()
    if not (has("fireredcartridge") or has("leafgreencartridge") or has("ruby_encounters") or has("sapphire_encounters") or has("emerald_encounters")) or not has("poketch") then return AccessibilityLevel.None end
    
    return math.max(has_level("encmethod_cartridge_on"), AccessibilityLevel.SequenceBreak)
end


function swarm_encounters()

    if not has("poffincase") or not has("bag") then
        return AccessibilityLevel.None
    end

    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    
    if has("encmethod_swarm_on") then
        if has("opt_start_with_swarms_on") then
            return AccessibilityLevel.Normal
        elseif has("national_dex") then
            return cynthia
        else
            return AccessibilityLevel.None
        end
    else
        if has("opt_start_with_swarms_on") then
            return AccessibilityLevel.SequenceBreak
        elseif has("national_dex") then
            return math.min(cynthia, AccessibilityLevel.SequenceBreak)
        else
            return AccessibilityLevel.None
        end
    end
end

function surf_encounters()
    if not surf() then return AccessibilityLevel.None end
    
    if has("encmethod_surf_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function roamer_encounters_cresselia()
    if not has("poketch") or not has("markingmap") or not has("event_roamer_1") then return AccessibilityLevel.None end
    
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("encmethod_roamer_on") then
        return math.max(has_level("opt_can_reset_legendaries_in_ap_helper_on"), cynthia, AccessibilityLevel.SequenceBreak)    
    end
    
    return AccessibilityLevel.SequenceBreak
end

function roamer_encounters_mesprit()
    if not has("poketch") or not has("markingmap") or not has("event_roamer_0") then return AccessibilityLevel.None end
    
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("encmethod_roamer_on") then
        return math.max(has_level("opt_can_reset_legendaries_in_ap_helper_on"), cynthia, AccessibilityLevel.SequenceBreak)    
    end
    
    return AccessibilityLevel.SequenceBreak
end

function roamer_encounters_birds()
    if not has("poketch") or not has("markingmap") or not has("event_roamer_3") then return AccessibilityLevel.None end
    
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("encmethod_roamer_on") then
        return math.max(has_level("opt_can_reset_legendaries_in_ap_helper_on"), cynthia, AccessibilityLevel.SequenceBreak)    
    end
    
    return AccessibilityLevel.SequenceBreak
end

function feebas_fishing_encounters()
    if not has("bag") or not (has("oldrod") or has("goodrod") or has("superrod")) or not surf() then return AccessibilityLevel.None end

    if has("encmethod_feebasfishing_on") and has("poketch") and has("dowsingmachine") and has("pokesonar") then
        return AccessibilityLevel.Normal
    end
    
    return AccessibilityLevel.SequenceBreak
end

function soft_honey()
	if has("honey") or has("caught_415") then
	    return AccessibilityLevel.SequenceBreak
	else
        return AccessibilityLevel.None
    end
end

function regular_honey_tree_encounters()
    local meadow = Tracker:FindObjectForCode("@floaroma_meadow_south").AccessibilityLevel
    if has("encmethod_honeytree_on") then
        return math.max(meadow, soft_honey())
    else
        if math.max(meadow, soft_honey()) >= 5 then
            return AccessibilityLevel.SequenceBreak
        end
    end
    return AccessibilityLevel.None
end

function munchlax_honey_tree_encounters()
    local meadow = Tracker:FindObjectForCode("@floaroma_meadow_south").AccessibilityLevel
    if has("treecamera") and has("poketch") and has("dowsingmachine") and has("encmethod_munchlaxtree_on") then
        return math.max(meadow, soft_honey())
    else
        if math.max(meadow, soft_honey()) >= 5 then
            return AccessibilityLevel.SequenceBreak
        end
    end
    return AccessibilityLevel.None
end

function great_marsh_observatory_encounters()
    if has("encmethod_greatmarsh_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function trophy_garden_encounters()
    if not has("national_dex") then return AccessibilityLevel.None end
    if has("encmethod_trophygarden_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function great_marsh_observatory_national_dex_encounters()
    if not has("national_dex") then return AccessibilityLevel.None end
    
    if has("encmethod_greatmarsh_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function oldrod_encounters()
    if not has("bag") or not has("oldrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function goodrod_encounters()
    if not has("bag") or not has("goodrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function superrod_encounters()
    if not has("bag") or not has("superrod") then return AccessibilityLevel.None end

    if has("encmethod_fishing_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function odd_keystone_encounters()
    if not has("oddkeystone") then return AccessibilityLevel.None end

    if has("encmethod_oddkeystone_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
	end
end

function evo_item_shop()
    if has("opt_evo_items_shop_in_ap_helper_on") then
        return AccessibilityLevel.Normal
    else
        local veilstone = Tracker:FindObjectForCode("@veilstone_city").AccessibilityLevel
        return math.max(veilstone, AccessibilityLevel.SequenceBreak)
    end    
end

--== Evolution Logic ==--

function levelup()
    return AccessibilityLevel.Normal
    -- yep. any level is always in logic.
end


function evolve_item(value)
    if not has(value) or not has("bag") then return end
    
    if has("evomethod_item_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_trade_item(value)
    if not has(value) or not has("linkingcord") or not has("bag") then return end
    
    if has("evomethod_item_on") then
        return evo_item_shop()
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_area(area)
    local evo_area = Tracker:FindObjectForCode("@"..area).AccessibilityLevel
    if has("evomethod_geographical_on") then
        return evo_area
    else
        math.min(evo_area, AccessibilityLevel.SequenceBreak)
    end
end

function evolve_mildly(which)
    if has("evomethod_mildly_on") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_highly(which)
    if has("evomethod_highly_on") then
        local veilstone = Tracker:FindObjectForCode("@veilstone_city").AccessibilityLevel
        if which == tyrogue then
            return math.max(veilstone, AccessibilityLevel.SequenceBreak)
        elseif which == beauty then
            local hearthome = Tracker:FindObjectForCode("@hearthome_city").AccessibilityLevel
            return math.min(veilstone, hearthome, has_level("poffincase"))
        end
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function evolve_friendship()
    return AccessibilityLevel.Normal
end
