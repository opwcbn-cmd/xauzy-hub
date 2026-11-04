local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

pcall(function()
    local old = LP:WaitForChild("PlayerGui"):FindFirstChild("XauzyGui")
    if old then old:Destroy() end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "XauzyGui"
sg.ResetOnSpawn = false
sg.Parent = LP:WaitForChild("PlayerGui")

-- ===================== WARNA & FONT (SESUAI GAMBAR) =====================
local GOLD = Color3.fromRGB(180, 150, 70)      -- Warna emas/kuning
local GOLD_DARK = Color3.fromRGB(100, 80, 30)  -- Emas gelap buat border
local BG_DARK = Color3.fromRGB(15, 15, 15)     -- Background hitam gelap
local HIGHLIGHT = Color3.fromRGB(60, 50, 20)   -- Highlight baris
local W = Color3.fromRGB(220, 220, 220)        -- Teks putih agak pudar
local FONT = Enum.Font.Code                   -- Font pixel/console

-- ===================== FRAME UTAMA =====================
local mf = Instance.new("Frame", sg)
mf.Size = UDim2.new(0, 460, 0, 480) -- Lebar biar muat tulisan panjang
mf.Position = UDim2.new(0.5, -230, 0.5, -240)
mf.BackgroundColor3 = BG_DARK
mf.BorderSizePixel = 0
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 4)
local ms = Instance.new("UIStroke", mf)
ms.Color = GOLD_DARK
ms.Thickness = 1

-- HEADER (JUDUL CHEAT)
local hd = Instance.new("TextLabel", mf)
hd.Size = UDim2.new(1, 0, 0, 40)
hd.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hd.Text = "CHEAT"
hd.TextColor3 = W
hd.Font = FONT
hd.TextSize = 16
hd.BorderSizePixel = 0
Instance.new("UICorner", hd).CornerRadius = UDim.new(0, 4)

-- GARIS BAWAH HEADER
local hdLine = Instance.new("Frame", mf)
hdLine.Size = UDim2.new(0.95, 0, 0, 1)
hdLine.Position = UDim2.new(0.025, 0, 0, 40)
hdLine.BackgroundColor3 = GOLD
hdLine.BorderSizePixel = 0

-- SCROLLING FRAME (BIAR BISA DI-SCROLL KE BAWAH)
local scroll = Instance.new("ScrollingFrame", mf)
scroll.Size = UDim2.new(1, -20, 1, -110)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = GOLD
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local scrollLay = Instance.new("UIListLayout", scroll)
scrollLay.Padding = UDim.new(0, 5)
scrollLay.SortOrder = Enum.SortOrder.LayoutOrder

-- FUNGSI BIKIN JUDUL KATEGORI (SENJATA, PEMAIN, DLL)
local function makeCategory(titleText, order)
    local cat = Instance.new("TextLabel", scroll)
    cat.Size = UDim2.new(1, -4, 0, 30)
    cat.BackgroundTransparency = 1
    cat.Text = titleText
    cat.TextColor3 = GOLD
    cat.Font = FONT
    cat.TextSize = 14
    cat.TextXAlignment = Enum.TextXAlignment.Left
    cat.LayoutOrder = order
    
    local line = Instance.new("Frame", cat)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -1)
    line.BackgroundColor3 = GOLD_DARK
    line.BorderSizePixel = 0
    return cat
end

