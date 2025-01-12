--
--Created Date: 15:44 11/12/2022
--Author: JustGod
--Made with ❤
--
--File: [Server]
--
--Copyright (c) 2022 JustGodWork, All Rights Reserved.
--This file is part of JustGodWork project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

---@type Server
Server = Class.new(function(class)

    ---@class Server: BaseObject
    local self = class;

    function self:Constructor()
        MySQL.ready(function()
            print([[
                ^4

                     ____.               __     ________           .___
                    |    |__ __  _______/  |_  /  _____/  ____   __| _/
                    |    |  |  \/  ___/\   __\/   \  ___ /  _ \ / __ |
                /\__|    |  |  /\___ \  |  |  \    \_\  (  <_> ) /_/ |
                \________|____//____  > |__|   \______  /\____/\____ |
                                    \/                \/            \/

                        ^6Made for Exelity

                        ^6Info: ^0This is not a Core, it's a module.

                        ^6Tip: ^0Make money but respect your player's and their wallet.


                ]]);
            JG.Discord = Discord(Config["ServerName"]);
            JG.AdminManager = AdminManager();
            JG.PlayersManager = PlayersManager();
            JG.SocietyManager = SocietyManager();
            JG.VehicleManager = VehicleManager();
            JG.KeyManager = KeyManager();
            JG.GangBuilder = GangBuilder();
            self:HandleDisconnectError();
            Shared:Initialized("Server");
        end);
    end

    ---@param callback function
    function self:OnRestart(callback)

        Shared.Events:On("onResourceStart", function(resourceName)

            if (resourceName == "JustGod") then

                if (callback) then callback(); end

            end

        end);

    end

    ---@param xPlayer xPlayer | number
    ---@return xPlayer
    function self:ConvertToPlayer(xPlayer)
        return type(xPlayer) == "table" and xPlayer or ESX.GetPlayerFromId(xPlayer);
    end

    ---@param xPlayer xPlayer | number
    ---@param reason string
    function self:BanPlayer(xPlayer, reason)
        local prefix = "\nJustGod say: ";
        local banReason = string.format("%s%s", prefix, reason) or "\nJustGod say: No reason provided.";
        local xPlayer = self:ConvertToPlayer(xPlayer);

        if (xPlayer) then

            Shared.Events:ToClient(xPlayer, Enums.Exelity.Player.TrollSong);

            xPlayer.ban(0, banReason);

            -- todo make this work again
            --exports["SeaShield"]:BanPlayer(xPlayer.source, {
            --    name = "JustGod Resource",
            --    reason = banReason
            --});

        end

    end

    ---@param callback fun(xPlayer: xPlayer, reason: string)
    ---@return number
    function self:OnPlayerDropped(callback)
        return AddEventHandler("playerDropped", function(reason)

            local src = source;
            local xPlayer = ESX.GetPlayerFromId(src);

            if (xPlayer) then

                callback(xPlayer, reason);

            end

        end);
    end

    function self:HandleDisconnectError()

        AddEventHandler("playerDropped", function(reason)

            local src = source;
            local xPlayer = ESX.GetPlayerFromId(src);

            if (not xPlayer) then

                local playerName = GetPlayerName(src);

                Shared.Log:Error(Shared.Lang:Translate("player_disconnected_while_loading", playerName ~= nil and playerName or src, reason));

            end

        end);

    end

    return self;

end)();