-- Aurora RP - Colors Configuration
-- File: lua/aurora_rp/cl_colors.lua

-- ============================================================================
-- AURORA COLOR PALETTE
-- ============================================================================

AURORA = AURORA or {}
AURORA.COLORS = {
    -- Основные цвета фона
    BACKGROUND_PRIMARY = Color(10, 10, 26),        -- #0A0A1A (глубокий тёмно-синий)
    BACKGROUND_SECONDARY = Color(13, 27, 42),      -- #0D1B2A (тёмно-синий)
    
    -- Акцентные цвета Aurora
    ACCENT_1 = Color(108, 99, 255),                -- #6C63FF (фиолетовый)
    ACCENT_2 = Color(0, 212, 255),                 -- #00D4FF (голубой неон)
    ACCENT_3 = Color(123, 47, 190),                -- #7B2FBE (тёмно-фиолетовый)
    
    -- Свечение
    GLOW = Color(167, 139, 250),                   -- #A78BFA (светло-фиолетовый)
    
    -- Текст
    TEXT_PRIMARY = Color(226, 232, 240),           -- #E2E8F0 (светло-серый)
    TEXT_SECONDARY = Color(148, 163, 184),         -- #94A3B8 (серый)
    
    -- Статусы
    SUCCESS = Color(16, 185, 129),                 -- #10B981 (зелёный)
    DANGER = Color(239, 68, 68),                   -- #EF4444 (красный)
    WARNING = Color(245, 158, 11),                 -- #F59E0B (жёлтый)
    
    -- VIP / Золото
    GOLD = Color(255, 215, 0),                     -- #FFD700 (золотой)
    
    -- Цвета департаментов
    POLICE = Color(59, 130, 246),                  -- #3B82F6 (синий)
    MEDICAL = Color(16, 185, 129),                 -- #10B981 (зелёный)
    TAXI = Color(234, 179, 8),                     -- #EAB308 (жёлтый)
    BUSINESS = Color(124, 58, 237),                -- #7C3AED (пурпурный)
    CRIMINAL = Color(153, 27, 27),                 -- #991B1B (тёмно-красный)
    MAYOR = Color(180, 83, 9),                     -- #B45309 (золотой)
    CITIZEN = Color(156, 163, 175)                 -- #9CA3AF (серый)
}

-- ============================================================================
-- NOTIFICATION COLORS
-- ============================================================================

AURORA.NOTIFY = {
    INFO    = {color = Color(108, 99, 255),  icon = "ℹ️", name = "Информация"},   -- Фиолетовый
    SUCCESS = {color = Color(16, 185, 129),  icon = "✅", name = "Успех"},         -- Зелёный
    WARNING = {color = Color(245, 158, 11),  icon = "⚠️", name = "Предупреждение"}, -- Жёлтый
    ERROR   = {color = Color(239, 68, 68),   icon = "❌", name = "Ошибка"},         -- Красный
    POLICE  = {color = Color(59, 130, 246),  icon = "🚔", name = "Полиция"},       -- Синий
    MEDICAL = {color = Color(16, 185, 129),  icon = "🏥", name = "Медицина"},      -- Зелёный
    MONEY   = {color = Color(234, 179, 8),   icon = "💰", name = "Деньги"},        -- Золотой
    DONATE  = {color = Color(168, 85, 247),  icon = "💎", name = "Донат"}          -- Фиолетовый
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Получить цвет по типу уведомления
function AURORA.GetNotifyColor(type)
    if AURORA.NOTIFY[type] then
        return AURORA.NOTIFY[type].color
    end
    return AURORA.COLORS.TEXT_PRIMARY
end

-- Получить иконку по типу уведомления
function AURORA.GetNotifyIcon(type)
    if AURORA.NOTIFY[type] then
        return AURORA.NOTIFY[type].icon
    end
    return ""
end

-- Градиент Aurora (для использования в draw.Gradient)
function AURORA.CreateGradient(startX, startY, endX, endY)
    return {
        {pos = 0, color = AURORA.COLORS.ACCENT_1},
        {pos = 0.5, color = AURORA.COLORS.ACCENT_2},
        {pos = 1, color = AURORA.COLORS.ACCENT_3}
    }
end

-- Glassmorphism эффект (полупрозрачный фон с размытием)
function AURORA.GlassColor(alpha)
    alpha = alpha or 180
    return Color(13, 27, 42, alpha) -- #0D1B2A с прозрачностью
end

print("[Aurora RP] Colors loaded successfully!")
