--[[ XAUZY HUB V2 - BAGIAN 1/4 ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    Colors = {
        BG   = Color3.fromRGB(15, 15, 16),
        BG2  = Color3.fromRGB(24, 24, 26),
        HD   = Color3.fromRGB(20, 20, 22),
        RD   = Color3.fromRGB(255, 27, 45),
        RDD  = Color3.fromRGB(140, 12, 25),
        TX   = Color3.fromRGB(240, 240, 240),
        GRN  = Color3.fromRGB(50, 220, 80)
    },
    FlySpeed   = 55,
    WalkSpeed  = 60,
    DefaultSpeed = 16,
    AimLerp    = 0.35,
}
local C = CONFIG.Colors

local State = { espOn = false, flyOn = false, spdOn = false, aimHeadOn = false, aimBodyOn = false }

pcall(function()
    local old = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("XauzyGui")
    if old then old:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XauzyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- NOTIFIKASI
local Notif = Instance.new("TextLabel", ScreenGui)
Notif.Size = UDim2.new(0, 220, 0, 32)
Notif.Position = UDim2.new(0.5, -110, 0, 24)
Notif.BackgroundColor3 = C.RDD
Notif.TextColor3 = C.TX
Notif.Font = Enum.Font.GothamBold
Notif.TextSize = 12
Notif.Visible = false
Notif.ZIndex = 100
Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", Notif).Color = C.RD

local notifToken = 0
local function showNotif(txt)
    if not Notif or not Notif.Parent then return end
    notifToken = notifToken + 1
    local myToken = notifToken
    Notif.Text = tostring(txt)
    Notif.Visible = true
    task.delay(2, function()
        if Notif and Notif.Parent and notifToken == myToken then Notif.Visible = false end
    end)
end

-- DRAG HELPER
local function makeDraggable(frame, handle)
    local dragging, dragStart, startPos
    handle = handle or frame
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- MAIN FRAME
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 380)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -190)
MainFrame.BackgroundColor3 = C.BG
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local ms = Instance.new("UIStroke", MainFrame); ms.Color = C.RD; ms.Thickness = 1.5; ms.Transparency = 0.15

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = C.HD
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local Logo = Instance.new("TextLabel", Header)
Logo.Size = UDim2.new(0, 34, 0, 34)
Logo.Position = UDim2.new(0, 8, 0.5, -17)
Logo.BackgroundColor3 = C.RDD
Logo.Text = "XY"
Logo.TextColor3 = C.TX
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 15
Logo.BorderSizePixel = 0
Logo.ZIndex = 2
Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 50, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "XAUZY HUB V2"
Title.TextColor3 = C.TX
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 22, 0, 22)
MinBtn.Position = UDim2.new(1, -50, 0.5, -11)
MinBtn.BackgroundColor3 = C.BG2
MinBtn.Text = "-"
MinBtn.TextColor3 = C.TX
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -26, 0.5, -11)
CloseBtn.BackgroundColor3 = C.RDD
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.TX
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local Body = Instance.new("ScrollingFrame", MainFrame)
Body.Size = UDim2.new(1, -20, 1, -62)
Body.Position = UDim2.new(0, 10, 0, 52)
Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0
Body.ScrollBarThickness = 3
Body.ScrollBarImageColor3 = C.RD
Body.CanvasSize = UDim2.new(0, 0, 0, 0)
Body.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", Body).Padding = UDim.new(0, 6)

local ButtonStrokes = {}
local function makeButton(text, order)
    local b = Instance.new("TextButton", Body)
    b.Size = UDim2.new(1, -4, 0, 32)
    b.BackgroundColor3 = C.BG2
    b.Text = text
    b.TextColor3 = C.TX
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", b); s.Color = C.RD; s.Thickness = 1; s.Transparency = 0.55
    ButtonStrokes[b] = s
    b.MouseEnter:Connect(function() if b.BackgroundColor3 ~= C.RDD then b.BackgroundColor3 = Color3.fromRGB(38, 10, 15); s.Transparency = 0.2 end end)
    b.MouseLeave:Connect(function() if b.BackgroundColor3 ~= C.RDD then b.BackgroundColor3 = C.BG2; s.Transparency = 0.55 end end)
    return b
end

local function setButton(b, on)
    local s = ButtonStrokes[b]
    if on then b.BackgroundColor3 = C.RDD; if s then s.Transparency = 0 end
    else b.BackgroundColor3 = C.BG2; if s then s.Transparency = 0.55 end end
end

