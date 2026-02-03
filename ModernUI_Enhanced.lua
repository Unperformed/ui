--[[
    ════════════════════════════════════════════════════════════════════════
    PROFESSIONAL ROBLOX UI LIBRARY - COMPLETE EDITION
    Version: 3.0.0
    Features: Everything a UI Library should have
    ════════════════════════════════════════════════════════════════════════
    
    NEW FEATURES IN V3.0:
    ✓ Color Pickers with RGB/HSV
    ✓ Keybind System
    ✓ Multi-theme Support (6 themes)
    ✓ Element Locking System
    ✓ Labels, Dividers, Paragraphs
    ✓ Input Validation
    ✓ Bind System
    ✓ Force State for Toggles
    ✓ Console Output
    ✓ Mini Color Pickers
    ✓ Image Display
    ✓ And much more!
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════════════════
-- THEME PRESETS - EASILY CHANGE YOUR UI THEME HERE!
-- ════════════════════════════════════════════════════════════════════════

local ThemePresets = {
    -- Default Purple Theme
    Purple = {
        Background = Color3.fromRGB(45, 50, 68),
        Secondary = Color3.fromRGB(55, 60, 78),
        Tertiary = Color3.fromRGB(65, 70, 88),
        Sidebar = Color3.fromRGB(35, 40, 58),
        SidebarHover = Color3.fromRGB(45, 50, 68),
        SidebarActive = Color3.fromRGB(88, 101, 242),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(108, 121, 255),
        AccentDark = Color3.fromRGB(70, 80, 200),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 165, 180),
        TextMuted = Color3.fromRGB(120, 125, 140),
        Border = Color3.fromRGB(75, 80, 98),
        BorderLight = Color3.fromRGB(85, 90, 108),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(88, 101, 242),
        ToggleOff = Color3.fromRGB(80, 85, 100)
    },
    
    -- Dark Red Theme
    Red = {
        Background = Color3.fromRGB(35, 35, 45),
        Secondary = Color3.fromRGB(45, 45, 55),
        Tertiary = Color3.fromRGB(55, 55, 65),
        Sidebar = Color3.fromRGB(25, 25, 35),
        SidebarHover = Color3.fromRGB(35, 35, 45),
        SidebarActive = Color3.fromRGB(220, 38, 38),
        Accent = Color3.fromRGB(220, 38, 38),
        AccentHover = Color3.fromRGB(239, 68, 68),
        AccentDark = Color3.fromRGB(185, 28, 28),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 165, 180),
        TextMuted = Color3.fromRGB(120, 125, 140),
        Border = Color3.fromRGB(75, 75, 85),
        BorderLight = Color3.fromRGB(85, 85, 95),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(220, 38, 38),
        ToggleOff = Color3.fromRGB(80, 80, 90)
    },
    
    -- Ocean Blue Theme
    Ocean = {
        Background = Color3.fromRGB(30, 41, 59),
        Secondary = Color3.fromRGB(40, 51, 69),
        Tertiary = Color3.fromRGB(50, 61, 79),
        Sidebar = Color3.fromRGB(20, 31, 49),
        SidebarHover = Color3.fromRGB(30, 41, 59),
        SidebarActive = Color3.fromRGB(14, 165, 233),
        Accent = Color3.fromRGB(14, 165, 233),
        AccentHover = Color3.fromRGB(34, 185, 253),
        AccentDark = Color3.fromRGB(2, 132, 199),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 165, 180),
        TextMuted = Color3.fromRGB(120, 125, 140),
        Border = Color3.fromRGB(60, 71, 89),
        BorderLight = Color3.fromRGB(70, 81, 99),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(14, 165, 233),
        ToggleOff = Color3.fromRGB(75, 85, 99)
    },
    
    -- Green Matrix Theme
    Matrix = {
        Background = Color3.fromRGB(15, 25, 15),
        Secondary = Color3.fromRGB(20, 30, 20),
        Tertiary = Color3.fromRGB(25, 35, 25),
        Sidebar = Color3.fromRGB(10, 20, 10),
        SidebarHover = Color3.fromRGB(15, 25, 15),
        SidebarActive = Color3.fromRGB(34, 197, 94),
        Accent = Color3.fromRGB(34, 197, 94),
        AccentHover = Color3.fromRGB(74, 222, 128),
        AccentDark = Color3.fromRGB(22, 163, 74),
        Text = Color3.fromRGB(74, 222, 128),
        TextDark = Color3.fromRGB(134, 239, 172),
        TextMuted = Color3.fromRGB(100, 180, 100),
        Border = Color3.fromRGB(35, 45, 35),
        BorderLight = Color3.fromRGB(45, 55, 45),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(250, 204, 21),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(59, 130, 246),
        ToggleOn = Color3.fromRGB(34, 197, 94),
        ToggleOff = Color3.fromRGB(50, 60, 50)
    },
    
    -- Midnight Purple Theme
    Midnight = {
        Background = Color3.fromRGB(15, 15, 35),
        Secondary = Color3.fromRGB(25, 25, 45),
        Tertiary = Color3.fromRGB(35, 35, 55),
        Sidebar = Color3.fromRGB(10, 10, 25),
        SidebarHover = Color3.fromRGB(15, 15, 35),
        SidebarActive = Color3.fromRGB(168, 85, 247),
        Accent = Color3.fromRGB(168, 85, 247),
        AccentHover = Color3.fromRGB(192, 132, 252),
        AccentDark = Color3.fromRGB(147, 51, 234),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 165, 180),
        TextMuted = Color3.fromRGB(120, 125, 140),
        Border = Color3.fromRGB(45, 45, 65),
        BorderLight = Color3.fromRGB(55, 55, 75),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(168, 85, 247),
        ToggleOff = Color3.fromRGB(75, 75, 95)
    },
    
    -- Orange Sunset Theme
    Sunset = {
        Background = Color3.fromRGB(45, 35, 30),
        Secondary = Color3.fromRGB(55, 45, 40),
        Tertiary = Color3.fromRGB(65, 55, 50),
        Sidebar = Color3.fromRGB(35, 25, 20),
        SidebarHover = Color3.fromRGB(45, 35, 30),
        SidebarActive = Color3.fromRGB(249, 115, 22),
        Accent = Color3.fromRGB(249, 115, 22),
        AccentHover = Color3.fromRGB(251, 146, 60),
        AccentDark = Color3.fromRGB(234, 88, 12),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 165, 160),
        TextMuted = Color3.fromRGB(140, 125, 120),
        Border = Color3.fromRGB(75, 65, 60),
        BorderLight = Color3.fromRGB(85, 75, 70),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Info = Color3.fromRGB(52, 152, 219),
        ToggleOn = Color3.fromRGB(249, 115, 22),
        ToggleOff = Color3.fromRGB(100, 85, 80)
    }
}

