local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

local Config = {
    FlySpeed = 60,
    WalkSpeed = 60,
    AimLerp = 0.35
}
local State = { esp = false, fly = false, spd = false, aimH = false, aimB = false, isVirt = false }

pcall(function() LP.PlayerGui:FindFirstChild("XauzyGui"):Destroy() end)

local SG = Instance.new("ScreenGui")
SG.Name = "XauzyGui"
SG.ResetOnSpawn = false
SG.Parent = LP:WaitForChild("PlayerGui")

local function drag(frame, handle)
    local on, start, pos
    handle.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then on = true; start = i.Position; pos = frame.Position end end)
    handle.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then on = false end end)
    UIS.InputChanged:Connect(function(i) if on and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - start; frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y) end end)
end

local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 300, 0, 220)
Main.Position = UDim2.new(0.5, -150, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 16)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Head = Instance.new("Frame", Main)
Head.Size = UDim2.new(1, 0, 0, 35)
Head.BackgroundColor3 = Color3.fromRGB(140, 12, 25)
Head.BorderSizePixel = 0
Instance.new("UICorner", Head).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Head)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "XAUZY HUB V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Head)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 27, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1, -20, 1, -45)
Body.Position = UDim2.new(0, 10, 0, 40)
Body.BackgroundTransparency = 1

local Grid = Instance.new("UIGridLayout", Body)
Grid.CellSize = UDim2.new(0, 85, 0, 40)
Grid.CellPadding = UDim2.new(0, 5, 0, 5)

local function makeBtn(txt, order)
    local b = Instance.new("TextButton", Body)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.LayoutOrder = order
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(255, 27, 45)
    b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(140, 12, 25) end)
    b.MouseLeave:Connect(function() if b.BackgroundColor3 ~= Color3.fromRGB(255, 27, 45) then b.BackgroundColor3 = Color3.fromRGB(30, 30, 33) end end)
    return b
end

local eBtn = makeBtn("ESP : OFF", 1)
local fBtn = makeBtn("FLY : OFF", 2)
local sBtn = makeBtn("SPEED : OFF", 3)
local aHBtn = makeBtn("AIM HEAD : OFF", 4)
local aBBtn = makeBtn("AIM BODY : OFF", 5)
local tBtn = makeBtn("TELEPORT", 6)
local vBtn = makeBtn("VIRTUAL AVA", 7)

local function toggle(b, isOn, txtOn, txtOff)
    b.BackgroundColor3 = isOn and Color3.fromRGB(255, 27, 45) or Color3.fromRGB(30, 30, 33)
    b.Text = isOn and txtOn or txtOff
end

-- ESP
local espConns = {}
local function clearESP()
    for _, c in ipairs(espConns) do c:Disconnect() end
    espConns = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            if p.Character:FindFirstChild("ESPH") then p.Character.ESPH:Destroy() end
            if p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("ESPBB") then p.Character.Head.ESPBB:Destroy() end
        end
    end
end

local function applyESP(p)
    if p == LP or not p.Character or not p.Character:FindFirstChild("Head") then return end
    local char = p.Character
    if not char:FindFirstChild("ESPH") then
        local h = Instance.new("Highlight", char)
        h.Name = "ESPH"; h.FillColor = Color3.fromRGB(255, 60, 70)
    end
    if not char.Head:FindFirstChild("ESPBB") then
        local bb = Instance.new("BillboardGui", char.Head)
        bb.Name = "ESPBB"; bb.Size = UDim2.new(0, 90, 0, 24); bb.StudsOffset = Vector3.new(0, 1.5, 0); bb.AlwaysOnTop = true
        local nl = Instance.new("TextLabel", bb)
        nl.Size = UDim2.new(1, 0, 0, 11); nl.BackgroundTransparency = 1; nl.Text = p.Name; nl.TextColor3 = Color3.fromRGB(255,255,255); nl.TextSize = 9
        local bg = Instance.new("Frame", bb)
        bg.Name = "BarBg"; bg.Size = UDim2.new(1, 0, 0, 5); bg.Position = UDim2.new(0, 0, 0, 12); bg.BackgroundColor3 = Color3.fromRGB(30,30,30)
        local fl = Instance.new("Frame", bg)
        fl.Name = "Fill"; fl.Size = UDim2.new(1, 0, 1, 0); fl.BackgroundColor3 = Color3.fromRGB(50, 220, 80)
    end
end

local function startESP()
    clearESP()
    for _, p in ipairs(Players:GetPlayers()) do applyESP(p) end
    table.insert(espConns, RunService.Heartbeat:Connect(function()
        if not State.esp then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChildOfClass("Humanoid") then
                local bb = p.Character.Head:FindFirstChild("ESPBB")
                if bb and bb:FindFirstChild("BarBg") and bb.BarBg:FindFirstChild("Fill") then
                    local r = math.clamp(p.Character.Humanoid.Health / p.Character.Humanoid.MaxHealth, 0, 1)
                    bb.BarBg.Fill.Size = UDim2.new(r, 0, 1, 0)
                    bb.BarBg.Fill.BackgroundColor3 = (r > 0.5 and Color3.fromRGB(50,220,80)) or Color3.fromRGB(255,50,50)
                end
            end
        end
    end))
