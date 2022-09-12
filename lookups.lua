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

local items = {
    "Torch",              -- 0x1
    "Fairy Water",        -- 0x2
    "Wings",              -- 0x3
    "Dragon's Scale",     -- 0x4
    "Fairy Flute",        -- 0x5
    "Fighter's Ring",     -- 0x6
    "Erdrick's Token",    -- 0x7
    "Gwaelin's Love",     -- 0x8
    "Cursed Belt",        -- 0x9
    "Silver Harp",        -- 0xA
    "Death Necklace",     -- 0xB
    "Stones of Sunlight", -- 0xC
    "Staff of Rain",      -- 0xD
    "Rainbow Drop",       -- 0xE
    "Herb",               -- 0xF
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
    items = items,
    weapons = weapons,
    armor = armor,
    shields = shields,
}
