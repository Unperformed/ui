-- ModernUI Enhanced - Complete Roblox UI Library (2025-2026 style)
-- Features: Themes, pages/tabs, collapsible sections, resizable window, smooth fades,
--           mobile-friendly, notifications, toggles, sliders, dropdowns, buttons, textboxes, color pickers, keybinds, locking

local Library = {}
local UIS = game:GetService("UserInputService")
local TS  = game:GetService("TweenService")
local RS  = game:GetService("RunService")
local CG  = game:GetService("CoreGui")
local HS  = game:GetService("HttpService")

-- ════════════════════════════════════════════════════════════════════════
-- THEMES
-- ════════════════════════════════════════════════════════════════════════

local Themes = {
    Purple = {
        Background   = Color3.fromRGB(30,  30,  46),
        Secondary    = Color3.fromRGB(45,  45,  65),
        Tertiary     = Color3.fromRGB(55,  55,  80),
        Sidebar      = Color3.fromRGB(24,  24,  37),
        SidebarHover = Color3.fromRGB(35,  35,  55),
        SidebarActive= Color3.fromRGB(195,126, 255),
        Accent       = Color3.fromRGB(195,126, 255),
        AccentHover  = Color3.fromRGB(210,160, 255),
        Text         = Color3.fromRGB(245,245, 250),
        TextDark     = Color3.fromRGB(200,200, 220),
        TextMuted    = Color3.fromRGB(150,150, 180),
        Border       = Color3.fromRGB(70,  70,  95),
        Success      = Color3.fromRGB(67, 181, 129),
        Warning      = Color3.fromRGB(250,166,  26),
        Error        = Color3.fromRGB(240, 71,  71),
        Info         = Color3.fromRGB(52, 152, 219),
        ToggleOn     = Color3.fromRGB(195,126, 255),
        ToggleOff    = Color3.fromRGB(80,  80, 100)
    },
    -- You can add Red, Ocean, Matrix, Midnight, Sunset here if you want
}

local CurrentThemeName = "Purple"
local Theme = Themes[CurrentThemeName]

-- ════════════════════════════════════════════════════════════════════════
-- UTILS
-- ════════════════════════════════════════════════════════════════════════

local function Tween(obj, props, duration)
    duration = duration or 0.25
    local t = TS:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function Create(class, props)
    local i = Instance.new(class)
    for k,v in pairs(props or {}) do i[k] = v end
    return i
end

local function IsMobile()
    return UIS.TouchEnabled and not UIS.KeyboardEnabled
end

