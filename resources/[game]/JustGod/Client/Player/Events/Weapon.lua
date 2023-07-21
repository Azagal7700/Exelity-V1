--
--Created Date: 18:02 11/12/2022
--Author: JustGod
--Made with ❤
--
--File: [Weapon]
--
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.addWeapon(), function(weaponName, ammo)
    Client.Player:AddWeapon(weaponName, ammo);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.removeWeapon(), function(weaponName, ammo)
    Client.Player:RemoveWeapon(weaponName, ammo);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.setWeaponAmmo(), function(weaponName, ammo)
    Client.Player:SetWeaponAmmo(weaponName, ammo);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.addWeaponComponent(), function(weaponName, component)
    Client.Player:AddWeaponComponent(weaponName, component);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.removeWeaponComponent(), function(weaponName, component)
    Client.Player:RemoveWeaponComponent(weaponName, component);
end);

