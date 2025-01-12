---
--- @author Azagal
--- Create at [01/11/2022] 20:26:55
--- Current project [Exelity-V1]
--- File name [_main]
---

Helipad = Helipad or {}
Helipad.Config = nil

local function initPlayer()
    if (ESX.GetPlayerData().job ~= nil and Helipad.Config[ESX.GetPlayerData().job["name"]] ~= nil) then
        local selectedHelipad = Helipad.Config[ESX.GetPlayerData().job["name"]]
        local currentJob = ESX.GetPlayerData().job
        while (ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job["name"] == currentJob.name and Helipad.Config[ESX.GetPlayerData().job["name"]] ~= nil) do
            local loopInterval = 1000

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            if (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 1.5)) then
                loopInterval = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'héliport.")
                if IsControlJustPressed(0, 51) then
                    Helipad:spawnMenu()
                end
            elseif (selectedHelipad.deletePosition ~= nil and (#(playerCoords-selectedHelipad.deletePosition) < 1.5)) then
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    loopInterval = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger l'hélicoptère.")
                    if IsControlJustPressed(0, 51) then
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end
            elseif (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 10.0)) then
                loopInterval = 0
                DrawMarker(Config.Get.Marker.Type, selectedHelipad.menuPosition, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end

            Wait(loopInterval)
        end
    end
end

CreateThread(function()
    while (ESX == nil) do
        Wait(0)
    end

    while (ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil) do
        Wait(0)
    end

    TriggerServerEvent("Helipad:Request:LoadConfig")

    while (Helipad.Config == nil) do
        Wait(0)
    end

    initPlayer()
end)

AddEventHandler('esx:setJob', function(job)
    while (ESX.GetPlayerData().job["name"] ~= job.name) do
        Wait(0)
    end

    initPlayer()
end)

RegisterNetEvent("Helipad:ClientReturn:Config", function(helipadConfig)
    Helipad.Config = helipadConfig or {};
end)