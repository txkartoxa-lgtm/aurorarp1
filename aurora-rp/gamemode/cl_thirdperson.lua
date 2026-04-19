-- Aurora RP - Third Person System
-- Toggle third person view with smooth camera

local thirdPersonEnabled = true
local thirdPersonDistance = 100
local thirdPersonHeight = 50

concommand.Add("aurora_thirdperson", function(ply, cmd, args)
    if #args > 0 then
        thirdPersonEnabled = args[1] == "1"
        LocalPlayer():SetNWBool("ThirdPerson", thirdPersonEnabled)
        
        if thirdPersonEnabled then
            notification.AddLegacy("Третье лицо: ВКЛЮЧЕНО", NOTIFY_GENERIC, 3)
        else
            notification.AddLegacy("Третье лицо: ВЫКЛЮЧЕНО", NOTIFY_GENERIC, 3)
        end
    else
        thirdPersonEnabled = not thirdPersonEnabled
        LocalPlayer():SetNWBool("ThirdPerson", thirdPersonEnabled)
        
        if thirdPersonEnabled then
            notification.AddLegacy("Третье лицо: ВКЛЮЧЕНО", NOTIFY_GENERIC, 3)
        else
            notification.AddLegacy("Третье лицо: ВЫКЛЮЧЕНО", NOTIFY_GENERIC, 3)
        end
    end
end)

concommand.Add("aurora_tp_distance", function(ply, cmd, args)
    if #args > 0 then
        local distance = tonumber(args[1])
        if distance and distance >= 50 and distance <= 300 then
            thirdPersonDistance = distance
            notification.AddLegacy("Дистанция камеры: " .. distance, NOTIFY_GENERIC, 2)
        end
    end
end)

-- Toggle with V key
hook.Add("Think", "AuroraRP_ThirdPersonToggle", function()
    if input.IsKeyDown(KEY_V) then
        if not thirdPersonToggleCooldown or CurTime() > thirdPersonToggleCooldown then
            RunConsoleCommand("aurora_thirdperson", thirdPersonEnabled and "0" or "1")
            thirdPersonToggleCooldown = CurTime() + 0.5
        end
    end
end)

print("Aurora RP Third Person System Loaded!")
