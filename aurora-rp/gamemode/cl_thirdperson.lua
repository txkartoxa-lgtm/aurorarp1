-- Aurora RP - Third Person System
-- Toggle third person view with V key

if CLIENT then
    local thirdPersonEnabled = false
    local thirdPersonDistance = 150
    local thirdPersonHeight = 60

    -- Toggle third person with V key
    local lastKeyPress = 0
    
    hook.Add("Think", "AuroraRP_ThirdPersonToggle", function()
        if input.IsKeyDown(KEY_V) and (CurTime() - lastKeyPress > 0.3) then
            lastKeyPress = CurTime()
            thirdPersonEnabled = not thirdPersonEnabled
            
            if thirdPersonEnabled then
                print("[Aurora RP] Третье лицо включено")
            else
                print("[Aurora RP] Третье лицо выключено")
            end
        end
    end)

    -- Calculate camera position for third person
    hook.Add("CalcView", "AuroraRP_ThirdPersonCamera", function(ply, origin, angles, fov, znear, zfar)
        if not thirdPersonEnabled then return end
        
        local targetOrigin = origin + Vector(0, 0, 30)
        
        -- Get the direction the player is looking
        local forward = angles:Forward() * -thirdPersonDistance
        local right = angles:Right() * 0
        local up = angles:Up() * thirdPersonHeight
        
        -- Calculate camera position
        local camPos = targetOrigin + forward + right + up
        
        -- Trace to avoid camera going through walls
        local trace = util.QuickTrace(targetOrigin, camPos - targetOrigin, ply)
        
        if trace.Hit then
            camPos = trace.HitPos + trace.HitNormal * 10
        end
        
        local view = {}
        view.origin = camPos
        view.angles = angles
        view.fov = fov
        view.znear = znear
        view.zfar = zfar
        
        return view
    end)

    -- Hide player model in first person when in third person
    hook.Add("ShouldDrawLocalPlayer", "AuroraRP_DrawLocalPlayer", function(ply)
        if thirdPersonEnabled then
            return true
        end
        return false
    end)

    print("[Aurora RP] Third person system loaded! Press V to toggle.")
end
