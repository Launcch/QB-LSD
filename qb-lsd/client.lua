local QBCore = exports['qb-core']:GetCoreObject()

-- Acid Pickup Targets
CreateThread(function()
    for _, loc in ipairs(Config.AcidPickupLocations) do
        exports['qb-target']:AddBoxZone("acid_pickup_" .. _, loc, 1.5, 1.5, {
            name = "acid_pickup_" .. _,
            heading = 0,
            debugPoly = false,
            minZ = loc.z - 1,
            maxZ = loc.z + 1
        }, {
            options = {
                {
                    label = "Collect Acid (Diethylamide)",
                    icon = "fas fa-vial",
                    action = function()
                        QBCore.Functions.Progressbar("pickup_acid", "Collecting Acid...", 10000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }, {
                            animDict = Config.PickupAnimDict,
                            anim = Config.PickupAnimName,
                            flags = 49
                        }, {}, {}, function() -- Done
                            TriggerServerEvent("acidjob:pickupAcid")
                        end)
                    end
                }
            },
            distance = 2.5
        })
    end
end)

-- Crafting Stage 1 Menu
CreateThread(function()
    exports['qb-target']:AddBoxZone("craft_acid_base", Config.CraftingStage1, 1.5, 1.5, {
        name = "craft_acid_base",
        heading = 0,
        debugPoly = false,
        minZ = Config.CraftingStage1.z - 1,
        maxZ = Config.CraftingStage1.z + 1
    }, {
        options = {
            {
                label = "Make Acid Base",
                icon = "fas fa-flask",
                action = function()
                    local menu = {
                        {
                            header = "Craft Acid Base",
                            txt = "Requires: 10x Acid (Diethylamide), 5x Ergot Plant",
                            params = {
                                event = "acidjob:attemptCraft",
                                args = { craftType = "acid_base" }
                            }
                        },
                        {
                            header = "Close",
                            params = { event = "qb-menu:client:closeMenu" }
                        }
                    }
                    exports['qb-menu']:openMenu(menu)
                end
            }
        },
        distance = 2.5
    })
end)

-- Crafting Stage 2 Menu
CreateThread(function()
    exports['qb-target']:AddBoxZone("craft_lsd", Config.CraftingStage2, 1.5, 1.5, {
        name = "craft_lsd",
        heading = 0,
        debugPoly = false,
        minZ = Config.CraftingStage2.z - 1,
        maxZ = Config.CraftingStage2.z + 1
    }, {
        options = {
            {
                label = "Make LSD",
                icon = "fas fa-capsules",
                action = function()
                    local menu = {
                        {
                            header = "Craft LSD",
                            txt = "Requires: 1x Acid Base, 1x Hydrochloric Acid",
                            params = {
                                event = "acidjob:attemptCraft",
                                args = { craftType = "lsd" }
                            }
                        },
                        {
                            header = "Close",
                            params = { event = "qb-menu:client:closeMenu" }
                        }
                    }
                    exports['qb-menu']:openMenu(menu)
                end
            }
        },
        distance = 2.5
    })
end)

-- Event triggered from qb-menu
RegisterNetEvent("acidjob:attemptCraft", function(data)
    QBCore.Functions.TriggerCallback("acidjob:checkItems", function(hasItems)
        if hasItems then
            if data.craftType == "acid_base" then
                QBCore.Functions.Progressbar("craft_acid_base", "Mixing Acid Base...", 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = Config.CraftingAnimDict,
                    anim = Config.CraftingAnimName,
                    flags = 49
                }, {}, {}, function()
                    TriggerServerEvent("acidjob:craftAcidBase")
                end)
            elseif data.craftType == "lsd" then
                QBCore.Functions.Progressbar("craft_lsd", "Processing LSD...", 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = Config.CraftingAnimDict,
                    anim = Config.CraftingAnimName,
                    flags = 49
                }, {}, {}, function()
                    TriggerServerEvent("acidjob:craftLSD")
                end)
            end
        else
            QBCore.Functions.Notify("You don’t have the required ingredients!", "error")
        end
    end, data.craftType)
end)
