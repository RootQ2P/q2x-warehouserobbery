local QBCore = exports['qb-core']:GetCoreObject()
-- Door
exports['qb-target']:AddBoxZone("d1", vector3(939.58, -1489.75, 30.45), 1.6, 1, {
    name = "d1",
    heading=270,
    debugPoly = false,
}, { 
    options = {
        {
            event = "q2x:client:hackdoor",
            icon = "fa-thin fa-warehouse",
            label = "Open Door",
            
        },
    },
    distance = 1.5
})
exports['qb-target']:AddBoxZone("d2", vector3(935.81, -1488.69, 30.16), 4.2, 3, {
    name = "d2",
    heading=270,
    debugPoly = false,
}, { 
    options = {
        {
            event = "q2x:client:hackg1",
            icon = "fa-thin fa-warehouse",
            label = "Open Door",
            
        },
    },
    distance = 1.5
})
exports['qb-target']:AddBoxZone("d3", vector3(943.35, -1489.02, 30.14), 4.2, 3, {
    name = "d3",
    heading=270,
    debugPoly = false,
}, { 
    options = {
        {
            event = "q2x:client:hackg2",
            icon = "fa-thin fa-warehouse",
            label = "Open Door",
            
        },
    },
    distance = 1.5
})
-- Door End

-- loot
exports['qb-target']:AddBoxZone("1", vector3(944.89, -1476.27, 30.1), 1.4, 3, {
    name = "1",
    heading=270,
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "q2x:client:loot1",
            icon = "fas fa-gem",
            label = 'Grab Jewellery'
            
        },
    },
    distance = 1.5
})

exports['qb-target']:AddBoxZone("2", vector3(945.52, -1473.22, 30.1), 3, 3, {
    name = "2",
    heading=0,
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "q2x:client:loot2",
            icon = "fas fa-question",
            label = 'Grab Items'
            
        },
    },
    distance = 1.5
})   
exports['qb-target']:AddBoxZone("3", vector3(944.91, -1470.37, 30.1), 1.6, 3, {
    name = "2",
    heading=0,
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "q2x:client:loot3",
            icon = "fas fa-question",
            label = 'Grab Items'
            
        },
    },
    distance = 1.5
})   
exports['qb-target']:AddBoxZone("3", vector3(945.47, -1466.45, 30.1), 3.2, 3, {
    name = "2",
    heading=0,
    debugPoly = false,
}, { 
    options = {
        {
            type = "Client",
            event = "q2x:client:loot3",
            icon = "fas fa-question",
            label = 'Grab Items'
            
        },
    },
    distance = 1.5
})  
-- loot

























-- lib
RegisterCommand("heist", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])
    TriggerServerEvent('q2x:server:ResetHeist')
end, true) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.


    
-- thread
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isActive then
            Citizen.Wait(Config.StartTimer*60000)
            RemoveBlip(hackBlip)
            TriggerEvent('q2x:client:ResetHeist')
        end
    end
end)
RegisterNetEvent('q2x:client:ResetHeist', function()
    TriggerServerEvent('q2x:server:ResetHeist')
end)

CreateThread(function()
    QBCore.Functions.LoadModel(Config.Ped)
    created_ped = CreatePed(5, GetHashKey(Config.Ped) , Config.PedCoords, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
end)