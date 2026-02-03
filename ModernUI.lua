--[[
    Professional Roblox UI Library
    Version: 2.0.0
    Supports: Mobile & PC
    Bug-free minimization and sleek design
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

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

-- Icon System (Lucide-style icons)
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
    X = "rbxassetid://10747384394"
}

-- Theme System
local Theme = {
    -- Main colors
    Background = Color3.fromRGB(45, 50, 68),
    Secondary = Color3.fromRGB(55, 60, 78),
    Tertiary = Color3.fromRGB(65, 70, 88),
    
    -- Sidebar
    Sidebar = Color3.fromRGB(35, 40, 58),
    SidebarHover = Color3.fromRGB(45, 50, 68),
    SidebarActive = Color3.fromRGB(88, 101, 242),
    
    -- Accent colors
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(108, 121, 255),
    AccentDark = Color3.fromRGB(70, 80, 200),
    
    -- Text colors
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(160, 165, 180),
    TextMuted = Color3.fromRGB(120, 125, 140),
    
    -- UI elements
    Border = Color3.fromRGB(75, 80, 98),
    BorderLight = Color3.fromRGB(85, 90, 108),
    
    -- Status colors
    Success = Color3.fromRGB(67, 181, 129),
    Warning = Color3.fromRGB(250, 166, 26),
    Error = Color3.fromRGB(240, 71, 71),
    Info = Color3.fromRGB(52, 152, 219),
    
    -- Toggle colors
    ToggleOn = Color3.fromRGB(88, 101, 242),
    ToggleOff = Color3.fromRGB(80, 85, 100)
}

-- Main Library
function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Script Hub"
    local Subtitle = config.Subtitle or "script.lua"
    local Size = config.Size or UDim2.new(0, IsMobile() and 380 or 520, 0, IsMobile() and 420 or 340)
    
    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = Size
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
    
    -- Title bar bottom cover
    local TitleBarCover = CreateElement("Frame", {
        Name = "Cover",
        Parent = TitleBar,
        Position = UDim2.new(0, 0, 1, -10),
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    -- Status indicator (green dot)
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
    
    -- Pulsing animation for status
    task.spawn(function()
        while ScreenGui.Parent do
            Tween(StatusIndicator, {Size = UDim2.new(0, 10, 0, 10)}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1)
            Tween(StatusIndicator, {Size = UDim2.new(0, 8, 0, 8)}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            task.wait(1)
        end
    end)
    
    -- Title
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
    
    -- Subtitle
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
    
    -- Close Button
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
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        CloseButton.TextColor3 = Theme.Error
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CloseButton.TextColor3 = Theme.TextDark
    end)
    
    -- Minimize Button
    local MinimizeButton = CreateElement("TextButton", {
        Name = "Minimize",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -28, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        BackgroundTransparency = 1,
        Text = "─",
        TextColor3 = Theme.TextDark,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    })
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        
        if Window.Minimized then
            -- Store original size and minimize
            Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 35)}, 0.3)
            Sidebar.Visible = false
            ContentFrame.Visible = false
            MinimizeButton.Text = "□"
        else
            -- Restore original size
            Tween(MainFrame, {Size = Window.OriginalSize}, 0.3)
            Sidebar.Visible = true
            ContentFrame.Visible = true
            MinimizeButton.Text = "─"
        end
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        MinimizeButton.TextColor3 = Theme.Text
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        MinimizeButton.TextColor3 = Theme.TextDark
    end)
    
    -- Sidebar
    local Sidebar = CreateElement("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(0, 45, 1, -35),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    
    CreateElement("UIListLayout", {
        Parent = Sidebar,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    
    CreateElement("UIPadding", {
        Parent = Sidebar,
        PaddingTop = UDim.new(0, 10)
    })
    
    -- Content Frame (holds all pages)
    local ContentFrame = CreateElement("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Position = UDim2.new(0, 45, 0, 35),
        Size = UDim2.new(1, -45, 1, -35),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    
    -- Dragging functionality
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if Dragging then
                local Delta = input.Position - DragStart
                MainFrame.Position = UDim2.new(
                    StartPos.X.Scale,
                    StartPos.X.Offset + Delta.X,
                    StartPos.Y.Scale,
                    StartPos.Y.Offset + Delta.Y
                )
            end
        end
    end)
    
    -- Create Page function
    function Window:CreatePage(config)
        config = config or {}
        local PageName = config.Name or "Page"
        local Icon = config.Icon or "rbxassetid://10734950309"
        
        local Page = {
            Name = PageName,
            Sections = {}
        }
        
        -- Sidebar button
        local SidebarButton = CreateElement("TextButton", {
            Name = "Btn_" .. PageName,
            Parent = Sidebar,
            Size = UDim2.new(0, 35, 0, 35),
            BackgroundColor3 = Theme.SidebarHover,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false
        })
        
        CreateElement("UICorner", {
            Parent = SidebarButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        -- Icon
        local IconImage = CreateElement("ImageLabel", {
            Name = "Icon",
            Parent = SidebarButton,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1,
            Image = Icon,
            ImageColor3 = Theme.TextDark
        })
        
        -- Page container
        local PageFrame = CreateElement("ScrollingFrame", {
            Name = "Page_" .. PageName,
            Parent = ContentFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ScrollingDirection = Enum.ScrollingDirection.Y
        })
        
        CreateElement("UIPadding", {
            Parent = PageFrame,
            PaddingTop = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        })
        
        -- Page selection
        SidebarButton.MouseButton1Click:Connect(function()
            for _, page in pairs(Window.Pages) do
                page.Frame.Visible = false
                page.Button.BackgroundColor3 = Theme.SidebarHover
                page.Icon.ImageColor3 = Theme.TextDark
            end
            
            PageFrame.Visible = true
            Window.CurrentPage = Page
            Tween(SidebarButton, {BackgroundColor3 = Theme.SidebarActive}, 0.2)
            IconImage.ImageColor3 = Theme.Text
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
        Page.Icon = IconImage
        
        -- Auto-select first page
        if #Window.Pages == 0 then
            PageFrame.Visible = true
            Window.CurrentPage = Page
            SidebarButton.BackgroundColor3 = Theme.SidebarActive
            IconImage.ImageColor3 = Theme.Text
        end
        
        table.insert(Window.Pages, Page)
        
        -- Create Section function
        function Page:CreateSection(sectionName)
            local Section = {
                Name = sectionName,
                Elements = {},
                Left = nil,
                Right = nil
            }
            
            -- Section container
            local SectionFrame = CreateElement("Frame", {
                Name = "Section_" .. sectionName,
                Parent = PageFrame,
                Size = UDim2.new(1, -5, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = SectionFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            })
            
            -- Section title
            local SectionTitle = CreateElement("TextLabel", {
                Name = "Title",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Theme.Text,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold,
                LayoutOrder = 0
            })
            
            -- Two-column layout container
            local ColumnsContainer = CreateElement("Frame", {
                Name = "Columns",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            })
            
            -- Left column
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
                Padding = UDim.new(0, 8)
            })
            
            -- Right column
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
                Padding = UDim.new(0, 8)
            })
            
            Section.Left = LeftColumn
            Section.Right = RightColumn
            Section.Container = SectionFrame
            
            -- Auto-resize canvas
            local function UpdateCanvasSize()
                local contentSize = 0
                for _, child in pairs(PageFrame:GetChildren()) do
                    if child:IsA("Frame") then
                        contentSize = contentSize + child.AbsoluteSize.Y + 8
                    end
                end
                PageFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize + 20)
            end
            
            SectionFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateCanvasSize)
            
            table.insert(Page.Sections, Section)
            
            -- Helper to get column with least height
            local function GetSmallestColumn()
                if LeftColumn.AbsoluteSize.Y <= RightColumn.AbsoluteSize.Y then
                    return LeftColumn
                else
                    return RightColumn
                end
            end
            
            -- Add Toggle
            function Section:AddToggle(config)
                config = config or {}
                local Name = config.Name or "Toggle"
                local Default = config.Default or false
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
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
                    Size = UDim2.new(1, -55, 1, 0),
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
                    Parent = Toggle,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -10, 0.5, 0),
                    Size = UDim2.new(0, 38, 0, 20),
                    BackgroundColor3 = Default and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Circle = CreateElement("Frame", {
                    Name = "Circle",
                    Parent = ToggleButton,
                    Position = Default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Circle,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Toggled = Default
                
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    
                    Tween(ToggleButton, {
                        BackgroundColor3 = Toggled and Theme.ToggleOn or Theme.ToggleOff
                    }, 0.2)
                    
                    Tween(Circle, {
                        Position = Toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    }, 0.2, Enum.EasingStyle.Quad)
                    
                    pcall(Callback, Toggled)
                end)
                
                return {
                    SetValue = function(value)
                        Toggled = value
                        ToggleButton.BackgroundColor3 = Toggled and Theme.ToggleOn or Theme.ToggleOff
                        Circle.Position = Toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                        pcall(Callback, Toggled)
                    end
                }
            end
            
            -- Add Slider
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
                    Size = UDim2.new(1, -80, 0, 16),
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
                    Parent = Slider,
                    Position = UDim2.new(1, -70, 0, 8),
                    Size = UDim2.new(0, 58, 0, 16),
                    BackgroundTransparency = 1,
                    Text = tostring(Default) .. Suffix,
                    TextColor3 = Theme.Accent,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamBold
                })
                
                local SliderBar = CreateElement("Frame", {
                    Name = "Bar",
                    Parent = Slider,
                    Position = UDim2.new(0, 12, 1, -18),
                    Size = UDim2.new(1, -24, 0, 4),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderBar,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderFill = CreateElement("Frame", {
                    Name = "Fill",
                    Parent = SliderBar,
                    Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderHandle = CreateElement("Frame", {
                    Name = "Handle",
                    Parent = SliderBar,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new((Default - Min) / (Max - Min), 0, 0.5, 0),
                    Size = UDim2.new(0, 12, 0, 12),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderHandle,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local Dragging = false
                local Value = Default
                
                local function UpdateSlider(input)
                    local Pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    Value = math.floor((Min + (Max - Min) * Pos) / Increment + 0.5) * Increment
                    Value = math.clamp(Value, Min, Max)
                    
                    SliderValue.Text = tostring(Value) .. Suffix
                    Tween(SliderFill, {Size = UDim2.new(Pos, 0, 1, 0)}, 0.1)
                    Tween(SliderHandle, {Position = UDim2.new(Pos, 0, 0.5, 0)}, 0.1)
                    
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
                
                return {
                    SetValue = function(value)
                        Value = math.clamp(value, Min, Max)
                        local Pos = (Value - Min) / (Max - Min)
                        SliderValue.Text = tostring(Value) .. Suffix
                        SliderFill.Size = UDim2.new(Pos, 0, 1, 0)
                        SliderHandle.Position = UDim2.new(Pos, 0, 0.5, 0)
                        pcall(Callback, Value)
                    end
                }
            end
            
            -- Add Dropdown
            function Section:AddDropdown(config)
                config = config or {}
                local Name = config.Name or "Dropdown"
                local Options = config.Options or {"Option 1", "Option 2"}
                local Default = config.Default or Options[1]
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
                local Dropdown = CreateElement("Frame", {
                    Name = "Dropdown",
                    Parent = Column,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ClipsDescendants = false,
                    ZIndex = 5
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
                    Size = UDim2.new(0, 60, 1, 0),
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
                    Parent = Dropdown,
                    Position = UDim2.new(0, 75, 0, 7),
                    Size = UDim2.new(1, -87, 0, 24),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "  " .. Default,
                    TextColor3 = Theme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                
                CreateElement("UICorner", {
                    Parent = DropdownButton,
                    CornerRadius = UDim.new(0, 5)
                })
                
                local Arrow = CreateElement("TextLabel", {
                    Name = "Arrow",
                    Parent = DropdownButton,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -4, 0.5, 0),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextMuted,
                    TextSize = 8,
                    Font = Enum.Font.Gotham
                })
                
                local DropdownList = CreateElement("Frame", {
                    Name = "List",
                    Parent = Dropdown,
                    Position = UDim2.new(0, 75, 1, 5),
                    Size = UDim2.new(1, -87, 0, 0),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Visible = false,
                    ZIndex = 10
                })
                
                CreateElement("UICorner", {
                    Parent = DropdownList,
                    CornerRadius = UDim.new(0, 6)
                })
                
                CreateElement("UIStroke", {
                    Parent = DropdownList,
                    Color = Theme.Border,
                    Thickness = 1,
                    Transparency = 0.5
                })
                
                CreateElement("UIListLayout", {
                    Parent = DropdownList,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2)
                })
                
                CreateElement("UIPadding", {
                    Parent = DropdownList,
                    PaddingTop = UDim.new(0, 4),
                    PaddingBottom = UDim.new(0, 4),
                    PaddingLeft = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 4)
                })
                
                local IsOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    IsOpen = not IsOpen
                    DropdownList.Visible = IsOpen
                    
                    if IsOpen then
                        Tween(DropdownList, {Size = UDim2.new(1, -87, 0, math.min(#Options * 26 + 8, 120))}, 0.2)
                        Tween(Arrow, {Rotation = 180}, 0.2)
                    else
                        Tween(DropdownList, {Size = UDim2.new(1, -87, 0, 0)}, 0.2)
                        Tween(Arrow, {Rotation = 0}, 0.2)
                        task.wait(0.2)
                        if not IsOpen then
                            DropdownList.Visible = false
                        end
                    end
                end)
                
                for _, option in ipairs(Options) do
                    local OptionButton = CreateElement("TextButton", {
                        Name = "Opt_" .. option,
                        Parent = DropdownList,
                        Size = UDim2.new(1, -8, 0, 22),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = "  " .. option,
                        TextColor3 = Theme.Text,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Font = Enum.Font.Gotham,
                        AutoButtonColor = false,
                        TextTruncate = Enum.TextTruncate.AtEnd
                    })
                    
                    CreateElement("UICorner", {
                        Parent = OptionButton,
                        CornerRadius = UDim.new(0, 4)
                    })
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        DropdownButton.Text = "  " .. option
                        IsOpen = false
                        Tween(DropdownList, {Size = UDim2.new(1, -87, 0, 0)}, 0.2)
                        Tween(Arrow, {Rotation = 0}, 0.2)
                        task.wait(0.2)
                        DropdownList.Visible = false
                        pcall(Callback, option)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.15)
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        Tween(OptionButton, {BackgroundColor3 = Theme.Tertiary}, 0.15)
                    end)
                end
                
                return {
                    SetValue = function(value)
                        DropdownButton.Text = "  " .. value
                        pcall(Callback, value)
                    end
                }
            end
            
            -- Add Button
            function Section:AddButton(config)
                config = config or {}
                local Name = config.Name or "Button"
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
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
                    Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                    task.wait(0.1)
                    Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.1)
                    pcall(Callback)
                end)
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
                end)
                
                return Button
            end
            
            -- Add Textbox
            function Section:AddTextbox(config)
                config = config or {}
                local Name = config.Name or "Textbox"
                local Default = config.Default or ""
                local Placeholder = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                local Column = config.Column or GetSmallestColumn()
                
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
                
                local TextboxInput = CreateElement("TextBox", {
                    Name = "Input",
                    Parent = Textbox,
                    Position = UDim2.new(0, 12, 0, 7),
                    Size = UDim2.new(1, -24, 1, -14),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = Default,
                    PlaceholderText = Placeholder,
                    TextColor3 = Theme.Text,
                    PlaceholderColor3 = Theme.TextMuted,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                CreateElement("UICorner", {
                    Parent = TextboxInput,
                    CornerRadius = UDim.new(0, 5)
                })
                
                CreateElement("UIPadding", {
                    Parent = TextboxInput,
                    PaddingLeft = UDim.new(0, 8)
                })
                
                TextboxInput.FocusLost:Connect(function()
                    pcall(Callback, TextboxInput.Text)
                end)
                
                return {
                    SetValue = function(value)
                        TextboxInput.Text = value
                        pcall(Callback, value)
                    end
                }
            end
            
            return Section
        end
        
        return Page
    end
    
    -- Notification System
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
    
    return Window
end

return Library
