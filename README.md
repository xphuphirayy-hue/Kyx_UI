# Kyx_UI — README

---

## 📦 โหลด Library

```lua
local KyxUI = loadstring(game:HttpGet("YOUR_RAW_URL"))()
```

---

## 🪟 สร้าง Window

```lua
local Window = KyxUI:CreateWindow({
    Title    = "My Hub",
    SubTitle = "v1.0",
    KeyCode  = Enum.KeyCode.RightShift, -- ปุ่มซ่อน/แสดง UI
    Width    = 660,
    Height   = 480,
    Icon     = nil, -- rbxassetid://... (optional)
})
```

---

## 📑 สร้าง Tab

```lua
local Tab = Window:CreateTab("Farm", nil)
-- พารามิเตอร์ที่ 2 คือ icon (rbxassetid) ใส่ nil ถ้าไม่ใช้
```

---

## 🧩 Components

### Section
```lua
Tab:Section("AUTO FARM")
```

---

### Toggle
```lua
local toggle = Tab:Toggle({
    Name        = "Auto Farm",
    Description = "ฟาร์มอัตโนมัติ",   -- optional
    Default     = false,
    Callback    = function(value)
        _G.AutoFarm = value
    end,
})

-- ใช้งาน
toggle:Set(true)   -- เปิด/ปิดด้วย code
toggle:Get()       -- ดึงค่าปัจจุบัน
toggle.Value       -- ค่าปัจจุบัน (boolean)
```

---

### Button
```lua
Tab:Button({
    Name        = "Hop Server",
    Description = "เปลี่ยน Server",   -- optional
    Accent      = false,               -- true = ปุ่มสีน้ำเงิน
    Callback    = function()
        print("clicked!")
    end,
})
```

---

### Slider
```lua
local slider = Tab:Slider({
    Name        = "Walk Speed",
    Description = "ความเร็วเดิน",      -- optional
    Min         = 1,
    Max         = 500,
    Default     = 16,
    Suffix      = " studs",            -- optional
    Callback    = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
})

-- ใช้งาน
slider:Set(100)
slider:Get()
slider.Value
```

---

### Dropdown
```lua
local dropdown = Tab:Dropdown({
    Name        = "Weapon",
    Description = "เลือก Weapon",      -- optional
    Options     = { "Melee", "Sword", "Gun", "Blox Fruit" },
    Default     = "Melee",
    Callback    = function(value)
        Selected_Weapon = value
    end,
})

-- ใช้งาน
dropdown:Set("Sword")
dropdown:Get()
dropdown.Value
```

---

### Input
```lua
local input = Tab:Input({
    Name            = "Custom Value",
    Description     = "กรอกค่า",       -- optional
    PlaceholderText = "พิมพ์ที่นี่...",
    Default         = "",
    NumberOnly      = false,            -- true = รับแค่ตัวเลข
    Callback        = function(value, enterPressed)
        print(value)
    end,
})
```

---

### Keybind
```lua
local keybind = Tab:Keybind({
    Name     = "Toggle Farm",
    Default  = Enum.KeyCode.F,
    Callback = function(keyCode)
        print("New key:", keyCode.Name)
    end,
})

keybind:Get()   -- ดึง KeyCode ปัจจุบัน
keybind.Value
```

---

### Label
```lua
Tab:Label("ข้อความอธิบายอะไรก็ได้")
```

---

### Separator
```lua
Tab:Separator()
```

---

### Color Display
```lua
Tab:ColorDisplay({
    Name  = "Accent Color",
    Color = Color3.fromRGB(0, 120, 212),
})
```

---

## 🔔 Notification

```lua
KyxUI:Notify({
    Title    = "สำเร็จ!",
    Content  = "โหลด Script เรียบร้อย",
    Duration = 3,          -- วินาที
    Type     = "Success",  -- Info | Success | Warning | Error
})
```

| Type | สี |
|------|----|
| `Info` | น้ำเงิน |
| `Success` | เขียว |
| `Warning` | ส้ม |
| `Error` | แดง |

---

## ⌨️ Hotkey

| ปุ่ม | หน้าที่ |
|------|---------|
| `RightShift` (default) | ซ่อน / แสดง UI |
| ปุ่ม `─` บน Titlebar | ย่อ / ขยาย Window |
| ปุ่ม `✕` บน Titlebar | ปิด UI |

เปลี่ยน Hotkey ได้ตอนสร้าง Window ผ่าน `KeyCode`

---

## 🎨 Theme

Kyx_UI ใช้ **Fluent Design / Windows 11** เป็น base
- สีหลัก: `#FFFFFF` / `#F3F3F3`
- Accent: `#0078D4` (Microsoft Blue)
- Font: `GothamBold` + `Gotham`
- Corner radius: `8px`

---

## 📋 ตัวอย่างเต็ม

```lua
local KyxUI = loadstring(game:HttpGet("URL"))()

local Window = KyxUI:CreateWindow({
    Title    = "Kyx Hub",
    SubTitle = "v1.0",
    KeyCode  = Enum.KeyCode.RightShift,
})

-- Tab 1: Farm
local FarmTab = Window:CreateTab("Farm", nil)

FarmTab:Section("AUTO FARM")

FarmTab:Toggle({
    Name     = "Auto Farm",
    Default  = false,
    Callback = function(v) _G.AutoFarm = v end,
})

FarmTab:Dropdown({
    Name     = "Weapon",
    Options  = { "Melee", "Sword", "Gun" },
    Default  = "Melee",
    Callback = function(v) Selected_Weapon = v end,
})

FarmTab:Slider({
    Name     = "Tween Speed",
    Min      = 50,
    Max      = 500,
    Default  = 250,
    Suffix   = " sps",
    Callback = function(v) TweenSpeed = v end,
})

FarmTab:Section("UTILITIES")

FarmTab:Button({
    Name     = "Hop Server",
    Accent   = true,
    Callback = function() HopServer() end,
})

-- Tab 2: Settings
local SettingsTab = Window:CreateTab("Settings", nil)

SettingsTab:Section("COMBAT")

SettingsTab:Toggle({
    Name        = "Fast Attack",
    Description = "โจมตีเร็วอัตโนมัติ",
    Default     = true,
    Callback    = function(v) AutoAttacks = v end,
})

SettingsTab:Keybind({
    Name    = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
})

-- Notification
KyxUI:Notify({
    Title   = "Kyx Hub",
    Content = "โหลดสำเร็จ!",
    Type    = "Success",
})
```

---

> **Kyx_UI** — WindUI Style · Fluent Design · Made for Roblox
