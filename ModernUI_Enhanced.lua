--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║              Modern UI Library - Enhanced                 ║
    ║                    Version: 3.0.0                         ║
    ║         Transparent Black/Purple/Gray Theme               ║
    ║              Supports: Mobile & Desktop                   ║
    ╚═══════════════════════════════════════════════════════════╝
    
    Created by: Your Name
    Inspired by: WindUI & Modern Design Principles
    
    Documentation: See DOCUMENTATION.md
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════

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

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle = dragHandle or frame
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Tween(frame, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.15)
        end
    end)
end

-- ════════════════════════════════════════════════════════════
-- ICON SYSTEM
-- ════════════════════════════════════════════════════════════

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
    Search = "rbxassetid://10734898355",
    Plus = "rbxassetid://10734896279",
    Minus = "rbxassetid://10734884537",
    Copy = "rbxassetid://10734883856",
    Trash = "rbxassetid://10734896638"
}

-- ════════════════════════════════════════════════════════════
-- THEME SYSTEM - Black/Purple/Gray/White Transparent
-- ════════════════════════════════════════════════════════════

local Theme = {
    -- Main Colors (Transparent backgrounds)
    Background = Color3.fromRGB(15, 15, 20),          -- Deep black
    BackgroundTransparency = 0.15,                     -- Transparent
    
    Secondary = Color3.fromRGB(25, 25, 35),           -- Slightly lighter black
    SecondaryTransparency = 0.2,
    
    Tertiary = Color3.fromRGB(35, 35, 45),            -- Card background
    TertiaryTransparency = 0.25,
    
    -- Sidebar
    Sidebar = Color3.fromRGB(12, 12, 18),             -- Darker sidebar
    SidebarTransparency = 0.1,
    SidebarHover = Color3.fromRGB(40, 35, 50),        -- Purple tint on hover
    SidebarActive = Color3.fromRGB(138, 43, 226),     -- Purple accent
    
    -- Purple Accent Colors
    Accent = Color3.fromRGB(138, 43, 226),            -- Blue Violet
    AccentHover = Color3.fromRGB(160, 70, 240),       -- Lighter purple
    AccentDark = Color3.fromRGB(110, 30, 200),        -- Darker purple
    AccentGlow = Color3.fromRGB(148, 0, 211),         -- Dark Violet
    
    -- Secondary Purple Shades
    Purple = Color3.fromRGB(138, 43, 226),
    PurpleLight = Color3.fromRGB(186, 85, 211),       -- Medium Orchid
    PurpleDark = Color3.fromRGB(75, 0, 130),          -- Indigo
    
    -- Text Colors
    Text = Color3.fromRGB(255, 255, 255),             -- Pure white
    TextDark = Color3.fromRGB(180, 180, 190),         -- Light gray
    TextMuted = Color3.fromRGB(120, 120, 130),        -- Medium gray
    TextDisabled = Color3.fromRGB(80, 80, 90),        -- Dark gray
    
    -- UI Elements
    Border = Color3.fromRGB(60, 55, 75),              -- Purple-tinted border
    BorderLight = Color3.fromRGB(80, 75, 95),
    BorderGlow = Color3.fromRGB(138, 43, 226),        -- Purple glow
    
    -- Status Colors
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Error = Color3.fromRGB(240, 71, 71),
    Info = Color3.fromRGB(138, 43, 226),              -- Purple for info
    
    -- Toggle Colors
    ToggleOn = Color3.fromRGB(138, 43, 226),
    ToggleOff = Color3.fromRGB(60, 60, 70),
    
    -- Slider Colors
    SliderFill = Color3.fromRGB(138, 43, 226),
    SliderBackground = Color3.fromRGB(40, 40, 50),
    
    -- Dropdown
    DropdownBackground = Color3.fromRGB(20, 20, 30),
    DropdownHover = Color3.fromRGB(138, 43, 226)
}

