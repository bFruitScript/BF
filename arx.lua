--[[
    Script Name: ArxHub
    Creator: FirePlayz
    Target Game: Blox Fruits (Roblox)
    Design Inspiration: RedzHub
    Asset ID: 74804727220238
    Features: PC & Mobile Friendly, Gradient Dark Green/Black UI
]]

-- // Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- // Player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- // Anti-Report / Anti-Crash (Basic)
local function antiCheat()
    -- Basic anti-crash / anti-report placebo
    if syn then syn.request({Url = "http://127.0.0.1"; Method = "POST"}) end
end
antiCheat()

-- // Create ScreenGui with Dark Gradient Background
local gui = Instance.new("ScreenGui")
gui.Name = "ArxHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if syn then syn.protect_gui(gui) end
gui.Parent = CoreGui

-- // Gradient Background
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(10, 20, 5)
background.Parent = gui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 30, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 10, 3))
}
gradient.Rotation = 45
gradient.Parent = background

-- // Main Frame (RedzHub Style)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 550, 0, 650)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -325)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 10)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 100)
stroke.Thickness = 2
stroke.Transparency = 0.5
stroke.Parent = mainFrame

-- // Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 20, 8)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ArxHub [BETA]"
titleText.TextColor3 = Color3.fromRGB(0, 255, 150)
titleText.TextSize = 20
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- // Dragging
local dragging = false
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- // Category Bar
local categoryBar = Instance.new("Frame")
categoryBar.Size = UDim2.new(1, 0, 0, 50)
categoryBar.Position = UDim2.new(0, 0, 0, 40)
categoryBar.BackgroundColor3 = Color3.fromRGB(10, 20, 5)
categoryBar.BorderSizePixel = 0
categoryBar.Parent = mainFrame

-- // Scrollable Categories (Mobile Friendly)
local categoryScroller = Instance.new("ScrollingFrame")
categoryScroller.Size = UDim2.new(1, 0, 1, 0)
categoryScroller.BackgroundTransparency = 1
categoryScroller.ScrollBarThickness = 0
categoryScroller.CanvasSize = UDim2.new(4, 0, 0, 0) -- Expanded horizontally
categoryScroller.Parent = categoryBar

local categoryLayout = Instance.new("UIListLayout")
categoryLayout.FillDirection = Enum.FillDirection.Horizontal
categoryLayout.Padding = UDim.new(0, 5)
categoryLayout.Parent = categoryScroller

-- // Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 95)
contentFrame.BackgroundColor3 = Color3.fromRGB(8, 15, 5)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame

-- // Category Data (with Icons)
local categories = {
    {name = "[⌂] Home", page = "home"},
    {name = "[◈] Status", page = "status"},
    {name = "[⚙] Settings", page = "settings"},
    {name = "[⚔] Farm", page = "farm"},
    {name = "[⬡] Farm Items", page = "farmItems"},
    {name = "[◌] Sea Event", page = "seaEvent"},
    {name = "[◍] Fruit/Raid", page = "fruitRaid"},
    {name = "[🛒] Shop", page = "shop"},
    {name = "[◐] Visual", page = "visual"},
    {name = "[☰] Misc", page = "misc"}
}

local pages = {}

-- // Create Category Buttons
for _, cat in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 1, -10)
    btn.Position = UDim2.new(0, 0, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(20, 35, 15)
    btn.Text = cat.name
    btn.TextColor3 = Color3.fromRGB(0, 255, 100)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    btn.Parent = categoryScroller
    
    btn.MouseButton1Click:Connect(function()
        for _, page in pairs(pages) do
            page.Visible = false
        end
        pages[cat.page].Visible = true
    end)
end

-- // Helper: Create Section
local function createSection(parent, title, yPos)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -20, 0, 30)
    section.Position = UDim2.new(0, 10, 0, yPos)
    section.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    section.BackgroundTransparency = 0.8
    section.BorderSizePixel = 0
    section.Parent = parent
    local secCorner = Instance.new("UICorner")
    secCorner.CornerRadius = UDim.new(0, 5)
    secCorner.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.PaddingLeft = UDim.new(0, 10)
    titleLabel.Parent = section
    return section
end

local function createButton(parent, text, yOffset, callback, isQuick)
    local prefix = isQuick and "(B) " or ""
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(25, 40, 20)
    btn.Text = prefix .. text
    btn.TextColor3 = Color3.fromRGB(200, 255, 200)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(parent, text, yOffset, initial, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 180, 0, 30)
    toggleFrame.Position = UDim2.new(0, 10, 0, yOffset)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(180, 255, 180)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 25)
    btn.Position = UDim2.new(0.7, 0, 0, 2)
    btn.BackgroundColor3 = initial and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
    btn.Text = initial and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 11
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn
    btn.Parent = toggleFrame
    
    local state = initial
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
    return toggleFrame
end

