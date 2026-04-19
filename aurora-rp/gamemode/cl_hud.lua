-- Aurora RP - HUD System
-- Custom HUD with time, health, armor, hunger, and money

if not CLIENT then return end

local hudColors = {
    primary = Color(138, 43, 226), -- Purple for Aurora theme
    secondary = Color(70, 130, 180), -- Blue
    text = Color(255, 255, 255),
    health = Color(220, 50, 50),
    armor = Color(50, 100, 200),
    hunger = Color(255, 200, 50),
    money = Color(50, 200, 50)
}

-- Draw top-right time display
hook.Add("HUDPaint", "AuroraRP_TimeDisplay", function()
    local width, height = ScrW(), ScrH()
    
    -- Get current time
    local hours = os.date("%H")
    local minutes = os.date("%M")
    
    -- Draw background panel
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(width - 220, 10, 200, 60)
    
    -- Draw border
    draw.RoundedBox(8, width - 220, 10, 200, 60, Color(138, 43, 226, 150))
    
    -- Draw server name
    draw.SimpleText("AURORA RP", "DermaLarge", width - 120, 20, hudColors.primary, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    
    -- Draw time
    draw.SimpleText(hours .. ":" .. minutes, "DermaExtraLarge", width - 120, 40, hudColors.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

-- Draw bottom-left stats
hook.Add("HUDPaint", "AuroraRP_StatsDisplay", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local x, y = 20, ScrH() - 120
    local barWidth = 200
    local barHeight = 25
    local spacing = 5
    
    -- Background panel
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(x - 10, y - 10, barWidth + 140, 120)
    draw.RoundedBox(8, x - 10, y - 10, barWidth + 140, 120, Color(138, 43, 226, 100))
    
    -- Health
    local hp = math.Clamp(ply:Health(), 0, 100)
    draw.RoundedBox(4, x, y, barWidth, barHeight, Color(50, 50, 50))
    draw.RoundedBox(4, x, y, barWidth * (hp / 100), barHeight, hudColors.health)
    draw.SimpleText("HP: " .. hp, "DermaDefault", x + barWidth + 10, y + 2, hudColors.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    
    -- Armor
    y = y + barHeight + spacing
    local armor = math.Clamp(ply:Armor(), 0, 100)
    draw.RoundedBox(4, x, y, barWidth, barHeight, Color(50, 50, 50))
    draw.RoundedBox(4, x, y, barWidth * (armor / 100), barHeight, hudColors.armor)
    draw.SimpleText("Armor: " .. armor, "DermaDefault", x + barWidth + 10, y + 2, hudColors.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    
    -- Hunger (using custom variable or default to 100)
    y = y + barHeight + spacing
    local hunger = ply:getDarkRPVariable("hunger") or 100
    hunger = math.Clamp(hunger, 0, 100)
    draw.RoundedBox(4, x, y, barWidth, barHeight, Color(50, 50, 50))
    draw.RoundedBox(4, x, y, barWidth * (hunger / 100), barHeight, hudColors.hunger)
    draw.SimpleText("Hunger: " .. hunger, "DermaDefault", x + barWidth + 10, y + 2, hudColors.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    
    -- Money
    y = y + barHeight + spacing
    local money = ply:getDarkRPVariable("money") or 0
    draw.RoundedBox(4, x, y, barWidth, barHeight, Color(50, 50, 50))
    draw.SimpleText("$ " .. money, "DermaDefaultBold", x + barWidth + 10, y + 2, hudColors.money, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end)

-- Voice chat indicator
hook.Add("PostRenderVGUI", "AuroraRP_VoiceIndicator", function()
    for _, ply in ipairs(player.GetAll()) do
        if ply ~= LocalPlayer() and IsValid(ply) and ply.AuroraVoiceTime and ply.AuroraVoiceTime > RealTime() then
            local pos = ply:GetPos() + Vector(0, 0, 80)
            local screenPos = pos:ToScreen()
            
            if screenPos.visible then
                surface.SetDrawColor(100, 255, 100, 255)
                surface.DrawCircle(screenPos.x, screenPos.y, 15, 255)
                draw.SimpleText("🎤", "DermaLarge", screenPos.x, screenPos.y - 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
end)

print("[Aurora RP] HUD loaded!")
