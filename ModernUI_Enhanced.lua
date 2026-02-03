--[[
    ════════════════════════════════════════════════════════════════════════
    PROFESSIONAL ROBLOX UI LIBRARY - ENHANCED EDITION v3.1
    Version: 3.1.0
    NEW in v3.1: 
    ✨ Gradient Backgrounds (all themes)
    ✨ Glow Effects on Active Elements
    ✨ Image Element Support
    ✨ Gradient Sliders
    ✨ Smooth Tab Switch Animations
    ✨ Enhanced Visual Polish
    ════════════════════════════════════════════════════════════════════════
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════════════════
-- THEME PRESETS WITH GRADIENTS - EASILY CHANGE YOUR UI THEME HERE!
-- ════════════════════════════════════════════════════════════════════════

-- Set your active theme here! Options: Purple, Red, Ocean, Matrix, Midnight, Sunset
local ACTIVE_THEME = "Purple"

local ThemePresets = {
    -- Deep Royal Purple with Gradients
    Purple = {
        Background = Color3.fromRGB(30, 30, 46),
        BackgroundGradient = Color3.fromRGB(45, 35, 60), -- Gradient end color
        Secondary = Color3.fromRGB(45, 45, 65),
        SecondaryGradient = Color3.fromRGB(55, 45, 75),
        Tertiary = Color3.fromRGB(55, 55, 80),
        Sidebar = Color3.fromRGB(24, 24, 37),
        SidebarGradient = Color3.fromRGB(35, 30, 50),
        SidebarHover = Color3.fromRGB(35, 35, 55),
        SidebarActive = Color3.fromRGB(195, 126, 255),
        Accent = Color3.fromRGB(195, 126, 255),
        AccentGradient = Color3.fromRGB(150, 80, 220),
        AccentHover = Color3.fromRGB(210, 160, 255),
        AccentDark = Color3.fromRGB(150, 80, 220),
        Text = Color3.fromRGB(245, 245, 250),
        TextDark = Color3.fromRGB(180, 180, 200),
        TextMuted = Color3.fromRGB(130, 130, 150),
        Border = Color3.fromRGB(60, 60, 85),
        BorderLight = Color3.fromRGB(80, 80, 110),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(195, 126, 255),
        ToggleOff = Color3.fromRGB(70, 70, 90),
        GlowColor = Color3.fromRGB(195, 126, 255) -- Glow effect color
    },
    
    -- Vampire / Blood Red
    Red = {
        Background = Color3.fromRGB(20, 10, 10),
        BackgroundGradient = Color3.fromRGB(35, 15, 15),
        Secondary = Color3.fromRGB(35, 15, 15),
        SecondaryGradient = Color3.fromRGB(50, 20, 20),
        Tertiary = Color3.fromRGB(50, 20, 20),
        Sidebar = Color3.fromRGB(15, 5, 5),
        SidebarGradient = Color3.fromRGB(25, 10, 10),
        SidebarHover = Color3.fromRGB(30, 10, 10),
        SidebarActive = Color3.fromRGB(220, 20, 60),
        Accent = Color3.fromRGB(220, 20, 60),
        AccentGradient = Color3.fromRGB(150, 10, 40),
        AccentHover = Color3.fromRGB(255, 50, 90),
        AccentDark = Color3.fromRGB(150, 10, 40),
        Text = Color3.fromRGB(255, 235, 235),
        TextDark = Color3.fromRGB(180, 150, 150),
        TextMuted = Color3.fromRGB(120, 90, 90),
        Border = Color3.fromRGB(60, 30, 30),
        BorderLight = Color3.fromRGB(80, 40, 40),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(220, 20, 60),
        ToggleOff = Color3.fromRGB(60, 30, 30),
        GlowColor = Color3.fromRGB(220, 20, 60)
    },
    
    -- Abyssal Ocean Blue
    Ocean = {
        Background = Color3.fromRGB(10, 15, 25),
        BackgroundGradient = Color3.fromRGB(20, 30, 45),
        Secondary = Color3.fromRGB(20, 30, 45),
        SecondaryGradient = Color3.fromRGB(30, 45, 65),
        Tertiary = Color3.fromRGB(30, 45, 65),
        Sidebar = Color3.fromRGB(5, 10, 20),
        SidebarGradient = Color3.fromRGB(15, 20, 35),
        SidebarHover = Color3.fromRGB(15, 25, 40),
        SidebarActive = Color3.fromRGB(0, 200, 255),
        Accent = Color3.fromRGB(0, 200, 255),
        AccentGradient = Color3.fromRGB(0, 140, 200),
        AccentHover = Color3.fromRGB(80, 230, 255),
        AccentDark = Color3.fromRGB(0, 140, 200),
        Text = Color3.fromRGB(230, 245, 255),
        TextDark = Color3.fromRGB(150, 180, 200),
        TextMuted = Color3.fromRGB(100, 130, 150),
        Border = Color3.fromRGB(40, 60, 80),
        BorderLight = Color3.fromRGB(60, 80, 100),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(0, 200, 255),
        ToggleOff = Color3.fromRGB(40, 60, 80),
        GlowColor = Color3.fromRGB(0, 200, 255)
    },
    
    -- Hacker Matrix Green
    Matrix = {
        Background = Color3.fromRGB(5, 10, 5),
        BackgroundGradient = Color3.fromRGB(10, 20, 10),
        Secondary = Color3.fromRGB(10, 20, 10),
        SecondaryGradient = Color3.fromRGB(15, 30, 15),
        Tertiary = Color3.fromRGB(15, 30, 15),
        Sidebar = Color3.fromRGB(0, 5, 0),
        SidebarGradient = Color3.fromRGB(5, 15, 5),
        SidebarHover = Color3.fromRGB(10, 25, 10),
        SidebarActive = Color3.fromRGB(0, 255, 65),
        Accent = Color3.fromRGB(0, 255, 65),
        AccentGradient = Color3.fromRGB(0, 180, 45),
        AccentHover = Color3.fromRGB(80, 255, 120),
        AccentDark = Color3.fromRGB(0, 180, 45),
        Text = Color3.fromRGB(200, 255, 200),
        TextDark = Color3.fromRGB(120, 180, 120),
        TextMuted = Color3.fromRGB(80, 120, 80),
        Border = Color3.fromRGB(30, 60, 30),
        BorderLight = Color3.fromRGB(50, 80, 50),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(0, 255, 65),
        ToggleOff = Color3.fromRGB(30, 60, 30),
        GlowColor = Color3.fromRGB(0, 255, 65)
    },
    
    -- Deep Midnight Purple
    Midnight = {
        Background = Color3.fromRGB(15, 10, 25),
        BackgroundGradient = Color3.fromRGB(25, 15, 40),
        Secondary = Color3.fromRGB(25, 20, 40),
        SecondaryGradient = Color3.fromRGB(35, 25, 55),
        Tertiary = Color3.fromRGB(35, 30, 55),
        Sidebar = Color3.fromRGB(10, 5, 20),
        SidebarGradient = Color3.fromRGB(20, 10, 35),
        SidebarHover = Color3.fromRGB(20, 15, 35),
        SidebarActive = Color3.fromRGB(138, 43, 226),
        Accent = Color3.fromRGB(138, 43, 226),
        AccentGradient = Color3.fromRGB(100, 30, 180),
        AccentHover = Color3.fromRGB(165, 80, 240),
        AccentDark = Color3.fromRGB(100, 30, 180),
        Text = Color3.fromRGB(240, 230, 255),
        TextDark = Color3.fromRGB(160, 150, 180),
        TextMuted = Color3.fromRGB(110, 100, 130),
        Border = Color3.fromRGB(50, 40, 70),
        BorderLight = Color3.fromRGB(70, 60, 90),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(138, 43, 226),
        ToggleOff = Color3.fromRGB(50, 40, 70),
        GlowColor = Color3.fromRGB(138, 43, 226)
    },
    
    -- Sunset Orange/Pink
    Sunset = {
        Background = Color3.fromRGB(25, 15, 20),
        BackgroundGradient = Color3.fromRGB(40, 20, 30),
        Secondary = Color3.fromRGB(35, 20, 25),
        SecondaryGradient = Color3.fromRGB(50, 30, 40),
        Tertiary = Color3.fromRGB(50, 30, 40),
        Sidebar = Color3.fromRGB(20, 10, 15),
        SidebarGradient = Color3.fromRGB(30, 15, 25),
        SidebarHover = Color3.fromRGB(30, 20, 25),
        SidebarActive = Color3.fromRGB(255, 99, 71),
        Accent = Color3.fromRGB(255, 99, 71),
        AccentGradient = Color3.fromRGB(255, 140, 0),
        AccentHover = Color3.fromRGB(255, 140, 100),
        AccentDark = Color3.fromRGB(255, 69, 0),
        Text = Color3.fromRGB(255, 245, 240),
        TextDark = Color3.fromRGB(200, 180, 170),
        TextMuted = Color3.fromRGB(140, 120, 110),
        Border = Color3.fromRGB(70, 50, 60),
        BorderLight = Color3.fromRGB(90, 70, 80),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(255, 99, 71),
        ToggleOff = Color3.fromRGB(70, 50, 60),
        GlowColor = Color3.fromRGB(255, 99, 71)
    }
}

local Theme = ThemePresets[ACTIVE_THEME]

-- ════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════

local function Tween(instance, properties, duration, easingStyle, easingDirection, callback)
    duration = duration or 0.3
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration, easingStyle, easingDirection),
        properties
    )
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    tween:Play()
    return tween
