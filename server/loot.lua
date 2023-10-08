local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('q2x:server:rewards', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    print("50")
    local random = math.random(100) 
    local random2 = math.random(20) 
    local item

    if random >= 1 and random <= 9 then 
        item = 'rolex'
    elseif random >= 10 and random <= 19 then 
        item = 'diamond_ring'
    elseif random >= 20 and random <= 29 then 
        item = 'goldchain'
    elseif random >= 30 and random <= 39 then 
        item = 'phone'
    elseif random >= 40 and random <= 49 then 
        item = 'weapon_advancedrifle'
    elseif random >= 50 and random <= 59 then 
        item = 'weapon_appistol'
    elseif random >= 60 and random <= 69 then 
        item = 'weapon_assaultshotgun'
    elseif random >= 70 and random <= 79 then 
        item = 'weapon_combatmg'
    elseif random >= 80 and random <= 89 then 
        item = 'weapon_combatpdw'
    elseif random >= 90 and random <= 92 then 
        item = 'coke_small_brick'
    elseif random >= 93 and random <= 94 then 
        item = 'weapon_combatpistol'
    elseif random >= 95 and random <= 96 then 
        item = 'weapon_heavypistol'
    elseif random >= 97 and random <= 98 then 
        item = 'weapon_marksmanpistol'
    elseif random >= 99 and random <= 100 then 
        item = 'weapon_pistol'
    end

    if item then
        if exports['qb-inventory']:AddItem(Player.PlayerData.source, item, random2, false) then
            TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[item], 'add', random2)
        else
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'Your inventory is full already..', 'error', 2500)
        end
    end
end)