-- Set your active theme here! Options: Purple, Red, Ocean, Matrix, Midnight, Sunset
local ACTIVE_THEME = "Purple"
local Theme = ThemePresets[ACTIVE_THEME]

-- ════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════

local function Tween(object, properties, duration, easingStyle, easingDirection)
    duration = duration or 0.3
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    easingDirection = easingDirection or Enum.EasingDirection.Out
    
    local tween = TweenService:Create(object, TweenInfo.new(duration, easingStyle, easingDirection), properties)
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
    
    -- Drop Shadow
    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 40, 1, 40),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.6,
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
    
    local TitleBarCover = CreateElement("Frame", {
        Name = "Cover",
        Parent = TitleBar,
        Position = UDim2.new(0, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    -- Status indicator
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
        Position = UDim2.new(1, -90, 0, 0),
        Size = UDim2.new(0, 80, 0, 35),
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
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -28, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = Theme.TextDark,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })
    
    local CloseButton = CreateElement("TextButton", {
        Name = "Close",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -5, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = Theme.TextDark,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })
    
    -- Sidebar
    local Sidebar = CreateElement("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(0, 45, 1, -35),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    local SidebarList = CreateElement("UIListLayout", {
        Parent = Sidebar,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    
    CreateElement("UIPadding", {
        Parent = Sidebar,
        PaddingTop = UDim.new(0, 10)
    })
    
    -- Content Area
    local Content = CreateElement("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Position = UDim2.new(0, 45, 0, 35),
        Size = UDim2.new(1, -45, 1, -35),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
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
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Minimize functionality
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        
        if Window.Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 35)}, 0.3)
            Tween(Sidebar, {Size = UDim2.new(0, 45, 0, 0)}, 0.3)
            Tween(Content, {Size = UDim2.new(1, -45, 0, 0)}, 0.3)
            Sidebar.Visible = false
            Content.Visible = false
        else
            Sidebar.Visible = true
            Content.Visible = true
            Tween(MainFrame, {Size = Window.OriginalSize}, 0.3)
            Tween(Sidebar, {Size = UDim2.new(0, 45, 1, -35)}, 0.3)
            Tween(Content, {Size = UDim2.new(1, -45, 1, -35)}, 0.3)
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- ════════════════════════════════════════════════════════════════════════
    -- CREATE PAGE
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:CreatePage(config)
        config = config or {}
        local Name = config.Name or "Page"
        local Icon = config.Icon
        
        local Page = {
            Name = Name,
            Sections = {},
            Visible = false
        }
        
        -- Page Content
        local PageFrame = CreateElement("ScrollingFrame", {
            Name = Name,
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        })
        
        CreateElement("UIPadding", {
            Parent = PageFrame,
            PaddingTop = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12)
        })
        
        CreateElement("UIListLayout", {
            Parent = PageFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        
        -- Sidebar Button
        local PageButton = CreateElement("TextButton", {
            Name = Name,
            Parent = Sidebar,
            Size = UDim2.new(0, 35, 0, 35),
            BackgroundColor3 = Theme.Sidebar,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false
        })
        
        CreateElement("UICorner", {
            Parent = PageButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        if Icon then
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
        end
        
        PageButton.MouseButton1Click:Connect(function()
            for _, p in pairs(Window.Pages) do
                p.Visible = false
                p.Frame.Visible = false
                p.Button.BackgroundColor3 = Theme.Sidebar
                if p.Button:FindFirstChild("Icon") then
                    p.Button.Icon.ImageColor3 = Theme.TextDark
                end
            end
            
            Page.Visible = true
            PageFrame.Visible = true
            PageButton.BackgroundColor3 = Theme.SidebarActive
            if PageButton:FindFirstChild("Icon") then
                PageButton.Icon.ImageColor3 = Theme.Text
            end
            Window.CurrentPage = Page
        end)
        
        PageButton.MouseEnter:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundColor3 = Theme.SidebarHover}, 0.2)
            end
        end)
        
        PageButton.MouseLeave:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundColor3 = Theme.Sidebar}, 0.2)
            end
        end)
        
        Page.Frame = PageFrame
        Page.Button = PageButton
        
        table.insert(Window.Pages, Page)
        
        if #Window.Pages == 1 then
            PageButton.BackgroundColor3 = Theme.SidebarActive
            if PageButton:FindFirstChild("Icon") then
                PageButton.Icon.ImageColor3 = Theme.Text
            end
            PageFrame.Visible = true
            Page.Visible = true
            Window.CurrentPage = Page
        end
        
        -- ════════════════════════════════════════════════════════════════════════
        -- CREATE SECTION
        -- ════════════════════════════════════════════════════════════════════════
        
        function Page:CreateSection(sectionName)
            sectionName = sectionName or "Section"
            
            local Section = {
                Elements = {}
            }
            
            local SectionFrame = CreateElement("Frame", {
                Name = sectionName,
                Parent = PageFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = SectionFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5)
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                LayoutOrder = 1
            })
            
            local ColumnContainer = CreateElement("Frame", {
                Name = "Columns",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            })
            
            local LeftColumn = CreateElement("Frame", {
                Name = "Left",
                Parent = ColumnContainer,
                Size = UDim2.new(0.48, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = LeftColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            local RightColumn = CreateElement("Frame", {
                Name = "Right",
                Parent = ColumnContainer,
                Size = UDim2.new(0.48, 0, 0, 0),
                Position = UDim2.new(0.52, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = RightColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            Section.Left = LeftColumn
            Section.Right = RightColumn
            
            local function GetSmallestColumn()
                return LeftColumn.AbsoluteSize.Y <= RightColumn.AbsoluteSize.Y and LeftColumn or RightColumn
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- ELEMENT LOCKING SYSTEM
            -- ════════════════════════════════════════════════════════════════════════
            
            local function CreateLockedOverlay(parent, reason)
                local Overlay = CreateElement("Frame", {
                    Name = "LockedOverlay",
                    Parent = parent,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 0.7,
                    BorderSizePixel = 0,
                    ZIndex = 10
                })
                
                CreateElement("UICorner", {
                    Parent = Overlay,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local LockIcon = CreateElement("ImageLabel", {
                    Name = "Lock",
                    Parent = Overlay,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, -15, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                    Image = Icons.Lock,
                    ImageColor3 = Theme.Warning
                })
                
                if reason then
                    local ReasonLabel = CreateElement("TextLabel", {
                        Name = "Reason",
                        Parent = Overlay,
                        Position = UDim2.new(0, 0, 1, 2),
                        Size = UDim2.new(1, 0, 0, 15),
                        BackgroundTransparency = 1,
                        Text = reason,
                        TextColor3 = Theme.Warning,
                        TextSize = 9,
                        Font = Enum.Font.Gotham,
                        TextWrapped = true
                    })
                end
                
                return Overlay
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
                
                return {
                    SetText = function(text)
                        Label.Text = text
                    end
                }
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
                
                local ParagraphTitle = CreateElement("TextLabel", {
                    Name = "Title",
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = Title,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold
                })
                
                local ParagraphContent = CreateElement("TextLabel", {
                    Name = "Content",
                    Parent = Container,
                    Position = UDim2.new(0, 0, 0, 20),
                    Size = UDim2.new(1, 0, 0, 0),
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
                
                return {
                    SetTitle = function(title)
                        ParagraphTitle.Text = title
                    end,
                    SetContent = function(content)
                        ParagraphContent.Text = content
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- TOGGLE ELEMENT (with Lock and ForceState)
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
                
                CreateElement("UIStroke", {
                    Parent = Toggle,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Toggle,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -60, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local ToggleButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Toggle,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 40, 0, 20),
                    BackgroundColor3 = currentValue and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local ToggleCircle = CreateElement("Frame", {
                    Name = "Circle",
                    Parent = ToggleButton,
                    Position = currentValue and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleCircle,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local function UpdateToggle(value, skipCallback)
                    currentValue = value
                    Tween(ToggleButton, {BackgroundColor3 = value and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
                    Tween(ToggleCircle, {Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.2)
                    if not skipCallback then
                        pcall(Callback, value)
                    end
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    if not Locked then
                        UpdateToggle(not currentValue)
                    end
                end)
                
                if Locked then
                    CreateLockedOverlay(Toggle, LockReason)
                end
                
                local ToggleObject = {
                    SetValue = function(value, skipCallback)
                        UpdateToggle(value, skipCallback)
                    end,
                    ForceState = function(state)
                        UpdateToggle(state, true)
                    end,
                    Lock = function(reason)
                        Locked = true
                        LockReason = reason or LockReason
                        if not Toggle:FindFirstChild("LockedOverlay") then
                            CreateLockedOverlay(Toggle, LockReason)
                        end
                    end,
                    Unlock = function()
                        Locked = false
                        local overlay = Toggle:FindFirstChild("LockedOverlay")
                        if overlay then
                            overlay:Destroy()
                        end
                    end
                }
                
                table.insert(Section.Elements, ToggleObject)
                return ToggleObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- SLIDER ELEMENT (with Lock)
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
                
                CreateElement("UIStroke", {
                    Parent = Slider,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Slider,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 15),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local SliderValue = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = Slider,
                    Position = UDim2.new(1, -12, 0, 8),
                    Size = UDim2.new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Text = tostring(currentValue) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamBold,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                local SliderTrack = CreateElement("Frame", {
                    Name = "Track",
                    Parent = Slider,
                    Position = UDim2.new(0, 12, 0, 32),
                    Size = UDim2.new(1, -24, 0, 6),
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
                    Size = UDim2.new((currentValue - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderDot = CreateElement("Frame", {
                    Name = "Dot",
                    Parent = SliderTrack,
                    Position = UDim2.new((currentValue - Min) / (Max - Min), -6, 0.5, 0),
                    Size = UDim2.new(0, 12, 0, 12),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderDot,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local dragging = false
                
                local function UpdateSlider(value, skipCallback)
                    value = math.clamp(value, Min, Max)
                    value = math.floor((value - Min) / Increment + 0.5) * Increment + Min
                    currentValue = value
                    
                    local percentage = (value - Min) / (Max - Min)
                    SliderValue.Text = tostring(value) .. Suffix
                    Tween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.1)
                    Tween(SliderDot, {Position = UDim2.new(percentage, -6, 0.5, 0)}, 0.1)
                    
                    if not skipCallback then
                        pcall(Callback, value)
                    end
                end
                
                SliderTrack.InputBegan:Connect(function(input)
                    if not Locked and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        dragging = true
                        local percentage = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        local value = Min + (Max - Min) * percentage
                        UpdateSlider(value)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local percentage = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        local value = Min + (Max - Min) * percentage
                        UpdateSlider(value)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)
                
                if Locked then
                    CreateLockedOverlay(Slider, LockReason)
                end
                
                local SliderObject = {
                    SetValue = function(value, skipCallback)
                        UpdateSlider(value, skipCallback)
                    end,
                    Lock = function(reason)
                        Locked = true
                        LockReason = reason or LockReason
                        if not Slider:FindFirstChild("LockedOverlay") then
                            CreateLockedOverlay(Slider, LockReason)
                        end
                    end,
                    Unlock = function()
                        Locked = false
                        local overlay = Slider:FindFirstChild("LockedOverlay")
                        if overlay then
                            overlay:Destroy()
                        end
                    end
                }
                
                table.insert(Section.Elements, SliderObject)
                return SliderObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- DROPDOWN ELEMENT (with Lock)
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
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = Dropdown,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = Dropdown,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local DropdownLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Dropdown,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -24, 0, 38),
                    BackgroundTransparency = 1,
                    Text = Name .. ": " .. currentValue,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local DropdownButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Dropdown,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 3
                })
                
                local DropdownArrow = CreateElement("TextLabel", {
                    Name = "Arrow",
                    Parent = Dropdown,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 12, 0, 12),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham
                })
                
                local OptionsContainer = CreateElement("Frame", {
                    Name = "Options",
                    Parent = Dropdown,
                    Position = UDim2.new(0, 0, 1, 5),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ClipsDescendants = true,
                    ZIndex = 5
                })
                
                CreateElement("UICorner", {
                    Parent = OptionsContainer,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIListLayout", {
                    Parent = OptionsContainer,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2)
                })
                
                CreateElement("UIPadding", {
                    Parent = OptionsContainer,
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5)
                })
                
                local function UpdateDropdown(value, skipCallback)
                    currentValue = value
                    DropdownLabel.Text = Name .. ": " .. value
                    if not skipCallback then
                        pcall(Callback, value)
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    if not Locked then
                        isOpen = not isOpen
                        OptionsContainer.Visible = isOpen
                        
                        if isOpen then
                            local optionHeight = #Options * 32 + 10
                            Tween(OptionsContainer, {Size = UDim2.new(1, 0, 0, optionHeight)}, 0.2)
                            Tween(DropdownArrow, {Rotation = 180}, 0.2)
                        else
                            Tween(OptionsContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                            Tween(DropdownArrow, {Rotation = 0}, 0.2)
                        end
                    end
                end)
                
                for _, option in ipairs(Options) do
                    local OptionButton = CreateElement("TextButton", {
                        Name = option,
                        Parent = OptionsContainer,
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = "  " .. option,
                        TextColor3 = Theme.Text,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        ZIndex = 6
                    })
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        UpdateDropdown(option)
                        isOpen = false
                        OptionsContainer.Visible = false
                        Tween(OptionsContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.15)
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Tertiary}, 0.15)
                    end)
                end
                
                if Locked then
                    CreateLockedOverlay(Dropdown, LockReason)
                end
                
                local DropdownObject = {
                    SetValue = function(value, skipCallback)
                        UpdateDropdown(value, skipCallback)
                    end,
                    Lock = function(reason)
                        Locked = true
                        LockReason = reason or LockReason
                        if not Dropdown:FindFirstChild("LockedOverlay") then
                            CreateLockedOverlay(Dropdown, LockReason)
                        end
                    end,
                    Unlock = function()
                        Locked = false
                        local overlay = Dropdown:FindFirstChild("LockedOverlay")
                        if overlay then
                            overlay:Destroy()
                        end
                    end
                }
                
                table.insert(Section.Elements, DropdownObject)
                return DropdownObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- BUTTON ELEMENT (with Lock)
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
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = Button,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = Button,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local ButtonLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Button,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    Font = Enum.Font.Gotham
                })
                
                Button.MouseButton1Click:Connect(function()
                    if not Locked then
                        Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                        task.wait(0.1)
                        Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.1)
                        pcall(Callback)
                    end
                end)
                
                Button.MouseEnter:Connect(function()
                    if not Locked then
                        Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    end
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
                end)
                
                if Locked then
                    CreateLockedOverlay(Button, LockReason)
                end
                
                local ButtonObject = {
                    Lock = function(reason)
                        Locked = true
                        LockReason = reason or LockReason
                        if not Button:FindFirstChild("LockedOverlay") then
                            CreateLockedOverlay(Button, LockReason)
                        end
                    end,
                    Unlock = function()
                        Locked = false
                        local overlay = Button:FindFirstChild("LockedOverlay")
                        if overlay then
                            overlay:Destroy()
                        end
                    end
                }
                
                table.insert(Section.Elements, ButtonObject)
                return ButtonObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- TEXTBOX ELEMENT (with Validation and Lock)
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddTextbox(config)
                config = config or {}
                local Name = config.Name or "Textbox"
                local Default = config.Default or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                local NumbersOnly = config.NumbersOnly or false
                local Locked = config.Locked or false
                local LockReason = config.LockReason or "This feature is locked"
                
                local Textbox = CreateElement("Frame", {
                    Name = "Textbox",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Textbox,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = Textbox,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local TextboxLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Textbox,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -24, 0, 12),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local TextboxInput = CreateElement("TextBox", {
                    Name = "Input",
                    Parent = Textbox,
                    Position = UDim2.new(0, 12, 0, 14),
                    Size = UDim2.new(1, -24, 1, -16),
                    BackgroundTransparency = 1,
                    Text = Default,
                    PlaceholderText = Placeholder,
                    TextColor3 = Theme.Text,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                if NumbersOnly then
                    TextboxInput:GetPropertyChangedSignal("Text"):Connect(function()
                        TextboxInput.Text = TextboxInput.Text:gsub("%D", "")
                    end)
                end
                
                TextboxInput.FocusLost:Connect(function()
                    if not Locked then
                        pcall(Callback, TextboxInput.Text)
                    end
                end)
                
                if Locked then
                    TextboxInput.TextEditable = false
                    CreateLockedOverlay(Textbox, LockReason)
                end
                
                local TextboxObject = {
                    SetValue = function(value, skipCallback)
                        TextboxInput.Text = tostring(value)
                        if not skipCallback then
                            pcall(Callback, value)
                        end
                    end,
                    Lock = function(reason)
                        Locked = true
                        LockReason = reason or LockReason
                        TextboxInput.TextEditable = false
                        if not Textbox:FindFirstChild("LockedOverlay") then
                            CreateLockedOverlay(Textbox, LockReason)
                        end
                    end,
                    Unlock = function()
                        Locked = false
                        TextboxInput.TextEditable = true
                        local overlay = Textbox:FindFirstChild("LockedOverlay")
                        if overlay then
                            overlay:Destroy()
                        end
                    end
                }
                
                table.insert(Section.Elements, TextboxObject)
                return TextboxObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- COLOR PICKER ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddColorPicker(config)
                config = config or {}
                local Name = config.Name or "Color Picker"
                local Default = config.Default or Color3.fromRGB(255, 0, 0)
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
                local currentColor = Default
                local h, s, v = RGBtoHSV(Default.R * 255, Default.G * 255, Default.B * 255)
                local pickerOpen = false
                
                local ColorPicker = CreateElement("Frame", {
                    Name = "ColorPicker",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = ColorPicker,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = ColorPicker,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local PickerLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ColorPicker,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -60, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local ColorDisplay = CreateElement("Frame", {
                    Name = "Display",
                    Parent = ColorPicker,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 35, 0, 22),
                    BackgroundColor3 = currentColor,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ColorDisplay,
                    CornerRadius = UDim.new(0, 5)
                })
                
                CreateElement("UIStroke", {
                    Parent = ColorDisplay,
                    Color = Theme.Border,
                    Thickness = 2
                })
                
                local ColorButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = ColorPicker,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 3
                })
                
                -- Color Picker Window
                local PickerWindow = CreateElement("Frame", {
                    Name = "PickerWindow",
                    Parent = ColorPicker,
                    Position = UDim2.new(0, 0, 1, 5),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ClipsDescendants = true,
                    ZIndex = 10
                })
                
                CreateElement("UICorner", {
                    Parent = PickerWindow,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = PickerWindow,
                    Color = Theme.Border,
                    Thickness = 1
                })
                
                -- Saturation/Value Selector
                local SVPicker = CreateElement("ImageButton", {
                    Name = "SVPicker",
                    Parent = PickerWindow,
                    Position = UDim2.new(0, 10, 0, 10),
                    Size = UDim2.new(1, -70, 0, 100),
                    BackgroundColor3 = Color3.fromHSV(h / 360, 1, 1),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 11
                })
                
                CreateElement("UICorner", {
                    Parent = SVPicker,
                    CornerRadius = UDim.new(0, 5)
                })
                
                local SVGradient = CreateElement("UIGradient", {
                    Parent = SVPicker,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                    },
                    Rotation = 90
                })
                
                local SVOverlay = CreateElement("Frame", {
                    Name = "Overlay",
                    Parent = SVPicker,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    ZIndex = 12
                })
                
                CreateElement("UICorner", {
                    Parent = SVOverlay,
                    CornerRadius = UDim.new(0, 5)
                })
                
                local SVOverlayGradient = CreateElement("UIGradient", {
                    Parent = SVOverlay,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    },
                    Transparency = NumberSequence.new{
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    }
                })
                
                local SVCursor = CreateElement("Frame", {
                    Name = "Cursor",
                    Parent = SVPicker,
                    Position = UDim2.new(s / 100, 0, 1 - v / 100, 0),
                    Size = UDim2.new(0, 10, 0, 10),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 15
                })
                
                CreateElement("UICorner", {
                    Parent = SVCursor,
                    CornerRadius = UDim.new(1, 0)
                })
                
                -- Hue Slider
                local HueSlider = CreateElement("ImageButton", {
                    Name = "HueSlider",
                    Parent = PickerWindow,
                    Position = UDim2.new(1, -50, 0, 10),
                    Size = UDim2.new(0, 35, 0, 100),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 11
                })
                
                CreateElement("UICorner", {
                    Parent = HueSlider,
                    CornerRadius = UDim.new(0, 5)
                })
                
                local HueGradient = CreateElement("UIGradient", {
                    Parent = HueSlider,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    },
                    Rotation = 90
                })
                
                local HueCursor = CreateElement("Frame", {
                    Name = "Cursor",
                    Parent = HueSlider,
                    Position = UDim2.new(0.5, 0, h / 360, 0),
                    Size = UDim2.new(1, 4, 0, 3),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    ZIndex = 15
                })
                
                -- RGB Display
                local RGBDisplay = CreateElement("TextLabel", {
                    Name = "RGB",
                    Parent = PickerWindow,
                    Position = UDim2.new(0, 10, 0, 115),
                    Size = UDim2.new(1, -20, 0, 20),
                    BackgroundTransparency = 1,
                    Text = string.format("RGB(%d, %d, %d)", currentColor.R * 255, currentColor.G * 255, currentColor.B * 255),
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ZIndex = 11
                })
                
                local function UpdateColor()
                    local r, g, b = HSVtoRGB(h, s, v)
                    currentColor = Color3.fromRGB(r, g, b)
                    ColorDisplay.BackgroundColor3 = currentColor
                    SVPicker.BackgroundColor3 = Color3.fromHSV(h / 360, 1, 1)
                    RGBDisplay.Text = string.format("RGB(%d, %d, %d)", r, g, b)
                    pcall(Callback, currentColor)
                end
                
                local draggingSV = false
                local draggingHue = false
                
                SVPicker.MouseButton1Down:Connect(function()
                    draggingSV = true
                end)
                
                HueSlider.MouseButton1Down:Connect(function()
                    draggingHue = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingSV = false
                        draggingHue = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if draggingSV then
                            local posX = math.clamp((input.Position.X - SVPicker.AbsolutePosition.X) / SVPicker.AbsoluteSize.X, 0, 1)
                            local posY = math.clamp((input.Position.Y - SVPicker.AbsolutePosition.Y) / SVPicker.AbsoluteSize.Y, 0, 1)
                            s = posX * 100
                            v = (1 - posY) * 100
                            SVCursor.Position = UDim2.new(posX, 0, posY, 0)
                            UpdateColor()
                        elseif draggingHue then
                            local posY = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
                            h = posY * 360
                            HueCursor.Position = UDim2.new(0.5, 0, posY, 0)
                            UpdateColor()
                        end
                    end
                end)
                
                ColorButton.MouseButton1Click:Connect(function()
                    pickerOpen = not pickerOpen
                    PickerWindow.Visible = pickerOpen
                    
                    if pickerOpen then
                        Tween(PickerWindow, {Size = UDim2.new(1, 0, 0, 145)}, 0.2)
                    else
                        Tween(PickerWindow, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    end
                end)
                
                local ColorPickerObject = {
                    SetValue = function(color, skipCallback)
                        currentColor = color
                        h, s, v = RGBtoHSV(color.R * 255, color.G * 255, color.B * 255)
                        ColorDisplay.BackgroundColor3 = color
                        SVPicker.BackgroundColor3 = Color3.fromHSV(h / 360, 1, 1)
                        SVCursor.Position = UDim2.new(s / 100, 0, 1 - v / 100, 0)
                        HueCursor.Position = UDim2.new(0.5, 0, h / 360, 0)
                        RGBDisplay.Text = string.format("RGB(%d, %d, %d)", color.R * 255, color.G * 255, color.B * 255)
                        if not skipCallback then
                            pcall(Callback, color)
                        end
                    end
                }
                
                table.insert(Section.Elements, ColorPickerObject)
                return ColorPickerObject
            end
            
            -- ════════════════════════════════════════════════════════════════════════
            -- KEYBIND ELEMENT
            -- ════════════════════════════════════════════════════════════════════════
            
            function Section:AddKeybind(config)
                config = config or {}
                local Name = config.Name or "Keybind"
                local Default = config.Default or Enum.KeyCode.E
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
                local currentKey = Default
                local listening = false
                
                local Keybind = CreateElement("Frame", {
                    Name = "Keybind",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Keybind,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = Keybind,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                local KeybindLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = Keybind,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -100, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham
                })
                
                local KeyButton = CreateElement("TextButton", {
                    Name = "KeyButton",
                    Parent = Keybind,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 70, 0, 24),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = currentKey.Name,
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = KeyButton,
                    CornerRadius = UDim.new(0, 5)
                })
                
                KeyButton.MouseButton1Click:Connect(function()
                    listening = true
                    KeyButton.Text = "..."
                    Tween(KeyButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        KeyButton.Text = currentKey.Name
                        listening = false
                        Tween(KeyButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                    end
                    
                    if not gameProcessed and input.KeyCode == currentKey then
                        pcall(Callback)
                    end
                end)
                
                local KeybindObject = {
                    SetKey = function(key)
                        currentKey = key
                        KeyButton.Text = key.Name
                    end
                }
                
                table.insert(Window.Keybinds, {Key = currentKey, Callback = Callback})
                table.insert(Section.Elements, KeybindObject)
                return KeybindObject
            end
            
            return Section
        end
        
        return Page
    end
    
    -- ════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION SYSTEM
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or ""
        local Duration = config.Duration or 3
        local Type = config.Type or "Info"
        
        local TypeColors = {
            Info = Theme.Info,
            Success = Theme.Success,
            Warning = Theme.Warning,
            Error = Theme.Error
        }
        
        local Notification = CreateElement("Frame", {
            Name = "Notification",
            Parent = ScreenGui,
            Position = UDim2.new(1, 10, 1, -100),
            Size = UDim2.new(0, 280, 0, 70),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = Notification,
            CornerRadius = UDim.new(0, 8)
        })
        
        CreateElement("UIStroke", {
            Parent = Notification,
            Color = TypeColors[Type] or Theme.Accent,
            Thickness = 2
        })
        
        local ColorBar = CreateElement("Frame", {
            Name = "Bar",
            Parent = Notification,
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = TypeColors[Type] or Theme.Accent,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = ColorBar,
            CornerRadius = UDim.new(0, 8)
        })
        
        local NotifTitle = CreateElement("TextLabel", {
            Name = "Title",
            Parent = Notification,
            Position = UDim2.new(0, 15, 0, 8),
            Size = UDim2.new(1, -30, 0, 18),
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
            Position = UDim2.new(0, 15, 0, 28),
            Size = UDim2.new(1, -30, 1, -36),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Font = Enum.Font.Gotham,
            TextWrapped = true
        })
        
        Tween(Notification, {Position = UDim2.new(1, -290, 1, -100)}, 0.4, Enum.EasingStyle.Back)
        
        task.wait(Duration)
        
        Tween(Notification, {Position = UDim2.new(1, 10, 1, -100)}, 0.3)
        task.wait(0.3)
        Notification:Destroy()
    end
    
    -- ════════════════════════════════════════════════════════════════════════
    -- THEME CHANGER
    -- ════════════════════════════════════════════════════════════════════════
    
    function Window:SetTheme(themeName)
        if ThemePresets[themeName] then
            Theme = ThemePresets[themeName]
            
            -- Update existing UI colors
            MainFrame.BackgroundColor3 = Theme.Background
            TitleBar.BackgroundColor3 = Theme.Sidebar
            TitleBarCover.BackgroundColor3 = Theme.Sidebar
            Sidebar.BackgroundColor3 = Theme.Sidebar
            StatusIndicator.BackgroundColor3 = Theme.Success
            
            Window:Notify({
                Title = "Theme Changed",
                Content = "Theme set to: " .. themeName,
                Duration = 2,
                Type = "Success"
            })
        end
    end
    
    return Window
end

return Library