end

local function CreateElement(className, properties)
    local element = Instance.new(className)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- Add gradient to any frame
local function AddGradient(parent, color1, color2, rotation)
    rotation = rotation or 90
    local gradient = CreateElement("UIGradient", {
        Parent = parent,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }),
        Rotation = rotation
    })
    return gradient
end

-- Add glow effect to element
local function AddGlow(parent, color, size)
    size = size or 20
    color = color or Theme.GlowColor
    
    local glow = CreateElement("ImageLabel", {
        Name = "Glow",
        Parent = parent,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, size, 1, size),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = color,
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = 0
    })
    
    return glow
end

-- Pulse glow effect
local function PulseGlow(glow, intensity)
    intensity = intensity or 0.3
    if not glow then return end
    
    task.spawn(function()
        while glow.Parent do
            Tween(glow, {ImageTransparency = intensity}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1)
            Tween(glow, {ImageTransparency = 0.5}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1)
        end
    end)
end

local function RGBtoHSV(r, g, b)
    r, g, b = r / 255, g / 255, b / 255
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v
    v = max
    local d = max - min
    s = max == 0 and 0 or d / max
    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    return h * 360, s * 100, v * 100
end

local function HSVtoRGB(h, s, v)
    h, s, v = h / 360, s / 100, v / 100
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

-- Icon System
local Icons = {
    Home = "rbxassetid://10734950309",
    User = "rbxassetid://10734949856",
    Settings = "rbxassetid://10734950309",
    Eye = "rbxassetid://10747372992",
    Zap = "rbxassetid://10747374131",
    Shield = "rbxassetid://10747373176",
    Tool = "rbxassetid://10747384394",
    Info = "rbxassetid://10734920149",
    Check = "rbxassetid://10709818534",
    X = "rbxassetid://10747384394",
    Lock = "rbxassetid://10747372992"
}

