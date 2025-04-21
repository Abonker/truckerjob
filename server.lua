-- server.lua
local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_truckjob:completeJob')
AddEventHandler('esx_truckjob:completeJob', function(jobType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local reward = Config.Missions[jobType].reward

    -- Give reward to player
    xPlayer.addMoney(reward)
    TriggerClientEvent('esx:showNotification', source, 'You completed the ' .. Config.Missions[jobType].label .. ' job and earned $' .. reward)
end)
