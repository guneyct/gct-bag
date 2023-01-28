local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.BagItem, function(source, item)
    local src = source
    
    TriggerClientEvent("gct-bag:client:openStash", src, item.info.stashName)
end)