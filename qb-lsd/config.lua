Config = {}

-- Acid Pickup Locations
Config.AcidPickupLocations = {
    vector3(-569.9, -1708.89, 18.9),
    vector3(-521.33, -2256.2, 6.82),
    vector3(269.94, -2973.34, 4.93)
}

-- Crafting Locations
Config.CraftingStage1 = vector3(2436.02, 4965.47, 42.35) -- Acid Base Craft
Config.CraftingStage2 = vector3(2431.63, 4971.13, 42.35) -- LSD Craft

-- Items
Config.Items = {
    acid_di = "acid_di",
    ergot = "ergot",
    acid_base = "acid_base",
    empty_weed_bag = "hydrochloric_acid",
    lsd = "lsd"
}

-- Animation dictionary & name for crafting
Config.CraftingAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
Config.CraftingAnimName = "fullcut_cycle_v7_cokecutter"

Config.PickupAnimDict = "anim@gangops@morgue@table@"
Config.PickupAnimName = "player_search"