end

eBtn.MouseButton1Click:Connect(function()
    State.esp = not State.esp
    toggle(eBtn, State.esp, "ESP : ON", "ESP : OFF")
    if State.esp then startESP() else clearESP() end
end)

-- SPEED
local function applySpeed()
    if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = State.spd and Config.WalkSpeed or 16
    end
end

sBtn.MouseButton1Click:Connect(function()
    State.spd = not State.spd
    toggle(sBtn, State.spd, "SPEED : ON", "SPEED : OFF")
    applySpeed()
end)

-- FLY
local flyV, flyG, flyC, flyY = nil, nil, nil, 0
local function stopFly()
    if flyC then flyC:Disconnect() end
    if flyV then flyV:Destroy() end
    if flyG then flyG:Destroy() end
    if LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character.Humanoid.PlatformStand = false end
    flyY = 0
end

local function startFly()
    stopFly()
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp, hm = LP.Character.HumanoidRootPart, LP.Character.Humanoid
    hm.PlatformStand = true
    flyV = Instance.new("BodyVelocity", hrp); flyV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyG = Instance.new("BodyGyro", hrp); flyG.MaxTorque = Vector3.new(9e9, 9e9, 9e9); flyG.P = 3000
    flyC = RunService.RenderStepped:Connect(function()
        if not State.fly or not hrp.Parent then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if hm.MoveDirection.Magnitude > 0.1 then
            local lk = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
            local rt = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z).Unit
            dir = (lk * -hm.MoveDirection.Z + rt * hm.MoveDirection.X).Unit
        end
        flyV.Velocity = (dir * Config.FlySpeed) + Vector3.new(0, flyY * Config.FlySpeed, 0)
        if dir.Magnitude > 0.01 then flyG.CFrame = CFrame.new(hrp.Position, hrp.Position + dir) end
    end)
end

fBtn.MouseButton1Click:Connect(function()
    State.fly = not State.fly
    toggle(fBtn, State.fly, "FLY : ON", "FLY : OFF")
    FlyUI.Visible = State.fly
    if State.fly then startFly() else stopFly() end
end)

-- FLY UI (NAIK TURUN)
local FlyUI = Instance.new("Frame", SG)
FlyUI.Size = UDim2.new(0, 60, 0, 140)
FlyUI.Position = UDim2.new(1, -80, 0.5, -70)
FlyUI.BackgroundTransparency = 1
FlyUI.Visible = false

local uBtn = Instance.new("TextButton", FlyUI)
uBtn.Size = UDim2.new(1, 0, 0, 60); uBtn.BackgroundColor3 = Color3.fromRGB(140, 12, 25); uBtn.Text = "^"; uBtn.TextColor3 = Color3.fromRGB(255,255,255); uBtn.TextSize = 30; uBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", uBtn).CornerRadius = UDim.new(0, 30)

local dBtn = Instance.new("TextButton", FlyUI)
dBtn.Size = UDim2.new(1, 0, 0, 60); dBtn.Position = UDim2.new(0, 0, 1, -60); dBtn.BackgroundColor3 = Color3.fromRGB(140, 12, 25); dBtn.Text = "v"; dBtn.TextColor3 = Color3.fromRGB(255,255,255); dBtn.TextSize = 30; dBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", dBtn).CornerRadius = UDim.new(0, 30)

uBtn.MouseButton1Down:Connect(function() flyY = 1 end)
uBtn.MouseButton1Up:Connect(function() flyY = 0 end)
dBtn.MouseButton1Down:Connect(function() flyY = -1 end)
dBtn.MouseButton1Up:Connect(function() flyY = 0 end)

-- AIM LOCK
local aimC, aimB
local function stopAim()
    if aimC then aimC:Disconnect() end
    if aimB and aimB.Parent then aimB:Destroy() end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            for _, d in ipairs(p.Character:GetDescendants()) do if d.Name == "AimAtt" then d:Destroy() end end
        end
    end
end

local function startAim(isHead)
    stopAim()
    if not LP.Character or not LP.Character:FindFirstChild("Head") then return end
    aimB = Instance.new("Attachment", LP.Character.Head)
    aimC = RunService.RenderStepped:Connect(function()
        if (isHead and not State.aimH) or (not isHead and not State.aimB) then return end
        local cam = workspace.CurrentCamera
        local target, dist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and p.Character.Humanoid.Health > 0 then
                local pt = isHead and p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
                if pt then
                    local d = (p.Character.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d; target = pt end
                end
            end
        end
        if target then
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), Config.AimLerp)
            aimB.Parent = target
        end
    end)
end

aHBtn.MouseButton1Click:Connect(function()
    State.aimH = not State.aimH
    State.aimB = false
    toggle(aHBtn, State.aimH, "AIM HEAD : ON", "AIM HEAD : OFF")
    toggle(aBBtn, false, "AIM BODY : ON", "AIM BODY : OFF")
    if State.aimH then startAim(true) else stopAim() end
end)