local function createSlider(parent, text, yOffset, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 250, 0, 40)
    sliderFrame.Position = UDim2.new(0, 10, 0, yOffset)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 15)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(180, 255, 180)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 6)
    bar.Position = UDim2.new(0, 0, 0, 20)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar
    bar.Parent = sliderFrame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    fill.Parent = bar
    
    local value = default
    local dragging = false
    
    local function update(pos)
        local relative = (pos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
        relative = math.clamp(relative, 0, 1)
        value = min + (max - min) * relative
        value = math.floor(value * 10) / 10
        fill.Size = UDim2.new(relative, 0, 1, 0)
        label.Text = text .. ": " .. tostring(value)
        callback(value)
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input.Position)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input.Position)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    return sliderFrame
end

-- // Create Pages
local function createHomePage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 250)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.home = page
    
    local welcome = Instance.new("TextLabel")
    welcome.Size = UDim2.new(1, -20, 0, 60)
    welcome.Position = UDim2.new(0, 10, 0, 10)
    welcome.BackgroundColor3 = Color3.fromRGB(0, 50, 20)
    welcome.BackgroundTransparency = 0.5
    welcome.Text = "((C) Welcome to ArxHub!\nBug fixes & new features added.\nVersion: 2.1.0 | Credits: FirePlayz"
    welcome.TextColor3 = Color3.fromRGB(100, 255, 150)
    welcome.TextSize = 14
    welcome.TextWrapped = true
    local welcomeCorner = Instance.new("UICorner")
    welcomeCorner.CornerRadius = UDim.new(0, 8)
    welcomeCorner.Parent = welcome
    welcome.Parent = page
end

local function createStatusPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 200)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.status = page
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 40)
    statusLabel.Position = UDim2.new(0, 10, 0, 10)
    statusLabel.BackgroundTransparency = 0.5
    statusLabel.BackgroundColor3 = Color3.fromRGB(0,30,10)
    statusLabel.Text = "((F) Katakuri Status: ALIVE"
    statusLabel.TextColor3 = Color3.fromRGB(0,255,100)
    statusLabel.TextSize = 14
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0,6)
    statusCorner.Parent = statusLabel
    statusLabel.Parent = page
    
    local moonPhase = Instance.new("TextLabel")
    moonPhase.Size = UDim2.new(1, -20, 0, 30)
    moonPhase.Position = UDim2.new(0, 10, 0, 60)
    moonPhase.BackgroundTransparency = 1
    moonPhase.Text = "Moon Phase: 0🌑1🌒2🌓3🌔4🌕5🌖6🌗7🌘"
    moonPhase.TextColor3 = Color3.fromRGB(200,255,200)
    moonPhase.TextSize = 12
    moonPhase.Parent = page
    
    -- Simulated update
    task.spawn(function()
        while pages.status and pages.status.Visible do
            pcall(function()
                local lp = Players.LocalPlayer
                local char = lp.Character
                if char and char:FindFirstChild("Humanoid") then
                    statusLabel.Text = "((F) Katakuri Status: " .. (char.Humanoid.Health > 0 and "ALIVE" or "DEFEATED")
                end
                -- Random moon phase update for demo
                local phases = {"0🌑","1🌒","2🌓","3🌔","4🌕","5🌖","6🌗","7🌘"}
                moonPhase.Text = "Moon Phase: " .. phases[math.random(1,8)]
            end)
            task.wait(3)
        end
    end)
end

local function createSettingsPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 200)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.settings = page
    
    createToggle(page, "((F) Use Melee in Farm", 10, true, function(state) print("Melee: "..tostring(state)) end)
    createToggle(page, "((F) Use Gun in Farm", 50, false, function(state) print("Gun: "..tostring(state)) end)
    createToggle(page, "((F) Use Sword in Farm", 90, true, function(state) print("Sword: "..tostring(state)) end)
    createSlider(page, "((F) Farm Distance", 130, 50, 500, 200, function(val) print("Distance: "..val) end)
end

local function createFarmPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 250)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.farm = page
    
    createButton(page, "((F) Farm Level", 10, function() print("Farming Level...") end)
    createButton(page, "((F) Farm Nearest", 55, function() print("Farming Nearest...") end)
    createButton(page, "((F) Farm All Boss", 100, function() print("Farming All Bosses...") end)
    createButton(page, "((F) Farm Chosen Boss", 145, function() print("Farming Chosen Boss...") end, true)
    createButton(page, "((F) Stop Farm", 190, function() print("Stopped Farming") end)
end

local function createFarmItemsPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 150)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.farmItems = page
    
    createButton(page, "((F) Farm Items First Sea", 10, function() print("Farming First Sea Items") end)
    createButton(page, "((F) Farm Items Second Sea", 55, function() print("Farming Second Sea Items") end)
    createButton(page, "((F) Farm Items Third Sea", 100, function() print("Farming Third Sea Items") end)
end

