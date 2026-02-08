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

function rockclimb()
    return has("free_rockclimb")
    or (has("hm08rockclimb") and has("iciclebadge"))
end

function hidden()
    return true
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