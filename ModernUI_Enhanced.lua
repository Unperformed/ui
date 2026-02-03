-- ModernUI Enhanced v3.1 - Complete Roblox UI Library
-- Full features: themes, pages, toggle/slider/dropdown/button/textbox/colorpicker/keybind, notifications
-- Ready for GitHub upload - no placeholders

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local CoreGui          = game:GetService("CoreGui")
local HttpService      = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════════════════
-- THEMES (all 6 presets)
-- ════════════════════════════════════════════════════════════════════════

local ThemePresets = {
    Purple = {
        Background    = Color3.fromRGB(30,  30,  46),
        Secondary     = Color3.fromRGB(45,  45,  65),
        Tertiary      = Color3.fromRGB(55,  55,  80),
        Sidebar       = Color3.fromRGB(24,  24,  37),
        SidebarHover  = Color3.fromRGB(35,  35,  55),
        SidebarActive = Color3.fromRGB(195,126,255),
        Accent        = Color3.fromRGB(195,126,255),
        AccentHover   = Color3.fromRGB(210,160,255),
        Text          = Color3.fromRGB(245,245,250),
        TextDark      = Color3.fromRGB(200,200,220),
        TextMuted     = Color3.fromRGB(150,150,180),
        Border        = Color3.fromRGB(70,  70,  95),
        Success       = Color3.fromRGB(67, 181,129),
        Warning       = Color3.fromRGB(250,166, 26),
        Error         = Color3.fromRGB(240, 71,  71),
        Info          = Color3.fromRGB(52, 152,219),
        ToggleOn      = Color3.fromRGB(195,126,255),
        ToggleOff     = Color3.fromRGB(80,  80,100)
    },
    Red = {
        Background    = Color3.fromRGB(20, 10, 10),
        Secondary     = Color3.fromRGB(35, 15, 15),
        Tertiary      = Color3.fromRGB(50, 20, 20),
        Sidebar       = Color3.fromRGB(15, 5, 5),
        SidebarHover  = Color3.fromRGB(30, 10, 10),
        SidebarActive = Color3.fromRGB(220, 20, 60),
        Accent        = Color3.fromRGB(220, 20, 60),
        AccentHover   = Color3.fromRGB(255, 50, 90),
        Text          = Color3.fromRGB(255,235,235),
        TextDark      = Color3.fromRGB(180,150,150),
        TextMuted     = Color3.fromRGB(120, 90, 90),
        Border        = Color3.fromRGB(60, 30, 30),
        BorderLight   = Color3.fromRGB(80, 40, 40),
        Success       = Color3.fromRGB(67, 181,129),
        Warning       = Color3.fromRGB(250,166, 26),
        Error         = Color3.fromRGB(240, 71,  71),
        Info          = Color3.fromRGB(52, 152,219),
        ToggleOn      = Color3.fromRGB(220, 20, 60),
        ToggleOff     = Color3.fromRGB(60, 30, 30)
    },
    Ocean = {
        Background    = Color3.fromRGB(10, 15, 25),
        Secondary     = Color3.fromRGB(20, 30, 45),
        Tertiary      = Color3.fromRGB(30, 45, 65),
        Sidebar       = Color3.fromRGB(5, 10, 20),
        SidebarHover  = Color3.fromRGB(15, 25, 40),
        SidebarActive = Color3.fromRGB(0, 200,255),
        Accent        = Color3.fromRGB(0, 200,255),
        AccentHover   = Color3.fromRGB(80, 230,255),
        Text          = Color3.fromRGB(230,245,255),
        TextDark      = Color3.fromRGB(150,180,200),
        TextMuted     = Color3.fromRGB(100,130,150),
        Border        = Color3.fromRGB(40, 60, 85),
        BorderLight   = Color3.fromRGB(60, 80,110),
        Success       = Color3.fromRGB(46,204,113),
        Warning       = Color3.fromRGB(241,196, 15),
        Error         = Color3.fromRGB(231, 76, 60),
        Info          = Color3.fromRGB(52, 152,219),
        ToggleOn      = Color3.fromRGB(0, 200,255),
        ToggleOff     = Color3.fromRGB(50, 70, 90)
    },
    Matrix = {
        Background    = Color3.fromRGB(5, 10, 5),
        Secondary     = Color3.fromRGB(10, 20, 10),
        Tertiary      = Color3.fromRGB(15, 30, 15),
        Sidebar       = Color3.fromRGB(2, 5, 2),
        SidebarHover  = Color3.fromRGB(10, 15, 10),
        SidebarActive = Color3.fromRGB(0, 255, 65),
        Accent        = Color3.fromRGB(0, 255, 65),
        AccentHover   = Color3.fromRGB(100,255,130),
        Text          = Color3.fromRGB(150,255,150),
        TextDark      = Color3.fromRGB(80, 200, 80),
        TextMuted     = Color3.fromRGB(40, 120, 40),
        Border        = Color3.fromRGB(20, 50, 20),
        BorderLight   = Color3.fromRGB(30, 70, 30),
        Success       = Color3.fromRGB(0, 255, 65),
        Warning       = Color3.fromRGB(255,200,  0),
        Error         = Color3.fromRGB(255, 50, 50),
        Info          = Color3.fromRGB(0, 150,255),
        ToggleOn      = Color3.fromRGB(0, 255, 65),
        ToggleOff     = Color3.fromRGB(20, 50, 20)
    },
    Midnight = {
        Background    = Color3.fromRGB(12, 12, 28),
        Secondary     = Color3.fromRGB(25, 25, 45),
        Tertiary      = Color3.fromRGB(35, 35, 60),
        Sidebar       = Color3.fromRGB(8, 8, 20),
        SidebarHover  = Color3.fromRGB(20, 20, 40),
        SidebarActive = Color3.fromRGB(130,115,255),
        Accent        = Color3.fromRGB(130,115,255),
        AccentHover   = Color3.fromRGB(160,150,255),
        Text          = Color3.fromRGB(240,240,255),
        TextDark      = Color3.fromRGB(170,170,200),
        TextMuted     = Color3.fromRGB(110,110,140),
        Border        = Color3.fromRGB(45, 45, 75),
        BorderLight   = Color3.fromRGB(65, 65,100),
        Success       = Color3.fromRGB(67, 181,129),
        Warning       = Color3.fromRGB(250,166, 26),
        Error         = Color3.fromRGB(240, 71,  71),
        Info          = Color3.fromRGB(52, 152,219),
        ToggleOn      = Color3.fromRGB(130,115,255),
        ToggleOff     = Color3.fromRGB(45, 45, 70)
    },
    Sunset = {
        Background    = Color3.fromRGB(25, 15, 15),
        Secondary     = Color3.fromRGB(45, 25, 20),
        Tertiary      = Color3.fromRGB(60, 35, 30),
        Sidebar       = Color3.fromRGB(20, 10, 10),
        SidebarHover  = Color3.fromRGB(40, 20, 15),
        SidebarActive = Color3.fromRGB(255,120, 60),
        Accent        = Color3.fromRGB(255,120, 60),
        AccentHover   = Color3.fromRGB(255,160,100),
        Text          = Color3.fromRGB(255,245,230),
        TextDark      = Color3.fromRGB(210,180,160),
        TextMuted     = Color3.fromRGB(150,120,100),
        Border        = Color3.fromRGB(75, 45, 35),
        BorderLight   = Color3.fromRGB(95, 60, 50),
        Success       = Color3.fromRGB(46,204,113),
        Warning       = Color3.fromRGB(250,166, 26),
        Error         = Color3.fromRGB(240, 71,  71),
        Info          = Color3.fromRGB(52, 152,219),
        ToggleOn      = Color3.fromRGB(255,120, 60),
        ToggleOff     = Color3.fromRGB(80, 50, 40)
    }
}

