local KeyTable = {}


RegisterNetEvent("RS_KEY:RegisterKey")
AddEventHandler("RS_KEY:RegisterKey", function(keys)
    local idSteam = GetPlayerIdentifier(source, 0)
    local found = false
    for k,v in pairs(KeyTable) do
        if v.id == idSteam then
            found = true
            table.remove(KeyTable, k)
            break
        end
    end
    table.insert(KeyTable, {id = idSteam, key = keys,})
end)


RegisterNetEvent("RS_KEY:GetRegisteredKeys")
AddEventHandler("RS_KEY:GetRegisteredKeys", function()
    local idSteam = GetPlayerIdentifier(source, 0)
    local found = false
    local keys = {}
    for k,v in pairs(KeyTable) do
        if v.id == idSteam then
            keys = v.key
            found = true
            break
        end
    end
    TriggerClientEvent("RS_KEY:GetRegisteredKeys", source, keys)
end)