-- UI SLIDER (Untuk Speed & Fly)
local function makeSlider(name, defaultVal, maxVal, order, callback)
    local frame = Instance.new("Frame", Body)
    frame.Size = UDim2.new(1, -4, 0, 45)
    frame.BackgroundColor3 = C.BG2
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = C.RD

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Position = UDim2.new(0, 5, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = name .. " : " .. defaultVal
    lbl.TextColor3 = C.TX
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local txtBox = Instance.new("TextBox", frame)
    txtBox.Size = UDim2.new(1, -10, 0, 18)
    txtBox.Position = UDim2.new(0, 5, 0, 22)
    txtBox.BackgroundColor3 = C.BG
    txtBox.Text = tostring(defaultVal)
    txtBox.TextColor3 = C.GRN
    txtBox.Font = Enum.Font.GothamBold
    txtBox.TextSize = 10
    txtBox.BorderSizePixel = 0
    Instance.new("UICorner", txtBox).CornerRadius = UDim.new(0, 4)
    
    txtBox.FocusLost:Connect(function()
        local num = tonumber(txtBox.Text)
        if num and num > 0 and num <= maxVal then
            lbl.Text = name .. " : " .. num
            callback(num)
        else
            txtBox.Text = tostring(defaultVal)
            callback(defaultVal)
        end
    end)
    return frame
end

local ESPBtn = makeButton("ESP : OFF", 1)
local FlyBtn = makeButton("FLY : OFF", 2)
local SpeedBtn = makeButton("SPEED : OFF", 3)
local AimHeadBtn = makeButton("AIM LOCK HEAD : OFF", 4)
local AimBodyBtn = makeButton("AIM LOCK BODY : OFF", 5)
local TPBtn = makeButton("TELEPORT", 6)
local CopyBtn = makeButton("COPY AVA", 7)

makeSlider("Fly Speed", CONFIG.FlySpeed, 500, 8, function(val) CONFIG.FlySpeed = val end)
makeSlider("Walk Speed", CONFIG.WalkSpeed, 500, 9, function(val) CONFIG.WalkSpeed = val; if State.spdOn then applySpeed() end end)
--[[ XAUZY HUB V2 - BAGIAN 2/4 ]]
local ESPConnections = {}
local function clearESP()
    for _, c in ipairs(ESPConnections) do pcall(function() c:Disconnect() end) end
    ESPConnections = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("ESPH"); if h then h:Destroy() end
            local hd = p.Character:FindFirstChild("Head")
            if hd then local bb = hd:FindFirstChild("ESPBB"); if bb then bb:Destroy() end end
        end
    end
end

local function applyESP(p)
    if p == LocalPlayer or not p.Character then return end
    local char = p.Character
    local head = char:FindFirstChild("Head")
    local hm = char:FindFirstChildOfClass("Humanoid")
    if not head or not hm then return end
    
    if not char:FindFirstChild("ESPH") then
        local hlp = Instance.new("Highlight", char)
        hlp.Name = "ESPH"; hlp.FillColor = Color3.fromRGB(255, 60, 70); hlp.OutlineColor = Color3.new(1,1,1); hlp.FillTransparency = 0.7
    end
    if not head:FindFirstChild("ESPBB") then
        local bb = Instance.new("BillboardGui", head)
        bb.Name = "ESPBB"; bb.Size = UDim2.new(0, 90, 0, 24); bb.StudsOffset = Vector3.new(0, 1.5, 0); bb.AlwaysOnTop = true; bb.Adornee = head
        local nl = Instance.new("TextLabel", bb)
        nl.Size = UDim2.new(1, 0, 0, 11); nl.BackgroundTransparency = 1; nl.Text = p.Name; nl.TextColor3 = Color3.fromRGB(255, 255, 255); nl.Font = Enum.Font.GothamBold; nl.TextSize = 9
        local bg = Instance.new("Frame", bb)
        bg.Name = "BarBg"; bg.Size = UDim2.new(1, 0, 0, 5); bg.Position = UDim2.new(0, 0, 0, 12); bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); bg.BorderSizePixel = 0
        Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 2)
        local fl = Instance.new("Frame", bg)
        fl.Name = "Fill"; fl.Size = UDim2.new(1, 0, 1, 0); fl.BackgroundColor3 = Color3.fromRGB(50, 220, 80); fl.BorderSizePixel = 0
        Instance.new("UICorner", fl).CornerRadius = UDim.new(0, 2)
    end
end