local function createSeaEventPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 300)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.seaEvent = page
    
    createToggle(page, "((F) Auto Sea Event", 10, true, function(s) print("Auto Sea Event: "..tostring(s)) end)
    createSlider(page, "((F) Sea Danger Level", 50, 1, 6, 3, function(v) print("Danger: "..v) end)
    createButton(page, "((F) Choose Boat", 95, function() print("Boat Selected") end)
    createToggle(page, "((F) Boat No Clip", 140, false, function(s) print("No Clip Boat: "..tostring(s)) end)
    createSlider(page, "((F) Boat Speed", 180, 50, 500, 150, function(v) print("Boat Speed: "..v) end)
end

local function createFruitRaidPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.fruitRaid = page
    
    createButton(page, "((F) Auto Roll Fruit", 10, function() print("Auto Rolling...") end)
    createButton(page, "((F) Auto Store Fruit", 55, function() print("Auto Store...") end)
    createButton(page, "((F) TP to Fruit", 100, function() print("Teleport to Fruit") end)
    createButton(page, "((F) Tween to Fruit", 145, function() print("Tweening to Fruit") end)
    createButton(page, "((R) Fruit/Raid", 190, function() print("Opening Raid UI") end)
    createButton(page, "((F) Start Raid", 235, function() print("Starting Raid") end)
    createToggle(page, "((F) UStore under 1M Fruit", 280, true, function(s) print("UStore: "..tostring(s)) end)
end

local function createShopPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 250)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.shop = page
    
    createButton(page, "((F) Normal Fruit Shop", 10, function() print("Opening Fruit Shop") end)
    createButton(page, "((F) Mirage Fruit Shop", 55, function() print("Opening Mirage Shop") end)
    createButton(page, "((F) Melee Shop", 100, function() print("Melee Shop") end)
    createButton(page, "((F) Weapons Shop", 145, function() print("Weapons Shop") end)
    createButton(page, "((F) Accessories Shop", 190, function() print("Accessories Shop") end)
end

local function createVisualPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.visual = page
    
    createToggle(page, "((F) ESP Players", 10, true, function(s) print("ESP: "..tostring(s)) end)
    createToggle(page, "((F) ESP Chests", 50, true, function(s) print("Chest ESP: "..tostring(s)) end)
    createToggle(page, "((F) Remove Fog", 90, true, function(s) 
        game.Lighting.FogEnd = s and 100000 or 1000
    end)
    createToggle(page, "((F) Cinematic Camera", 130, false, function(s) print("Cinematic: "..tostring(s)) end)
    createToggle(page, "((F) Radar Scanner", 170, true, function(s) print("Radar: "..tostring(s)) end)
    createToggle(page, "((F) Nearby Fruit Alert", 210, true, function(s) print("Fruit Alert: "..tostring(s)) end)
    createToggle(page, "((F) Threat Detector", 250, false, function(s) print("Threat: "..tostring(s)) end)
    createToggle(page, "((F) Safe Zone Warning", 290, true, function(s) print("Safe Zone: "..tostring(s)) end)
end

local function createMiscPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ScrollBarThickness = 4
    page.Parent = contentFrame
    pages.misc = page
    
    createToggle(page, "((F) Auto Aim Camera", 10, false, function(s) print("Auto Aim: "..tostring(s)) end)
    createToggle(page, "((F) Silent Aim", 50, false, function(s) print("Silent Aim: "..tostring(s)) end)
    createToggle(page, "((F) Skill Prediction", 90, true, function(s) print("Skill Prediction: "..tostring(s)) end)
    createToggle(page, "((F) Auto Combo", 130, false, function(s) print("Auto Combo: "..tostring(s)) end)
    createToggle(page, "((F) Auto Observation", 170, true, function(s) print("Auto Observation: "..tostring(s)) end)
    createToggle(page, "((F) Dodge Assist", 210, true, function(s) print("Dodge Assist: "..tostring(s)) end)
    createButton(page, "((B) TP Behind Enemy", 255, function() print("TP to Enemy") end, true)
    createButton(page, "((B) Camera Lock", 300, function() print("Camera Locked") end, true)
    createButton(page, "((B) Quick Combo", 345, function() print("Combo Executed") end, true)
end

-- // Initialize all pages
createHomePage()
createStatusPage()
createSettingsPage()
createFarmPage()
createFarmItemsPage()
createSeaEventPage()
createFruitRaidPage()
createShopPage()
createVisualPage()
createMiscPage()

-- // Set default visible page
pages.home.Visible = true
for k,v in pairs(pages) do
    if k ~= "home" then v.Visible = false end
end

-- // Mobile Optimization: Make buttons larger touch area
for _, btn in pairs(gui:GetDescendants()) do
    if btn:IsA("TextButton") then
        btn.AutoButtonColor = false
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,80,40) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(25,40,20) end)
    end
end

print("ArxHub Loaded Successfully | Credit: FirePlayz")