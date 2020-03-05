local OwnedVehTable = {}
RegisterNetEvent("RS_KEY:GiveKey")
AddEventHandler("RS_KEY:GiveKey", function(plaque)
    local exist = false
    for _,v in pairs(OwnedVehTable) do
        if v == plaque then
            exist = true
            break
        end
    end
    if not exist then
        table.insert(OwnedVehTable, plaque)
        Popup("~r~Tu à reçu les clé du véhicule "..plaque)
    end
end)



-- Opti pour évité que ça spam
local NearVeh = nil
local NearPlate
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        --if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            NearVeh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)))
            NearPlate = GetVehicleNumberPlateText(NearVeh)
        --else
        --    NearVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        --    NearPlate = GetVehicleNumberPlateText(NearVeh)
        --end
    end
end)




-- Controls
Citizen.CreateThread(function()
    --DecorRegister("lock_status", 2)
    --DecorRegisterLock()
    while true do
        Wait(0)
        DisableControlAction(0, 303, true)
        if IsDisabledControlJustPressed(0, 303) then
            print(NearPlate)
            local found = false
            for k,v in pairs(OwnedVehTable) do
                if v == NearPlate then
                    found = true
                    --print(DecorGetBool(NearVeh, "lock_status"))
                    --if DecorExistOn(NearVeh, "lock_status") and DecorGetBool(NearVeh, "lock_status") then
                    if GetVehicleDoorLockStatus(NearVeh) == 2 then
                        --DecorSetBool(NearVeh, "lock_status", false)
                        LockVehicle(NearVeh, false)
                        print("Unlocked")
                    else
                        --DecorSetBool(NearVeh, "lock_status", true)
                        LockVehicle(NearVeh, true)
                        print("Locked")
                    end
                end
            end
            if not found then
                Popup("~r~Tu n'a pas les clés du véhicule.")
            end 
        end
        
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(3000)
        local _c = 0
        for veh in EnumerateVehicles() do
            --if DecorExistOn(veh, "lock_status") and DecorGetBool(veh, "lock_status") then
            --    --print(GetVehicleNumberPlateText(veh).." - fermé")
            --    SetVehicleDoorsLocked(veh, 2)
            --    SetVehicleDoorsLockedForAllPlayers(veh, 1)
            --else
            --    --print(GetVehicleNumberPlateText(veh).." - Ouvert")
            --    SetVehicleDoorsLocked(veh, 1)
            --    SetVehicleDoorsLockedForAllPlayers(veh, 0)
            --end
            SetEntityAsMissionEntity(veh, 1, 1)
            _c = (_c + 1) % 10
            if _c == 0 then
                Wait(0)
            end
        end
    end
end)


function Popup(txt)
	ClearPrints()
	SetNotificationBackgroundColor(140)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(txt)
	DrawNotification(false, true)
end

function LockVehicle(veh, status)
    if not status then
        exports['rs_notif']:Notify('true', 'Véhicule ouvert')
        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForAllPlayers(veh, 0)
        SetVehicleLights(veh, 2)
        SoundVehicleHornThisFrame(veh)
        Wait(200)
        SetVehicleLights(veh, 0)
        Wait(200)
        SetVehicleLights(veh, 2)
        SoundVehicleHornThisFrame(veh)
        Wait(400)
        SetVehicleLights(veh, 0)
    else
        exports['rs_notif']:Notify('false', 'Véhicule fermé')
        SetVehicleDoorsLocked(veh, 2)
        SetVehicleDoorsLockedForAllPlayers(veh, 1)
        SetVehicleLights(veh, 2)
        SoundVehicleHornThisFrame(veh)
        Wait(200)
        SetVehicleLights(veh, 0)
        Wait(200)
        SetVehicleLights(veh, 2)
        SoundVehicleHornThisFrame(veh)
        Wait(400)
        SetVehicleLights(veh, 0)
    end
end
