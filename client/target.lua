local QBCore = exports['qb-core']:GetCoreObject()
local isActive = false
local hackBlip

-- Thread for handling heist reset
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isActive then
            Citizen.Wait(Config.StartTimer * 60000)
            RemoveBlip(hackBlip)
            TriggerEvent('q2x:client:ResetHeist')
        end
    end
end)

-- Event to reset the heist
RegisterNetEvent('q2x:client:ResetHeist', function()
    TriggerServerEvent('q2x:server:ResetHeist')
end)

-- Thread to create a ped
CreateThread(function()
    QBCore.Functions.LoadModel(Config.Ped)
    local created_ped = CreatePed(5, GetHashKey(Config.Ped), Config.PedCoords, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
end)

-- Add box zones
exports['qb-target']:AddBoxZone("4", vector3(1014.96, -2448.09, 28.52), 4, 1, {
    name = "4",
    heading = 0,  
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "test:client:target:enterLocation",
            icon = "fas fa-hand-spock",
            label = 'Hack KeyPad'
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("3", vector3(1105.82, -3099.37, -39.0), 4, 1, {
    name = "3",
    heading = 0,  
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "test:client:target:exitLocation",
            icon = "fas fa-door-open",
            label = 'Exit Warehouse'
        },
    },
    distance = 1.5
})

-- Thread to add target models
CreateThread(function()
    exports['qb-target']:AddTargetModel(box.Props, {
        options = {
            {
                type = "Client",
                event = "q2x:client:loot",
                icon = "fas fa-gem",
                label = 'Grab Loot'
            },
        },
        distance = 1.5
    })
end)
