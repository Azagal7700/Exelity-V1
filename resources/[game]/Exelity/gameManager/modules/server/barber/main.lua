--[[
  This file is part of Exelity RolePlay.
  Copyright (c) Exelity RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

RegisterServerEvent('barbershop:pay')
AddEventHandler('barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeAccountMoney('cash', 15)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez payé ~p~15$")
end)