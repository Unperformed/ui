--[[
    Universal Modern Roblox UI Library
    Version: 3.0.0
    Features: Transparent acrylic, Purple/White theme, All WindUI elements
    Supports: Mobile & PC
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Utility Functions
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

-- Theme System - Dark Purple/White with Transparency
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),
    Secondary = Color3.fromRGB(25, 25, 40),
    Tertiary = Color3.fromRGB(35, 35, 55),
    Sidebar = Color3.fromRGB(12, 12, 20),
    SidebarHover = Color3.fromRGB(30, 30, 50),
    SidebarActive = Color3.fromRGB(147, 112, 219),
    Accent = Color3.fromRGB(147, 112, 219),
    AccentHover = Color3.fromRGB(170, 130, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(200, 200, 220),
    TextMuted = Color3.fromRGB(140, 140, 160),
    Success = Color3.fromRGB(100, 255, 150),
    Warning = Color3.fromRGB(255, 200, 100),
    Error = Color3.fromRGB(255, 100, 100),
    Info = Color3.fromRGB(100, 180, 255),
    ToggleOn = Color3.fromRGB(147, 112, 219),
    ToggleOff = Color3.fromRGB(60, 60, 80),
    SliderBar = Color3.fromRGB(50, 50, 70),
    SliderFill = Color3.fromRGB(147, 112, 219),
    WindowTransparency = 0.1,
}

function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Script Hub"
    local Subtitle = config.Subtitle or "v1.0"
    local Size = config.Size or UDim2.new(0, IsMobile() and 360 or 580, 0, IsMobile() and 450 or 420)
    local Acrylic = config.Acrylic ~= false
    local KeySystem = config.KeySystem

    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = Size,
        Flags = {},
        ToggleKey = Enum.KeyCode.RightShift
    }

    -- Key System
    if KeySystem then
        local KeyFrame = CreateElement("Frame", {
            Name = "KeySystem",
            Parent = CoreGui,
            Size = UDim2.new(0, 400, 0, 250),
            Position = UDim2.new(0.5, -200, 0.5, -125),
            BackgroundColor3 = Theme.Background,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
        })

        CreateElement("UICorner", {Parent = KeyFrame, CornerRadius = UDim.new(0, 12)})

        local KeyTitle = CreateElement("TextLabel", {
            Parent = KeyFrame,
            Position = UDim2.new(0, 0, 0, 20),
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            Text = KeySystem.Title or "Key System",
            TextColor3 = Theme.Text,
            TextSize = 20,
            Font = Enum.Font.GothamBold,
        })

        local KeyInput = CreateElement("TextBox", {
            Parent = KeyFrame,
            Position = UDim2.new(0.5, -150, 0.5, -20),
            Size = UDim2.new(0, 300, 0, 40),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.2,
            PlaceholderText = "Enter key...",
            PlaceholderColor3 = Theme.TextMuted,
            TextColor3 = Theme.Text,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            ClearTextOnFocus = false,
        })

        CreateElement("UICorner", {Parent = KeyInput, CornerRadius = UDim.new(0, 8)})
        CreateElement("UIPadding", {Parent = KeyInput, PaddingLeft = UDim.new(0, 12)})

        local SubmitBtn = CreateElement("TextButton", {
            Parent = KeyFrame,
            Position = UDim2.new(0.5, -75, 1, -70),
            Size = UDim2.new(0, 150, 0, 40),
            BackgroundColor3 = Theme.Accent,
            Text = "Submit",
            TextColor3 = Theme.Text,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false,
        })

        CreateElement("UICorner", {Parent = SubmitBtn, CornerRadius = UDim.new(0, 8)})

        local Validated = false

        SubmitBtn.MouseButton1Click:Connect(function()
            local key = KeyInput.Text
            local isValid = false

            if KeySystem.Key then
                if type(KeySystem.Key) == "table" then
                    isValid = table.find(KeySystem.Key, key) ~= nil
                else
                    isValid = tostring(KeySystem.Key) == key
                end
            end

            if KeySystem.Callback then
                isValid = KeySystem.Callback(key)
            end

            if isValid then
                Validated = true
                Tween(KeyFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
                task.wait(0.3)
                KeyFrame:Destroy()
            else
                KeyInput.Text = ""
                KeyInput.PlaceholderText = "Invalid key!"
                Tween(KeyInput, {BackgroundColor3 = Theme.Error}, 0.2)
                task.wait(0.2)
                Tween(KeyInput, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end
        end)

        repeat task.wait() until Validated
    end

    local ScreenGui = CreateElement("ScreenGui", {
        Name = "ModernUI_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = 999
    })

    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = Size,
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = Acrylic and Theme.WindowTransparency or 0,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })

    CreateElement("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 12)})

    if Acrylic then
        local Blur = CreateElement("ImageLabel", {
            Name = "Blur",
            Parent = MainFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5554236805",
            ImageColor3 = Color3.fromRGB(20, 20, 35),
            ImageTransparency = 0.4,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(23, 23, 277, 277),
            ZIndex = -2
        })
    end

    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 60, 1, 60),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        ZIndex = -3
    })

    local TitleBar = CreateElement("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Acrylic and 0.3 or 0,
        BorderSizePixel = 0
    })

    CreateElement("UICorner", {Parent = TitleBar, CornerRadius = UDim.new(0, 12)})

    local TitleBarCover = CreateElement("Frame", {
        Name = "Cover",
        Parent = TitleBar,
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Acrylic and 0.3 or 0,
        BorderSizePixel = 0
    })

    local StatusIndicator = CreateElement("Frame", {
        Name = "Status",
        Parent = TitleBar,
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.new(0, 10, 0, 10),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Theme.Success,
        BorderSizePixel = 0
    })

    CreateElement("UICorner", {Parent = StatusIndicator, CornerRadius = UDim.new(1, 0)})

    task.spawn(function()
        while ScreenGui.Parent do
            Tween(StatusIndicator, {Size = UDim2.new(0, 12, 0, 12)}, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1.5)
            Tween(StatusIndicator, {Size = UDim2.new(0, 10, 0, 10)}, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1.5)
        end
    end)

    local TitleLabel = CreateElement("TextLabel", {
        Name = "Title",
        Parent = TitleBar,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(1, -200, 0, 45),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold
    })

    local SubtitleLabel = CreateElement("TextLabel", {
        Name = "Subtitle",
        Parent = TitleBar,
        Position = UDim2.new(1, -140, 0, 0),
        Size = UDim2.new(0, 100, 0, 45),
        BackgroundTransparency = 1,
        Text = Subtitle,
        TextColor3 = Theme.TextMuted,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
        Font = Enum.Font.Gotham
    })

    local ControlsFrame = CreateElement("Frame", {
        Name = "Controls",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -15, 0.5, 0),
        Size = UDim2.new(0, 70, 0, 30),
        BackgroundTransparency = 1
    })

    local MinimizeButton = CreateElement("TextButton", {
        Name = "Minimize",
        Parent = ControlsFrame,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 30, 1, 0),
        BackgroundTransparency = 1,
        Text = "─",
        TextColor3 = Theme.TextDark,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })

    local CloseButton = CreateElement("TextButton", {
        Name = "Close",
        Parent = ControlsFrame,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(0, 30, 1, 0),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = Theme.TextDark,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })

    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)

    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.Error}, 0.2)
    end)

    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 45)}, 0.3)
            MinimizeButton.Text = "□"
        else
            Tween(MainFrame, {Size = Window.OriginalSize}, 0.3)
            MinimizeButton.Text = "─"
        end
    end)

    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.Text}, 0.2)
    end)

    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {TextColor3 = Theme.TextDark}, 0.2)
    end)

    local Sidebar = CreateElement("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 45),
        Size = UDim2.new(0, 55, 1, -45),
        BackgroundColor3 = Theme.Sidebar,
        BackgroundTransparency = Acrylic and 0.4 or 0.1,
        BorderSizePixel = 0
    })

    CreateElement("UIListLayout", {
        Parent = Sidebar,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })

    CreateElement("UIPadding", {Parent = Sidebar, PaddingTop = UDim.new(0, 15)})

    local ContentFrame = CreateElement("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Position = UDim2.new(0, 55, 0, 45),
        Size = UDim2.new(1, -55, 1, -45),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })

    -- Dragging
    local dragging = false
    local dragStart = nil
    local startPos = nil

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
            if dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)

    -- Toggle Key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Window.ToggleKey then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Config Manager
    Window.ConfigManager = {}

    function Window.ConfigManager:SaveConfig(name, data)
        if not isfolder("ModernUI") then makefolder("ModernUI") end
        if not isfolder("ModernUI/" .. Title) then makefolder("ModernUI/" .. Title) end
        writefile("ModernUI/" .. Title .. "/" .. name .. ".json", HttpService:JSONEncode(data))
        return true
    end

    function Window.ConfigManager:LoadConfig(name)
        local path = "ModernUI/" .. Title .. "/" .. name .. ".json"
        if isfile(path) then
            return HttpService:JSONDecode(readfile(path))
        end
        return nil
    end

    function Window:SetToggleKey(key)
        Window.ToggleKey = key
    end

    -- Create Page
    function Window:CreatePage(config)
        config = config or {}
        local PageName = config.Name or "Page"
        local Icon = config.Icon

        local Page = {
            Name = PageName,
            Sections = {},
            Elements = {},
            Flags = {}
        }

        local SidebarButton = CreateElement("TextButton", {
            Name = "Btn_" .. PageName,
            Parent = Sidebar,
            Size = UDim2.new(0, 42, 0, 42),
            BackgroundColor3 = Theme.SidebarHover,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            Text = Icon or PageName:sub(1, 1),
            TextColor3 = Theme.TextDark,
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            AutoButtonColor = false
        })

        CreateElement("UICorner", {Parent = SidebarButton, CornerRadius = UDim.new(0, 10)})

        local PageFrame = CreateElement("ScrollingFrame", {
            Name = "Page_" .. PageName,
            Parent = ContentFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ScrollingDirection = Enum.ScrollingDirection.Y
        })

        CreateElement("UIPadding", {
            Parent = PageFrame,
            PaddingTop = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15)
        })

        CreateElement("UIListLayout", {
            Parent = PageFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 15)
        })

        SidebarButton.MouseButton1Click:Connect(function()
            for _, page in pairs(Window.Pages) do
                page.Frame.Visible = false
                page.Button.BackgroundColor3 = Theme.SidebarHover
                page.Button.TextColor3 = Theme.TextDark
            end
            PageFrame.Visible = true
            Window.CurrentPage = Page
            Tween(SidebarButton, {BackgroundColor3 = Theme.SidebarActive}, 0.2)
            SidebarButton.TextColor3 = Theme.Text
        end)

        SidebarButton.MouseEnter:Connect(function()
            if Window.CurrentPage ~= Page then
                Tween(SidebarButton, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end
        end)

        SidebarButton.MouseLeave:Connect(function()
            if Window.CurrentPage ~= Page then
                Tween(SidebarButton, {BackgroundColor3 = Theme.SidebarHover}, 0.2)
            end
        end)

        Page.Frame = PageFrame
        Page.Button = SidebarButton

        if #Window.Pages == 0 then
            PageFrame.Visible = true
            Window.CurrentPage = Page
            SidebarButton.BackgroundColor3 = Theme.SidebarActive
            SidebarButton.TextColor3 = Theme.Text
        end

        table.insert(Window.Pages, Page)

        local function UpdateCanvas()
            task.wait(0.1)
            local contentHeight = 0
            for _, child in pairs(PageFrame:GetChildren()) do
                if child:IsA("Frame") or child:IsA("TextLabel") then
                    contentHeight = contentHeight + child.AbsoluteSize.Y + 15
                end
            end
            PageFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
        end

        PageFrame.ChildAdded:Connect(UpdateCanvas)
        PageFrame.ChildRemoved:Connect(UpdateCanvas)

        function Page:CreateSection(sectionName)
            local Section = {
                Name = sectionName,
                Elements = {},
                Flags = {}
            }

            local SectionFrame = CreateElement("Frame", {
                Name = "Section_" .. sectionName,
                Parent = PageFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = #Page.Sections
            })

            CreateElement("UICorner", {Parent = SectionFrame, CornerRadius = UDim.new(0, 10)})

            CreateElement("UIPadding", {
                Parent = SectionFrame,
                PaddingTop = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12)
            })

            CreateElement("UIListLayout", {
                Parent = SectionFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })

            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Theme.Text,
                TextSize = 15,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                LayoutOrder = 0
            })

            local ColumnsContainer = CreateElement("Frame", {
                Name = "Columns",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            })

            local LeftColumn = CreateElement("Frame", {
                Name = "Left",
                Parent = ColumnsContainer,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0.48, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })

            CreateElement("UIListLayout", {
                Parent = LeftColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })

            local RightColumn = CreateElement("Frame", {
                Name = "Right",
                Parent = ColumnsContainer,
                Position = UDim2.new(0.52, 0, 0, 0),
                Size = UDim2.new(0.48, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })

            CreateElement("UIListLayout", {
                Parent = RightColumn,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })

            Section.Left = LeftColumn
            Section.Right = RightColumn
            Section.Container = SectionFrame

            table.insert(Page.Sections, Section)

            local function GetSmallestColumn()
                return LeftColumn.AbsoluteSize.Y <= RightColumn.AbsoluteSize.Y and LeftColumn or RightColumn
            end

            -- Toggle
            function Section:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                local Column = config.Column or GetSmallestColumn()

                local ToggleFrame = CreateElement("Frame", {
                    Name = "Toggle",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = ToggleFrame, CornerRadius = UDim.new(0, 8)})

                local ToggleLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ToggleFrame,
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

                local ToggleButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = ToggleFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 42, 0, 22),
                    BackgroundColor3 = Default and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })

                CreateElement("UICorner", {Parent = ToggleButton, CornerRadius = UDim.new(1, 0)})

                local Circle = CreateElement("Frame", {
                    Name = "Circle",
                    Parent = ToggleButton,
                    Position = Default and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 18, 0, 18),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = Circle, CornerRadius = UDim.new(1, 0)})

                local Toggled = Default

                local function SetValue(value)
                    Toggled = value
                    Tween(ToggleButton, {BackgroundColor3 = Toggled and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
                    Tween(Circle, {Position = Toggled and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.2)
                    if Flag then Window.Flags[Flag] = Toggled end
                    pcall(Callback, Toggled)
                end

                ToggleButton.MouseButton1Click:Connect(function() SetValue(not Toggled) end)
                if Flag then Window.Flags[Flag] = Toggled end

                return {SetValue = SetValue, GetValue = function() return Toggled end}
            end

            -- Slider
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
                local Column = config.Column or GetSmallestColumn()

                local SliderFrame = CreateElement("Frame", {
                    Name = "Slider",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = SliderFrame, CornerRadius = UDim.new(0, 8)})

                local SliderLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 0, 10),
                    Size = UDim2.new(1, -90, 0, 16),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local SliderValue = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = SliderFrame,
                    Position = UDim2.new(1, -75, 0, 10),
                    Size = UDim2.new(0, 65, 0, 16),
                    BackgroundTransparency = 1,
                    Text = tostring(Default) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamBold
                })

                local SliderBar = CreateElement("Frame", {
                    Name = "Bar",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 1, -22),
                    Size = UDim2.new(1, -24, 0, 6),
                    BackgroundColor3 = Theme.SliderBar,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = SliderBar, CornerRadius = UDim.new(1, 0)})

                local SliderFill = CreateElement("Frame", {
                    Name = "Fill",
                    Parent = SliderBar,
                    Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.SliderFill,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = SliderFill, CornerRadius = UDim.new(1, 0)})

                local SliderHandle = CreateElement("Frame", {
                    Name = "Handle",
                    Parent = SliderBar,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new((Default - Min) / (Max - Min), 0, 0.5, 0),
                    Size = UDim2.new(0, 14, 0, 14),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = SliderHandle, CornerRadius = UDim.new(1, 0)})

                local Dragging = false
                local Value = Default

                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    Value = math.floor((Min + (Max - Min) * pos) / Increment + 0.5) * Increment
                    Value = math.clamp(Value, Min, Max)
                    SliderValue.Text = tostring(Value) .. Suffix
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    SliderHandle.Position = UDim2.new(pos, 0, 0.5, 0)
                    if Flag then Window.Flags[Flag] = Value end
                    pcall(Callback, Value)
                end

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        UpdateSlider(input)
                    end
                end)

                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateSlider(input)
                    end
                end)

                local function SetValue(val)
                    Value = math.clamp(val, Min, Max)
                    local pos = (Value - Min) / (Max - Min)
                    SliderValue.Text = tostring(Value) .. Suffix
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    SliderHandle.Position = UDim2.new(pos, 0, 0.5, 0)
                    if Flag then Window.Flags[Flag] = Value end
                    pcall(Callback, Value)
                end

                if Flag then Window.Flags[Flag] = Value end

                return {SetValue = SetValue, GetValue = function() return Value end}
            end

            -- Dropdown
            function Section:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or config.Values or {"Option 1", "Option 2"}
                local Default = config.Default or config.Value or Options[1]
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                local Multi = config.Multi or false
                local Column = config.Column or GetSmallestColumn()

                local Selected = Multi and (type(Default) == "table" and Default or {Default}) or Default

                local DropdownFrame = CreateElement("Frame", {
                    Name = "Dropdown",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0,
                    ClipsDescendants = false,
                    ZIndex = 5
                })

                CreateElement("UICorner", {Parent = DropdownFrame, CornerRadius = UDim.new(0, 8)})

                local DropdownLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0, 70, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local DropdownButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 85, 0.5, -12),
                    Size = UDim2.new(1, -100, 0, 24),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = "  " .. (Multi and table.concat(Selected, ", ") or tostring(Selected)),
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                CreateElement("UICorner", {Parent = DropdownButton, CornerRadius = UDim.new(0, 6)})

                local Arrow = CreateElement("TextLabel", {
                    Name = "Arrow",
                    Parent = DropdownButton,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -6, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextMuted,
                    TextSize = 10,
                    Font = Enum.Font.Gotham
                })

                local DropdownList = CreateElement("Frame", {
                    Name = "List",
                    Parent = DropdownFrame,
                    Position = UDim2.new(0, 85, 1, 5),
                    Size = UDim2.new(1, -100, 0, 0),
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.05,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Visible = false,
                    ZIndex = 100
                })

                CreateElement("UICorner", {Parent = DropdownList, CornerRadius = UDim.new(0, 8)})

                CreateElement("UIListLayout", {
                    Parent = DropdownList,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 3)
                })

                CreateElement("UIPadding", {
                    Parent = DropdownList,
                    PaddingTop = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 6),
                    PaddingRight = UDim.new(0, 6)
                })

                local IsOpen = false

                DropdownButton.MouseButton1Click:Connect(function()
                    IsOpen = not IsOpen
                    DropdownList.Visible = IsOpen
                    if IsOpen then
                        local listHeight = math.min(#Options * 28 + 12, 200)
                        Tween(DropdownList, {Size = UDim2.new(1, -100, 0, listHeight)}, 0.2)
                        Tween(Arrow, {Rotation = 180}, 0.2)
                    else
                        Tween(DropdownList, {Size = UDim2.new(1, -100, 0, 0)}, 0.2)
                        Tween(Arrow, {Rotation = 0}, 0.2)
                        task.wait(0.2)
                        if not IsOpen then DropdownList.Visible = false end
                    end
                end)

                for _, option in ipairs(Options) do
                    local OptionButton = CreateElement("TextButton", {
                        Name = "Opt_" .. tostring(option),
                        Parent = DropdownList,
                        Size = UDim2.new(1, -8, 0, 24),
                        BackgroundColor3 = Theme.Tertiary,
                        BackgroundTransparency = 0.3,
                        BorderSizePixel = 0,
                        Text = "  " .. tostring(option),
                        TextColor3 = Theme.Text,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        TextTruncate = Enum.TextTruncate.AtEnd
                    })

                    CreateElement("UICorner", {Parent = OptionButton, CornerRadius = UDim.new(0, 5)})

                    OptionButton.MouseButton1Click:Connect(function()
                        if Multi then
                            local found = table.find(Selected, option)
                            if found then table.remove(Selected, found) else table.insert(Selected, option) end
                            DropdownButton.Text = "  " .. table.concat(Selected, ", ")
                        else
                            Selected = option
                            DropdownButton.Text = "  " .. tostring(option)
                            IsOpen = false
                            Tween(DropdownList, {Size = UDim2.new(1, -100, 0, 0)}, 0.2)
                            Tween(Arrow, {Rotation = 0}, 0.2)
                            task.wait(0.2)
                            DropdownList.Visible = false
                        end
                        if Flag then Window.Flags[Flag] = Selected end
                        pcall(Callback, Selected)
                    end)

                    OptionButton.MouseEnter:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.15)
                    end)

                    OptionButton.MouseLeave:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Tertiary}, 0.15)
                    end)
                end

                local function SetValue(value)
                    if Multi then
                        Selected = type(value) == "table" and value or {value}
                        DropdownButton.Text = "  " .. table.concat(Selected, ", ")
                    else
                        Selected = value
                        DropdownButton.Text = "  " .. tostring(value)
                    end
                    if Flag then Window.Flags[Flag] = Selected end
                    pcall(Callback, Selected)
                end

                if Flag then Window.Flags[Flag] = Selected end

                return {SetValue = SetValue, GetValue = function() return Selected end}
            end

            -- Button
            function Section:AddButton(config)
                config = config or {}
                local Name = config.Name or config.Title or "Button"
                local Callback = config.Callback or function() end
                local Color = config.Color or Theme.Accent
                local Column = config.Column or GetSmallestColumn()

                local Button = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Color,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false
                })

                CreateElement("UICorner", {Parent = Button, CornerRadius = UDim.new(0, 8)})

                Button.MouseButton1Click:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.AccentHover}, 0.1)
                    task.wait(0.1)
                    Tween(Button, {BackgroundColor3 = Color}, 0.1)
                    pcall(Callback)
                end)

                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.AccentHover}, 0.2)
                end)

                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Color}, 0.2)
                end)

                return Button
            end

            -- Input
            function Section:AddInput(config)
                config = config or {}
                local Name = config.Name or "Input"
                local Default = config.Default or config.Value or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                local Type = config.Type or "Input"
                local Column = config.Column or GetSmallestColumn()

                local InputFrame = CreateElement("Frame", {
                    Name = "Input",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, Type == "Textarea" and 80 or 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = InputFrame, CornerRadius = UDim.new(0, 8)})

                local InputLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = InputFrame,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 16),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local InputBox = CreateElement("TextBox", {
                    Name = "Box",
                    Parent = InputFrame,
                    Position = UDim2.new(0, 12, 0, Type == "Textarea" and 28 or 26),
                    Size = UDim2.new(1, -24, 0, Type == "Textarea" and 44 or 20),
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.2,
                    Text = Default,
                    PlaceholderText = Placeholder,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Type == "Textarea" and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
                    TextWrapped = Type == "Textarea",
                    MultiLine = Type == "Textarea"
                })

                CreateElement("UICorner", {Parent = InputBox, CornerRadius = UDim.new(0, 6)})
                CreateElement("UIPadding", {
                    Parent = InputBox,
                    PaddingLeft = UDim.new(0, 8),
                    PaddingTop = UDim.new(0, Type == "Textarea" and 6 or 0)
                })

                InputBox.FocusLost:Connect(function()
                    if Flag then Window.Flags[Flag] = InputBox.Text end
                    pcall(Callback, InputBox.Text)
                end)

                local function SetValue(value)
                    InputBox.Text = value
                    if Flag then Window.Flags[Flag] = value end
                    pcall(Callback, value)
                end

                if Flag then Window.Flags[Flag] = Default end

                return {SetValue = SetValue, GetValue = function() return InputBox.Text end}
            end

            -- Keybind
            function Section:AddKeybind(config)
                config = config or {}
                local Name = config.Name or "Keybind"
                local Default = config.Default or config.Value or "None"
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                local Column = config.Column or GetSmallestColumn()

                local CurrentKey = Default
                local Listening = false

                local KeybindFrame = CreateElement("Frame", {
                    Name = "Keybind",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0
                })

                CreateElement("UICorner", {Parent = KeybindFrame, CornerRadius = UDim.new(0, 8)})

                local KeybindLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = KeybindFrame,
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

                local KeybindButton = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = KeybindFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 70, 0, 26),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = tostring(CurrentKey),
                    TextColor3 = Theme.Accent,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false
                })

                CreateElement("UICorner", {Parent = KeybindButton, CornerRadius = UDim.new(0, 6)})

                KeybindButton.MouseButton1Click:Connect(function()
                    if Listening then return end
                    Listening = true
                    KeybindButton.Text = "..."

                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                        if gameProcessed then return end
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            CurrentKey = input.KeyCode.Name
                            KeybindButton.Text = CurrentKey
                            if Flag then Window.Flags[Flag] = CurrentKey end
                            pcall(Callback, CurrentKey)
                            Listening = false
                            connection:Disconnect()
                        end
                    end)
                end)

                local function SetValue(key)
                    CurrentKey = key
                    KeybindButton.Text = tostring(key)
                    if Flag then Window.Flags[Flag] = key end
                    pcall(Callback, key)
                end

                if Flag then Window.Flags[Flag] = CurrentKey end

                return {SetValue = SetValue, GetValue = function() return CurrentKey end}
            end

            -- Colorpicker
            function Section:AddColorpicker(config)
                config = config or {}
                local Name = config.Name or "Colorpicker"
                local Default = config.Default or Color3.fromRGB(255, 255, 255)
                local Callback = config.Callback or function() end
                local Flag = config.Flag
                local Column = config.Column or GetSmallestColumn()

                local ColorpickerFrame = CreateElement("Frame", {
                    Name = "Colorpicker",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0,
                    ClipsDescendants = false
                })

                CreateElement("UICorner", {Parent = ColorpickerFrame, CornerRadius = UDim.new(0, 8)})

                local ColorpickerLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ColorpickerFrame,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -70, 1, 0),
                    BackgroundTransparency = 1,
                    Text = Name,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local ColorPreview = CreateElement("TextButton", {
                    Name = "Preview",
                    Parent = ColorpickerFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 40, 0, 26),
                    BackgroundColor3 = Default,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })

                CreateElement("UICorner", {Parent = ColorPreview, CornerRadius = UDim.new(0, 6)})

                local ColorPickerOpen = false
                local CurrentColor = Default

                local PickerFrame = CreateElement("Frame", {
                    Name = "Picker",
                    Parent = ColorpickerFrame,
                    Position = UDim2.new(0, 0, 1, 5),
                    Size = UDim2.new(1, 0, 0, 150),
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.05,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 100
                })

                CreateElement("UICorner", {Parent = PickerFrame, CornerRadius = UDim.new(0, 10)})

                local Presets = {
                    Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 128, 0), Color3.fromRGB(255, 255, 0),
                    Color3.fromRGB(128, 255, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 255, 128),
                    Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 128, 255), Color3.fromRGB(0, 0, 255),
                    Color3.fromRGB(128, 0, 255), Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 0, 128),
                    Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 128, 128), Color3.fromRGB(0, 0, 0),
                }

                CreateElement("UIGridLayout", {
                    Parent = PickerFrame,
                    CellSize = UDim2.new(0, 30, 0, 30),
                    CellPadding = UDim2.new(0, 8, 0, 8),
                    StartCorner = Enum.StartCorner.TopLeft,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                })

                CreateElement("UIPadding", {Parent = PickerFrame, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)})

                for _, color in ipairs(Presets) do
                    local ColorBtn = CreateElement("TextButton", {
                        Parent = PickerFrame,
                        BackgroundColor3 = color,
                        BorderSizePixel = 0,
                        Text = "",
                        AutoButtonColor = false
                    })

                    CreateElement("UICorner", {Parent = ColorBtn, CornerRadius = UDim.new(0, 6)})

                    ColorBtn.MouseButton1Click:Connect(function()
                        CurrentColor = color
                        ColorPreview.BackgroundColor3 = color
                        if Flag then Window.Flags[Flag] = {R = color.R * 255, G = color.G * 255, B = color.B * 255} end
                        pcall(Callback, color)
                        ColorPickerOpen = false
                        PickerFrame.Visible = false
                    end)
                end

                ColorPreview.MouseButton1Click:Connect(function()
                    ColorPickerOpen = not ColorPickerOpen
                    PickerFrame.Visible = ColorPickerOpen
                end)

                local function SetValue(color)
                    CurrentColor = color
                    ColorPreview.BackgroundColor3 = color
                    if Flag then Window.Flags[Flag] = {R = color.R * 255, G = color.G * 255, B = color.B * 255} end
                    pcall(Callback, color)
                end

                if Flag then Window.Flags[Flag] = {R = Default.R * 255, G = Default.G * 255, B = Default.B * 255} end

                return {SetValue = SetValue, GetValue = function() return CurrentColor end}
            end

            -- Label
            function Section:AddLabel(config)
                config = config or {}
                local Text = config.Text or config.Name or "Label"
                local Column = config.Column or GetSmallestColumn()

                local Label = CreateElement("TextLabel", {
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Text = Text,
                    TextColor3 = Theme.TextDark,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    TextWrapped = true
                })

                return {SetText = function(text) Label.Text = text end}
            end

            -- Paragraph
            function Section:AddParagraph(config)
                config = config or {}
                local Title = config.Title or ""
                local Content = config.Content or config.Text or ""
                local Column = config.Column or GetSmallestColumn()

                local ParagraphFrame = CreateElement("Frame", {
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Theme.Tertiary,
                    BackgroundTransparency = 0.1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                CreateElement("UICorner", {Parent = ParagraphFrame, CornerRadius = UDim.new(0, 8)})

                CreateElement("UIPadding", {
                    Parent = ParagraphFrame,
                    PaddingTop = UDim.new(0, 12),
                    PaddingLeft = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 12),
                    PaddingBottom = UDim.new(0, 12)
                })

                local ParagraphTitle = CreateElement("TextLabel", {
                    Parent = ParagraphFrame,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = Title,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamBold,
                    TextWrapped = true
                })

                local ParagraphContent = CreateElement("TextLabel", {
                    Parent = ParagraphFrame,
                    Position = UDim2.new(0, 0, 0, 22),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Content,
                    TextColor3 = Theme.TextDark,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Font = Enum.Font.Gotham,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                return ParagraphFrame
            end

            -- Divider
            function Section:AddDivider(config)
                config = config or {}
                local Height = config.Height or 10
                local Column = config.Column or GetSmallestColumn()

                local Divider = CreateElement("Frame", {
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, Height),
                    BackgroundTransparency = 1
                })

                return Divider
            end

            return Section
        end

        return Page
    end

    -- Notification
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or config.Desc or ""
        local Duration = config.Duration or 5
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
            Position = UDim2.new(1, 20, 1, -100),
            Size = UDim2.new(0, 300, 0, 80),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0
        })

        CreateElement("UICorner", {Parent = Notification, CornerRadius = UDim.new(0, 10)})

        local AccentBar = CreateElement("Frame", {
            Name = "Accent",
            Parent = Notification,
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = TypeColors[Type] or Theme.Accent,
            BorderSizePixel = 0
        })

        CreateElement("UICorner", {Parent = AccentBar, CornerRadius = UDim.new(0, 10)})

        local NotifTitle = CreateElement("TextLabel", {
            Name = "Title",
            Parent = Notification,
            Position = UDim2.new(0, 15, 0, 10),
            Size = UDim2.new(1, -30, 0, 20),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold
        })

        local NotifContent = CreateElement("TextLabel", {
            Name = "Content",
            Parent = Notification,
            Position = UDim2.new(0, 15, 0, 32),
            Size = UDim2.new(1, -30, 1, -42),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Font = Enum.Font.Gotham,
            TextWrapped = true
        })

        Tween(Notification, {Position = UDim2.new(1, -320, 1, -100)}, 0.4, Enum.EasingStyle.Back)

        task.wait(Duration)

        Tween(Notification, {Position = UDim2.new(1, 20, 1, -100)}, 0.3)
        task.wait(0.3)
        Notification:Destroy()
    end

    -- Dialog
    function Window:Dialog(config)
        config = config or {}
        local Title = config.Title or "Dialog"
        local Content = config.Content or ""
        local Buttons = config.Buttons or {{Title = "OK", Callback = function() end}}

        local DialogFrame = CreateElement("Frame", {
            Name = "Dialog",
            Parent = ScreenGui,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            ZIndex = 1000
        })

        local DialogBox = CreateElement("Frame", {
            Name = "Box",
            Parent = DialogFrame,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 400, 0, 0),
            BackgroundColor3 = Theme.Background,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 1001
        })

        CreateElement("UICorner", {Parent = DialogBox, CornerRadius = UDim.new(0, 12)})

        CreateElement("UIPadding", {
            Parent = DialogBox,
            PaddingTop = UDim.new(0, 20),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20),
            PaddingBottom = UDim.new(0, 20)
        })

        local DialogTitle = CreateElement("TextLabel", {
            Parent = DialogBox,
            Size = UDim2.new(1, 0, 0, 25),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 18,
            Font = Enum.Font.GothamBold,
            ZIndex = 1002
        })

        local DialogContent = CreateElement("TextLabel", {
            Parent = DialogBox,
            Position = UDim2.new(0, 0, 0, 35),
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 1002
        })

        local ButtonsFrame = CreateElement("Frame", {
            Parent = DialogBox,
            Position = UDim2.new(0, 0, 0, 70),
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundTransparency = 1,
            ZIndex = 1002
        })

        CreateElement("UIListLayout", {
            Parent = ButtonsFrame,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 10)
        })

        for _, btnConfig in ipairs(Buttons) do
            local Btn = CreateElement("TextButton", {
                Parent = ButtonsFrame,
                Size = UDim2.new(0, 100, 0, 35),
                BackgroundColor3 = btnConfig.Color or Theme.Accent,
                Text = btnConfig.Title,
                TextColor3 = Theme.Text,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                AutoButtonColor = false,
                ZIndex = 1003
            })

            CreateElement("UICorner", {Parent = Btn, CornerRadius = UDim.new(0, 8)})

            Btn.MouseButton1Click:Connect(function()
                Tween(DialogFrame, {BackgroundTransparency = 1}, 0.2)
                Tween(DialogBox, {Size = UDim2.new(0, 400, 0, 0)}, 0.2)
                task.wait(0.2)
                DialogFrame:Destroy()
                if btnConfig.Callback then pcall(btnConfig.Callback) end
            end)
        end

        Tween(DialogBox, {Size = UDim2.new(0, 400, 0, 150)}, 0.3, Enum.EasingStyle.Back)
    end

    -- Save/Load Config
    function Window:SaveConfig(name)
        return Window.ConfigManager:SaveConfig(name, Window.Flags)
    end

    function Window:LoadConfig(name)
        local data = Window.ConfigManager:LoadConfig(name)
        if data then
            for flag, value in pairs(data) do
                Window.Flags[flag] = value
            end
        end
    end

    return Window
end

return Library
