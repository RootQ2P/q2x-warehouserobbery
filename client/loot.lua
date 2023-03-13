local QBCore = exports['qb-core']:GetCoreObject()
local hasJob = false
local cooldown = false
local Loot1 = false 
local Loot2 = false 
local Loot3 = false 

RegisterNetEvent('q2x:client:loot1',function ()
    if not Loot1 then 
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot1', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards1')
end
end)


RegisterNetEvent('q2x:client:loot2',function ()
    if not Loot2 then 
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot2', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards2')
end
end)


RegisterNetEvent('q2x:client:loot3',function ()
    if not Loot2 then 
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot3', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards3')
end
end)



-- dep
RegisterNetEvent('q2x:client:setloot1', function(status)
    Loot1 = status
end)
RegisterNetEvent('q2x:client:setloot2', function(status)
    Loot2 = status
end)
RegisterNetEvent('q2x:client:setloot3', function(status)
    Loot3 = status
end)