-- FUNGSI BIKIN BARIS MENU (KAYAK DI GAMBAR)
local function makeRow(labelText, order, isToggle, callback)
    -- Container baris
    local row = Instance.new("Frame", scroll)
    row.Size = UDim2.new(1, -4, 0, 35)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order

    -- Teks Label
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = W
    lbl.Font = FONT
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Teks Nilai (MATI / NYALA)
    local val = Instance.new("TextLabel", row)
    val.Size = UDim2.new(0.2, 0, 1, 0)
    val.Position = UDim2.new(0.6, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = isToggle and "MATI" or "100% (BAWAAN)"
    val.TextColor3 = W
    val.Font = FONT
    val.TextSize = 14
    val.TextXAlignment = Enum.TextXAlignment.Center

    -- Tombol Kiri (◄)
    local btnLeft = Instance.new("TextButton", row)
    btnLeft.Size = UDim2.new(0, 30, 0, 25)
    btnLeft.Position = UDim2.new(0.6, -35, 0.5, -12)
    btnLeft.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btnLeft.Text = "◄"
    btnLeft.TextColor3 = W
    btnLeft.Font = FONT
    btnLeft.TextSize = 14
    btnLeft.BorderSizePixel = 1
    btnLeft.BorderColor3 = GOLD_DARK
    Instance.new("UICorner", btnLeft).CornerRadius = UDim.new(0, 2)

    -- Tombol Kanan (►)
    local btnRight = Instance.new("TextButton", row)
    btnRight.Size = UDim2.new(0, 30, 0, 25)
    btnRight.Position = UDim2.new(0.8, 5, 0.5, -12)
    btnRight.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btnRight.Text = "►"
    btnRight.TextColor3 = W
    btnRight.Font = FONT
    btnRight.TextSize = 14
    btnRight.BorderSizePixel = 1
    btnRight.BorderColor3 = GOLD_DARK
    Instance.new("UICorner", btnRight).CornerRadius = UDim.new(0, 2)

    -- Logika Toggle
    if isToggle then
        local isOn = false
        local function toggle()
            isOn = not isOn
            val.Text = isOn and "NYALA" or "MATI"
            val.TextColor3 = isOn and GOLD or W
            if callback then callback(isOn) end
        end
        btnRight.MouseButton1Click:Connect(toggle)
        btnLeft.MouseButton1Click:Connect(toggle)
        row:SetAttribute("IsOn", false)
    end

    -- Efek Hover (Highlight baris)
    row.MouseEnter:Connect(function()
        row.BackgroundColor3 = HIGHLIGHT
        row.BackgroundTransparency = 0.5
    end)
    row.MouseLeave:Connect(function()
        row.BackgroundTransparency = 1
    end)

    return {frame = row, left = btnLeft, right = btnRight, label = lbl, value = val}
end

-- ===================== ISI MENU =====================
-- FITUR-FITUR GUE MASUKIN KE DALAM UI INI
local espOn, invOn, flyOn, spdOn, aimOn = false,false,false,false,false
local flySpeed, walkSpeed = 55, 60
local savedT = {}
local flyConn, spdConn, aimConn, invisConn, aimBeam
local upDown, tStartY = 0, nil

-- Bikin Kategori & Baris
makeCategory("SENJATA", 1)
makeRow("ESP PLAYER (GARIS)", 2, true, function(on) espOn = on; if not on then 
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("ESPH")
            if h then h:Destroy() end
        end
    end
end end)

makeRow("INVISIBLE MODE", 3, true, function(on)
    invOn = on
    if invisConn then invisConn:Disconnect(); invisConn = nil end
    local c = LP.Character
    if on then
        if invisConn then invisConn:Disconnect() end
        invisConn = RunService.RenderStepped:Connect(function()
            if not invOn then return end
            local c = LP.Character
            if not c then return end
            for _,p in pairs(c:GetDescendants()) do
                if p:IsA("BasePart") then
                    if savedT[p] == nil then savedT[p] = p.Transparency end
                    p.Transparency = 1
                    p.LocalTransparencyModifier = 1
                    p.CanCollide = false
                end
            end
        end)
    else
        if c then
            for _,p in pairs(c:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Transparency = savedT[p] or 0
                    p.LocalTransparencyModifier = 0
                    p.CanCollide = true
                end
            end
        end
        savedT = {}
    end
end)

makeCategory("PEMAIN", 4)

makeRow("FLY MODE", 5, true, function(on)
    flyOn = on
    if not on then
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        upDown = 0; tStartY = nil
        local c = LP.Character
        if c then
            local hrp = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hrp then
                local bv = hrp:FindFirstChild("FlyBV"); if bv then bv:Destroy() end
                local bg = hrp:FindFirstChild("FlyBG"); if bg then bg:Destroy() end
            end
            if hum then hum.PlatformStand = false end
        end
        return
    end

    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local bv = Instance.new("BodyVelocity", hrp); bv.Name = "FlyBV"; bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Velocity = Vector3.zero
    local bg = Instance.new("BodyGyro", hrp); bg.Name = "FlyBG"; bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.P = 3000; bg.D = 100
    hum.PlatformStand = true

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyOn or not hrp.Parent then return end
        local spd = spdOn and walkSpeed or flySpeed
        local cam = workspace.CurrentCamera
        local mv = hum.MoveDirection
        local dir = Vector3.zero
        local moving = false

        if mv.Magnitude > 0.05 then
            moving = true
            local look = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
            local right = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
            if look.Magnitude > 0.001 then look = look.Unit end
            if right.Magnitude > 0.001 then right = right.Unit end
            dir = look * -mv.Z + right * mv.X
            if dir.Magnitude > 0.001 then dir = dir.Unit end
        end
        bv.Velocity = dir * spd + Vector3.new(0, upDown * spd, 0)
        if moving then bg.CFrame = CFrame.new(hrp.Position, hrp.Position + dir) end
    end)

    UIS.TouchStarted:Connect(function(input) if flyOn then tStartY = input.Position.Y end end)
    UIS.TouchMoved:Connect(function(input)
        if not flyOn or not tStartY then return end
        local d = input.Position.Y - tStartY
        if d < -40 then upDown = 1 elseif d > 40 then upDown = -1 else upDown = 0 end
    end)
    UIS.TouchEnded:Connect(function() tStartY = nil; upDown = 0 end)
end)

makeRow("SPEED HACK", 6, true, function(on)
    spdOn = on
    local c = LP.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = on and walkSpeed or 16 end
    end
end)

makeRow("AIM LOCK", 7, true, function(on)
    aimOn = on
    if not on then
        if aimConn then aimConn:Disconnect(); aimConn = nil end
        if aimBeam then aimBeam.beam.Enabled = false end
        return
    end
    local c = LP.Character
    if not c then return end
    local head = c:FindFirstChild("Head")
    if not head then return end
    local att = Instance.new("Attachment", head); att.Name = "AimAtt"
    local b = Instance.new("Beam", att); b.Attachment0 = att; b.Attachment1 = att; b.Width0 = 0.15; b.Width1 = 0.05; b.Color = ColorSequence.new(GOLD); b.FaceCamera = true; b.Transparency = NumberSequence.new(0.2); b.Enabled = false
    aimBeam = {att = att, beam = b}

    aimConn = RunService.RenderStepped:Connect(function()
        if not aimOn then return end
        local c = LP.Character
        if not c then return end
        local myHrp = c:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end
        local list = {}
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local hd = p.Character:FindFirstChild("Head")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hd and hum and hum.Health > 0 then
                    table.insert(list, {head = hd, dist = (hrp.Position - myHrp.Position).Magnitude})
                end
            end
        end
        table.sort(list, function(a,b) return a.dist < b.dist end)
        local fil = {}
        for _,v in ipairs(list) do if v.dist >= 20 and v.dist <= 250 then table.insert(fil, v) end end
        local tgt = #fil > 0 and fil[math.floor(#fil/2)+1].head or (#list > 0 and list[math.floor(#list/2)+1].head or nil)

        if tgt then
            local cam = workspace.CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.Position, tgt.Position)
            if aimBeam then
                local a1 = tgt:FindFirstChild("AimAtt") or Instance.new("Attachment", tgt)
                a1.Name = "AimAtt"
                aimBeam.beam.Attachment1 = a1
                aimBeam.beam.Enabled = true
            end
        else
            if aimBeam then aimBeam.beam.Enabled = false end
        end
    end)
end)

