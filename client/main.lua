function GetZone()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    return wx.ZoneNames[tostring(GetNameOfZone(x,y,z))]
end

function GetStreet()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local streetHash = GetStreetNameAtCoord(x, y, z)
    return GetStreetNameFromHashKey(streetHash)
end

AddEventHandler("gameEventTriggered", function(name, args)
    if name == "CEventNetworkPlayerEnteredVehicle" then
        if args[1] ~= PlayerId() then
            return
        end
        SendNUIMessage({
            action = "show"
        })    end
end)

local open = false
Citizen.CreateThread(function ()
    while true do
        Wait(wx.refreshTime)
        if IsPedInAnyVehicle(PlayerPedId()) then
            local heading = GetEntityHeading(PlayerPedId())
            local main = Main(heading)
            local right = Right(main)
            local left = Left(main)
            SendNUIMessage({
                action = "refresh",
                street = GetStreet(),
                zone = GetZone(),
                heading = main,
                leftheading = left,
                rightheading = right,
            })
        else
            SendNUIMessage({
                action = "hide"
            })
        end
    end
end)

local directions = {"N", "NW", "W", "SW", "S", "SE", "E", "NE", "N"}

function Main(heading)
    local index = math.floor(((heading % 360) + 22.5) / 45) + 1
    return directions[index]
end

function Right(currentDirection)
    local leftIndex = currentDirection == "N" and "NW" or currentDirection == "NW" and "W" or currentDirection == "W" and "SW" or currentDirection == "SW" and "S" or currentDirection == "S" and "SE" or currentDirection == "SE" and "E" or currentDirection == "E" and "NE" or currentDirection == "NE" and "N" or "N"
    return leftIndex
end

function Left(currentDirection)
    local rightIndex = currentDirection == "N" and "NE" or currentDirection == "NE" and "E" or currentDirection == "E" and "SE" or currentDirection == "SE" and "S" or currentDirection == "S" and "SW" or currentDirection == "SW" and "W" or currentDirection == "W" and "NW" or currentDirection == "NW" and "N" or "N"
    return rightIndex
end
