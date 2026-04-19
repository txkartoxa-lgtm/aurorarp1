-- Aurora RP - Server Initialization
-- Door system, keys, jobs, and core mechanics

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_jobs_menu.lua")
AddCSLuaFile("cl_donate_menu.lua")
AddCSLuaFile("cl_thirdperson.lua")

include("init.lua")

-- Set default money for new players
hook.Add("PlayerInitialSpawn", "AuroraRP_SetDefaultMoney", function(ply)
    timer.Simple(5, function()
        if IsValid(ply) then
            ply:addMoney(5000 - ply:getDarkRPVar("money"))
            ply:setHealth(100)
            ply:setArmor(0)
            -- Set hunger to 100 (if using hunger mod)
            if ply.setHunger then
                ply:setHunger(100)
            end
        end
    end)
end)

-- Door ownership system
hook.Add("CanDoorOwn", "AuroraRP_DoorOwnership", function(ply, ent)
    -- Only allow door purchase for valid doors
    if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
        return true
    end
    return false
end)

-- Prevent door stealing
hook.Add("CanTool", "AuroraRP_PreventDoorSteal", function(ply, trace, tool)
    if tool == "door" then
        local ent = trace.Entity
        if IsValid(ent) and ent:GetOwner() ~= ply and ent:GetOwner() ~= NULL then
            -- Someone else owns this door
            ply:ChatPrint("Эта дверь принадлежит другому игроку!")
            return false
        end
    end
    return true
end)

-- Key system integration
hook.Add("PlayerUse", "AuroraRP_DoorKeySystem", function(ply, ent)
    if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
        local owner = ent:GetOwner()
        
        if owner == ply or owner == NULL then
            -- Owner or unowned door - can open/close
            return nil
        else
            -- Check if player has key (using DarkRP's built-in system)
            if ent:IsKeysOwnedBy(ply) then
                return nil -- Allow interaction
            else
                -- Player doesn't own key - knock only
                ply:ChatPrint("У вас нет ключа от этой двери. Используйте !knock чтобы постучаться.")
                return false
            end
        end
    end
end)

-- Custom commands for door management
concommand.Add("addowner", function(ply, cmd, args)
    if #args < 1 then
        ply:ChatPrint("Использование: !addowner [игрок] - добавить владельца двери")
        return
    end
    
    local targetName = table.concat(args, " ")
    local target = player.GetByName(targetName)
    
    if not IsValid(target) then
        ply:ChatPrint("Игрок не найден!")
        return
    end
    
    local trace = ply:GetEyeTrace()
    local ent = trace.Entity
    
    if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
        if ent:GetOwner() == ply then
            ent:AddKeys(target)
            ply:ChatPrint("Вы добавили " .. target:Nick() .. " в владельцы двери.")
            target:ChatPrint(ply:Nick() .. " добавил вас в владельцы двери.")
        else
            ply:ChatPrint("Эта дверь вам не принадлежит!")
        end
    else
        ply:ChatPrint("Смотрите на дверь!")
    end
end)

concommand.Add("removeowner", function(ply, cmd, args)
    if #args < 1 then
        ply:ChatPrint("Использование: !removeowner [игрок] - удалить владельца двери")
        return
    end
    
    local targetName = table.concat(args, " ")
    local target = player.GetByName(targetName)
    
    if not IsValid(target) then
        ply:ChatPrint("Игрок не найден!")
        return
    end
    
    local trace = ply:GetEyeTrace()
    local ent = trace.Entity
    
    if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
        if ent:GetOwner() == ply then
            ent:RemoveKeys(target)
            ply:ChatPrint("Вы удалили " .. target:Nick() .. " из владельцев двери.")
            target:ChatPrint(ply:Nick() .. " удалил вас из владельцев двери.")
        else
            ply:ChatPrint("Эта дверь вам не принадлежит!")
        end
    else
        ply:ChatPrint("Смотрите на дверь!")
    end
end)

concommand.Add("knock", function(ply, cmd, args)
    local trace = ply:GetEyeTrace()
    local ent = trace.Entity
    
    if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
        local owner = ent:GetOwner()
        
        if IsValid(owner) and owner ~= ply then
            -- Play knock sound
            ent:EmitSound("physics/wood/wood_solid_impact_hard2.wav")
            
            -- Notify owner
            owner:ChatPrint(ply:Nick() .. " стучится в вашу дверь!")
            ply:ChatPrint("Вы постучались в дверь.")
        else
            ply:ChatPrint("Дверь никому не принадлежит или вы владелец.")
        end
    else
        ply:ChatPrint("Смотрите на дверь!")
    end
end)

-- Safe gravity gun (no explosions)
hook.Add("GravGunPickupAllowed", "AuroraRP_SafeGravGun", function(ply, ent)
    if IsValid(ent) and ent:GetClass() == "prop_physics" then
        return true
    end
    return false
end)

hook.Add("PhysgunPickup", "AuroraRP_SafePhysGun", function(ply, ent)
    if IsValid(ent) and ent:GetClass() == "prop_physics" then
        return true
    end
    return false
end)

-- Prevent physics gun from breaking props
hook.Add("PhysgunDrop", "AuroraRP_PreventPhysGunBreak", function(ply, ent)
    if IsValid(ent) then
        ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    end
end)

-- Toolgun restrictions
hook.Add("CanTool", "AuroraRP_ToolRestrictions", function(ply, trace, tool)
    local ent = trace.Entity
    
    -- Allow toolgun on world but restrict certain tools
    if tool == "nocollide" then
        return false -- Prevent nocollide abuse
    end
    
    if tool == "remover" then
        if IsValid(ent) and ent:GetClass() == "prop_physics" then
            return true
        end
        return false
    end
    
    return true
end)

print("Aurora RP Server Loaded!")
