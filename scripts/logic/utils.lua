ACCESS_NONE = AccessibilityLevel.None
ACCESS_PARTIAL = AccessibilityLevel.Partial
ACCESS_INSPECT = AccessibilityLevel.Inspect
ACCESS_SEQUENCEBREAK = AccessibilityLevel.SequenceBreak
ACCESS_NORMAL = AccessibilityLevel.Normal
ACCESS_CLEARED = AccessibilityLevel.Cleared

local bool_to_accesslvl = {
    [true] = ACCESS_NORMAL,
    [false] = ACCESS_NONE
}
      

function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

      
function a(result)
    if result then
        return ACCESS_NORMAL
    end
    return ACCESS_NONE
end

function all(...)
    local args = { ... }
    local min = ACCESS_NORMAL
    for _, v in ipairs(args) do
        if type(v) == "function" then
            v = v()
        elseif type(v) == "string" then
            v = has_level(v)
        end
        if type(v) == "boolean" then
            v = bool_to_accesslvl[v]
        end
        if v < min then
            if v == ACCESS_NONE then
                return ACCESS_NONE
            end
            min = v
        end
    end
    return min
end

function any(...)
    local args = { ... }
    local max = ACCESS_NONE
    for _, v in ipairs(args) do
        if type(v) == "function" then
            v = v()
        elseif type(v) == "string" then
            v = has_level(v)
        end
        if type(v) == "boolean" then
            v = bool_to_accesslvl[v]
            -- v = A(v)
        end
        if v > max then
            if v == ACCESS_NORMAL then
                return ACCESS_NORMAL
            end
            max = v
        end
    end
    return max
end

function has_level(item, amount, amountInLogic)
    local count = Tracker:ProviderCountForCode(item)

    -- print(item, count, amount, amountInLogic)
    if amountInLogic then
        if count >= amountInLogic then
            return ACCESS_NORMAL
        elseif count >= amount then
            return ACCESS_SEQUENCEBREAK
        end
        return ACCESS_NONE
    end
    if not amount then
        if count > 0 then
            return ACCESS_NORMAL
        end
        return ACCESS_NONE
    else
        if count >= amount then
            return ACCESS_SEQUENCEBREAK
        end
        return ACCESS_NONE
    end
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function debug()
    local count = 0

    for _, locationTable in pairs(LOCATION_MAPPING) do
        for _, locationCode in ipairs(locationTable) do
            local obj = Tracker:FindObjectForCode(locationCode)
            if obj and obj.AccessibilityLevel == 6 then
                count = count + 1
            end
        end
    end

    print(count)
end