local QBCore = exports['qb-core']:GetCoreObject()
local entities = {}

RegisterNetEvent('q2x:server:ResetHeist', function()
    TriggerEvent('q2x:server:setloot1', false)
end)

RegisterNetEvent('q2x:server:setloot', function(status)
    if status ~= nil then
        Loot1 = status
        TriggerClientEvent('q2x:client:setloot', -1, Loot1)
    else 
        TriggerClientEvent('q2x:client:setloot', -1, Loot1)
    end
end)

RegisterNetEvent('q2x:server:ThermitePtfx', function()
    TriggerClientEvent('q2x:client:ThermitePtfx', -1)
end)

RegisterNetEvent('q2x:server:removeitem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(Config.bomb, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.bomb], "remove")
end)

RegisterNetEvent('q2x-warehouse:server:setCrateStatus', function(crate)
    box.crate[crate].robbed = true
    box.crate[crate].time = Config.resetTime
    TriggerClientEvent('q2x-warehouse:client:setCrateStatus', -1, crate, box.crate[crate])
end)
