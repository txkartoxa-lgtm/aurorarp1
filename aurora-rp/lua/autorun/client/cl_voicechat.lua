-- Aurora RP - Client Side Voice Chat
-- Proximity voice chat with visual indicators

if CLIENT then
    AuroraRP = AuroraRP or {}
    AuroraRP.Voice = AuroraRP.Voice or {}

    -- Voice chat indicators
    AuroraRP.Voice.Indicators = AuroraRP.Voice.Indicators or {}

    hook.Add("HUDPaint", "AuroraRP_VoiceIndicators", function()
        for _, ply in ipairs(player.GetAll()) do
            if IsValid(ply) and ply:IsTalking() and ply ~= LocalPlayer() then
                local pos = ply:GetPos() + Vector(0, 0, 80)
                local screenPos = pos:ToScreen()

                if screenPos.visible then
                    local distance = LocalPlayer():GetPos():Distance(pos)
                    local alpha = math.Clamp(255 - (distance / 2), 100, 255)
                    
                    draw.SimpleText("🎤", "DermaLarge", screenPos.x, screenPos.y, 
                        Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end
    end)

    -- Set voice distance
    hook.Add("Initialize", "AuroraRP_SetVoiceDistance", function()
        if AuroraRP.Config and AuroraRP.Config.VoiceDistance then
            RunConsoleCommand("voice_scale", "1")
        end
    end)

    print("[Aurora RP] Voice chat system loaded!")
end
