--[[
  This file is part of Exelity RolePlay.
  Copyright (c) Exelity RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

local desCategoriesDeBateau = {}
local desBateaux = {}
local isOpenedActions = false
local theCategoriesname
local theCategorieslabel
local thisIsForPreviewBoat = {}
local alwaysPreview = {}
local getSocietyBateaux = {}
local LastBoats = {}
local inCaseOfBoat = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    x,y,z = -901.7216, 6672.901, 3.229774
    local blip = AddBlipForCoord(x,y,z)

	SetBlipSprite (blip, 410)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 3)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("[Entreprise] Concessionnaire bateaux")
	EndTextCommandSetBlipName(blip)

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while true do
        local interval = 500
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Jobs.Boat.Actions) do
            if ESX.PlayerData.job.name == 'boatseller' then
                if #(coords - v.actions) <= 10 then
                    interval = 1
                    DrawMarker(Config.Get.Marker.Type, v.actions, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.actions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustReleased(0, 38) then
                            openBoatshopActions()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterNetEvent('BoatShop:onSpawnVehicle', function(menuData, vehicleNetworkId, vehicleProps)
    local data = menuData;
    exports["JustGod"]:GetByNetworkId(vehicleNetworkId, function(vehicle)
        table.insert(LastBoats, vehicle);
        table.insert(inCaseOfBoat, {
            vehicle = data.props,
            name = data.name,
            price = data.price,
            category = data.category,
            vehicleProps = vehicleProps
        });
    end)
end);

function openBoatshopActions()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local sortirBateaux = RageUI.CreateSubMenu(mainMenu, "", "Sortir un bâteau")
    local listeBateaux = RageUI.CreateSubMenu(mainMenu, "", "Liste des catégories")
    local lesBateauxDeLaCategories = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local preview = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')

    local x,y,z 

    preview.Closed = function()
        SetEntityCoords(PlayerPedId(), x, y, z)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityLocallyInvisible(PlayerPedId(), false)
        for k,v in pairs(thisIsForPreviewBoat) do
            SetModelAsNoLongerNeeded(v.vehicle)
            ESX.Game.DeleteVehicle(v.vehicle)
        end
        RageUI.CloseAll()
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Acheter un bâteau", nil , {RightLabel = "→"}, true, {
                onSelected = function()
                    getBoatCategories()
                    getBoats()
                end
            }, listeBateaux)
            RageUI.Button("Sortir un bâteau", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    getPossedBoats()
                end
            }, sortirBateaux)
            RageUI.Button("Donner le bâteau", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('~r~Personne autour de vous')
                    else
                        for k,v in pairs(inCaseOfBoat) do
                            TriggerServerEvent('BoatShop:sellthevehicle', GetPlayerServerId(closestPlayer), v.vehicleProps)
                            ESX.ShowNotification("~y~Vous avez bien donner le bâteau !")
                        end
                        inCaseOfBoat = {}
                    end
                end
            })
            RageUI.Button("Mettre une facture", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputBoatShop("Montant:", 'Rentrez un montant', '', 8)
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification('~r~Personne autour de vous')
						else
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'boatseller', 'Concessionnaire Bateau', amount)
						end
                    end
                end
            })
            RageUI.Button("Ranger le bâteau", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    DeleteShopInsideBoat()
                end
            })
        end)

        RageUI.IsVisible(sortirBateaux, function()
            for k,v in pairs(getSocietyBateaux) do
                RageUI.Button(v.name, nil , {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        local plate     = GeneratePlate();
                        TriggerServerEvent('BoatShop:removesocietyboat',  v.id, v.props, plate, v);

                        --[[
                        ESX.Game.SpawnVehicle(v.props, {x = -734.8, y = -1332.4, z = -0.47}, 349.06, function (vehicle)
                            local plaque     = GeneratePlate()
                            SetVehicleNumberPlateText(vehicle, plaque)
                            table.insert(LastBoats, vehicle)
                            local vehicleProps = ESX.Game.GetVehicleProperties(LastBoats[#LastBoats])
                            vehicleProps.plate = plaque
                            table.insert(inCaseOfBoat, {
                                vehicle = v.props,
                                name = v.name,
                                price = v.price,
                                category = v.category,
                                vehicleProps = vehicleProps
                            })
                            
                        end)
                        ]]
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        RageUI.IsVisible(listeBateaux, function()
            for k,v in pairs(desCategoriesDeBateau) do
                if v.name == 'superboat' then
                    RageUI.Button(v.label, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                        end
                    }, lesBateauxDeLaCategories)
                end
            end
        end)

        RageUI.IsVisible(lesBateauxDeLaCategories, function()
            RageUI.Separator("bâteau de la catégorie: "..theCategorieslabel)
            for k,v in pairs(desBateaux) do
                if v.category == theCategories then
                    RageUI.Button(v.name, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                            local plyPed = PlayerPedId()
                            SetEntityCoords(plyPed, -982.8464, 6631.547, -0.4078919)
                            local vehicle = v.model
                            ESX.Game.SpawnLocalVehicle(vehicle, {x = -982.8464, y = 6631.547, z = -0.4078919}, 89.16, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                                --SetModelAsNoLongerNeeded(vehicle)
                                table.insert(thisIsForPreviewBoat, {
                                    vehicle = vehicle,
                                    price = v.price,
                                    name = v.name,
                                    model = v.model
                                })
                            end)
                        end
                    }, preview)
                end
            end
        end)


        RageUI.IsVisible(preview, function()
            for k,v in pairs(thisIsForPreviewBoat) do
                local plyPed = PlayerPedId()
                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
                SetEntityLocallyInvisible(PlayerPedId(), true)
                if GetVehiclePedIsIn(plyPed) == 0 then
                    TaskWarpPedIntoVehicle(plyPed, v.vehicle, -1)
                end
                RageUI.Separator("~p~Confirmez l'achat de "..v.name.."")
                RageUI.Button("Acheter le bâteau", nil, {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('BoatShop:getSocietyMoney', function(data)
                            local d = data;
                            if (d >= v.price) then
                                TriggerServerEvent('BoatShop:buyVehicle', v.model, v.name, v.price);
                                SetModelAsNoLongerNeeded(v.vehicle)
                                ESX.Game.DeleteVehicle(v.vehicle)
                                RageUI.CloseAll()
                                SetEntityCoords(PlayerPedId(), x, y, z)
                                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                                SetEntityLocallyInvisible(PlayerPedId(), false)
                                TriggerServerEvent('BoatShop:changeBucket', "leave")
                                inCaseOfBoat = {}
                            else
                                ESX.ShowNotification("~r~Il n'y a pas suffisamment d'argent dans la société.")
                            end
                        end)
                    end
                })
                RageUI.Button("Non", nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        SetModelAsNoLongerNeeded(v.vehicle)
                        ESX.Game.DeleteVehicle(v.vehicle)
                        RageUI.CloseAll()
                        SetEntityCoords(PlayerPedId(), x, y, z)
                        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                        SetEntityLocallyInvisible(PlayerPedId(), false)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(listeBateaux) and not RageUI.Visible(lesBateauxDeLaCategories) and not RageUI.Visible(preview) and not RageUI.Visible(sortirBateaux) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        if not RageUI.Visible(listeBateaux) and not RageUI.Visible(lesBateauxDeLaCategories) and not RageUI.Visible(preview) then
            desCategoriesDeBateau = {}
            desBateaux = {}
            thisIsForPreviewBoat = {}
        end
        if not RageUI.Visible(sortirBateaux) then
            getSocietyBateaux = {}
            alwaysPreview = {}
        end

        Citizen.Wait(0)
    end
end

function getBoatCategories()
    ESX.TriggerServerCallback('BoatShop:getBoatCategories', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategoriesDeBateau, {
                name = d.name,
                label = d.label,
                society = d.society
            })

        end
    end)
end

function getBoats()
    ESX.TriggerServerCallback('BoatShop:getAllVehicles', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desBateaux, {
                model = d.model,
                name = d.name,
                price = d.price,
                category = d.category
            })
        end
    end)
end

function getPossedBoats()
    ESX.TriggerServerCallback('BoatShop:getSocietyVehicles', function(ladata)
        for i=1, #ladata do
            local d = ladata[i]
            table.insert(getSocietyBateaux, {
                id = d.id,
                props = d.vehicle,
                name = d.name,
                price = d.price,
                society = d.society
            })
        end
    end)
end

function DeleteShopInsideBoat()

    TriggerServerEvent("boatseller:deleteAllVehicles");

	--while #LastBoats > 0 do
	--	local vehicle = LastBoats[1]
    --
	--	ESX.Game.DeleteVehicle(vehicle)
    --    for k,v in pairs(inCaseOfBoat) do
    --        TriggerServerEvent('BoatShop:recupvehicle', v.vehicle, v.name, v.price, v.society)
    --    end
	--	table.remove(LastBoats, 1)
    --    inCaseOfBoat = {}
	--end
end

function KeyboardInputBoatShop(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

local open = false 
local boatMain2 = RageUI.CreateMenu('', 'Concessionnaire Bateau')
local subMenu5 = RageUI.CreateSubMenu(boatMain2, "Annonces", "Interaction")
boatMain2.Display.Header = true 
boatMain2.Closed = function()
  open = false
end

function OpenMenuBoatShop()
	if open then 
		open = false
		RageUI.Visible(boatMain2, false)
		return
	else
		open = true 
		RageUI.Visible(boatMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(boatMain2,function() 

			RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:BoatShop')
				end
			})

			RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:BoatShop')
				end
			})

			RageUI.Button("Annonce ~p~[Recrutement]", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recrutement:BoatShop')
				end
			})
			end)

		 Wait(0)
		end
	 end)
  end
end

local IsInPVP = false;

AddEventHandler("JustGod:exelity:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

Keys.Register('F6', 'boatshop', 'Menu job boatshop', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boatseller' then

        if (not IsInPVP) then
            OpenMenuBoatShop()
        end
    	
	end
end)