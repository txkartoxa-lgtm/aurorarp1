-- Aurora RP - Server-side Jobs Configuration
-- DarkRP job definitions

if not DarkRP then return end

-- Police Chief
DarkRP.createJob("Police Chief", {
    color = Color(25, 25, 170),
    model = {"models/player/police.mdl"},
    description = [[You are the head of the police force. Lead your team and maintain order!]],
    weapons = {"weapon_glock2", "weapon_stunstick", "weapon_m9k_m4"},
    command = "policechief",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 3,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Law Enforcement"
})

-- Police Officer
DarkRP.createJob("Police Officer", {
    color = Color(50, 50, 200),
    model = {"models/player/police.mdl"},
    description = [[Protect and serve the citizens of Aurora RP.]],
    weapons = {"weapon_glock2", "weapon_stunstick"},
    command = "police",
    max = 5,
    salary = GAMEMODE.Config.normalsalary * 1.8,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Law Enforcement"
})

-- Medic
DarkRP.createJob("Medic", {
    color = Color(200, 50, 50),
    model = {"models/player/combine_soldier_prisonguard.mdl"},
    description = [[Heal injured citizens and keep everyone healthy!]],
    weapons = {"weapon_medkit"},
    command = "medic",
    max = 4,
    salary = GAMEMODE.Config.normalsalary * 1.6,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Medical"
})

-- Taxi Driver
DarkRP.createJob("Taxi Driver", {
    color = Color(255, 200, 0),
    model = {"models/player/group01/male01.mdl"},
    description = [[Transport citizens around the city for money.]],
    weapons = {},
    command = "taxi",
    max = 6,
    salary = GAMEMODE.Config.normalsalary * 1.3,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Services"
})

-- Gun Dealer
DarkRP.createJob("Gun Dealer", {
    color = Color(100, 100, 100),
    model = {"models/player/group01/male02.mdl"},
    description = [[Sell weapons to lawful citizens.]],
    weapons = {"weapon_glock2"},
    command = "gun",
    max = 2,
    salary = GAMEMODE.Config.normalsalary * 1.5,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Special"
})

-- Banker
DarkRP.createJob("Banker", {
    color = Color(0, 150, 0),
    model = {"models/player/group01/female01.mdl"},
    description = [[Manage the bank and help citizens with their money.]],
    weapons = {},
    command = "banker",
    max = 2,
    salary = GAMEMODE.Config.normalsalary * 1.7,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Services"
})

-- Fire Chief
DarkRP.createJob("Fire Chief", {
    color = Color(200, 100, 0),
    model = {"models/player/firefighter.mdl"},
    description = [[Lead the fire department and save lives!]],
    weapons = {},
    command = "firechief",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 2,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Emergency"
})

-- Fire Fighter
DarkRP.createJob("Fire Fighter", {
    color = Color(220, 120, 20),
    model = {"models/player/firefighter.mdl"},
    description = [[Put out fires and rescue people.]],
    weapons = {},
    command = "firefighter",
    max = 4,
    salary = GAMEMODE.Config.normalsalary * 1.5,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Emergency"
})

print("[Aurora RP] Jobs loaded successfully!")
