-- Aurora RP - Shared Functions
-- Door system, keys, and protection

if not DarkRP then return end

-- Network strings for door system
util.AddNetworkString("AuroraRP_DoorKnock")
util.AddNetworkString("AuroraRP_DoorAddOwner")
util.AddNetworkString("AuroraRP_DoorRemoveOwner")

-- Client-side door commands
if CLIENT then
    net.Receive("AuroraRP_DoorKnockResponse", function()
        local msg = net.ReadString()
        chat.AddText(Color(255, 200, 50), "[Aurora RP] ", Color(255, 255, 255), msg)
    end)
    
    net.Receive("AuroraRP_DoorOperationResult", function()
        local success = net.ReadBool()
        local msg = net.ReadString()
        
        if success then
            notification.AddLegacy(msg, NOTIFY_GENERIC, 3)
        else
            notification.AddLegacy(msg, NOTIFY_ERROR, 3)
        end
    end)
end

-- Server-side door handling
if SERVER then
    -- Door knocking system
    net.Receive("AuroraRP_DoorKnock", function(len, ply)
        local ent = net.ReadEntity()
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then return end
        
        local owners = ent:getKeys()
        if #owners == 0 then
            net.Start("AuroraRP_DoorKnockResponse")
            net.WriteString("This door has no owner. You can buy it!")
            net.Send(ply)
            return
        end
        
        -- Find online owners
        local onlineOwners = {}
        for _, owner in ipairs(owners) do
            if IsValid(owner) and owner:IsPlayer() then
                table.insert(onlineOwners, owner)
            end
        end
        
        if #onlineOwners > 0 then
            -- Send knock message to owners
            for _, owner in ipairs(onlineOwners) do
                owner:ChatPrint("[Aurora RP] Someone is knocking at your door! (" .. ply:Nick() .. ")")
            end
            
            net.Start("AuroraRP_DoorKnockResponse")
            net.WriteString("You knocked on the door. Waiting for response...")
            net.Send(ply)
        else
            net.Start("AuroraRP_DoorKnockResponse")
            net.WriteString("No owners are online.")
            net.Send(ply)
        end
    end)
    
    -- Add door owner
    net.Receive("AuroraRP_DoorAddOwner", function(len, ply)
        local ent = net.ReadEntity()
        local target = net.ReadPlayer()
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("Invalid door!")
            net.Send(ply)
            return
        end
        
        if not IsValid(target) then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("Player not found!")
            net.Send(ply)
            return
        end
        
        local owners = ent:getKeys()
        local isOwner = false
        for _, owner in ipairs(owners) do
            if owner == ply then
                isOwner = true
                break
            end
        end
        
        if not isOwner then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("You are not the owner of this door!")
            net.Send(ply)
            return
        end
        
        -- Check max doors
        local currentDoors = 0
        for _, door in ipairs(ents.FindByClass("prop_door_rotating")) do
            local doorOwners = door:getKeys()
            for _, owner in ipairs(doorOwners) do
                if owner == target then
                    currentDoors = currentDoors + 1
                    break
                end
            end
        end
        
        if currentDoors >= (AuroraRP.Config.MaxDoorsPerPlayer or 10) then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("Player has reached maximum door limit!")
            net.Send(ply)
            return
        end
        
        -- Add owner
        ent:addKeys(target)
        
        net.Start("AuroraRP_DoorOperationResult")
        net.WriteBool(true)
        net.WriteString("Added " .. target:Nick() .. " as door owner!")
        net.Broadcast()
    end)
    
    -- Remove door owner
    net.Receive("AuroraRP_DoorRemoveOwner", function(len, ply)
        local ent = net.ReadEntity()
        local target = net.ReadPlayer()
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("Invalid door!")
            net.Send(ply)
            return
        end
        
        if not IsValid(target) then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("Player not found!")
            net.Send(ply)
            return
        end
        
        local owners = ent:getKeys()
        local isOwner = false
        for _, owner in ipairs(owners) do
            if owner == ply then
                isOwner = true
                break
            end
        end
        
        if not isOwner then
            net.Start("AuroraRP_DoorOperationResult")
            net.WriteBool(false)
            net.WriteString("You are not the owner of this door!")
            net.Send(ply)
            return
        end
        
        -- Remove owner
        ent:removeKeys(target)
        
        net.Start("AuroraRP_DoorOperationResult")
        net.WriteBool(true)
        net.WriteString("Removed " .. target:Nick() .. " from door owners!")
        net.Broadcast()
    end)
    
    -- Prevent physgun abuse
    hook.Add("PhysgunPickup", "AuroraRP_PhysgunRestriction", function(ply, ent)
        -- Prevent picking up other players' doors
        if ent:GetClass() == "prop_door_rotating" then
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
                    ply:ChatPrint("[Aurora RP] You cannot pick up doors you don't own!")
                    return false
                end
            end
        end
        
        -- Prevent picking up players
        if ent:IsPlayer() then
            return false
        end
        
        return true
    end)
    
    -- Prevent toolgun abuse on doors
    hook.Add("CanTool", "AuroraRP_ToolgunRestriction", function(ply, trace, tool)
        local ent = trace.Entity
        if IsValid(ent) and ent:GetClass() == "prop_door_rotating" then
            local owners = ent:getKeys()
            if #owners > 0 then
                local isOwner = false
                for _, owner in ipairs(owners) do
                    if owner == ply then
                        isOwner = true
                        break
                    end
                end
                if not isOwner and tool ~= "remover" then
                    ply:ChatPrint("[Aurora RP] You cannot modify doors you don't own!")
                    return false
                end
            end
        end
        return true
    end)
