Config = {}
 
-- DEBUG -- 
Config.Debug = true

Config.Ped = "a_m_y_business_02"  
Config.PedCoords = vector4(699.95, -1448.85, 21.0, 303.08) 

Config.jobTime = 15            
Config.cooldown = 15
Config.BombTimer = 10 -- how long the bomb needs to explode
Config.bomb = "weapon_stickybomb"
Config.DoorLock = 'qb' -- use 'qb' for qb-doorlock events
Config.DoorId = '1-1' -- name of the door in your doorlock config
Config.DoorId2 = '1-2' -- name of the door in your doorlock config
Config.DoorId3 = '1-3' -- name of the door in your doorlock config




-- peds
Config.PedGun = 'weapon_pistol' -- weapon NPC's use
Config.SetPedAccuracy = 100 -- (between 10-100)
Config.Shooters = {
    ['whouse'] = {
        locations = {
            [1] = { 
                peds = {vector3(935.97, -1475.74, 30.1),vector3(941.27, -1479.89, 30.1)}
            },
        },
    }
}
