local QBCore = exports['qb-core']:GetCoreObject()
local hasJob = false
local cooldown = false
local Loot1 = false 
local Loot2 = false 
local Loot3 = false 

-- Main
RegisterNetEvent('q2x:client:startCooldown',function ()
    local timer = Config.cooldown * 60000
    while timer > 0 do
    Wait(1000)
    print("test")
    timer = timer - 1000
        if timer == 0 then
        cooldown = false
        TriggerEvent('q2x:client:ResetHeist')
        end
    end
end)

-- Start
RegisterNetEvent('q2x:client:startJob',function ()
    if cooldown == false then
        hasJob = true
        QBCore.Functions.Notify("The location have been marked on your map", 'success', 5000)
            AddTextEntry('MYBLIP', 'Warehouse Robbery')
            local blip = AddBlipForCoord(939.94, -1476.03, 32.69)
            SetBlipSprite(blip,161)
            BeginTextCommandSetBlipName('MYBLIP')
            EndTextCommandSetBlipName(blip)
            local time = Config.jobTime*60000
        while hasJob == true and time > 0 do
            Wait(1000)
            time = time - 1000
            if time == 0 then
            hasJob = false
            cooldown = true
            QBCore.Functions.Notify("Your Contract has ended", 'error', 5000)
            RemoveBlip(blip)
            TriggerEvent('q2x:client:startCooldown')
            print(cooldown)
            end
        end
    else if cooldown == true then
        QBCore.Functions.Notify("Cooldown Now Fuck Off", 'error', 5000)
        return
      end
   end
end)


-- Doors
RegisterNetEvent('q2x:client:hackdoor',function ()
    if cooldown == false then
    if hasJob == true then
    if QBCore.Functions.HasItem(Config.bomb) then
    TriggerServerEvent('q2x:server:removeitem')
    TriggerEvent('q2x:client:dispatch')
    exports['ps-ui']:Thermite(function(success)
        if success then
            TriggerEvent('q2x:client:SpawnNPC', 1)
            door1()            
        else
            print("fail")
        end
     end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
      end
    end
  end
end)

RegisterNetEvent('q2x:client:hackg1',function ()
    if cooldown == false then
    if hasJob == true then
        if QBCore.Functions.HasItem(Config.bomb) then
            TriggerServerEvent('q2x:server:removeitem')
            TriggerEvent('q2x:client:dispatch')    
    exports['ps-ui']:Thermite(function(success)
        if success then
            TriggerEvent('q2x:client:SpawnNPC', 1)
            door2()            
        else
            print("fail")
        end
     end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
      end
    end
  end
end)

RegisterNetEvent('q2x:client:hackg2',function ()
    if cooldown == false then
    if hasJob == true then
     if QBCore.Functions.HasItem(Config.bomb) then
            TriggerServerEvent('q2x:server:removeitem')
            TriggerEvent('q2x:client:dispatch')  
    exports['ps-ui']:Thermite(function(success)
        if success then
            TriggerEvent('q2x:client:SpawnNPC', 1)
            door3()            
        else
            print("fail")
        end
     end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
      end
    end
  end
end)
-- Doors End

-- loot

RegisterNetEvent('q2x:client:loot1',function ()
    if not Loot1 then 
       if hasJob == true then
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot1', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards1')
       end
    end
end)

RegisterNetEvent('q2x:client:loot2',function ()
    if not Loot2 then 
       if hasJob == true then
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot2', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards2')
       end
    end
end)


RegisterNetEvent('q2x:client:loot3',function ()
    if not Loot2 then 
       if hasJob == true then
        TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
        TriggerServerEvent('q2x:server:setloot3', true)
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('q2x:server:rewards3')
       end
    end
end)
-- loot end







-- lib
exports['qb-target']:AddTargetModel(Config.Ped, {
    options = {
        {
            event = "q2x:client:startJob",
            icon = "fa-thin fa-warehouse",
            label = "Take a job",
            canInteract = function()
                if hasJob == false and GetEntityCoords(created_ped).x == Config.PedCoords.x and GetEntityCoords(created_ped).y == Config.PedCoords.y then
                    return hasJob == false and GetEntityCoords(created_ped).x == Config.PedCoords.x and GetEntityCoords(created_ped).y == Config.PedCoords.y
                end
            end,
        },
        {
            event = "q2x:client:hack",
            icon = "fa-thin fa-warehouse",
            label = "test",
        },
    },
    distance = 2.5,
})



RegisterNetEvent('q2x:client:dispatch', function(data, outside)
exports["ps-dispatch"]:CustomAlert({
    coords = vector3(0.0, 0.0, 0.0),
    message = "10-15 - Warehouse Robbery",
    description = "Warehouse Robbery",
    radius = 0,
    sprite = 64,
    color = 2,
    scale = 1.0,
    length = 3,
})
end)