-- ╔══════════════════════════════════════════════════════════╗
-- ║               Kyx_UI                                    ║
-- ║         Fluent Design · Windows 11 Aesthetic            ║
-- ║                   Version 1.1.0                         ║
-- ║  + Theme Switcher  + SearchBox  + Dialog                ║
-- ║  + Badge on Tabs   + ProgressBar                        ║
-- ╚══════════════════════════════════════════════════════════╝
--
-- USAGE:
--   local KyxUI = loadstring(game:HttpGet("URL"))()
--   local Window = KyxUI:CreateWindow({ Title="My Hub", SubTitle="v1.0" })
--   local Tab = Window:CreateTab("Farm", nil, { Badge="NEW" })
--   Tab:Section("Auto Farm")
--   Tab:Toggle({ Name="Auto Farm", Default=false, Callback=function(v) end })
--   Tab:Button({ Name="Hop Server", Callback=function() end })
--   Tab:Slider({ Name="Speed", Min=1, Max=100, Default=50, Callback=function(v) end })
--   Tab:Dropdown({ Name="Weapon", Options={"Melee","Sword"}, Default="Melee", Callback=function(v) end })
--   Tab:Input({ Name="Value", PlaceholderText="...", Callback=function(v) end })
--   Tab:ProgressBar({ Name="EXP", Value=75, Max=100, Color=Color3.fromRGB(0,120,212) })
--   Tab:Label("ข้อความ")
--   Tab:Separator()
--   KyxUI:Notify({ Title="Done!", Content="สำเร็จ", Duration=3 })
--   KyxUI:Dialog({ Title="ยืนยัน?", Content="ต้องการดำเนินการ?", OnConfirm=function() end })
--   KyxUI:SetTheme("Dark")   -- "Light" | "Dark"

local KyxUI    = {}
KyxUI.__index  = KyxUI

-- ============================================================
--  SERVICES
-- ============================================================
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local CoreGui           = game:GetService("CoreGui")
local TextService       = game:GetService("TextService")

-- ============================================================
--  THEME  (WindUI / Fluent — Light variant with dark sidebar)
-- ============================================================
local T = {
    -- Window
    WindowBG        = Color3.fromRGB(243, 243, 243),
    WindowBorder    = Color3.fromRGB(200, 200, 200),
    TitleBG         = Color3.fromRGB(255, 255, 255),
    TitleText       = Color3.fromRGB(28,  28,  28),
    SubTitleText    = Color3.fromRGB(120, 120, 120),

    -- Sidebar
    SidebarBG       = Color3.fromRGB(238, 238, 238),
    SidebarBorder   = Color3.fromRGB(218, 218, 218),
    TabBtn          = Color3.fromRGB(238, 238, 238),
    TabBtnHov       = Color3.fromRGB(228, 228, 228),
    TabBtnActive    = Color3.fromRGB(255, 255, 255),
    TabText         = Color3.fromRGB(100, 100, 100),
    TabTextActive   = Color3.fromRGB(28,  28,  28),
    TabIndicator    = Color3.fromRGB(0,   120, 212),

    -- Panel
    PanelBG         = Color3.fromRGB(249, 249, 249),
    SectionText     = Color3.fromRGB(0,   120, 212),
    SectionLine     = Color3.fromRGB(0,   120, 212),

    -- Element row
    RowBG           = Color3.fromRGB(255, 255, 255),
    RowBorder       = Color3.fromRGB(220, 220, 220),
    RowHov          = Color3.fromRGB(245, 245, 245),
    LabelText       = Color3.fromRGB(28,  28,  28),
    DescText        = Color3.fromRGB(130, 130, 130),
    SeparatorLine   = Color3.fromRGB(220, 220, 220),

    -- Toggle
    ToggleON        = Color3.fromRGB(0,   120, 212),
    ToggleOFF       = Color3.fromRGB(180, 180, 180),
    ToggleBall      = Color3.fromRGB(255, 255, 255),

    -- Slider
    SliderFill      = Color3.fromRGB(0,   120, 212),
    SliderTrack     = Color3.fromRGB(210, 210, 210),
    SliderThumb     = Color3.fromRGB(255, 255, 255),
    SliderValue     = Color3.fromRGB(80,  80,  80),

    -- Button
    BtnBG           = Color3.fromRGB(255, 255, 255),
    BtnBorder       = Color3.fromRGB(200, 200, 200),
    BtnHov          = Color3.fromRGB(235, 235, 235),
    BtnPress        = Color3.fromRGB(220, 220, 220),
    BtnText         = Color3.fromRGB(28,  28,  28),
    BtnAccent       = Color3.fromRGB(0,   120, 212),
    BtnAccentHov    = Color3.fromRGB(16,  110, 190),
    BtnAccentText   = Color3.fromRGB(255, 255, 255),

    -- Dropdown
    DropBG          = Color3.fromRGB(255, 255, 255),
    DropBorder      = Color3.fromRGB(200, 200, 200),
    DropItemHov     = Color3.fromRGB(230, 240, 255),
    DropItemActive  = Color3.fromRGB(0,   120, 212),
    DropText        = Color3.fromRGB(28,  28,  28),

    -- Input
    InputBG         = Color3.fromRGB(255, 255, 255),
    InputBorder     = Color3.fromRGB(200, 200, 200),
    InputFocus      = Color3.fromRGB(0,   120, 212),
    InputText       = Color3.fromRGB(28,  28,  28),
    InputPlaceholder= Color3.fromRGB(160, 160, 160),

    -- Notification
    NotifBG         = Color3.fromRGB(255, 255, 255),
    NotifBorder     = Color3.fromRGB(200, 200, 200),
    NotifTitle      = Color3.fromRGB(28,  28,  28),
    NotifContent    = Color3.fromRGB(100, 100, 100),
    NotifAccent     = Color3.fromRGB(0,   120, 212),
    NotifSuccess    = Color3.fromRGB(16,  124, 16),
    NotifWarning    = Color3.fromRGB(200, 100, 0),
    NotifError      = Color3.fromRGB(196, 43,  28),

    -- Shadow/Misc
    Shadow          = Color3.fromRGB(0, 0, 0),
    CloseHov        = Color3.fromRGB(196, 43, 28),
    MinHov          = Color3.fromRGB(200, 200, 200),
    Accent          = Color3.fromRGB(0, 120, 212),
}

-- ============================================================
--  TRANSPARENCY CONFIG
-- ============================================================
-- ค่า transparency ของ background UI ทั้งหมด (0=ทึบ, 1=โปร่งใส)
local BG_ALPHA = 0.4

-- Classes ที่จะถูกใส่ BG_ALPHA อัตโนมัติ
local APPLY_ALPHA = { Frame=true, ScrollingFrame=true, TextButton=true, TextBox=true }

-- ============================================================
--  UTIL HELPERS
-- ============================================================
local function New(class, props, children)
    local obj = Instance.new(class)
    -- ใส่ BG_ALPHA อัตโนมัติ ถ้าเป็น solid element และยังไม่ได้กำหนดไว้
    if APPLY_ALPHA[class] and (not props or props.BackgroundTransparency == nil) then
        obj.BackgroundTransparency = BG_ALPHA
    end
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then obj[k] = v end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = obj
    end
    if props and props.Parent then obj.Parent = props.Parent end
    return obj
end

local function Tween(obj, info, props)
    return TweenService:Create(obj, info, props)
end

