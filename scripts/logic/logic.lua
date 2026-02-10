function cut()
    if not has("bag") then
        return false
    end
    return has("free_cut")
    or (has("hm01cut") and has("forestbadge"))
end

function fly()
    if not has("bag") then
        return false
    end
    return has("free_fly")
    or (has("hm02fly") and has("cobblebadge"))
end

function surf()
    if not has("bag") then
        return false
    end
    return has("free_surf")
    or (has("hm03surf") and has("fenbadge"))
end

function strength()
    if not has("bag") then
        return false
    end
    return has("free_strength")
    or (has("hm04strength") and has("minebadge"))
end

function defog()
    if not has("bag") then
        return false
    end
    return has("free_defog")
    or (has("hm05defog") and has("relicbadge"))
end

function rock_smash()
    if not has("bag") then
        return false
    end
    return has("free_rocksmash")
    or (has("hm06rocksmash") and has("coalbadge"))
end

function waterfall()
    if not has("bag") then
        return false
    end
    return has("free_waterfall")
    or (has("hm07waterfall") and has("beaconbadge"))
end

function rock_climb()
    if not has("bag") then
        return false
    end
    return has("free_rockclimb")
    or (has("hm08rockclimb") and has("iciclebadge"))
end

function hidden()
    if has("opt_dowsing_off") or has("dowsingmachine") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function regional_monsTODO()
    -- Returns true for now, will change with PKMN Randomisation
    return true
end

function badges()
  return
  Tracker:ProviderCountForCode("coalbadge") +
  Tracker:ProviderCountForCode("forestbadge") +
  Tracker:ProviderCountForCode("cobblebadge") +
  Tracker:ProviderCountForCode("fenbadge") +
  Tracker:ProviderCountForCode("relicbadge") +
  Tracker:ProviderCountForCode("minebadge") +
  Tracker:ProviderCountForCode("iciclebadge") +
  Tracker:ProviderCountForCode("beaconbadge")
end

function poketch_req(badgecount)
    if badgecount ~= nil then 
        if badges() >= tonumber(badgecount) then
            -- dummy
        else
            return false
        end
    end
    return has("coupons", 3) and has("parcel")
end

function route203_pass()
    if has("opt_route_203_off") then
        return true
    else
        return poketch_req()
    end
end

function early_sunyshore()
    if has("opt_early_sunyshore_on") then
        return AccessibilityLevel.Normal
    else
        return math.max(has_level("event_clear_distortion") and Tracker:FindObjectForCode("@event_clear_distortion").AccessibilityLevel)
    end
end

function north_sinnoh_fly()
    if has("opt_north_sinnoh_fly_off") or fly() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function soft_defog()
    if has("opt_hm_visibility_off") or defog() then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function unowns()
    if has("opt_unown_none") then
        return true
    elseif has("opt_unown_item") then
        return has("unownfile", 28)
    elseif has("opt_unown_vanilla") then
        return true
    end
end

function mon_geodude()
    -- Once Encounter Randomisation is a thing, this needs to change.
    -- Now just gives accessibility of the earliest area you can catch Geodude
    return Tracker:FindObjectForCode("@oreburgh_gate_1f").AccessibilityLevel
end

function pastoria_barriers()
    return has("opt_pastoria_barriers_off") or surf()
end

function mons()
    -- Returns true for now, will change with PKMN Randomisation
    return true
end

function regional_mons()
    -- Returns true for now, will change with PKMN Randomisation
    return true
end

function marsh_pass()
    print(Tracker:FindObjectForCode("@pokemon_league").AccessibilityLevel)
    return has("opt_marsh_pass_off") or has("marshpass")
end

function flash()
    if has("opt_hm_visibility_off") or has("tm70flash") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end