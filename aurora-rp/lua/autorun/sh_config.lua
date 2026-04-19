-- Aurora RP Configuration
-- Main configuration file

AuroraRP = AuroraRP or {}
AuroraRP.Config = AuroraRP.Config or {}

-- Server Settings
AuroraRP.Config.ServerName = "Aurora RP"
AuroraRP.Config.StartingMoney = 5000
AuroraRP.Config.StartingHealth = 100
AuroraRP.Config.StartingArmor = 0
AuroraRP.Config.StartingHunger = 100

-- Voice Chat Settings
AuroraRP.Config.VoiceDistance = 400 -- Distance for voice chat

-- Door Settings
AuroraRP.Config.MaxDoorsPerPlayer = 10
AuroraRP.Config.DoorPrice = 500

-- Third Person Settings
AuroraRP.Config.DefaultThirdPerson = true -- Enable third person by default

print("[Aurora RP] Configuration loaded successfully!")