end

-- Chat commands for door management
hook.Add("PlayerSay", "AuroraRP_DoorCommands", function(ply, text)
    local cmd = string.lower(text)
    local trace = ply:GetEyeTrace()
    local ent = trace.Entity
    
    if cmd == "!knock" or cmd == "/knock" then
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            ply:ChatPrint("[Aurora RP] Look at a door to knock!")
            return ""
        end
        
        net.Start("AuroraRP_DoorKnock")
        net.WriteEntity(ent)
        net.SendToServer()
        return ""
    end
    
    if string.find(cmd, "!addowner") or string.find(cmd, "/addowner") then
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            ply:ChatPrint("[Aurora RP] Look at a door to add an owner!")
            return ""
        end
        
        local targetName = string.gsub(text, "!addowner", "")
        targetName = string.gsub(targetName, "/addowner", "")
        targetName = string.trim(targetName)
        
        if targetName == "" then
            ply:ChatPrint("[Aurora RP] Usage: !addowner <player name>")
            return ""
        end
        
        local target = player.GetByName(targetName)
        if not IsValid(target) then
            ply:ChatPrint("[Aurora RP] Player not found!")
            return ""
        end
        
        net.Start("AuroraRP_DoorAddOwner")
        net.WriteEntity(ent)
        net.WritePlayer(target)
        net.SendToServer()
        return ""
    end
    
    if string.find(cmd, "!removeowner") or string.find(cmd, "/removeowner") then
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            ply:ChatPrint("[Aurora RP] Look at a door to remove an owner!")
            return ""
        end
        
        local targetName = string.gsub(text, "!removeowner", "")
        targetName = string.gsub(targetName, "/removeowner", "")
        targetName = string.trim(targetName)
        
        if targetName == "" then
            ply:ChatPrint("[Aurora RP] Usage: !removeowner <player name>")
            return ""
        end
        
        local target = player.GetByName(targetName)
        if not IsValid(target) then
            ply:ChatPrint("[Aurora RP] Player not found!")
            return ""
        end
        
        net.Start("AuroraRP_DoorRemoveOwner")
        net.WriteEntity(ent)
        net.WritePlayer(target)
        net.SendToServer()
        return ""
    end
end)

print("[Aurora RP] Door system loaded!")
