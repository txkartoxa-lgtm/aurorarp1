-- Aurora RP - HUD
-- Displays: Time (top right), HP/Armor/Hunger/Money (bottom left)

local hudColors = {
    primary = Color(138, 43, 226), -- Blue Violet for Aurora theme
    secondary = Color(75, 0, 130), -- Indigo
    text = Color(255, 255, 255),
    health = Color(255, 69, 58),
    armor = Color(64, 158, 255),
    hunger = Color(255, 165, 0),
    money = Color(50, 205, 50)
}

-- Draw top-right time display
hook.Add("HUDPaint", "AuroraRP_TimeDisplay", function()
    local width = ScrW()
    local padding = 30
    
    -- Get current server time
    local currentTime = os.date("%H:%M:%S")
    local currentDate = os.date("%d.%m.%Y")
    
    -- Draw background panel
    local timeWidth = 200
    local timeHeight = 60
    local timeX = width - timeWidth - padding
    local timeY = padding
    
    draw.RoundedBoxEx(10, timeX, timeY, timeWidth, timeHeight, Color(0, 0, 0, 200), true, true, false, false)
    
    -- Draw Aurora RP title
    draw.SimpleText("AURORA RP", "DermaLarge", timeX + timeWidth/2, timeY + 10, hudColors.primary, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    
    -- Draw time
    draw.SimpleText(currentTime, "DermaLarge", timeX + timeWidth/2, timeY + 35, hudColors.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    
    -- Draw date below
    draw.SimpleText(currentDate, "DermaDefault", timeX + timeWidth/2, timeY + 55, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

-- Draw bottom-left stats (HP, Armor, Hunger, Money)
hook.Add("HUDPaint", "AuroraRP_StatsDisplay", function()
    local padding = 30
    local boxWidth = 250
    local boxHeight = 120
    local boxX = padding
    local boxY = ScrH() - boxHeight - padding
    
    -- Draw main background
    draw.RoundedBoxEx(10, boxX, boxY, boxWidth, boxHeight, Color(0, 0, 0, 200), false, false, true, true)
    
    -- Draw Aurora RP watermark at bottom
    draw.SimpleText("AURORA RP", "DermaDefault", boxX + boxWidth/2, boxY + boxHeight - 20, hudColors.primary, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    -- Get player stats
    local hp = ply:Health() or 100
    local armor = ply:Armor() or 0
    local money = ply:getDarkRPVar("money") or 5000
    local hunger = ply:getDarkRPVar("hunger") or 100
    
    -- Stats layout
    local statHeight = 25
    local startY = boxY + 10
    
    -- Health
    draw.SimpleText("❤ Здоровье: " .. hp .. "/100", "DermaDefault", boxX + 10, startY, hudColors.health, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(hp .. "%", "DermaDefault", boxX + boxWidth - 10, startY, hudColors.health, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    
    -- Armor
    draw.SimpleText("🛡 Броня: " .. armor, "DermaDefault", boxX + 10, startY + statHeight, hudColors.armor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(armor .. "%", "DermaDefault", boxX + boxWidth - 10, startY + statHeight, hudColors.armor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    
    -- Hunger
    draw.SimpleText("🍖 Голод: " .. hunger .. "/100", "DermaDefault", boxX + 10, startY + statHeight * 2, hudColors.hunger, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(hunger .. "%", "DermaDefault", boxX + boxWidth - 10, startY + statHeight * 2, hudColors.hunger, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    
    -- Money
    draw.SimpleText("💰 Деньги: " .. DarkRP.formatMoney(money), "DermaDefault", boxX + 10, startY + statHeight * 3, hudColors.money, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end)

-- Progress bars for better visualization
hook.Add("HUDPaint", "AuroraRP_ProgressBars", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local padding = 30
    local barWidth = 200
    local barHeight = 8
    local barX = padding + 260
    local barY = ScrH() - 150
    
    local hp = ply:Health() or 100
    local armor = ply:Armor() or 0
    local hunger = ply:getDarkRPVar("hunger") or 100
    
    -- Health bar
    draw.RoundedBox(4, barX, barY, barWidth, barHeight, Color(50, 50, 50, 200))
    draw.RoundedBox(4, barX, barY, barWidth * (hp / 100), barHeight, hudColors.health)
    
    -- Armor bar
    draw.RoundedBox(4, barX, barY + barHeight + 5, barWidth, barHeight, Color(50, 50, 50, 200))
    draw.RoundedBox(4, barX, barY + barHeight + 5, barWidth * (armor / 100), barHeight, hudColors.armor)
    
    -- Hunger bar
    draw.RoundedBox(4, barX, barY + (barHeight + 5) * 2, barWidth, barHeight, Color(50, 50, 50, 200))
    draw.RoundedBox(4, barX, barY + (barHeight + 5) * 2, barWidth * (hunger / 100), barHeight, hudColors.hunger)
end)

print("Aurora RP HUD Loaded!")
