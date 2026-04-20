-- Aurora RP - Custom Props Configuration
-- File: lua/autorun/server/aurora_props.lua

print("[Aurora RP] Loading custom props configuration...")

-- ============================================================================
-- AURORA DECORATIVE PROPS
-- ============================================================================

-- Прописываем кастомные пропсы для украшения карты
-- Эти пропсы будут добавлены через аддон или вручную в карте

AURORA = AURORA or {}
AURORA.Props = {
    -- Полицейский участок (декорации)
    PoliceStation = {
        "props/cs_office/computer_monitor.mdl",
        "props/cs_office/computer_keyboard.mdl",
        "props/cs_office/computer_mouse.mdl",
        "props/cs_office/sofa_leather.mdl",
        "props/cs_office/desk.mdl",
        "props/cs_office/file_cabinet.mdl",
        "props/cs_office/paper_towel_dispenser.mdl",
        "props/de_nuke/security_station.mdl",
        "models/props_c17/furnitureCouch001a.mdl",
        "models/props_c17/filingcabinet001a.mdl",
        "models/props_c17/desktop001a.mdl",
        "models/props_c17/desktop002a.mdl"
    },
    
    -- Больница (декорации)
    Hospital = {
        "models/props_c17/furnituremattress001a.mdl",
        "models/props_c17/furnituredresser001a.mdl",
        "models/props_c17/furniturechair001a.mdl",
        "models/props_c17/furnituretable001a.mdl",
        "models/props_lab/hazardlightbarrel001.mdl",
        "models/props_lab/cabinet.mdl",
        "models/props_lab/glass_tube01a.mdl",
        "models/items/healthkit.mdl",
        "models/items/healthvial.mdl",
        "models/weapons/w_eq_syringe_medieval_thrown.mdl"
    },
    
    -- Такси стоянка (декорации)
    TaxiStand = {
        "models/props_c17/metalladder001.mdl",
        "models/props_c17/oildrum001.mdl",
        "models/props_junk/trafficcone001a.mdl",
        "models/props_junk/sign_traffic01.mdl",
        "models/props_junk/sign_traffic02.mdl",
        "models/props_junk/sign_traffic03.mdl",
        "models/props_junk/sign_traffic04.mdl",
        "models/props_interiors/vending_machine_soda01a.mdl",
        "models/props_wasteland/controlroom_filecabinet001a.mdl",
        "models/props_wasteland/controlroom_filecabinet002a.mdl"
    },
    
    -- Бизнес центры (декорации)
    Business = {
        "models/props_c17/furniturecouch002a.mdl",
        "models/props_c17/furnituretable002a.mdl",
        "models/props_c17/furniturechair002a.mdl",
        "models/props_c17/desktop003a.mdl",
        "models/props_c17/desktop004a.mdl",
        "models/props_interiors/vending_machine01a.mdl",
        "models/props_interiors/vending_machine_soda01a.mdl",
        "models/props_wasteland/kitchen_fridge001a.mdl",
        "models/props_wasteland/kitchen_stove001a.mdl"
    },
    
    -- Городские декорации (общие)
    CityDecor = {
        "models/props_junk/trashdumpster01a.mdl",
        "models/props_junk/trashdumpster01b.mdl",
        "models/props_junk/trashcan001a.mdl",
        "models/props_junk/newspaper001a.mdl",
        "models/props_junk/cardboard_box004a.mdl",
        "models/props_junk/cardboard_box001a.mdl",
        "models/props_junk/plasticbucket001a.mdl",
        "models/props_junk/metalbucket001a.mdl",
        "models/props_c17/bollard.mdl",
        "models/props_c17/pole02a.mdl",
        "models/props_c17/pole03a.mdl",
        "models/props_street/streetlight001.mdl",
        "models/props_street/streetlight002.mdl",
        "models/props_street/traffic_light01.mdl",
        "models/props_street/traffic_light02.mdl",
        "models/props_street/sign_stop.mdl",
        "models/props_street/sign_yield.mdl"
    }
}

-- ============================================================================
-- SPAWN POINTS CONFIGURATION
-- ============================================================================

-- Точки спавна для профессий (координаты для rp_downtown_tits_v2)
AURORA.SpawnPoints = {
    -- Полиция
    Police = {
        Vector(0, 0, 0),      -- Замените на реальные координаты
        Vector(0, 0, 0),
        Vector(0, 0, 0)
    },
    
    -- Медики
    Medic = {
        Vector(0, 0, 0),      -- Замените на реальные координаты
        Vector(0, 0, 0)
    },
    
    -- Такси
    Taxi = {
        Vector(0, 0, 0),      -- Замените на реальные координаты
        Vector(0, 0, 0),
        Vector(0, 0, 0)
    }
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Функция для получения случайного пропа из списка
function AURORA.GetRandomProp(category)
    if AURORA.Props[category] and #AURORA.Props[category] > 0 then
        return table.Random(AURORA.Props[category])
    end
    return nil
end

-- Функция для проверки существования модели
function AURORA.ValidateModel(model)
    local util = util
    local result = util.IsValidModel(model)
    return result
end

-- Автоматическая настройка зон (требует ручной настройки координат)
hook.Add("InitPostEntity", "AuroraRP_SetupZones", function()
    print("[Aurora RP] Setting up custom zones...")
    
    -- Здесь можно добавить автоматическую расстановку пропсов
    -- Пример:
    -- timer.Simple(5, function()
    --     for _, model in ipairs(AURORA.Props.CityDecor) do
    --         if AURORA.ValidateModel(model) then
    --             local prop = ents.Create("prop_physics")
    --             prop:SetPos(Vector(0, 0, 0)) -- Замените на координаты
    --             prop:SetModel(model)
    --             prop:Spawn()
    --         end
    --     end
    -- end)
    
    print("[Aurora RP] Zones configured (manual setup required)")
end)

print("[Aurora RP] Custom props configuration loaded!")
print("[Aurora RP] Note: Spawn points require manual coordinate setup for rp_downtown_tits_v2")
