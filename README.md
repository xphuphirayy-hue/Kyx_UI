
## Kyx_UI
---

**Fluent Design · Windows 11 Style · v1.2.0**  
UI Library สำหรับ Roblox Exploits
---

## 📦 โหลด Library

```lua
local KyxUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xphuphirayy-hue/Kyx_UI/refs/heads/main/KyxUImain.lua"))()
```

---

## 🪟 CreateWindow

```lua
local Win = KyxUI:CreateWindow({
    Title    = "My Hub",
    SubTitle = "v1.0",
    KeyCode  = Enum.KeyCode.RightShift,  -- ปุ่มซ่อน/แสดง (default: RightShift)
    Width    = 660,                       -- optional
    Height   = 480,                       -- optional
    Icon     = nil,                       -- rbxassetid://... (optional)
})
```

| Method | หน้าที่ |
|--------|---------|
| `Win:CreateTab(name, icon)` | สร้าง Tab ใหม่ |
| `Win:EnableSearch()` | เพิ่ม SearchBox บน Sidebar |
| `Win:SetTitle(text)` | เปลี่ยนชื่อ Window |
| `Win:Destroy()` | ลบ Window |

**Hotkey เริ่มต้น**

| ปุ่ม | หน้าที่ |
|------|---------|
| `RightShift` | ซ่อน / แสดง UI |
| `─` (Titlebar) | ย่อ / ขยาย Window |
| `✕` (Titlebar) | ปิด UI |

---

## 📑 CreateTab

```lua
local Tab = Win:CreateTab("Farm", nil)
-- arg 1: ชื่อ Tab
-- arg 2: icon rbxassetid (nil ถ้าไม่ใช้)
```

---

## 🔍 EnableSearch ⭐ NEW

เพิ่ม SearchBox ที่ด้านบน Sidebar — กรอก keyword กรอง Tab ได้ทันที

```lua
Win:EnableSearch()
```

---

## 🧩 Tab Components

### Section
```lua
Tab:Section("AUTO FARM")
```

---

### Toggle
```lua
local tog = Tab:Toggle({
    Name        = "Auto Farm",
    Description = "ฟาร์มอัตโนมัติ",  -- optional
    Default     = false,
    Callback    = function(value) _G.AutoFarm = value end,
})

tog:Set(true)           -- เปิด/ปิด
tog:Get()               -- ดึงค่าปัจจุบัน (boolean)
tog:SetDisabled(true)   -- ⭐ NEW — disable/enable component
tog.Value               -- ค่าปัจจุบัน
```

---

### Button
```lua
Tab:Button({
    Name        = "Hop Server",
    Description = "เปลี่ยน Server",  -- optional
    Accent      = false,              -- true = ปุ่มสีน้ำเงิน
    Callback    = function() HopServer() end,
})
```

---

### Slider
```lua
local sl = Tab:Slider({
    Name        = "Walk Speed",
    Description = "ความเร็วเดิน",  -- optional
    Min         = 1,
    Max         = 500,
    Default     = 16,
    Suffix      = " studs",         -- optional
    Callback    = function(value) Humanoid.WalkSpeed = value end,
})

sl:Set(100)
sl:Get()
sl:SetDisabled(true)   -- ⭐ NEW — disable/enable
sl.Value
```

---

### Dropdown
```lua
local dd = Tab:Dropdown({
    Name        = "Weapon",
    Description = "เลือก Weapon",  -- optional
    Options     = { "Melee", "Sword", "Gun", "Blox Fruit" },
    Default     = "Melee",
    Callback    = function(value) Selected = value end,
})

dd:Set("Sword")
dd:Get()
dd.Value
```

---

### Input
```lua
local inp = Tab:Input({
    Name            = "Custom Value",
    Description     = "กรอกค่า",      -- optional
    PlaceholderText = "พิมพ์ที่นี่...",
    Default         = "",
    NumberOnly      = false,           -- true = รับแค่ตัวเลข
    Callback        = function(value, enterPressed) print(value) end,
})
```

---

### Keybind
```lua
local kb = Tab:Keybind({
    Name     = "Toggle Farm",
    Default  = Enum.KeyCode.F,
    Callback = function(keyCode) print("New key:", keyCode.Name) end,
})

kb:Get()   -- ดึง KeyCode ปัจจุบัน
kb.Value
```

---

### ColorDisplay
```lua
Tab:ColorDisplay({
    Name  = "Accent Color",
    Color = Color3.fromRGB(0, 120, 212),
})
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

### Alert ⭐ NEW

แถบแจ้งเตือนแบบ inline ภายใน Tab — กด ✕ ปิดได้

```lua
local al = Tab:Alert({
    Type        = "Warning",               -- Info | Success | Warning | Error
    Text        = "Equip weapon ก่อนฟาร์ม",
    Dismissible = true,                    -- default true
})

