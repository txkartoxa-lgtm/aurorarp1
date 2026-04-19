-- Aurora RP - Client Initialization
-- HUD, Menus, and Third Person Toggle

include("cl_hud.lua")
include("cl_jobs_menu.lua")
include("cl_donate_menu.lua")
include("cl_thirdperson.lua")

-- Enable third person by default
hook.Add("InitPostEntity", "AuroraRP_ThirdPersonInit", function()
    RunConsoleCommand("aurora_thirdperson", "1")
end)

print("Aurora RP Client Loaded!")