aBBtn.MouseButton1Click:Connect(function()
    State.aimB = not State.aimB
    State.aimH = false
    toggle(aBBtn, State.aimB, "AIM BODY : ON", "AIM BODY : OFF")
    toggle(aHBtn, false, "AIM HEAD : ON", "AIM HEAD : OFF")
    if State.aimB then startAim(false) else stopAim() end
end)

-- PANELS (Teleport & Copy Ava)
local function mkPanel(title, w, h)
    local f = Instance.new("Frame", SG)
    f.Size = UDim2.new(0, w, 0, h); f.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    f.BackgroundColor3 = Color3.fromRGB(15, 15, 16); f.Visible = false
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    local hd = Instance.new("Frame", f); hd.Size = UDim2.new(1, 0, 0, 35); hd.BackgroundColor3 = Color3.fromRGB(140, 12, 25)
    Instance.new("UICorner", hd).CornerRadius = UDim.new(0, 12)
    local t = Instance.new("TextLabel", hd); t.Size = UDim2.new(1, -40, 1, 0); t.Text = title; t.BackgroundTransparency = 1; t.TextColor3 = Color3.fromRGB(255,255,255); t.Font = Enum.Font.GothamBold; t.TextSize = 12
    local x = Instance.new("TextButton", hd); x.Size = UDim2.new(0, 25, 0, 25); x.Position = UDim2.new(1, -30, 0.5, -12); x.BackgroundColor3 = Color3.fromRGB(255,27,45); x.Text = "X"; x.TextColor3 = Color3.fromRGB(255,255,255); x.Font = Enum.Font.GothamBold
    Instance.new("UICorner", x).CornerRadius = UDim.new(0, 6)
    local sc = Instance.new("ScrollingFrame", f); sc.Size = UDim2.new(1, -10, 1, -45); sc.Position = UDim2.new(0, 5, 0, 40); sc.BackgroundTransparency = 1; sc.AutomaticCanvasSize = Enum.AutomaticSize.Y; sc.ScrollBarThickness = 3
    Instance.new("UIListLayout", sc).Padding = UDim.new(0, 5)
    drag(f, hd)
    x.MouseButton1Click:Connect(function() f.Visible = false end)
    return f, sc
end

local function mkBtn(sc, txt, callback)
    local b = Instance.new("TextButton", sc)
    b.Size = UDim2.new(1, -5, 0, 30); b.BackgroundColor3 = Color3.fromRGB(30, 30, 33); b.Text = txt; b.TextColor3 = Color3.fromRGB(255,255,255); b.Font = Enum.Font.GothamBold; b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
end

local TPFrame, TPScroll = mkPanel("TELEPORT", 180, 250)
tBtn.MouseButton1Click:Connect(function()
    TPFrame.Visible = not TPFrame.Visible
    if TPFrame.Visible then
        for _, c in ipairs(TPScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                mkBtn(TPScroll, p.Name, function()
                    if LP.Character and p.Character then LP.Character:PivotTo(p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)) end
                end)
            end
        end
    end
end)

local AVAFrame, AVAScroll = mkPanel("VIRTUAL AVA", 200, 280)
local vChar = nil
local function resetVirt()
    State.isVirt = false
    if vChar then vChar:Destroy(); vChar = nil end
    if LP.Character then
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end
            if p:IsA("Accessory") and p:FindFirstChild("Handle") then p.Handle.Transparency = 0 end
        end
    end
end

local function setVirt(id, name)
    resetVirt()
    local s, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(id) end)
    if not s or not desc then return end
    local ok, mod = pcall(function() return Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15) end)
    if ok and mod then
        vChar = mod
        for _, o in ipairs(vChar:GetDescendants()) do if o:IsA("Script") then o:Destroy() end end
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then vChar:PivotTo(LP.Character.HumanoidRootPart.CFrame) end
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 1 end
            if p:IsA("Accessory") and p:FindFirstChild("Handle") then p.Handle.Transparency = 1 end
        end
        vChar.Parent = workspace
        State.isVirt = true
        RunService.RenderStepped:Connect(function()
            if not State.isVirt or not vChar.Parent or not LP.Character then return end
            vChar:PivotTo(LP.Character.HumanoidRootPart.CFrame)
        end)
    end
end

vBtn.MouseButton1Click:Connect(function()
    AVAFrame.Visible = not AVAFrame.Visible
    if AVAFrame.Visible then
        for _, c in ipairs(AVAScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        mkBtn(AVAScroll, "MATIKAN AVA", function() resetVirt() end)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then mkBtn(AVAScroll, p.Name, function() setVirt(p.UserId, p.Name) end) end
        end
    end
end)

-- CLEANUP
LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    resetVirt()
    if State.spd then applySpeed() end
    if State.fly then startFly() end
    if State.esp then startESP() end
end)

CloseBtn.MouseButton1Click:Connect(function()
    State = {esp = false, fly = false, spd = false, aimH = false, aimB = false, isVirt = false}
    clearESP()
    stopFly()
    stopAim()
    resetVirt()
    SG:Destroy()
end)

drag(Main, Head)