al:SetText("ข้อความใหม่")  -- แก้ข้อความ runtime
al:Dismiss()               -- ปิดด้วย code
```

| Type | สี |
|------|----|
| `Info` | น้ำเงิน |
| `Success` | เขียว |
| `Warning` | ส้ม |
| `Error` | แดง |

---

### MultiToggleGroup ⭐ NEW

กลุ่มปุ่มแบบ radio — เลือกได้ทีละอันเดียว เหมาะกับ Mode เลือก

```lua
local mode = Tab:MultiToggleGroup({
    Name     = "Farm Mode",
    Options  = { "Quest", "Boss", "Material" },
    Default  = "Quest",
    Callback = function(value) FarmMode = value end,
})

mode:Set("Boss")
mode:Get()
mode.Value
```

---

## 🔔 Notify

```lua
KyxUI:Notify({
    Title    = "สำเร็จ!",
    Content  = "โหลด Script เรียบร้อย",
    Duration = 3,           -- วินาที (default 3)
    Type     = "Success",   -- Info | Success | Warning | Error
})
```

Notification จะ slide-in จากขวาล่าง มี progress bar countdown และปิดเองอัตโนมัติ

---

## 💬 Dialog ⭐ NEW

Popup confirm แบบ modal — ใช้ก่อนทำ action สำคัญ

```lua
KyxUI:Dialog({
    Title     = "ยืนยัน?",
    Content   = "ต้องการ Hop Server ใช่ไหม?",
    Confirm   = "ยืนยัน",    -- default "ยืนยัน"
    Cancel    = "ยกเลิก",    -- default "ยกเลิก"
    OnConfirm = function() HopServer() end,
    OnCancel  = function() print("cancelled") end,  -- optional
})
```

---

## 🎨 Theme

Kyx_UI ใช้ **Fluent Design / Windows 11** เป็น base

| Property | ค่า |
|----------|-----|
| Background | `#F3F3F3` / `#FFFFFF` |
| Sidebar | `#EEEEEE` |
| Accent | `#0078D4` (Microsoft Blue) |
| Font | `GothamBold` + `Gotham` |
| Corner radius | `8px` window `12px` |
| UI Transparency | `0.4` (ปรับได้ที่ `BG_ALPHA`) |

แก้ค่า transparency ทั้ง UI ได้ที่บรรทัดเดียว:
```lua
local BG_ALPHA = 0.4  -- 0 = ทึบสนิท, 1 = โปร่งใสสนิท
```

---

## 📋 ตัวอย่างเต็ม

```lua
local KyxUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xphuphirayy-hue/Kyx_UI/refs/heads/main/KyxUImain.lua"))()

local Win = KyxUI:CreateWindow({
    Title    = "Kyx Hub",
    SubTitle = "v1.2",
    KeyCode  = Enum.KeyCode.RightShift,
})

Win:EnableSearch()  -- เปิด searchbox

-- ─── Tab: Farm ───────────────────────────────────────────
local FarmTab = Win:CreateTab("Farm", nil)

FarmTab:Alert({
    Type = "Info",
    Text = "ต้องการ Sword ที่ Level เดียวกับ Quest",
})

FarmTab:Section("AUTO FARM")

local autoFarm = FarmTab:Toggle({
    Name     = "Auto Farm",
    Default  = false,
    Callback = function(v) _G.AutoFarm = v end,
})

FarmTab:MultiToggleGroup({
    Name     = "Farm Mode",
    Options  = { "Quest", "Boss", "Material" },
    Default  = "Quest",
    Callback = function(v) _G.FarmMode = v end,
})

FarmTab:Dropdown({
    Name     = "Weapon",
    Options  = { "Melee", "Sword", "Gun" },
    Default  = "Melee",
    Callback = function(v) _G.Weapon = v end,
})

FarmTab:Slider({
    Name     = "Tween Speed",
    Min      = 50,
    Max      = 500,
    Default  = 250,
    Suffix   = " sps",
    Callback = function(v) _G.TweenSpeed = v end,
})

FarmTab:Section("UTILITIES")

FarmTab:Button({
    Name     = "Hop Server",
    Accent   = true,
    Callback = function()
        KyxUI:Dialog({
            Title     = "Hop Server?",
            Content   = "ต้องการย้าย Server ใช่ไหม?",
            OnConfirm = function() HopServer() end,
        })
    end,
})

-- ─── Tab: Settings ───────────────────────────────────────
local SettingsTab = Win:CreateTab("Settings", nil)

SettingsTab:Section("COMBAT")

local fastAtk = SettingsTab:Toggle({
    Name        = "Fast Attack",
    Description = "โจมตีเร็วอัตโนมัติ",
    Default     = true,
    Callback    = function(v) _G.FastAttack = v end,
})

SettingsTab:Keybind({
    Name    = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
})

-- ─── Done ────────────────────────────────────────────────
KyxUI:Notify({
    Title   = "Kyx Hub",
    Content = "โหลดสำเร็จ!",
    Type    = "Success",
})
```

---

## 📝 Changelog

| Version | Changes |
|---------|---------|
| **v1.2.0** | + Disabled State · + Alert · + MultiToggleGroup · + Sidebar Search · + Dialog |
| **v1.1.0** | + UI Transparency (`BG_ALPHA = 0.4`) |
| **v1.0.0** | Initial release — Window · Tab · Toggle · Button · Slider · Dropdown · Input · Keybind · Notify |

---

> **Kyx_UI** · Made for Roblox
