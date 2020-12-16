
local debug = false
local activated = true
local curStep = nil

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
