-- client.lua
local ESX = exports['es_extended']:getSharedObject()

local currentJob = nil
local deliveryBlip = nil
local returnBlip = nil
local jobVehicle = nil
local deliveryCoords = nil
local waiting = false

function DrawMarkerAndBlip()
    if Config.JobStartBlip then
        local blip = AddBlipForCoord(Config.JobStart)
        SetBlipSprite(blip, 477)
        SetBlipColour(blip, 2)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Truck Job")
        EndTextCommandSetBlipName(blip)
    end
end

function StartTruckJobMenu()
    local elements = {}
    for jobType, data in pairs(Config.Missions) do
        table.insert(elements, {label = data.label, value = jobType})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'truck_job_menu', {
        title = 'Choose a job type',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()
        StartJob(data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

function StartJob(jobType)
    local mission = Config.Missions[jobType]
    currentJob = jobType
    deliveryCoords = mission.deliveryPoints[math.random(1, #mission.deliveryPoints)]

    -- Vehicle spawn
    ESX.Game.SpawnVehicle(mission.vehicle, vector3(Config.VehicleSpawn.coords.x, Config.VehicleSpawn.coords.y, Config.VehicleSpawn.coords.z), Config.VehicleSpawn.heading, function(vehicle)
        jobVehicle = vehicle
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)

    -- Delivery point blip
    deliveryBlip = AddBlipForCoord(deliveryCoords)
    SetBlipRoute(deliveryBlip, true)
    SetBlipColour(deliveryBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Point")
    EndTextCommandSetBlipName(deliveryBlip)
end

CreateThread(function()
    DrawMarkerAndBlip()
    while true do
        local sleep = 0 -- always running for the marker
        local playerCoords = GetEntityCoords(PlayerPedId())
        DrawMarker(1, Config.JobStart.x, Config.JobStart.y, Config.JobStart.z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 255, 0, 150, false, true, 2, false, nil, nil, false)

        if #(playerCoords - Config.JobStart) < 3.0 then
            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to start the job.")
            if IsControlJustReleased(0, 38) then
                if currentJob == nil then
                    StartTruckJobMenu()
                else
                    ESX.ShowNotification("You already have an active job!")
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        if currentJob and not waiting then
            local playerCoords = GetEntityCoords(PlayerPedId())
            if #(playerCoords - deliveryCoords) < 5.0 then
                waiting = true
                ESX.ShowNotification("Wait 1 minute for unloading...")
                SetBlipRoute(deliveryBlip, false)
                Wait(60000) -- Wait for 1 minute
                ESX.ShowNotification("You can now return to the station.")

                -- Set return point blip
                RemoveBlip(deliveryBlip)
                deliveryBlip = nil
                returnBlip = AddBlipForCoord(vector3(1204.6064453125, -3116.6423339844, 5.5403246879578))
                SetBlipRoute(returnBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Park here to finish the job")
                EndTextCommandSetBlipName(returnBlip)
            end
        elseif waiting then
            local playerCoords = GetEntityCoords(PlayerPedId())
            -- Check if the player is at the parking location to complete the job
            if #(playerCoords - vector3(1204.6064453125, -3116.6423339844, 5.5403246879578)) < 5.0 then
                ESX.ShowNotification("You successfully completed the job!")
                RemoveBlip(returnBlip)
                returnBlip = nil
                DeleteVehicle(jobVehicle)
                jobVehicle = nil

                TriggerServerEvent('esx_truckjob:completeJob', currentJob)

                currentJob = nil
                deliveryCoords = nil
                waiting = false
            end
        end
    end
end)
