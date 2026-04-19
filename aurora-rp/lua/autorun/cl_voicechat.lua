-- Aurora RP - Voice Chat Enhancements
-- Proximity-based voice chat with distance settings

if CLIENT then
    -- Voice chat distance settings
    local voiceDistance = 500 -- Default voice range in units
    
    concommand.Add("aurora_voice_distance", function(ply, cmd, args)
        if #args > 0 then
            local distance = tonumber(args[1])
            if distance and distance >= 100 and distance <= 1000 then
                voiceDistance = distance
                notification.AddLegacy("Дистанция голоса: " .. distance, NOTIFY_GENERIC, 2)
            end
        else
            notification.AddLegacy("Текущая дистанция голоса: " .. voiceDistance, NOTIFY_GENERIC, 2)
        end
    end)
    
    -- Visual indicator for voice chat
    hook.Add("HUDPaint", "AuroraRP_VoiceChatIndicator", function()
        local localPly = LocalPlayer()
        if not IsValid(localPly) then return end
        
        -- Show speaking indicator
        for _, ply in ipairs(player.GetAll()) do
            if ply ~= localPly and IsValid(ply) and ply:IsSpeaking() then
                local dist = localPly:GetPos():Distance(ply:GetPos())
                
                if dist <= voiceDistance then
                    local screenPos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1"))
                    if screenPos then
                        screenPos = screenPos:ToScreen()
                        
                        if screenPos.visible then
                            -- Draw voice indicator above player head
                            local size = 20 * (1 - dist / voiceDistance)
                            local alpha = 255 * (1 - dist / voiceDistance)
                            
                            draw.SimpleText("🎤", "DermaLarge", 
                                screenPos.x, 
                                screenPos.y - 50, 
                                Color(138, 43, 226, alpha), 
                                TEXT_ALIGN_CENTER, 
                                TEXT_ALIGN_BOTTOM)
                        end
                    end
                end
            end
        end
    end)
    
    -- Mute players beyond distance
    hook.Add("Think", "AuroraRP_ProximityVoice", function()
        local localPly = LocalPlayer()
        if not IsValid(localPly) then return end
        
        for _, ply in ipairs(player.GetAll()) do
            if ply ~= localPly and IsValid(ply) then
                local dist = localPly:GetPos():Distance(ply:GetPos())
                
                if dist > voiceDistance then
                    ply:SetMuted(true)
                else
                    ply:SetMuted(false)
                end
            end
        end
    end)
end

if SERVER then
    -- Server-side voice distance enforcement
    util.AddNetworkString("AuroraRP_VoiceDistance")
    
    hook.Add("PlayerCanHearPlayersVoice", "AuroraRP_ProximityVoiceServer", function(listener, talker)
        if not IsValid(listener) or not IsValid(talker) then return false end
        
        local distance = listener:GetPos():Distance(talker:GetPos())
        local maxDistance = 500 -- Maximum voice distance
        
        if distance <= maxDistance then
            -- Calculate volume based on distance (closer = louder)
            local volume = math.max(0, 1 - (distance / maxDistance))
            return true, volume
        end
        
        return false
    end)
end

print("Aurora RP Voice Chat System Loaded!")
