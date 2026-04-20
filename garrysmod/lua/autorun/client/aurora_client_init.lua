-- Aurora RP - Client Initialization
-- File: lua/autorun/client/aurora_client_init.lua

print("[Aurora RP] Loading client-side modules...")

-- Load Aurora color system
if file.Exists("aurora_rp/cl_colors.lua", "LUA") then
    include("aurora_rp/cl_colors.lua")
    print("[Aurora RP] Colors loaded")
end

-- Load notification system
if file.Exists("aurora_rp/cl_notifications.lua", "LUA") then
    include("aurora_rp/cl_notifications.lua")
    print("[Aurora RP] Notifications loaded")
end

-- Load HUD system
if file.Exists("aurora_rp/cl_hud.lua", "LUA") then
    include("aurora_rp/cl_hud.lua")
    print("[Aurora RP] HUD loaded")
end

-- Custom font loading
hook.Add("HUDPaint", "AuroraRP_LoadFonts", function()
    -- Загрузка шрифтов (будет вызвано один раз)
    if not AURORA.FontsLoaded then
        -- Основной шрифт
        surface.CreateFont("AuroraTitle", {
            font = "Exo 2",
            size = 32,
            weight = 700,
            antialias = true,
            shadow = true
        })
        
        -- Заголовки
        surface.CreateFont("AuroraHeader", {
            font = "Orbitron",
            size = 24,
            weight = 600,
            antialias = true
        })
        
        -- Основной текст
        surface.CreateFont("AuroraDefault", {
            font = "Roboto",
            size = 16,
            weight = 400,
            antialias = true
        })
        
        -- Акцентный текст
        surface.CreateFont("AuroraAccent", {
            font = "Rajdhani",
            size = 20,
            weight = 600,
            antialias = true
        })
        
        AURORA.FontsLoaded = true
        print("[Aurora RP] Fonts loaded")
    end
    
    hook.Remove("HUDPaint", "AuroraRP_LoadFonts")
end)

-- Welcome message on spawn
hook.Add("PlayerLoadout", "AuroraRP_WelcomeMessage", function()
    timer.Simple(3, function()
        if IsValid(LocalPlayer()) then
            local ply = LocalPlayer()
            if ply:IsFirstTimeSpawn() then
                AURORA.Notify("SUCCESS", "Добро пожаловать в Aurora RP! 🌌", 5)
                AURORA.Notify("INFO", "Нажмите F4 для выбора профессии", 4)
            end
        end
    end)
end)

-- Chat commands help
hook.Add("InitPostEntity", "AuroraRP_ChatCommands", function()
    timer.Simple(5, function()
        if IsValid(LocalPlayer()) then
            chat.AddText(
                Color(108, 99, 255), "[Aurora RP] ",
                Color(226, 232, 240), "Основные команды: "
            )
            chat.AddText(
                Color(255, 255, 255), "/me ",
                Color(200, 200, 200), "- RP действие"
            )
            chat.AddText(
                Color(255, 255, 255), "/ooc ",
                Color(200, 200, 200), "- OOC чат"
            )
            chat.AddText(
                Color(255, 255, 255), "/ad ",
                Color(200, 200, 200), "- Рекламное объявление"
            )
            chat.AddText(
                Color(255, 255, 255), "/helpme ",
                Color(200, 200, 200), "- Вызов помощи"
            )
            chat.AddText(
                Color(255, 255, 255), "F4 ",
                Color(200, 200, 200), "- Меню профессий"
            )
        end
    end)
end)

print("[Aurora RP] Client initialization complete!")
