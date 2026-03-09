function night_encounters()
    if has("night") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.None
    end
end