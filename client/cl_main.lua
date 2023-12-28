QBCore = exports['qb-core']:GetCoreObject()

local inStashLocation = false

local function stash(name, space)
	while inStashLocation do
		Wait(0)
		if IsControlJustReleased(0, 38) then
			TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {maxweight = space, slots = 70})
			TriggerEvent("inventory:client:SetCurrentStash", name)
			break
		end
	end
end

-- Personal Stash steveauto
local stashPerZone = {}
stashPerZone[1] = BoxZone:Create(
	vector3(vector3(1011.07, -113.04, 75.42)), 1.5, 1.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  75.42 - 2,
	maxZ =  75.42 + 1,
})
local PerStash = ComboZone:Create(stashPerZone, {name = "PerStash", debugPoly = false})
PerStash:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'steveauto' then
			inStashLocation = true
    		exports['qb-core']:DrawText("Press [E] to open personal locker", 'left')
        	stash("stevemech_"..Player.citizenid, 400000)
        end
    else
		inStashLocation = false
        exports['qb-core']:HideText()
    end
end)

-- Personal Stash fastcustoms
local stashPerZonefastcustoms = {}
stashPerZonefastcustoms[1] = BoxZone:Create(
	vector3(vector3(-928.78, -766.67, 15.27)), 1.5, 1.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  15.42 - 2,
	maxZ =  15.42 + 1,
})
local PerStashfastcustoms = ComboZone:Create(stashPerZonefastcustoms, {name = "PerStashfastcustoms", debugPoly = false})
PerStashfastcustoms:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'fastcustoms' then
			inStashLocation = true
    		exports['qb-core']:DrawText("Press [E] to open personal locker", 'left')
        	stash("fastcustoms_"..Player.citizenid, 400000)
        end
    else
		inStashLocation = false
        exports['qb-core']:HideText()
    end
end)

-- Fridge Stash
local stashFridgeZone = {}
stashFridgeZone[1] = BoxZone:Create(
	vector3(vector3(963.57, -98.34, 74.5)), 2.5, 2.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  75.42 - 2,
	maxZ =  75.42 + 1,
})
local FridgeStash = ComboZone:Create(stashFridgeZone, {name = "FridgeStash", debugPoly = false})
FridgeStash:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'steveauto' then
			inStashLocation = true
    		exports['qb-core']:DrawText("Press [E] to open storage", 'left')
        	stash("stevemech_fridge", 4000000)
        end
    else
		inStashLocation = false
        exports['qb-core']:HideText()
    end
end)

-- shared stash
local stashSharedZone = {}
stashSharedZone[1] = BoxZone:Create(
	vector3(vector3(-926.96, -765.82, 15.27)), 2.5, 2.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  15.42 - 2,
	maxZ =  15.42 + 1,
})
local sharedZone = ComboZone:Create(stashSharedZone, {name = "sharedZone", debugPoly = false})
sharedZone:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'fastcustoms' then
			inStashLocation = true
    		exports['qb-core']:DrawText("Press [E] to open storage", 'left')
        	stash("fastcustoms_shared", 4000000)
        end
    else
		inStashLocation = false
        exports['qb-core']:HideText()
    end
end)


local inClothing = false

local function clothing()
    CreateThread(function()
        while inClothing do
            Wait(0)
			if IsControlJustReleased(0, 38) then
				TriggerEvent("illenium-appearance:client:openOutfitMenu")
				break
			end
        end
    end)
end

-- Clothing steveauto
local clothingZone = {}
clothingZone[1] = BoxZone:Create(
	vector3(vector3(1010.79, -116.58, 74.5)), 1.5, 1.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  75.42 - 2,
	maxZ =  75.42 + 1,
})
local clothingsec = ComboZone:Create(clothingZone, {name = "clothingsec", debugPoly = false})
clothingsec:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'steveauto' then
			inClothing = true
    		exports['qb-core']:DrawText("Press [E] to change outfit", 'left')
        	clothing()
        end
    else
		inClothing = false
        exports['qb-core']:HideText()
    end
end)

local clothingZonefastcustoms = {}
clothingZonefastcustoms[1] = BoxZone:Create(
	vector3(vector3(-931.76, -759.12, 15.27)), 1.5, 1.5, {
	name="box_zone",
	debugPoly = false,
	minZ =  15.42 - 2,
	maxZ =  15.42 + 1,
})
local clothingsecfastcustoms = ComboZone:Create(clothingZonefastcustoms, {name = "clothingsecfastcustoms", debugPoly = false})
clothingsecfastcustoms:onPlayerInOut(function(isPointInside, _, _)
    if isPointInside then
		local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == 'fastcustoms' then
			inClothing = true
    		exports['qb-core']:DrawText("Press [E] to change outfit", 'left')
        	clothing()
        end
    else
		inClothing = false
        exports['qb-core']:HideText()
    end
end)