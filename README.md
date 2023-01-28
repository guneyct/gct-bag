## GCT Bag

This script allows you to open a bag for yourself.

https://discord.gg/PHBX53jcSn

## DEPENDENCIES

[qb-core](https://github.com/qbcore-framework/qb-core)

## INVENTORY INTEGRATION

Add this code in **AddItems** *main function*;

```lua

    if item:lower() == "bag" and (info.created == nil or info.created == false)  then
        info = {
            created = true,
            stashName = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomInt(4))
        }
    end

```

After that go to your **qb-inventory/server/main.lua** and find the code below and change like this:

```lua

            elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)

				TriggerClientEvent('inventory:client:ItemBox',src,QBCore.Shared.Items[fromItemData.name],'remove', fromAmount) 

				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				--Player.PlayerData.items[toSlot] = fromItemData
				if toItemData ~= nil then
					--Player.PlayerData.items[fromSlot] = toItemData
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						RemoveFromStash(stashId, fromSlot, itemInfo["name"], toAmount)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerClientEvent('inventory:client:ItemBox',src,QBCore.Shared.Items[toItemData.name],'add', toAmount)

						--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="stash1", toName=toItemData.name, toAmount=toAmount, fromName=fromItemData.name, fromAmount=fromAmount, target=stashId})
						--TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) swapped item; name: **"..itemInfo["name"].."**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					--TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "itemswapped", {type="stash2", name=fromItemData.name, amount=fromAmount, target=stashId})
					--TriggerEvent("qb-log:server:CreateLog", "stash", "Dropped Item", "red", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) dropped new item; name: **"..itemInfo["name"].."**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
				end

				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]

				AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info) -- CHANGE THE CODE LINE 59 WITH THE CODE BELOW (THIS LINE)
				
				--[[ 
				if fromItemData.name == "bag" then
					if stashId == "bag_".. fromItemData.info.stashName then
						RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
						Player.Functions.AddItem(fromItemData.name, fromAmount, fromSlot, fromItemData.info)
						TriggerClientEvent('qb-inventory:client:CloseInv', src)
						TriggerClientEvent('QBCore:Notify', src, "Aynı çantayı çanta içine koyamazsın..", 'error')
					else
						AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
					end
				else
					AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
				]]--

```

## IMPORTANT

Don't forget to edit **config.lua**