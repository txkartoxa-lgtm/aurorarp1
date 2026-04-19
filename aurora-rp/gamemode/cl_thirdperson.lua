-- Aurora RP - Third Person System
-- Smooth third person camera with V key toggle

if not CLIENT then return end

AuroraRP.ThirdPerson = AuroraRP.ThirdPerson or {}
AuroraRP.ThirdPerson.Enabled = AuroraRP.Config.DefaultThirdPerson or true
AuroraRP.ThirdPerson.Distance = 150
AuroraRP.ThirdPerson.Height = 60
AuroraRP.ThirdPerson.Smoothness = 0.15

-- Toggle third person with V key
hook.Add("Think", "AuroraRP_ThirdPersonToggle", function()
    if input.IsKeyDown(KEY_V) then
        if not AuroraRP.ThirdPerson.LastVPress or (CurTime() - AuroraRP.ThirdPerson.LastVPress) > 0.3 then
            AuroraRP.ThirdPerson.Enabled = not AuroraRP.ThirdPerson.Enabled
            AuroraRP.ThirdPerson.LastVPress = CurTime()
            
            local status = AuroraRP.ThirdPerson.Enabled and "enabled" or "disabled"
            notification.AddLegacy("Third Person " .. status, NOTIFY_GENERIC, 2)
        end
    end
end)

-- Override camera for third person
hook.Add("CalcView", "AuroraRP_ThirdPersonCamera", function(ply, pos, angles, fov, zfar, znear)
    if not AuroraRP.ThirdPerson.Enabled then return end
    if not IsValid(ply) or ply ~= LocalPlayer() then return end
    if not ply:Alive() then return end
    
    local view = {}
    
    -- Calculate camera position
    local trace = {}
    trace.start = pos
    trace.endpos = pos - (angles:Forward() * AuroraRP.ThirdPerson.Distance) + Vector(0, 0, AuroraRP.ThirdPerson.Height)
    trace.filter = ply
    trace.mask = MASK_SOLID
    
    local tr = util.TraceLine(trace)
    
    view.origin = tr.HitPos
    view.angles = angles
    view.fov = fov
    view.znear = znear
    view.zfar = zfar
    view.drawviewer = true
    
    return view
end)

-- Apply third person model rendering
hook.Add("CalcViewModelView", "AuroraRP_ThirdPersonViewModel", function(vm, wep, pos, angles, fov, znear, zfar)
    if not AuroraRP.ThirdPerson.Enabled then return end
    
    -- Hide view model in third person
    return pos, angles
end)

-- Make player model visible in third person
hook.Add("PrePlayerDraw", "AuroraRP_DrawLocalPlayer", function(ply)
    if AuroraRP.ThirdPerson.Enabled and ply == LocalPlayer() then
        -- Player model is automatically drawn in third person
        return false
    end
end)

print("[Aurora RP] Third person system loaded!")
