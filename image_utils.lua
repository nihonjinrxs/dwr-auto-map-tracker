require 'auxlib'

local function getWeaponImage(weaponName)
    local weaponsImages = {
        ["Bamboo Pole"] = "./resources/weapons/bamboo_pole_th.png",
        ["Club"] = "./resources/weapons/club_th.png",
        ["Copper Sword"] = "./resources/weapons/copper_sword_th.png",
        ["Hand Axe"] = "./resources/weapons/hand_axe_th.png",
        ["Broad Sword"] = "./resources/weapons/broad_sword_th.png",
        ["Flame Sword"] = "./resources/weapons/flame_sword_th.png",
        ["Erdrick's Sword"] = "./resources/weapons/erdricks_sword_th.png",
    }
    return weaponsImages[weaponName]
end

local function getArmorImage(armorName)
    local armorImages = {
        ["Clothes"] = "./resources/armor/clothes_th.png",
        ["Leather Armor"] = "./resources/armor/leather_armor_th.png",
        ["Chain Mail"] = "./resources/armor/chain_mail_th.png",
        ["Half Plate Armor"] = "./resources/armor/half_plate_th.png",
        ["Full Plate Armor"] = "./resources/armor/full_plate_th.png",
        ["Magic Armor"] = "./resources/armor/magic_armor_th.png",
        ["Erdrick's Armor"] = "./resources/armor/erdricks_armor_th.png",
    }
    return armorImages[armorName]
end

local function getShieldImage(shieldName)
    local shieldImages = {
        ["Small Shield"] = "./resources/shields/small_shield_th.png",
        ["Large Shield"] = "./resources/shields/large_shield_th.png",
        ["Silver Shield"] = "./resources/shields/silver_shield_th.png",
    }
    return shieldImages[shieldName]
end

return {
    getWeaponImage = getWeaponImage,
    getArmorImage = getArmorImage,
    getShieldImage = getShieldImage,
}
