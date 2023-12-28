-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local RepairCosts = {}

-----------------------
----   Functions   ----
-----------------------

local function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result then retval = true end
    return retval
end

-----------------------
----   Callbacks   ----
-----------------------

QBCore.Functions.CreateCallback('qb-customs:server:GetLocations', function(_, cb)
    cb(Config.Locations)
end)

-----------------------
---- Server Events ----
-----------------------

AddEventHandler("playerDropped", function()
    local source = source
    RepairCosts[source] = nil
end)



  

RegisterNetEvent('qb-customs:server:attemptPurchase', function(type, upgradeLevel, location)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local job = Player.PlayerData.job.name
    local moneyType = Config.MoneyType
    local balance = Player.Functions.GetMoney(moneyType)
    local price
    if type == "repair" then
        price = RepairCosts[source] or Config.DefaultRepairPrice
        moneyType = Config.RepairMoneyType
        balance = Player.Functions.GetMoney(moneyType)
    elseif type == "performance" or type == "turbo" then
        price = vehicleCustomisationPrices[type].prices[upgradeLevel]
    else
        price = vehicleCustomisationPrices[type].price
    end
    local restrictionJobs = Config.Locations[location] and Config.Locations[location].restrictions.job or {}
    local paidBySociety = false
    local jobRestricted = false
    local freeForSociety = false

    for i = 1, #restrictionJobs do
        if restrictionJobs[i] == job then
            jobRestricted = true
            paidBySociety = true
            break
        end
    end
    if not paidBySociety then
        for i = 1, #Config.PaidBySociety do
            if Config.PaidBySociety[i] == job then
                paidBySociety = true
                break
            end
        end
    end
    if not freeForSociety then
        for i = 1, #Config.FreeForSociety do
            if Config.FreeForSociety[i] == job then
                FreeForSociety = true
                break
            end
        end
    end
    if not freeForSociety then
        if paidBySociety then
            if exports['qb-management']:GetAccount(job) >= price then
                exports['qb-management']:RemoveMoney(job, price)
                TriggerClientEvent('qb-customs:client:purchaseSuccessful', source)
            else
                paidBySociety = false
                TriggerClientEvent('QBCore:Notify', source, "Your job society can't pay for this. ", 6000)
                TriggerClientEvent('qb-customs:client:purchaseFailed', source)
            end
        end
        if not paidBySociety then
            if balance >= price then
                TriggerClientEvent('qb-customs:client:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-customs:client:purchaseFailed', source)
            end
        end
    else
        TriggerClientEvent('qb-customs:client:purchaseSuccessful', source)
    end
end)

RegisterNetEvent('qb-customs:server:updateRepairCost', function(cost)
    local source = source
    RepairCosts[source] = cost
end)

function sendToDiscord(color, message, webhook)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**Mechanic Logs**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "NS Scripts https://ns-scripts.tebex.io/",
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    return
end

RegisterNetEvent('qb-customs:server:sendWebhook', function(message, webhook)
    if message.message == "" then
        return
    end
    message.message = "**"..message.title.."**"..message.message.."\nTotal Cost (exc repairs): $"..message.price
    sendToDiscord(message.color, message.message, Config.AdminLogsWebhook)
    if webhook then
        sendToDiscord(message.color, message.message, webhook)
    else
        return
    end
end)

RegisterNetEvent("qb-customs:server:updateVehicle", function(myCar)
    if IsVehicleOwned(myCar.plate) then
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(myCar), myCar.plate })
    end
end)

-- Use this event to dynamically enable/disable a location. Can be used to change anything at a location.
-- TriggerEvent('qb-customs:server:UpdateLocation', 'Hayes', 'settings', 'enabled', test)

RegisterNetEvent('qb-customs:server:UpdateLocation', function(location, type, key, value)
    local source = source
    if not QBCore.Functions.HasPermission(source, 'god') then return CancelEvent() end
    Config.Locations[location][type][key] = value
    TriggerClientEvent('qb-customs:client:UpdateLocation', -1, location, type, key, value)
end)

-- name, help, args, argsrequired, cb, perms
QBCore.Commands.Add('customs', 'Open customs (God Only)', {}, false, function(source)
    local ped = GetPlayerPed(source)
    TriggerClientEvent('qb-customs:client:EnterCustoms', source, {
        coords = GetEntityCoords(ped),
        heading = GetEntityHeading(ped),
        categories = {
            repair = true,
            mods = true,
            armor = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            turbo = true,
            cosmetics = true,
        }
    })

end, 'god')

