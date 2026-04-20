-- Aurora RP - Custom HUD System
-- File: lua/aurora_rp/cl_hud.lua

AURORA = AURORA or {}
AURORA.HUD = AURORA.HUD or {}

-- ============================================================================
-- HUD CONFIGURATION
-- ============================================================================

AURORA.HUD.Enabled = true
AURORA.HUD.Position = {x = 20, y = ScrH() - 180} -- Левый нижний угол
AURORA.HUD.Size = {width = 320, height = 160}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

local function DrawGlassPanel(x, y, w, h, alpha)
    alpha = alpha or 180
    local bgColor = Color(13, 27, 42, alpha) -- #0D1B2A с прозрачностью
    
    -- Основной фон
    draw.RoundedBoxEx(12, x, y, w, h, bgColor, true, true, true, true)
    
    -- Градиентная рамка (Aurora эффект)
    local borderSize = 2
    local gradientColors = {
        {pos = 0, color = AURORA.COLORS.ACCENT_1},
        {pos = 0.5, color = AURORA.COLORS.ACCENT_2},
        {pos = 1, color = AURORA.COLORS.ACCENT_3}
    }
    
    -- Верхняя граница
    draw.RoundedBoxEx(borderSize, x, y, w, borderSize, AURORA.COLORS.ACCENT_1, true, true, false, false)
    -- Нижняя граница
    draw.RoundedBoxEx(borderSize, x, y + h - borderSize, w, borderSize, AURORA.COLORS.ACCENT_3, false, false, true, true)
    -- Левая граница
    draw.RoundedBoxEx(borderSize, x, y, borderSize, h, AURORA.COLORS.ACCENT_1, true, false, false, true)
    -- Правая граница
    draw.RoundedBoxEx(borderSize, x + w - borderSize, y, borderSize, h, AURORA.COLORS.ACCENT_2, false, true, true, false)
end

