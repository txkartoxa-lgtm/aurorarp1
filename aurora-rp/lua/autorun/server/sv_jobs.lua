-- Aurora RP - Additional Jobs Configuration
-- Extended job list for DarkRP

GM.JobCategories = {
    ["Службы порядка"] = true,
    ["Медицина"] = true,
    ["Транспорт"] = true,
    ["Бизнес"] = true,
    ["Рабочие"] = true,
    ["Государство"] = true,
    ["Другие"] = true
}

-- Define custom jobs (these will be added to DarkRP)
DarkRP.createJob("Полицейский", {
    color = Color(25, 25, 170),
    model = {"models/player/police.mdl"},
    description = [[Защита порядка и безопасности города. 
Борьба с преступностью и обеспечение безопасности граждан.]],
    weapons = {"weapon_pistol", "weapon_stunstick", "weapon_crowbar"},
    command = "police",
    salary = 500,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Службы порядка",
    PlayerModel = "models/player/police.mdl"
})

DarkRP.createJob("Шериф", {
    color = Color(25, 25, 170),
    model = {"models/player/police.mdl"},
    description = [[Глава полицейского департамента.
Руководство полицией и координация операций.]],
    weapons = {"weapon_pistol", "weapon_smg1", "weapon_stunstick"},
    command = "chief",
    salary = 700,
    admin = 0,
    vote = true,
    hasLicense = true,
    category = "Службы порядка",
    PlayerModel = "models/player/police.mdl",
    needToChangeFrom = {"Полицейский"}
})

DarkRP.createJob("SWAT", {
    color = Color(20, 20, 120),
    model = {"models/player/swat.mdl"},
    description = [[Спецназ для особых операций.
Решение критических ситуаций и задержание опасных преступников.]],
    weapons = {"weapon_ar2", "weapon_pistol", "weapon_stunstick"},
    command = "swat",
    salary = 600,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Службы порядка",
    PlayerModel = "models/player/swat.mdl",
    needToChangeFrom = {"Полицейский"}
})

DarkRP.createJob("Врач", {
    color = Color(255, 100, 100),
    model = {"models/player/group03/female_02.mdl", "models/player/group03/male_02.mdl"},
    description = [[Лечение раненых граждан.
Оказание медицинской помощи и продажа медикаментов.]],
    weapons = {"weapon_medkit"},
    command = "medic",
    salary = 450,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Медицина",
    PlayerModel = "models/player/group03/female_02.mdl"
})

DarkRP.createJob("Хирург", {
    color = Color(255, 80, 80),
    model = {"models/player/group03/male_02.mdl", "models/player/group03/female_02.mdl"},
    description = [[Проведение сложных операций.
Высококвалифицированный медицинский персонал.]],
    weapons = {"weapon_medkit"},
    command = "surgeon",
    salary = 650,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Медицина",
    PlayerModel = "models/player/group03/male_02.mdl",
    needToChangeFrom = {"Врач"}
})

DarkRP.createJob("Таксист", {
    color = Color(255, 200, 0),
    model = {"models/player/eli.mdl"},
    description = [[Перевозка пассажиров по городу.
Зарабатывайте деньги, перевозя людей из точки А в точку Б.]],
    weapons = {},
    command = "taxi",
    salary = 350,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Транспорт",
    PlayerModel = "models/player/eli.mdl"
})

DarkRP.createJob("Водитель автобуса", {
    color = Color(200, 180, 0),
    model = {"models/player/barney.mdl"},
    description = [[Общественный транспорт.
Перевозка пассажиров по маршруту.]],
    weapons = {},
    command = "busdriver",
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Транспорт",
    PlayerModel = "models/player/barney.mdl"
})

DarkRP.createJob("Дальнобойщик", {
    color = Color(180, 160, 0),
    model = {"models/player/breen.mdl"},
    description = [[Грузоперевозки на дальние расстояния.
Транспортировка грузов между городами.]],
    weapons = {},
    command = "truckdriver",
    salary = 400,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Транспорт",
    PlayerModel = "models/player/breen.mdl"
})

DarkRP.createJob("Продавец", {
    color = Color(100, 200, 100),
    model = {"models/player/group01/female_01.mdl", "models/player/group01/male_01.mdl"},
    description = [[Работа в магазине.
Продажа товаров гражданам.]],
    weapons = {},
    command = "seller",
    salary = 250,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Бизнес",
    PlayerModel = "models/player/group01/female_01.mdl"
})

DarkRP.createJob("Менеджер", {
    color = Color(80, 180, 80),
    model = {"models/player/group01/male_01.mdl"},
    description = [[Управление бизнесом.
Координация работы сотрудников.]],
    weapons = {},
    command = "manager",
    salary = 500,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Бизнес",
    PlayerModel = "models/player/group01/male_01.mdl",
    needToChangeFrom = {"Продавец"}
})

DarkRP.createJob("Банкир", {
    color = Color(60, 160, 60),
    model = {"models/player/gman_high.mdl"},
    description = [[Работа в банке.
Управление финансовыми операциями.]],
    weapons = {},
    command = "banker",
    salary = 800,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Бизнес",
    PlayerModel = "models/player/gman_high.mdl"
})

DarkRP.createJob("Шахтёр", {
    color = Color(100, 80, 60),
    model = {"models/player/group03/male_04.mdl"},
    description = [[Добыча ресурсов.
Добыча полезных ископаемых в шахте.]],
    weapons = {"weapon_crowbar", "weapon_pickaxe"},
    command = "miner",
    salary = 300,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Рабочие",
    PlayerModel = "models/player/group03/male_04.mdl"
})

DarkRP.createJob("Строитель", {
    color = Color(120, 100, 80),
    model = {"models/player/group03/male_03.mdl"},
    description = [[Строительство зданий.
Возведение новых построек в городе.]],
    weapons = {"weapon_crowbar", "weapon_tool"},
    command = "builder",
    salary = 350,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Рабочие",
    PlayerModel = "models/player/group03/male_03.mdl"
})

DarkRP.createJob("Электрик", {
    color = Color(140, 120, 100),
    model = {"models/player/group03/male_05.mdl"},
    description = [[Ремонт электропроводки.
Обслуживание электрических систем города.]],
    weapons = {"weapon_tool"},
    command = "electrician",
    salary = 400,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Рабочие",
    PlayerModel = "models/player/group03/male_05.mdl"
})

DarkRP.createJob("Журналист", {
    color = Color(200, 150, 50),
    model = {"models/player/group01/female_03.mdl"},
    description = [[Освещение новостей города.
Репортажи и интервью с гражданами.]],
    weapons = {"weapon_camera"},
    command = "journalist",
    salary = 350,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Другие",
    PlayerModel = "models/player/group01/female_03.mdl"
})

-- Remove default citizen job if needed
-- DarkRP.removeJob("Citizen")

print("Aurora RP Jobs Configuration Loaded!")
