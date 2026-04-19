-- Aurora RP - Main Gamemode File
-- This file extends DarkRP with Aurora RP features

if not DarkRP then return end

-- Initialize Aurora RP
AuroraRP = AuroraRP or {}

-- Override default values
hook.Add("Initialize", "AuroraRP_Init", function()
    print("[Aurora RP] Server initialized!")
    print("[Aurora RP] Map: " .. game.GetMap())
end)

-- Set player defaults
hook.Add("PlayerInitialSpawn", "AuroraRP_PlayerSpawn", function(ply)
    timer.Simple(1, function()
        if not IsValid(ply) then return end
        
        -- Set starting money
        if ply:Team() == TEAM_CITIZEN then
            ply:setDarkRPVariable("money", math.max(ply:getDarkRPVariable("money", 0), AuroraRP.Config.StartingMoney or 5000))
        end
    end)
end)

-- Prevent door stealing
hook.Add("CanProperty", "AuroraRP_PreventDoorSteal", function(ply, property, ent)
    if property == "keepupright" and IsValid(ent) and ent:GetClass() == "prop_door_rotating" then
        local owners = ent:getKeys()
        if #owners > 0 then
            local isOwner = false
            for _, owner in ipairs(owners) do
                if owner == ply then
                    isOwner = true
                    break
                end
            end
            if not isOwner then
                ply:ChatPrint("[Aurora RP] You cannot modify doors you don't own!")
                return false
            end
        end
    end
end)

-- Safe physgun restrictions
hook.Add("PhysgunPickup", "AuroraRP_SafePhysgun", function(ply, ent)
    -- Allow physgun on props but prevent destructive behavior
    if ent:GetClass() == "prop_physics" then
        return true
    end
    -- Prevent picking up players without permission
    if ent:IsPlayer() then
        return false
    end
end)

print("[Aurora RP] Gamemode loaded successfully!")
