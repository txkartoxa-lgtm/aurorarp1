-- Aurora RP - Server Side Jobs Configuration
-- This file runs only on the server

if SERVER then
    hook.Add("Initialize", "AuroraRP_SetupJobs", function()
        -- Police Jobs
        DarkRP.createJob("Полицейский", {
            color = Color(25, 25, 170),
            model = {"models/player/police.mdl"},
            description = [[Защищайте город от преступников!]],
            weapons = {"weapon_glock2", "weapon_stunstick"},
            command = "police",
            max = 10,
            salary = 150,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Службы порядка"
        })

        DarkRP.createJob("Шериф", {
            color = Color(25, 25, 170),
            model = {"models/player/police.mdl"},
            description = [[Глава полиции]],
            weapons = {"weapon_glock2", "weapon_stunstick", "weapon_m4a1"},
            command = "sheriff",
            max = 2,
            salary = 200,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Службы порядка",
            boss = true
        })

        -- Medical Jobs
        DarkRP.createJob("Врач", {
            color = Color(50, 200, 50),
            model = {"models/player/group03/female_07.mdl"},
            description = [[Лечите раненых граждан!]],
            weapons = {"weapon_medkit"},
            command = "medic",
            max = 8,
            salary = 140,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Медицина"
        })

        DarkRP.createJob("Хирург", {
            color = Color(50, 200, 50),
            model = {"models/player/group03/female_07.mdl"},
            description = [[Проводите сложные операции]],
            weapons = {"weapon_medkit"},
            command = "surgeon",
            max = 3,
            salary = 180,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Медицина"
        })

        -- Transport Jobs
        DarkRP.createJob("Таксист", {
            color = Color(255, 200, 0),
            model = {"models/player/group03/male_04.mdl"},
            description = [[Перевозите пассажиров по городу]],
            weapons = {},
            command = "taxi",
            max = 15,
            salary = 120,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Транспорт"
        })

        DarkRP.createJob("Водитель автобуса", {
            color = Color(200, 150, 0),
            model = {"models/player/group03/male_04.mdl"},
            description = [[Перевозите группы людей]],
            weapons = {},
            command = "busdriver",
            max = 5,
            salary = 130,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Транспорт"
        })

        -- Business Jobs
        DarkRP.createJob("Продавец", {
            color = Color(100, 100, 200),
            model = {"models/player/group03/female_06.mdl"},
            description = [[Работайте в магазинах]],
            weapons = {},
            command = "seller",
            max = 20,
            salary = 100,
            admin = 0,
            vote = false,
            hasLicense = false,
            category = "Бизнес"
        })

        DarkRP.createJob("Банкир", {
            color = Color(50, 150, 50),
            model = {"models/player/group03/male_09.mdl"},
            description = [[Управляйте банком]],
            weapons = {},
            command = "banker",
            max = 3,
            salary = 170,
            admin = 0,
            vote = false,
            hasLicense = true,
            category = "Бизнес"
        })

        -- Worker Jobs
        DarkRP.createJob("Шахтёр", {
            color = Color(150, 100, 50),
            model = {"models/player/group03/male_02.mdl"},
            description = [[Добывайте ресурсы]],
            weapons = {"weapon_pickaxe"},
            command = "miner",
            max = 15,
            salary = 110,
            admin = 0,
            vote = false,
            hasLicense = false,
            category = "Рабочие"
        })

        DarkRP.createJob("Строитель", {
            color = Color(200, 150, 100),
            model = {"models/player/group03/male_03.mdl"},
            description = [[Стройте здания]],
            weapons = {"weapon_physgun"},
            command = "builder",
            max = 10,
            salary = 120,
            admin = 0,
            vote = false,
            hasLicense = false,
            category = "Рабочие"
        })

        -- Other Jobs
        DarkRP.createJob("Журналист", {
            color = Color(200, 50, 50),
            model = {"models/player/group03/female_04.mdl"},
            description = [[Освещайте новости города]],
            weapons = {"weapon_camera"},
            command = "journalist",
            max = 5,
            salary = 110,
            admin = 0,
            vote = false,
            hasLicense = false,
            category = "Другие"
        })

        print("[Aurora RP] Jobs loaded successfully!")
    end)
end