local function startESP()
    clearESP()
    for _, p in ipairs(Players:GetPlayers()) do applyESP(p) end
    table.insert(ESPConnections, RunService.Heartbeat:Connect(function()
        if not State.espOn then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hd = p.Character:FindFirstChild("Head")
                local hm = p.Character:FindFirstChildOfClass("Humanoid")
                if hd and hm then
                    local bb = hd:FindFirstChild("ESPBB")
                    if bb then
                        local bg = bb:FindFirstChild("BarBg")
                        if bg then
                            local fl = bg:FindFirstChild("Fill")
                            if fl then
                                local r = math.clamp(hm.Health / math.max(hm.MaxHealth, 1), 0, 1)
                                fl.Size = UDim2.new(r, 0, 1, 0)
                                fl.BackgroundColor3 = (r > 0.6 and Color3.fromRGB(50, 220, 80)) or (r > 0.3 and Color3.fromRGB(255, 200, 0)) or Color3.fromRGB(255, 50, 50)
                            end
                        end
                    end
                end
            end
        end
    end))
end

ESPBtn.MouseButton1Click:Connect(function()
    State.espOn = not State.espOn
    ESPBtn.Text = State.espOn and "ESP : ON" or "ESP : OFF"
    setButton(ESPBtn, State.espOn)
    if State.espOn then startESP() else clearESP() end
end)

-- SPEED CONTROL
local function applySpeed()
    local char = LocalPlayer.Character
    if not char then return end
    local hm = char:FindFirstChildOfClass("Humanoid")
    if hm then hm.WalkSpeed = State.spdOn and CONFIG.WalkSpeed or CONFIG.DefaultSpeed end
end

SpeedBtn.MouseButton1Click:Connect(function()
    State.spdOn = not State.spdOn
    SpeedBtn.Text = State.spdOn and "SPEED : ON" or "SPEED : OFF"
    setButton(SpeedBtn, State.spdOn)
    applySpeed()
end)

-- FLY (Sistem UI / Mobile Friendly)
local flyVelocity, flyGyro, flyConn
local flyDir = Vector3.zero

local function stopFly()
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
    if flyGyro then flyGyro:Destroy(); flyGyro = nil end
    local char = LocalPlayer.Character
    if char then
        local hm = char:FindFirstChildOfClass("Humanoid")
        if hm then hm.PlatformStand = false end
    end
end

local function startFly()
    stopFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hm = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hm then return end

    hm.PlatformStand = true
    flyVelocity = Instance.new("BodyVelocity", hrp)
    flyVelocity.Name = "FlyBV"
    flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyVelocity.Velocity = Vector3.zero

    flyGyro = Instance.new("BodyGyro", hrp)
    flyGyro.Name = "FlyBG"
    flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyGyro.P = 3000; flyGyro.D = 100

    flyConn = RunService.RenderStepped:Connect(function()
        if not State.flyOn or not hrp or not hrp.Parent then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        
        local speed = CONFIG.FlySpeed
        local mv = hm.MoveDirection
        local dir = Vector3.zero
        
        if mv.Magnitude > 0.05 then
            local lk = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
            local rt = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
            if lk.Magnitude > 0.001 then lk = lk.Unit end
            if rt.Magnitude > 0.001 then rt = rt.Unit end
            dir = (lk * -mv.Z + rt * mv.X).Unit
        end
        
        flyDir = flyDir:Lerp(dir, 0.2) -- Smoothening
        flyVelocity.Velocity = flyDir * speed
        if flyDir.Magnitude > 0.01 then flyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + flyDir) end
    end)
end

FlyBtn.MouseButton1Click:Connect(function()
    State.flyOn = not State.flyOn
    FlyBtn.Text = State.flyOn and "FLY : ON" or "FLY : OFF"
    setButton(FlyBtn, State.flyOn)
    if State.flyOn then startFly() else stopFly() end
end)
--[[ XAUZY HUB V2 - BAGIAN 3/4 ]]
-- AIM LOCK
local AimConn, AimBeamData
local function clearAimVisual()
    if AimBeamData and AimBeamData.att and AimBeamData.att.Parent then pcall(function() AimBeamData.att:Destroy() end) end
    AimBeamData = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, d in ipairs(p.Character:GetDescendants()) do
                if d.Name == "AimAtt" then pcall(function() d:Destroy() end) end
            end
        end
    end
end

local function createBeam()
    clearAimVisual()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Head") then return end
    local att = Instance.new("Attachment", char.Head); att.Name = "AimAtt"
    local beam = Instance.new("Beam", att)
    beam.Attachment0 = att; beam.Attachment1 = att
    beam.Width0 = 0.12; beam.Width1 = 0.04; beam.Color = ColorSequence.new(C.RD)
    beam.FaceCamera = true; beam.Transparency = NumberSequence.new(0.3); beam.Enabled = false
    AimBeamData = { att = att, beam = beam }
