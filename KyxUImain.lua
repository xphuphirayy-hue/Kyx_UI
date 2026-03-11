-- ╔══════════════════════════════════════════════════════════╗
-- ║                   Kyx_UI  v2.0                          ║
-- ║            Dark Gold Theme  —  KYX HUB Style            ║
-- ╚══════════════════════════════════════════════════════════╝
--[[
  USAGE:
    local KyxUI = loadstring(game:HttpGet("URL"))()
    local Win = KyxUI:CreateWindow({ Title="KYX HUB", SubTitle="v1.0" })
    local Tab = Win:CreateTab("Farm")
    Tab:Section("AUTO FARM")
    Tab:Toggle({ Name="Auto Farm", Default=false, Callback=function(v) print(v) end })
    Tab:Button({ Name="Hop Server", Callback=function() print("hop") end })
    Tab:Slider({ Name="Speed", Min=1, Max=100, Default=50, Callback=function(v) print(v) end })
    Tab:Dropdown({ Name="Mode", Options={"A","B","C"}, Default="A", Callback=function(v) print(v) end })
    Tab:Input({ Name="Value", PlaceholderText="...", Callback=function(v) print(v) end })
    KyxUI:Notify({ Title="Done", Content="สำเร็จ", Duration=3 })
    KyxUI:Dialog({ Title="ยืนยัน?", Content="ดำเนินการ?", OnConfirm=function() end })
]]

local KyxUI = {}
KyxUI.__index = KyxUI

-- ── Services ─────────────────────────────────────────────────
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

-- ── Theme ─────────────────────────────────────────────────────
local T = {
    -- Window
    WindowBG      = Color3.fromRGB(20,  20,  24),
    WindowBorder  = Color3.fromRGB(220, 168, 60),
    TitleBG       = Color3.fromRGB(14,  14,  17),
    TitleText     = Color3.fromRGB(255, 255, 255),
    SubText       = Color3.fromRGB(180, 140, 60),
    Accent        = Color3.fromRGB(220, 168, 60),
    AccentDark    = Color3.fromRGB(160, 120, 40),

    -- Sidebar
    SidebarBG     = Color3.fromRGB(14,  14,  17),
    TabBtn        = Color3.fromRGB(22,  22,  27),
    TabBtnHov     = Color3.fromRGB(32,  30,  38),
    TabBtnActive  = Color3.fromRGB(30,  28,  36),
    TabText       = Color3.fromRGB(160, 155, 170),
    TabTextActive = Color3.fromRGB(255, 255, 255),

    -- Panel / Row
    PanelBG       = Color3.fromRGB(20,  20,  24),
    RowBG         = Color3.fromRGB(26,  26,  32),
    RowHov        = Color3.fromRGB(32,  31,  40),
    RowBorder     = Color3.fromRGB(45,  43,  55),
    LabelText     = Color3.fromRGB(230, 230, 235),
    DescText      = Color3.fromRGB(130, 125, 145),
    SectionText   = Color3.fromRGB(220, 168, 60),

    -- Toggle
    ToggleON      = Color3.fromRGB(220, 168, 60),
    ToggleOFF     = Color3.fromRGB(55,  52,  68),
    ToggleBall    = Color3.fromRGB(255, 255, 255),

    -- Slider
    SliderTrack   = Color3.fromRGB(45,  43,  55),
    SliderFill    = Color3.fromRGB(220, 168, 60),
    SliderThumb   = Color3.fromRGB(255, 255, 255),
    SliderValue   = Color3.fromRGB(220, 168, 60),

    -- Button
    BtnText       = Color3.fromRGB(230, 230, 235),
    BtnAccent     = Color3.fromRGB(220, 168, 60),
    BtnAccentHov  = Color3.fromRGB(240, 185, 80),
    BtnAccentText = Color3.fromRGB(20,  18,  12),
    BtnPress      = Color3.fromRGB(38,  37,  48),

    -- Dropdown
    DropBG        = Color3.fromRGB(26,  26,  32),
    DropBorder    = Color3.fromRGB(60,  57,  75),
    DropText      = Color3.fromRGB(200, 195, 215),
    DropItemHov   = Color3.fromRGB(38,  36,  48),
    DropItemActive= Color3.fromRGB(220, 168, 60),

    -- Input
    InputBG       = Color3.fromRGB(18,  18,  23),
    InputBorder   = Color3.fromRGB(55,  52,  68),
    InputFocus    = Color3.fromRGB(220, 168, 60),
    InputText     = Color3.fromRGB(230, 230, 235),
    InputPlaceholder = Color3.fromRGB(100, 95, 115),

    -- Notify
    NotifyBG      = Color3.fromRGB(26,  26,  32),
    NotifyBorder  = Color3.fromRGB(60,  57,  75),

    Shadow        = Color3.fromRGB(0, 0, 0),
}

