local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent("gct-bag:client:openStash", function(stashName)
    local hasBag = false
    for k, v in pairs(Config.BagList) do
        if v == GetPedDrawableVariation(PlayerPedId(), 5) then
            hasBag = true
            break
        end
    end

    if hasBag then
        QBCore.Functions.Progressbar("use_bag", "Putting on Bag", 2000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            RequestAnimDict("anim@heists@ornate_bank@grab_cash")
            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash", "intro", 3.0, 3.0, 2000, 51, 0, false, false, false)
            Wait(550)
            TriggerEvent("inventory:client:SetCurrentStash", "bag_" .. stashName, QBCore.Key)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "bag_" .. stashName, {
                maxweight = Config.Weight * 1000,
                slots = Config.Slots
            })
        end)
    else
        QBCore.Functions.Notify("Çanta takmıyorsunuz!", "error", 2500)
    end
end)