end

local function findTarget(mode)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local myHrp = char.HumanoidRootPart
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hm = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hm and hm.Health > 0 then
                local pt = (mode == "head" and p.Character:FindFirstChild("Head")) or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or hrp
                if pt then
                    local d = (hrp.Position - myHrp.Position).Magnitude
                    if d < bestDist then bestDist = d; best = pt end
                end
            end
        end
    end
    return best
end

local function stopAim()
    if AimConn then AimConn:Disconnect(); AimConn = nil end
    clearAimVisual()
end

local function startAim(mode)
    stopAim(); createBeam()
    AimConn = RunService.RenderStepped:Connect(function()
        if (mode == "head" and not State.aimHeadOn) or (mode == "body" and not State.aimBodyOn) then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local target = findTarget(mode)
        if not target or not target.Parent then
            if AimBeamData and AimBeamData.beam then AimBeamData.beam.Enabled = false end
            return
        end
        cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), CONFIG.AimLerp)
        if AimBeamData and AimBeamData.beam then
            local a1 = target:FindFirstChild("AimAtt")
            if not a1 then a1 = Instance.new("Attachment", target); a1.Name = "AimAtt" end
            AimBeamData.beam.Attachment1 = a1; AimBeamData.beam.Enabled = true
        end
    end)
end

AimHeadBtn.MouseButton1Click:Connect(function()
    State.aimHeadOn = not State.aimHeadOn
    AimHeadBtn.Text = State.aimHeadOn and "AIM LOCK HEAD : ON" or "AIM LOCK HEAD : OFF"
    setButton(AimHeadBtn, State.aimHeadOn)
    if State.aimHeadOn then State.aimBodyOn = false; AimBodyBtn.Text = "AIM LOCK BODY : OFF"; setButton(AimBodyBtn, false); startAim("head")
    else stopAim() end
end)

AimBodyBtn.MouseButton1Click:Connect(function()
    State.aimBodyOn = not State.aimBodyOn
    AimBodyBtn.Text = State.aimBodyOn and "AIM LOCK BODY : ON" or "AIM LOCK BODY : OFF"
    setButton(AimBodyBtn, State.aimBodyOn)
    if State.aimBodyOn then State.aimHeadOn = false; AimHeadBtn.Text = "AIM LOCK HEAD : OFF"; setButton(AimHeadBtn, false); startAim("body")
    else stopAim() end
end)

-- PANEL HELPER
local function createPanel(name, titleText, width, height)
    local panel = Instance.new("Frame", ScreenGui)
    panel.Name = name; panel.Size = UDim2.new(0, width, 0, height); panel.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    panel.BackgroundColor3 = C.BG; panel.BorderSizePixel = 0; panel.Visible = false; panel.ZIndex = 10
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)
    local ps = Instance.new("UIStroke", panel); ps.Color = C.RD; ps.Thickness = 1.5
    
    local h = Instance.new("Frame", panel)
    h.Size = UDim2.new(1, 0, 0, 38); h.BackgroundColor3 = C.HD; h.BorderSizePixel = 0; h.ZIndex = 11
    Instance.new("UICorner", h).CornerRadius = UDim.new(0, 14)
    
    local t = Instance.new("TextLabel", h)
    t.Size = UDim2.new(1, -34, 1, 0); t.Position = UDim2.new(0, 12, 0, 0); t.BackgroundTransparency = 1; t.Text = titleText
    t.TextColor3 = C.RD; t.Font = Enum.Font.GothamBold; t.TextSize = 12; t.TextXAlignment = Enum.TextXAlignment.Left; t.ZIndex = 12
    
    local x = Instance.new("TextButton", h)
    x.Size = UDim2.new(0, 22, 0, 22); x.Position = UDim2.new(1, -26, 0.5, -11); x.BackgroundColor3 = C.RDD; x.Text = "X"
    x.TextColor3 = C.TX; x.Font = Enum.Font.GothamBold; x.TextSize = 12; x.BorderSizePixel = 0; x.ZIndex = 12
    Instance.new("UICorner", x).CornerRadius = UDim.new(0, 6)
    
    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Size = UDim2.new(1, -14, 1, -52); scroll.Position = UDim2.new(0, 7, 0, 44); scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = C.RD; scroll.CanvasSize = UDim2.new(0, 0, 0, 0); scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y; scroll.ZIndex = 11
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)
    
    makeDraggable(panel, h)
    x.MouseButton1Click:Connect(function() panel.Visible = false end)
    return panel, scroll
