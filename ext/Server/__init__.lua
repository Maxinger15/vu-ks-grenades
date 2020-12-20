local mortarPartitionGuid = Guid("5350B268-18C9-11E0-B820-CD6C272E4FCC")
local customBlueprintGuid = Guid("D407033B-49AE-DF14-FE19-FC776AE04E2C")
NetEvents:Subscribe(
	"vu-ks-grenades:Launch",
	function(player, position)
		local weaponsComponent = player.soldier.weaponsComponent
		SoldierWeapon(weaponsComponent.weapons[7]).secondaryAmmo =
		SoldierWeapon(weaponsComponent.weapons[7]).secondaryAmmo + 2
		NetEvents:SendTo("Killstreak:showNotification",player, json.encode({title="Grenades",message="Resupply arrived"}))
		NetEvents:SendToLocal("vu-ks-grenades:Success",player)
	end
)


--Events:Subscribe(
--	"Player:Chat",
--	function(player, recipientMask, message)
--		local weaponsComponent = player.soldier.weaponsComponent
--
--		for key, value in pairs(weaponsComponent.weapons) do
--			if weaponsComponent.weapons[key] ~= nil then
--				weapon = SoldierWeapon(weaponsComponent.weapons[key])
--				print(weapon.name)
--			end
--		end
--	end
--)
