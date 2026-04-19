-- Aurora RP - Client Initialization
-- Loads all client-side modules

if CLIENT then
    include("cl_hud.lua")
    include("cl_jobs_menu.lua")
    include("cl_donate_menu.lua")
    include("cl_thirdperson.lua")
    include("shared.lua")

    print("[Aurora RP] Client initialization complete!")
end
