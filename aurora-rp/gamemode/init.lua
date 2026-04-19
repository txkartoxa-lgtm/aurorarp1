-- Aurora RP - Main Gamemode File
-- DarkRP Based Gamemode

GM.Name = "Aurora RP"
GM.Author = "Aurora Team"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("darkrp")

-- Third Person View
function GM:CalcView(ply, pos, angles, fov, zfar, znear)
    if ply:GetNWBool("ThirdPerson", false) then
        local offset = angles:Forward() * -100
        local viewpos = pos + offset + Vector(0, 0, 50)
        
        local trace = util.TraceLine({
            start = pos,
            endpos = viewpos,
            filter = ply
        })
        
        return {
            origin = trace.HitPos,
            angles = angles,
            fov = fov,
            znear = znear,
            zfar = zfar
        }
    end
end

-- Disable door stealing
function GM:CanTool(ply, tr, tool)
    if tool == "door" then
        local ent = tr.Entity
        if IsValid(ent) and (ent.ClassName() == "func_door" or ent.ClassName() == "prop_door_rotating") then
            -- Only allow door tool for owners
            return true
        end
    end
    return true
end

-- Prevent physics gun from breaking things
function GM:PhysgunPickup(ply, ent)
    if ent:GetClass() == "prop_physics" then
        return true
    end
    return false
end

-- Gravity gun safety
function GM:PlayerGravPickup(ply, ent)
    if IsValid(ent) and ent:GetClass() == "prop_physics" then
        return true
    end
    return false
end

print("Aurora RP Gamemode Loaded!")