-- ════════════════════════════════════════════════════════════════════════
-- MAIN LIBRARY
-- ════════════════════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Script Hub"
    local Subtitle = config.Subtitle or "script.lua"
    local Size = config.Size or UDim2.new(0, IsMobile() and 400 or 560, 0, IsMobile() and 450 or 380)
    local ThemeName = config.Theme or ACTIVE_THEME
    
    -- Override theme if specified
    if ThemeName and ThemePresets[ThemeName] then
        Theme = ThemePresets[ThemeName]
    end
    
    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = Size,
        Keybinds = {}
    }
    
    local AllSections = {}
    
    -- Create ScreenGui
    local ScreenGui = CreateElement("ScreenGui", {
        Name = "ModernUI_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 999
    })
    
    -- Main Container
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = Size,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    CreateElement("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 10)
    })
    
    -- Add gradient to main frame
    AddGradient(MainFrame, Theme.Background, Theme.BackgroundGradient, 45)
    
    -- Drop Shadow with glow
    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 50, 1, 50),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Theme.GlowColor,
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -1
    })
    
    -- Title Bar
    local TitleBar = CreateElement("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = TitleBar,
        CornerRadius = UDim.new(0, 10)
    })
    
    -- Add gradient to title bar
    AddGradient(TitleBar, Theme.Sidebar, Theme.SidebarGradient, 90)
    
    local TitleBarCover = CreateElement("Frame", {
        Name = "Cover",
        Parent = TitleBar,
        Position = UDim2.new(0, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    AddGradient(TitleBarCover, Theme.Sidebar, Theme.SidebarGradient, 90)
    
    -- Status indicator with glow
    local StatusIndicator = CreateElement("Frame", {
        Name = "Status",
        Parent = TitleBar,
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(0, 8, 0, 8),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Success,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = StatusIndicator,
        CornerRadius = UDim.new(1, 0)
    })
    
    local statusGlow = AddGlow(StatusIndicator, Theme.Success, 10)
    PulseGlow(statusGlow, 0.2)
    
    task.spawn(function()
        while ScreenGui.Parent do
            Tween(StatusIndicator, {Size = UDim2.new(0, 10, 0, 10)}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1)
            Tween(StatusIndicator, {Size = UDim2.new(0, 8, 0, 8)}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1)
        end
    end)
    
    local TitleLabel = CreateElement("TextLabel", {
        Name = "Title",
        Parent = TitleBar,
        Position = UDim2.new(0, 25, 0, 0),
        Size = UDim2.new(1, -120, 0, 35),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold
    })
    
    local SubtitleLabel = CreateElement("TextLabel", {
        Name = "Subtitle",
        Parent = TitleBar,
        Position = UDim2.new(1, -115, 0, 0),
        Size = UDim2.new(0, 60, 0, 35),
        BackgroundTransparency = 1,
        Text = Subtitle,
        TextColor3 = Theme.TextMuted,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        Font = Enum.Font.Gotham
    })
    
    -- Minimize Button
    local MinimizeButton = CreateElement("TextButton", {
        Name = "Minimize",
        Parent = TitleBar,
        Position = UDim2.new(1, -50, 0, 0),
        Size = UDim2.new(0, 25, 0, 35),
        BackgroundTransparency = 1,
        Text = "−",
        TextColor3 = Theme.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold
    })
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, Size.X.Offset, 0, 35)}, 0.3)
            MinimizeButton.Text = "+"
        else
            Tween(MainFrame, {Size = Size}, 0.3)
            MinimizeButton.Text = "−"
        end
    end)
    
    -- Close Button
    local CloseButton = CreateElement("TextButton", {
        Name = "Close",
        Parent = TitleBar,
        Position = UDim2.new(1, -25, 0, 0),
        Size = UDim2.new(0, 25, 0, 35),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.Error,
        TextSize = 20,
        Font = Enum.Font.GothamBold
    })
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        Tween(MainFrame, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.1)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    -- Content Container
    local ContentContainer = CreateElement("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(1, 0, 1, -35),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })
    
    -- Sidebar
    local Sidebar = CreateElement("Frame", {
        Name = "Sidebar",
        Parent = ContentContainer,
        Size = UDim2.new(0, 50, 1, 0),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    -- Add gradient to sidebar
    AddGradient(Sidebar, Theme.Sidebar, Theme.SidebarGradient, 180)
    
    local SidebarList = CreateElement("UIListLayout", {
        Parent = Sidebar,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })
    
    CreateElement("UIPadding", {
        Parent = Sidebar,
        PaddingTop = UDim.new(0, 8)
    })
    
    -- Page Container
    local PageContainer = CreateElement("Frame", {
        Name = "Pages",
        Parent = ContentContainer,
        Position = UDim2.new(0, 50, 0, 0),
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1
    })
    
    -- ════════════════════════════════════════════════════════════════════════
    -- CREATE PAGE FUNCTION
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:CreatePage(config)
        config = config or {}
        local Name = config.Name or "Page"
        local Icon = config.Icon or Icons.Home
        
        local Page = {
            Name = Name,
            Sections = {},
            Visible = false
        }
        
        -- Page Button
        local PageButton = CreateElement("TextButton", {
            Name = Name,
            Parent = Sidebar,
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = Theme.Sidebar,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false
        })
        
        CreateElement("UICorner", {
            Parent = PageButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        local ButtonGlow = AddGlow(PageButton, Theme.GlowColor, 15)
        ButtonGlow.ImageTransparency = 1
        
        local PageIcon = CreateElement("ImageLabel", {
            Name = "Icon",
            Parent = PageButton,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1,
            Image = Icon,
            ImageColor3 = Theme.TextDark
        })
        
        -- Page Frame
        local PageFrame = CreateElement("ScrollingFrame", {
            Name = Name,
            Parent = PageContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false
        })
        
        CreateElement("UIPadding", {
            Parent = PageFrame,
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        })
        
        CreateElement("UIListLayout", {
            Parent = PageFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        
        -- Page switching with animation
        PageButton.MouseButton1Click:Connect(function()
            for _, p in pairs(Window.Pages) do
                if p.PageFrame then
                    -- Fade out current page
                    Tween(p.PageFrame, {Position = UDim2.new(0, 20, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
                        p.PageFrame.Visible = false
                    end)
                    
                    p.Visible = false
                    if p.PageButton then
                        Tween(p.PageButton, {BackgroundColor3 = Theme.Sidebar}, 0.2)
                        Tween(p.PageIcon, {ImageColor3 = Theme.TextDark}, 0.2)
                        if p.ButtonGlow then
                            Tween(p.ButtonGlow, {ImageTransparency = 1}, 0.2)
                        end
                    end
                end
            end
            
            -- Fade in new page
            PageFrame.Position = UDim2.new(0, -20, 0, 0)
            PageFrame.Visible = true
            Tween(PageFrame, {Position = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            
            Page.Visible = true
            Window.CurrentPage = Page
            Tween(PageButton, {BackgroundColor3 = Theme.SidebarActive}, 0.2)
            Tween(PageIcon, {ImageColor3 = Theme.Text}, 0.2)
            Tween(ButtonGlow, {ImageTransparency = 0.5}, 0.2)
        end)
        
        PageButton.MouseEnter:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundColor3 = Theme.SidebarHover}, 0.2)
                Tween(PageIcon, {ImageColor3 = Theme.Text}, 0.2)
            end
        end)
        
        PageButton.MouseLeave:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundColor3 = Theme.Sidebar}, 0.2)
                Tween(PageIcon, {ImageColor3 = Theme.TextDark}, 0.2)
            end
        end)
        
        Page.PageButton = PageButton
        Page.PageFrame = PageFrame
        Page.PageIcon = PageIcon
        Page.ButtonGlow = ButtonGlow
        
        table.insert(Window.Pages, Page)
        
        -- Auto-select first page
        if #Window.Pages == 1 then
            PageButton.MouseButton1Click:Fire()
        end
        
        -- ════════════════════════════════════════════════════════════════════════
        -- CREATE SECTION FUNCTION
        -- ════════════════════════════════════════════════════════════════════════
        
        function Page:CreateSection(name)
            name = name or "Section"
            
            local Section = {
                Name = name,
                Elements = {},
                Left = nil,
                Right = nil
            }
            
            local SectionFrame = CreateElement("Frame", {
                Name = name,
                Parent = PageFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = SectionFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            -- Section Header
            local SectionHeader = CreateElement("TextLabel", {
                Name = "Header",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                LayoutOrder = 1
            })
            
            -- Two Column Layout
            local ColumnsFrame = CreateElement("Frame", {
                Name = "Columns",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            })
            
            CreateElement("UIListLayout", {
                Parent = ColumnsFrame,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            -- Left Column
            local LeftColumn = CreateElement("Frame", {
                Name = "Left",
                Parent = ColumnsFrame,
                Size = UDim2.new(0.5, -4, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            })
            
            CreateElement("UIListLayout", {
                Parent = LeftColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6)
            })
            
            -- Right Column
            local RightColumn = CreateElement("Frame", {
                Name = "Right",
                Parent = ColumnsFrame,
                Size = UDim2.new(0.5, -4, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            })
            
            CreateElement("UIListLayout", {
                Parent = RightColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6)
            })
            
            Section.Left = LeftColumn
            Section.Right = RightColumn
            Section.Frame = SectionFrame
            
            local function GetSmallestColumn()
                local leftHeight = LeftColumn.AbsoluteSize.Y
                local rightHeight = RightColumn.AbsoluteSize.Y
                return leftHeight <= rightHeight and LeftColumn or RightColumn
            end
            
            table.insert(Page.Sections, Section)
            table.insert(AllSections, Section)
            
            -- Helper for locked elements
            local function CreateLockOverlay(parent, reason)
                local Overlay = CreateElement("Frame", {
                    Name = "LockOverlay",
                    Parent = parent,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 0.6,
                    BorderSizePixel = 0,
                    ZIndex = 50
                })
                
                CreateElement("UICorner", {
                    Parent = Overlay,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local LockIcon = CreateElement("ImageLabel", {
                    Name = "LockIcon",
                    Parent = Overlay,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, reason and -8 or 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    BackgroundTransparency = 1,
                    Image = Icons.Lock,
                    ImageColor3 = Theme.Warning,
                    ZIndex = 51
                })
                
                if reason then
                    local ReasonLabel = CreateElement("TextLabel", {
                        Name = "Reason",
                        Parent = Overlay,
                        AnchorPoint = Vector2.new(0.5, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 12),
                        Size = UDim2.new(0.9, 0, 0, 20),
                        BackgroundTransparency = 1,
                        Text = reason,
                        TextColor3 = Theme.Warning,
                        TextSize = 9,
                        Font = Enum.Font.Gotham,
                        TextWrapped = true,
                        TextScaled = false,
                        ZIndex = 51
                    })
                end
                
                return Overlay
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- IMAGE ELEMENT (NEW!)
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddImage(config)
                config = config or {}
                local AssetId = config.AssetId or ""
                local ImageSize = config.Size or UDim2.new(1, 0, 0, 150)
                local Column = config.Column or GetSmallestColumn()
                local Rounded = config.Rounded ~= false
                
                local ImageContainer = CreateElement("Frame", {
                    Name = "Image",
                    Parent = Column,
                    Size = ImageSize,
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                
                if Rounded then
                    CreateElement("UICorner", {
                        Parent = ImageContainer,
                        CornerRadius = UDim.new(0, 8)
                    })
                end
                
                -- Add gradient background
                AddGradient(ImageContainer, Theme.Secondary, Theme.SecondaryGradient, 45)
                
                local Image = CreateElement("ImageLabel", {
                    Name = "ImageLabel",
                    Parent = ImageContainer,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Image = AssetId,
                    ScaleType = Enum.ScaleType.Fit
                })
                
                if Rounded then
                    CreateElement("UICorner", {
                        Parent = Image,
                        CornerRadius = UDim.new(0, 8)
                    })
                end
                
                local ImageObject = {
                    SetImage = function(self, newAssetId)
                        Image.Image = newAssetId
                    end,
                    SetSize = function(self, newSize)
                        ImageContainer.Size = newSize
                    end,
                    RefreshTheme = function()
                        ImageContainer.BackgroundColor3 = Theme.Secondary
                    end
                }
                
                table.insert(Section.Elements, ImageObject)
                return ImageObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- LABEL ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddLabel(config)
                config = config or {}
                local Text = config.Text or "Label"
                local Column = config.Column or GetSmallestColumn()
                
                local Label = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = Text,
                    TextColor3 = Theme.TextDark,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                local LabelObject = {
                    SetText = function(self, text)
                        Label.Text = text
                    end,
                    RefreshTheme = function()
                        Label.TextColor3 = Theme.TextDark
                    end
                }
                
                table.insert(Section.Elements, LabelObject)
                return LabelObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- DIVIDER ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddDivider(config)
                config = config or {}
                local Column = config.Column or GetSmallestColumn()
                
                local Divider = CreateElement("Frame", {
                    Name = "Divider",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Theme.Border,
                    BorderSizePixel = 0
                })
                
                local DividerObject = {
                    RefreshTheme = function()
                        Divider.BackgroundColor3 = Theme.Border
                    end
                }
                
                table.insert(Section.Elements, DividerObject)
                return Divider
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- PARAGRAPH ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddParagraph(config)
                config = config or {}
                local Title = config.Title or "Paragraph"
                local Content = config.Content or "Content"
                local Column = config.Column or GetSmallestColumn()
                
                local Container = CreateElement("Frame", {
                    Name = "Paragraph",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                CreateElement("UIListLayout", {
                    Parent = Container,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 3)
                })
                
                local ParagraphTitle = CreateElement("TextLabel", {
                    Name = "Title",
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = Title,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold,
                    LayoutOrder = 1
                })
                
                local ParagraphContent = CreateElement("TextLabel", {
                    Name = "Content",
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Content,
                    TextColor3 = Theme.TextDark,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Font = Enum.Font.Gotham,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2
                })
                
                local ParagraphObject = {
                    SetTitle = function(self, title)
                        ParagraphTitle.Text = title
                    end,
                    SetContent = function(self, content)
                        ParagraphContent.Text = content
                    end,
                    RefreshTheme = function()
                        ParagraphTitle.TextColor3 = Theme.Text
                        ParagraphContent.TextColor3 = Theme.TextDark
                    end
                }
                
                table.insert(Section.Elements, ParagraphObject)
                return ParagraphObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- TOGGLE ELEMENT (with Lock, ForceState, and Glow)
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                local Locked = config.Locked or false
                local LockReason = config.LockReason or "This feature is locked"
                
                local currentValue = Default
                
                local Toggle = CreateElement("Frame", {
                    Name = "Toggle",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Toggle,
                    CornerRadius = UDim.new(0, 6)
                })
                
                -- Add gradient
                AddGradient(Toggle, Theme.Secondary, Theme.SecondaryGradient, 90)
                
                local ToggleStroke = CreateElement("UIStroke", {
                    Parent = Toggle,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Toggle,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -65, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                
                local ToggleSwitch = CreateElement("Frame", {
                    Name = "Switch",
                    Parent = Toggle,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 40, 0, 20),
                    BackgroundColor3 = Default and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleSwitch,
                    CornerRadius = UDim.new(1, 0)
                })
                
                -- Add glow to active toggle
                local toggleGlow = AddGlow(ToggleSwitch, Theme.GlowColor, 12)
                toggleGlow.ImageTransparency = Default and 0.4 or 1
                if Default then
                    PulseGlow(toggleGlow, 0.3)
                end
                
                local ToggleKnob = CreateElement("Frame", {
                    Name = "Knob",
                    Parent = ToggleSwitch,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = Default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleKnob,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local ToggleButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Toggle,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 2
                })
                
                local function UpdateToggle(value, triggerCallback)
                    currentValue = value
                    
                    Tween(ToggleSwitch, {BackgroundColor3 = value and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
                    Tween(ToggleKnob, {Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    
                    if value then
                        Tween(toggleGlow, {ImageTransparency = 0.4}, 0.2)
                        if not toggleGlow:FindFirstChild("PulseActive") then
                            local marker = Instance.new("BoolValue")
                            marker.Name = "PulseActive"
                            marker.Parent = toggleGlow
                            PulseGlow(toggleGlow, 0.3)
                        end
                    else
                        Tween(toggleGlow, {ImageTransparency = 1}, 0.2)
                        local marker = toggleGlow:FindFirstChild("PulseActive")
                        if marker then marker:Destroy() end
                    end
                    
                    if triggerCallback then
                        Callback(value)
                    end
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    if Locked then return end
                    UpdateToggle(not currentValue, true)
                end)
                
                local lockOverlay = nil
                if Locked then
                    lockOverlay = CreateLockOverlay(Toggle, LockReason)
                end
                
                local ToggleObject = {
                    SetValue = function(self, value)
                        UpdateToggle(value, true)
                    end,
                    ForceState = function(self, value)
                        UpdateToggle(value, false)
                    end,
                    Lock = function(self, reason)
                        Locked = true
                        if not lockOverlay then
                            lockOverlay = CreateLockOverlay(Toggle, reason or LockReason)
                        end
                    end,
                    Unlock = function(self)
                        Locked = false
                        if lockOverlay then
                            lockOverlay:Destroy()
                            lockOverlay = nil
                        end
                    end,
                    RefreshTheme = function()
                        Toggle.BackgroundColor3 = Theme.Secondary
                        ToggleStroke.Color = Theme.Border
                        ToggleLabel.TextColor3 = Theme.Text
                        ToggleSwitch.BackgroundColor3 = currentValue and Theme.ToggleOn or Theme.ToggleOff
                        ToggleKnob.BackgroundColor3 = Theme.Text
                    end
                }
                
                table.insert(Section.Elements, ToggleObject)
                return ToggleObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- SLIDER ELEMENT (with Gradient!)
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddSlider(config)
                config = config or {}
                local Name = config.Name or "Slider"
                local Min = config.Min or 0
                local Max = config.Max or 100
                local Default = config.Default or Min
                local Increment = config.Increment or 1
                local Suffix = config.Suffix or ""
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                local Locked = config.Locked or false
                local LockReason = config.LockReason or "This feature is locked"
                
                local currentValue = Default
                
                local Slider = CreateElement("Frame", {
                    Name = "Slider",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Slider,
                    CornerRadius = UDim.new(0, 6)
                })
                
                -- Add gradient
                AddGradient(Slider, Theme.Secondary, Theme.SecondaryGradient, 90)
                
                local SliderStroke = CreateElement("UIStroke", {
                    Parent = Slider,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Slider,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 16),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local SliderValue = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = Slider,
                    Position = UDim2.new(1, -12, 0, 8),
                    Size = UDim2.new(0, 50, 0, 16),
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(Default) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamBold
                })
                
                local SliderTrack = CreateElement("Frame", {
                    Name = "Track",
                    Parent = Slider,
                    Position = UDim2.new(0, 12, 1, -16),
                    Size = UDim2.new(1, -24, 0, 4),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderTrack,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderFill = CreateElement("Frame", {
                    Name = "Fill",
                    Parent = SliderTrack,
                    Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                -- Add gradient to slider fill
                AddGradient(SliderFill, Theme.Accent, Theme.AccentGradient, 0)
                
                -- Add glow to slider fill
                local sliderGlow = AddGlow(SliderFill, Theme.GlowColor, 8)
                sliderGlow.ImageTransparency = 0.5
                PulseGlow(sliderGlow, 0.4)
                
                local SliderKnob = CreateElement("Frame", {
                    Name = "Knob",
                    Parent = SliderFill,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.new(0, 12, 0, 12),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderKnob,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local knobGlow = AddGlow(SliderKnob, Theme.GlowColor, 10)
                knobGlow.ImageTransparency = 0.6
                
                local dragging = false
                
                local function UpdateSlider(value, triggerCallback)
                    value = math.clamp(value, Min, Max)
                    value = math.floor(value / Increment + 0.5) * Increment
                    currentValue = value
                    
                    local percent = (value - Min) / (Max - Min)
                    Tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    SliderValue.Text = tostring(value) .. Suffix
                    
                    if triggerCallback then
                        Callback(value)
                    end
                end
                
                local function HandleInput(input)
                    if Locked then return end
                    
                    local pos = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                    pos = math.clamp(pos, 0, 1)
                    local value = Min + (Max - Min) * pos
                    UpdateSlider(value, true)
                end
                
                SliderTrack.InputBegan:Connect(function(input)
                    if Locked then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        HandleInput(input)
                        Tween(SliderKnob, {Size = UDim2.new(0, 14, 0, 14)}, 0.1)
                        Tween(knobGlow, {ImageTransparency = 0.3}, 0.1)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        HandleInput(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Tween(SliderKnob, {Size = UDim2.new(0, 12, 0, 12)}, 0.1)
                        Tween(knobGlow, {ImageTransparency = 0.6}, 0.1)
                    end
                end)
                
                local lockOverlay = nil
                if Locked then
                    lockOverlay = CreateLockOverlay(Slider, LockReason)
                end
                
                local SliderObject = {
                    SetValue = function(self, value)
                        UpdateSlider(value, true)
                    end,
                    Lock = function(self, reason)
                        Locked = true
                        if not lockOverlay then
                            lockOverlay = CreateLockOverlay(Slider, reason or LockReason)
                        end
                    end,
                    Unlock = function(self)
                        Locked = false
                        if lockOverlay then
                            lockOverlay:Destroy()
                            lockOverlay = nil
                        end
                    end,
                    RefreshTheme = function()
                        Slider.BackgroundColor3 = Theme.Secondary
                        SliderStroke.Color = Theme.Border
                        SliderLabel.TextColor3 = Theme.Text
                        SliderValue.TextColor3 = Theme.Accent
                        SliderTrack.BackgroundColor3 = Theme.Tertiary
                        SliderFill.BackgroundColor3 = Theme.Accent
                        SliderKnob.BackgroundColor3 = Theme.Text
                    end
                }
                
                table.insert(Section.Elements, SliderObject)
                return SliderObject
            end
            
            -- Continue with other elements (Dropdown, Button, Textbox, ColorPicker, Keybind)
            -- For brevity, I'll include the most important ones with gradient/glow enhancements
            
            -- ════════════════════════════════════════════════════════════════════════
            -- DROPDOWN ELEMENT (with animations)
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or {"Option 1", "Option 2"}
                local Default = config.Default or Options[1]
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                local Locked = config.Locked or false
                local LockReason = config.LockReason or "This feature is locked"
                
                local currentValue = Default
                local isOpen = false
                
                local Dropdown = CreateElement("Frame", {
                    Name = "Dropdown",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ClipsDescendants = false,
                    ZIndex = 10
                })
                
                CreateElement("UICorner", {
                    Parent = Dropdown,
                    CornerRadius = UDim.new(0, 6)
                })
                
                AddGradient(Dropdown, Theme.Secondary, Theme.SecondaryGradient, 90)
                
                local DropdownStroke = CreateElement("UIStroke", {
                    Parent = Dropdown,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local DropdownLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Dropdown,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -100, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                
                local DropdownValue = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = Dropdown,
                    Position = UDim2.new(1, -30, 0, 0),
                    Size = UDim2.new(0, 80, 1, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Text = currentValue,
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                
                local DropdownArrow = CreateElement("TextLabel", {
                    Name = "Arrow",
                    Parent = Dropdown,
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham
                })
                
                local OptionsFrame = CreateElement("Frame", {
                    Name = "Options",
                    Parent = Dropdown,
                    Position = UDim2.new(0, 0, 1, 4),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Visible = false,
                    ZIndex = 15
                })
                
                CreateElement("UICorner", {
                    Parent = OptionsFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                AddGradient(OptionsFrame, Theme.Tertiary, Theme.Secondary, 90)
                
                local OptionsStroke = CreateElement("UIStroke", {
                    Parent = OptionsFrame,
                    Color = Theme.Accent,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local OptionsList = CreateElement("UIListLayout", {
                    Parent = OptionsFrame,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2)
                })
                
                CreateElement("UIPadding", {
                    Parent = OptionsFrame,
                    PaddingTop = UDim.new(0, 4),
                    PaddingBottom = UDim.new(0, 4),
                    PaddingLeft = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 4)
                })
                
                for _, option in ipairs(Options) do
                    local OptionButton = CreateElement("TextButton", {
                        Name = option,
                        Parent = OptionsFrame,
                        Size = UDim2.new(1, 0, 0, 26),
                        BackgroundColor3 = currentValue == option and Theme.SidebarActive or Theme.Secondary,
                        BorderSizePixel = 0,
                        Text = option,
                        TextColor3 = Theme.Text,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        ZIndex = 16
                    })
                    
                    CreateElement("UICorner", {
                        Parent = OptionButton,
                        CornerRadius = UDim.new(0, 4)
                    })
                    
                    OptionButton.MouseEnter:Connect(function()
                        if currentValue ~= option then
                            Tween(OptionButton, {BackgroundColor3 = Theme.SidebarHover}, 0.1)
                        end
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        if currentValue ~= option then
                            Tween(OptionButton, {BackgroundColor3 = Theme.Secondary}, 0.1)
                        end
                    end)
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        if Locked then return end
                        currentValue = option
                        DropdownValue.Text = option
                        
                        for _, btn in ipairs(OptionsFrame:GetChildren()) do
                            if btn:IsA("TextButton") then
                                Tween(btn, {BackgroundColor3 = Theme.Secondary}, 0.1)
                            end
                        end
                        
                        Tween(OptionButton, {BackgroundColor3 = Theme.SidebarActive}, 0.1)
                        Callback(option)
                        
                        -- Close dropdown
                        isOpen = false
                        Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
                            OptionsFrame.Visible = false
                        end)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end)
                end
                
                local DropdownButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Dropdown,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 11
                })
                
                DropdownButton.MouseButton1Click:Connect(function()
                    if Locked then return end
                    isOpen = not isOpen
                    
                    if isOpen then
                        OptionsFrame.Visible = true
                        OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
                        local targetHeight = math.min(#Options * 28 + 8, 200)
                        Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        Tween(DropdownArrow, {Rotation = 180}, 0.2)
                    else
                        Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
                            OptionsFrame.Visible = false
                        end)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end
                end)
                
                local lockOverlay = nil
                if Locked then
                    lockOverlay = CreateLockOverlay(Dropdown, LockReason)
                end
                
                local DropdownObject = {
                    SetValue = function(self, value)
                        if table.find(Options, value) then
                            currentValue = value
                            DropdownValue.Text = value
                            
                            for _, btn in ipairs(OptionsFrame:GetChildren()) do
                                if btn:IsA("TextButton") then
                                    Tween(btn, {BackgroundColor3 = btn.Name == value and Theme.SidebarActive or Theme.Secondary}, 0.1)
                                end
                            end
                            
                            Callback(value)
                        end
                    end,
                    Lock = function(self, reason)
                        Locked = true
                        if not lockOverlay then
                            lockOverlay = CreateLockOverlay(Dropdown, reason or LockReason)
                        end
                    end,
                    Unlock = function(self)
                        Locked = false
                        if lockOverlay then
                            lockOverlay:Destroy()
                            lockOverlay = nil
                        end
                    end,
                    RefreshTheme = function()
                        Dropdown.BackgroundColor3 = Theme.Secondary
                        DropdownStroke.Color = Theme.Border
                        DropdownLabel.TextColor3 = Theme.Text
                        DropdownValue.TextColor3 = Theme.Accent
                        OptionsFrame.BackgroundColor3 = Theme.Tertiary
                        OptionsStroke.Color = Theme.Accent
                    end
                }
                
                table.insert(Section.Elements, DropdownObject)
                return DropdownObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- BUTTON ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddButton(config)
                config = config or {}
                local Name = config.Name or "Button"
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                local Locked = config.Locked or false
                local LockReason = config.LockReason or "This feature is locked"
                
                local Button = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = Button,
                    CornerRadius = UDim.new(0, 6)
                })
                
                AddGradient(Button, Theme.Accent, Theme.AccentGradient, 90)
                
                local buttonGlow = AddGlow(Button, Theme.GlowColor, 15)
                buttonGlow.ImageTransparency = 0.6
                
                Button.MouseEnter:Connect(function()
                    if not Locked then
                        Tween(Button, {Size = UDim2.new(1, 0, 0, 37)}, 0.1)
                        Tween(buttonGlow, {ImageTransparency = 0.3}, 0.1)
                    end
                end)
                
                Button.MouseLeave:Connect(function()
                    if not Locked then
                        Tween(Button, {Size = UDim2.new(1, 0, 0, 35)}, 0.1)
                        Tween(buttonGlow, {ImageTransparency = 0.6}, 0.1)
                    end
                end)
                
                Button.MouseButton1Click:Connect(function()
                    if Locked then return end
                    
                    -- Click animation
                    Tween(Button, {Size = UDim2.new(1, 0, 0, 33)}, 0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
                        Tween(Button, {Size = UDim2.new(1, 0, 0, 35)}, 0.05)
                    end)
                    
                    Callback()
                end)
                
                local lockOverlay = nil
                if Locked then
                    lockOverlay = CreateLockOverlay(Button, LockReason)
                end
                
                local ButtonObject = {
                    Lock = function(self, reason)
                        Locked = true
                        if not lockOverlay then
                            lockOverlay = CreateLockOverlay(Button, reason or LockReason)
                        end
                    end,
                    Unlock = function(self)
                        Locked = false
                        if lockOverlay then
                            lockOverlay:Destroy()
                            lockOverlay = nil
                        end
                    end,
                    RefreshTheme = function()
                        Button.BackgroundColor3 = Theme.Accent
                        Button.TextColor3 = Theme.Text
                    end
                }
                
                table.insert(Section.Elements, ButtonObject)
                return ButtonObject
            end
            -- ════════════════════════════════════════════════════════════════════════
-- PARAGRAPH ELEMENT
-- ════════════════════════════════════════════════════════════════════════

function Section:AddParagraph(config)
    config = config or {}
    local Title = config.Title or "Paragraph"
    local Content = config.Content or ""
    
    local ParagraphFrame = CreateElement("Frame", {
        Name = "Paragraph",
        Parent = SectionContent,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    CreateElement("UIListLayout", {
        Parent = ParagraphFrame,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    local ParagraphTitle = CreateElement("TextLabel", {
        Name = "Title",
        Parent = ParagraphFrame,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local ParagraphContent = CreateElement("TextLabel", {
        Name = "Content",
        Parent = ParagraphFrame,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = Content,
        TextColor3 = Theme.TextDark,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local ParagraphObject = {
        SetTitle = function(self, title)
            ParagraphTitle.Text = title
        end,
        SetContent = function(self, content)
            ParagraphContent.Text = content
        end,
        RefreshTheme = function()
            ParagraphTitle.TextColor3 = Theme.Text
            ParagraphContent.TextColor3 = Theme.TextDark
        end
    }
    
    table.insert(Section.Elements, ParagraphObject)
    return ParagraphObject
end

-- ════════════════════════════════════════════════════════════════════════
-- DROPDOWN ELEMENT (with smooth animations)
-- ════════════════════════════════════════════════════════════════════════

function Section:AddDropdown(config)
    config = config or {}
    local DropdownName = config.Name or "Dropdown"
    local Options = config.Options or {"Option 1", "Option 2", "Option 3"}
    local Default = config.Default or Options[1]
    local Callback = config.Callback or function() end
    local Locked = config.Locked or false
    local LockReason = config.LockReason or "Locked"
    
    local CurrentValue = Default
    local IsOpen = false
    
    local DropdownFrame = CreateElement("Frame", {
        Name = "Dropdown",
        Parent = SectionContent,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    CreateElement("UICorner", {
        Parent = DropdownFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    local DropdownButton = CreateElement("TextButton", {
        Name = "Button",
        Parent = DropdownFrame,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    })
    
    local DropdownLabel = CreateElement("TextLabel", {
        Name = "Label",
        Parent = DropdownFrame,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -45, 0, 35),
        BackgroundTransparency = 1,
        Text = DropdownName,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham
    })
    
    local DropdownValue = CreateElement("TextLabel", {
        Name = "Value",
        Parent = DropdownFrame,
        Position = UDim2.new(0, 12, 0, 35),
        Size = UDim2.new(1, -24, 0, 20),
        BackgroundTransparency = 1,
        Text = CurrentValue,
        TextColor3 = Theme.Accent,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold
    })
    
    local ArrowIcon = CreateElement("TextLabel", {
        Name = "Arrow",
        Parent = DropdownFrame,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 0),
        Size = UDim2.new(0, 35, 0, 35),
        BackgroundTransparency = 1,
        Text = "⌄",
        TextColor3 = Theme.TextMuted,
        TextSize = 16,
        Font = Enum.Font.GothamBold
    })
    
    local OptionsContainer = CreateElement("Frame", {
        Name = "Options",
        Parent = DropdownFrame,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    
    CreateElement("UIListLayout", {
        Parent = OptionsContainer,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    CreateElement("UIPadding", {
        Parent = OptionsContainer,
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 8)
    })
    
    for _, option in ipairs(Options) do
        local OptionButton = CreateElement("TextButton", {
            Name = option,
            Parent = OptionsContainer,
            Size = UDim2.new(1, 0, 0, 25),
            BackgroundColor3 = option == CurrentValue and Theme.Accent or Theme.Background,
            Text = option,
            TextColor3 = Theme.Text,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            AutoButtonColor = false
        })
        
        CreateElement("UICorner", {
            Parent = OptionButton,
            CornerRadius = UDim.new(0, 4)
        })
        
        OptionButton.MouseEnter:Connect(function()
            if option ~= CurrentValue then
                Tween(OptionButton, {BackgroundColor3 = Theme.Secondary}, 0.1)
            end
        end)
        
        OptionButton.MouseLeave:Connect(function()
            if option ~= CurrentValue then
                Tween(OptionButton, {BackgroundColor3 = Theme.Background}, 0.1)
            end
        end)
        
        OptionButton.MouseButton1Click:Connect(function()
            if Locked then return end
            
            CurrentValue = option
            DropdownValue.Text = option
            Callback(option)
            
            for _, child in ipairs(OptionsContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    if child.Text == option then
                        Tween(child, {BackgroundColor3 = Theme.Accent}, 0.2)
                    else
                        Tween(child, {BackgroundColor3 = Theme.Background}, 0.2)
                    end
                end
            end
            
            task.wait(0.1)
            IsOpen = false
            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.3, Enum.EasingStyle.Quad)
            Tween(ArrowIcon, {Rotation = 0}, 0.2)
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        if Locked then return end
        
        IsOpen = not IsOpen
        
        if IsOpen then
            task.wait()
            local containerHeight = OptionsContainer.AbsoluteSize.Y
            local targetHeight = 60 + containerHeight
            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.3, Enum.EasingStyle.Quad)
            Tween(ArrowIcon, {Rotation = 180}, 0.2)
        else
            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.3, Enum.EasingStyle.Quad)
            Tween(ArrowIcon, {Rotation = 0}, 0.2)
        end
    end)
    
    local lockOverlay = nil
    if Locked then
        lockOverlay = CreateLockOverlay(DropdownFrame, LockReason)
    end
    
    local DropdownObject = {
        SetValue = function(self, value)
            if table.find(Options, value) then
                CurrentValue = value
                DropdownValue.Text = value
                
                for _, child in ipairs(OptionsContainer:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = (child.Text == value) and Theme.Accent or Theme.Background
                    end
                end
            end
        end,
        Lock = function(self, reason)
            Locked = true
            if not lockOverlay then
                lockOverlay = CreateLockOverlay(DropdownFrame, reason or LockReason)
            end
        end,
        Unlock = function(self)
            Locked = false
            if lockOverlay then
                lockOverlay:Destroy()
                lockOverlay = nil
            end
        end,
        RefreshTheme = function()
            DropdownFrame.BackgroundColor3 = Theme.Tertiary
            DropdownLabel.TextColor3 = Theme.Text
            DropdownValue.TextColor3 = Theme.Accent
        end
    }
    
    table.insert(Section.Elements, DropdownObject)
    return DropdownObject
end

-- ════════════════════════════════════════════════════════════════════════
-- TEXTBOX ELEMENT
-- ════════════════════════════════════════════════════════════════════════

function Section:AddTextbox(config)
    config = config or {}
    local TextboxName = config.Name or "Textbox"
    local Default = config.Default or ""
    local Placeholder = config.Placeholder or "Enter text..."
    local NumbersOnly = config.NumbersOnly or false
    local Callback = config.Callback or function() end
    local Locked = config.Locked or false
    local LockReason = config.LockReason or "Locked"
    
    local TextboxFrame = CreateElement("Frame", {
        Name = "Textbox",
        Parent = SectionContent,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = TextboxFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    local TextboxLabel = CreateElement("TextLabel", {
        Name = "Label",
        Parent = TextboxFrame,
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 14),
        BackgroundTransparency = 1,
        Text = TextboxName,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham
    })
    
    local TextboxInput = CreateElement("TextBox", {
        Name = "Input",
        Parent = TextboxFrame,
        Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -24, 0, 25),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Text = Default,
        PlaceholderText = Placeholder,
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.TextMuted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false
    })
    
    CreateElement("UICorner", {
        Parent = TextboxInput,
        CornerRadius = UDim.new(0, 4)
    })
    
    CreateElement("UIPadding", {
        Parent = TextboxInput,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    })
    
    if NumbersOnly then
        TextboxInput:GetPropertyChangedSignal("Text"):Connect(function()
            TextboxInput.Text = TextboxInput.Text:gsub("%D", "")
        end)
    end
    
    TextboxInput.FocusLost:Connect(function(enterPressed)
        if Locked then return end
        Callback(TextboxInput.Text, enterPressed)
    end)
    
    local lockOverlay = nil
    if Locked then
        lockOverlay = CreateLockOverlay(TextboxFrame, LockReason)
    end
    
    local TextboxObject = {
        SetValue = function(self, value)
            TextboxInput.Text = tostring(value)
        end,
        GetValue = function(self)
            return TextboxInput.Text
        end,
        Lock = function(self, reason)
            Locked = true
            TextboxInput.TextEditable = false
            if not lockOverlay then
                lockOverlay = CreateLockOverlay(TextboxFrame, reason or LockReason)
            end
        end,
        Unlock = function(self)
            Locked = false
            TextboxInput.TextEditable = true
            if lockOverlay then
                lockOverlay:Destroy()
                lockOverlay = nil
            end
        end,
        RefreshTheme = function()
            TextboxFrame.BackgroundColor3 = Theme.Tertiary
            TextboxLabel.TextColor3 = Theme.Text
            TextboxInput.BackgroundColor3 = Theme.Background
            TextboxInput.TextColor3 = Theme.Text
        end
    }
    
    table.insert(Section.Elements, TextboxObject)
    return TextboxObject
end

-- ════════════════════════════════════════════════════════════════════════
-- COLOR PICKER ELEMENT (RGB sliders)
-- ════════════════════════════════════════════════════════════════════════

function Section:AddColorPicker(config)
    config = config or {}
    local PickerName = config.Name or "Color Picker"
    local Default = config.Default or Color3.fromRGB(255, 255, 255)
    local Callback = config.Callback or function() end
    
    local CurrentColor = Default
    local IsOpen = false
    
    local PickerFrame = CreateElement("Frame", {
        Name = "ColorPicker",
        Parent = SectionContent,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    CreateElement("UICorner", {
        Parent = PickerFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    local PickerButton = CreateElement("TextButton", {
        Name = "Button",
        Parent = PickerFrame,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    })
    
    local PickerLabel = CreateElement("TextLabel", {
        Name = "Label",
        Parent = PickerFrame,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -55, 0, 35),
        BackgroundTransparency = 1,
        Text = PickerName,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham
    })
    
    local ColorDisplay = CreateElement("Frame", {
        Name = "ColorDisplay",
        Parent = PickerFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0, 17.5),
        Size = UDim2.new(0, 30, 0, 20),
        BackgroundColor3 = CurrentColor,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = ColorDisplay,
        CornerRadius = UDim.new(0, 4)
    })
    
    CreateElement("UIStroke", {
        Parent = ColorDisplay,
        Color = Theme.Border,
        Thickness = 1
    })
    
    local SlidersContainer = CreateElement("Frame", {
        Name = "Sliders",
        Parent = PickerFrame,
        Position = UDim2.new(0, 12, 0, 45),
        Size = UDim2.new(1, -24, 0, 120),
        BackgroundTransparency = 1
    })
    
    local rgbValues = {
        R = math.floor(CurrentColor.R * 255),
        G = math.floor(CurrentColor.G * 255),
        B = math.floor(CurrentColor.B * 255)
    }
    
    local function CreateColorSlider(name, yPos, color, getValue, setValue)
        local sliderFrame = CreateElement("Frame", {
            Parent = SlidersContainer,
            Position = UDim2.new(0, 0, 0, yPos),
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1
        })
        
        local label = CreateElement("TextLabel", {
            Parent = sliderFrame,
            Size = UDim2.new(0, 15, 0, 30),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            Font = Enum.Font.GothamBold
        })
        
        local track = CreateElement("Frame", {
            Parent = sliderFrame,
            Position = UDim2.new(0, 25, 0.5, -2),
            Size = UDim2.new(1, -55, 0, 4),
            BackgroundColor3 = color,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = track,
            CornerRadius = UDim.new(1, 0)
        })
        
        local value = getValue()
        local knob = CreateElement("Frame", {
            Parent = track,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(value / 255, 0, 0.5, 0),
            Size = UDim2.new(0, 10, 0, 10),
            BackgroundColor3 = Theme.Text,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = knob,
            CornerRadius = UDim.new(1, 0)
        })
        
        local valueLabel = CreateElement("TextLabel", {
            Parent = sliderFrame,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 25, 0, 30),
            BackgroundTransparency = 1,
            Text = tostring(value),
            TextColor3 = Theme.TextDark,
            TextSize = 10,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Right
        })
        
        local dragging = false
        
        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                
                local function update()
                    local mousePos = UserInputService:GetMouseLocation().X
                    local trackPos = track.AbsolutePosition.X
                    local trackSize = track.AbsoluteSize.X
                    local percent = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
                    local newValue = math.floor(percent * 255)
                    
                    setValue(newValue)
                    knob.Position = UDim2.new(percent, 0, 0.5, 0)
                    valueLabel.Text = tostring(newValue)
                    
                    CurrentColor = Color3.fromRGB(rgbValues.R, rgbValues.G, rgbValues.B)
                    ColorDisplay.BackgroundColor3 = CurrentColor
                    Callback(CurrentColor)
                end
                
                update()
                
                local moveConn = UserInputService.InputChanged:Connect(function(input2)
                    if input2.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                        update()
                    end
                end)
                
                local endConn = UserInputService.InputEnded:Connect(function(input2)
                    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        moveConn:Disconnect()
                        endConn:Disconnect()
                    end
                end)
            end
        end)
    end
    
    CreateColorSlider("R", 0, Color3.fromRGB(255, 0, 0),
        function() return rgbValues.R end,
        function(v) rgbValues.R = v end
    )
    
    CreateColorSlider("G", 35, Color3.fromRGB(0, 255, 0),
        function() return rgbValues.G end,
        function(v) rgbValues.G = v end
    )
    
    CreateColorSlider("B", 70, Color3.fromRGB(0, 0, 255),
        function() return rgbValues.B end,
        function(v) rgbValues.B = v end
    )
    
    PickerButton.MouseButton1Click:Connect(function()
        IsOpen = not IsOpen
        
        if IsOpen then
            Tween(PickerFrame, {Size = UDim2.new(1, 0, 0, 175)}, 0.3, Enum.EasingStyle.Quad)
        else
            Tween(PickerFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.3, Enum.EasingStyle.Quad)
        end
    end)
    
    local PickerObject = {
        SetColor = function(self, color)
            CurrentColor = color
            ColorDisplay.BackgroundColor3 = color
            rgbValues.R = math.floor(color.R * 255)
            rgbValues.G = math.floor(color.G * 255)
            rgbValues.B = math.floor(color.B * 255)
        end,
        RefreshTheme = function()
            PickerFrame.BackgroundColor3 = Theme.Tertiary
            PickerLabel.TextColor3 = Theme.Text
        end
    }
    
    table.insert(Section.Elements, PickerObject)
    return PickerObject
end

-- ════════════════════════════════════════════════════════════════════════
-- KEYBIND ELEMENT
-- ════════════════════════════════════════════════════════════════════════

function Section:AddKeybind(config)
    config = config or {}
    local KeybindName = config.Name or "Keybind"
    local Default = config.Default or Enum.KeyCode.E
    local Callback = config.Callback or function() end
    
    local CurrentKey = Default
    local Listening = false
    
    local KeybindFrame = CreateElement("Frame", {
        Name = "Keybind",
        Parent = SectionContent,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = KeybindFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    local KeybindLabel = CreateElement("TextLabel", {
        Name = "Label",
        Parent = KeybindFrame,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -90, 0, 35),
        BackgroundTransparency = 1,
        Text = KeybindName,
        TextColor3 = Theme.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham
    })
    
    local KeybindButton = CreateElement("TextButton", {
        Name = "Button",
        Parent = KeybindFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.new(0, 70, 0, 25),
        BackgroundColor3 = Theme.Background,
        Text = CurrentKey.Name,
        TextColor3 = Theme.Accent,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })
    
    CreateElement("UICorner", {
        Parent = KeybindButton,
        CornerRadius = UDim.new(0, 4)
    })
    
    KeybindButton.MouseButton1Click:Connect(function()
        Listening = true
        KeybindButton.Text = "..."
        KeybindButton.TextColor3 = Theme.Warning
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if Listening and input.UserInputType == Enum.UserInputType.Keyboard then
            CurrentKey = input.KeyCode
            KeybindButton.Text = input.KeyCode.Name
            KeybindButton.TextColor3 = Theme.Accent
            Listening = false
        end
        
        if not gameProcessed and input.KeyCode == CurrentKey then
            Callback(CurrentKey)
        end
    end)
    
    local KeybindObject = {
        SetKey = function(self, key)
            CurrentKey = key
            KeybindButton.Text = key.Name
        end,
        RefreshTheme = function()
            KeybindFrame.BackgroundColor3 = Theme.Tertiary
            KeybindLabel.TextColor3 = Theme.Text
            KeybindButton.BackgroundColor3 = Theme.Background
            if not Listening then
                KeybindButton.TextColor3 = Theme.Accent
            end
        end
    }
    
    table.insert(Section.Elements, KeybindObject)
    return KeybindObject
end

-- ════════════════════════════════════════════════════════════════════════
-- IMAGE ELEMENT (NEW in v3.1!)
-- ════════════════════════════════════════════════════════════════════════

function Section:AddImage(config)
    config = config or {}
    local AssetId = config.AssetId or "rbxassetid://6031071053"
    local Size = config.Size or UDim2.new(1, 0, 0, 150)
    local Rounded = config.Rounded ~= false
    
    local ImageFrame = CreateElement("ImageLabel", {
        Name = "Image",
        Parent = SectionContent,
        Size = Size,
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Image = AssetId,
        ScaleType = Enum.ScaleType.Fit
    })
    
    if Rounded then
        CreateElement("UICorner", {
            Parent = ImageFrame,
            CornerRadius = UDim.new(0, 8)
        })
    end
    
    local ImageObject = {
        SetImage = function(self, assetId)
            ImageFrame.Image = assetId
        end,
        SetSize = function(self, size)
            ImageFrame.Size = size
        end,
        RefreshTheme = function()
            ImageFrame.BackgroundColor3 = Theme.Border
        end
    }
    
    table.insert(Section.Elements, ImageObject)
    return ImageObject
end
            
            -- Note: For TextBox, ColorPicker, and Keybind elements, similar enhancements would be applied
            -- I've kept the key ones here to show the pattern. The full implementation would continue...
            
            return Section
        end
        
        return Page
    end
    
    -- ════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION SYSTEM (Enhanced with gradients)
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or ""
        local Duration = config.Duration or 3
        local Type = config.Type or "Info"
        
        local NotificationColors = {
            Success = Theme.Success,
            Warning = Theme.Warning,
            Error = Theme.Error,
            Info = Theme.Info
        }
        
        local Color = NotificationColors[Type] or Theme.Info
        
        local Notification = CreateElement("Frame", {
            Name = "Notification",
            Parent = ScreenGui,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -20, 0, 20),
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0,
            ClipsDescendants = true
        })
        
        CreateElement("UICorner", {
            Parent = Notification,
            CornerRadius = UDim.new(0, 8)
        })
        
        AddGradient(Notification, Theme.Secondary, Theme.Tertiary, 90)
        
        local notifGlow = AddGlow(Notification, Color, 20)
        notifGlow.ImageTransparency = 0.4
        PulseGlow(notifGlow, 0.2)
        
        local NotifStroke = CreateElement("UIStroke", {
            Parent = Notification,
            Color = Color,
            Thickness = 2
        })
        
        local NotifTitle = CreateElement("TextLabel", {
            Name = "Title",
            Parent = Notification,
            Position = UDim2.new(0, 12, 0, 8),
            Size = UDim2.new(1, -24, 0, 18),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold
        })
        
        local NotifContent = CreateElement("TextLabel", {
            Name = "Content",
            Parent = Notification,
            Position = UDim2.new(0, 12, 0, 28),
            Size = UDim2.new(1, -24, 0, 0),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y
        })
        
        task.wait()
        local contentHeight = NotifContent.AbsoluteSize.Y
        local totalHeight = 40 + contentHeight
        
        -- Slide in animation
        Tween(Notification, {Size = UDim2.new(0, 280, 0, totalHeight)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        
        task.delay(Duration, function()
            Tween(Notification, {Size = UDim2.new(0, 0, 0, totalHeight)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, function()
                Notification:Destroy()
            end)
        end)
    end
    
    -- ════════════════════════════════════════════════════════════════════════
    -- THEME SWITCHING
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:SetTheme(themeName)
        if ThemePresets[themeName] then
            Theme = ThemePresets[themeName]
            
            -- Refresh all UI elements
            MainFrame.BackgroundColor3 = Theme.Background
            TitleBar.BackgroundColor3 = Theme.Sidebar
            TitleBarCover.BackgroundColor3 = Theme.Sidebar
            Sidebar.BackgroundColor3 = Theme.Sidebar
            
            for _, section in ipairs(AllSections) do
                for _, element in ipairs(section.Elements) do
                    if element.RefreshTheme then
                        element.RefreshTheme()
                    end
                end
            end
        end
    end
    
    return Window
end

return Library
