-- Aurora RP - Shared Door and Key System
-- Works on both client and server

-- Door purchase command
if SERVER then
    util.AddNetworkString("AuroraRP_BuyDoor")
    util.AddNetworkString("AuroraRP_DoorStatus")
    util.AddNetworkString("AuroraRP_KnockDoor")

    -- Buy door command
    concommand.Add("aurora_buydoor", function(ply, cmd, args)
        if not IsValid(ply) then return end
        
        local trace = ply:GetEyeTrace()
        local ent = trace.Entity
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            DarkRP.notify(ply, 1, 3, "Смотрите на дверь!")
            return
        end
        
        -- Check if door already has an owner
        local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
        if owner then
            DarkRP.notify(ply, 1, 3, "Эта дверь уже куплена!")
            return
        end
        
        -- Check money
        local money = ply:getDarkRPVar("money") or 0
        local doorPrice = AuroraRP.Config.DoorPrice or 500
        
        if money < doorPrice then
            DarkRP.notify(ply, 1, 3, "Недостаточно денег! Нужно $" .. doorPrice)
            return
        end
        
        -- Purchase door
        ply:setDarkRPVar("money", money - doorPrice)
        ent:SetNWEntity("AuroraDoorOwner", ply)
        ent:SetNWString("AuroraDoorCoOwners", "")
        
        DarkRP.notify(ply, 0, 3, "Дверь успешно куплена за $" .. doorPrice .. "!")
        
        -- Send status to all clients
        net.Start("AuroraRP_DoorStatus")
            net.WriteEntity(ent)
            net.WriteEntity(ply)
            net.WriteString("buy")
        net.Broadcast()
    end)

    -- Add owner command
    concommand.Add("aurora_addowner", function(ply, cmd, args)
        if not IsValid(ply) then return end
        
        local trace = ply:GetEyeTrace()
        local ent = trace.Entity
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            DarkRP.notify(ply, 1, 3, "Смотрите на дверь!")
            return
        end
        
        local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
        if owner ~= ply then
            DarkRP.notify(ply, 1, 3, "Это не ваша дверь!")
            return
        end
        
        if not args[1] then
            DarkRP.notify(ply, 1, 3, "Использование: !addowner <имя игрока>")
            return
        end
        
        local targetName = table.concat(args, " ")
        local target = DarkRP.findPlayer(targetName)
        
        if not target then
            DarkRP.notify(ply, 1, 3, "Игрок не найден!")
            return
        end
        
        local coOwners = ent:GetNWString("AuroraDoorCoOwners", "")
        if string.find(coOwners, target:SteamID()) then
            DarkRP.notify(ply, 1, 3, "Этот игрок уже является владельцем!")
            return
        end
        
        ent:SetNWString("AuroraDoorCoOwners", coOwners .. target:SteamID() .. ",")
        DarkRP.notify(ply, 0, 3, target:Nick() .. " добавлен как совладелец двери!")
        DarkRP.notify(target, 0, 3, ply:Nick() .. " добавил вас как совладельца двери!")
    end)

    -- Remove owner command
    concommand.Add("aurora_removeowner", function(ply, cmd, args)
        if not IsValid(ply) then return end
        
        local trace = ply:GetEyeTrace()
        local ent = trace.Entity
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            DarkRP.notify(ply, 1, 3, "Смотрите на дверь!")
            return
        end
        
        local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
        if owner ~= ply then
            DarkRP.notify(ply, 1, 3, "Это не ваша дверь!")
            return
        end
        
        if not args[1] then
            DarkRP.notify(ply, 1, 3, "Использование: !removeowner <имя игрока>")
            return
        end
        
        local targetName = table.concat(args, " ")
        local target = DarkRP.findPlayer(targetName)
        
        if not target then
            DarkRP.notify(ply, 1, 3, "Игрок не найден!")
            return
        end
        
        local coOwners = ent:GetNWString("AuroraDoorCoOwners", "")
        local newCoOwners = string.gsub(coOwners, target:SteamID() .. ",", "")
        ent:SetNWString("AuroraDoorCoOwners", newCoOwners)
        
        DarkRP.notify(ply, 0, 3, target:Nick() .. " удалён из владельцев двери!")
        DarkRP.notify(target, 1, 3, ply:Nick() .. " удалил вас из владельцев двери!")
    end)

    -- Knock on door
    concommand.Add("aurora_knock", function(ply, cmd, args)
        if not IsValid(ply) then return end
        
        local trace = ply:GetEyeTrace()
        local ent = trace.Entity
        
        if not IsValid(ent) or ent:GetClass() ~= "prop_door_rotating" then
            DarkRP.notify(ply, 1, 3, "Смотрите на дверь!")
            return
        end
        
        local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
        if not owner then
            DarkRP.notify(ply, 1, 3, "У этой двери нет владельца!")
            return
        end
        
        -- Notify the owner
        DarkRP.notify(owner, 0, 3, ply:Nick() .. " стучится в вашу дверь!")
        
        -- Play knock sound
        ent:EmitSound("physics/wood/wood_solid_impact_hard2.wav")
    end)
end

-- Client-side door system
if CLIENT then
    net.Receive("AuroraRP_DoorStatus", function()
        local ent = net.ReadEntity()
        local owner = net.ReadEntity()
        local action = net.ReadString()
        
        if IsValid(ent) then
            if action == "buy" then
                -- Show notification
                notification.AddLegacy("Дверь куплена!", NOTIFY_GENERIC, 3)
            end
        end
    end)

    -- E key to interact with doors
    hook.Add("PlayerBindPress", "AuroraRP_DoorInteraction", function(ply, bind, pressed)
        if not pressed then return end
        
        if bind == "+use" then
            local trace = ply:GetEyeTrace()
            local ent = trace.Entity
            
            if IsValid(ent) and ent:GetClass() == "prop_door_rotating" then
                local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
                
                if not owner then
                    -- Prompt to buy
                    chat.AddText(Color(138, 43, 226), "[Aurora RP] ", Color(255, 255, 255), 
                        "Нажмите F4 чтобы купить эту дверь за $", AuroraRP.Config.DoorPrice or 500)
                end
            end
        end
    end)

    -- F4 to buy door
    hook.Add("Think", "AuroraRP_BuyDoorKey", function()
        if input.IsKeyDown(KEY_F4) then
            local ply = LocalPlayer()
            local trace = ply:GetEyeTrace()
            local ent = trace.Entity
            
            if IsValid(ent) and ent:GetClass() == "prop_door_rotating" then
                local owner = ent:GetNWEntity("AuroraDoorOwner", nil)
                
                if not owner then
                    RunConsoleCommand("aurora_buydoor")
                end
            end
        end
    end)
end

print("[Aurora RP] Door and key system loaded!")