local TI = {
    Fast    = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Medium  = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Slow    = TweenInfo.new(0.4,  Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    Spring  = TweenInfo.new(0.35, Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
    Bounce  = TweenInfo.new(0.3,  Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
}

local function Shadow(parent, size, transparency)
    local sh = New("ImageLabel", {
        Name                  = "_Shadow",
        AnchorPoint           = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position              = UDim2.new(0.5, 0, 0.5, 0),
        Size                  = UDim2.new(1, size or 30, 1, size or 30),
        ZIndex                = (parent.ZIndex or 1) - 1,
        Image                 = "rbxassetid://6015897843",
        ImageColor3           = T.Shadow,
        ImageTransparency     = transparency or 0.82,
        ScaleType             = Enum.ScaleType.Slice,
        SliceCenter           = Rect.new(49, 49, 450, 450),
        Parent                = parent,
    })
    return sh
end

local function MakeCorner(parent, r)
    return New("UICorner", { CornerRadius=UDim.new(0, r or 8), Parent=parent })
end

local function MakeStroke(parent, color, thickness, transparency)
    return New("UIStroke", {
        Color        = color or T.RowBorder,
        Thickness    = thickness or 1,
        Transparency = transparency or 0,
        Parent       = parent,
    })
end

local function MakePadding(parent, top, bottom, left, right)
    return New("UIPadding", {
        PaddingTop    = UDim.new(0, top    or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft   = UDim.new(0, left   or 0),
        PaddingRight  = UDim.new(0, right  or 0),
        Parent        = parent,
    })
end

-- ============================================================
--  NOTIFICATION SYSTEM  (ScreenGui แยก)
-- ============================================================
local NotifGui = New("ScreenGui", {
    Name             = "KyxUI_Notifications",
    ResetOnSpawn     = false,
    ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
    Parent           = CoreGui,
})

local NotifContainer = New("Frame", {
    Name                   = "Container",
    AnchorPoint            = Vector2.new(1, 1),
    Position               = UDim2.new(1, -16, 1, -16),
    Size                   = UDim2.new(0, 320, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel        = 0,
    Parent                 = NotifGui,
})

local NotifList = New("UIListLayout", {
    Padding           = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment   = Enum.VerticalAlignment.Bottom,
    SortOrder           = Enum.SortOrder.LayoutOrder,
    Parent              = NotifContainer,
})

function KyxUI:Notify(config)
    config = config or {}
    local title    = config.Title    or "Notification"
    local content  = config.Content  or ""
    local duration = config.Duration or 3
    local notifType= config.Type     or "Info" -- Info, Success, Warning, Error

    local accentColor = T.NotifAccent
    if notifType == "Success" then accentColor = T.NotifSuccess
    elseif notifType == "Warning" then accentColor = T.NotifWarning
    elseif notifType == "Error"   then accentColor = T.NotifError end

    local icon = "ℹ"
    if notifType == "Success" then icon = "✓"
    elseif notifType == "Warning" then icon = "⚠"
    elseif notifType == "Error"   then icon = "✕" end

    -- Card
    local card = New("Frame", {
        Name                   = "Notif",
        Size                   = UDim2.new(1, 0, 0, 72),
        BackgroundColor3       = T.NotifBG,
        BorderSizePixel        = 0,
        ClipsDescendants       = true,
        Parent                 = NotifContainer,
    })
    MakeCorner(card, 10)
    MakeStroke(card, T.NotifBorder, 1, 0)
    Shadow(card, 20, 0.88)

    -- Accent bar (left)
    New("Frame", {
        Size             = UDim2.new(0, 4, 1, 0),
        BackgroundColor3 = accentColor,
        BorderSizePixel  = 0,
        Parent           = card,
    })
    MakeCorner(_, 2)

    -- Icon
    New("TextLabel", {
        Text                   = icon,
        Size                   = UDim2.new(0, 32, 0, 32),
        Position               = UDim2.new(0, 14, 0.5, -16),
        BackgroundTransparency = 1,
        TextColor3             = accentColor,
        Font                   = Enum.Font.GothamBold,
        TextSize               = 18,
        Parent                 = card,
    })

    -- Title
    New("TextLabel", {
        Text                   = title,
        Size                   = UDim2.new(1, -60, 0, 20),
        Position               = UDim2.new(0, 52, 0, 14),
        BackgroundTransparency = 1,
        TextColor3             = T.NotifTitle,
        Font                   = Enum.Font.GothamBold,
        TextSize               = 13,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = card,
    })

    -- Content
    New("TextLabel", {
        Text                   = content,
        Size                   = UDim2.new(1, -60, 0, 24),
        Position               = UDim2.new(0, 52, 0, 36),
        BackgroundTransparency = 1,
        TextColor3             = T.NotifContent,
        Font                   = Enum.Font.Gotham,
        TextSize               = 11,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextWrapped            = true,
        Parent                 = card,
    })

    -- Progress bar
    local progressBG = New("Frame", {
        Size             = UDim2.new(1, 0, 0, 3),
        Position         = UDim2.new(0, 0, 1, -3),
        BackgroundColor3 = T.SeparatorLine,
        BorderSizePixel  = 0,
        Parent           = card,
    })
    local progressFill = New("Frame", {
        Size             = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = accentColor,
        BorderSizePixel  = 0,
        Parent           = progressBG,
    })

    -- Animate in
    card.Position = UDim2.new(1, 20, 0, 0)
    Tween(card, TI.Spring, {Position = UDim2.new(0, 0, 0, 0)}):Play()

    -- Progress countdown
    Tween(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

    -- Dismiss
    task.delay(duration, function()
        Tween(card, TI.Medium, {Position = UDim2.new(1, 20, 0, 0)}):Play()
        task.wait(0.3)
        card:Destroy()
    end)

    return card
end


-- ============================================================
--  UPDATE 1 — DIALOG (Modal confirm popup)
-- ============================================================
--  KyxUI:Dialog({ Title, Content, Confirm, Cancel, OnConfirm, OnCancel })
-- ============================================================
local DialogGui = New("ScreenGui", {
    Name           = "KyxUI_Dialog",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent         = CoreGui,
})

function KyxUI:Dialog(config)
    config = config or {}
    local dTitle   = config.Title     or "ยืนยัน?"
    local dContent = config.Content   or "ต้องการดำเนินการนี้?"
    local dConfirm = config.Confirm   or "ยืนยัน"
    local dCancel  = config.Cancel    or "ยกเลิก"
    local onConfirm= config.OnConfirm
    local onCancel = config.OnCancel

    -- Backdrop
    local backdrop = New("Frame", {
        Size                   = UDim2.new(1,0,1,0),
        BackgroundColor3       = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.55,
        BorderSizePixel        = 0,
        ZIndex                 = 200,
        Parent                 = DialogGui,
    })

    -- Card
    local card = New("Frame", {
        Size             = UDim2.new(0,360,0,180),
        AnchorPoint      = Vector2.new(0.5,0.5),
        Position         = UDim2.new(0.5,0,0.5,0),
        BackgroundColor3 = T.WindowBG,
        BorderSizePixel  = 0,
        ZIndex           = 201,
        Parent           = DialogGui,
    })
    MakeCorner(card, 12)
    MakeStroke(card, T.WindowBorder, 1, 0)
    Shadow(card, 40, 0.65)

    -- Title
    New("TextLabel", {
        Text           = dTitle,
        Size           = UDim2.new(1,-32,0,22),
        Position       = UDim2.new(0,16,0,18),
        BackgroundTransparency = 1,
        TextColor3     = T.TitleText,
        Font           = Enum.Font.GothamBold,
        TextSize       = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex         = 202,
        Parent         = card,
    })

    -- Content
    New("TextLabel", {
        Text           = dContent,
        Size           = UDim2.new(1,-32,0,60),
        Position       = UDim2.new(0,16,0,46),
        BackgroundTransparency = 1,
        TextColor3     = T.DescText,
        Font           = Enum.Font.Gotham,
        TextSize       = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped    = true,
        ZIndex         = 202,
        Parent         = card,
    })

    -- Divider
    New("Frame", {
        Size             = UDim2.new(1,0,0,1),
        Position         = UDim2.new(0,0,0,118),
        BackgroundColor3 = T.SeparatorLine,
        BorderSizePixel  = 0,
        ZIndex           = 202,
        Parent           = card,
    })

    local function CloseDialog()
        Tween(backdrop, TI.Fast, {BackgroundTransparency=1}):Play()
        Tween(card, TI.Fast, {Size=UDim2.new(0,360,0,0), BackgroundTransparency=1}):Play()
        task.delay(0.2, function()
            backdrop:Destroy()
            card:Destroy()
        end)
    end

    -- Cancel button
    local cancelBtn = New("TextButton", {
        Text             = dCancel,
        Size             = UDim2.new(0.5,-1,0,40),
        Position         = UDim2.new(0,0,0,119),
        BackgroundColor3 = T.RowBG,
        TextColor3       = T.LabelText,
        Font             = Enum.Font.GothamBold,
        TextSize         = 12,
        BorderSizePixel  = 0,
        ZIndex           = 202,
        Parent           = card,
    })
    New("UICorner", {CornerRadius=UDim.new(0,12), Parent=cancelBtn})
    cancelBtn.MouseEnter:Connect(function() Tween(cancelBtn,TI.Fast,{BackgroundColor3=T.RowHov}):Play() end)
    cancelBtn.MouseLeave:Connect(function() Tween(cancelBtn,TI.Fast,{BackgroundColor3=T.RowBG}):Play() end)
    cancelBtn.MouseButton1Click:Connect(function()
        CloseDialog()
        if onCancel then onCancel() end
    end)

    -- Confirm button
    local confirmBtn = New("TextButton", {
        Text             = dConfirm,
        Size             = UDim2.new(0.5,-1,0,40),
        Position         = UDim2.new(0.5,1,0,119),
        BackgroundColor3 = T.Accent,
        TextColor3       = Color3.fromRGB(255,255,255),
        Font             = Enum.Font.GothamBold,
        TextSize         = 12,
        BorderSizePixel  = 0,
        ZIndex           = 202,
        Parent           = card,
    })
    New("UICorner", {CornerRadius=UDim.new(0,12), Parent=confirmBtn})
    confirmBtn.MouseEnter:Connect(function() Tween(confirmBtn,TI.Fast,{BackgroundColor3=T.BtnAccentHov}):Play() end)
    confirmBtn.MouseLeave:Connect(function() Tween(confirmBtn,TI.Fast,{BackgroundColor3=T.Accent}):Play() end)
    confirmBtn.MouseButton1Click:Connect(function()
        CloseDialog()
        if onConfirm then onConfirm() end
    end)

    -- Open animation
    card.Size = UDim2.new(0,360,0,0)
    backdrop.BackgroundTransparency = 1
    Tween(backdrop, TI.Medium, {BackgroundTransparency=0.55}):Play()
    Tween(card, TI.Spring, {Size=UDim2.new(0,360,0,180), BackgroundTransparency=BG_ALPHA}):Play()
end

-- ============================================================
--  DROPDOWN OVERLAY  (shared)
-- ============================================================
local DDGui = New("ScreenGui", {
    Name           = "KyxUI_DDOverlay",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent         = CoreGui,
})

local DDOverlay = New("Frame", {
    Size                   = UDim2.new(1,0,1,0),
    BackgroundTransparency = 1,
    BorderSizePixel        = 0,
    ZIndex                 = 100,
    Visible                = false,
    Parent                 = DDGui,
})

local ActiveDD = nil

local function CloseDD()
    if ActiveDD then ActiveDD:Destroy(); ActiveDD = nil end
    DDOverlay.Visible = false
end

DDOverlay.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then CloseDD() end
end)

-- ============================================================
--  CREATE WINDOW
-- ============================================================
function KyxUI:CreateWindow(config)
    config       = config or {}
    local Title  = config.Title    or "Kyx UI"
    local Sub    = config.SubTitle or "v1.0"
    local Key    = config.KeyCode  or Enum.KeyCode.RightShift
    local W      = config.Width    or 660
    local H      = config.Height   or 480
    local Icon   = config.Icon     or nil  -- rbxassetid

    local MainSize = UDim2.new(0, W, 0, H)

    -- ScreenGui
    local SG = New("ScreenGui", {
        Name           = "KyxUI_"..Title,
        ResetOnSpawn   = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent         = CoreGui,
    })

    -- Main Frame (Acrylic-like window)
    local MF = New("Frame", {
        Name             = "Window",
        Size             = MainSize,
        Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
        BackgroundColor3 = T.WindowBG,
        BorderSizePixel  = 0,
        ClipsDescendants = false,
        Parent           = SG,
    })
    MakeCorner(MF, 12)
    MakeStroke(MF, T.WindowBorder, 1, 0)
    Shadow(MF, 40, 0.7)

    -- Clip inner
    local MFClip = New("Frame", {
        Size             = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent           = MF,
    })
    MakeCorner(MFClip, 12)

    -- ── Title Bar ──────────────────────────────────────────
    local TitleBar = New("Frame", {
        Name             = "TitleBar",
        Size             = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = T.TitleBG,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = MFClip,
    })

    -- Bottom border of title bar
    New("Frame", {
        Size             = UDim2.new(1,0,0,1),
        Position         = UDim2.new(0,0,1,-1),
        BackgroundColor3 = T.WindowBorder,
        BorderSizePixel  = 0,
        ZIndex           = 4,
        Parent           = TitleBar,
    })

    -- Window icon
    local xOffset = 14
    if Icon then
        New("ImageLabel", {
            Size                   = UDim2.new(0,20,0,20),
            Position               = UDim2.new(0,14,0.5,-10),
            BackgroundTransparency = 1,
            Image                  = Icon,
            ZIndex                 = 4,
            Parent                 = TitleBar,
        })
        xOffset = 40
    end

    New("TextLabel", {
        Text           = Title,
        Size           = UDim2.new(0,200,0,20),
        Position       = UDim2.new(0, xOffset, 0.5, -10),
        BackgroundTransparency = 1,
        TextColor3     = T.TitleText,
        Font           = Enum.Font.GothamBold,
        TextSize       = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex         = 4,
        Parent         = TitleBar,
    })

    New("TextLabel", {
        Text           = Sub,
        Size           = UDim2.new(0,200,0,14),
        Position       = UDim2.new(0, xOffset, 0.5, 8),
        BackgroundTransparency = 1,
        TextColor3     = T.SubTitleText,
        Font           = Enum.Font.Gotham,
        TextSize       = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex         = 4,
        Parent         = TitleBar,
    })

    -- Window Control Buttons (Win11 style)
    local function WinBtn(text, xPos, hoverColor, textColor)
        local btn = New("TextButton", {
            Text             = text,
            Size             = UDim2.new(0, 46, 1, 0),
            Position         = UDim2.new(1, xPos, 0, 0),
            BackgroundColor3 = T.TitleBG,
            TextColor3       = textColor or T.TitleText,
            Font             = Enum.Font.Gotham,
            TextSize         = 10,
            BorderSizePixel  = 0,
            ZIndex           = 5,
            Parent           = TitleBar,
        })
        btn.MouseEnter:Connect(function()
            Tween(btn, TI.Fast, {BackgroundColor3=hoverColor}):Play()
            if textColor then Tween(btn, TI.Fast, {TextColor3=Color3.fromRGB(255,255,255)}):Play() end
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, TI.Fast, {BackgroundColor3=T.TitleBG}):Play()
            if textColor then Tween(btn, TI.Fast, {TextColor3=textColor}):Play() end
        end)
        return btn
    end

    local CloseBtn = WinBtn("✕", -46, T.CloseHov, Color3.fromRGB(196,43,28))
    local MinBtn   = WinBtn("─", -92, T.MinHov)

    -- Make close button rounded right corners only
    New("UICorner", { CornerRadius=UDim.new(0,12), Parent=CloseBtn })

    -- ── Body ──────────────────────────────────────────────
    local Body = New("Frame", {
        Name             = "Body",
        Size             = UDim2.new(1,0,1,-48),
        Position         = UDim2.new(0,0,0,48),
        BackgroundTransparency = 1,
        Parent           = MFClip,
    })

    -- ── Sidebar ────────────────────────────────────────────
    local Sidebar = New("Frame", {
        Name             = "Sidebar",
        Size             = UDim2.new(0, 200, 1, 0),
        BackgroundColor3 = T.SidebarBG,
        BorderSizePixel  = 0,
        Parent           = Body,
    })

    -- Sidebar right border
    New("Frame", {
        Size             = UDim2.new(0,1,1,0),
        Position         = UDim2.new(1,-1,0,0),
        BackgroundColor3 = T.SidebarBorder,
        BorderSizePixel  = 0,
        Parent           = Sidebar,
    })

    local SidebarScroll = New("ScrollingFrame", {
        Size             = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        ScrollBarThickness = 0,
        CanvasSize       = UDim2.new(0,0,0,0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent           = Sidebar,
    })

    local SidebarList = New("UIListLayout", {
        Padding           = UDim.new(0,2),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder         = Enum.SortOrder.LayoutOrder,
        Parent            = SidebarScroll,
    })
    MakePadding(SidebarScroll, 8, 8, 8, 8)

    -- ── Panel ──────────────────────────────────────────────
    local Panel = New("Frame", {
        Name             = "Panel",
        Size             = UDim2.new(1,-200,1,0),
        Position         = UDim2.new(0,200,0,0),
        BackgroundColor3 = T.PanelBG,
        BorderSizePixel  = 0,
        Parent           = Body,
    })

    -- ── TAB SYSTEM ─────────────────────────────────────────
    local TabPages = {}
    local ActiveTabName = nil

    local WinObj = {}

    function WinObj:CreateTab(name, icon)
        -- Sidebar button
        local tabBtn = New("TextButton", {
            Text             = "",
            Size             = UDim2.new(1,0,0,40),
            BackgroundColor3 = T.TabBtn,
            BorderSizePixel  = 0,
            ZIndex           = 2,
            Parent           = SidebarScroll,
        })
        MakeCorner(tabBtn, 8)

        -- Active indicator bar
        local indicator = New("Frame", {
            Size             = UDim2.new(0, 3, 0, 20),
            Position         = UDim2.new(0, 0, 0.5, -10),
            BackgroundColor3 = T.TabIndicator,
            BorderSizePixel  = 0,
            BackgroundTransparency = 1,
            ZIndex           = 3,
            Parent           = tabBtn,
        })
        MakeCorner(indicator, 99)

        -- Icon
        local iconLbl = nil
        local textX = 14
        if icon then
            iconLbl = New("ImageLabel", {
                Size                   = UDim2.new(0,18,0,18),
                Position               = UDim2.new(0,14,0.5,-9),
                BackgroundTransparency = 1,
                Image                  = icon,
                ImageColor3            = T.TabText,
                ZIndex                 = 3,
                Parent                 = tabBtn,
            })
            textX = 38
        end

        local tabLabel = New("TextLabel", {
            Text           = name,
            Size           = UDim2.new(1,-textX-8,1,0),
            Position       = UDim2.new(0,textX,0,0),
            BackgroundTransparency = 1,
            TextColor3     = T.TabText,
            Font           = Enum.Font.Gotham,
            TextSize       = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex         = 3,
            Parent         = tabBtn,
        })

        -- Page (ScrollingFrame inside Panel)
        local page = New("ScrollingFrame", {
            Name                   = "Page_"..name,
            Size                   = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            BorderSizePixel        = 0,
            Visible                = false,
            ScrollBarThickness     = 4,
            ScrollBarImageColor3   = Color3.fromRGB(180,180,180),
            CanvasSize             = UDim2.new(0,0,0,0),
            AutomaticCanvasSize    = Enum.AutomaticSize.Y,
            ScrollingDirection     = Enum.ScrollingDirection.Y,
            Parent                 = Panel,
        })
        New("UIListLayout", {
            Padding             = UDim.new(0,6),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder           = Enum.SortOrder.LayoutOrder,
            Parent              = page,
        })
        MakePadding(page, 12, 16, 14, 14)

        TabPages[name] = { Btn=tabBtn, Page=page, Indicator=indicator, Label=tabLabel, Icon=iconLbl }

        local function Activate()
            -- Deactivate all
            for _, t in pairs(TabPages) do
                Tween(t.Btn,       TI.Fast, {BackgroundColor3=T.TabBtn}):Play()
                Tween(t.Label,     TI.Fast, {TextColor3=T.TabText, Font=Enum.Font.Gotham}):Play()
                Tween(t.Indicator, TI.Fast, {BackgroundTransparency=1}):Play()
                if t.Icon then Tween(t.Icon, TI.Fast, {ImageColor3=T.TabText}):Play() end
                t.Page.Visible = false
            end
            -- Activate this
            Tween(tabBtn,    TI.Fast, {BackgroundColor3=T.TabBtnActive}):Play()
            Tween(tabLabel,  TI.Fast, {TextColor3=T.TabTextActive}):Play()
            Tween(indicator, TI.Bounce, {BackgroundTransparency=0}):Play()
            if iconLbl then Tween(iconLbl, TI.Fast, {ImageColor3=T.TabIndicator}):Play() end
            page.Visible = true
            ActiveTabName = name
        end

        tabBtn.MouseButton1Click:Connect(Activate)
        tabBtn.MouseEnter:Connect(function()
            if ActiveTabName ~= name then
                Tween(tabBtn, TI.Fast, {BackgroundColor3=T.TabBtnHov}):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if ActiveTabName ~= name then
                Tween(tabBtn, TI.Fast, {BackgroundColor3=T.TabBtn}):Play()
            end
        end)

        if not ActiveTabName then Activate() end

        -- ── TAB OBJECT ────────────────────────────────────
        local Tab = {}

        -- ── SECTION ──
        function Tab:Section(text)
            local sec = New("Frame", {
                Size             = UDim2.new(1,0,0,28),
                BackgroundTransparency = 1,
                Parent           = page,
            })
            New("TextLabel", {
                Text           = text:upper(),
                Size           = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                TextColor3     = T.SectionText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = sec,
            })
            New("Frame", {
                Size             = UDim2.new(1,0,0,1),
                Position         = UDim2.new(0,0,1,-1),
                BackgroundColor3 = T.SectionLine,
                BackgroundTransparency = 0.8,
                BorderSizePixel  = 0,
                Parent           = sec,
            })
            return sec
        end

        -- ── SEPARATOR ──
        function Tab:Separator()
            New("Frame", {
                Size             = UDim2.new(1,0,0,1),
                BackgroundColor3 = T.SeparatorLine,
                BorderSizePixel  = 0,
                Parent           = page,
            })
        end


        -- ── ALERT (inline notification row) ──
        -- Type: "Info" | "Warning" | "Error" | "Success"
        -- Tab:Alert({ Type="Warning", Text="ข้อความ", Dismissible=true })
        function Tab:Alert(config)
            config = config or {}
            local aType  = config.Type        or "Info"
            local aText  = config.Text        or ""
            local aDismiss = config.Dismissible ~= false  -- default true

            local aColor = T.NotifAccent
            local aIcon  = "ℹ"
            if aType == "Success" then aColor = T.NotifSuccess; aIcon = "✓"
            elseif aType == "Warning" then aColor = T.NotifWarning; aIcon = "⚠"
            elseif aType == "Error"   then aColor = T.NotifError;   aIcon = "✕" end

            local alertBG = Color3.fromRGB(
                math.floor(aColor.R*255*0.12 + 243*0.88),
                math.floor(aColor.G*255*0.12 + 243*0.88),
                math.floor(aColor.B*255*0.12 + 243*0.88)
            )

            local row = New("Frame", {
                Size             = UDim2.new(1,0,0,44),
                BackgroundColor3 = alertBG,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                Parent           = page,
            })
            MakeCorner(row, 8)
            MakeStroke(row, aColor, 1, 0.5)
            MakePadding(row, 0, 0, 10, aDismiss and 36 or 10)

            -- Left accent bar
            New("Frame", {
                Size             = UDim2.new(0,3,1,0),
                BackgroundColor3 = aColor,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = row,
            })

            -- Icon
            New("TextLabel", {
                Text           = aIcon,
                Size           = UDim2.new(0,28,1,0),
                Position       = UDim2.new(0,8,0,0),
                BackgroundTransparency = 1,
                TextColor3     = aColor,
                Font           = Enum.Font.GothamBold,
                TextSize       = 14,
                ZIndex         = 2,
                Parent         = row,
            })

            -- Text
            local textLbl = New("TextLabel", {
                Text           = aText,
                Size           = UDim2.new(1,-40,1,0),
                Position       = UDim2.new(0,36,0,0),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.Gotham,
                TextSize       = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped    = true,
                ZIndex         = 2,
                Parent         = row,
            })

            -- Dismiss button
            if aDismiss then
                local closeBtn = New("TextButton", {
                    Text             = "✕",
                    Size             = UDim2.new(0,28,1,0),
                    Position         = UDim2.new(1,-28,0,0),
                    BackgroundTransparency = 1,
                    TextColor3       = T.DescText,
                    Font             = Enum.Font.GothamBold,
                    TextSize         = 10,
                    BorderSizePixel  = 0,
                    ZIndex           = 3,
                    Parent           = row,
                })
                closeBtn.MouseButton1Click:Connect(function()
                    Tween(row, TI.Medium, {Size=UDim2.new(1,0,0,0), BackgroundTransparency=1}):Play()
                    task.delay(0.25, function() row:Destroy() end)
                end)
            end

            local obj = {}
            function obj:SetText(t) textLbl.Text = t end
            function obj:Dismiss()
                Tween(row, TI.Medium, {Size=UDim2.new(1,0,0,0), BackgroundTransparency=1}):Play()
                task.delay(0.25, function() row:Destroy() end)
            end
            return obj
        end

        -- ── LABEL ──
        function Tab:Label(text)
            local lbl = New("TextLabel", {
                Text           = text or "",
                Size           = UDim2.new(1,0,0,24),
                BackgroundTransparency = 1,
                TextColor3     = T.DescText,
                Font           = Enum.Font.Gotham,
                TextSize       = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped    = true,
                Parent         = page,
            })
            return lbl
        end

        -- ── ROW BASE ──
        local function MakeRow(height)
            local row = New("Frame", {
                Size             = UDim2.new(1,0,0,height or 52),
                BackgroundColor3 = T.RowBG,
                BorderSizePixel  = 0,
                Parent           = page,
            })
            MakeCorner(row, 8)
            MakeStroke(row, T.RowBorder, 1, 0)
            MakePadding(row, 0, 0, 14, 14)
            return row
        end


        -- ── DISABLED STATE helper (shared) ──────────────────────
        -- returns a function: setDisabled(bool)
        -- called after creating the row + clickArea
        local function MakeDisabledOverlay(row, clickArea)
            local overlay = New("Frame", {
                Size             = UDim2.new(1,0,1,0),
                BackgroundColor3 = Color3.fromRGB(220,220,220),
                BackgroundTransparency = 1,
                BorderSizePixel  = 0,
                ZIndex           = 10,
                Parent           = row,
            })
            MakeCorner(overlay, 8)
            local disabled = false
            return function(v)
                disabled = v
                Tween(overlay, TI.Fast, {BackgroundTransparency = v and 0.4 or 1}):Play()
                clickArea.Active = not v
                clickArea.Interactable = not v
            end
        end

        -- ── TOGGLE ──
        function Tab:Toggle(config)
            config = config or {}
            local lName = config.Name     or "Toggle"
            local lDesc = config.Description
            local lDef  = config.Default  or false
            local lCB   = config.Callback

            local rowH = lDesc and 56 or 44
            local row  = MakeRow(rowH)

            -- Labels
            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-68,0,18),
                Position       = UDim2.new(0,0,0, lDesc and 10 or 13),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            if lDesc then
                New("TextLabel", {
                    Text           = lDesc,
                    Size           = UDim2.new(1,-68,0,14),
                    Position       = UDim2.new(0,0,0,30),
                    BackgroundTransparency = 1,
                    TextColor3     = T.DescText,
                    Font           = Enum.Font.Gotham,
                    TextSize       = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped    = true,
                    Parent         = row,
                })
            end

            -- Track
            local track = New("Frame", {
                Size             = UDim2.new(0,44,0,24),
                Position         = UDim2.new(1,-44,0.5,-12),
                BackgroundColor3 = lDef and T.ToggleON or T.ToggleOFF,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = row,
            })
            MakeCorner(track, 99)

            -- Ball
            local ball = New("Frame", {
                Size             = UDim2.new(0,18,0,18),
                Position         = lDef and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
                BackgroundColor3 = T.ToggleBall,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = track,
            })
            MakeCorner(ball, 99)
            Shadow(ball, 8, 0.85)

            local isOn = lDef
            local obj  = { Value = isOn }

            local clickArea = New("TextButton", {
                Size             = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text             = "",
                ZIndex           = 5,
                Parent           = row,
            })

            local function SetToggle(v, skipCB)
                isOn      = v
                obj.Value = v
                local ti = TI.Medium
                if v then
                    Tween(track, ti, {BackgroundColor3=T.ToggleON}):Play()
                    Tween(ball, TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position=UDim2.new(1,-21,0.5,-9)}):Play()
                else
                    Tween(track, ti, {BackgroundColor3=T.ToggleOFF}):Play()
                    Tween(ball, TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position=UDim2.new(0,3,0.5,-9)}):Play()
                end
                -- Press scale effect
                task.spawn(function()
                    Tween(ball, TweenInfo.new(0.08), {Size=UDim2.new(0,22,0,18)}):Play()
                    task.wait(0.08)
                    Tween(ball, TweenInfo.new(0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Size=UDim2.new(0,18,0,18)}):Play()
                end)
                if not skipCB and lCB then lCB(v) end
            end

            clickArea.MouseButton1Click:Connect(function() SetToggle(not isOn) end)
            clickArea.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            clickArea.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            local setDisabledToggle = MakeDisabledOverlay(row, clickArea)
            function obj:Set(v) SetToggle(v, false) end
            function obj:Get() return isOn end
            function obj:SetDisabled(v) setDisabledToggle(v) end

            return obj
        end

        -- ── BUTTON ──
        function Tab:Button(config)
            config = config or {}
            local lName  = config.Name     or "Button"
            local lDesc  = config.Description
            local lCB    = config.Callback
            local accent = config.Accent   or false  -- true = blue accent button

            local rowH = lDesc and 56 or 44
            local row  = MakeRow(rowH)
            local baseBG = accent and T.BtnAccent or T.BtnBG

            row.BackgroundColor3 = baseBG

            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-40,0,18),
                Position       = UDim2.new(0,0,0, lDesc and 10 or 13),
                BackgroundTransparency = 1,
                TextColor3     = accent and T.BtnAccentText or T.BtnText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            if lDesc then
                New("TextLabel", {
                    Text           = lDesc,
                    Size           = UDim2.new(1,-40,0,14),
                    Position       = UDim2.new(0,0,0,30),
                    BackgroundTransparency = 1,
                    TextColor3     = accent and Color3.fromRGB(200,220,255) or T.DescText,
                    Font           = Enum.Font.Gotham,
                    TextSize       = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent         = row,
                })
            end

            -- Chevron
            New("TextLabel", {
                Text           = "›",
                Size           = UDim2.new(0,20,1,0),
                Position       = UDim2.new(1,-20,0,0),
                BackgroundTransparency = 1,
                TextColor3     = accent and T.BtnAccentText or T.DescText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 16,
                Parent         = row,
            })

            local clickArea = New("TextButton", {
                Size             = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text             = "",
                ZIndex           = 5,
                Parent           = row,
            })

            clickArea.MouseEnter:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3=accent and T.BtnAccentHov or T.RowHov}):Play()
            end)
            clickArea.MouseLeave:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3=baseBG}):Play()
            end)
            clickArea.MouseButton1Down:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3=accent and Color3.fromRGB(0,100,180) or T.BtnPress}):Play()
            end)
            clickArea.MouseButton1Up:Connect(function()
                Tween(row, TI.Fast, {BackgroundColor3=baseBG}):Play()
            end)
            clickArea.MouseButton1Click:Connect(function()
                if lCB then lCB() end
            end)

            return row
        end

        -- ── SLIDER ──
        function Tab:Slider(config)
            config = config or {}
            local lName = config.Name     or "Slider"
            local lDesc = config.Description
            local lMin  = config.Min      or 0
            local lMax  = config.Max      or 100
            local lDef  = config.Default  or lMin
            local lSuffix = config.Suffix or ""
            local lCB   = config.Callback

            lDef = math.clamp(lDef, lMin, lMax)

            local rowH = lDesc and 70 or 60
            local row  = MakeRow(rowH)

            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-80,0,18),
                Position       = UDim2.new(0,0,0,10),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            if lDesc then
                New("TextLabel", {
                    Text           = lDesc,
                    Size           = UDim2.new(1,-80,0,12),
                    Position       = UDim2.new(0,0,0,28),
                    BackgroundTransparency = 1,
                    TextColor3     = T.DescText,
                    Font           = Enum.Font.Gotham,
                    TextSize       = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent         = row,
                })
            end

            local valLbl = New("TextLabel", {
                Text           = tostring(lDef)..lSuffix,
                Size           = UDim2.new(0,70,0,18),
                Position       = UDim2.new(1,-70,0,10),
                BackgroundTransparency = 1,
                TextColor3     = T.SliderValue,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent         = row,
            })

            -- Track
            local trackY = lDesc and 50 or 40
            local trackBG = New("Frame", {
                Size             = UDim2.new(1,0,0,6),
                Position         = UDim2.new(0,0,0,trackY),
                BackgroundColor3 = T.SliderTrack,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = row,
            })
            MakeCorner(trackBG, 99)

            local pct = (lDef - lMin) / (lMax - lMin)

            local trackFill = New("Frame", {
                Size             = UDim2.new(pct, 0, 1, 0),
                BackgroundColor3 = T.SliderFill,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = trackBG,
            })
            MakeCorner(trackFill, 99)

            local thumb = New("Frame", {
                Size             = UDim2.new(0,16,0,16),
                Position         = UDim2.new(pct,-8,0.5,-8),
                BackgroundColor3 = T.SliderThumb,
                BorderSizePixel  = 0,
                ZIndex           = 4,
                Parent           = trackBG,
            })
            MakeCorner(thumb, 99)
            MakeStroke(thumb, T.SliderFill, 2, 0)
            Shadow(thumb, 6, 0.88)

            local curVal  = lDef
            local dragging = false
            local obj      = { Value = curVal }

            local function SetSlider(v, skipCB)
                v = math.clamp(math.round(v), lMin, lMax)
                curVal    = v
                obj.Value = v
                local p = (v - lMin) / (lMax - lMin)
                Tween(trackFill, TI.Fast, {Size=UDim2.new(p,0,1,0)}):Play()
                Tween(thumb,     TI.Fast, {Position=UDim2.new(p,-8,0.5,-8)}):Play()
                valLbl.Text = tostring(v)..lSuffix
                if not skipCB and lCB then lCB(v) end
            end

            local sliderBtn = New("TextButton", {
                Size             = UDim2.new(1,0,0, rowH),
                Position         = UDim2.new(0,0,0,-trackY),
                BackgroundTransparency = 1,
                Text             = "",
                ZIndex           = 6,
                Parent           = trackBG,
            })

            sliderBtn.MouseButton1Down:Connect(function()
                dragging = true
                Tween(thumb, TI.Fast, {Size=UDim2.new(0,20,0,20), Position=UDim2.new(
                    (curVal-lMin)/(lMax-lMin),-10,0.5,-10)}):Play()
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    if dragging then
                        dragging = false
                        Tween(thumb, TI.Fast, {Size=UDim2.new(0,16,0,16)}):Play()
                    end
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local abs   = trackBG.AbsolutePosition
                    local width = trackBG.AbsoluteSize.X
                    local rel   = math.clamp((i.Position.X - abs.X) / width, 0, 1)
                    local val   = lMin + rel * (lMax - lMin)
                    SetSlider(val)
                end
            end)

            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            local setDisabledSlider = MakeDisabledOverlay(row, sliderBtn)
            function obj:Set(v) SetSlider(v, false) end
            function obj:Get() return curVal end
            function obj:SetDisabled(v) setDisabledSlider(v) end

            return obj
        end

        -- ── DROPDOWN ──
        function Tab:Dropdown(config)
            config = config or {}
            local lName    = config.Name        or "Dropdown"
            local lDesc    = config.Description
            local lOptions = config.Options      or {}
            local lDef     = config.Default      or (lOptions[1] or "เลือก...")
            local lCB      = config.Callback
            local lMulti   = config.MultiSelect  or false

            local rowH = lDesc and 56 or 44
            local row  = MakeRow(rowH)

            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-160,0,18),
                Position       = UDim2.new(0,0,0, lDesc and 10 or 13),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            if lDesc then
                New("TextLabel", {
                    Text           = lDesc,
                    Size           = UDim2.new(1,-160,0,14),
                    Position       = UDim2.new(0,0,0,30),
                    BackgroundTransparency = 1,
                    TextColor3     = T.DescText,
                    Font           = Enum.Font.Gotham,
                    TextSize       = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent         = row,
                })
            end

            local selected = lDef

            local dropBtn = New("TextButton", {
                Text             = tostring(selected).." ▾",
                Size             = UDim2.new(0,140,0,28),
                Position         = UDim2.new(1,-140,0.5,-14),
                BackgroundColor3 = T.InputBG,
                TextColor3       = T.LabelText,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = row,
            })
            MakeCorner(dropBtn, 6)
            MakeStroke(dropBtn, T.RowBorder, 1, 0)

            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            local obj = { Value = selected }

            dropBtn.MouseButton1Click:Connect(function()
                if ActiveDD then CloseDD(); return end

                DDOverlay.Visible = true
                local absPos  = dropBtn.AbsolutePosition
                local absSize = dropBtn.AbsoluteSize
                local count   = math.min(#lOptions, 7)

                local popup = New("Frame", {
                    Position         = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4),
                    Size             = UDim2.new(0, absSize.X, 0, count * 32 + 8),
                    BackgroundColor3 = T.DropBG,
                    BorderSizePixel  = 0,
                    ZIndex           = 110,
                    Parent           = DDOverlay,
                })
                MakeCorner(popup, 8)
                MakeStroke(popup, T.DropBorder, 1, 0)
                Shadow(popup, 16, 0.82)

                local sl = New("ScrollingFrame", {
                    Size                   = UDim2.new(1,-4,1,-4),
                    Position               = UDim2.new(0,2,0,2),
                    BackgroundTransparency = 1,
                    BorderSizePixel        = 0,
                    ScrollBarThickness     = 3,
                    ScrollBarImageColor3   = Color3.fromRGB(180,180,180),
                    CanvasSize             = UDim2.new(0,0,0,0),
                    AutomaticCanvasSize    = Enum.AutomaticSize.Y,
                    ZIndex                 = 111,
                    Parent                 = popup,
                })
                New("UIListLayout", { Padding=UDim.new(0,2), Parent=sl })
                MakePadding(sl, 4, 4, 4, 4)

                for _, opt in ipairs(lOptions) do
                    local isActive = (opt == selected)
                    local item = New("TextButton", {
                        Size             = UDim2.new(1,0,0,28),
                        BackgroundColor3 = isActive and T.DropItemActive or T.DropBG,
                        BorderSizePixel  = 0,
                        Text             = opt,
                        TextColor3       = isActive and Color3.fromRGB(255,255,255) or T.DropText,
                        Font             = isActive and Enum.Font.GothamBold or Enum.Font.Gotham,
                        TextSize         = 11,
                        ZIndex           = 112,
                        Parent           = sl,
                    })
                    MakeCorner(item, 6)

                    item.MouseEnter:Connect(function()
                        if not isActive then
                            Tween(item, TI.Fast, {BackgroundColor3=T.DropItemHov}):Play()
                        end
                    end)
                    item.MouseLeave:Connect(function()
                        if not isActive then
                            Tween(item, TI.Fast, {BackgroundColor3=T.DropBG}):Play()
                        end
                    end)
                    item.MouseButton1Click:Connect(function()
                        selected  = opt
                        obj.Value = opt
                        dropBtn.Text = opt.." ▾"
                        CloseDD()
                        if lCB then lCB(opt) end
                    end)
                end

                ActiveDD = popup
            end)

            function obj:Set(v) selected=v; obj.Value=v; dropBtn.Text=v.." ▾" end
            function obj:Get() return selected end

            return obj
        end

        -- ── INPUT ──
        function Tab:Input(config)
            config = config or {}
            local lName  = config.Name            or "Input"
            local lDesc  = config.Description
            local lPlace = config.PlaceholderText  or "พิมพ์ที่นี่..."
            local lDef   = config.Default          or ""
            local lCB    = config.Callback
            local lNum   = config.NumberOnly       or false

            local rowH = lDesc and 68 or 58
            local row  = MakeRow(rowH)

            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,0,0,18),
                Position       = UDim2.new(0,0,0,8),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            if lDesc then
                New("TextLabel", {
                    Text           = lDesc,
                    Size           = UDim2.new(1,0,0,12),
                    Position       = UDim2.new(0,0,0,26),
                    BackgroundTransparency = 1,
                    TextColor3     = T.DescText,
                    Font           = Enum.Font.Gotham,
                    TextSize       = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent         = row,
                })
            end

            local boxY = lDesc and 42 or 32
            local boxBG = New("Frame", {
                Size             = UDim2.new(1,0,0,26),
                Position         = UDim2.new(0,0,0,boxY),
                BackgroundColor3 = T.InputBG,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = row,
            })
            MakeCorner(boxBG, 6)
            local inputStroke = MakeStroke(boxBG, T.InputBorder, 1, 0)

            local box = New("TextBox", {
                Size             = UDim2.new(1,-12,1,0),
                Position         = UDim2.new(0,6,0,0),
                BackgroundTransparency = 1,
                Text             = lDef,
                PlaceholderText  = lPlace,
                PlaceholderColor3= T.InputPlaceholder,
                TextColor3       = T.InputText,
                Font             = Enum.Font.Gotham,
                TextSize         = 11,
                TextXAlignment   = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                ZIndex           = 3,
                Parent           = boxBG,
            })

            box.Focused:Connect(function()
                Tween(inputStroke, TI.Fast, {Color=T.InputFocus, Thickness=1.5}):Play()
            end)
            box.FocusLost:Connect(function(enter)
                Tween(inputStroke, TI.Fast, {Color=T.InputBorder, Thickness=1}):Play()
                local val = box.Text
                if lNum then val = tonumber(val) or 0; box.Text = tostring(val) end
                if lCB then lCB(val, enter) end
            end)

            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            return box
        end

        -- ── COLOR DISPLAY (read-only color swatch) ──
        function Tab:ColorDisplay(config)
            config = config or {}
            local lName  = config.Name  or "Color"
            local lColor = config.Color or Color3.fromRGB(0,120,212)

            local row = MakeRow(44)
            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-60,1,0),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })
            local swatch = New("Frame", {
                Size             = UDim2.new(0,40,0,24),
                Position         = UDim2.new(1,-40,0.5,-12),
                BackgroundColor3 = lColor,
                BorderSizePixel  = 0,
                ZIndex           = 2,
                Parent           = row,
            })
            MakeCorner(swatch, 6)
            MakeStroke(swatch, T.RowBorder, 1, 0)
            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            return swatch
        end

        -- ── KEYBIND ──
        function Tab:Keybind(config)
            config = config or {}
            local lName  = config.Name     or "Keybind"
            local lDef   = config.Default  or Enum.KeyCode.Unknown
            local lCB    = config.Callback

            local row  = MakeRow(44)
            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,-120,1,0),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = row,
            })

            local currentKey = lDef
            local listening  = false

            local keyBtn = New("TextButton", {
                Text             = "["..tostring(currentKey.Name).."]",
                Size             = UDim2.new(0,100,0,28),
                Position         = UDim2.new(1,-100,0.5,-14),
                BackgroundColor3 = T.InputBG,
                TextColor3       = T.Accent,
                Font             = Enum.Font.GothamBold,
                TextSize         = 11,
                BorderSizePixel  = 0,
                ZIndex           = 3,
                Parent           = row,
            })
            MakeCorner(keyBtn, 6)
            MakeStroke(keyBtn, T.RowBorder, 1, 0)

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text = "[ ... ]"
                keyBtn.TextColor3 = T.NotifWarning
            end)

            UserInputService.InputBegan:Connect(function(input, processed)
                if listening and not processed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        listening   = false
                        currentKey  = input.KeyCode
                        keyBtn.Text = "["..input.KeyCode.Name.."]"
                        keyBtn.TextColor3 = T.Accent
                        if lCB then lCB(input.KeyCode) end
                    end
                end
            end)

            row.MouseEnter:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowHov}):Play() end)
            row.MouseLeave:Connect(function() Tween(row, TI.Fast, {BackgroundColor3=T.RowBG}):Play() end)

            local obj = { Value = currentKey }
            function obj:Get() return currentKey end
            return obj
        end


        -- ── MULTI TOGGLE GROUP (radio buttons) ──
        -- Tab:MultiToggleGroup({ Name, Options, Default, Callback })
        function Tab:MultiToggleGroup(config)
            config = config or {}
            local lName    = config.Name     or "Select"
            local lOptions = config.Options  or {}
            local lDef     = config.Default  or (lOptions[1] or "")
            local lCB      = config.Callback

            -- Header row
            local headerRow = New("Frame", {
                Size             = UDim2.new(1,0,0,28),
                BackgroundTransparency = 1,
                Parent           = page,
            })
            New("TextLabel", {
                Text           = lName,
                Size           = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                TextColor3     = T.LabelText,
                Font           = Enum.Font.GothamBold,
                TextSize       = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent         = headerRow,
            })

            -- Button strip row
            local stripRow = New("Frame", {
                Size             = UDim2.new(1,0,0,36),
                BackgroundColor3 = T.SidebarBG,
                BorderSizePixel  = 0,
                Parent           = page,
            })
            MakeCorner(stripRow, 8)
            MakeStroke(stripRow, T.RowBorder, 1, 0)

            local btnList = New("UIListLayout", {
                FillDirection   = Enum.FillDirection.Horizontal,
                SortOrder       = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Parent          = stripRow,
            })

            local currentVal = lDef
            local buttons    = {}
            local btnW       = math.floor(100 / #lOptions)

            local function SelectOption(val)
                currentVal = val
                for optVal, btn in pairs(buttons) do
                    local active = (optVal == val)
                    Tween(btn, TI.Fast, {
                        BackgroundColor3 = active and T.Accent or T.SidebarBG,
                        TextColor3       = active and Color3.fromRGB(255,255,255) or T.TabText,
                    }):Play()
                end
                if lCB then lCB(val) end
            end

            for i, opt in ipairs(lOptions) do
                local btn = New("TextButton", {
                    Text             = opt,
                    Size             = UDim2.new(1/#lOptions, 0, 1, 0),
                    BackgroundColor3 = (opt == lDef) and T.Accent or T.SidebarBG,
                    TextColor3       = (opt == lDef) and Color3.fromRGB(255,255,255) or T.TabText,
                    Font             = Enum.Font.GothamBold,
                    TextSize         = 11,
                    BorderSizePixel  = 0,
                    ZIndex           = 2,
                    LayoutOrder      = i,
                    Parent           = stripRow,
                })
                if i == 1 then
                    New("UICorner", {CornerRadius=UDim.new(0,7), Parent=btn})
                elseif i == #lOptions then
                    New("UICorner", {CornerRadius=UDim.new(0,7), Parent=btn})
                end
                buttons[opt] = btn
                btn.MouseButton1Click:Connect(function() SelectOption(opt) end)
            end

            local obj = { Value = currentVal }
            function obj:Set(v) SelectOption(v) end
            function obj:Get() return currentVal end
            return obj
        end

        return Tab
    end  -- CreateTab


    -- ── SEARCH BOX (กรอง Tab ใน Sidebar) ──────────────────
    function WinObj:EnableSearch()
        -- Insert search frame at top of sidebar
        local searchFrame = New("Frame", {
            Size             = UDim2.new(1,0,0,36),
            BackgroundTransparency = 1,
            LayoutOrder      = -1,
            Parent           = SidebarScroll,
        })
        MakePadding(searchFrame, 0, 4, 0, 0)

        local searchBG = New("Frame", {
            Size             = UDim2.new(1,0,1,-4),
            BackgroundColor3 = T.RowBG,
            BorderSizePixel  = 0,
            Parent           = searchFrame,
        })
        MakeCorner(searchBG, 8)
        MakeStroke(searchBG, T.RowBorder, 1, 0)

        -- Search icon
        New("TextLabel", {
            Text           = "🔍",
            Size           = UDim2.new(0,24,1,0),
            Position       = UDim2.new(0,4,0,0),
            BackgroundTransparency = 1,
            TextColor3     = T.DescText,
            Font           = Enum.Font.Gotham,
            TextSize       = 12,
            ZIndex         = 2,
            Parent         = searchBG,
        })

        local searchBox = New("TextBox", {
            Text             = "",
            PlaceholderText  = "ค้นหา Tab...",
            PlaceholderColor3= T.InputPlaceholder,
            Size             = UDim2.new(1,-28,1,0),
            Position         = UDim2.new(0,24,0,0),
            BackgroundTransparency = 1,
            TextColor3       = T.LabelText,
            Font             = Enum.Font.Gotham,
            TextSize         = 11,
            TextXAlignment   = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
            ZIndex           = 3,
            Parent           = searchBG,
        })

        -- Filter tabs by search text
        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local q = searchBox.Text:lower()
            for tabName, tabData in pairs(TabPages) do
                if q == "" then
                    tabData.Btn.Visible = true
                else
                    tabData.Btn.Visible = tabName:lower():find(q, 1, true) ~= nil
                end
            end
        end)
    end

    -- ── CLOSE / MIN ────────────────────────────────────────
    CloseBtn.MouseButton1Click:Connect(function()
        Tween(MF, TI.Medium, {Size=UDim2.new(0,W,0,0), BackgroundTransparency=1}):Play()
        task.delay(0.28, function() SG:Destroy() end)
    end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MF, TI.Medium, {Size=UDim2.new(0,W,0,48)}):Play()
            Body.Visible = false
        else
            Body.Visible = true
            Tween(MF, TI.Spring, {Size=MainSize}):Play()
        end
    end)

    -- ── DRAG ───────────────────────────────────────────────
    local dragging, dragStart, startPos2 = false, nil, nil
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging   = true
            dragStart  = i.Position
            startPos2  = MF.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            MF.Position = UDim2.new(
                startPos2.X.Scale, startPos2.X.Offset + d.X,
                startPos2.Y.Scale, startPos2.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- ── TOGGLE VISIBILITY (key) ────────────────────────────
    local visible = true
    UserInputService.InputBegan:Connect(function(i, p)
        if not p and i.KeyCode == Key then
            visible = not visible
            if visible then
                MF.Visible = true
                Tween(MF, TI.Spring, {Size=MainSize, BackgroundTransparency=BG_ALPHA}):Play()
            else
                Tween(MF, TI.Medium, {BackgroundTransparency=1}):Play()
                task.delay(0.28, function() MF.Visible = false end)
            end
        end
    end)

    -- ── OPEN ANIMATION ────────────────────────────────────
    MF.Size = UDim2.new(0,W,0,0)
    MF.BackgroundTransparency = 1
    MF.Visible = true
    task.wait(0.05)
    Tween(MF, TI.Spring, {Size=MainSize, BackgroundTransparency=BG_ALPHA}):Play()

    function WinObj:Destroy() SG:Destroy() end
    function WinObj:SetTitle(t) TitleText.Text = t end

    return WinObj
end

return KyxUI
