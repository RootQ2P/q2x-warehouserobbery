local QBCore = exports['qb-core']:GetCoreObject()

function makein()
    for _, pickuploc in pairs(box.PickupLocations) do
    local model = GetHashKey(box.WarehouseObjects[math.random(1, #box.WarehouseObjects)])
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(0)
    end
    local obj = CreateObject(model, pickuploc.x, pickuploc.y, pickuploc.z)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
end
end

RegisterNetEvent('test:client:target:exitLocation', function()
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(10)
  end
  SetEntityCoords(PlayerPedId(), Config.warehousesmallexit.x, Config.warehousesmallexit.y, Config.warehousesmallexit.z)
  DoScreenFadeIn(500)
end)

  
