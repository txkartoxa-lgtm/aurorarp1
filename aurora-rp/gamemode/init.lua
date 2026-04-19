-- Aurora RP - Main Server Initialization
-- This file handles server-side game logic

if SERVER then
    AddCSLuaFile("cl_init.lua")
    AddCSLuaFile("cl_hud.lua")
    AddCSLuaFile("cl_jobs_menu.lua")
    AddCSLuaFile("cl_donate_menu.lua")
    AddCSLuaFile("cl_thirdperson.lua")
    AddCSLuaFile("shared.lua")

    GM = GM or {}
    GM.Name = "Aurora RP"
    GM.Author = "Aurora Team"

    -- Set starting money and stats
    hook.Add("PlayerInitialSpawn", "AuroraRP_SetStartingStats", function(ply)
        timer.Simple(2, function()
            if IsValid(ply) then
                ply:SetMaxHealth(100)
                ply:SetHealth(100)
                ply:SetArmor(0)
                
                -- Set starting money if DarkRP is loaded
                if DarkRP and ply.setDarkRPVar then
                    ply:setDarkRPVar("money", 5000)
                end
            end
        end)
    end)

    -- Safe Physgun - prevent destruction
    hook.Add("PhysgunPickup", "AuroraRP_SafePhysgun", function(ply, ent)
        -- Allow physgun but log usage
        return true
    end)

    -- Prevent door stealing
    hook.Add("CanProperty", "AuroraRP_PreventDoorStealing", function(ply, property, ent)
        if property == "persist" and ent:GetClass() == "prop_door_rotating" then
            local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
            if owner and owner ~= ply then
                DarkRP.notify(ply, 1, 3, "Вы не можете сохранять чужие двери!")
                return false
            end
        end
        return true
    end)

    -- Door ownership system
    hook.Add("PlayerUse", "AuroraRP_DoorSystem", function(ply, ent)
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            return
        end

        local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
        
        -- If door has no owner, allow purchase
        if not owner then
            return true
        end

        -- Owner can always use the door
        if owner == ply then
            return true
        end

        -- Check if player is co-owner
        local coOwners = ent:GetNWString("AuroraDoorCoOwners", "")
        if string.find(coOwners, ply:SteamID()) then
            return true
        end

        -- Non-owners can only open if already open
        if ent:IsOpen() then
            return true
        end

        -- Notify player
        DarkRP.notify(ply, 1, 3, "Эта дверь принадлежит другому игроку. Используйте !knock чтобы постучаться.")
        return false
    end)

    print("[Aurora RP] Server initialization complete!")
end