local ActiveTheme = "Purple"
local Theme = ThemePresets[ActiveTheme]

-- ════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════

local function Tween(object, properties, duration)
    duration = duration or 0.25
    local tween = TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local function Create(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        element[prop] = value
    end
    return element
end

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

-- ════════════════════════════════════════════════════════════════════════
-- MAIN LIBRARY
-- ════════════════════════════════════════════════════════════════════════

function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Modern UI"
    local Subtitle = config.Subtitle or "v3.1"
    local Size = config.Size or UDim2.new(0, IsMobile() and 420 or 620, 0, IsMobile() and 520 or 460)
    local ThemeName = config.Theme or ActiveTheme

    if ThemePresets[ThemeName] then
        Theme = ThemePresets[ThemeName]
        ActiveTheme = ThemeName
    end

    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = Size
    }

    local ScreenGui = Create("ScreenGui", {
        Name = "ModernUI_" .. HttpService:GenerateGUID(false):sub(1,8),
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })

    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = Size,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    Create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 12)})

    -- Title Bar
    local TitleBar = Create("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    Create("UICorner", {Parent = TitleBar, CornerRadius = UDim.new(0, 12)})

    Create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 1, -16),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })

    Create("TextLabel", {
        Parent = TitleBar,
        Size = UDim2.new(1, -160, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Create("TextLabel", {
        Parent = TitleBar,
        Size = UDim2.new(0, 120, 1, 0),
        Position = UDim2.new(1, -130, 0, 0),
        BackgroundTransparency = 1,
        Text = Subtitle,
        TextColor3 = Theme.TextMuted,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right
    })

    local MinimizeButton = Create("TextButton", {
        Parent = TitleBar,
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(1, -80, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = "−",
        TextColor3 = Theme.Text,
        TextSize = 26,
        Font = Enum.Font.GothamBold
    })

    local CloseButton = Create("TextButton", {
        Parent = TitleBar,
        Size = UDim2.new(0, 36, 0, 36),
        Position = UDim2.new(1, -40, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.Text,
        TextSize = 26,
        Font = Enum.Font.GothamBold
    })

    -- Sidebar
    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Size = UDim2.new(0, 58, 1, -44),
        Position = UDim2.new(0, 0, 0, 44),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })

    -- Content Area
    local ContentArea = Create("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Size = UDim2.new(1, -58, 1, -44),
        Position = UDim2.new(0, 58, 0, 44),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })

    -- Dragging
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Minimize / Close
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 44)}, 0.3)
        else
            Tween(MainFrame, {Size = Window.OriginalSize}, 0.3)
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0,0,0,0)}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.4, function() ScreenGui:Destroy() end)
    end)

    -- Page switching with fade
    local function SwitchPage(newPage)
        if Window.CurrentPage == newPage then return end

        local old = Window.CurrentPage
        if old then
            Tween(old.Frame, {BackgroundTransparency = 1}, 0.2)
            task.delay(0.21, function() old.Frame.Visible = false end)
            Tween(old.Button, {BackgroundColor3 = Theme.Sidebar}, 0.2)
            local icon = old.Button:FindFirstChild("Icon")
            if icon then Tween(icon, {ImageColor3 = Theme.TextMuted}, 0.2) end
        end

        newPage.Frame.BackgroundTransparency = 1
        newPage.Frame.Visible = true
        Tween(newPage.Frame, {BackgroundTransparency = 0}, 0.25)
        Tween(newPage.Button, {BackgroundColor3 = Theme.SidebarActive}, 0.2)
        local icon = newPage.Button:FindFirstChild("Icon")
        if icon then Tween(icon, {ImageColor3 = Theme.Text}, 0.2) end

        Window.CurrentPage = newPage
    end

    -- ════════════════════════════════════════════════════════════════════════
    -- CREATE PAGE
    -- ════════════════════════════════════════════════════════════════════════

    function Window:CreatePage(config)
        config = config or {}
        local Name = config.Name or "Page"
        local Icon = config.Icon

        local Page = { Visible = false }

        local PageFrame = Create("ScrollingFrame", {
            Name = Name,
            Parent = ContentArea,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 5,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false
        })

        Create("UIPadding", {
            Parent = PageFrame,
            PaddingTop = UDim.new(0, 16),
            PaddingLeft = UDim.new(0, 16),
            PaddingRight = UDim.new(0, 16),
            PaddingBottom = UDim.new(0, 16)
        })

        Create("UIListLayout", {
            Parent = PageFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 14)
        })

        -- Sidebar Button
        local ButtonSize = IsMobile() and 52 or 46
        local PageButton = Create("TextButton", {
            Name = Name,
            Parent = Sidebar,
            Size = UDim2.new(0, ButtonSize, 0, ButtonSize),
            BackgroundColor3 = Theme.Sidebar,
            BorderSizePixel = 0,
            AutoButtonColor = false
        })
        Create("UICorner", {Parent = PageButton, CornerRadius = UDim.new(0, 10)})

        if Icon then
            Create("ImageLabel", {
                Name = "Icon",
                Parent = PageButton,
                Size = UDim2.new(0, 26, 0, 26),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = Icon,
                ImageColor3 = Theme.TextMuted,
                ScaleType = Enum.ScaleType.Fit
            })
        end

        PageButton.MouseButton1Click:Connect(function()
            SwitchPage(Page)
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
            Page.Frame.Visible = true
            Page.Frame.BackgroundTransparency = 0
            Page.Visible = true
            Page.Button.BackgroundColor3 = Theme.SidebarActive
            local icon = Page.Button:FindFirstChild("Icon")
            if icon then icon.ImageColor3 = Theme.Text end
            Window.CurrentPage = Page
        end

        -- ════════════════════════════════════════════════════════════════════════
        -- CREATE SECTION
        -- ════════════════════════════════════════════════════════════════════════

        function Page:CreateSection(sectionName)
            local Section = { Elements = {} }

            local SectionFrame = Create("Frame", {
                Parent = PageFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })

            Create("UIListLayout", {
                Parent = SectionFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })

            Create("TextLabel", {
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Theme.Text,
                TextSize = 16,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local LeftColumn = Create("Frame", {
                Parent = SectionFrame,
                Size = UDim2.new(0.48, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            Create("UIListLayout", {Parent = LeftColumn, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)})

            local RightColumn = Create("Frame", {
                Parent = SectionFrame,
                Size = UDim2.new(0.48, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            Create("UIListLayout", {Parent = RightColumn, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)})

            Section.Left = LeftColumn
            Section.Right = RightColumn
            Section.Frame = SectionFrame

            local function GetSmallestColumn()
                return LeftColumn.AbsoluteSize.Y <= RightColumn.AbsoluteSize.Y and LeftColumn or RightColumn
            end

            -- LABEL
            function Section:AddLabel(config)
                config = config or {}
                local Text = config.Text or "Label"

                local Label = Create("TextLabel", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = Text,
                    TextColor3 = Theme.TextDark,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                return { SetText = function(t) Label.Text = t end }
            end

            -- DIVIDER
            function Section:AddDivider()
                Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Theme.Border,
                    BorderSizePixel = 0
                })
            end

            -- PARAGRAPH
            function Section:AddParagraph(config)
                config = config or {}
                local TitleText = config.Title or "Paragraph"
                local ContentText = config.Content or ""

                local Container = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                Create("UIListLayout", {Parent = Container, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})

                Create("TextLabel", {
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = TitleText,
                    TextColor3 = Theme.Text,
                    TextSize = 15,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                Create("TextLabel", {
                    Parent = Container,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = ContentText,
                    TextColor3 = Theme.TextDark,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
            end

            -- TOGGLE
            function Section:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end

                local ToggleFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = ToggleFrame, CornerRadius = UDim.new(0, 6)})

                Create("TextLabel", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(1, -70, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local ToggleButton = Create("TextButton", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 44, 0, 22),
                    Position = UDim2.new(1, -54, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Default and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                Create("UICorner", {Parent = ToggleButton, CornerRadius = UDim.new(1, 0)})

                local Circle = Create("Frame", {
                    Parent = ToggleButton,
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = Default and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = Circle, CornerRadius = UDim.new(1, 0)})

                local Value = Default
                local function Update(value)
                    Value = value
                    Tween(ToggleButton, {BackgroundColor3 = value and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
                    Tween(Circle, {Position = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.2)
                    pcall(Callback, value)
                end

                ToggleButton.MouseButton1Click:Connect(function()
                    Update(not Value)
                end)

                local ToggleObject = {
                    SetValue = function(v) Update(v) end,
                    Toggle = function() Update(not Value) end
                }

                table.insert(Section.Elements, ToggleObject)
                return ToggleObject
            end

            -- SLIDER
            function Section:AddSlider(config)
                config = config or {}
                local Name = config.Name or "Slider"
                local Min = config.Min or 0
                local Max = config.Max or 100
                local Default = config.Default or Min
                local Increment = config.Increment or 1
                local Suffix = config.Suffix or ""
                local Callback = config.Callback or function() end

                local currentValue = Default

                local SliderFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 54),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = SliderFrame, CornerRadius = UDim.new(0, 8)})

                Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(1, -80, 0, 18),
                    Position = UDim2.new(0, 12, 0, 8),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamSemibold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local ValueLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0, 60, 0, 18),
                    Position = UDim2.new(1, -72, 0, 8),
                    BackgroundTransparency = 1,
                    Text = tostring(Default) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right
                })

                local Track = Create("Frame", {
                    Parent = SliderFrame,
                    Size = UDim2.new(1, -24, 0, 6),
                    Position = UDim2.new(0, 12, 0, 36),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = Track, CornerRadius = UDim.new(1, 0)})

                local Fill = Create("Frame", {
                    Parent = Track,
                    Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = Fill, CornerRadius = UDim.new(1, 0)})

                local Knob = Create("Frame", {
                    Parent = Track,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new((Default - Min) / (Max - Min), -8, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = Knob, CornerRadius = UDim.new(1, 0)})

                local dragging = false

                local function UpdateSlider(value, skipCallback)
                    value = math.clamp(value, Min, Max)
                    value = math.floor((value - Min) / Increment + 0.5) * Increment + Min
                    currentValue = value

                    local ratio = (value - Min) / (Max - Min)
                    ValueLabel.Text = tostring(value) .. Suffix
                    Tween(Fill, {Size = UDim2.new(ratio, 0, 1, 0)}, 0.12)
                    Tween(Knob, {Position = UDim2.new(ratio, -8, 0.5, 0)}, 0.12)

                    if not skipCallback then
                        pcall(Callback, value)
                    end
                end

                Track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        local relX = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                        UpdateSlider(Min + (Max - Min) * relX)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local relX = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                        UpdateSlider(Min + (Max - Min) * relX)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                local SliderObject = {
                    SetValue = function(v, skip) UpdateSlider(v, skip) end,
                    GetValue = function() return currentValue end
                }

                table.insert(Section.Elements, SliderObject)
                return SliderObject
            end

            -- DROPDOWN
            function Section:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or {"Option 1", "Option 2"}
                local Default = config.Default or Options[1]
                local Callback = config.Callback or function() end

                local currentValue = Default
                local isOpen = false

                local DropdownFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                Create("UICorner", {Parent = DropdownFrame, CornerRadius = UDim.new(0, 6)})

                local Label = Create("TextLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, -40, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Name .. ": " .. currentValue,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local Arrow = Create("TextLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -30, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextMuted,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold
                })

                local OptionsList = Create("Frame", {
                    Name = "OptionsList",
                    Parent = ScreenGui,
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 100,
                    ClipsDescendants = true
                })
                Create("UICorner", {Parent = OptionsList, CornerRadius = UDim.new(0, 6)})
                Create("UIListLayout", {Parent = OptionsList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2)})
                Create("UIPadding", {Parent = OptionsList, PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6)})

                local function UpdateDropdown(value)
                    currentValue = value
                    Label.Text = Name .. ": " .. value
                    pcall(Callback, value)
                end

                local function UpdateListPosition()
                    local pos = DropdownFrame.AbsolutePosition
                    local sz = DropdownFrame.AbsoluteSize
                    OptionsList.Position = UDim2.new(0, pos.X, 0, pos.Y + sz.Y + 4)
                    OptionsList.Size = UDim2.new(0, sz.X, 0, 0)
                end

                DropdownFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isOpen = not isOpen
                        OptionsList.Visible = isOpen
                        if isOpen then
                            UpdateListPosition()
                            local height = #Options * 34 + 12
                            Tween(OptionsList, {Size = UDim2.new(0, DropdownFrame.AbsoluteSize.X, 0, height)}, 0.2)
                            Tween(Arrow, {Rotation = 180}, 0.2)
                        else
                            Tween(OptionsList, {Size = UDim2.new(0, DropdownFrame.AbsoluteSize.X, 0, 0)}, 0.2)
                            Tween(Arrow, {Rotation = 0}, 0.2)
                            task.delay(0.2, function() OptionsList.Visible = false end)
                        end
                    end
                end)

                for _, option in ipairs(Options) do
                    local OptionButton = Create("TextButton", {
                        Parent = OptionsList,
                        Size = UDim2.new(1, 0, 0, 32),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = "  " .. option,
                        TextColor3 = Theme.Text,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false
                    })

                    OptionButton.MouseButton1Click:Connect(function()
                        UpdateDropdown(option)
                        isOpen = false
                        Tween(OptionsList, {Size = UDim2.new(0, DropdownFrame.AbsoluteSize.X, 0, 0)}, 0.2)
                        Tween(Arrow, {Rotation = 0}, 0.2)
                        task.delay(0.2, function() OptionsList.Visible = false end)
                    end)
                end

                local DropdownObject = {
                    SetValue = function(v) UpdateDropdown(v) end,
                    GetValue = function() return currentValue end
                }

                table.insert(Section.Elements, DropdownObject)
                return DropdownObject
            end

            -- BUTTON
            function Section:AddButton(config)
                config = config or {}
                local Name = config.Name or "Button"
                local Callback = config.Callback or function() end

                local Button = Create("TextButton", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold
                })
                Create("UICorner", {Parent = Button, CornerRadius = UDim.new(0, 6)})

                Button.MouseButton1Click:Connect(function()
                    pcall(Callback)
                end)

                return { Fire = function() pcall(Callback) end }
            end

            -- TEXTBOX
            function Section:AddTextbox(config)
                config = config or {}
                local Name = config.Name or "Textbox"
                local Default = config.Default or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local NumbersOnly = config.NumbersOnly or false

                local TextboxFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = TextboxFrame, CornerRadius = UDim.new(0, 6)})

                Create("TextLabel", {
                    Parent = TextboxFrame,
                    Size = UDim2.new(1, -24, 0, 14),
                    Position = UDim2.new(0, 12, 0, 4),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.TextDark,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local Input = Create("TextBox", {
                    Parent = TextboxFrame,
                    Size = UDim2.new(1, -24, 0, 20),
                    Position = UDim2.new(0, 12, 0, 18),
                    BackgroundTransparency = 1,
                    Text = Default,
                    PlaceholderText = Placeholder,
                    TextColor3 = Theme.Text,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                if NumbersOnly then
                    Input:GetPropertyChangedSignal("Text"):Connect(function()
                        Input.Text = Input.Text:gsub("%D", "")
                    end)
                end

                Input.FocusLost:Connect(function()
                    pcall(Callback, Input.Text)
                end)

                local TextboxObject = {
                    SetValue = function(text)
                        Input.Text = tostring(text)
                    end,
                    GetValue = function()
                        return Input.Text
                    end
                }

                table.insert(Section.Elements, TextboxObject)
                return TextboxObject
            end

            -- COLOR PICKER (basic HSV version)
            function Section:AddColorPicker(config)
                config = config or {}
                local Name = config.Name or "Color Picker"
                local Default = config.Default or Color3.fromRGB(255, 0, 0)
                local Callback = config.Callback or function() end

                local currentColor = Default

                local PickerFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = PickerFrame, CornerRadius = UDim.new(0, 6)})

                Create("TextLabel", {
                    Parent = PickerFrame,
                    Size = UDim2.new(1, -80, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local ColorPreview = Create("Frame", {
                    Parent = PickerFrame,
                    Size = UDim2.new(0, 30, 0, 24),
                    Position = UDim2.new(1, -42, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = currentColor,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = ColorPreview, CornerRadius = UDim.new(0, 4)})

                local PickerButton = Create("TextButton", {
                    Parent = PickerFrame,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    AutoButtonColor = false
                })

                -- Simple color picker popup (HSV)
                local PickerPopup = Create("Frame", {
                    Parent = ScreenGui,
                    Size = UDim2.new(0, 220, 0, 180),
                    Position = UDim2.new(0.5, -110, 0.5, -90),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 100
                })
                Create("UICorner", {Parent = PickerPopup, CornerRadius = UDim.new(0, 8)})

                -- Hue slider (simplified)
                local HueSlider = Create("Frame", {
                    Parent = PickerPopup,
                    Size = UDim2.new(0, 200, 0, 20),
                    Position = UDim2.new(0, 10, 0, 10),
                    BackgroundColor3 = Color3.new(1,1,1),
                    BorderSizePixel = 0
                })

                local HueGradient = Create("UIGradient", {
                    Parent = HueSlider,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
                        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255,255,0)),
                        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0,255,0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
                        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0,0,255)),
                        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255,0,255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0))
                    }
                })

                local HueKnob = Create("Frame", {
                    Parent = HueSlider,
                    Size = UDim2.new(0, 8, 1, 4),
                    Position = UDim2.new(0.5, -4, 0, -2),
                    BackgroundColor3 = Color3.new(1,1,1),
                    BorderSizePixel = 0
                })

                -- SV square (simplified)
                local SVSquare = Create("ImageButton", {
                    Parent = PickerPopup,
                    Size = UDim2.new(0, 200, 0, 100),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundColor3 = Color3.fromHSV(0, 1, 1),
                    BorderSizePixel = 0,
                    Image = "rbxassetid://3570695787", -- white-black gradient
                    ImageTransparency = 0
                })
                Create("UICorner", {Parent = SVSquare, CornerRadius = UDim.new(0, 6)})

                local SVKnob = Create("Frame", {
                    Parent = SVSquare,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(1, -8, 0, -8),
                    BackgroundColor3 = Color3.new(1,1,1),
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.new(0,0,0)
                })
                Create("UICorner", {Parent = SVKnob, CornerRadius = UDim.new(1,0)})

                local hue, sat, val = 0, 1, 1

                local function UpdateColor()
                    local r, g, b = Color3.fromHSV(hue, sat, val)
                    currentColor = r
                    ColorPreview.BackgroundColor3 = r
                    SVSquare.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                    pcall(Callback, r)
                end

                local draggingHue, draggingSV = false, false

                HueSlider.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingHue = true
                    end
                end)

                SVSquare.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingSV = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingHue = false
                        draggingSV = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(i)
                    if draggingHue and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        local rel = math.clamp((i.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
                        hue = rel
                        HueKnob.Position = UDim2.new(rel, -4, 0, -2)
                        UpdateColor()
                    end
                    if draggingSV and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        local sx = math.clamp((i.Position.X - SVSquare.AbsolutePosition.X) / SVSquare.AbsoluteSize.X, 0, 1)
                        local sy = math.clamp((i.Position.Y - SVSquare.AbsolutePosition.Y) / SVSquare.AbsoluteSize.Y, 0, 1)
                        sat = sx
                        val = 1 - sy
                        SVKnob.Position = UDim2.new(sx, -8, sy, -8)
                        UpdateColor()
                    end
                end)

                PickerButton.MouseButton1Click:Connect(function()
                    PickerPopup.Visible = not PickerPopup.Visible
                end)

                local ColorPickerObject = {
                    SetColor = function(col)
                        currentColor = col
                        local h, s, v = Color3.toHSV(col)
                        hue, sat, val = h, s, v
                        ColorPreview.BackgroundColor3 = col
                        SVSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                        SVKnob.Position = UDim2.new(s, -8, 1-v, -8)
                        HueKnob.Position = UDim2.new(h, -4, 0, -2)
                        pcall(Callback, col)
                    end,
                    GetColor = function() return currentColor end
                }

                table.insert(Section.Elements, ColorPickerObject)
                return ColorPickerObject
            end

            -- KEYBIND
            function Section:AddKeybind(config)
                config = config or {}
                local Name = config.Name or "Keybind"
                local Default = config.Default or Enum.KeyCode.Unknown
                local Callback = config.Callback or function() end

                local currentKey = Default.Name or "None"
                local listening = false

                local KeyFrame = Create("Frame", {
                    Parent = GetSmallestColumn(),
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = KeyFrame, CornerRadius = UDim.new(0, 6)})

                Create("TextLabel", {
                    Parent = KeyFrame,
                    Size = UDim2.new(1, -100, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local KeyButton = Create("TextButton", {
                    Parent = KeyFrame,
                    Size = UDim2.new(0, 80, 0, 28),
                    Position = UDim2.new(1, -92, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = currentKey,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold
                })
                Create("UICorner", {Parent = KeyButton, CornerRadius = UDim.new(0, 5)})

                KeyButton.MouseButton1Click:Connect(function()
                    listening = true
                    KeyButton.Text = "..."
                end)

                UserInputService.InputBegan:Connect(function(input, gpe)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard and not gpe then
                        currentKey = input.KeyCode.Name
                        KeyButton.Text = currentKey
                        listening = false
                        pcall(Callback, input.KeyCode)
                    end
                end)

                local KeybindObject = {
                    SetKey = function(key)
                        currentKey = key.Name
                        KeyButton.Text = currentKey
                    end
                }

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
        local Duration = config.Duration or 4
        local Type = config.Type or "Info"

        local colors = {
            Info = Theme.Info,
            Success = Theme.Success,
            Warning = Theme.Warning,
            Error = Theme.Error
        }

        local Notif = Create("Frame", {
            Parent = ScreenGui,
            Size = UDim2.new(0, 360, 0, 120),
            Position = UDim2.new(1, -380, 1, -140),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0
        })
        Create("UICorner", {Parent = Notif, CornerRadius = UDim.new(0, 14)})

        Create("Frame", {
            Parent = Notif,
            Size = UDim2.new(0, 6, 1, 0),
            BackgroundColor3 = colors[Type] or Theme.Accent,
            BorderSizePixel = 0
        })

        Create("TextLabel", {
            Parent = Notif,
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 16, 0, 16),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 18,
            Font = Enum.Font.GothamSemibold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })

        Create("TextLabel", {
            Parent = Notif,
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 16, 0, 42),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 15,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true
        })

        Notif.BackgroundTransparency = 1
        Tween(Notif, {BackgroundTransparency = 0, Position = UDim2.new(1, -380, 1, -140)}, 0.4)

        task.delay(Duration, function()
            Tween(Notif, {BackgroundTransparency = 1, Position = UDim2.new(1, -380, 1, -90)}, 0.5)
            task.delay(0.6, Notif.Destroy, Notif)
        end)
    end

    return Window
end

return Library
