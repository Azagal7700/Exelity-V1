ESX = nil
TriggerEvent(Config.ESX, function(obj) ESX = obj end)

RegisterServerEvent('vda:pay')
AddEventHandler('vda:pay', function(prix, weapon, nom, type)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job2.name == Config.Vda.OrgaOK then
        if xPlayer.getAccount('dirtycash').money >= prix then
            if type == "weapon" then
                xPlayer.removeAccountMoney('dirtycash', prix)
                xPlayer.addWeapon(weapon, 255)
                TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~g~"..nom.." pour ~g~"..prix.."$.")
            else
                if type == "item" then
                    xPlayer.removeAccountMoney('dirtycash', prix)
                    xPlayer.addInventoryItem(weapon, 1)
                    TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~g~"..nom.." pour ~g~"..prix.."$.")
                end
            end
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    else
        xPlayer.ban(0, '(vda:pay)');
    end
end)

ESX.RegisterServerCallback('vda:getPos', function(source, cb)
    cb(vector3(5065.917, -4591.636, 2.8))
end)