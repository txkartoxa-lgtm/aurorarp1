-- Aurora RP - Client-side Voice Chat
-- Proximity voice chat system

if CLIENT then
    net.Receive("AuroraRP_VoiceIndicator", function()
        local ply = net.ReadPlayer()
        if not IsValid(ply) then return end
        
        -- Show voice indicator above player
        ply.AuroraVoiceTime = RealTime() + 2
    end)
end

-- Hook for voice chat (works with GMod's built-in voice chat)
hook.Add("PlayerStartVoice", "AuroraRP_VoiceStart", function(ply)
    if not IsValid(ply) then return end
    net.Start("AuroraRP_VoiceIndicator")
    net.WritePlayer(ply)
    net.Broadcast()
end)

hook.Add("PlayerEndVoice", "AuroraRP_VoiceEnd", function(ply)
    if IsValid(ply) then
        ply.AuroraVoiceTime = nil
    end
end)

print("[Aurora RP] Voice chat system loaded!")