makeCategory("PERMAINAN", 8)

makeRow("TELEPORT KE PEMAIN", 9, true, function(on)
    -- Kalau dinyalain, teleport ke pemain jarak sedang
    if on then
        local c = LP.Character
        if not c then return end
        local myHrp = c:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end
        local list = {}
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then table.insert(list, {hrp = hrp, dist = (hrp.Position - myHrp.Position).Magnitude}) end
            end
        end
        if #list > 0 then
            table.sort(list, function(a,b) return a.dist < b.dist end)
            myHrp.CFrame = list[1].hrp.CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

-- ===================== FOOTER (TOMBOL KEMBALI & BAWAAN) =====================
local footer = Instance.new("Frame", mf)
footer.Size = UDim2.new(1, -20, 0, 45)
footer.Position = UDim2.new(0, 10, 1, -55)
footer.BackgroundTransparency = 1

local txtInfo = Instance.new("TextLabel", footer)
txtInfo.Size = UDim2.new(1, 0, 0, 20)
txtInfo.Position = UDim2.new(0, 0, 0, -15)
txtInfo.BackgroundTransparency = 1
txtInfo.Text = "A weapon replaces the one not in hand, gold names are held"
txtInfo.TextColor3 = GOLD_DARK
txtInfo.Font = FONT
txtInfo.TextSize = 10
txtInfo.TextXAlignment = Enum.TextXAlignment.Left

local btnClose = Instance.new("TextButton", footer)
btnClose.Size = UDim2.new(0, 100, 0, 30)
btnClose.Position = UDim2.new(1, -210, 0, 5)
btnClose.BackgroundColor3 = Color3.fromRGB(30, 25, 15)
btnClose.Text = "Kembali"
btnClose.TextColor3 = W
btnClose.Font = FONT
btnClose.TextSize = 14
btnClose.BorderSizePixel = 1
btnClose.BorderColor3 = GOLD_DARK
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(0, 2)

local btnReset = Instance.new("TextButton", footer)
btnReset.Size = UDim2.new(0, 100, 0, 30)
btnReset.Position = UDim2.new(1, -100, 0, 5)
btnReset.BackgroundColor3 = Color3.fromRGB(30, 25, 15)
btnReset.Text = "Bawaan"
btnReset.TextColor3 = W
btnReset.Font = FONT
btnReset.TextSize = 14
btnReset.BorderSizePixel = 1
btnReset.BorderColor3 = GOLD_DARK
Instance.new("UICorner", btnReset).CornerRadius = UDim.new(0, 2)

btnClose.MouseButton1Click:Connect(function()
    -- Matikan semua fitur sebelum close
    if flyConn then flyConn:Disconnect() end
    if aimConn then aimConn:Disconnect() end
    if invisConn then invisConn:Disconnect() end
    local c = LP.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16; h.PlatformStand = false end
        for _,p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Transparency = savedT[p] or 0
                p.LocalTransparencyModifier = 0
            end
        end
    end
    sg:Destroy()
end)

btnReset.MouseButton1Click:Connect(function()
    -- Reset ke setelan bawaan Roblox
    local c = LP.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end
end)

-- ===================== DRAG GUI (BISA DIGESER) =====================
local dragging, dragInput, dragStart, startPos
hd.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mf.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
hd.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mf.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- LOOP ESP
RunService.RenderStepped:Connect(function()
    if espOn then
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local c = p.Character
                if not c:FindFirstChild("ESPH") then
                    local h = Instance.new("Highlight", c)
                    h.Name = "ESPH"
                    h.FillColor = GOLD
                    h.OutlineColor = Color3.new(1,1,1)
                    h.FillTransparency = 0.65
                end
            end
        end
    end
end)

-- LOOP SPEED
RunService.Heartbeat:Connect(function()
    if spdOn then
        local c = LP.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h and h.WalkSpeed ~= walkSpeed then h.WalkSpeed = walkSpeed end
        end
    end
end)

print("[Xauzy] UI Berhasil Dimuat")