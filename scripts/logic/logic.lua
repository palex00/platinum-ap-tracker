function cut()
    return has("free_cut")
    or (has("hm01cut") and has("forestbadge"))
end

function fly()
    return has("free_fly")
    or (has("hm02fly") and has("cobblebadge"))
end

function surf()
    return has("free_surf")
    or (has("hm03surf") and has("fenbadge"))
end

function strength()
    return has("free_strength")
    or (has("hm04strength") and has("minebadge"))
end

function defog()
    return has("free_defog")
    or (has("hm05defog") and has("relicbadge"))
end

function rock_smash()
    return has("free_rocksmash")
    or (has("hm06rocksmash") and has("coalbadge"))
end

function waterfall()
    return has("free_waterfall")
    or (has("hm07waterfall") and has("beaconbadge"))
end

function rock_climb()
    return has("free_rockclimb")
    or (has("hm08rockclimb") and has("iciclebadge"))
end

function hidden()
    return AccessibilityLevel.Normal
end

function regional_monsTODO()
    print("Remember to implement this")
    return true
end

function pokedex()
    print("Remember to implement this")
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
    print("Remember to implement this")
    return true
end

function early_sunyshore()
    print("Remember to implement this")
    return true
    -- has early sunyshore or event distortion world
end

function north_sinnoh_fly()
    print("Remember to implement this")
    return true
    -- has north sinnoh fly on and fly or just true
end

function soft_defog()
    print("Remember to implement this")
    return true
    -- has defog or defog-not-required
end

function unowns()
    print("Remember to implement this")
    return true
    -- either 26 Unown Files if they're items or access to Solaceon Ruins if Unowns are vanilla
end

function mon_geodude()
    -- Once Encounter Randomisation is a thing, this needs to change.
    -- Now just gives accessibility of the earliest area you can catch Geodude
    return Tracker:FindObjectForCode("@oreburgh_gate_1f").AccessibilityLevel
end

function pastoria_barriers()
    print("Remember to implement this")
    return true
    -- either pastoria barriers off or surf
end

function mons()
    print("Remember to implement this")
    return true
end

function regional_mons()
    print("Remember to implement this")
    return true
end

function marsh_pass()
    print("Remember to implement this")
    return true
end

function flash()
    return AccessibilityLevel.Normal
end