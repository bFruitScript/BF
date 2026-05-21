local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "ArxHub",
    SubTitle = "by FirePlayz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 480),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Home = Window:AddTab({ Title = "⌂ Home", Icon = "home" }),
    Status = Window:AddTab({ Title = "◈ Status", Icon = "activity" }),
    Settings = Window:AddTab({ Title = "⚙ Settings", Icon = "settings" }),
    Farm = Window:AddTab({ Title = "⚔ Farm", Icon = "swords" }),
    FarmItems = Window:AddTab({ Title = "⬡ Farm Items", Icon = "package" }),
    SeaEvent = Window:AddTab({ Title = "◌ Sea Event", Icon = "ship" }),
    FruitRaid = Window:AddTab({ Title = "◍ Fruit/Raid", Icon = "cherry" }),
    Shop = Window:AddTab({ Title = "🛒 Shop", Icon = "shopping-cart" }),
    Visual = Window:AddTab({ Title = "◐ Visual", Icon = "eye" }),
    Pvp = Window:AddTab({ Title = "☰ PvP", Icon = "crosshair" }),
    Misc = Window:AddTab({ Title = "☰ Misc", Icon = "layers" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "ArxHub",
        Content = "Welcome to ArxHub by FirePlayz",
        Duration = 8
    })
end

-- Home Tab
do
    local Section = Tabs.Home:AddSection("Information")
    Section:AddParagraph({
        Title = "ArxHub v1.0.0",
        Content = "Made by FirePlayz"
    })
    Section:AddParagraph({
        Title = "Latest Updates",
        Content = "• Fixed auto farm bugs\n• Added new sea events\n• Improved PvP features\n• Added threat detector"
    })
end

-- Status Tab
do
    local Section = Tabs.Status:AddSection("Katakuri Status")
    local katakuriAlive = false
    local enemyCount = 0
    
    Section:AddToggle("katakuri_alive", {
        Title = "Katakuri Alive",
        Description = "Shows if Katakuri is alive",
        Default = false,
        Callback = function(Value)
            katakuriAlive = Value
        end
    })
    
    Section:AddParagraph({
        Title = "Enemies to Kill",
        Content = "0/7 remaining\n🌑🌒🌓🌔🌕🌖🌗🌘"
    })
    
    local moonPhases = {"🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"}
    Section:AddDropdown("moon_phase", {
        Title = "Current Moon Phase",
        Values = moonPhases,
        Multi = false,
        Default = "🌑",
        Description = "Shows current moon phase"
    })
end

-- Settings Tab
do
    local Section = Tabs.Settings:AddSection("Weapon Settings")
    Section:AddDropdown("farm_weapon", {
        Title = "Farming Weapon",
        Values = {"Melee", "Sword", "Gun", "Fruit"},
        Multi = false,
        Default = "Melee",
        Description = "Weapon used for farming levels"
    })
    
    Section:AddDropdown("boss_weapon", {
        Title = "Boss Weapon",
        Values = {"Melee", "Sword", "Gun", "Fruit"},
        Multi = false,
        Default = "Fruit",
        Description = "Weapon used for boss fights"
    })
    
    Section:AddToggle("auto_switch", {
        Title = "Auto Switch Weapons",
        Description = "Automatically switch weapons based on target",
        Default = true
    })
end

-- Farm Tab
do
    local Section = Tabs.Farm:AddSection("Auto Farm")
    Section:AddToggle("farm_level", {
        Title = "Farm Level",
        Description = "Automatically farm levels",
        Default = false
    })
    
    Section:AddToggle("farm_nearest", {
        Title = "Farm Nearest",
        Description = "Farm nearest enemy",
        Default = false
    })
    
    Section:AddToggle("farm_all_boss", {
        Title = "Farm All Boss",
        Description = "Farm all bosses automatically",
        Default = false
    })
    
    local bosses = {"Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Chief Warden", "Swan", "Fajita", "Don Swan", "Diamond", "Jeremy", "Fountain City Boss"}
    Section:AddDropdown("farm_chosen_boss", {
        Title = "Farm Chosen Boss",
        Values = bosses,
        Multi = false,
        Default = "Bobby",
        Description = "Select boss to farm"
    })
end

-- Farm Items Tab
do
    local Section = Tabs.FarmItems:AddSection("Item Farm")
    local seas = {"First Sea", "Second Sea", "Third Sea"}
    Section:AddDropdown("farm_sea", {
        Title = "Select Sea",
        Values = seas,
        Multi = false,
        Default = "First Sea",
        Description = "Choose sea for item farming"
    })
    
    local items = {"Bone", "Ectoplasm", "Dark Fragment", "Magma Ore", "Dragon Scale", "Soul Reaper"}
    Section:AddDropdown("farm_item", {
        Title = "Farm Item",
        Values = items,
        Multi = true,
        Default = {},
        Description = "Select items to farm"
    })
