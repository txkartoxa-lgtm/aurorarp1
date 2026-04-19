-- Aurora RP - HUD System
-- Shows time, health, armor, hunger, and money

if CLIENT then
    local serverName = "AURORA RP"
    
    -- Main HUD Paint
    hook.Add("HUDPaint", "AuroraRP_MainHUD", function()
        local scrW, scrH = ScrW(), ScrH()
        
        -- Top Right: Server Name and Time
        local currentTime = os.date("%H:%M:%S")
        local currentDate = os.date("%d.%m.%Y")
        
        -- Background panel for time
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(scrW - 250, 10, 240, 70)
        
        -- Server Name
        draw.SimpleText(serverName, "DermaLarge", scrW - 130, 20, 
            Color(138, 43, 226), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        
        -- Time
        draw.SimpleText(currentTime, "DermaLarge", scrW - 130, 45, 
            Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        
        -- Date
        draw.SimpleText(currentDate, "DermaDefault", scrW - 130, 65, 
            Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        
        -- Bottom Left: Stats (Health, Armor, Hunger, Money)
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        
        local health = ply:Health()
        local armor = ply:Armor()
        local money = 0
        
        -- Get money from DarkRP
        if LocalPlayer().getDarkRPVar then
            money = LocalPlayer():getDarkRPVar("money") or 0
        end
        
        -- Hunger (simulated, starts at 100)
        local hunger = AuroraRP.Hunger or 100
        
        -- Background panel for stats
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(10, scrH - 120, 280, 110)
        
        -- Health
        draw.SimpleText("Здоровье: " .. health .. "/100", "DermaDefault", 20, scrH - 110, 
            Color(255, 100, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        
        -- Health bar
        surface.SetDrawColor(255, 100, 100, 200)
        surface.DrawRect(20, scrH - 95, math.Clamp(health * 2, 0, 200), 10)
        
        -- Armor
        draw.SimpleText("Броня: " .. armor, "DermaDefault", 20, scrH - 75, 
            Color(100, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        
        -- Armor bar
        surface.SetDrawColor(100, 100, 255, 200)
        surface.DrawRect(20, scrH - 60, math.Clamp(armor * 2, 0, 200), 10)
        
        -- Hunger
        draw.SimpleText("Голод: " .. hunger .. "/100", "DermaDefault", 20, scrH - 45, 
            Color(255, 200, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        
        -- Hunger bar
        surface.SetDrawColor(255, 200, 50, 200)
        surface.DrawRect(20, scrH - 30, math.Clamp(hunger * 2, 0, 200), 10)
        
        -- Money
        draw.SimpleText("Деньги: $" .. money, "DermaDefaultBold", 20, scrH - 15, 
            Color(100, 255, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end)

    -- Initialize hunger system
    hook.Add("Initialize", "AuroraRP_InitHunger", function()
        AuroraRP.Hunger = 100
        
        -- Decrease hunger over time
        timer.Create("AuroraRP_HungerTimer", 60, 0, function()
            if AuroraRP.Hunger and AuroraRP.Hunger > 0 then
                AuroraRP.Hunger = AuroraRP.Hunger - 1
            end
        end)
    end)

    print("[Aurora RP] HUD system loaded!")
end
