-- Aurora RP - Atmospheric Lighting Enhancement
-- Better lighting for rp_downtown_tits_v2 map

hook.Add("InitPostEntity", "AuroraRP_SetupLighting", function()
    -- Global lighting adjustments
    game.SetTimeScale(1.0)
    
    -- Set ambient light color for atmospheric mood (purple-blue aurora theme)
    render.setAmbientLight(Color(30, 25, 45))
end)

-- Dynamic lighting adjustments based on time of day
hook.Add("Think", "AuroraRP_DynamicLighting", function()
    local hour = tonumber(os.date("%H"))
    
    -- Dawn (5-7 AM) - Warm orange/pink
    if hour >= 5 and hour < 7 then
        render.setAmbientLight(Color(255, 180, 150))
        
    -- Morning (7-11 AM) - Bright white/blue
    elseif hour >= 7 and hour < 11 then
        render.setAmbientLight(Color(200, 220, 255))
        
    -- Afternoon (11 AM - 5 PM) - Neutral bright
    elseif hour >= 11 and hour < 17 then
        render.setAmbientLight(Color(255, 255, 240))
        
    -- Evening (5-8 PM) - Golden hour
    elseif hour >= 17 and hour < 20 then
        render.setAmbientLight(Color(255, 200, 150))
        
    -- Night (8 PM - 5 AM) - Dark blue with aurora tint
    else
        render.setAmbientLight(Color(25, 20, 40))
    end
end)

-- Enhanced street lights
hook.Add("InitPostEntity", "AuroraRP_StreetLights", function()
    timer.Simple(5, function()
        -- Find all light entities and enhance them
        for _, ent in ipairs(ents.FindByClass("light_*")) do
            if IsValid(ent) then
                local brightness = ent:GetBrightness() or 1
                if brightness < 2 then
                    ent:SetBrightness(math.min(brightness * 1.5, 3))
                end
            end
        end
        
        -- Add ambient particles for atmosphere
        if CLIENT then
            -- Create subtle aurora particles
            local particleEffect = util.ParticleTracerEx("spark", 
                Vector(0, 0, 100), 
                Vector(0, 0, 50), 
                true, 
                PARTICLE_ENTITY_ID, 
                0)
        end
    end)
end)

-- Custom environment settings for the map
hook.Add("SetupMove", "AuroraRP_EnvironmentSettings", function(ply, cmd, data)
    if SERVER then
        -- Set fog for atmospheric effect
        game.FogEnable(true)
        game.FogStart(500)
        game.FogEnd(2000)
        game.FogColor(25, 20, 40)
        game.FogMaxDensity(0.8)
    end
end)

print("Aurora RP Lighting System Loaded!")