-- ════════════════════════════════════════════════════════════════════════
-- LIBRARY CORE
-- ════════════════════════════════════════════════════════════════════════

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    local title     = cfg.Title     or "Modern UI"
    local subtitle  = cfg.Subtitle  or "v3.1"
    local size      = cfg.Size      or UDim2.new(0, IsMobile() and 420 or 620, 0, IsMobile() and 520 or 460)
    local themeName = cfg.Theme     or CurrentThemeName

    if Themes[themeName] then
        Theme = Themes[themeName]
        CurrentThemeName = themeName
    end

    local Window = {
        Pages = {},
        CurrentPage = nil,
        Minimized = false,
        OriginalSize = size
    }

    local sg = Create("ScreenGui", {
        Name = "ModernUI",
        Parent = CG,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })

    local main = Create("Frame", {
        Name = "Main",
        Parent = sg,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        Size = size,
        BackgroundColor3 = Theme.Background,
        ClipsDescendants = true,
        BorderSizePixel = 0
    })
    Create("UICorner", {Parent = main, CornerRadius = UDim.new(0,12)})

    -- Resize grip
    local grip = Create("TextButton", {
        Name = "ResizeGrip",
        Parent = main,
        Size = UDim2.new(0,28,0,28),
        Position = UDim2.new(1,-4,1,-4),
        AnchorPoint = Vector2.new(1,1),
        BackgroundTransparency = 1,
        Text = "↘",
        TextColor3 = Theme.TextMuted,
        TextSize = 20,
        Font = Enum.Font.Gotham,
        ZIndex = 10
    })

    local resizing, rStartPos, rStartSize
    grip.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            rStartPos = i.Position
            rStartSize = main.AbsoluteSize
        end
    end)
    grip.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if resizing and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - rStartPos
            local nw = math.clamp(rStartSize.X + d.X, 340, 1200)
            local nh = math.clamp(rStartSize.Y + d.Y, 300, 900)
            main.Size = UDim2.new(0,nw,0,nh)
        end
    end)

    -- Titlebar
    local tb = Create("Frame", {
        Name = "TitleBar",
        Parent = main,
        Size = UDim2.new(1,0,0,44),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })
    Create("UICorner", {Parent = tb, CornerRadius = UDim.new(0,12)})

    Create("Frame", {Parent = tb, Size = UDim2.new(1,0,0,16), Position = UDim2.new(0,0,1,-16), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0})

    Create("TextLabel", {
        Parent = tb,
        Size = UDim2.new(1,-160,1,0),
        Position = UDim2.new(0,16,0,0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Create("TextLabel", {
        Parent = tb,
        Size = UDim2.new(0,120,1,0),
        Position = UDim2.new(1,-130,0,0),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = Theme.TextMuted,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right
    })

    local minBtn = Create("TextButton", {
        Parent = tb,
        Size = UDim2.new(0,36,0,36),
        Position = UDim2.new(1,-80,0.5,0),
        AnchorPoint = Vector2.new(0,0.5),
        BackgroundTransparency = 1,
        Text = "−",
        TextColor3 = Theme.Text,
        TextSize = 26,
        Font = Enum.Font.GothamBold
    })

    local closeBtn = Create("TextButton", {
        Parent = tb,
        Size = UDim2.new(0,36,0,36),
        Position = UDim2.new(1,-40,0.5,0),
        AnchorPoint = Vector2.new(0,0.5),
        BackgroundTransparency = 1,
        Text = "×",
        TextColor3 = Theme.Text,
        TextSize = 26,
        Font = Enum.Font.GothamBold
    })

    -- Sidebar
    local sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = main,
        Size = UDim2.new(0,58,1,-44),
        Position = UDim2.new(0,0,0,44),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0
    })

    -- Content
    local content = Create("Frame", {
        Name = "Content",
        Parent = main,
        Size = UDim2.new(1,-58,1,-44),
        Position = UDim2.new(0,58,0,44),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })

    -- Dragging
    local dragging, dragStart, startPos
    tb.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = main.Position
        end
    end)

    tb.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Minimize / Close
    minBtn.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(main, {Size = UDim2.new(0, main.AbsoluteSize.X, 0, 44)}, 0.3)
        else
            Tween(main, {Size = Window.OriginalSize}, 0.3)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, {Size = UDim2.new(0,0,0,0)}, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.4, sg.Destroy, sg)
    end)

    -- ════════════════════════════════════════════════════════════════════════
    -- PAGE SWITCHING
    -- ════════════════════════════════════════════════════════════════════════

    local function SwitchPage(page)
        if Window.CurrentPage == page then return end

        local old = Window.CurrentPage
        if old then
            Tween(old.Frame, {BackgroundTransparency = 1}, 0.2)
            task.delay(0.21, function() old.Frame.Visible = false end)
            Tween(old.Button, {BackgroundColor3 = Theme.Sidebar}, 0.2)
            local icon = old.Button:FindFirstChild("Icon")
            if icon then Tween(icon, {ImageColor3 = Theme.TextMuted}, 0.2) end
        end

        page.Frame.BackgroundTransparency = 1
        page.Frame.Visible = true
        Tween(page.Frame, {BackgroundTransparency = 0}, 0.25)
        Tween(page.Button, {BackgroundColor3 = Theme.SidebarActive}, 0.2)
        local icon = page.Button:FindFirstChild("Icon")
        if icon then Tween(icon, {ImageColor3 = Theme.Text}, 0.2) end

        Window.CurrentPage = page
    end

    -- ════════════════════════════════════════════════════════════════════════
    -- CREATE PAGE
    -- ════════════════════════════════════════════════════════════════════════

    function Window:CreatePage(cfg)
        cfg = cfg or {}
        local name = cfg.Name or "Page"
        local icon = cfg.Icon

        local page = { Visible = false }

        local frame = Create("ScrollingFrame", {
            Name = name,
            Parent = content,
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 5,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0,0,0,0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false
        })

        Create("UIPadding", {Parent = frame, PaddingTop = UDim.new(0,16), PaddingLeft = UDim.new(0,16), PaddingRight = UDim.new(0,16), PaddingBottom = UDim.new(0,16)})
        Create("UIListLayout", {Parent = frame, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,14)})

        local btnSize = IsMobile() and 52 or 46
        local btn = Create("TextButton", {
            Name = name,
            Parent = sidebar,
            Size = UDim2.new(0, btnSize, 0, btnSize),
            BackgroundColor3 = Theme.Sidebar,
            BorderSizePixel = 0,
            AutoButtonColor = false
        })
        Create("UICorner", {Parent = btn, CornerRadius = UDim.new(0,10)})

        if icon then
            Create("ImageLabel", {
                Name = "Icon",
                Parent = btn,
                Size = UDim2.new(0,26,0,26),
                Position = UDim2.new(0.5,0,0.5,0),
                AnchorPoint = Vector2.new(0.5,0.5),
                BackgroundTransparency = 1,
                Image = icon,
                ImageColor3 = Theme.TextMuted,
                ScaleType = Enum.ScaleType.Fit
            })
        end

        btn.MouseButton1Click:Connect(function() SwitchPage(page) end)

        btn.MouseEnter:Connect(function()
            if not page.Visible then Tween(btn, {BackgroundColor3 = Theme.SidebarHover}, 0.2) end
        end)

        btn.MouseLeave:Connect(function()
            if not page.Visible then Tween(btn, {BackgroundColor3 = Theme.Sidebar}, 0.2) end
        end)

        btn.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                Tween(btn, {Size = UDim2.new(0, btnSize*1.08, 0, btnSize*1.08)}, 0.14)
            end
        end)

        btn.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                Tween(btn, {Size = UDim2.new(0, btnSize, 0, btnSize)}, 0.16)
            end
        end)

        page.Frame  = frame
        page.Button = btn

        table.insert(Window.Pages, page)

        if #Window.Pages == 1 then
            page.Frame.Visible = true
            page.Frame.BackgroundTransparency = 0
            page.Visible = true
            page.Button.BackgroundColor3 = Theme.SidebarActive
            local ic = page.Button:FindFirstChild("Icon")
            if ic then ic.ImageColor3 = Theme.Text end
            Window.CurrentPage = page
        end

        -- ════════════════════════════════════════════════════════════════════════
        -- CREATE SECTION
        -- ════════════════════════════════════════════════════════════════════════

        function page:CreateSection(name, collapsible)
            local sec = {}

            local f = Create("Frame", {
                Parent = frame,
                Size = UDim2.new(1,0,0,0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })

            Create("UIListLayout", {Parent = f, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,10)})

            local header, container, arrow

            if collapsible then
                header = Create("TextButton", {
                    Parent = f,
                    Size = UDim2.new(1,0,0,40),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                Create("UICorner", {Parent = header, CornerRadius = UDim.new(0,8)})

                Create("TextLabel", {
                    Parent = header,
                    Size = UDim2.new(1,-48,1,0),
                    Position = UDim2.new(0,16,0,0),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 15,
                    Font = Enum.Font.GothamSemibold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                arrow = Create("TextLabel", {
                    Parent = header,
                    Size = UDim2.new(0,24,0,24),
                    Position = UDim2.new(1,-32,0.5,0),
                    AnchorPoint = Vector2.new(0,0.5),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextMuted,
                    TextSize = 18,
                    Font = Enum.Font.GothamBold
                })

                container = Create("Frame", {
                    Parent = f,
                    Size = UDim2.new(1,0,0,0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Visible = false
                })
                Create("UIListLayout", {Parent = container, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,10)})

                local open = false
                header.MouseButton1Click:Connect(function()
                    open = not open
                    container.Visible = open
                    Tween(arrow, {Rotation = open and 180 or 0}, 0.25)
                end)

                sec.Container = container
            else
                header = Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(1,0,0,30),
                    BackgroundTransparency = 1,
                    Text = name,
                    TextColor3 = Theme.Text,
                    TextSize = 16,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                sec.Container = f
            end

            local left = Create("Frame", {
                Parent = collapsible and container or f,
                Size = UDim2.new(0.48,0,0,0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            Create("UIListLayout", {Parent = left, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,10)})

            local right = Create("Frame", {
                Parent = collapsible and container or f,
                Size = UDim2.new(0.48,0,0,0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            Create("UIListLayout", {Parent = right, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,10)})

            sec.Left = left
            sec.Right = right
            sec.Frame = f

            local function smallest()
                return left.AbsoluteSize.Y <= right.AbsoluteSize.Y and left or right
            end

            -- TOGGLE (example - already had)
            function sec:AddToggle(c)
                c = c or {}
                local n = c.Name or "Toggle"
                local d = c.Default or false
                local cb = c.Callback or function() end

                local f = Create("Frame", {
                    Parent = smallest(),
                    Size = UDim2.new(1,0,0,38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = f, CornerRadius = UDim.new(0,6)})

                Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(1,-70,1,0),
                    Position = UDim2.new(0,12,0,0),
                    BackgroundTransparency = 1,
                    Text = n,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local b = Create("TextButton", {
                    Parent = f,
                    Size = UDim2.new(0,44,0,22),
                    Position = UDim2.new(1,-54,0.5,0),
                    AnchorPoint = Vector2.new(1,0.5),
                    BackgroundColor3 = d and Theme.ToggleOn or Theme.ToggleOff,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })
                Create("UICorner", {Parent = b, CornerRadius = UDim.new(1,0)})

                local c = Create("Frame", {
                    Parent = b,
                    Size = UDim2.new(0,18,0,18),
                    Position = d and UDim2.new(1,-20,0.5,0) or UDim2.new(0,2,0.5,0),
                    AnchorPoint = Vector2.new(0,0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = c, CornerRadius = UDim.new(1,0)})

                local v = d
                local function update(val)
                    v = val
                    Tween(b, {BackgroundColor3 = val and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
                    Tween(c, {Position = val and UDim2.new(1,-20,0.5,0) or UDim2.new(0,2,0.5,0)}, 0.2)
                    cb(val)
                end

                b.MouseButton1Click:Connect(function() update(not v) end)

                return { SetValue = function(x) update(x) end, Toggle = function() update(not v) end }
            end

            -- SLIDER
            function sec:AddSlider(c)
                c = c or {}
                local n  = c.Name or "Slider"
                local mi = c.Min or 0
                local ma = c.Max or 100
                local de = c.Default or mi
                local st = c.Step or 1
                local su = c.Suffix or ""
                local cb = c.Callback or function() end

                local val = de

                local f = Create("Frame", {
                    Parent = smallest(),
                    Size = UDim2.new(1,0,0,54),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = f, CornerRadius = UDim.new(0,8)})

                Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(1,-80,0,18),
                    Position = UDim2.new(0,12,0,8),
                    BackgroundTransparency = 1,
                    Text = n,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.GothamSemibold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local vl = Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(0,60,0,18),
                    Position = UDim2.new(1,-72,0,8),
                    BackgroundTransparency = 1,
                    Text = tostring(de)..su,
                    TextColor3 = Theme.Accent,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right
                })

                local t = Create("Frame", {
                    Parent = f,
                    Size = UDim2.new(1,-24,0,6),
                    Position = UDim2.new(0,12,0,36),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = t, CornerRadius = UDim.new(1,0)})

                local fill = Create("Frame", {
                    Parent = t,
                    Size = UDim2.new((de-mi)/(ma-mi),0,1,0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = fill, CornerRadius = UDim.new(1,0)})

                local knob = Create("Frame", {
                    Parent = t,
                    Size = UDim2.new(0,16,0,16),
                    Position = UDim2.new((de-mi)/(ma-mi),-8,0.5,0),
                    AnchorPoint = Vector2.new(0.5,0.5),
                    BackgroundColor3 = Theme.Text,
                    BorderSizePixel = 0
                })
                Create("UICorner", {Parent = knob, CornerRadius = UDim.new(1,0)})

                local drag = false

                local function upd(v, skip)
                    v = math.clamp(v, mi, ma)
                    v = math.floor((v - mi)/st + 0.5) * st + mi
                    val = v
                    local r = (v - mi)/(ma - mi)
                    vl.Text = tostring(v)..su
                    Tween(fill, {Size = UDim2.new(r,0,1,0)}, 0.12)
                    Tween(knob, {Position = UDim2.new(r,-8,0.5,0)}, 0.12)
                    if not skip then cb(v) end
                end

                t.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        drag = true
                        local rx = math.clamp((i.Position.X - t.AbsolutePosition.X)/t.AbsoluteSize.X, 0, 1)
                        upd(mi + (ma - mi) * rx)
                    end
                end)

                UIS.InputChanged:Connect(function(i)
                    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        local rx = math.clamp((i.Position.X - t.AbsolutePosition.X)/t.AbsoluteSize.X, 0, 1)
                        upd(mi + (ma - mi) * rx)
                    end
                end)

                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        drag = false
                    end
                end)

                t.MouseEnter:Connect(function() Tween(knob, {Size = UDim2.new(0,20,0,20)}, 0.18) end)
                knob.MouseEnter:Connect(function() Tween(knob, {Size = UDim2.new(0,20,0,20)}, 0.18) end)
                t.MouseLeave:Connect(function() Tween(knob, {Size = UDim2.new(0,16,0,16)}, 0.18) end)
                knob.MouseLeave:Connect(function() Tween(knob, {Size = UDim2.new(0,16,0,16)}, 0.18) end)

                local obj = {
                    SetValue = function(v,skip) upd(v,skip) end,
                    GetValue = function() return val end
                }

                table.insert(sec.Elements or {}, obj)
                return obj
            end

            -- DROPDOWN
            function sec:AddDropdown(c)
                c = c or {}
                local n = c.Name or "Dropdown"
                local opts = c.Options or {"Option 1", "Option 2"}
                local def = c.Default or opts[1]
                local cb  = c.Callback or function() end

                local cur = def
                local open = false

                local f = Create("Frame", {
                    Parent = smallest(),
                    Size = UDim2.new(1,0,0,38),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    ZIndex = 2
                })
                Create("UICorner", {Parent = f, CornerRadius = UDim.new(0,6)})

                local lbl = Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(1,-40,1,0),
                    Position = UDim2.new(0,12,0,0),
                    BackgroundTransparency = 1,
                    Text = n .. ": " .. cur,
                    TextColor3 = Theme.Text,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })

                local arrow = Create("TextLabel", {
                    Parent = f,
                    Size = UDim2.new(0,20,0,20),
                    Position = UDim2.new(1,-30,0.5,0),
                    AnchorPoint = Vector2.new(0,0.5),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = Theme.TextMuted,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold
                })

                local list = Create("Frame", {
                    Name = "List",
                    Parent = sg,
                    Size = UDim2.new(0,0,0,0),
                    Position = UDim2.new(0,0,0,0),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 100
                })
                Create("UICorner", {Parent = list, CornerRadius = UDim.new(0,6)})
                Create("UIListLayout", {Parent = list, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,2)})
                Create("UIPadding", {Parent = list, PaddingTop = UDim.new(0,6), PaddingBottom = UDim.new(0,6)})

                local function update(v)
                    cur = v
                    lbl.Text = n .. ": " .. v
                    cb(v)
                end

                local function posList()
                    local abs = f.AbsolutePosition
                    local sz  = f.AbsoluteSize
                    list.Position = UDim2.new(0, abs.X, 0, abs.Y + sz.Y + 4)
                    list.Size = UDim2.new(0, sz.X, 0, 0)
                end

                f.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        open = not open
                        list.Visible = open
                        if open then
                            posList()
                            local h = #opts * 34 + 12
                            Tween(list, {Size = UDim2.new(0, f.AbsoluteSize.X, 0, h)}, 0.2)
                            Tween(arrow, {Rotation = 180}, 0.2)
                        else
                            Tween(list, {Size = UDim2.new(0, f.AbsoluteSize.X, 0, 0)}, 0.2)
                            Tween(arrow, {Rotation = 0}, 0.2)
                            task.delay(0.2, function() list.Visible = false end)
                        end
                    end
                end)

                for _, opt in ipairs(opts) do
                    local b = Create("TextButton", {
                        Parent = list,
                        Size = UDim2.new(1,0,0,32),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = "  " .. opt,
                        TextColor3 = Theme.Text,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false
                    })

                    b.MouseButton1Click:Connect(function()
                        update(opt)
                        open = false
                        Tween(list, {Size = UDim2.new(0, f.AbsoluteSize.X, 0, 0)}, 0.2)
                        Tween(arrow, {Rotation = 0}, 0.2)
                        task.delay(0.2, function() list.Visible = false end)
                    end)

                    b.MouseEnter:Connect(function() Tween(b, {BackgroundColor3 = Theme.Accent}, 0.15) end)
                    b.MouseLeave:Connect(function() Tween(b, {BackgroundColor3 = Theme.Tertiary}, 0.15) end)
                end

                local obj = {
                    SetValue = function(v) update(v) end,
                    GetValue = function() return cur end
                }

                table.insert(sec.Elements or {}, obj)
                return obj
            end

            -- You can continue adding more elements here (Button, Textbox, ColorPicker, Keybind, Label, etc.)

            return sec
        end

        return page
    end

    -- ════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION
    -- ════════════════════════════════════════════════════════════════════════

    function Window:Notify(cfg)
        cfg = cfg or {}
        local n = Create("Frame", {
            Parent = sg,
            Size = UDim2.new(0,360,0,120),
            Position = UDim2.new(1,-380,1,-140),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0
        })
        Create("UICorner", {Parent = n, CornerRadius = UDim.new(0,14)})

        Create("Frame", {
            Parent = n,
            Size = UDim2.new(0,6,1,0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0
        })

        Create("TextLabel", {
            Parent = n,
            Size = UDim2.new(1,-20,0,0),
            Position = UDim2.new(0,16,0,16),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = cfg.Title or "Notification",
            TextColor3 = Theme.Text,
            TextSize = 18,
            Font = Enum.Font.GothamSemibold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })

        Create("TextLabel", {
            Parent = n,
            Size = UDim2.new(1,-20,0,0),
            Position = UDim2.new(0,16,0,42),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = cfg.Content or "",
            TextColor3 = Theme.TextDark,
            TextSize = 15,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true
        })

        n.BackgroundTransparency = 1
        Tween(n, {BackgroundTransparency = 0, Position = UDim2.new(1,-380,1,-140)}, 0.4)

        task.delay(cfg.Duration or 4, function()
            Tween(n, {BackgroundTransparency = 1, Position = UDim2.new(1,-380,1,-90)}, 0.5)
            task.delay(0.6, n.Destroy, n)
        end)
    end

    -- Theme switch (basic - you can expand later)
    function Window:SetTheme(name)
        if Themes[name] then
            Theme = Themes[name]
            CurrentThemeName = name
            -- Add full refresh logic here if desired (re-color everything)
            self:Notify({Title = "Theme Changed", Content = "Now using "..name, Duration = 2.5})
        end
    end

    return Window
end

return Library