local function DrawProgressBar(x, y, w, h, current, max, color)
    local percent = math.Clamp(current / max, 0, 1)
    local barWidth = (w - 20) * percent
    
    -- Фон прогресс бара
    draw.RoundedBox(4, x, y, w - 20, h, Color(50, 50, 70, 150))
    
    -- Прогресс
    draw.RoundedBox(4, x, y, barWidth, h, color)
    
    -- Текст с числами
    draw.SimpleText(current .. "/" .. max, "DermaDefault", x + w - 10, y + h/2, AURORA.COLORS.TEXT_PRIMARY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

local function GetJobColor(ply)
    if not IsValid(ply) then return AURORA.COLORS.CITIZEN end
    
    local teamIndex = ply:Team()
    local teamData = team.GetData(teamIndex)
    
    if teamData and teamData.color then
        return teamData.color
    end
    
    return AURORA.COLORS.CITIZEN
end

-- ============================================================================
-- MAIN HUD DRAWING
-- ============================================================================

hook.Add("HUDPaint", "AuroraRP_DrawHUD", function()
    if not AURORA.HUD.Enabled then return end
    
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() then return end
    
    local colors = AURORA.COLORS
    local hudX = AURORA.HUD.Position.x
    local hudY = AURORA.HUD.Position.y
    local hudW = AURORA.HUD.Size.width
    local hudH = AURORA.HUD.Size.height
    
    -- Основная панель
    DrawGlassPanel(hudX, hudY, hudW, hudH, 200)
    
    -- Заголовок с именем и профессией
    local playerName = ply:Nick()
    local jobName = team.GetName(ply:Team()) or "Безработный"
    local jobColor = GetJobColor(ply)
    
    draw.SimpleText("AURORA RP", "DermaLarge", hudX + 60, hudY + 15, colors.ACCENT_1, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(playerName, "DermaDefault", hudX + 60, hudY + 35, colors.TEXT_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    
    -- Профессия с цветной меткой
    surface.SetDrawColor(jobColor)
    draw.RoundedBox(4, hudX + 60, hudY + 50, 8, 8)
    draw.SimpleText(jobName, "DermaDefault", hudX + 75, hudY + 54, colors.TEXT_SECONDARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    
    -- Разделительная линия
    surface.SetDrawColor(Color(255, 255, 255, 30))
    draw.RoundedBox(2, hudX + 15, hudY + 65, hudW - 30, 1)
    
    -- Здоровье
    local hp = ply:Health()
    local hpColor = hp > 50 and colors.SUCCESS or (hp > 25 and colors.WARNING or colors.DANGER)
    DrawProgressBar(hudX + 15, hudY + 80, 140, 16, hp, 100, hpColor)
    draw.SimpleText("❤️", "DermaDefault", hudX + 15, hudY + 88, colors.TEXT_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
    -- Броня
    local armor = ply:Armor()
    DrawProgressBar(hudX + 15, hudY + 105, 140, 16, armor, 100, colors.ACCENT_2)
    draw.SimpleText("🛡️", "DermaDefault", hudX + 15, hudY + 113, colors.TEXT_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
    -- Деньги (справа внизу)
    local money = DarkRP.getMoney(ply) or 0
    local formattedMoney = string.format("$%s", string.NumberFormatted(money))
    
    draw.SimpleText(formattedMoney, "DermaLarge", hudX + hudW - 20, hudY + hudH - 50, colors.GOLD, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    
    -- Зарплата таймер
    local nextPay = GAMEMODE.Config.paychecktimer - (CurTime() % GAMEMODE.Config.paychecktimer)
    local minutes = math.floor(nextPay / 60)
    local seconds = math.floor(nextPay % 60)
    local payTimer = string.format("%d:%02d", minutes, seconds)
    
    draw.SimpleText("⏰ Зарплата: " .. payTimer, "DermaDefault", hudX + hudW - 20, hudY + hudH - 25, colors.TEXT_SECONDARY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end)

-- ============================================================================
-- STATUS PANEL (Правый верхний угол)
-- ============================================================================

hook.Add("HUDPaint", "AuroraRP_DrawStatusPanel", function()
    if not AURORA.HUD.Enabled then return end
    
    local colors = AURORA.COLORS
    local panelX = ScrW() - 220
    local panelY = 20
    local panelW = 200
    local panelH = 90
    
    -- Основная панель
    DrawGlassPanel(panelX, panelY, panelW, panelH, 180)
    
    -- Онлайн игроков
    local players = player.GetCount()
    local maxPlayers = game.MaxPlayers()
    draw.SimpleText("🔵 Онлайн: " .. players .. "/" .. maxPlayers, "DermaDefault", panelX + panelW/2, panelY + 20, colors.TEXT_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    -- Время
    local hours = os.date("%H")
    local minutes = os.date("%M")
    draw.SimpleText("📅 " .. hours .. ":" .. minutes, "DermaDefault", panelX + panelW/2, panelY + 45, colors.TEXT_SECONDARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    -- Карта
    local mapName = game.GetMap()
    draw.SimpleText("🗺️ " .. mapName, "DermaDefault", panelX + panelW/2, panelY + 70, colors.TEXT_SECONDARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

-- ============================================================================
-- LOW HEALTH WARNING (Пульсация при низком HP)
-- ============================================================================

hook.Add("HUDPaint", "AuroraRP_LowHealthWarning", function()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() then return end
    
    local hp = ply:Health()
    if hp > 25 then return end
    
    -- Пульсация
    local pulse = math.sin(CurTime() * 5) * 0.5 + 0.5
    local alpha = 50 + (pulse * 100)
    
    screen.DrawEffect("effects/combine_binocoverlay", {
        size = 1 - (hp / 100),
        overlayalpha = alpha / 255
    })
    
    -- Красная виньетка
    local gradient = Material("vgui/gradient-l")
    surface.SetMaterial(gradient)
    surface.SetDrawColor(255, 0, 0, alpha)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
end)

print("[Aurora RP] HUD system loaded successfully!")
