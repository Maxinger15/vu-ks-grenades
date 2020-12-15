
local debug = false
local activated = true
local curStep = nil
Hooks:Install(
	"UI:PushScreen",
	1,
	function(hook, screen, priority, parentGraph, stateNodeGuid)
		local screen = UIGraphAsset(screen)
		print(screen.name)

		if screen.name == "UI/Flow/Screen/KillScreen" and (pointOfAim.mode == 1 or pointOfAim.mode == 2) then
			pointOfAim.mode = FiringMode.Disabled
			Events:Unsubscribe("Player:UpdateInput")
			Events:Unsubscribe("UpdateManager:Update")
			Events:Unsubscribe("UI:DrawHud")
			updateEvent = nil
			drawHudEvent = nil
		end
	end
)

NetEvents:Subscribe("vu-ks-grenades:Success",function()
	print("Grenades restocked successfully")
	Events:Dispatch("Killstreak:usedStep",curStep)
end)

Events:Subscribe("vu-ks-grenades:Invoke",function(stepNr,keyboardKey)
	print("Killstreak enabled")
	curStep = stepNr
	NetEvents:SendLocal("vu-ks-grenades:Launch")
end)

if(debug) then
	Events:Subscribe(
		"Player:UpdateInput",
		function()
			if InputManager:WentKeyDown(InputDeviceKeys.IDK_F) then
				print("restock grenades")
				NetEvents:SendLocal("vu-ks-grenades:Launch")
			end
		end
	)
end
