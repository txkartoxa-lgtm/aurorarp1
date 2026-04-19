# Aurora RP - DarkRP Server Addon

## 🌟 Features

### HUD Interface
- **Top Right**: Server name "AURORA RP" with real-time clock
- **Bottom Left**: Health, Armor, Hunger, and Money display with progress bars
- Voice chat indicators above speaking players

### Profession System (F2)
Beautiful menu with job categories:
- Law Enforcement (Police Chief, Police Officer)
- Medical (Medic)
- Emergency (Fire Chief, Fire Fighter)
- Services (Taxi Driver, Banker)
- Special (Gun Dealer)

Each job has custom models, weapons, salary, and descriptions.

### Donate Shop (F3)
Ready-to-customize donation menu with categories:
- VIP Status (Basic, Premium, Elite)
- Money Packs
- Weapon Packs
- Vehicles
- Pets

### Third Person Camera
- Press **V** to toggle third person view
- Smooth camera movement
- Enabled by default
- Configurable distance and height

### Door & Key System
- Buy doors legitimately
- Add/remove owners with commands:
  - `!addowner <player name>` - Add friend as owner
  - `!removeowner <player name>` - Remove owner
  - `!knock` - Knock on door
- Only owners can open/close doors
- Protection against door stealing
- Physgun and toolgun restrictions

### Voice Chat
- Proximity-based voice chat
- Visual microphone indicators
- Works with GMod's built-in voice system

### Safety Features
- No door theft prevention
- Safe physgun usage (no explosions)
- Toolgun restrictions on other players' property
- Cannot pickup other players

## 📁 Installation

1. **Download the map**: 
   - Get `rp_downtown_tits_v2` from: https://steamcommunity.com/sharedfiles/filedetails/?id=1527403485
   - Or subscribe to it on Steam Workshop

2. **Install the addon**:
   ```
   Copy the aurora-rp folder to:
   garrysmod/addons/aurora-rp/
   ```

3. **Required Dependencies**:
   - DarkRP gamemode (must be installed)
   - Map: rp_downtown_tits_v2

4. **Start the server**:
   - Launch Garry's Mod
   - Create server with map `rp_downtown_tits_v2`
   - Make sure DarkRP is the active gamemode

## ⌨️ Controls

| Key | Action |
|-----|--------|
| F2 | Open Jobs Menu |
| F3 | Open Donate Shop |
| V | Toggle Third Person |
| E | Interact with doors |
| !knock | Knock on door (chat command) |
| !addowner \<name\> | Add door owner |
| !removeowner \<name\> | Remove door owner |

## ⚙️ Configuration

Edit `lua/autorun/sh_config.lua` to customize:

```lua
AuroraRP.Config.ServerName = "Aurora RP"
AuroraRP.Config.StartingMoney = 5000
AuroraRP.Config.StartingHealth = 100
AuroraRP.Config.StartingArmor = 0
AuroraRP.Config.StartingHunger = 100
AuroraRP.Config.VoiceDistance = 400
AuroraRP.Config.MaxDoorsPerPlayer = 10
AuroraRP.Config.DoorPrice = 500
AuroraRP.Config.DefaultThirdPerson = true
```

## 🎨 Customization

### Adding New Jobs
Edit `lua/autorun/server/sv_jobs.lua` and use:
```lua
DarkRP.createJob("Job Name", {
    color = Color(r, g, b),
    model = {"models/player/model.mdl"},
    description = [[Description text]],
    weapons = {"weapon_name"},
    command = "jobcommand",
    max = 5,
    salary = GAMEMODE.Config.normalsalary * 1.5,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Category Name"
})
```

### Customizing Donate Items
Edit `gamemode/cl_donate_menu.lua` and modify the `donateItems` table.

### Changing HUD Colors
Edit `gamemode/cl_hud.lua` and modify the `hudColors` table.

## 🐛 Troubleshooting

**No jobs showing?**
- Make sure DarkRP is properly installed
- Check console for errors

**HUD not appearing?**
- Verify all client files are loading
- Check for Lua errors in console

**Third person not working?**
- Press V to toggle
- Check if DefaultThirdPerson is enabled in config

**Door commands not working?**
- Look directly at a door when using commands
- Make sure you're the owner to add/remove owners

## 📝 Notes

- This addon extends DarkRP, it does NOT replace it
- All features work alongside standard DarkRP mechanics
- Donation store link needs to be configured by server owner
- For best experience, use with atmospheric lighting mods

## 💬 Support

For issues or questions:
1. Check console for error messages
2. Verify all files are in correct locations
3. Ensure DarkRP is installed and working
4. Test on a local server first

---

**Made for Aurora RP** 🌅
Enjoy your roleplay experience!
