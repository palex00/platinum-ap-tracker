function cut()
    if not has("bag") and not has("hmreader") then
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
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_surf")
    or (has("hm03surf") and has("fenbadge"))
end

function strength()
    if not has("bag") and not has("hmreader") then
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
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_rocksmash")
    or (has("hm06rocksmash") and has("coalbadge"))
end

function up_waterfall()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_waterfall")
    or (has("hm07waterfall") and has("beaconbadge"))
end

function down_waterfall()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("hm07waterfall")
end

function rock_climb()
    if not has("bag") and not has("hmreader") then
        return false
    end
    return has("free_rockclimb")
    or (has("hm08rockclimb") and has("iciclebadge"))
end

function hidden()
    if has("opt_dowsing_off") or (has("dowsingmachine") and has("poketch")) then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function badges_req(count)
    return (badges() >= tonumber(count))
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
        return math.min(has_level("event_clear_distortion"), Tracker:FindObjectForCode("@distortion_world").AccessibilityLevel)
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
        return has("unownfile", 26)
    elseif has("opt_unown_vanilla") then
        return true
    end
end

function pastoria_barriers()
    return has("opt_pastoria_barriers_off") or surf()
end

function boat_canalave_pastoria()
    if has("opt_boat_canalave_pastoria_off") then
        return false
    elseif has("opt_boat_canalave_pastoria_on") then
        return true
    elseif has("opt_boat_canalave_pastoria_ssticket") then
        return has("ssticket")
    end
end

function boat_canalave_snowpoint()
    if has("opt_boat_canalave_snowpoint_off") then
        return false
    elseif has("opt_boat_canalave_snowpoint_on") then
        return true
    elseif has("opt_boat_canalave_snowpoint_ssticket") then
        return has("ssticket")
    end
end

function boat_pastoria_snowpoint()
    if has("opt_boat_pastoria_snowpoint_off") then
        return false
    elseif has("opt_boat_pastoria_snowpoint_on") then
        return true
    elseif has("opt_boat_pastoria_snowpoint_ssticket") then
        return has("ssticket")
    end
end

function route_207_barricade_up()
    if has("opt_route_207_barricade_none") then
        return true
    elseif has("opt_route_207_barricade_bicycle_slope") then
        return has("bicycle")
    elseif has("opt_route_207_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_207_barricade_impassable") then
        return false
    elseif has("opt_route_207_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        return has("bicycle") and cut()
    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        return has("bicycle") and rock_smash()
    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        return has("bicycle") and strength()
    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        return has("bicycle") and has("secretpotion")
    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    end
end

function route_207_barricade_down()
    if has("opt_route_207_barricade_none") then
        return true
    elseif has("opt_route_207_barricade_bicycle_slope") then
        return true
    elseif has("opt_route_207_barricade_rock_climb") then
        return rock_climb()
    elseif has("opt_route_207_barricade_impassable") then
        return false
    elseif has("opt_route_207_barricade_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_bicycle_slope_and_cut_tree") then
        return cut()
    elseif has("opt_route_207_barricade_bicycle_slope_and_rock_smash") then
        return rock_smash()
    elseif has("opt_route_207_barricade_bicycle_slope_and_strength_boulder") then
        return strength()
    elseif has("opt_route_207_barricade_bicycle_slope_and_psyduck") then
        return has("secretpotion")
    elseif has("opt_route_207_barricade_rock_climb_and_cut_tree") then
        return rock_climb() and cut()
    elseif has("opt_route_207_barricade_rock_climb_and_rock_smash") then
        return rock_climb() and rock_smash()
    elseif has("opt_route_207_barricade_rock_climb_and_strength_boulder") then
        return rock_climb() and strength()
    elseif has("opt_route_207_barricade_rock_climb_and_psyduck") then
        return rock_climb() and has("secretpotion")
    end
end

function marsh_pass()
    return has("opt_marsh_pass_off") or has("marshpass")
end

function flash()
    if has("opt_hm_visibility_off") or has("tm70flash") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function roamer_respawn()
    return AccessibilityLevel.Normal
end

function any_rod()
    return has("oldrod") or has("goodrod") or has("superrod")
end

function see_regional_mons()
    goal = Tracker:FindObjectForCode("regional_dex_goal").AcquiredCount
    seen = Tracker:FindObjectForCode("num_seen_reg").AcquiredCount
    if goal <= seen then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.Inspect
    end
end

function amity_square()
    local dexIds = {
        25,  -- Pikachu
        35,  -- Clefairy
        54,  -- Psyduck
        387, -- Turtwig
        388, -- Grotle
        389, -- Torterra
        390, -- Chimchar
        391, -- Monferno
        392, -- Infernape
        393, -- Piplup
        394, -- Prinplup
        395, -- Empoleon
        417, -- Pachirisu
        425, -- Drifloon
        427, -- Buneary
        440  -- Happiny
    }

    for _, id in ipairs(dexIds) do
        if has("caught_" .. id) then
            return AccessibilityLevel.Normal
        end
    end

    if has("national_dex") then
        if has("caught_39") or has("caught_255") or has("caught_") or has("caught_") then
            return AccessibilityLevel.Normal
        end
    end

    return AccessibilityLevel.Inspect
end

function has_mon(dexnumber)
    if has("caught_"..dexnumber) then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.Inspect
    end
end

function day()
    return has("poketch") and has("daytime")
end

function night()
    return has("poketch") and has("nighttime")
end
