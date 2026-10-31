--[[ XAUZY HUB RENOVATED - BAGIAN 1/4 ]]
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

-- DRAG HELPER (Dipindah ke atas biar aman)
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
MainFrame.Size = UDim2.new(0, 230, 0, 360)
MainFrame.Position = UDim2.new(0.5, -115, 0.5, -180)
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
Title.Text = "XAUZY HUB"
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

local Body = Instance.new("Frame", MainFrame)
Body.Size = UDim2.new(1, -20, 1, -62)
Body.Position = UDim2.new(0, 10, 0, 52)
Body.BackgroundTransparency = 1
Instance.new("UIListLayout", Body).Padding = UDim.new(0, 6)

local ButtonStrokes = {}
local function makeButton(text, order)
    local b = Instance.new("TextButton", Body)
    b.Size = UDim2.new(1, 0, 0, 32)
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

local ESPBtn = makeButton("ESP : OFF", 1)
local FlyBtn = makeButton("FLY : OFF", 2)
local SpeedBtn = makeButton("SPEED : OFF", 3)
local AimHeadBtn = makeButton("AIM LOCK HEAD : OFF", 4)
local AimBodyBtn = makeButton("AIM LOCK BODY : OFF", 5)
local TPBtn = makeButton("TELEPORT", 6)
local CopyBtn = makeButton("COPY AVA", 7)--[[ XAUZY HUB RENOVATED - BAGIAN 2/4 ]]
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

-- FLY
local FlyConn, FlyTouchStart, FlyTouchMove, FlyTouchEnd
local flyUpDown, flyStartY = 0, nil

local function stopFly()
    if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
    if FlyTouchStart then FlyTouchStart:Disconnect(); FlyTouchStart = nil end
    if FlyTouchMove then FlyTouchMove:Disconnect(); FlyTouchMove = nil end
    if FlyTouchEnd then FlyTouchEnd:Disconnect(); FlyTouchEnd = nil end
    flyUpDown, flyStartY = 0, nil
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hm = char:FindFirstChildOfClass("Humanoid")
        if hrp then
            local bv = hrp:FindFirstChild("FlyBV"); if bv then bv:Destroy() end
            local bg = hrp:FindFirstChild("FlyBG"); if bg then bg:Destroy() end
        end
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

    local bv = Instance.new("BodyVelocity", hrp)
    bv.Name = "FlyBV"; bv.MaxForce = Vector3.new(9e9, 9e9, 9e9); bv.Velocity = Vector3.zero
    local bg = Instance.new("BodyGyro", hrp)
    bg.Name = "FlyBG"; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bg.P = 3000; bg.D = 100
    hm.PlatformStand = true

    FlyConn = RunService.RenderStepped:Connect(function()
        if not State.flyOn or not hrp or not hrp.Parent then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local speed = State.spdOn and CONFIG.WalkSpeed or CONFIG.FlySpeed
        local mv = hm.MoveDirection
        local dir, moving = Vector3.zero, false
        if mv.Magnitude > 0.05 then
            moving = true
            local lk = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
            local rt = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
            if lk.Magnitude > 0.001 then lk = lk.Unit end
            if rt.Magnitude > 0.001 then rt = rt.Unit end
            dir = lk * -mv.Z + rt * mv.X
            if dir.Magnitude > 0.001 then dir = dir.Unit end
        end
        bv.Velocity = dir * speed + Vector3.new(0, flyUpDown * speed, 0)
        if moving then bg.CFrame = CFrame.new(hrp.Position, hrp.Position + dir) end
    end)

    FlyTouchStart = UserInputService.TouchStarted:Connect(function(i) if State.flyOn then flyStartY = i.Position.Y end end)
    FlyTouchMove = UserInputService.TouchMoved:Connect(function(i)
        if not State.flyOn or not flyStartY then return end
        local d = i.Position.Y - flyStartY
        flyUpDown = (d < -40 and 1) or (d > 40 and -1) or 0
    end)
    FlyTouchEnd = UserInputService.TouchEnded:Connect(function() flyStartY = nil; flyUpDown = 0 end)
end

FlyBtn.MouseButton1Click:Connect(function()
    State.flyOn = not State.flyOn
    FlyBtn.Text = State.flyOn and "FLY : ON" or "FLY : OFF"
    setButton(FlyBtn, State.flyOn)
    if State.flyOn then startFly() else stopFly() end
end)

-- SPEED
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
--[[ XAUZY HUB RENOVATED - BAGIAN 3/4 ]]
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

-- PANEL TELEPORT
local TPFrame, TPScroll = createPanel("TeleportPanel", "TELEPORT", 190, 270)
local function refreshTP()
    for _, c in ipairs(TPScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            makeListButton(TPScroll, p.Name, function()
                local myChar = LocalPlayer.Character
                if myChar and p.Character then
                    local th = p.Character:FindFirstChild("HumanoidRootPart")
                    if th then
                        -- PERBAIKAN: PivotTo aman dari error
                        if pcall(function() myChar:PivotTo(th.CFrame * CFrame.new(0, 0, 2)) end) then showNotif("TP ke "..p.Name) end
                    end
                end
            end)
        end
    end
end
TPBtn.MouseButton1Click:Connect(function() TPFrame.Visible = not TPFrame.Visible; if TPFrame.Visible then refreshTP() end end)

-- PANEL COPY AVA
local CPFrame, CPScroll = createPanel("CopyAvaPanel", "COPY AVA", 210, 290)
local function applyAvatar(userId, name)
    local char = LocalPlayer.Character
    if not char then return showNotif("Char gak ada") end
    local hm = char:FindFirstChildOfClass("Humanoid")
    if not hm then return showNotif("Humanoid gak ada") end
    showNotif("Loading AVA "..name.."...")
    task.spawn(function()
        local suc, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
        if not suc or not desc then return showNotif("Gagal ambil AVA") end
        if not pcall(function() hm:ApplyDescription(desc) end) then
            if not pcall(function() hm:ApplyDescriptionReset(desc) end) then return showNotif("AVA diblokir game") end
        end
        showNotif("AVA "..name.." sukses!")
    end)
end

local function refreshCP()
    for _, c in ipairs(CPScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then makeListButton(CPScroll, p.Name, function() applyAvatar(p.UserId, p.Name) end) end
    end
    for _, pName in ipairs({"HerulAjaDeh", "kojayy1"}) do
        makeListButton(CPScroll, pName, function()
            local id = 0; pcall(function() id = Players:GetUserIdFromNameAsync(pName) end)
            if id > 0 then applyAvatar(id, pName) else showNotif("User gak ketemu") end
        end)
    end
end
CopyBtn.MouseButton1Click:Connect(function() CPFrame.Visible = not CPFrame.Visible; if CPFrame.Visible then refreshCP() end end)
--[[ XAUZY HUB RENOVATED - BAGIAN 4/4 ]]
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
    MainFrame.Size = isMinimized and UDim2.new(0, 230, 0, 48) or UDim2.new(0, 230, 0, 360)
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
showNotif("Xauzy Hub Loaded!")