-- ════════════════════════════════════════════════════════════
-- MAIN LIBRARY
-- ════════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Modern UI"
    local Subtitle = config.Subtitle or "v3.0.0"
    local Size = config.Size or UDim2.new(0, IsMobile() and 380 or 540, 0, IsMobile() and 420 or 360)
    local LoadingEnabled = config.LoadingEnabled ~= false
    local ConfigFolder = config.ConfigFolder or "ModernUIConfigs"
    
    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = Size,
        ConfigFolder = ConfigFolder,
        Flags = {}
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
        BackgroundTransparency = Theme.BackgroundTransparency,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    CreateElement("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 12)
    })
    
    -- Outer glow effect
    CreateElement("UIStroke", {
        Parent = MainFrame,
        Color = Theme.BorderGlow,
        Thickness = 1,
        Transparency = 0.5
    })
    
    -- Drop Shadow with purple tint
    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 50, 1, 50),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Theme.Accent,
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -1
    })
    
    -- Blur effect for background
    local BackgroundBlur = CreateElement("Frame", {
        Name = "BackgroundBlur",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        ZIndex = 0
    })
    
    CreateElement("UICorner", {
        Parent = BackgroundBlur,
        CornerRadius = UDim.new(0, 12)
    })
    
    -- Title Bar
    local TitleBar = CreateElement("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Theme.SidebarTransparency,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    CreateElement("UICorner", {
        Parent = TitleBar,
        CornerRadius = UDim.new(0, 12)
    })
    
    -- Gradient overlay for title bar
    local TitleGradient = CreateElement("UIGradient", {
        Parent = TitleBar,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
        }),
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.85),
            NumberSequenceKeypoint.new(1, 0.95)
        })
    })
    
    -- Title bar bottom cover
    local TitleBarCover = CreateElement("Frame", {
        Name = "Cover",
        Parent = TitleBar,
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Theme.SidebarTransparency,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    -- Status indicator with purple glow
    local StatusIndicator = CreateElement("Frame", {
        Name = "Status",
        Parent = TitleBar,
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.new(0, 8, 0, 8),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 3
    })
    
    CreateElement("UICorner", {
        Parent = StatusIndicator,
        CornerRadius = UDim.new(1, 0)
    })
    
    CreateElement("UIStroke", {
        Parent = StatusIndicator,
        Color = Theme.Accent,
        Thickness = 2,
        Transparency = 0.3
    })
    
    -- Pulsing animation for status
    task.spawn(function()
        while ScreenGui.Parent do
            Tween(StatusIndicator, {Size = UDim2.new(0, 10, 0, 10)}, 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1.2)
            Tween(StatusIndicator, {Size = UDim2.new(0, 8, 0, 8)}, 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1.2)
        end
    end)
    
    -- Title with gradient effect
    local TitleLabel = CreateElement("TextLabel", {
        Name = "Title",
        Parent = TitleBar,
        Position = UDim2.new(0, 28, 0, 0),
        Size = UDim2.new(0.5, -28, 0, 40),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 3
    })
    
    -- Subtitle
    local SubtitleLabel = CreateElement("TextLabel", {
        Name = "Subtitle",
        Parent = TitleBar,
        Position = UDim2.new(1, -100, 0, 0),
        Size = UDim2.new(0, 90, 0, 40),
        BackgroundTransparency = 1,
        Text = Subtitle,
        TextColor3 = Theme.TextMuted,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        Font = Enum.Font.Gotham,
        ZIndex = 3
    })
    
    -- Minimize Button
    local MinimizeButton = CreateElement("TextButton", {
        Name = "Minimize",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -30, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = "─",
        TextColor3 = Theme.TextDark,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 3
    })
    
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.Accent}, 0.15)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.TextDark}, 0.15)
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        
        if Window.Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, Window.OriginalSize.X.Offset, 0, 40)}, 0.3, Enum.EasingStyle.Quad)
            MinimizeButton.Text = "+"
        else
            Tween(MainFrame, {Size = Window.OriginalSize}, 0.3, Enum.EasingStyle.Quad)
            MinimizeButton.Text = "─"
        end
    end)
    
    -- Close Button
    local CloseButton = CreateElement("TextButton", {
        Name = "Close",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -6, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = Theme.TextDark,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 3
    })
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.Error}, 0.15)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.TextDark}, 0.15)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Make draggable
    MakeDraggable(MainFrame, TitleBar)
    
    -- Sidebar
    local Sidebar = CreateElement("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(0, 65, 1, -40),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Theme.SidebarTransparency,
        BorderSizePixel = 0,
        ZIndex = 1
    })
    
    CreateElement("UIStroke", {
        Parent = Sidebar,
        Color = Theme.Border,
        Thickness = 1,
        Transparency = 0.6
    })
    
    local SidebarList = CreateElement("UIListLayout", {
        Parent = Sidebar,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    })
    
    CreateElement("UIPadding", {
        Parent = Sidebar,
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4)
    })
    
    -- Content Area
    local ContentFrame = CreateElement("Frame", {
        Name = "ContentFrame",
        Parent = MainFrame,
        Position = UDim2.new(0, 65, 0, 40),
        Size = UDim2.new(1, -65, 1, -40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 1
    })
    
    -- ════════════════════════════════════════════════════════════
    -- CREATE PAGE
    -- ════════════════════════════════════════════════════════════
    
    function Window:CreatePage(config)
        config = config or {}
        local Name = config.Name or "Page"
        local Icon = config.Icon or Icons.Home
        local LayoutOrder = config.LayoutOrder or #Window.Pages + 1
        
        local Page = {
            Name = Name,
            Icon = Icon,
            Sections = {},
            Visible = false
        }
        
        table.insert(Window.Pages, Page)
        
        -- Page Button in Sidebar
        local PageButton = CreateElement("TextButton", {
            Name = Name,
            Parent = Sidebar,
            Size = UDim2.new(1, 0, 0, 52),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = LayoutOrder,
            ZIndex = 2
        })
        
        CreateElement("UICorner", {
            Parent = PageButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        local PageStroke = CreateElement("UIStroke", {
            Parent = PageButton,
            Color = Theme.Border,
            Thickness = 1,
            Transparency = 0.7
        })
        
        local PageIcon = CreateElement("ImageLabel", {
            Name = "Icon",
            Parent = PageButton,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.4, 0),
            Size = UDim2.new(0, 24, 0, 24),
            BackgroundTransparency = 1,
            Image = Icon,
            ImageColor3 = Theme.TextDark,
            ZIndex = 3
        })
        
        local PageLabel = CreateElement("TextLabel", {
            Name = "Label",
            Parent = PageButton,
            Position = UDim2.new(0, 0, 0.65, 0),
            Size = UDim2.new(1, 0, 0, 16),
            BackgroundTransparency = 1,
            Text = Name,
            TextColor3 = Theme.TextMuted,
            TextSize = 10,
            Font = Enum.Font.Gotham,
            ZIndex = 3
        })
        
        -- Page Content
        local PageContent = CreateElement("ScrollingFrame", {
            Name = Name .. "Content",
            Parent = ContentFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            ZIndex = 1
        })
        
        CreateElement("UIListLayout", {
            Parent = PageContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        
        CreateElement("UIPadding", {
            Parent = PageContent,
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12)
        })
        
        PageButton.MouseButton1Click:Connect(function()
            for _, p in pairs(Window.Pages) do
                if p.Button then
                    Tween(p.Button, {BackgroundColor3 = Theme.Secondary, BackgroundTransparency = 0.3}, 0.2)
                    Tween(p.Icon, {ImageColor3 = Theme.TextDark}, 0.2)
                    Tween(p.Label, {TextColor3 = Theme.TextMuted}, 0.2)
                    Tween(p.Stroke, {Color = Theme.Border, Transparency = 0.7}, 0.2)
                    p.Content.Visible = false
                    p.Visible = false
                end
            end
            
            Tween(PageButton, {BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0}, 0.2)
            Tween(PageIcon, {ImageColor3 = Theme.Text}, 0.2)
            Tween(PageLabel, {TextColor3 = Theme.Text}, 0.2)
            Tween(PageStroke, {Color = Theme.Accent, Transparency = 0.3}, 0.2)
            PageContent.Visible = true
            Page.Visible = true
            Window.CurrentPage = Page
        end)
        
        PageButton.MouseEnter:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundTransparency = 0}, 0.15)
                Tween(PageIcon, {ImageColor3 = Theme.Accent}, 0.15)
            end
        end)
        
        PageButton.MouseLeave:Connect(function()
            if not Page.Visible then
                Tween(PageButton, {BackgroundTransparency = 0.3}, 0.15)
                Tween(PageIcon, {ImageColor3 = Theme.TextDark}, 0.15)
            end
        end)
        
        Page.Button = PageButton
        Page.Icon = PageIcon
        Page.Label = PageLabel
        Page.Stroke = PageStroke
        Page.Content = PageContent
        
        -- Auto-select first page
        if #Window.Pages == 1 then
            PageButton.MouseButton1Click:Fire()
        end
        
        -- ════════════════════════════════════════════════════════════
        -- CREATE SECTION
        -- ════════════════════════════════════════════════════════════
        
        function Page:CreateSection(name)
            local Section = {
                Name = name or "Section",
                Elements = {}
            }
            
            table.insert(Page.Sections, Section)
            
            local SectionFrame = CreateElement("Frame", {
                Name = name,
                Parent = PageContent,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = Theme.SecondaryTransparency,
                BorderSizePixel = 0,
                ZIndex = 1
            })
            
            CreateElement("UICorner", {
                Parent = SectionFrame,
                CornerRadius = UDim.new(0, 10)
            })
            
            CreateElement("UIStroke", {
                Parent = SectionFrame,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.6
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Parent = SectionFrame,
                Position = UDim2.new(0, 14, 0, 0),
                Size = UDim2.new(1, -28, 0, 35),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                ZIndex = 2
            })
            
            local SectionDivider = CreateElement("Frame", {
                Name = "Divider",
                Parent = SectionFrame,
                Position = UDim2.new(0, 12, 0, 35),
                Size = UDim2.new(1, -24, 0, 1),
                BackgroundColor3 = Theme.Border,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local SectionContent = CreateElement("Frame", {
                Name = "Content",
                Parent = SectionFrame,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ZIndex = 1
            })
            
            CreateElement("UIListLayout", {
                Parent = SectionContent,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            CreateElement("UIPadding", {
                Parent = SectionContent,
                PaddingTop = UDim.new(0, 6),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            })
            
            Section.Frame = SectionFrame
            Section.Content = SectionContent
            
            -- ════════════════════════════════════════════════════════════
            -- ADD TOGGLE
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                
                local ToggleState = Default
                
                local ToggleFrame = CreateElement("Frame", {
                    Name = "Toggle",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                CreateElement("UIStroke", {
                    Parent = ToggleFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ToggleFrame,
                    Position = UDim2.new(0, 14, 0, 0),
                    Size = UDim2.new(1, -70, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                local ToggleButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = ToggleFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0, 44, 0, 24),
                    BackgroundColor3 = Default and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 3
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                CreateElement("UIStroke", {
                    Parent = ToggleButton,
                    Color = Default and Theme.Accent or Theme.Border,
                    Thickness = 2,
                    Transparency = 0.5
                })
                
                local ToggleCircle = CreateElement("Frame", {
                    Name = "Circle",
                    Parent = ToggleButton,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = Default and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 20, 0, 20),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 4
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleCircle,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local function UpdateToggle(state)
                    ToggleState = state
                    
                    if state then
                        Tween(ToggleButton, {BackgroundColor3 = Theme.ToggleOn}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(1, -22, 0.5, 0)}, 0.2, Enum.EasingStyle.Quad)
                    else
                        Tween(ToggleButton, {BackgroundColor3 = Theme.ToggleOff}, 0.2)
                        Tween(ToggleCircle, {Position = UDim2.new(0, 2, 0.5, 0)}, 0.2, Enum.EasingStyle.Quad)
                    end
                    
                    if Flag then
                        Window.Flags[Flag] = state
                    end
                    
                    pcall(Callback, state)
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    UpdateToggle(not ToggleState)
                end)
                
                ToggleFrame.MouseEnter:Connect(function()
                    Tween(ToggleFrame, {BackgroundTransparency = 0}, 0.15)
                end)
                
                ToggleFrame.MouseLeave:Connect(function()
                    Tween(ToggleFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                end)
                
                if Flag then
                    Window.Flags[Flag] = Default
                end
                
                return {
                    SetValue = UpdateToggle,
                    GetValue = function() return ToggleState end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD SLIDER
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddSlider(config)
                config = config or {}
                local Name = config.Name or "Slider"
                local Min = config.Min or 0
                local Max = config.Max or 100
                local Default = config.Default or Min
                local Increment = config.Increment or 1
                local Suffix = config.Suffix or ""
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                
                local SliderValue = Default
                local Dragging = false
                
                local SliderFrame = CreateElement("Frame", {
                    Name = "Slider",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                CreateElement("UIStroke", {
                    Parent = SliderFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 14, 0, 8),
                    Size = UDim2.new(1, -28, 0, 16),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                local SliderValueLabel = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = SliderFrame,
                    Position = UDim2.new(1, -14, 0, 8),
                    Size = UDim2.new(0, 50, 0, 16),
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(Default) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamBold,
                    ZIndex = 3
                })
                
                local SliderBackground = CreateElement("Frame", {
                    Name = "Background",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 14, 1, -18),
                    Size = UDim2.new(1, -28, 0, 6),
                    BackgroundColor3 = Theme.SliderBackground,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = SliderBackground,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderFill = CreateElement("Frame", {
                    Name = "Fill",
                    Parent = SliderBackground,
                    Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.SliderFill,
                    BorderSizePixel = 0,
                    ZIndex = 3
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                CreateElement("UIGradient", {
                    Parent = SliderFill,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Theme.Accent),
                        ColorSequenceKeypoint.new(1, Theme.AccentHover)
                    })
                })
                
                local SliderDot = CreateElement("Frame", {
                    Name = "Dot",
                    Parent = SliderBackground,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new((Default - Min) / (Max - Min), 0, 0.5, 0),
                    Size = UDim2.new(0, 14, 0, 14),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 4
                })
                
                CreateElement("UICorner", {
                    Parent = SliderDot,
                    CornerRadius = UDim.new(1, 0)
                })
                
                CreateElement("UIStroke", {
                    Parent = SliderDot,
                    Color = Theme.Accent,
                    Thickness = 2,
                    Transparency = 0.5
                })
                
                local function UpdateSlider(value)
                    value = math.clamp(value, Min, Max)
                    value = math.floor((value - Min) / Increment + 0.5) * Increment + Min
                    value = math.clamp(value, Min, Max)
                    
                    SliderValue = value
                    SliderValueLabel.Text = tostring(value) .. Suffix
                    
                    local percent = (value - Min) / (Max - Min)
                    Tween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    Tween(SliderDot, {Position = UDim2.new(percent, 0, 0.5, 0)}, 0.1)
                    
                    if Flag then
                        Window.Flags[Flag] = value
                    end
                    
                    pcall(Callback, value)
                end
                
                SliderBackground.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        Tween(SliderDot, {Size = UDim2.new(0, 18, 0, 18)}, 0.1)
                        
                        local function Update()
                            local mouse = UserInputService:GetMouseLocation()
                            local percent = math.clamp((mouse.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
                            local value = Min + ((Max - Min) * percent)
                            UpdateSlider(value)
                        end
                        
                        Update()
                        
                        local connection
                        connection = input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                Dragging = false
                                Tween(SliderDot, {Size = UDim2.new(0, 14, 0, 14)}, 0.1)
                                connection:Disconnect()
                            end
                        end)
                    end
                end)
                
                SliderBackground.InputChanged:Connect(function(input)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local mouse = UserInputService:GetMouseLocation()
                        local percent = math.clamp((mouse.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
                        local value = Min + ((Max - Min) * percent)
                        UpdateSlider(value)
                    end
                end)
                
                SliderFrame.MouseEnter:Connect(function()
                    Tween(SliderFrame, {BackgroundTransparency = 0}, 0.15)
                end)
                
                SliderFrame.MouseLeave:Connect(function()
                    Tween(SliderFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                end)
                
                if Flag then
                    Window.Flags[Flag] = Default
                end
                
                return {
                    SetValue = UpdateSlider,
                    GetValue = function() return SliderValue end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD DROPDOWN
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or {"Option 1", "Option 2", "Option 3"}
                local Default = config.Default or Options[1]
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                
                local DropdownOpen = false
                local SelectedOption = Default
                
                local DropdownFrame = CreateElement("Frame", {
                    Name = "Dropdown",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = DropdownFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                CreateElement("UIStroke", {
                    Parent = DropdownFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local DropdownLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 14, 0, 0),
                    Size = UDim2.new(1, -14, 0, 40),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.TextMuted,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                CreateElement("UIPadding", {
                    Parent = DropdownLabel,
                    PaddingTop = UDim.new(0, 6)
                })
                
                local DropdownButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 14, 0, 20),
                    Size = UDim2.new(1, -38, 0, 18),
                    BackgroundTransparency = 1,
                    Text = "  " .. Default,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    ZIndex = 3
                })
                
                local DropdownArrow = CreateElement("TextLabel", {
                    Name = "Arrow",
                    Parent = DropdownFrame,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -10, 0, 20),
                    Size = UDim2.new(0, 18, 0, 18),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextDark,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                local DropdownContent = CreateElement("ScrollingFrame", {
                    Name = "Content",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 8, 0, 46),
                    Size = UDim2.new(1, -16, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 3,
                    ScrollBarImageColor3 = Theme.Accent,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ZIndex = 3
                })
                
                CreateElement("UIListLayout", {
                    Parent = DropdownContent,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                })
                
                local function ToggleDropdown()
                    DropdownOpen = not DropdownOpen
                    
                    if DropdownOpen then
                        local contentHeight = math.min(#Options * 32 + (#Options - 1) * 4, 150)
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 50 + contentHeight)}, 0.2)
                        Tween(DropdownContent, {Size = UDim2.new(1, -16, 0, contentHeight)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 180}, 0.2)
                    else
                        Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.2)
                        Tween(DropdownContent, {Size = UDim2.new(1, -16, 0, 0)}, 0.2)
                        Tween(DropdownArrow, {Rotation = 0}, 0.2)
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
                
                DropdownFrame.MouseEnter:Connect(function()
                    Tween(DropdownFrame, {BackgroundTransparency = 0}, 0.15)
                end)
                
                DropdownFrame.MouseLeave:Connect(function()
                    Tween(DropdownFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                end)
                
                for i, option in ipairs(Options) do
                    local OptionButton = CreateElement("TextButton", {
                        Name = option,
                        Parent = DropdownContent,
                        Size = UDim2.new(1, 0, 0, 32),
                        BackgroundColor3 = Theme.DropdownBackground,
                        BackgroundTransparency = 0.3,
                        BorderSizePixel = 0,
                        Text = "  " .. option,
                        TextColor3 = Theme.Text,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        ZIndex = 4
                    })
                    
                    CreateElement("UICorner", {
                        Parent = OptionButton,
                        CornerRadius = UDim.new(0, 6)
                    })
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        SelectedOption = option
                        DropdownButton.Text = "  " .. option
                        ToggleDropdown()
                        
                        if Flag then
                            Window.Flags[Flag] = option
                        end
                        
                        pcall(Callback, option)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.DropdownHover, BackgroundTransparency = 0}, 0.15)
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.DropdownBackground, BackgroundTransparency = 0.3}, 0.15)
                    end)
                end
                
                if Flag then
                    Window.Flags[Flag] = Default
                end
                
                return {
                    SetValue = function(value)
                        SelectedOption = value
                        DropdownButton.Text = "  " .. value
                        if Flag then
                            Window.Flags[Flag] = value
                        end
                        pcall(Callback, value)
                    end,
                    GetValue = function() return SelectedOption end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD BUTTON
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddButton(config)
                config = config or {}
                local Name = config.Name or "Button"
                local Callback = config.Callback or function() end
                
                local ButtonFrame = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = ButtonFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                local ButtonStroke = CreateElement("UIStroke", {
                    Parent = ButtonFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local ButtonLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ButtonFrame,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold,
                    ZIndex = 3
                })
                
                ButtonFrame.MouseButton1Click:Connect(function()
                    Tween(ButtonFrame, {BackgroundColor3 = Theme.Accent}, 0.1)
                    Tween(ButtonStroke, {Color = Theme.Accent, Transparency = 0.3}, 0.1)
                    task.wait(0.15)
                    Tween(ButtonFrame, {BackgroundColor3 = Theme.Tertiary}, 0.1)
                    Tween(ButtonStroke, {Color = Theme.Border, Transparency = 0.7}, 0.1)
                    pcall(Callback)
                end)
                
                ButtonFrame.MouseEnter:Connect(function()
                    Tween(ButtonFrame, {BackgroundTransparency = 0}, 0.15)
                    Tween(ButtonLabel, {TextColor3 = Theme.Accent}, 0.15)
                end)
                
                ButtonFrame.MouseLeave:Connect(function()
                    Tween(ButtonFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                    Tween(ButtonLabel, {TextColor3 = Theme.Text}, 0.15)
                end)
                
                return ButtonFrame
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD TEXTBOX
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddTextbox(config)
                config = config or {}
                local Name = config.Name or "Textbox"
                local Default = config.Default or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                
                local TextboxFrame = CreateElement("Frame", {
                    Name = "Textbox",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = TextboxFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                CreateElement("UIStroke", {
                    Parent = TextboxFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local TextboxLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = TextboxFrame,
                    Position = UDim2.new(0, 14, 0, 8),
                    Size = UDim2.new(1, -28, 0, 14),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.TextMuted,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                local TextboxInput = CreateElement("TextBox", {
                    Name = "Input",
                    Parent = TextboxFrame,
                    Position = UDim2.new(0, 14, 0, 26),
                    Size = UDim2.new(1, -28, 0, 24),
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.3,
                    BorderSizePixel = 0,
                    Text = Default,
                    PlaceholderText = Placeholder,
                    TextColor3 = Theme.Text,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 3
                })
                
                CreateElement("UICorner", {
                    Parent = TextboxInput,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIPadding", {
                    Parent = TextboxInput,
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10)
                })
                
                TextboxInput.Focused:Connect(function()
                    Tween(TextboxInput, {BackgroundTransparency = 0, BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                TextboxInput.FocusLost:Connect(function()
                    Tween(TextboxInput, {BackgroundTransparency = 0.3, BackgroundColor3 = Theme.Secondary}, 0.2)
                    
                    if Flag then
                        Window.Flags[Flag] = TextboxInput.Text
                    end
                    
                    pcall(Callback, TextboxInput.Text)
                end)
                
                TextboxFrame.MouseEnter:Connect(function()
                    Tween(TextboxFrame, {BackgroundTransparency = 0}, 0.15)
                end)
                
                TextboxFrame.MouseLeave:Connect(function()
                    Tween(TextboxFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                end)
                
                if Flag then
                    Window.Flags[Flag] = Default
                end
                
                return {
                    SetValue = function(value)
                        TextboxInput.Text = value
                        if Flag then
                            Window.Flags[Flag] = value
                        end
                        pcall(Callback, value)
                    end,
                    GetValue = function() return TextboxInput.Text end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD LABEL
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddLabel(config)
                config = config or {}
                local Text = config.Text or "Label"
                local Color = config.Color or Theme.Text
                
                local LabelFrame = CreateElement("Frame", {
                    Name = "Label",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                local Label = CreateElement("TextLabel", {
                    Name = "Text",
                    Parent = LabelFrame,
                    Position = UDim2.new(0, 14, 0, 0),
                    Size = UDim2.new(1, -28, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Text,
                    TextColor3 = Color,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Font = Enum.Font.Gotham,
                    TextWrapped = true,
                    ZIndex = 3
                })
                
                return {
                    SetText = function(text)
                        Label.Text = text
                    end,
                    SetColor = function(color)
                        Label.TextColor3 = color
                    end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD KEYBIND
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddKeybind(config)
                config = config or {}
                local Name = config.Name or "Keybind"
                local Default = config.Default or Enum.KeyCode.E
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                
                local CurrentKey = Default
                local Binding = false
                
                local KeybindFrame = CreateElement("Frame", {
                    Name = "Keybind",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = Theme.TertiaryTransparency,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                CreateElement("UICorner", {
                    Parent = KeybindFrame,
                    CornerRadius = UDim.new(0, 8)
                })
                
                CreateElement("UIStroke", {
                    Parent = KeybindFrame,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.7
                })
                
                local KeybindLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = KeybindFrame,
                    Position = UDim2.new(0, 14, 0, 0),
                    Size = UDim2.new(1, -100, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    ZIndex = 3
                })
                
                local KeybindButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = KeybindFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0, 60, 0, 26),
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.3,
                    BorderSizePixel = 0,
                    Text = Default.Name,
                    TextColor3 = Theme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    ZIndex = 3
                })
                
                CreateElement("UICorner", {
                    Parent = KeybindButton,
                    CornerRadius = UDim.new(0, 6)
                })
                
                KeybindButton.MouseButton1Click:Connect(function()
                    Binding = true
                    KeybindButton.Text = "..."
                    Tween(KeybindButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if Binding then
                        if input.KeyCode ~= Enum.KeyCode.Unknown then
                            CurrentKey = input.KeyCode
                            KeybindButton.Text = input.KeyCode.Name
                            Binding = false
                            Tween(KeybindButton, {BackgroundColor3 = Theme.Secondary}, 0.2)
                            
                            if Flag then
                                Window.Flags[Flag] = input.KeyCode
                            end
                        end
                    elseif not gameProcessed and input.KeyCode == CurrentKey then
                        pcall(Callback, input.KeyCode)
                    end
                end)
                
                KeybindFrame.MouseEnter:Connect(function()
                    Tween(KeybindFrame, {BackgroundTransparency = 0}, 0.15)
                end)
                
                KeybindFrame.MouseLeave:Connect(function()
                    Tween(KeybindFrame, {BackgroundTransparency = Theme.TertiaryTransparency}, 0.15)
                end)
                
                if Flag then
                    Window.Flags[Flag] = Default
                end
                
                return {
                    SetValue = function(key)
                        CurrentKey = key
                        KeybindButton.Text = key.Name
                        if Flag then
                            Window.Flags[Flag] = key
                        end
                    end,
                    GetValue = function() return CurrentKey end
                }
            end
            
            -- ════════════════════════════════════════════════════════════
            -- ADD DIVIDER
            -- ════════════════════════════════════════════════════════════
            
            function Section:AddDivider()
                local Divider = CreateElement("Frame", {
                    Name = "Divider",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Theme.Border,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                
                return Divider
            end
            
            return Section
        end
        
        return Page
    end
    
    -- ════════════════════════════════════════════════════════════
    -- NOTIFICATION SYSTEM
    -- ════════════════════════════════════════════════════════════
    
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
        
        local TypeIcons = {
            Info = Icons.Info,
            Success = Icons.Check,
            Warning = "⚠",
            Error = Icons.X
        }
        
        local Notification = CreateElement("Frame", {
            Name = "Notification",
            Parent = ScreenGui,
            Position = UDim2.new(1, 10, 1, -100),
            Size = UDim2.new(0, 300, 0, 80),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = Theme.SecondaryTransparency,
            BorderSizePixel = 0,
            ZIndex = 100
        })
        
        CreateElement("UICorner", {
            Parent = Notification,
            CornerRadius = UDim.new(0, 10)
        })
        
        CreateElement("UIStroke", {
            Parent = Notification,
            Color = TypeColors[Type] or Theme.Accent,
            Thickness = 2,
            Transparency = 0.3
        })
        
        -- Glow effect
        local NotifShadow = CreateElement("ImageLabel", {
            Name = "Shadow",
            Parent = Notification,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 30, 1, 30),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5554236805",
            ImageColor3 = TypeColors[Type] or Theme.Accent,
            ImageTransparency = 0.6,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            ZIndex = 99
        })
        
        local ColorBar = CreateElement("Frame", {
            Name = "Bar",
            Parent = Notification,
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = TypeColors[Type] or Theme.Accent,
            BorderSizePixel = 0,
            ZIndex = 101
        })
        
        CreateElement("UICorner", {
            Parent = ColorBar,
            CornerRadius = UDim.new(0, 10)
        })
        
        CreateElement("UIGradient", {
            Parent = ColorBar,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, TypeColors[Type] or Theme.Accent),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            }),
            Rotation = 90,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 0.5)
            })
        })
        
        local NotifTitle = CreateElement("TextLabel", {
            Name = "Title",
            Parent = Notification,
            Position = UDim2.new(0, 18, 0, 12),
            Size = UDim2.new(1, -36, 0, 20),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold,
            ZIndex = 102
        })
        
        local NotifContent = CreateElement("TextLabel", {
            Name = "Content",
            Parent = Notification,
            Position = UDim2.new(0, 18, 0, 36),
            Size = UDim2.new(1, -36, 1, -48),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            ZIndex = 102
        })
        
        Tween(Notification, {Position = UDim2.new(1, -310, 1, -100)}, 0.5, Enum.EasingStyle.Back)
        
        task.wait(Duration)
        
        Tween(Notification, {Position = UDim2.new(1, 10, 1, -100)}, 0.3)
        task.wait(0.3)
        Notification:Destroy()
    end
    
    -- ════════════════════════════════════════════════════════════
    -- CONFIG SYSTEM
    -- ════════════════════════════════════════════════════════════
    
    function Window:SaveConfig(name)
        name = name or "default"
        local config = HttpService:JSONEncode(Window.Flags)
        writefile(Window.ConfigFolder .. "/" .. name .. ".json", config)
        Window:Notify({
            Title = "Config Saved",
            Content = "Configuration '" .. name .. "' has been saved!",
            Duration = 3,
            Type = "Success"
        })
    end
    
    function Window:LoadConfig(name)
        name = name or "default"
        if isfile(Window.ConfigFolder .. "/" .. name .. ".json") then
            local config = HttpService:JSONDecode(readfile(Window.ConfigFolder .. "/" .. name .. ".json"))
            for flag, value in pairs(config) do
                Window.Flags[flag] = value
            end
            Window:Notify({
                Title = "Config Loaded",
                Content = "Configuration '" .. name .. "' has been loaded!",
                Duration = 3,
                Type = "Success"
            })
        else
            Window:Notify({
                Title = "Error",
                Content = "Configuration '" .. name .. "' not found!",
                Duration = 3,
                Type = "Error"
            })
        end
    end
    
    function Window:SetTheme(themeName)
        -- Future implementation for theme switching
    end
    
    -- Show loading animation if enabled
    if LoadingEnabled then
        task.spawn(function()
            local LoadingFrame = CreateElement("Frame", {
                Name = "Loading",
                Parent = MainFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Theme.Background,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                ZIndex = 999
            })
            
            CreateElement("UICorner", {
                Parent = LoadingFrame,
                CornerRadius = UDim.new(0, 12)
            })
            
            local LoadingText = CreateElement("TextLabel", {
                Name = "Text",
                Parent = LoadingFrame,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0.8, 0, 0, 40),
                BackgroundTransparency = 1,
                Text = "Loading Modern UI...",
                TextColor3 = Theme.Accent,
                TextSize = 16,
                Font = Enum.Font.GothamBold,
                ZIndex = 1000
            })
            
            task.wait(1)
            Tween(LoadingFrame, {BackgroundTransparency = 1}, 0.5)
            Tween(LoadingText, {TextTransparency = 1}, 0.5)
            task.wait(0.5)
            LoadingFrame:Destroy()
        end)
    end
    
    return Window
end

return Library
