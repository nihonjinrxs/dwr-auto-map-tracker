local nonParseables = {
    "level", "xp", "strength", "agility", "ap", "dp", "gold", "keys",
}

local maps = {
    [0x00] = "None",
    [0x01] = "World Map",
    [0x02] = "Charlock Castle",
    [0x03] = "Hauksness",
    [0x04] = "Tantegel Castle",
    [0x05] = "Throne Room",
    [0x06] = "Dragonlord's Lair",
    [0x07] = "Kol",
    [0x08] = "Brecconary",
    [0x09] = "Garinham",
    [0x0A] = "Cantlin",
    [0x0B] = "Rimuldar",
    [0x0C] = "Sun Shrine",
    [0x0D] = "Rain Shrine",
    [0x0E] = "Magic Temple",
    [0x0F] = "Charlock B1",
    [0x10] = "Charlock B2",
    [0x11] = "Charlock B3",
    [0x12] = "Charlock B4",
    [0x13] = "Charlock B5",
    [0x14] = "Charlock B6",
    [0x15] = "Swamp Cave",
    [0x16] = "Mountain Cave B1",
    [0x17] = "Mountain Cave B2",
    [0x18] = "Garin's Grave B1",
    [0x19] = "Garin's Grave B2",
    [0x1A] = "Garin's Grave B3",
    [0x1B] = "Garin's Grave B4",
    [0x1C] = "Erdrick's Cave B1",
    [0x1D] = "Erdrick's Cave B2",
}

-- "BGCOLOR",     -- 0 = background color
-- "0 0 0",       -- 1 = black  = unknown
-- "196 196 196", -- 2 = grey   = mountain
-- "128 0 240",   -- 3 = purple = swamp
-- "240 188 60",  -- 4 = orange = hills
-- "252 228 160", -- 5 = yellow = desert
-- "76 220 72",   -- 6 = green  = grass
-- "32 56 236",   -- 7 = blue   = water
-- "216 40 0",    -- 8 = red    = point of interest
local overworldTiles = {
    [0x0] = "Grass",
    [0x1] = "Sand",
    [0x2] = "Hill",
    [0x3] = "Mountain",
    [0x4] = "Water",
    [0x5] = "Block",
    [0x6] = "Forest",
    [0x7] = "Swamp",
    [0x8] = "Town",
    [0x9] = "Cave",
    [0xA] = "Castle",
    [0xB] = "Bridge",
    [0xC] = "Stairs",
}

local overworldTilePixelValues = {
    ["Unknown"] = 1,  -- "0 0 0"       = black   = $0F
    ["Mountain"] = 2, -- "196 196 196" = grey    = $3D
    ["Swamp"] = 3,    -- "128 0 240"   = purple  = $13
    ["Hill"] = 4,     -- "240 188 60"  = orange  = $28
    ["Sand"] = 5,     -- "252 228 160" = yellow  = $38
    ["Grass"] = 6,    -- "76 220 72"   = green   = $2A
    ["Water"] = 7,    -- "32 56 236"   = blue    = $12
    ["Forest"] = 8,   -- "0 144 56"    = dk grn  = $1B
    ["Town"] = 9,     -- "216 40 0"    = red     = $16
    ["Cave"] = 9,     -- "216 40 0"    = red     = $16
    ["Castle"] = 9,   -- "216 40 0"    = red     = $16
    ["Stairs"] = 9,   -- "216 40 0"    = red     = $16
    ["Bridge"] = 10,  -- "252 252 252" = lt grey = $20
    ["Block"] = 10,   -- "252 252 252" = lt grey = $20
}

local overworldPixelColorMapping = {
    "0 0 0",       -- black   = $0F
    "196 196 196", -- grey    = $3D
    "128 0 240",   -- purple  = $13
    "240 188 60",  -- orange  = $28
    "252 228 160", -- yellow  = $38
    "76 220 72",   -- green   = $2A
    "32 56 236",   -- blue    = $12
    "0 144 56",    -- dk grn  = $1B
    "216 40 0",    -- red     = $16
    "252 252 252", -- lt grey = $20
}

local items = {
    "torch",              -- 0x1
    "fairy_water",        -- 0x2
    "wings",              -- 0x3
    "dragon_scale",       -- 0x4
    "fairy_flute",        -- 0x5
    "fighter_ring",       -- 0x6
    "erdrick_token",      -- 0x7
    "gwaelin_love",       -- 0x8
    "cursed_belt",        -- 0x9
    "silver_harp",        -- 0xA
    "death_necklace",     -- 0xB
    "stones_of_sunlight", -- 0xC
    "staff_of_rain",      -- 0xD
    "rainbow_drop",       -- 0xE
    "herb_glitched",      -- 0xF
}

local levelXP = {
    5,      --  2
    17,     --  3
    35,     --  4
    82,     --  5
    165,    --  6
    337,    --  7
    600,    --  8
    975,    --  9
    1500,   -- 10
    2175,   -- 11
    3000,   -- 12
    4125,   -- 13
    5625,   -- 14
    7500,   -- 15
    9750,   -- 16
    12000,  -- 17
    14250,  -- 18
    16500,  -- 19
    19500,  -- 20
    22500,  -- 21
    25500,  -- 22
    28500,  -- 23
    31500,  -- 24
    34500,  -- 25
    37500,  -- 26
    40500,  -- 27
    43500,  -- 28
    46500,  -- 29
    49151   -- 30
}

local weapons = {
    [0x20] = "Bamboo Pole",
    [0x40] = "Club",
    [0x60] = "Copper Sword",
    [0x80] = "Hand Axe",
    [0xA0] = "Broad Sword",
    [0xC0] = "Flame Sword",
    [0xE0] = "Erdrick's Sword",
}

local armor  = {
    [0x04] = "Clothes",
    [0x08] = "Leather Armor",
    [0x0C] = "Chain Mail",
    [0x10] = "Half Plate Armor",
    [0x14] = "Full Plate Armor",
    [0x18] = "Magic Armor",
    [0x1C] = "Erdrick's Armor",
}

local shields = {
    [0x01] = "Small Shield",
    [0x02] = "Large Shield",
    [0x03] = "Silver Shield",
}

return {
    nonParseables = nonParseables,
    maps = maps,
    overworldTiles = overworldTiles,
    overworldTilePixelValues = overworldTilePixelValues,
    overworldPixelColorMapping = overworldPixelColorMapping,
    levelXP = levelXP,
    items = items,
    weapons = weapons,
    armor = armor,
    shields = shields,
}
