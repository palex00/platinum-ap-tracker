function day_encounters()
    if has("daytime") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function night_encounters()
    if has("nighttime") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function radar_encounters()
    if has("radar") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function firered_encounters()
    if has("fireredcartridge") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function leafgreen_encounters()
    if has("leafgreencartridge") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function ruby_encounters()
    if has("rubycartridge") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function sapphire_encounters()
    if has("sapphirecartridge") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function emerald_encounters()
    if has("emeraldcartridge") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function swarms_encounters()
    if has("ACCESS TO SWARMS") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function surf_encounters()
    if has("hm03surf") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function roamers_encounters()
    if has("markingmap") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function odd_keystone_encounters()
    if has("oddkeystone") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function feebas_fishing_encounters()
    if has("pokesonar") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function trophy_garden_encounters()
    if has("ACCESS TO PKEMON MANSION") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function regular_honey_tree_encounters()
    if has("ACCESS TO HONEY") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function munchlax_honey_tree_encounters()
    if has("treecamera") and has ("ACCESS TO HONEY") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function great_marsh_observatory_encounters()
    if has("ACCESS TO GREAT MARSH") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function great_marsh_observatory_national_dex_encounters()
    if has("ACCESS TO GREAT MARSH") and has("national_dex") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function oldrod_encounters()
    if has("oldrod") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function goodrod_encounters()
    if has("goodrod") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end

function superrod_encounters()
    if has("superrod") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end