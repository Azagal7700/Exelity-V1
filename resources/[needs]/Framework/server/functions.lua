function ESX.SetTimeout(msec, cb)
	local id = ESX.TimeoutCount + 1

	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id
	return id
end

ESX.AddJob = function(jobInfo)
	if not ESX.Jobs[jobInfo.name] then
		ESX.Jobs[jobInfo.name] = {}
		ESX.Jobs[jobInfo.name].name = jobInfo.name
		ESX.Jobs[jobInfo.name].label = jobInfo.label
		ESX.Jobs[jobInfo.name].grades = jobInfo.grades
		ESX.Jobs[jobInfo.name].whitelisted = jobInfo.whitelisted
		for k,v in pairs(jobInfo.grades) do
			MySQL.Async.execute('INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
				['@job_name'] = v.job_name,
				['@grade'] = tonumber(k),
				['@name'] = v.name,
				['@label'] = v.label,
				['@salary'] = v.salary,
				['@skin_male'] = v.skin_male,
				['@skin_female'] = v.skin_female
			})
		end
		MySQL.Async.execute('INSERT INTO jobs (name, label, whitelisted) VALUES (@name, @label, @whitelisted)', {
			['@name'] = jobInfo.name,
			['@label'] = jobInfo.label,
			['@whitelisted'] = jobInfo.whitelisted
		})
		print("Ajout d'un job dans ESX, nom : "..jobInfo.label)
	end
end

function ESX.ClearTimeout(id)
	ESX.CancelledTimeouts[id] = true
end

---@param xPlayer xPlayer | string
---@return boolean
function ESX.CheckIfPlayerIsAllowedForDanger(xPlayer)

	local founded

	if (type(xPlayer) == "table") then

		local player_identifiers = GetPlayerIdentifiers(xPlayer.source)

		for i in ipairs(player_identifiers) do
			
			local player_identifier = player_identifiers[i]
	
			if (player_identifier ~= nil and Config.PlayerAllowedForDanger[player_identifier] ~= nil) then
				
				founded = true
				break
	
			end
	
		end
		
	elseif (type(xPlayer) == "string") then
		
		local player_identifier = xPlayer

		if (player_identifier ~= nil and Config.PlayerAllowedForDanger[player_identifier] ~= nil) then
				
			founded = true

		end
	
	end

	return founded ~= nil and true or false

end

---@param xPlayer xPlayer
---@return boolean
function ESX.IsAllowedForDanger(xPlayer)
	return ESX.CheckIfPlayerIsAllowedForDanger(xPlayer);
end

function ESX.RegisterServerCallback(name, cb)
	ESX.ServerCallbacks[name] = cb
end