-- ── TweenInfos ────────────────────────────────────────────────
local TI = {
    Fast   = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Medium = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Spring = TweenInfo.new(0.3,  Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
}

-- ── Helpers ───────────────────────────────────────────────────
local function Tween(obj, info, props)
    local ok, tw = pcall(function() return TweenService:Create(obj, info, props) end)
    if ok and tw then tw:Play() end
end

local function New(class, props)
    local ok, obj = pcall(function() return Instance.new(class) end)
    if not ok then return nil end
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            pcall(function() obj[k] = v end)
        end
    end
    if props and props.Parent then
        pcall(function() obj.Parent = props.Parent end)
    end
    return obj
end

local function Corner(parent, r)
    New("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = parent })
end

local function Stroke(parent, color, thick, trans)
    New("UIStroke", {
        Color        = color or T.RowBorder,
        Thickness    = thick or 1,
        Transparency = trans or 0,
        Parent       = parent,
    })
end

local function Pad(parent, t, b, l, r)
    New("UIPadding", {
        PaddingTop    = UDim.new(0, t or 0),
        PaddingBottom = UDim.new(0, b or 0),
        PaddingLeft   = UDim.new(0, l or 0),
        PaddingRight  = UDim.new(0, r or 0),
        Parent        = parent,
    })
end

local function Shadow(parent)
    New("ImageLabel", {
        Name                  = "_Shadow",
        AnchorPoint           = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position              = UDim2.new(0.5,0,0.5,0),
        Size                  = UDim2.new(1,35,1,35),
        ZIndex                = (parent.ZIndex or 1) - 1,
        Image                 = "rbxassetid://6015897843",
        ImageColor3           = T.Shadow,
        ImageTransparency     = 0.5,
        ScaleType             = Enum.ScaleType.Slice,
        SliceCenter           = Rect.new(49,49,450,450),
        Parent                = parent,
    })
end

-- ── Notification ──────────────────────────────────────────────
local NotifySG = nil
local function EnsureNotifySG()
    if NotifySG and NotifySG.Parent then return NotifySG end
    NotifySG = New("ScreenGui", {
        Name           = "KyxUI_Notify",
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = CoreGui,
    })
    return NotifySG
end

function KyxUI:Notify(cfg)
    cfg = cfg or {}
    local title    = cfg.Title   or "Kyx_UI"
    local content  = cfg.Content or ""
    local duration = cfg.Duration or 3
    local ntype    = cfg.Type or "Info"

    local typeColor = {
        Info    = Color3.fromRGB(100, 160, 255),
        Success = Color3.fromRGB(80,  200, 120),
        Warning = Color3.fromRGB(255, 185, 60),
        Error   = Color3.fromRGB(255, 80,  80),
    }
    local accent = typeColor[ntype] or typeColor.Info

    local sg = EnsureNotifySG()

    local card = New("Frame", {
        Size             = UDim2.new(0, 300, 0, 70),
        Position         = UDim2.new(1, 20, 1, -90),
        AnchorPoint      = Vector2.new(1, 1),
        BackgroundColor3 = T.NotifyBG,
        BorderSizePixel  = 0,
        ZIndex           = 200,
        Parent           = sg,
    })
    Corner(card, 10)
    Stroke(card, T.NotifyBorder, 1, 0)
    Shadow(card)

    -- left accent bar
    New("Frame", {
        Size             = UDim2.new(0, 3, 1, -16),
        Position         = UDim2.new(0, 0, 0, 8),
        BackgroundColor3 = accent,
        BorderSizePixel  = 0,
        ZIndex           = 201,
        Parent           = card,
    })

    New("TextLabel", {
        Text               = title,
        Size               = UDim2.new(1,-20,0,20),
        Position           = UDim2.new(0,14,0,10),
        BackgroundTransparency = 1,
        TextColor3         = Color3.fromRGB(255,255,255),
        Font               = Enum.Font.GothamBold,
        TextSize           = 13,
        TextXAlignment     = Enum.TextXAlignment.Left,
        ZIndex             = 202,
        Parent             = card,
    })
    New("TextLabel", {
        Text               = content,
        Size               = UDim2.new(1,-20,0,28),
        Position           = UDim2.new(0,14,0,30),
        BackgroundTransparency = 1,
        TextColor3         = T.DescText,
        Font               = Enum.Font.Gotham,
        TextSize           = 11,
        TextWrapped        = true,
        TextXAlignment     = Enum.TextXAlignment.Left,
        ZIndex             = 202,
        Parent             = card,
    })

    -- slide in
    Tween(card, TI.Spring, { Position = UDim2.new(1,-16,1,-90) })
    task.delay(duration, function()
        Tween(card, TI.Medium, { Position = UDim2.new(1,320,1,-90) })
        task.delay(0.3, function() card:Destroy() end)
    end)
end

-- ── Dialog ────────────────────────────────────────────────────
function KyxUI:Dialog(cfg)
    cfg = cfg or {}
    local title   = cfg.Title   or "ยืนยัน"
    local content = cfg.Content or ""
    local confirmTxt = cfg.Confirm or "ยืนยัน"
    local cancelTxt  = cfg.Cancel  or "ยกเลิก"
    local onConfirm  = cfg.OnConfirm
    local onCancel   = cfg.OnCancel

    local sg = New("ScreenGui", {
        Name           = "KyxUI_Dialog",
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = CoreGui,
    })

    local backdrop = New("Frame", {
        Size             = UDim2.new(1,0,1,0),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.5,
        BorderSizePixel  = 0,
        ZIndex           = 300,
        Parent           = sg,
    })

    local card = New("Frame", {
        Size             = UDim2.new(0, 360, 0, 160),
        Position         = UDim2.new(0.5,0,0.5,0),
        AnchorPoint      = Vector2.new(0.5, 0.5),
        BackgroundColor3 = T.WindowBG,
        BorderSizePixel  = 0,
        ZIndex           = 301,
        Parent           = sg,
    })
    Corner(card, 12)
    Stroke(card, T.WindowBorder, 1, 0)
    Shadow(card)

    New("TextLabel", {
        Text               = title,
        Size               = UDim2.new(1,-24,0,24),
        Position           = UDim2.new(0,16,0,16),
        BackgroundTransparency = 1,
        TextColor3         = T.TitleText,
        Font               = Enum.Font.GothamBold,
        TextSize           = 15,
        TextXAlignment     = Enum.TextXAlignment.Left,
        ZIndex             = 302,
        Parent             = card,
    })
    New("TextLabel", {
        Text               = content,
        Size               = UDim2.new(1,-32,0,40),
        Position           = UDim2.new(0,16,0,46),
        BackgroundTransparency = 1,
        TextColor3         = T.DescText,
        Font               = Enum.Font.Gotham,
        TextSize           = 12,
        TextWrapped        = true,
        TextXAlignment     = Enum.TextXAlignment.Left,
        ZIndex             = 302,
        Parent             = card,
    })

    local function Dismiss()
        sg:Destroy()
    end

    local cancelBtn = New("TextButton", {
        Text             = cancelTxt,
        Size             = UDim2.new(0, 150, 0, 36),
        Position         = UDim2.new(0, 16, 1, -52),
        BackgroundColor3 = T.RowBG,
        TextColor3       = T.LabelText,
        Font             = Enum.Font.GothamBold,
        TextSize         = 12,
        BorderSizePixel  = 0,
        ZIndex           = 302,
        Parent           = card,
    })
    Corner(cancelBtn, 8)
    Stroke(cancelBtn, T.RowBorder, 1, 0)

    local confirmBtn = New("TextButton", {
        Text             = confirmTxt,
        Size             = UDim2.new(0, 150, 0, 36),
        Position         = UDim2.new(1, -166, 1, -52),
        BackgroundColor3 = T.Accent,
        TextColor3       = Color3.fromRGB(20,18,12),
        Font             = Enum.Font.GothamBold,
        TextSize         = 12,
        BorderSizePixel  = 0,
        ZIndex           = 302,
        Parent           = card,
    })
    Corner(confirmBtn, 8)

    cancelBtn.MouseEnter:Connect(function()  Tween(cancelBtn,  TI.Fast, {BackgroundColor3=T.RowHov}) end)
    cancelBtn.MouseLeave:Connect(function()  Tween(cancelBtn,  TI.Fast, {BackgroundColor3=T.RowBG}) end)
    confirmBtn.MouseEnter:Connect(function() Tween(confirmBtn, TI.Fast, {BackgroundColor3=T.BtnAccentHov}) end)
    confirmBtn.MouseLeave:Connect(function() Tween(confirmBtn, TI.Fast, {BackgroundColor3=T.Accent}) end)

    cancelBtn.MouseButton1Click:Connect(function()
        Dismiss()
        if onCancel then onCancel() end
    end)
    confirmBtn.MouseButton1Click:Connect(function()
        Dismiss()
        if onConfirm then onConfirm() end
    end)
    backdrop.MouseButton1Click:Connect(Dismiss)
end

-- ══════════════════════════════════════════════════════════════
--  CreateWindow
-- ══════════════════════════════════════════════════════════════
function KyxUI:CreateWindow(cfg)
    cfg = cfg or {}
    local Title    = cfg.Title    or "KYX HUB"
    local SubTitle = cfg.SubTitle or ""
    local W        = cfg.Width    or 660
    local H        = cfg.Height   or 480
    local KeyCode  = cfg.KeyCode  or Enum.KeyCode.Insert

    -- ── ScreenGui ─────────────────────────────────────────────
    local SG = New("ScreenGui", {
        Name           = "KyxUI_"..Title,
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = CoreGui,
    })

    -- ── Main Frame ────────────────────────────────────────────
    local MF = New("Frame", {
        Name             = "Window",
        Size             = UDim2.new(0, W, 0, H),
        Position         = UDim2.new(0.5,-W/2, 0.5,-H/2),
        BackgroundColor3 = T.WindowBG,
        BorderSizePixel  = 0,
        ClipsDescendants = false,
        ZIndex           = 10,
        Parent           = SG,
    })
    Corner(MF, 12)
    Stroke(MF, T.WindowBorder, 1, 0)
    Shadow(MF)

    -- Clip frame (rounded inner)
    local Clip = New("Frame", {
        Size             = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex           = 10,
        Parent           = MF,
    })
    Corner(Clip, 12)

    -- ── Title Bar ─────────────────────────────────────────────
    local TitleBar = New("Frame", {
        Size             = UDim2.new(1,0,0,52),
        BackgroundColor3 = T.TitleBG,
        BorderSizePixel  = 0,
        ZIndex           = 11,
        Parent           = Clip,
    })

    -- gold top line
    New("Frame", {
        Size             = UDim2.new(1,0,0,2),
        BackgroundColor3 = T.Accent,
        BorderSizePixel  = 0,
        ZIndex           = 12,
        Parent           = TitleBar,
    })

    New("TextLabel", {
        Text               = Title,
        Size               = UDim2.new(0,200,0,26),
        Position           = UDim2.new(0,16,0,14),
        BackgroundTransparency = 1,
        TextColor3         = T.TitleText,
        Font               = Enum.Font.GothamBold,
        TextSize           = 14,
        TextXAlignment     = Enum.TextXAlignment.Left,
        ZIndex             = 12,
        Parent             = TitleBar,
    })
    if SubTitle ~= "" then
        New("TextLabel", {
            Text               = SubTitle,
            Size               = UDim2.new(0,200,0,16),
            Position           = UDim2.new(0,16,0,30),
            BackgroundTransparency = 1,
            TextColor3         = T.SubText,
            Font               = Enum.Font.Gotham,
            TextSize           = 10,
            TextXAlignment     = Enum.TextXAlignment.Left,
            ZIndex             = 12,
            Parent             = TitleBar,
        })
    end

    -- Separator under titlebar
    New("Frame", {
        Size             = UDim2.new(1,0,0,1),
        Position         = UDim2.new(0,0,1,-1),
        BackgroundColor3 = Color3.fromRGB(40,38,50),
        BorderSizePixel  = 0,
        ZIndex           = 12,
        Parent           = TitleBar,
    })

    -- Close button
    local CloseBtn = New("TextButton", {
        Text             = "✕",
        Size             = UDim2.new(0,32,0,32),
        Position         = UDim2.new(1,-40,0,10),
        BackgroundTransparency = 1,
        TextColor3       = Color3.fromRGB(160,155,170),
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        BorderSizePixel  = 0,
        ZIndex           = 13,
        Parent           = TitleBar,
    })
    Corner(CloseBtn, 6)
    CloseBtn.MouseEnter:Connect(function()
        Tween(CloseBtn, TI.Fast, {BackgroundColor3=Color3.fromRGB(200,60,60), BackgroundTransparency=0, TextColor3=Color3.fromRGB(255,255,255)})
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, TI.Fast, {BackgroundColor3=Color3.fromRGB(0,0,0), BackgroundTransparency=1, TextColor3=Color3.fromRGB(160,155,170)})
    end)
    CloseBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

    -- Minimize button
    local MinBtn = New("TextButton", {
        Text             = "─",
        Size             = UDim2.new(0,32,0,32),
        Position         = UDim2.new(1,-76,0,10),
        BackgroundTransparency = 1,
        TextColor3       = Color3.fromRGB(160,155,170),
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        BorderSizePixel  = 0,
        ZIndex           = 13,
        Parent           = TitleBar,
    })
    Corner(MinBtn, 6)
    local minimized = false
    MinBtn.MouseEnter:Connect(function()
        Tween(MinBtn, TI.Fast, {BackgroundColor3=T.RowHov, BackgroundTransparency=0, TextColor3=Color3.fromRGB(255,255,255)})
    end)
    MinBtn.MouseLeave:Connect(function()
        Tween(MinBtn, TI.Fast, {BackgroundColor3=Color3.fromRGB(0,0,0), BackgroundTransparency=1, TextColor3=Color3.fromRGB(160,155,170)})
    end)
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MF, TI.Spring, {Size=UDim2.new(0,W,0,52)})
        else
            Tween(MF, TI.Spring, {Size=UDim2.new(0,W,0,H)})
        end
    end)

    -- Draggable
    local dragging, dragStart, startPos = false, nil, nil
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = MF.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MF.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Toggle visibility
    UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == KeyCode then
            MF.Visible = not MF.Visible
        end
    end)

    -- ── Body ──────────────────────────────────────────────────
    local Body = New("Frame", {
        Size             = UDim2.new(1,0,1,-52),
        Position         = UDim2.new(0,0,0,52),
        BackgroundTransparency = 1,
        ZIndex           = 11,
        Parent           = Clip,
    })

    -- ── Sidebar ───────────────────────────────────────────────
    local Sidebar = New("Frame", {
        Size             = UDim2.new(0,200,1,0),
        BackgroundColor3 = T.SidebarBG,
        BorderSizePixel  = 0,
        ZIndex           = 11,
        Parent           = Body,
    })

    -- sidebar right border
    New("Frame", {
        Size             = UDim2.new(0,1,1,0),
        Position         = UDim2.new(1,-1,0,0),
        BackgroundColor3 = Color3.fromRGB(40,38,50),
        BorderSizePixel  = 0,
        ZIndex           = 12,
        Parent           = Sidebar,
    })

    local SideScroll = New("ScrollingFrame", {
        Size                 = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        BorderSizePixel      = 0,
        ScrollBarThickness   = 0,
        CanvasSize           = UDim2.new(0,0,0,0),
        AutomaticCanvasSize  = Enum.AutomaticSize.Y,
        ScrollingDirection   = Enum.ScrollingDirection.Y,
        ZIndex               = 12,
        Parent               = Sidebar,
    })
    New("UIListLayout", {
        Padding             = UDim.new(0,4),
        SortOrder           = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Parent              = SideScroll,
    })
    Pad(SideScroll, 8,8,8,8)

    -- ── Panel ─────────────────────────────────────────────────
    local Panel = New("Frame", {
        Size             = UDim2.new(1,-200,1,0),
        Position         = UDim2.new(0,200,0,0),
        BackgroundColor3 = T.PanelBG,
        BorderSizePixel  = 0,
        ZIndex           = 11,
        Parent           = Body,
    })

    -- ── Dropdown overlay ──────────────────────────────────────
    local DDOverlay = New("Frame", {
        Size             = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        ZIndex           = 90,
        Visible          = false,
        Parent           = SG,
    })
    local ActiveDD = nil
    local function CloseDD()
        if ActiveDD then
            ActiveDD:Destroy()
            ActiveDD = nil
        end
        DDOverlay.Visible = false
    end
    DDOverlay.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then CloseDD() end
    end)

    -- ══════════════════════════════════════════════════════════
    --  TAB SYSTEM
    -- ══════════════════════════════════════════════════════════
    local TabList    = {}  -- ordered
    local ActiveName = nil

    -- WinObj
    local WinObj = {}

    function WinObj:CreateTab(name, _icon)
        -- ── Sidebar button ────────────────────────────────────
        local tabBtn = New("TextButton", {
            Text             = "",
            Size             = UDim2.new(1,-16,0,40),
            BackgroundColor3 = T.TabBtn,
            BorderSizePixel  = 0,
            ZIndex           = 13,
            Parent           = SideScroll,
        })
        Corner(tabBtn, 8)

        -- active indicator
        local indicator = New("Frame", {
            Size             = UDim2.new(0,3,0,18),
            Position         = UDim2.new(0,0,0.5,-9),
            BackgroundColor3 = T.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel  = 0,
            ZIndex           = 14,
            Parent           = tabBtn,
        })
        Corner(indicator, 99)

        local tabLbl = New("TextLabel", {
            Text               = name,
            Size               = UDim2.new(1,-22,1,0),
            Position           = UDim2.new(0,14,0,0),
            BackgroundTransparency = 1,
            TextColor3         = T.TabText,
            Font               = Enum.Font.GothamBold,
            TextSize           = 12,
            TextXAlignment     = Enum.TextXAlignment.Left,
            ZIndex             = 14,
            Parent             = tabBtn,
        })

        -- ── Page ──────────────────────────────────────────────
        local page = New("ScrollingFrame", {
            Size                 = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            ScrollBarThickness   = 4,
            ScrollBarImageColor3 = Color3.fromRGB(80,75,95),
            CanvasSize           = UDim2.new(0,0,0,0),
            AutomaticCanvasSize  = Enum.AutomaticSize.Y,
            ScrollingDirection   = Enum.ScrollingDirection.Y,
            Visible              = false,
            ZIndex               = 12,
            Parent               = Panel,
        })
        New("UIListLayout", {
            Padding             = UDim.new(0,6),
            SortOrder           = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Parent              = page,
        })
        Pad(page, 12,12,12,12)

        -- register
        local entry = { Btn=tabBtn, Page=page, Indicator=indicator, Label=tabLbl }
        table.insert(TabList, entry)

        -- ── Activate ──────────────────────────────────────────
        local function Activate()
            for _, e in ipairs(TabList) do
                Tween(e.Btn,       TI.Fast, {BackgroundColor3=T.TabBtn})
                Tween(e.Label,     TI.Fast, {TextColor3=T.TabText})
                Tween(e.Indicator, TI.Fast, {BackgroundTransparency=1})
                e.Page.Visible = false
            end
            Tween(tabBtn,    TI.Fast, {BackgroundColor3=T.TabBtnActive})
            Tween(tabLbl,    TI.Fast, {TextColor3=T.TabTextActive})
            Tween(indicator, TI.Spring, {BackgroundTransparency=0})
            page.Visible = true
            ActiveName   = name
        end

        tabBtn.MouseButton1Click:Connect(Activate)
        tabBtn.MouseEnter:Connect(function()
            if ActiveName ~= name then
                Tween(tabBtn, TI.Fast, {BackgroundColor3=T.TabBtnHov})
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if ActiveName ~= name then
                Tween(tabBtn, TI.Fast, {BackgroundColor3=T.TabBtn})
            end
        end)

        -- first tab auto-activate
        if #TabList == 1 then Activate() end

        -- ══════════════════════════════════════════════════════
        --  Tab Object (components)
        -- ══════════════════════════════════════════════════════
        local Tab = {}

        -- ── Helpers for rows ──────────────────────────────────
        local function Row(h)
            local r = New("Frame", {
                Size             = UDim2.new(1,0,0,h or 48),
                BackgroundColor3 = T.RowBG,
                BorderSizePixel  = 0,
                ZIndex           = 13,
                Parent           = page,
            })
            Corner(r, 8)
            Stroke(r, T.RowBorder, 1, 0)
            return r
        end

        local function RowLabel(parent, text, x, y, w, h, big)
            New("TextLabel", {
                Text               = text or "",
                Size               = UDim2.new(0, w or 200, 0, h or 18),
                Position           = UDim2.new(0, x or 12, 0, y or 8),
                BackgroundTransparency = 1,
                TextColor3         = big and T.LabelText or T.DescText,
                Font               = big and Enum.Font.GothamBold or Enum.Font.Gotham,
                TextSize           = big and 12 or 10,
                TextXAlignment     = Enum.TextXAlignment.Left,
                TextWrapped        = true,
                ZIndex             = 14,
                Parent             = parent,
            })
        end

        -- ── SECTION ───────────────────────────────────────────
        function Tab:Section(text)
            local sec = New("Frame", {
                Size             = UDim2.new(1,0,0,28),
                BackgroundTransparency = 1,
                ZIndex           = 13,
                Parent           = page,
            })
            New("Frame", {
                Size             = UDim2.new(0,3,0,14),
                Position         = UDim2.new(0,0,0.5,-7),
                BackgroundColor3 = T.Accent,
                BorderSizePixel  = 0,
                ZIndex           = 14,
                Parent           = sec,
            })
            New("TextLabel", {
                Text               = (text or ""):upper(),
                Size               = UDim2.new(1,-10,1,0),
                Position           = UDim2.new(0,10,0,0),
                BackgroundTransparency = 1,
                TextColor3         = T.SectionText,
                Font               = Enum.Font.GothamBold,
                TextSize           = 10,
                TextXAlignment     = Enum.TextXAlignment.Left,
                ZIndex             = 14,
                Parent             = sec,
            })
            New("Frame", {
                Size             = UDim2.new(1,0,0,1),
                Position         = UDim2.new(0,0,1,-1),
                BackgroundColor3 = Color3.fromRGB(45,43,55),
                BackgroundTransparency = 0.5,
                BorderSizePixel  = 0,
                ZIndex           = 13,
                Parent           = sec,
            })
        end

        -- ── SEPARATOR ─────────────────────────────────────────
        function Tab:Separator()
            New("Frame", {
                Size             = UDim2.new(1,0,0,1),
                BackgroundColor3 = T.RowBorder,
                BackgroundTransparency = 0.5,
                BorderSizePixel  = 0,
                ZIndex           = 13,
                Parent           = page,
            })
        end

        -- ── LABEL ─────────────────────────────────────────────
        function Tab:Label(text)
            New("TextLabel", {
                Text               = text or "",
                Size               = UDim2.new(1,0,0,22),
                BackgroundTransparency = 1,
                TextColor3         = T.DescText,
                Font               = Enum.Font.Gotham,
                TextSize           = 11,
                TextXAlignment     = Enum.TextXAlignment.Left,
                TextWrapped        = true,
                ZIndex             = 13,
                Parent             = page,
            })
        end

        -- ── TOGGLE ────────────────────────────────────────────
        function Tab:Toggle(cfg2)
            cfg2 = cfg2 or {}
            local name2 = cfg2.Name        or "Toggle"
            local desc  = cfg2.Description
            local def   = cfg2.Default     or false
            local cb    = cfg2.Callback

            local rh  = desc and 54 or 44
            local row = Row(rh)

            RowLabel(row, name2, 12, desc and 8 or 14, (Panel.AbsoluteSize.X - 200 - 80), 18, true)
            if desc then RowLabel(row, desc, 12, 28, (Panel.AbsoluteSize.X - 200 - 80), 14, false) end

            -- Track
            local track = New("Frame", {
                Size             = UDim2.new(0,42,0,22),
                Position         = UDim2.new(1,-54,0.5,-11),
                BackgroundColor3 = def and T.ToggleON or T.ToggleOFF,
                BorderSizePixel  = 0,
                ZIndex           = 15,
                Parent           = row,
            })
            Corner(track, 99)

            -- Ball
            local ball = New("Frame", {
                Size             = UDim2.new(0,16,0,16),
                Position         = def and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
                BackgroundColor3 = T.ToggleBall,
                BorderSizePixel  = 0,
                ZIndex           = 16,
                Parent           = track,
            })
            Corner(ball, 99)

            local isOn = def
            local obj  = { Value = isOn }

            local function SetToggle(v, skipCB)
                isOn      = v
                obj.Value = v
                Tween(track, TI.Fast, {BackgroundColor3 = v and T.ToggleON or T.ToggleOFF})
                Tween(ball,  TI.Spring, {Position = v and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)})
                if not skipCB and cb then cb(v) end
            end

            -- Clickable overlay
            local click = New("TextButton", {
                Text             = "",
                Size             = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                BorderSizePixel  = 0,
                ZIndex           = 17,
                Parent           = row,
            })
            click.MouseButton1Click:Connect(function() SetToggle(not isOn) end)
            click.MouseEnter:Connect(function()  Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}) end)
            click.MouseLeave:Connect(function()  Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}) end)

            function obj:Set(v)  SetToggle(v, false) end
            function obj:Get()   return isOn end
            function obj:SetDisabled(v)
                click.Active       = not v
                click.Interactable = not v
                Tween(row, TI.Fast, {BackgroundTransparency = v and 0.5 or 0})
            end
            return obj
        end

        -- ── BUTTON ────────────────────────────────────────────
        function Tab:Button(cfg2)
            cfg2 = cfg2 or {}
            local name2  = cfg2.Name     or "Button"
            local desc   = cfg2.Description
            local cb     = cfg2.Callback
            local accent = cfg2.Accent   or false

            local rh     = desc and 54 or 44
            local row    = Row(rh)

            if accent then
                row.BackgroundColor3 = T.BtnAccent
            end

            local baseBG = accent and T.BtnAccent or T.RowBG

            New("TextLabel", {
                Text               = name2,
                Size               = UDim2.new(1,-48,0,18),
                Position           = UDim2.new(0,12,0, desc and 8 or 14),
                BackgroundTransparency = 1,
                TextColor3         = accent and T.BtnAccentText or T.BtnText,
                Font               = Enum.Font.GothamBold,
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                ZIndex             = 14,
                Parent             = row,
            })
            if desc then
                New("TextLabel", {
                    Text               = desc,
                    Size               = UDim2.new(1,-48,0,14),
                    Position           = UDim2.new(0,12,0,28),
                    BackgroundTransparency = 1,
                    TextColor3         = accent and Color3.fromRGB(60,40,10) or T.DescText,
                    Font               = Enum.Font.Gotham,
                    TextSize           = 10,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    ZIndex             = 14,
                    Parent             = row,
                })
            end

            -- chevron
            New("TextLabel", {
                Text               = "›",
                Size               = UDim2.new(0,20,1,0),
                Position           = UDim2.new(1,-24,0,0),
                BackgroundTransparency = 1,
                TextColor3         = accent and T.BtnAccentText or T.DescText,
                Font               = Enum.Font.GothamBold,
                TextSize           = 18,
                ZIndex             = 14,
                Parent             = row,
            })

            -- Clickable overlay
            local click = New("TextButton", {
                Text             = "",
                Size             = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                BorderSizePixel  = 0,
                ZIndex           = 17,
                Parent           = row,
            })
            click.MouseEnter:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3 = accent and T.BtnAccentHov or T.RowHov})
            end)
            click.MouseLeave:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3 = baseBG})
            end)
            click.MouseButton1Down:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3 = accent and T.AccentDark or T.BtnPress})
            end)
            click.MouseButton1Up:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3 = baseBG})
            end)
            click.MouseButton1Click:Connect(function()
                if cb then cb() end
            end)
        end

        -- ── SLIDER ────────────────────────────────────────────
        function Tab:Slider(cfg2)
            cfg2 = cfg2 or {}
            local name2   = cfg2.Name     or "Slider"
            local desc    = cfg2.Description
            local minV    = cfg2.Min      or 0
            local maxV    = cfg2.Max      or 100
            local def     = math.clamp(cfg2.Default or minV, minV, maxV)
            local suffix  = cfg2.Suffix   or ""
            local cb      = cfg2.Callback

            local rh  = desc and 68 or 58
            local row = Row(rh)

            -- Value label (top right)
            local valLbl = New("TextLabel", {
                Text               = tostring(def)..suffix,
                Size               = UDim2.new(0,60,0,18),
                Position           = UDim2.new(1,-68,0,10),
                BackgroundTransparency = 1,
                TextColor3         = T.SliderValue,
                Font               = Enum.Font.GothamBold,
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Right,
                ZIndex             = 14,
                Parent             = row,
            })
            RowLabel(row, name2, 12, 10, (Panel.AbsoluteSize.X - 200 - 100), 18, true)
            if desc then RowLabel(row, desc, 12, 30, (Panel.AbsoluteSize.X - 200 - 100), 14, false) end

            -- Track background
            local trackY = desc and 48 or 38
            local trackBG = New("Frame", {
                Size             = UDim2.new(1,-24,0,5),
                Position         = UDim2.new(0,12,0,trackY),
                BackgroundColor3 = T.SliderTrack,
                BorderSizePixel  = 0,
                ZIndex           = 14,
                Parent           = row,
            })
            Corner(trackBG, 99)

            local pct = (def - minV) / math.max(maxV - minV, 1)

            local trackFill = New("Frame", {
                Size             = UDim2.new(pct,0,1,0),
                BackgroundColor3 = T.SliderFill,
                BorderSizePixel  = 0,
                ZIndex           = 15,
                Parent           = trackBG,
            })
            Corner(trackFill, 99)

            local thumb = New("Frame", {
                Size             = UDim2.new(0,14,0,14),
                Position         = UDim2.new(pct,-7,0.5,-7),
                BackgroundColor3 = T.SliderThumb,
                BorderSizePixel  = 0,
                ZIndex           = 16,
                Parent           = trackBG,
            })
            Corner(thumb, 99)
            Stroke(thumb, T.SliderFill, 2, 0)

            local curVal   = def
            local dragging = false
            local obj      = { Value = curVal }

            local function SetVal(v, skipCB)
                v = math.clamp(math.floor(v + 0.5), minV, maxV)
                curVal    = v
                obj.Value = v
                local p   = (v - minV) / math.max(maxV - minV, 1)
                Tween(trackFill, TI.Fast, {Size=UDim2.new(p,0,1,0)})
                Tween(thumb,     TI.Fast, {Position=UDim2.new(p,-7,0.5,-7)})
                valLbl.Text = tostring(v)..suffix
                if not skipCB and cb then cb(v) end
            end

            -- Hit area over entire row
            local sliderHit = New("TextButton", {
                Text             = "",
                Size             = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                BorderSizePixel  = 0,
                ZIndex           = 17,
                Parent           = row,
            })

            sliderHit.MouseButton1Down:Connect(function()
                dragging = true
                Tween(thumb, TI.Fast, {Size=UDim2.new(0,18,0,18), Position=UDim2.new((curVal-minV)/math.max(maxV-minV,1),-9,0.5,-9)})
            end)
            sliderHit.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}) end)
            sliderHit.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}) end)

            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
                    dragging = false
                    Tween(thumb, TI.Fast, {Size=UDim2.new(0,14,0,14)})
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local abs   = trackBG.AbsolutePosition
                    local width = trackBG.AbsoluteSize.X
                    if width < 1 then return end
                    local rel = math.clamp((i.Position.X - abs.X) / width, 0, 1)
                    SetVal(minV + rel * (maxV - minV))
                end
            end)

            function obj:Set(v)  SetVal(v, false) end
            function obj:Get()   return curVal end
            function obj:SetDisabled(v)
                sliderHit.Active       = not v
                sliderHit.Interactable = not v
            end
            return obj
        end

        -- ── DROPDOWN ──────────────────────────────────────────
        function Tab:Dropdown(cfg2)
            cfg2 = cfg2 or {}
            local name2   = cfg2.Name        or "Dropdown"
            local desc    = cfg2.Description
            local options = cfg2.Options      or {}
            local def     = cfg2.Default      or (options[1] or "เลือก...")
            local cb      = cfg2.Callback

            local rh  = desc and 54 or 44
            local row = Row(rh)

            RowLabel(row, name2, 12, desc and 8 or 14, (Panel.AbsoluteSize.X - 200 - 170), 18, true)
            if desc then RowLabel(row, desc, 12, 28, (Panel.AbsoluteSize.X - 200 - 170), 14, false) end

            local selected = def

            local dropBtn = New("TextButton", {
                Text             = tostring(selected).." ▾",
                Size             = UDim2.new(0,130,0,28),
                Position         = UDim2.new(1,-142,0.5,-14),
                BackgroundColor3 = T.InputBG,
                TextColor3       = T.Accent,
                Font             = Enum.Font.GothamBold,
                TextSize         = 11,
                BorderSizePixel  = 0,
                ZIndex           = 15,
                Parent           = row,
            })
            Corner(dropBtn, 6)
            Stroke(dropBtn, T.Accent, 1, 0.4)

            local obj = { Value = selected }

            dropBtn.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}) end)
            dropBtn.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}) end)

            dropBtn.MouseButton1Click:Connect(function()
                if ActiveDD then CloseDD(); return end
                DDOverlay.Visible = true

                local abs     = dropBtn.AbsolutePosition
                local absSize = dropBtn.AbsoluteSize
                local count   = math.min(#options, 7)
                local popH    = count * 30 + 10

                local popup = New("Frame", {
                    Position         = UDim2.new(0, abs.X, 0, abs.Y + absSize.Y + 4),
                    Size             = UDim2.new(0, absSize.X, 0, popH),
                    BackgroundColor3 = T.DropBG,
                    BorderSizePixel  = 0,
                    ZIndex           = 100,
                    Parent           = DDOverlay,
                })
                Corner(popup, 8)
                Stroke(popup, T.DropBorder, 1, 0)
                Shadow(popup)

                local scroll = New("ScrollingFrame", {
                    Size                 = UDim2.new(1,-6,1,-6),
                    Position             = UDim2.new(0,3,0,3),
                    BackgroundTransparency = 1,
                    BorderSizePixel      = 0,
                    ScrollBarThickness   = 3,
                    ScrollBarImageColor3 = Color3.fromRGB(100,95,115),
                    CanvasSize           = UDim2.new(0,0,0,0),
                    AutomaticCanvasSize  = Enum.AutomaticSize.Y,
                    ZIndex               = 101,
                    Parent               = popup,
                })
                New("UIListLayout", { Padding=UDim.new(0,2), Parent=scroll })
                Pad(scroll, 2,2,2,2)

                for _, opt in ipairs(options) do
                    local isActive = (opt == selected)
                    local item = New("TextButton", {
                        Text             = opt,
                        Size             = UDim2.new(1,0,0,28),
                        BackgroundColor3 = isActive and T.DropItemActive or T.DropBG,
                        TextColor3       = isActive and Color3.fromRGB(20,18,12) or T.DropText,
                        Font             = isActive and Enum.Font.GothamBold or Enum.Font.Gotham,
                        TextSize         = 11,
                        BorderSizePixel  = 0,
                        ZIndex           = 102,
                        Parent           = scroll,
                    })
                    Corner(item, 6)
                    item.MouseEnter:Connect(function()
                        if not (opt == selected) then
                            Tween(item, TI.Fast, {BackgroundColor3=T.DropItemHov})
                        end
                    end)
                    item.MouseLeave:Connect(function()
                        if not (opt == selected) then
                            Tween(item, TI.Fast, {BackgroundColor3=T.DropBG})
                        end
                    end)
                    item.MouseButton1Click:Connect(function()
                        selected      = opt
                        obj.Value     = opt
                        dropBtn.Text  = opt.." ▾"
                        CloseDD()
                        if cb then cb(opt) end
                    end)
                end

                ActiveDD = popup
            end)

            function obj:Set(v) selected=v; obj.Value=v; dropBtn.Text=v.." ▾" end
            function obj:Get()  return selected end
            return obj
        end

        -- ── INPUT ─────────────────────────────────────────────
        function Tab:Input(cfg2)
            cfg2 = cfg2 or {}
            local name2   = cfg2.Name           or "Input"
            local desc    = cfg2.Description
            local place   = cfg2.PlaceholderText or "พิมพ์ที่นี่..."
            local def     = cfg2.Default         or ""
            local cb      = cfg2.Callback
            local numOnly = cfg2.NumberOnly      or false

            local rh  = desc and 68 or 58
            local row = Row(rh)

            RowLabel(row, name2, 12, 8, (Panel.AbsoluteSize.X - 200 - 30), 18, true)
            if desc then RowLabel(row, desc, 12, 26, (Panel.AbsoluteSize.X - 200 - 30), 14, false) end

            local boxY = desc and 42 or 32

            local boxBG = New("Frame", {
                Size             = UDim2.new(1,-24,0,24),
                Position         = UDim2.new(0,12,0,boxY),
                BackgroundColor3 = T.InputBG,
                BorderSizePixel  = 0,
                ZIndex           = 14,
                Parent           = row,
            })
            Corner(boxBG, 6)
            local stroke2 = New("UIStroke", {
                Color      = T.InputBorder,
                Thickness  = 1,
                Parent     = boxBG,
            })

            local box = New("TextBox", {
                Text             = def,
                PlaceholderText  = place,
                PlaceholderColor3= T.InputPlaceholder,
                Size             = UDim2.new(1,-12,1,0),
                Position         = UDim2.new(0,6,0,0),
                BackgroundTransparency = 1,
                TextColor3       = T.InputText,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                TextXAlignment   = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                ZIndex           = 15,
                Parent           = boxBG,
            })
            box.Focused:Connect(function()
                Tween(stroke2, TI.Fast, {Color=T.InputFocus})
            end)
            box.FocusLost:Connect(function(enter)
                Tween(stroke2, TI.Fast, {Color=T.InputBorder})
                local val = box.Text
                if numOnly then
                    local n = tonumber(val) or 0
                    box.Text = tostring(n)
                    val = n
                end
                if cb then cb(val, enter) end
            end)
            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}) end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}) end)
            return box
        end

        -- ── KEYBIND ───────────────────────────────────────────
        function Tab:Keybind(cfg2)
            cfg2 = cfg2 or {}
            local name2 = cfg2.Name    or "Keybind"
            local def   = cfg2.Default or Enum.KeyCode.F
            local cb    = cfg2.Callback

            local row   = Row(44)
            RowLabel(row, name2, 12, 14, (Panel.AbsoluteSize.X - 200 - 100), 18, true)

            local current  = def
            local listening = false

            local kbBtn = New("TextButton", {
                Text             = tostring(def.Name or def):gsub("Enum.KeyCode.", ""),
                Size             = UDim2.new(0,80,0,26),
                Position         = UDim2.new(1,-92,0.5,-13),
                BackgroundColor3 = T.InputBG,
                TextColor3       = T.Accent,
                Font             = Enum.Font.GothamBold,
                TextSize         = 11,
                BorderSizePixel  = 0,
                ZIndex           = 15,
                Parent           = row,
            })
            Corner(kbBtn, 6)
            Stroke(kbBtn, T.RowBorder, 1, 0)

            kbBtn.MouseButton1Click:Connect(function()
                listening    = true
                kbBtn.Text   = "..."
                kbBtn.TextColor3 = T.LabelText
            end)
            UserInputService.InputBegan:Connect(function(input, gp)
                if listening and not gp and input.UserInputType == Enum.UserInputType.Keyboard then
                    listening      = false
                    current        = input.KeyCode
                    kbBtn.Text     = tostring(input.KeyCode.Name)
                    kbBtn.TextColor3 = T.Accent
                    if cb then cb(input.KeyCode) end
                end
            end)

            local obj = {}
            function obj:Get() return current end
            return obj
        end

        -- ── MULTITOGGLE GROUP ─────────────────────────────────
        function Tab:MultiToggleGroup(cfg2)
            cfg2 = cfg2 or {}
            local name2   = cfg2.Name     or "Mode"
            local opts    = cfg2.Options  or {}
            local def     = cfg2.Default  or opts[1]
            local cb      = cfg2.Callback

            local rh  = 56
            local row = Row(rh)
            RowLabel(row, name2, 12, 6, (Panel.AbsoluteSize.X - 200 - 30), 18, true)

            local btnW    = math.floor(((Panel.AbsoluteSize.X - 200 - 24 - (4*(#opts-1))) / math.max(#opts,1)))
            local buttons = {}
            local selected = def
            local obj      = { Value = def }

            local strip = New("Frame", {
                Size             = UDim2.new(1,-24,0,26),
                Position         = UDim2.new(0,12,0,26),
                BackgroundColor3 = T.ToggleOFF,
                BorderSizePixel  = 0,
                ZIndex           = 14,
                Parent           = row,
            })
            Corner(strip, 6)

            New("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding       = UDim.new(0,2),
                Parent        = strip,
            })
            Pad(strip, 2,2,2,2)

            local function RefreshBtns()
                for _, b in ipairs(buttons) do
                    local active = (b._opt == selected)
                    Tween(b, TI.Fast, {
                        BackgroundColor3 = active and T.ToggleON or Color3.fromRGB(0,0,0),
                        BackgroundTransparency = active and 0 or 1,
                        TextColor3       = active and Color3.fromRGB(20,18,12) or T.DescText,
                    })
                end
            end

            for _, opt in ipairs(opts) do
                local b = New("TextButton", {
                    Text             = opt,
                    Size             = UDim2.new(1/#opts,-2,1,0),
                    BackgroundColor3 = opt == def and T.ToggleON or Color3.fromRGB(0,0,0),
                    BackgroundTransparency = opt == def and 0 or 1,
                    TextColor3       = opt == def and Color3.fromRGB(20,18,12) or T.DescText,
                    Font             = Enum.Font.GothamBold,
                    TextSize         = 10,
                    BorderSizePixel  = 0,
                    ZIndex           = 15,
                    Parent           = strip,
                })
                Corner(b, 5)
                b._opt = opt
                table.insert(buttons, b)
                b.MouseButton1Click:Connect(function()
                    selected  = opt
                    obj.Value = opt
                    RefreshBtns()
                    if cb then cb(opt) end
                end)
            end

            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}) end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}) end)

            function obj:Set(v)  selected=v; obj.Value=v; RefreshBtns() end
            function obj:Get()   return selected end
            return obj
        end

        -- ── COLOR DISPLAY ─────────────────────────────────────
        function Tab:ColorDisplay(cfg2)
            cfg2 = cfg2 or {}
            local row = Row(44)
            RowLabel(row, cfg2.Name or "Color", 12, 14, (Panel.AbsoluteSize.X - 200 - 70), 18, true)
            local swatch = New("Frame", {
                Size             = UDim2.new(0,36,0,22),
                Position         = UDim2.new(1,-48,0.5,-11),
                BackgroundColor3 = cfg2.Color or Color3.fromRGB(0,120,212),
                BorderSizePixel  = 0,
                ZIndex           = 14,
                Parent           = row,
            })
            Corner(swatch, 5)
            Stroke(swatch, T.RowBorder, 1, 0)
        end

        return Tab
    end -- CreateTab

    -- ── WinObj helpers ────────────────────────────────────────
    function WinObj:SetTitle(t) end -- placeholder
    function WinObj:Destroy()  SG:Destroy() end

    return WinObj
end -- CreateWindow

-- ── Return module ─────────────────────────────────────────────
return KyxUI
