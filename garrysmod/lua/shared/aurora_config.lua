-- Aurora RP - Shared Configuration
-- File: lua/shared/aurora_config.lua

AURORA = AURORA or {}

-- ============================================================================
-- SERVER INFORMATION
-- ============================================================================

AURORA.Config = {
    ServerName = "Aurora RP",
    Version = "1.0.0",
    Discord = "discord.gg/aurorarx",
    VK = "vk.com/aurorarx",
    
    -- Настройки карты
    DefaultMap = "rp_downtown_tits_v2",
    MapWorkshopID = "1527403485",
    
    -- Максимальное количество игроков
    MaxPlayers = 64,
    
    -- Язык сервера
    Language = "ru"
}

-- ============================================================================
-- ECONOMY SETTINGS
-- ============================================================================

AURORA.Economy = {
    -- Стартовые настройки
    StartingMoney = 1000,
    PaycheckAmount = 300,
    PaycheckInterval = 300, -- 5 минут в секундах
    
    -- Лимиты
    MaxWalletMoney = 1000000,
    MaxBankMoney = 10000000,
    
    -- Налоги
    TaxEnabled = true,
    DefaultTaxRate = 0, -- 0% по умолчанию
    
    -- Выпадение денег при смерти
    DropMoneyOnDeath = true,
    DropMoneyPercent = 10, -- 10% от наличных
    
    -- Ограбления
    MuggingEnabled = true,
    MuggingCooldown = 300, -- 5 минут
    MuggingAmount = 500    -- Максимум можно украсть
}

-- ============================================================================
-- JOB SETTINGS
-- ============================================================================

AURORA.Jobs = {
    -- Cooldown на смену профессии
    JobSwitchCooldown = 600, -- 10 минут
    
    -- Whitelist требования
    WhitelistEnabled = true,
    
    -- Максимум в банде
    MaxGangMembers = 4,
    
    -- Соотношения профессий (рекомендуемые)
    Ratios = {
        PoliceToCivilian = 0.25,    -- 1 полицейский на 4 гражданских
        CriminalMax = 0.20,         -- Максимум 20% криминала
        MedicMin = 2,               -- Минимум 2 медика при 30+ игроках
        TaxiPerPlayers = 15         -- 1 таксист на 15 игроков
    }
}

-- ============================================================================
-- POLICE SETTINGS
-- ============================================================================

AURORA.Police = {
    -- Арест
    ArrestTime = 120,           -- Стандартное время ареста (2 минуты)
    MaxArrestTime = 600,        -- Максимум 10 минут
    MinArrestTime = 30,         -- Минимум 30 секунд
    
    -- Штрафы
    MaxFine = 10000,            -- Максимальный штраф за раз
    ChiefFineApproval = 5000,   -- Требуется одобрение начальника при штрафе > $5000
    
    -- Оружейная
    ArmoryEnabled = true,
    DailyWeaponLimit = true
}

-- ============================================================================
-- MEDICAL SETTINGS
-- ============================================================================

AURORA.Medical = {
    -- Лечение
    HealingEnabled = true,
    HealingPricePerHP = 5,      -- Цена за 1 HP
    
    -- Скорая помощь
    AmbulanceEnabled = true,
    AmbulanceReward = 500,      -- Вознаграждение за спасение
    AmbulanceResponseTime = 120, -- Время отклика (2 минуты)
    
    -- Аптека
    PharmacyEnabled = true,
    MedkitPrice = 100,          -- Базовая цена аптечки
    BandagePrice = 50           -- Базовая цена бинта
}

-- ============================================================================
-- TAXI SETTINGS
-- ============================================================================

AURORA.Taxi = {
    -- Таксометр
    TaxiMeterEnabled = true,
    TaxiStartPrice = 50,        -- Стартовая сумма
    TaxiPricePerDistance = 10,  -- За каждые 100 юнитов
    TaxiWaitingPrice = 5,       -- За ожидание (30 секунд)
    
    -- Заказы
    TaxiOrdersEnabled = true,
    TaxiOrderTimeout = 120      -- Время жизни заказа
}

-- ============================================================================
-- HUD SETTINGS
-- ============================================================================

AURORA.HUDConfig = {
    Enabled = true,
    Style = "Aurora",
    
    -- Позиции
    MainPanel = {
        x = 20,
        y = -180, -- От низа экрана
        width = 320,
        height = 160
    },
    
    StatusPanel = {
        x = -220, -- От правого края
        y = 20,
        width = 200,
        height = 90
    },
    
    -- Анимации
    AnimationSpeed = 0.3,
    EnableTransitions = true
}

-- ============================================================================
-- NOTIFICATION SETTINGS
-- ============================================================================

AURORA.NotificationConfig = {
    MaxVisible = 5,
    DisplayTime = 4,
    AnimationSpeed = 0.3,
    Position = "top-right"
}

-- ============================================================================
-- VIP SETTINGS (Placeholder)
-- ============================================================================

AURORA.VIP = {
    Enabled = true,
    
    -- Статусы (будут заполнены позже)
    Tiers = {
        VIP = {
            Name = "VIP",
            Icon = "⭐",
            Color = Color(234, 179, 8), -- Жёлтый
            Badge = "[VIP]",
            Price = 0 -- Будет указано позже
        },
        
        VIPPlus = {
            Name = "VIP+",
            Icon = "💎",
            Color = Color(0, 212, 255), -- Голубой
            Badge = "[VIP+]",
            Price = 0 -- Будет указано позже
        },
        
        Premium = {
            Name = "PREMIUM",
            Icon = "👑",
            Color = Color(168, 85, 247), -- Фиолетовый градиент
            Badge = "[PREMIUM]",
            Animated = true,
            Price = 0 -- Будет указано позже
        }
    },
    
    -- Внутренняя валюта
    Currency = {
        Name = "Aurora Coins",
        Symbol = "✦",
        ExchangeRate = 1 -- 1 рубль = 1 монета
    }
}

-- ============================================================================
-- INTEGRATION SETTINGS
-- ============================================================================

AURORA.Integrations = {
    Discord = {
        Enabled = true,
        WebhookURL = "", -- Вставить URL вебхука
        
        -- Логирование событий
        LogEvents = {
            PlayerConnect = true,
            PlayerDisconnect = true,
            JobChange = true,
            Arrests = true,
            Donations = true,
            LargeTransactions = true, -- > $50,000
            AdminActions = true,
            Reports = true
        }
    },
    
    VK = {
        Enabled = true,
        GroupURL = "vk.com/aurorarx"
    }
}

-- ============================================================================
-- ANTI-CHEAT & PROTECTION
-- ============================================================================

AURORA.Protection = {
    -- Защита от пропспама
    PropSpamProtection = true,
    MaxPropsPerPlayer = 50,
    
    -- Защита от кармабомбинга
    KarmaBombProtection = true,
    
    -- Логирование
    LoggingEnabled = true,
    
    -- Steam аутентификация
    SteamAuthRequired = true,
    
    -- Anti-VPN (опционально)
    VPNProtection = false
}

print("[Aurora RP] Shared configuration loaded!")
