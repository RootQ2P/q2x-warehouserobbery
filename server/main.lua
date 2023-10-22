local QBCore = exports['qb-core']:GetCoreObject()

local Loot1 = false 
local Loot2 = false 
local Loot3 = false 


RegisterNetEvent('q2x:server:ResetHeist', function()
    TriggerEvent('q2x:server:setloot1', false)
    TriggerEvent('q2x:server:setloot2', false)
    TriggerEvent('q2x:server:setloot3', false)
    TriggerEvent('q2x:server:closedoor', Config.DoorId)
    TriggerEvent('q2x:server:closedoor', Config.DoorId2)
    TriggerEvent('q2x:server:closedoor', Config.DoorId3)
end)

RegisterNetEvent('q2x:server:setloot1', function(status)
    if status ~= nil then
        Loot1 = status
        TriggerClientEvent('q2x:client:setloot1', -1, Loot1)
    else 
        TriggerClientEvent('q2x:client:setloot1', -1, Loot1)
    end
end)

RegisterNetEvent('q2x:server:setloot2', function(status)
    if status ~= nil then
        Loot2 = status
        TriggerClientEvent('q2x:client:setloot2', -1, Loot2)
    else 
        TriggerClientEvent('q2x:client:setloot2', -1, Loot2)
    end
end)

RegisterNetEvent('q2x:server:setloot3', function(status)
    if status ~= nil then
        Loot3 = status
        TriggerClientEvent('q2x:client:setloot3', -1, Loot3)
    else 
        TriggerClientEvent('q2x:client:setloot3', -1, Loot3)
    end
end)



-- open a door
RegisterNetEvent('q2x:server:closedoor', function(doorid)
    local src = source
    TriggerClientEvent('qb-doorlock:client:setState', -1, src, doorid, true, false, false, false)
end)

RegisterNetEvent('q2x:server:ThermitePtfx', function()
    TriggerClientEvent('q2x:client:ThermitePtfx', -1)
end)

-- test
local peds = { 
    `mp_m_securoguard_01`,
    `s_m_m_security_01`,
    `s_m_m_highsec_01`,
    `s_m_m_highsec_02`,
    `s_m_m_marine_01`,
    `s_m_m_prisguard_01`,
    `s_m_m_strpreach_01`,
    `s_m_y_armymech_01`,
}

local getRandomNPC = function()
    return peds[math.random(#peds)]
end

QBCore.Functions.CreateCallback('q2x:server:SpawnNPC', function(source, cb, loc)
    local netIds = {}
    local netId
    local npc
    for i=1, #Config.Shooters['whouse'].locations[loc].peds, 1 do
        npc = CreatePed(30, getRandomNPC(), Config.Shooters['whouse'].locations[loc].peds[i], true, false)
        while not DoesEntityExist(npc) do Wait(10) end
        netId = NetworkGetNetworkIdFromEntity(npc)
        netIds[#netIds+1] = netId
    end
    cb(netIds)
end)

RegisterNetEvent('q2x:server:removeitem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.RemoveItem(Config.bomb, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.bomb], "remove")
end)