function ESX.TriggerServerCallback(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print(('[^3WARNING^7] Server callback "%s" does not exist.'):format(name))
	end
end

---@param xPlayer xPlayer
function ESX.SavePlayer(xPlayer, cb)
	local asyncTasks = {}

	if xPlayer then

		if (not ESX.GetPlayerInPVPMode(xPlayer.identifier)) then
			-- User Main
			table.insert(asyncTasks, function(cb)
				local lastCoords = ESX.RoundVector(xPlayer.getLastPosition())

				MySQL.Async.execute('UPDATE users SET accounts = @accounts, job = @job, job2 = @job2, job_grade = @job_grade, job2_grade = @job2_grade, inventory = @inventory, loadout = @loadout, position = @position, ammo = @ammo WHERE identifier = @identifier', {
					['@job'] = xPlayer.job.name,
					['@job2'] = xPlayer.job2.name,
					['@job_grade'] = xPlayer.job.grade,
					['@job2_grade'] = xPlayer.job2.grade,
					['@accounts'] = json.encode(xPlayer.getAccounts(true)),
					['@inventory'] = json.encode(xPlayer.getInventory(true)),
					['@loadout'] = json.encode(xPlayer.getLoadout()),
					['@position'] = json.encode({x = lastCoords.x, y = lastCoords.y, z = lastCoords.z}),
					['@ammo'] = json.encode(xPlayer.GetAmmo()),
					['@identifier'] = xPlayer.identifier
				}, function(rowsChanged)
					cb()
				end)
			end)

			Async.parallel(asyncTasks, function(results)
				if cb then
					cb()
				end
			end)
		end
	else
		if cb then
			cb()
		end
	end
end

function ESX.SavePlayers(cb)
	local asyncTasks = {}
	local xPlayers = ESX.GetPlayers()

	if #xPlayers > 0 then
		for i = 1, #xPlayers, 1 do
			table.insert(asyncTasks, function(cb)
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				ESX.SavePlayer(xPlayer, cb)
			end)
		end

		Async.parallelLimit(asyncTasks, 8, function(results)
			print(('[^2SAVE^7] %s player(s)'):format(#xPlayers))

			if cb then
				cb()
			end
		end)
	end
end

function ESX.SyncPosition()
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer then
			local plyPed = GetPlayerPed(xPlayer.source)

			if DoesEntityExist(plyPed) and xPlayer.positionSaveReady then
				local lastCoords = GetEntityCoords(plyPed)

				if lastCoords ~= nil then
					xPlayer.setLastPosition(lastCoords)
				end
			end
		end
	end
end

function ESX.StartDBSync()
	function saveData()
		ESX.SavePlayers()
		SetTimeout(5 * 60 * 1000, saveData)
	end

	SetTimeout(5 * 60 * 1000, saveData)
end

function ESX.StartPositionSync()
	function updateData()
		ESX.SyncPosition()
		SetTimeout(10 * 1000, updateData)
	end

	SetTimeout(5 * 1000, updateData)
end

function ESX.GetPlayers()
	local sources = {}

	for k, v in pairs(ESX.Players) do
		table.insert(sources, k)
	end

	return sources
end

---@return xPlayer[]
function ESX.GetPlayerInstances()
	return ESX.Players
end

---@param source number
---@return xPlayer
function ESX.GetPlayerFromId(source)
	return ESX.Players[tonumber(source)]
end

---@param character_id number
---@return xPlayer
function ESX.GetPlayerFromCharacter(character_id)

	if (type(character_id) ~= "number") then
		return
	end

	for _, v in pairs(ESX.Players) do

		if v.character_id == character_id then

			return v

		end

	end

end

---@param identifier string
---@return xPlayer
function ESX.GetPlayerFromIdentifier(identifier)
	for k, v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

function ESX.GetIdentifierFromId(source, identifier)
	identifier = identifier or Config.DefaultIdentifier;
	local identifiers = GetPlayerIdentifiers(tonumber(source))

	for i = 1, #identifiers, 1 do
		if string.sub(identifiers[i], 1, string.len(identifier)) == identifier then
			return identifiers[i]
		end
	end

	return false
end

function ESX.RegisterUsableItem(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

function ESX.UseItem(source, item)
	if ESX.UsableItemsCallbacks[item] then
		ESX.UsableItemsCallbacks[item](source)
	end
end

function ESX.GetItem(item)
	if ESX.Items[item] then
		return ESX.Items[item]
	end
end

function ESX.DoesJobExist(job, grade)
	grade = tostring(grade)

	if job and grade then
		if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end

function ESX.ChatMessage(source, msg, author, color)
	TriggerClientEvent('chat:addMessage', source, {color = color or {0, 0, 0}, args = {author or 'SYSTEME', msg or ''}})
end

function ESX.DB.CreateUser(identifier, cb)
	local position = json.encode({x = Config.DefaultPosition.x, y = Config.DefaultPosition.y, z = Config.DefaultPosition.z})

	MySQL.Async.execute('INSERT INTO users (identifier, position) VALUES (@identifier, @position)', {
		identifier = identifier,
		position = position
	}, function()
		if cb then
			cb()
		end
	end)
end

function ESX.DB.UpdateUser(identifier, new, cb)
	Citizen.CreateThread(function()
		local updateString = ''
		local length = ESX.Table.SizeOf(new)
		local cLength = 1

		for k, v in pairs(new) do
			if cLength < length then
				if (type(v) == 'number') then
					updateString = updateString .. "`" .. k .. "` = " .. v .. ","
				else
					updateString = updateString .. "`" .. k .. "` = '" .. v .. "',"
				end
			else
				if (type(v) == 'number') then
					updateString = updateString .. "`" .. k .. "` = " .. v
				else
					updateString = updateString .. "`" .. k .. "` = '" .. v .. "'"
				end
			end

			cLength = cLength + 1
		end

		MySQL.Async.execute('UPDATE users SET ' .. updateString .. ' WHERE `identifier` = @identifier', {identifier = identifier}, function()
			if cb then
				cb(true)
			end
		end)
	end)
end

function ESX.DB.DoesUserExist(identifier, cb)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier` = @identifier', {identifier = identifier}, function(result)
		if cb then
			if result[1] then
				cb(true)
			else
				cb(false)
			end
		end
	end)
end

---Server side function (exports from JustGod resource)
---@param model string
---@param position vector3
---@param heading number
---@param plate string
---@param locked boolean
---@param xPlayer xPlayer
---@param callback fun(handle: number, properties: table)
function ESX.SpawnVehicle(model, position, heading, plate, locked, xPlayer, callback)
	exports["JustGod"]:SpawnVehicle(model, position, heading, plate, locked, xPlayer, callback);
end

---Server side function (exports from JustGod resource)
---@param vehiclePlate string
---@param callback function
function ESX.RemoveVehicle(vehiclePlate, callback)
	exports["JustGod"]:RemoveVehicle(vehiclePlate, callback);
end

---Server side function (exports from JustGod resource)
---@param xPlayer xPlayer
---@param numberPlate string
---@param notify boolean
function ESX.GiveCarKey(xPlayer, numberPlate, notify)
	exports["JustGod"]:GiveCarKey(xPlayer, numberPlate, notify);
end

---Server side function (exports from JustGod resource)
---@param societyName string
---@return boolean
function ESX.DoesSocietyExist(societyName)
	return exports["JustGod"]:SocietyExist(societyName);
end

---Server side function (exports from JustGod resource)
---@param societyName string
---@return number
function ESX.GetSocietyMoney(societyName)
	return exports["JustGod"]:GetSocietyMoney(societyName);
end

---Server side function (exports from JustGod resource)
---@param societyName string
---@param amount number
function ESX.AddSocietyMoney(societyName, amount)
	exports["JustGod"]:AddSocietyMoney(societyName, amount);
end

---Server side function (exports from JustGod resource)
---@param societyName string
---@param amount number
function ESX.RemoveSocietyMoney(societyName, amount)
	exports["JustGod"]:RemoveSocietyMoney(societyName, amount);
end

---Server side function (exports from JustGod resource)
---@param name string
---@param label string
---@param canWashMoney boolean
---@param canUseOffshore boolean
---@param societyType number
---@param callback fun(esxSociety: table)
function ESX.AddSociety(name, label, canWashMoney, canUseOffshore, societyType, callback)
	exports["JustGod"]:AddSociety(name, label, canWashMoney, canUseOffshore, societyType, callback);
end