INLOGIC_SLOT_COUNT = 20
INLOGIC_COLUMN_SIZE = 10
INLOGIC_ITEMS = {}

INLOGIC_DIRTY = true

local BLANK_ICON = "images/pokemon/blank.png"
local BADGE_INDENT = string.rep(" ", 12)
local empty_message = nil

local EMPTY_MESSAGES = {
    {"palex00 is proud of you!"},
    {"You proved Darwin right!"},
    {"I've come to evolve and chew gum.", "And I'm all out of evolve."},
    {"Your ad here"},
}

InLogicItem = CustomItem:extend()

function InLogicItem:init(index)
    self.code = "inlogic_" .. index
    self:createItem("In Logic " .. index, {self.code})
    self:show(nil)
end

function InLogicItem:canProvideCode(code)
    return code == self.code
end

function InLogicItem:providesCode(code)
    return 0
end

function InLogicItem:show(entry)
    local inst = self.ItemInstance
    local icon = BLANK_ICON
    local name = ""
    local badge = ""
    if entry and entry.id then
        icon = "images/pokemon/" .. entry.id .. ".png"
        name = "Evolve " .. POKEMON_NAMES[entry.id]
        badge = BADGE_INDENT .. name
    elseif entry and entry.text then
        badge = entry.text
    end
    if self.shown == icon .. badge then
        return
    end
    self.shown = icon .. badge
    inst.Icon = ImageReference:FromPackRelativePath(icon)
    inst.Name = name
    inst.BadgeText = badge
    inst.BadgeTextColor = "#abcdef"
    inst:SetOverlayBackground("")
    inst:SetOverlayFontSize(11)
    inst:SetOverlayAlign("left")
end

local function owned(id)
    return has("caught_" .. id)
end

local function green(level)
    return level == AccessibilityLevel.Normal
end

local function is_dexsanity_check(id)
    return has("dexsanity_visibility_" .. id) and not owned(id) and not has("dexsanity_sent_" .. id)
end

local function is_new(id)
    return not owned(id)
end

local function evolve_targets(id, targets)
    for _, evo in ipairs(EVOLUTION_DATA[id] or {}) do
        if green(evolution_access(evo)) then
            table.insert(targets, evo.into)
            if not owned(evo.into) then
                evolve_targets(evo.into, targets)
            end
        end
    end
    return targets
end

local function any_target(targets, test)
    for _, target in ipairs(targets) do
        if test(target) then
            return true
        end
    end
    return false
end

local function fill(first, count, entries)
    for i = 1, count do
        INLOGIC_ITEMS[first + i - 1]:show(entries[i])
    end
end

function inlogic_split()
    return has("opt_dexsanity")
end

function syncInLogic()
    local split = inlogic_split()

    local dexsanity, new = {}, {}
    local any_owned = false
    for id = 1, 493 do
        if owned(id) then
            any_owned = true
            local evolves = evolve_targets(id, {})
            if split and any_target(evolves, is_dexsanity_check) then
                table.insert(dexsanity, {id = id})
            end
            if any_target(evolves, is_new) then
                table.insert(new, {id = id})
            end
        end
    end

    if #new == 0 and any_owned then
        empty_message = empty_message or EMPTY_MESSAGES[math.random(#EMPTY_MESSAGES)]
        for _, line in ipairs(empty_message) do
            table.insert(new, {text = line})
        end
    else
        empty_message = nil
    end

    if split then
        fill(1, INLOGIC_COLUMN_SIZE, dexsanity)
        fill(INLOGIC_COLUMN_SIZE + 1, INLOGIC_SLOT_COUNT - INLOGIC_COLUMN_SIZE, new)
    else
        fill(1, INLOGIC_SLOT_COUNT, new)
    end
end

for i = 1, INLOGIC_SLOT_COUNT do
    INLOGIC_ITEMS[i] = InLogicItem(i)
end
