local QBCore = exports['qb-core']:GetCoreObject()
local hasJob = false
local cooldown = false
local crate = 0

-- Main
RegisterNetEvent('q2x:client:startCooldown', function()
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

RegisterNetEvent('q2x:client:startJob', function()
    if cooldown then
        QBCore.Functions.Notify("Cooldown is active. Please wait.", 'error', 5000)
        return
    end
    
    hasJob = true
    QBCore.Functions.Notify("The job location has been marked on your map", 'success', 5000)
    
    -- Create a custom blip for the job location
    local blip = AddBlipForCoord(1014.32, -2450.50, 28.39)
    SetBlipSprite(blip, 161)
    BeginTextCommandSetBlipName('MYBLIP')
    EndTextCommandSetBlipName(blip)

    local time = Config.jobTime * 60000

    while hasJob and time > 0 do
        Wait(1000)
        time = time - 1000

        if time <= 0 then
            hasJob = false
            cooldown = true
            QBCore.Functions.Notify("Your contract has ended", 'error', 5000)
            RemoveBlip(blip)
            TriggerEvent('q2x:client:startCooldown')
            print(cooldown)
        end
    end
end)



RegisterNetEvent('q2x:client:loot', function(data, outside)
    Wait(1)
    local inRange = false  
    if QBCore ~= nil then
        local pos = GetEntityCoords(PlayerPedId())
        for k in pairs(box.crate) do
            local dist = #(pos - box.crate[k][1].xyz)
            if dist < 3 then
                inRange = true
                if dist < 1.0 then
                    if not box.crate[k].robbed then
                        crate = k
                        exports['ps-ui']:Circle(function(success)
                            if success then
                                print("success")
                                TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
                                Wait(5000)
                                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                TriggerServerEvent('q2x:server:rewards')
                                TriggerServerEvent("q2x-warehouse:server:setCrateStatus", crate)
                            else
                                print("fail")
                            end
                        end, 2, 20) -- NumberOfCircles, MS
                        print(k)
                    end
                end
            end
        end
    end

    if not inRange then
        Wait(2000)
    end
end)

RegisterNetEvent('test:client:target:enterLocation', function()
    if hasJob then
        exports['ps-ui']:VarHack(function(success)
            if success then
                exports['ps-dispatch']:SuspiciousActivity()
                print("Success: Fading out screen...")
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    makein()
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.warehousesmall.x, Config.warehousesmall.y, Config.warehousesmall.z)
                DoScreenFadeIn(500)
            else
                print("Fail: VarHack failed.")
exports['ps-dispatch']:SuspiciousActivity()
            end
        end, 2, 3) -- Number of Blocks, Time (seconds)
    else 
        QBCore.Functions.Notify("You Don't Have the Job", 'error', 5000)
    end
end)

RegisterNetEvent('q2x-warehouse:client:setCrateStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if type(batch) ~= "table" then
        box.crate[batch] = val
    else
        for k in pairs(batch) do
            box.crate[k] = batch[k]
        end
    end
end)

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
    },
    distance = 2.5,
})