end

-- Sea Event Tab
do
    local Section = Tabs.SeaEvent:AddSection("Sea Events")
    Section:AddToggle("choose_sea_event", {
        Title = "Choose Sea Events",
        Description = "Select specific sea events",
        Default = false
    })
    
    local dangerLevels = {"0%", "25%", "50%", "75%", "100%"}
    Section:AddDropdown("danger_level", {
        Title = "Sea Danger Level",
        Values = dangerLevels,
        Multi = false,
        Default = "0%",
        Description = "Choose sea danger level"
    })
    
    Section:AddDropdown("drive_boat", {
        Title = "Choose Boat to Drive",
        Values = {"Boat", "Caravel", "Galleon", "Striker", "Brigade", "Grand Brigade"},
        Multi = false,
        Default = "Boat",
        Description = "Select boat to drive"
    })
    
    Section:AddDropdown("farm_boat", {
        Title = "Choose Boat to Farm",
        Values = {"Boat", "Caravel", "Galleon", "Striker", "Brigade", "Grand Brigade"},
        Multi = false,
        Default = "Boat",
        Description = "Select boat to farm"
    })
    
    Section:AddSlider("boat_speed", {
        Title = "Boat Speed",
        Description = "Adjust boat speed multiplier",
        Default = 1,
        Min = 1,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
        end
    })
    
    Section:AddToggle("boat_noclip", {
        Title = "No Clip for Boat",
        Description = "Enable no clip for boat",
        Default = false
    })
end

-- Fruit/Raid Tab
do
    local Section = Tabs.FruitRaid:AddSection("Fruit Settings")
    Section:AddToggle("auto_roll", {
        Title = "Auto Roll",
        Description = "Automatically roll fruits",
        Default = false
    })
    
    Section:AddToggle("auto_store", {
        Title = "Auto Store",
        Description = "Automatically store fruits",
        Default = false
    })
    
    Section:AddToggle("tp_to_fruit", {
        Title = "TP to Fruit",
        Description = "Teleport to spawned fruit",
        Default = false
    })
    
    Section:AddToggle("tween_to_fruit", {
        Title = "Tween to Fruit",
        Description = "Tween to spawned fruit",
        Default = false
    })
    
    local raids = {"Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Buddha", "Phoenix", "Dough", "Dragon"}
    Section:AddDropdown("choose_raid", {
        Title = "Choose Raid",
        Values = raids,
        Multi = false,
        Default = "Flame",
        Description = "Select raid type"
    })
    
    Section:AddToggle("auto_start_raid", {
        Title = "Auto Start Raid",
        Description = "Automatically start raids",
        Default = false
    })
    
    Section:AddToggle("store_under_1m", {
        Title = "Store Under 1M Fruits",
        Description = "Auto store fruits worth under 1 million",
        Default = false
    })
end

-- Shop Tab
do
    local Section = Tabs.Shop:AddSection("Normal Fruit Shop")
    Section:AddToggle("auto_buy_fruit", {
        Title = "Auto Buy Fruit",
        Description = "Automatically buy fruits from shop",
        Default = false
    })
    
    local Section2 = Tabs.Shop:AddSection("Mirage Fruit Shop")
    Section2:AddToggle("auto_buy_mirage", {
        Title = "Auto Buy Mirage Fruit",
        Description = "Automatically buy mirage fruits",
        Default = false
    })
    
    local Section3 = Tabs.Shop:AddSection("Item Shops")
    Section3:AddToggle("auto_buy_melee", {
        Title = "Auto Buy Melee",
        Description = "Automatically buy melee weapons",
        Default = false
    })
    
    Section3:AddToggle("auto_buy_weapons", {
        Title = "Auto Buy Weapons",
        Description = "Automatically buy weapons",
        Default = false
    })
    
    Section3:AddToggle("auto_buy_accessories", {
        Title = "Auto Buy Accessories",
        Description = "Automatically buy accessories",
        Default = false
    })
end

