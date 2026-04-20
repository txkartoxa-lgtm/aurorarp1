-- Aurora RP - Jobs Configuration
-- File: lua/darkrp_customthings/jobs.lua

AddExtraLanguage("ru", {
    ["Citizen"] = "Гражданин",
    ["Police Officer"] = "Полицейский",
    ["Senior Officer"] = "Старший полицейский",
    ["Police Chief"] = "Начальник полиции",
    ["SWAT Operative"] = "SWAT Оперативник",
    ["Paramedic"] = "Врач скорой помощи",
    ["Doctor"] = "Врач",
    ["Head Doctor"] = "Главный врач",
    ["Taxi Driver"] = "Таксист",
    ["Taxi Dispatcher"] = "Старший диспетчер такси",
    ["Businessman"] = "Бизнесмен",
    ["Gangster"] = "Бандит",
    ["Mayor"] = "Мэр города"
})

-- ============================================================================
-- ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ
-- ============================================================================

TEAM_POLICE = AddExtraTeam("Police Officer", {
    color = Color(59, 130, 246), -- Синий (#3B82F6)
    model = {"models/player/police.mdl"},
    description = [[Защитник порядка в городе Aurora. Патрулируй улицы, 
арестовывай преступников, обеспечивай безопасность граждан.]],
    weapons = {"arrest_stick", "unarrest_stick", "weapon_pistol", "stunstick", "weapon_cuff_police"},
    command = "police",
    max = 6,
    salary = 2500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Полиция",
    spawnMoney = 3000
})

TEAM_SENIOR_POLICE = AddExtraTeam("Senior Officer", {
    color = Color(29, 78, 216), -- Тёмно-синий (#1D4ED8)
    model = {"models/player/police.mdl"},
    description = [[Опытный офицер с расширенными полномочиями и лучшим снаряжением.]],
    weapons = {"arrest_stick", "unarrest_stick", "weapon_pistol", "weapon_smg1", "stunstick"},
    command = "senior",
    max = 3,
    salary = 3500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Полиция",
    spawnMoney = 5000,
    NeedToKnowFrom = {TEAM_POLICE}, -- Требует опыта работы полицейским
    whitelist = true
})

TEAM_CHIEF = AddExtraTeam("Police Chief", {
    color = Color(30, 58, 138), -- Тёмно-синий (#1E3A8A)
    model = {"models/player/police.mdl"},
    description = [[Глава полицейского департамента Aurora. Координируй операции,
управляй офицерами, устанавливай законы города.]],
    weapons = {"arrest_stick", "unarrest_stick", "weapon_pistol", "weapon_shotgun", "stunstick"},
    command = "chief",
    max = 1,
    salary = 5000,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Полиция",
    spawnMoney = 10000,
    mayor = false,
    chief = true,
    whitelist = true
})

TEAM_SWAT = AddExtraTeam("SWAT Operative", {
    color = Color(17, 24, 39), -- Чёрный (#111827)
    model = {"models/player/Group01/male_07.mdl"},
    description = [[Элитный отряд быстрого реагирования. Штурм, зачистка, 
нейтрализация особо опасных преступников.]],
    weapons = {"weapon_pistol", "weapon_shotgun", "weapon_smg1", "stunstick"},
    command = "swat",
    max = 3,
    salary = 4000,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Полиция",
    spawnMoney = 7000,
    whitelist = true
})

-- ============================================================================
-- МЕДИЦИНСКИЙ ДЕПАРТАМЕНТ
-- ============================================================================

TEAM_PARAMEDIC = AddExtraTeam("Paramedic", {
    color = Color(248, 250, 252), -- Белый (#F8FAFC)
    model = {"models/player/Group01/male_02.mdl"},
    description = [[Первая медицинская помощь на улицах Aurora. 
Выезжай на вызовы, спасай жизни горожан.]],
    weapons = {"weapon_medkit"},
    command = "paramedic",
    max = 4,
    salary = 2500,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Медицина",
    spawnMoney = 2500,
    medic = true
})

TEAM_DOCTOR = AddExtraTeam("Doctor", {
    color = Color(16, 185, 129), -- Зелёный (#10B981)
    model = {"models/player/Group01/male_04.mdl"},
    description = [[Квалифицированный медицинский специалист больницы Aurora.
Лечи пациентов, продавай лекарства, проводи операции.]],
    weapons = {"weapon_medkit"},
    command = "doctor",
    max = 3,
    salary = 3000,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Медицина",
    spawnMoney = 5000,
    medic = true,
    headMedic = false
})

TEAM_HEAD_DOCTOR = AddExtraTeam("Head Doctor", {
    color = Color(5, 150, 105), -- Ярко-зелёный (#059669)
    model = {"models/player/Group01/male_04.mdl"},
    description = [[Руководитель медицинского департамента. Управляй больницей,
обучай персонал, устанавливай цены на медуслуги.]],
    weapons = {"weapon_medkit"},
    command = "headdoctor",
    max = 1,
    salary = 4500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Медицина",
    spawnMoney = 8000,
    medic = true,
    headMedic = true,
    whitelist = true
})

-- ============================================================================
-- ТРАНСПОРТНЫЙ ДЕПАРТАМЕНТ
-- ============================================================================

TEAM_TAXI = AddExtraTeam("Taxi Driver", {
    color = Color(234, 179, 8), -- Жёлтый (#EAB308)
    model = {"models/player/Group01/male_06.mdl"},
    description = [[Профессиональный водитель такси Aurora. Развози клиентов 
по городу, зарабатывай на чаевых, знай каждый переулок.]],
    weapons = {},
    command = "taxi",
    max = 5,
    salary = 1500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Транспорт",
    spawnMoney = 2000
})

TEAM_DISPATCHER = AddExtraTeam("Taxi Dispatcher", {
    color = Color(217, 119, 6), -- Золотой (#D97706)
    model = {"models/player/Group01/male_06.mdl"},
    description = [[Координируй всех таксистов города, распределяй заказы,
управляй автопарком Aurora Taxi.]],
    weapons = {},
    command = "dispatcher",
    max = 1,
    salary = 2500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Транспорт",
    spawnMoney = 3000
})

-- ============================================================================
-- ГРАЖДАНСКИЕ ПРОФЕССИИ
-- ============================================================================

TEAM_CITIZEN = AddExtraTeam("Citizen", {
    color = Color(156, 163, 175), -- Серый (#9CA3AF)
    model = {
        "models/player/Group01/male_01.mdl",
        "models/player/Group01/male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/male_04.mdl",
        "models/player/Group01/male_05.mdl",
        "models/player/Group01/male_06.mdl",
        "models/player/Group01/male_07.mdl",
        "models/player/Group01/male_08.mdl",
        "models/player/Group01/male_09.mdl",
        "models/player/Group01/female_01.mdl",
        "models/player/Group01/female_02.mdl",
        "models/player/Group01/female_03.mdl",
        "models/player/Group01/female_04.mdl",
        "models/player/Group01/female_05.mdl",
        "models/player/Group01/female_06.mdl",
        "models/player/Group01/female_07.mdl"
    },
    description = [[Обычный житель города Aurora. Начни свой путь с нуля.]],
    weapons = {},
    command = "citizen",
    max = 0, -- Без ограничений
    salary = 500,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Гражданские",
    spawnMoney = 1000
})

TEAM_BUSINESSMAN = AddExtraTeam("Businessman", {
    color = Color(124, 58, 237), -- Пурпурный (#7C3AED)
    model = {"models/player/Group01/male_03.mdl"},
    description = [[Успешный предприниматель Aurora. Открывай магазины,
торгуй ресурсами, строй бизнес-империю.]],
    weapons = {},
    command = "businessman",
    max = 5,
    salary = 2000,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Бизнес",
    spawnMoney = 15000
})

TEAM_GANGSTER = AddExtraTeam("Gangster", {
    color = Color(153, 27, 27), -- Тёмно-красный (#991B1B)
    model = {"models/player/Group01/male_05.mdl"},
    description = [[Тёмная сторона Aurora. Грабь, торгуй запрещёнкой,
захватывай территории. Но полиция не дремлет.]],
    weapons = {"weapon_pistol"},
    command = "gangster",
    max = 8,
    salary = 800,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Криминал",
    spawnMoney = 500
})

TEAM_MAYOR = AddExtraTeam("Mayor", {
    color = Color(180, 83, 9), -- Золотой (#B45309)
    model = {"models/player/Group01/male_03.mdl"},
    description = [[Глава города Aurora. Принимай законы, управляй городской
казной, взаимодействуй со всеми департаментами.]],
    weapons = {},
    command = "mayor",
    max = 1,
    salary = 7500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Власть",
    spawnMoney = 20000,
    mayor = true,
    whitelist = true
})

-- Категории профессий для F4 меню
AddExtraCategory("Полиция", {color = Color(59, 130, 246)})
AddExtraCategory("Медицина", {color = Color(16, 185, 129)})
AddExtraCategory("Транспорт", {color = Color(234, 179, 8)})
AddExtraCategory("Бизнес", {color = Color(124, 58, 237)})
AddExtraCategory("Криминал", {color = Color(153, 27, 27)})
AddExtraCategory("Власть", {color = Color(180, 83, 9)})
AddExtraCategory("Гражданские", {color = Color(156, 163, 175)})
