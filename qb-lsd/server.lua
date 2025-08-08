local QBCore = exports['qb-core']:GetCoreObject()

-- Check if player has items before starting craft
QBCore.Functions.CreateCallback("acidjob:checkItems", function(source, cb, craftType)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(false) return end

    if craftType == "acid_base" then
        local acid = Player.Functions.GetItemByName(Config.Items.acid_di)
        local ergot = Player.Functions.GetItemByName(Config.Items.ergot)
        if acid and acid.amount >= 10 and ergot and ergot.amount >= 5 then
            cb(true)
        else
            cb(false)
        end
    elseif craftType == "lsd" then
        local base = Player.Functions.GetItemByName(Config.Items.acid_base)
        local bag = Player.Functions.GetItemByName(Config.Items.empty_weed_bag)
        if base and base.amount >= 1 and bag and bag.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

-- Pickup Acid
RegisterNetEvent("acidjob:pickupAcid", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local amount = math.random(1, 3)
        Player.Functions.AddItem(Config.Items.acid_di, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.acid_di], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You collected " .. amount .. " Acid (Diethylamide)", "success")
    end
end)

-- Craft Acid Base
RegisterNetEvent("acidjob:craftAcidBase", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(Config.Items.acid_di, 3) and Player.Functions.RemoveItem(Config.Items.ergot, 2) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.acid_di], 'remove')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.ergot], 'remove')
        Player.Functions.AddItem(Config.Items.acid_base, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.acid_base], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You Made Acid Base", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Missing ingredients!", "error")
    end
end)

-- Craft LSD
RegisterNetEvent("acidjob:craftLSD", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(Config.Items.acid_base, 1) and Player.Functions.RemoveItem(Config.Items.empty_weed_bag, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.acid_base], 'remove')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.empty_weed_bag], 'remove')
        Player.Functions.AddItem(Config.Items.lsd, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.lsd], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You Made LSD", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Missing ingredients!", "error")
    end
end)
