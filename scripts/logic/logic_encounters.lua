function land_encounters()
    return AccessibilityLevel.Normal
end

function day_encounters()
    if has("daytime") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function night_encounters()
    if has("nighttime") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function radar_encounters()
    if has("radar") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function firered_encounters()
    if has("fireredcartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function leafgreen_encounters()
    if has("leafgreencartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function ruby_encounters()
    if has("rubycartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function sapphire_encounters()
    if has("sapphirecartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function emerald_encounters()
    if has("emeraldcartridge") and has("poketch") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function swarm_encounters()
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("opt_start_with_swarms_on") and has("poffincase") and has("bag") then
        return AccessibilityLevel.Normal
    elseif has("poffincase") and has("bag") and has ("national_dex") then
        return cynthia
    else
        return AccessibilityLevel.None
    end
end

function surf_encounters()
    return surf
end

function roamer_encounters()
    local cynthia = Tracker:FindObjectForCode("@pokemon_league_hall_of_fame").AccessibilityLevel
    if has("opt_can_reset_legendaries_in_ap_helper_on") and has("poketch") and has("markingmap") then
        return AccessibilityLevel.Normal
    elseif has("poketch") and has("markingmap") then
        return cynthia
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function feebas_fishing_encounters()
    if has("pokesonar")  and has("poketch") and has("dowsingmachine") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function regular_honey_tree_encounters()
    if has("event_floaroma_meadow") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function munchlax_honey_tree_encounters()
    if has("event_floaroma_meadow") and has ("treecamera") and has("poketch") has ("dowsingmachine") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function great_marsh_observatory_encounters()
    return AccessibilityLevel.Normal
end

function great_marsh_observatory_national_dex_encounters()
    if has("national_dex") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function oldrod_encounters()
    if has("oldrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function goodrod_encounters()
    if has("goodrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function superrod_encounters()
    if has("superrod") and has("bag") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end