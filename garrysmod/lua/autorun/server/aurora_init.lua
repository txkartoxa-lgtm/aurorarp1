-- Aurora RP - Server Initialization
-- File: lua/autorun/server/aurora_init.lua

-- Aurora RP Version
AURORA_VERSION = "1.0.0"

-- Server Information
AURORA_SERVER_NAME = "Aurora RP"
AURORA_DISCORD = "discord.gg/aurorarx"
AURORA_VK = "vk.com/aurorarx"

print("[Aurora RP] Initializing server...")
print("[Aurora RP] Version: " .. AURORA_VERSION)
print("[Aurora RP] Server Name: " .. AURORA_SERVER_NAME)

-- Load configuration files
if file.Exists("darkrp_config/configuration.lua", "GAME") then
    print("[Aurora RP] Loading DarkRP configuration...")
    include("darkrp_config/configuration.lua")
end

-- Custom initialization for Aurora RP
hook.Add("Initialize", "AuroraRP_Initialize", function()
    print("[Aurora RP] Server initialized successfully!")
    
    -- Set hostname
    RunConsoleCommand("hostname", AURORA_SERVER_NAME .. " | Реалистичный DarkRP | 18+")
end)

-- Player connect logging
hook.Add("PlayerInitialSpawn", "AuroraRP_PlayerConnect", function(ply)
    local steamID = ply:SteamID()
    local name = ply:Nick()
    local ip = ply:IPAddress()
    
    print("[Aurora RP] Player connected: " .. name .. " (" .. steamID .. ")")
    
    -- Welcome message
    timer.Simple(5, function()
        if IsValid(ply) then
            DarkRP.notify(ply, 1, 4, "Добро пожаловать в " .. AURORA_SERVER_NAME .. "!")
            DarkRP.notify(ply, 0, 4, "Используйте F4 для выбора профессии.")
            DarkRP.notify(ply, 0, 4, "Твоя история начинается в Aurora 🌌")
        end
    end)
end)

-- Player disconnect logging
hook.Add("PlayerDisconnected", "AuroraRP_PlayerDisconnect", function(ply)
    local steamID = ply:SteamID()
    local name = ply:Nick()
    
    print("[Aurora RP] Player disconnected: " .. name .. " (" .. steamID .. ")")
end)

-- Job change logging
hook.Add("OnPlayerChangedTeam", "AuroraRP_JobChange", function(ply, oldTeam, newTeam)
    local oldJob = team.GetName(oldTeam) or "Безработный"
    local newJob = team.GetName(newTeam) or "Неизвестно"
    local name = ply:Nick()
    
    print("[Aurora RP] " .. name .. " сменил профессию: " .. oldJob .. " → " .. newJob)
end)

-- Server performance settings
RunConsoleCommand("sv_minrate", "0")
RunConsoleCommand("sv_maxrate", "100000")
RunConsoleCommand("sv_minupdaterate", "10")
RunConsoleCommand("sv_maxupdaterate", "66")
RunConsoleCommand("sv_mincmdrate", "10")
RunConsoleCommand("sv_maxcmdrate", "66")
RunConsoleCommand("sv_cheats", "0")
RunConsoleCommand("sv_allowcslua", "0")
RunConsoleCommand("sv_kickerrornum", "1")

print("[Aurora RP] Performance settings configured")
print("[Aurora RP] Security settings configured")
