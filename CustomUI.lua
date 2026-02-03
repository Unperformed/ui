--[[
    Custom UI Library for Roblox
    Version: 1.0.0
    Supports: Mobile & PC
    
    Usage:
    local Library = loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()
    local Window = Library:CreateWindow({
        Title = "Your Script Hub",
        Theme = "Dark"
    })
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

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

-- Theme System
local Themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 35),
        Tertiary = Color3.fromRGB(40, 40, 45),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(108, 121, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 185),
        Border = Color3.fromRGB(50, 50, 55),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 250),
        Secondary = Color3.fromRGB(255, 255, 255),
        Tertiary = Color3.fromRGB(235, 235, 240),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentHover = Color3.fromRGB(108, 121, 255),
        Text = Color3.fromRGB(20, 20, 25),
        TextDark = Color3.fromRGB(100, 100, 105),
        Border = Color3.fromRGB(220, 220, 225),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71)
    }
}

-- Main Library Functions
function Library:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Script Hub"
    local Theme = Themes[config.Theme] or Themes.Dark
    local Size = config.Size or UDim2.new(0, IsMobile() and 350 or 550, 0, IsMobile() and 450 or 600)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Theme = Theme
    }
    
    -- Create ScreenGui
    local ScreenGui = CreateElement("ScreenGui", {
        Name = "CustomUILib_" .. math.random(1000, 9999),
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })
    
    -- Main Frame
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = Size,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = false
    })
    
    CreateElement("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 12)
    })
    
    CreateElement("UIStroke", {
        Parent = MainFrame,
        Color = Theme.Border,
        Thickness = 1,
        Transparency = 0.5
    })
    
    -- Drop Shadow
    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 30, 1, 30),
        BackgroundTransparency = 1,
        Image = "rbxassetid://297694300",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        ZIndex = 0
    })
    
    -- Title Bar
    local TitleBar = CreateElement("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = TitleBar,
        CornerRadius = UDim.new(0, 12)
    })
    
    local TitleLabel = CreateElement("TextLabel", {
        Name = "Title",
        Parent = TitleBar,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold
    })
    
    -- Close Button
    local CloseButton = CreateElement("TextButton", {
        Name = "CloseButton",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Theme.Text,
        TextSize = 20,
        Font = Enum.Font.GothamBold
    })
    
    CreateElement("UICorner", {
        Parent = CloseButton,
        CornerRadius = UDim.new(0, 8)
    })
    
    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Theme.Error}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
    end)
    
    -- Minimize Button
    local MinimizeButton = CreateElement("TextButton", {
        Name = "MinimizeButton",
        Parent = TitleBar,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -45, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "−",
        TextColor3 = Theme.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold
    })
    
    CreateElement("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 8)
    })
    
    local Minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        if Minimized then
            Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 45)}, 0.3)
        else
            Tween(MainFrame, {Size = Size}, 0.3)
        end
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.AccentHover}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
    end)
    
    -- Tab Container
    local TabContainer = CreateElement("Frame", {
        Name = "TabContainer",
        Parent = MainFrame,
        Position = UDim2.new(0, 10, 0, 55),
        Size = UDim2.new(0, IsMobile() and 50 or 140, 1, -65),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = TabContainer,
        CornerRadius = UDim.new(0, 10)
    })
    
    CreateElement("UIListLayout", {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    
    CreateElement("UIPadding", {
        Parent = TabContainer,
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5)
    })
    
    -- Content Container
    local ContentContainer = CreateElement("Frame", {
        Name = "ContentContainer",
        Parent = MainFrame,
        Position = UDim2.new(0, IsMobile() and 70 or 160, 0, 55),
        Size = UDim2.new(1, IsMobile() and -80 or -170, 1, -65),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    
    -- Dragging
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
        end
    end)
    
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(
                StartPos.X.Scale,
                StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale,
                StartPos.Y.Offset + Delta.Y
            )
        end
    end)
    
    -- Create Tab Function
    function Window:CreateTab(tabName)
        local Tab = {
            Name = tabName,
            Elements = {}
        }
        
        -- Tab Button
        local TabButton = CreateElement("TextButton", {
            Name = "TabButton_" .. tabName,
            Parent = TabContainer,
            Size = UDim2.new(1, -10, 0, IsMobile() and 40 or 35),
            BackgroundColor3 = Theme.Tertiary,
            BorderSizePixel = 0,
            Text = IsMobile() and tabName:sub(1, 1) or tabName,
            TextColor3 = Theme.TextDark,
            TextSize = IsMobile() and 16 or 14,
            Font = Enum.Font.GothamMedium,
            AutoButtonColor = false
        })
        
        CreateElement("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        -- Tab Content
        local TabContent = CreateElement("ScrollingFrame", {
            Name = "TabContent_" .. tabName,
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        })
        
        CreateElement("UIListLayout", {
            Parent = TabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        
        CreateElement("UIPadding", {
            Parent = TabContent,
            PaddingTop = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 5),
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 10)
        })
        
        -- Auto-resize canvas
        TabContent:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 10)
        end)
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Button, {BackgroundColor3 = Theme.Tertiary, TextColor3 = Theme.TextDark}, 0.2)
            end
            
            TabContent.Visible = true
            Window.CurrentTab = Tab
            Tween(TabButton, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text}, 0.2)
        end)
        
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(TabButton, {BackgroundColor3 = Theme.Border}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(TabButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
            end
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        
        -- Auto-select first tab
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            Window.CurrentTab = Tab
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Tab Element Functions
        function Tab:AddButton(config)
            config = config or {}
            local Name = config.Name or "Button"
            local Callback = config.Callback or function() end
            
            local Button = CreateElement("TextButton", {
                Name = "Button",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 40),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false
            })
            
            CreateElement("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Button,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local ButtonLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Button,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -30, 1, 0),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham
            })
            
            Button.MouseButton1Click:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                task.wait(0.1)
                Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.1)
                Callback()
            end)
            
            Button.MouseEnter:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.2)
            end)
            
            Button.MouseLeave:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end)
            
            return Button
        end
        
        function Tab:AddToggle(config)
            config = config or {}
            local Name = config.Name or "Toggle"
            local Default = config.Default or false
            local Callback = config.Callback or function() end
            
            local Toggle = CreateElement("Frame", {
                Name = "Toggle",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 40),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = Toggle,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Toggle,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local ToggleLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Toggle,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -70, 1, 0),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham
            })
            
            local ToggleButton = CreateElement("TextButton", {
                Name = "ToggleButton",
                Parent = Toggle,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -15, 0.5, 0),
                Size = UDim2.new(0, 45, 0, 24),
                BackgroundColor3 = Default and Theme.Success or Theme.Border,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false
            })
            
            CreateElement("UICorner", {
                Parent = ToggleButton,
                CornerRadius = UDim.new(1, 0)
            })
            
            local ToggleIndicator = CreateElement("Frame", {
                Name = "Indicator",
                Parent = ToggleButton,
                Position = Default and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                Size = UDim2.new(0, 20, 0, 20),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Theme.Text,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = ToggleIndicator,
                CornerRadius = UDim.new(1, 0)
            })
            
            local Toggled = Default
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                
                Tween(ToggleButton, {
                    BackgroundColor3 = Toggled and Theme.Success or Theme.Border
                }, 0.2)
                
                Tween(ToggleIndicator, {
                    Position = Toggled and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                }, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                
                Callback(Toggled)
            end)
            
            return {
                SetValue = function(value)
                    Toggled = value
                    ToggleButton.BackgroundColor3 = Toggled and Theme.Success or Theme.Border
                    ToggleIndicator.Position = Toggled and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    Callback(Toggled)
                end
            }
        end
        
        function Tab:AddSlider(config)
            config = config or {}
            local Name = config.Name or "Slider"
            local Min = config.Min or 0
            local Max = config.Max or 100
            local Default = config.Default or Min
            local Increment = config.Increment or 1
            local Callback = config.Callback or function() end
            
            local Slider = CreateElement("Frame", {
                Name = "Slider",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 55),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = Slider,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Slider,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local SliderLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Slider,
                Position = UDim2.new(0, 15, 0, 5),
                Size = UDim2.new(1, -30, 0, 20),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham
            })
            
            local SliderValue = CreateElement("TextLabel", {
                Name = "Value",
                Parent = Slider,
                Position = UDim2.new(0, 15, 0, 5),
                Size = UDim2.new(1, -30, 0, 20),
                BackgroundTransparency = 1,
                Text = tostring(Default),
                TextColor3 = Theme.Accent,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right,
                Font = Enum.Font.GothamBold
            })
            
            local SliderBar = CreateElement("Frame", {
                Name = "Bar",
                Parent = Slider,
                Position = UDim2.new(0, 15, 0, 32),
                Size = UDim2.new(1, -30, 0, 6),
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
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundColor3 = Theme.Text,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = SliderHandle,
                CornerRadius = UDim.new(1, 0)
            })
            
            CreateElement("UIStroke", {
                Parent = SliderHandle,
                Color = Theme.Accent,
                Thickness = 2
            })
            
            local Dragging = false
            local Value = Default
            
            local function UpdateSlider(input)
                local Position = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                Value = math.floor((Min + (Max - Min) * Position) / Increment + 0.5) * Increment
                Value = math.clamp(Value, Min, Max)
                
                SliderValue.Text = tostring(Value)
                Tween(SliderFill, {Size = UDim2.new(Position, 0, 1, 0)}, 0.1)
                Tween(SliderHandle, {Position = UDim2.new(Position, 0, 0.5, 0)}, 0.1)
                
                Callback(Value)
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
                    local Position = (Value - Min) / (Max - Min)
                    SliderValue.Text = tostring(Value)
                    SliderFill.Size = UDim2.new(Position, 0, 1, 0)
                    SliderHandle.Position = UDim2.new(Position, 0, 0.5, 0)
                    Callback(Value)
                end
            }
        end
        
        function Tab:AddDropdown(config)
            config = config or {}
            local Name = config.Name or "Dropdown"
            local Options = config.Options or {"Option 1", "Option 2", "Option 3"}
            local Default = config.Default or Options[1]
            local Callback = config.Callback or function() end
            
            local Dropdown = CreateElement("Frame", {
                Name = "Dropdown",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 40),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                ClipsDescendants = false
            })
            
            CreateElement("UICorner", {
                Parent = Dropdown,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Dropdown,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local DropdownLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Dropdown,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -70, 1, 0),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham
            })
            
            local DropdownButton = CreateElement("TextButton", {
                Name = "Button",
                Parent = Dropdown,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -15, 0.5, 0),
                Size = UDim2.new(0, 120, 1, -10),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Text = Default,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                AutoButtonColor = false
            })
            
            CreateElement("UICorner", {
                Parent = DropdownButton,
                CornerRadius = UDim.new(0, 6)
            })
            
            local DropdownIcon = CreateElement("TextLabel", {
                Name = "Icon",
                Parent = DropdownButton,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -5, 0.5, 0),
                Size = UDim2.new(0, 20, 0, 20),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Theme.TextDark,
                TextSize = 10,
                Font = Enum.Font.Gotham
            })
            
            local DropdownList = CreateElement("Frame", {
                Name = "List",
                Parent = Dropdown,
                Position = UDim2.new(0, 0, 1, 5),
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Visible = false,
                ZIndex = 10
            })
            
            CreateElement("UICorner", {
                Parent = DropdownList,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = DropdownList,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            CreateElement("UIListLayout", {
                Parent = DropdownList,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2)
            })
            
            CreateElement("UIPadding", {
                Parent = DropdownList,
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 5),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5)
            })
            
            local IsOpen = false
            
            DropdownButton.MouseButton1Click:Connect(function()
                IsOpen = not IsOpen
                DropdownList.Visible = IsOpen
                
                if IsOpen then
                    Tween(DropdownList, {Size = UDim2.new(1, 0, 0, #Options * 32 + 10)}, 0.2)
                    Tween(DropdownIcon, {Rotation = 180}, 0.2)
                else
                    Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    Tween(DropdownIcon, {Rotation = 0}, 0.2)
                    task.wait(0.2)
                    if not IsOpen then
                        DropdownList.Visible = false
                    end
                end
            end)
            
            for _, option in ipairs(Options) do
                local OptionButton = CreateElement("TextButton", {
                    Name = "Option_" .. option,
                    Parent = DropdownList,
                    Size = UDim2.new(1, -10, 0, 28),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = option,
                    TextColor3 = Theme.Text,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false
                })
                
                CreateElement("UICorner", {
                    Parent = OptionButton,
                    CornerRadius = UDim.new(0, 6)
                })
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = option
                    IsOpen = false
                    Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    Tween(DropdownIcon, {Rotation = 0}, 0.2)
                    task.wait(0.2)
                    DropdownList.Visible = false
                    Callback(option)
                end)
                
                OptionButton.MouseEnter:Connect(function()
                    Tween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.2)
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    Tween(OptionButton, {BackgroundColor3 = Theme.Tertiary}, 0.2)
                end)
            end
            
            return {
                SetValue = function(value)
                    DropdownButton.Text = value
                    Callback(value)
                end
            }
        end
        
        function Tab:AddTextbox(config)
            config = config or {}
            local Name = config.Name or "Textbox"
            local Default = config.Default or ""
            local Placeholder = config.Placeholder or "Enter text..."
            local Callback = config.Callback or function() end
            
            local Textbox = CreateElement("Frame", {
                Name = "Textbox",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 40),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = Textbox,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Textbox,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local TextboxLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Textbox,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(0, 100, 1, 0),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham
            })
            
            local TextboxInput = CreateElement("TextBox", {
                Name = "Input",
                Parent = Textbox,
                Position = UDim2.new(0, 120, 0, 5),
                Size = UDim2.new(1, -135, 1, -10),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Text = Default,
                PlaceholderText = Placeholder,
                TextColor3 = Theme.Text,
                PlaceholderColor3 = Theme.TextDark,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                ClearTextOnFocus = false
            })
            
            CreateElement("UICorner", {
                Parent = TextboxInput,
                CornerRadius = UDim.new(0, 6)
            })
            
            TextboxInput.FocusLost:Connect(function()
                Callback(TextboxInput.Text)
            end)
            
            return {
                SetValue = function(value)
                    TextboxInput.Text = value
                    Callback(value)
                end
            }
        end
        
        function Tab:AddLabel(text)
            local Label = CreateElement("Frame", {
                Name = "Label",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 35),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = Label,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateElement("UIStroke", {
                Parent = Label,
                Color = Theme.Border,
                Thickness = 1,
                Transparency = 0.7
            })
            
            local LabelText = CreateElement("TextLabel", {
                Name = "Text",
                Parent = Label,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -30, 1, 0),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextWrapped = true
            })
            
            return {
                SetText = function(newText)
                    LabelText.Text = newText
                end
            }
        end
        
        function Tab:AddSection(name)
            local Section = CreateElement("Frame", {
                Name = "Section",
                Parent = TabContent,
                Size = UDim2.new(1, -5, 0, 30),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })
            
            local SectionLabel = CreateElement("TextLabel", {
                Name = "Label",
                Parent = Section,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = Theme.Accent,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamBold
            })
            
            local Divider = CreateElement("Frame", {
                Name = "Divider",
                Parent = Section,
                Position = UDim2.new(0, 0, 1, -2),
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0
            })
            
            CreateElement("UICorner", {
                Parent = Divider,
                CornerRadius = UDim.new(1, 0)
            })
        end
        
        return Tab
    end
    
    -- Notification System
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or ""
        local Duration = config.Duration or 3
        local Type = config.Type or "Info" -- Info, Success, Warning, Error
        
        local TypeColors = {
            Info = Theme.Accent,
            Success = Theme.Success,
            Warning = Theme.Warning,
            Error = Theme.Error
        }
        
        local NotificationFrame = CreateElement("Frame", {
            Name = "Notification",
            Parent = ScreenGui,
            Position = UDim2.new(1, -320, 1, 100),
            Size = UDim2.new(0, 300, 0, 80),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = NotificationFrame,
            CornerRadius = UDim.new(0, 10)
        })
        
        CreateElement("UIStroke", {
            Parent = NotificationFrame,
            Color = TypeColors[Type],
            Thickness = 2
        })
        
        local NotificationTitle = CreateElement("TextLabel", {
            Name = "Title",
            Parent = NotificationFrame,
            Position = UDim2.new(0, 15, 0, 10),
            Size = UDim2.new(1, -30, 0, 20),
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold
        })
        
        local NotificationContent = CreateElement("TextLabel", {
            Name = "Content",
            Parent = NotificationFrame,
            Position = UDim2.new(0, 15, 0, 35),
            Size = UDim2.new(1, -30, 1, -45),
            BackgroundTransparency = 1,
            Text = Content,
            TextColor3 = Theme.TextDark,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Font = Enum.Font.Gotham,
            TextWrapped = true
        })
        
        Tween(NotificationFrame, {Position = UDim2.new(1, -320, 1, -100)}, 0.5, Enum.EasingStyle.Back)
        
        task.wait(Duration)
        
        Tween(NotificationFrame, {Position = UDim2.new(1, -320, 1, 100)}, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.wait(0.3)
        NotificationFrame:Destroy()
    end
    
    return Window
end

return Library
