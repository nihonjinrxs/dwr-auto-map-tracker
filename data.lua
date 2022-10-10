local parsers = require "parsers"

local Data = {
    map = {
        id = nil,
        explored = {},
        data = {},
    },
    game = {
        rng_state = 0,
    },
    player = {
        position = {x = 0, y = 0},
        alt = {h = 0, v = 0},
    },
    hero = {
        stats = {
            xp = 0,
            level = 0,
            hp = 0,
            hpMax = 0,
            mp = 0,
            mpMax = 0,
            strength = 0,
            agility = 0,
            attack = 0,
            defense = 0,
        },
        gold = 0,
        equipment = {
            weapon = nil,
            armor = nil,
            shield = nil,
        },
        quest_progress = {
            left_throne_room = false,
            green_dragon_trap = false,
            golem_trap = false,
            princess_rescued = false,
            princess_returned = false,
            rainbow_bridge = false,
            charlock_stairs = false,
        },
        quest_items = {
            dragon_scale = false,
            fighter_ring = false,
            death_necklace = false,
            gwaelin_love = false,
            erdrick_token = false,
            silver_harp = false,
            fairy_flute = false,
            stones_of_sunlight = false,
            staff_of_rain = false,
            rainbow_drop = false,
            ball_of_light = false,
        },
        equipped = {
            dragon_scale = false,
            fighter_ring = false,
            death_necklace = false,
            cursed_belt = false,
        },
        items = {
            magic_key = 0,
            herb = 0,
            torch = 0,
            wings = 0,
            fairy_water = 0,
            cursed_belt = 0,
        },
        spells = {
            HEAL = false,
            HURT = false,
            SLEEP = false,
            RADIANT = false,
            STOPSPELL = false,
            OUTSIDE = false,
            RETURN = false,
            REPEL = false,
            HEALMORE = false,
            HURTMORE = false,
        },
    },
}

local function updateMapData(TrackedValues, AllData)
    local map = require('map')
    return {
        id = parsers.parseMap(TrackedValues.map.memValue) or nil,
        explored = map.updateMapExplored(AllData),
        data = map.data,
    }
end

local function updateGameData(TrackedValues)
    return {
        rng_state = TrackedValues.rngState.memValue or 0,
    }
end

local function updatePlayerData(TrackedValues)
    return parsers.parsePlayerData(TrackedValues)
end

local function updateHeroStats(TrackedValues)
    return parsers.parseStats(TrackedValues)
end

local function updateHeroEquipment(TrackedValues)
    return parsers.parseEquipment(TrackedValues.equipment.memValue)
end

local function updateHeroQuestProgress(TrackedValues)
    return parsers.parseQuestProgress(
        TrackedValues.quest.memvValue,
        TrackedValues.quest2.memValue,
        TrackedValues.quest3.memValue
    )
end

local function updateHeroQuestItems(TrackedValues)
    return parsers.parseQuestItems(
        TrackedValues.items.memValue
    )
end

local function updateHeroEquipped(TrackedValues)
    return parsers.parseEquipped(
        TrackedValues.quest.memValue
    )
end

local function updateHeroItems(TrackedValues)
    return parsers.parseItems(
        TrackedValues.items.memValue,
        TrackedValues.keys.memValue,
        TrackedValues.herbs.memValue
    )
end

local function updateHeroSpells(TrackedValues)
    return parsers.parseSpells(
        TrackedValues.spells.memValue,
        TrackedValues.quest.memValue
    )
end

local function updateHeroData(TrackedValues)
    return {
        stats = updateHeroStats(TrackedValues),
        gold = TrackedValues.gold.memValue or 0,
        equipment = updateHeroEquipment(TrackedValues),
        quest_progress = updateHeroQuestProgress(TrackedValues),
        quest_items = updateHeroQuestItems(TrackedValues),
        equipped = updateHeroEquipped(TrackedValues),
        items = updateHeroItems(TrackedValues),
        spells = updateHeroSpells(TrackedValues),
    }
end

local function updateData(TrackedValues, AllData)
    AllData.map = updateMapData(TrackedValues, AllData)
    AllData.game = updateGameData(TrackedValues)
    AllData.player = updatePlayerData(TrackedValues)
    AllData.hero = updateHeroData(TrackedValues)
end

return {
    Data = Data,
    updateData = updateData,
}
