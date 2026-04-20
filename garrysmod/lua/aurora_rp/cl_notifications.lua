-- Aurora RP - Custom Notification System
-- File: lua/aurora_rp/cl_notifications.lua

AURORA = AURORA or {}
AURORA.Notifications = AURORA.Notifications or {}
AURORA.Notifications.Queue = {}
AURORA.Notifications.MaxVisible = 5
AURORA.Notifications.DisplayTime = 4 -- секунды

-- ============================================================================
-- NOTIFICATION CREATION
-- ============================================================================

function AURORA.Notify(type, text, duration)
    duration = duration or AURORA.Notifications.DisplayTime
    
    local notifyData = {
        type = type or "INFO",
        text = text or "",
        created = SysTime(),
        duration = duration,
        alpha = 0,
        state = "entering" -- entering, visible, exiting
    }
    
    table.insert(AURORA.Notifications.Queue, notifyData)
    
    -- Воспроизвести звук уведомления (если есть)
    if file.Exists("sound/aurora_rp/notification.wav", "GAME") then
        surface.PlaySound("aurora_rp/notification.wav")
    end
end

-- ============================================================================
-- NOTIFICATION RENDERING
-- ============================================================================

local function DrawNotification(notify, x, y, width, height)
    local colors = AURORA.COLORS
    local notifyColors = AURORA.NOTIFY[notify.type] or AURORA.NOTIFY.INFO
    
    local bgColor = Color(colors.BACKGROUND_SECONDARY.r, colors.BACKGROUND_SECONDARY.g, colors.BACKGROUND_SECONDARY.b, 200 * (notify.alpha / 255))
    local accentColor = notifyColors.color
    
    -- Основная панель
    draw.RoundedBoxEx(8, x, y, width, height, bgColor, true, true, false, true)
    
    -- Акцентная полоска слева
    draw.RoundedBox(0, x, y, 4, height, accentColor)
    
    -- Иконка
    local icon = notifyColors.icon or "ℹ️"
    draw.SimpleText(icon, "DermaLarge", x + 20, y + height/2, colors.TEXT_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    -- Текст
    draw.SimpleText(notify.text, "DermaDefault", x + 50, y + height/2, colors.TEXT_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
    -- Прогресс бар времени
    local elapsed = SysTime() - notify.created
    local progress = math.Clamp(1 - (elapsed / notify.duration), 0, 1)
    local barWidth = (width - 60) * progress
    
    draw.RoundedBox(2, x + 30, y + height - 12, width - 60, 4, Color(50, 50, 70, 150))
    draw.RoundedBox(2, x + 30, y + height - 12, barWidth, 4, accentColor)
end

-- ============================================================================
-- NOTIFICATION UPDATE & DRAW
-- ============================================================================

hook.Add("HUDPaint", "AuroraRP_DrawNotifications", function()
    local screenWidth = ScrW()
    local screenHeight = ScrH()
    local notifyWidth = 350
    local notifyHeight = 60
    local spacing = 10
    local rightMargin = 20
    
    local currentTime = SysTime()
    local visibleCount = 0
    
    -- Обработка очереди уведомлений
    for i = #AURORA.Notifications.Queue, 1, -1 do
        local notify = AURORA.Notifications.Queue[i]
        
        if not notify then continue end
        
        local elapsed = currentTime - notify.created
        
        -- Анимация появления
        if notify.state == "entering" then
            notify.alpha = math.Approach(notify.alpha, 255, 255 * FrameTime() * 3)
            if notify.alpha >= 255 then
                notify.state = "visible"
            end
        end
        
        -- Проверка на выход
        if notify.state == "visible" and elapsed >= notify.duration then
            notify.state = "exiting"
        end
        
        -- Анимация исчезновения
        if notify.state == "exiting" then
            notify.alpha = math.Approach(notify.alpha, 0, 255 * FrameTime() * 3)
            if notify.alpha <= 0 then
                table.remove(AURORA.Notifications.Queue, i)
                continue
            end
        end
        
        -- Ограничение количества видимых уведомлений
        if visibleCount >= AURORA.Notifications.MaxVisible then
            continue
        end
        
        -- Позиция уведомления (справа сверху, вниз)
        local yPos = rightMargin + (visibleCount * (notifyHeight + spacing))
        local xPos = screenWidth - notifyWidth - rightMargin
        
        -- Отрисовка
        DrawNotification(notify, xPos, yPos, notifyWidth, notifyHeight)
        
        visibleCount = visibleCount + 1
    end
end)

-- ============================================================================
-- ALIAS FOR COMPATIBILITY
-- ============================================================================

-- Переопределение стандартной функции DarkRP для использования Aurora стиля
local OldDarkRPNotify = DarkRP.notify
function DarkRP.notify(ply, type, duration, text)
    -- Если это клиент (ply это локальный игрок)
    if LocalPlayer() == ply or ply == nil then
        local notifyType = "INFO"
        
        -- Конвертация типов DarkRP в типы Aurora
        if type == 0 then notifyType = "INFO"
        elseif type == 1 then notifyType = "SUCCESS"
        elseif type == 2 then notifyType = "WARNING"
        elseif type == 3 then notifyType = "ERROR"
        elseif type == 4 then notifyType = "POLICE"
        end
        
        AURORA.Notify(notifyType, text, duration)
    end
    
    -- Вызов оригинальной функции (если нужно)
    -- OldDarkRPNotify(ply, type, duration, text)
end

print("[Aurora RP] Notification system loaded successfully!")
