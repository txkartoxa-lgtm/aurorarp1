-- Aurora RP - Configuration File
-- Server settings and customization options

AuroraRP = AuroraRP or {}

-- General Settings
AuroraRP.Config = {
    -- Server name displayed in menus
    ServerName = "Aurora RP",
    
    -- Default player settings
    DefaultMoney = 5000,
    DefaultHealth = 100,
    DefaultArmor = 0,
    DefaultHunger = 100,
    
    -- Third person settings
    ThirdPersonEnabled = true,
    ThirdPersonDistance = 100,
    ThirdPersonHeight = 50,
    
    -- Voice chat settings
    VoiceChatDistance = 500,
    VoiceChatEnabled = true,
    
    -- Door system settings
    MaxDoorsPerPlayer = 10,
    DoorPriceMultiplier = 1.0,
    
    -- Job settings
    MaxPolice = 10,
    MaxMedics = 5,
    MayorSalary = 1000,
    
    -- Hunger system
    HungerEnabled = true,
    HungerDecayRate = 0.5, -- Hunger lost per second
    
    -- Lighting
    AtmosphericLighting = true,
    DynamicTimeOfDay = true,
    
    -- Anti-cheat
    PreventDoorStealing = true,
    SafePhysGun = true,
    SafeGravGun = true,
    RestrictNocollide = true
}

-- Custom colors for UI
AuroraRP.Colors = {
    Primary = Color(138, 43, 226),   -- Blue Violet
    Secondary = Color(75, 0, 130),    -- Indigo
    Accent = Color(147, 112, 219),    -- Medium Purple
    Success = Color(50, 205, 50),     -- Lime Green
    Danger = Color(255, 69, 58),      -- Red
    Warning = Color(255, 165, 0),     -- Orange
    Info = Color(64, 158, 255)        -- Blue
}

-- Donation items (configure later with actual items)
AuroraRP.DonateItems = {
    VIP = {
        price = 100,
        currency = "RUB",
        benefits = {"VIP чат", "Доступ к VIP зоне", "+10% к зарплате"}
    },
    VIPPremium = {
        price = 250,
        currency = "RUB",
        benefits = {"Все benefits VIP", "Уникальный скин", "Приоритет в очереди"}
    },
    VIPElite = {
        price = 500,
        currency = "RUB",
        benefits = {"Все benefits Premium", "Админ команды", "Свой ник в списке спонсоров"}
    }
}

-- Map workshop ID
AuroraRP.MapWorkshopID = "1527403485"
AuroraRP.MapName = "rp_downtown_tits_v2"

print("Aurora RP Configuration Loaded!")