-- Visual Tab
do
    local Section = Tabs.Visual:AddSection("ESP Settings")
    Section:AddToggle("player_esp", {
        Title = "Player ESP",
        Description = "Show player ESP",
        Default = false
    })
    
    Section:AddToggle("enemy_esp", {
        Title = "Enemy ESP",
        Description = "Show enemy ESP",
        Default = false
    })
    
    Section:AddToggle("fruit_esp", {
        Title = "Fruit ESP",
        Description = "Show fruit ESP",
        Default = false
    })
    
    Section:AddToggle("chest_esp", {
        Title = "Chest ESP",
        Description = "Show chest ESP",
        Default = false
    })
    
    local Section2 = Tabs.Visual:AddSection("World Settings")
    Section2:AddToggle("remove_fog", {
        Title = "Remove Fog",
        Description = "Remove all fog from the map",
        Default = false
    })
    
    Section2:AddToggle("fake_night", {
        Title = "Fake Night",
        Description = "Toggle fake night mode",
        Default = false
    })
    
    Section2:AddToggle("fake_day", {
        Title = "Fake Day",
        Description = "Toggle fake day mode",
        Default = false
    })
end

-- PvP Tab
do
    local Section = Tabs.Pvp:AddSection("Quick Buttons")
    Section:AddButton({
        Title = "Flash Step",
        Description = "Quick flash step",
        Callback = function()
        end
    })
    
    Section:AddButton({
        Title = "Observation Haki",
        Description = "Toggle observation haki",
        Callback = function()
        end
    })
    
    Section:AddButton({
        Title = "Buso Haki",
        Description = "Toggle buso haki",
        Callback = function()
        end
    })
    
    local Section2 = Tabs.Pvp:AddSection("Combat Settings")
    Section2:AddToggle("aimbot", {
        Title = "Aimbot",
        Description = "Enable aimbot",
        Default = false
    })
    
    Section2:AddToggle("aim_skills", {
        Title = "Aim Skills",
        Description = "Auto aim skills",
        Default = false
    })
    
    Section2:AddToggle("camera_lock", {
        Title = "Camera Lock",
        Description = "Lock camera on enemy",
        Default = false
    })
    
    Section2:AddToggle("tp_behind", {
        Title = "TP Behind Enemy",
        Description = "Teleport behind enemy",
        Default = false
    })
    
    local Section3 = Tabs.Pvp:AddSection("Advanced PvP")
    Section3:AddToggle("silent_aim", {
        Title = "Silent Aim",
        Description = "Enable silent aim",
        Default = false
    })
    
    Section3:AddToggle("skill_prediction", {
        Title = "Skill Prediction",
        Description = "Predict enemy movement",
        Default = false
    })
    
    Section3:AddToggle("auto_combo", {
        Title = "Auto Combo",
        Description = "Execute automatic combos",
        Default = false
    })
    
    Section3:AddToggle("auto_observation", {
        Title = "Auto Observation",
        Description = "Auto use observation haki",
        Default = false
    })
    
    Section3:AddToggle("dodge_assist", {
        Title = "Dodge Assist",
        Description = "Assist with dodging attacks",
        Default = false
    })
end

-- Misc Tab
do
    local Section = Tabs.Misc:AddSection("Extra Features")
    Section:AddToggle("cinematic_camera", {
        Title = "Cinematic Camera",
        Description = "Enable cinematic camera mode",
        Default = false
    })
    
    Section:AddToggle("radar_scanner", {
        Title = "Radar Scanner",
        Description = "Show radar scanner",
        Default = false
    })
    
    Section:AddToggle("nearby_fruit_alert", {
        Title = "Nearby Fruit Alert",
        Description = "Alert when fruit is nearby",
        Default = false
    })
    
    Section:AddToggle("threat_detector", {
        Title = "Threat Detector",
        Description = "Detect nearby threats",
        Default = false
    })
    
    Section:AddToggle("safe_zone_warning", {
        Title = "Safe Zone Warning",
        Description = "Warn when entering safe zone",
        Default = false
    })
    
    local Section2 = Tabs.Misc:AddSection("Auto Join")
    Section2:AddToggle("auto_join_raids", {
        Title = "Auto Join Raids",
        Description = "Automatically join raid invitations",
        Default = false
    })
    
    Section2:AddToggle("auto_join_factory", {
        Title = "Auto Join Factory",
        Description = "Automatically join factory events",
        Default = false
    })
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("ArxHub")
SaveManager:SetFolder("ArxHub/BloxFruits")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:ApplyTheme({
    Accent = Color3.fromRGB(0, 255, 65),
    AccentDark = Color3.fromRGB(0, 180, 45),
    AccentLight = Color3.fromRGB(50, 255, 100),
    Background = Color3.fromRGB(10, 10, 10),
    BackgroundDark = Color3.fromRGB(5, 5, 5),
    BackgroundLight = Color3.fromRGB(20, 20, 20),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(150, 150, 150),
    TextLight = Color3.fromRGB(200, 200, 200)
})

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ArxHubIcon") then
                game.Players.LocalPlayer.PlayerGui.ArxHubIcon:Destroy()
            end
        end)
    end
end)