end

local function makeListButton(parent, text, onClick)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -4, 0, 30); b.BackgroundColor3 = C.BG2; b.Text = text; b.TextColor3 = C.TX; b.Font = Enum.Font.GothamBold; b.TextSize = 10; b.AutoButtonColor = false; b.BorderSizePixel = 0; b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local st = Instance.new("UIStroke", b); st.Color = C.RD; st.Thickness = 1; st.Transparency = 0.55
    b.MouseButton1Click:Connect(onClick)
    return b
end

-- TELEPORT
local TPFrame, TPScroll = createPanel("TeleportPanel", "TELEPORT", 190, 270)
local function refreshTP()
    for _, c in ipairs(TPScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            makeListButton(TPScroll, p.Name, function()
                local myChar = LocalPlayer.Character
                if myChar and p.Character then
                    local th = p.Character:FindFirstChild("HumanoidRootPart")
                    if th then if pcall(function() myChar:PivotTo(th.CFrame * CFrame.new(0, 0, 2)) end) then showNotif("TP ke "..p.Name) end end
                end
            end)
        end
    end
end
TPBtn.MouseButton1Click:Connect(function() TPFrame.Visible = not TPFrame.Visible; if TPFrame.Visible then refreshTP() end end)

-- COPY AVA (FIXED)
local CPFrame, CPScroll = createPanel("CopyAvaPanel", "COPY AVA", 210, 290)

local function applyAvatar(userId, name)
    local char = LocalPlayer.Character
    if not char then return showNotif("Karakter tidak ditemukan") end
    local hm = char:FindFirstChildOfClass("Humanoid")
    if not hm then return showNotif("Humanoid tidak ditemukan") end
    
    showNotif("Memuat AVA "..name.."...")
    task.spawn(function()
        -- Ambil data avatar
        local suc, desc = pcall(function()
            return Players:GetHumanoidDescriptionFromUserId(userId)
        end)
        if not suc or not desc then return showNotif("Gagal mengambil data avatar") end

        -- Trick: Matikan state agar bisa copy
        local oldState = hm:GetState()
        pcall(function() hm:ChangeState(Enum.HumanoidStateType.Physics) end)
        
        -- Coba ApplyDescription
        local ok = pcall(function() hm:ApplyDescription(desc) end)
        
        -- Jika gagal, coba Reset
        if not ok then
            ok = pcall(function() hm:ApplyDescriptionReset(desc) end)
        end
        
        -- Kembalikan state
        pcall(function() hm:ChangeState(oldState) end)

        if ok then showNotif("AVA "..name.." berhasil!") 
        else showNotif("Game memblokir Copy AVA") end
    end)
end

local function refreshCP()
    for _, c in ipairs(CPScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then 
            makeListButton(CPScroll, p.Name, function() applyAvatar(p.UserId, p.Name) end) 
        end
    end
    for _, pName in ipairs({"HerulAjaDeh", "kojayy1"}) do
        makeListButton(CPScroll, pName, function()
            local id = 0; pcall(function() id = Players:GetUserIdFromNameAsync(pName) end)
            if id > 0 then applyAvatar(id, pName) else showNotif("User tidak ditemukan") end
        end)
    end
end
CopyBtn.MouseButton1Click:Connect(function() CPFrame.Visible = not CPFrame.Visible; if CPFrame.Visible then refreshCP() end end)--[[ XAUZY HUB V2 - BAGIAN 4/4 ]]
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if State.spdOn then
        local hm = char:FindFirstChildOfClass("Humanoid")
        if hm then hm.WalkSpeed = CONFIG.WalkSpeed end
    end
    if State.flyOn then startFly() end
    if State.aimHeadOn then createBeam() elseif State.aimBodyOn then createBeam() end
    if State.espOn then
        task.wait(0.5)
        for _, p in ipairs(Players:GetPlayers()) do applyESP(p) end
    end
end)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Size = isMinimized and UDim2.new(0, 240, 0, 48) or UDim2.new(0, 240, 0, 380)
    Body.Visible = not isMinimized
    MinBtn.Text = isMinimized and "+" or "-"
end)

CloseBtn.MouseButton1Click:Connect(function()
    State.espOn = false; clearESP()
    State.flyOn = false; stopFly()
    State.spdOn = false; applySpeed()
    State.aimHeadOn = false; State.aimBodyOn = false; stopAim()
    if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
end)

makeDraggable(MainFrame, Header)
showNotif("Xauzy Hub V2 Dimuat!")