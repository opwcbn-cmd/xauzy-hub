loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Awesome-Invisible-man-21074"))()
local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local L=P.LocalPlayer
local BG=Color3.fromRGB(15,15,16)
local BG2=Color3.fromRGB(24,24,26)
local HD=Color3.fromRGB(20,20,22)
local RD=Color3.fromRGB(255,27,45)
local RDD=Color3.fromRGB(140,12,25)
local TX=Color3.fromRGB(240,240,240)
pcall(function()local o=L:WaitForChild("PlayerGui"):FindFirstChild("XauzyGui")if o then o:Destroy()end end)
local sg=Instance.new("ScreenGui")
sg.Name="XauzyGui"
sg.ResetOnSpawn=false
sg.DisplayOrder=999
sg.Parent=L:WaitForChild("PlayerGui")
local mf=Instance.new("Frame",sg)
mf.Size=UDim2.new(0,210,0,300)
mf.Position=UDim2.new(0.5,-105,0.5,-150)
mf.BackgroundColor3=BG
mf.BorderSizePixel=0
Instance.new("UICorner",mf).CornerRadius=UDim.new(0,12)
local ms=Instance.new("UIStroke",mf)
ms.Color=RD
ms.Thickness=1.5
ms.Transparency=0.15
local gw=Instance.new("UIStroke",mf)
gw.Color=RD
gw.Thickness=6
gw.Transparency=0.85
local hd=Instance.new("Frame",mf)
hd.Size=UDim2.new(1,0,0,42)
hd.BackgroundColor3=HD
hd.BorderSizePixel=0
Instance.new("UICorner",hd).CornerRadius=UDim.new(0,12)
local hf=Instance.new("Frame",hd)
hf.Size=UDim2.new(1,0,0,12)
hf.Position=UDim2.new(0,0,1,-12)
hf.BackgroundColor3=HD
hf.BorderSizePixel=0
local hl=Instance.new("Frame",hd)
hl.Size=UDim2.new(1,-20,0,1)
hl.Position=UDim2.new(0,10,1,-1)
hl.BackgroundColor3=RD
hl.BorderSizePixel=0
hl.ZIndex=2
local tt=Instance.new("TextLabel",hd)
tt.Size=UDim2.new(1,-70,1,0)
tt.Position=UDim2.new(0,14,0,0)
tt.BackgroundTransparency=1
tt.Text="XAUZY"
tt.TextColor3=RD
tt.Font=Enum.Font.GothamBold
tt.TextSize=15
tt.TextXAlignment=Enum.TextXAlignment.Left
tt.ZIndex=2
local dt=Instance.new("Frame",hd)
dt.Size=UDim2.new(0,6,0,6)
dt.Position=UDim2.new(0,88,0.5,-3)
dt.BackgroundColor3=RD
dt.BorderSizePixel=0
Instance.new("UICorner",dt).CornerRadius=UDim.new(1,0)
dt.ZIndex=2
local mn=Instance.new("TextButton",hd)
mn.Size=UDim2.new(0,22,0,22)
mn.Position=UDim2.new(1,-50,0.5,-11)
mn.BackgroundColor3=BG2
mn.Text="-"
mn.TextColor3=TX
mn.Font=Enum.Font.GothamBold
mn.TextSize=14
mn.BorderSizePixel=0
Instance.new("UICorner",mn).CornerRadius=UDim.new(0,6)
local mns=Instance.new("UIStroke",mn)
mns.Color=RD
mns.Thickness=1
mns.Transparency=0.5
local cb=Instance.new("TextButton",hd)
cb.Size=UDim2.new(0,22,0,22)
cb.Position=UDim2.new(1,-26,0.5,-11)
cb.BackgroundColor3=RDD
cb.Text="X"
cb.TextColor3=TX
cb.Font=Enum.Font.GothamBold
cb.TextSize=12
cb.BorderSizePixel=0
Instance.new("UICorner",cb).CornerRadius=UDim.new(0,6)
local cbs=Instance.new("UIStroke",cb)
cbs.Color=RD
cbs.Thickness=1
local bd=Instance.new("Frame",mf)
bd.Size=UDim2.new(1,-20,1,-58)
bd.Position=UDim2.new(0,10,0,48)
bd.BackgroundTransparency=1
local lay=Instance.new("UIListLayout",bd)
lay.Padding=UDim.new(0,7)
lay.SortOrder=Enum.SortOrder.LayoutOrder
local function mk(t,o)
    local b=Instance.new("TextButton",bd)
    b.Size=UDim2.new(1,0,0,34)
    b.BackgroundColor3=BG2
    b.Text=t
    b.TextColor3=TX
    b.Font=Enum.Font.GothamBold
    b.TextSize=11
    b.AutoButtonColor=false
    b.BorderSizePixel=0
    b.LayoutOrder=o
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    local s=Instance.new("UIStroke",b)
    s.Color=RD
    s.Thickness=1
    s.Transparency=0.55
    b.MouseEnter:Connect(function()
        if not b:GetAttribute("on") then
            b.BackgroundColor3=Color3.fromRGB(38,10,15)
            s.Transparency=0.2
        end
    end)
    b.MouseLeave:Connect(function()
        if not b:GetAttribute("on") then
            b.BackgroundColor3=BG2
            s.Transparency=0.55
        end
    end)
    b:SetAttribute("stroke",s)
    return b
end
local function setBtn(b,on)
    b:SetAttribute("on",on)
    local s=b:GetAttribute("stroke")
    if on then
        b.BackgroundColor3=RDD
        b.TextColor3=TX
        if s then s.Color=RD s.Transparency=0 end
    else
        b.BackgroundColor3=BG2
        b.TextColor3=TX
        if s then s.Color=RD s.Transparency=0.55 end
    end
end
local espB=mk("ESP : OFF",1)
local flyB=mk("FLY : OFF",2)
local spdB=mk("SPEED : OFF",3)
local aHB=mk("AIM HEAD : OFF",4)
local aBB=mk("AIM BODY : OFF",5)
local tpB=mk("TELEPORT",6)
local espOn,flyOn,spdOn,aHOn,aBOn=false,false,false,false,false
local FLY_S,WALK_S=55,60
local flyC,aimC
local tS1,tM1,tE1
local upDown,tStartY=0,nil
local function mkESP(p)
    local c=p.Character
    if not c then return end
    local h=c:FindFirstChild("Head")
    local hm=c:FindFirstChildOfClass("Humanoid")
    if not h or not hm then return end
    if not c:FindFirstChild("ESPH")then
        local hl=Instance.new("Highlight",c)
        hl.Name="ESPH"
        hl.FillColor=Color3.fromRGB(255,60,70)
        hl.OutlineColor=Color3.new(1,1,1)
        hl.FillTransparency=0.7
    end
    if not h:FindFirstChild("ESPBB")then
        local bb=Instance.new("BillboardGui",h)
        bb.Name="ESPBB"
        bb.Size=UDim2.new(0,90,0,24)
        bb.StudsOffset=Vector3.new(0,1.5,0)
        bb.AlwaysOnTop=true
        bb.Adornee=h
        local nl=Instance.new("TextLabel",bb)
        nl.Size=UDim2.new(1,0,0,11)
        nl.BackgroundTransparency=1
        nl.Text=p.Name
        nl.TextColor3=Color3.fromRGB(255,255,255)
        nl.TextStrokeTransparency=0.4
        nl.TextStrokeColor3=Color3.fromRGB(0,0,0)
        nl.Font=Enum.Font.GothamBold
        nl.TextSize=9
        local bg2=Instance.new("Frame",bb)
        bg2.Name="BarBg"
        bg2.Size=UDim2.new(1,0,0,5)
        bg2.Position=UDim2.new(0,0,0,12)
        bg2.BackgroundColor3=Color3.fromRGB(30,30,30)
        bg2.BorderSizePixel=0
        Instance.new("UICorner",bg2).CornerRadius=UDim.new(0,2)
        local bf=Instance.new("Frame",bg2)
        bf.Name="Fill"
        bf.Size=UDim2.new(1,0,1,0)
        bf.BackgroundColor3=Color3.fromRGB(50,220,80)
        bf.BorderSizePixel=0
        Instance.new("UICorner",bf).CornerRadius=UDim.new(0,2)
    end
end
local function clrESP()
    for _,p in pairs(P:GetPlayers())do
        if p.Character then
            local h=p.Character:FindFirstChild("ESPH")if h then h:Destroy()end
            local hd2=p.Character:FindFirstChild("Head")
            if hd2 then local bb=hd2:FindFirstChild("ESPBB")if bb then bb:Destroy()end end
        end
    end
end
espB.MouseButton1Click:Connect(function()
    espOn=not espOn
    espB.Text=espOn and "ESP : ON"or"ESP : OFF"
    setBtn(espB,espOn)
    if not espOn then clrESP()end
end)
local function startFly()
    local c=L.Character
    if not c then return end
    local hrp=c:FindFirstChild("HumanoidRootPart")
    local hm=c:FindFirstChildOfClass("Humanoid")
    if not hrp or not hm then return end
    local o1=hrp:FindFirstChild("FlyBV")if o1 then o1:Destroy()end
    local o2=hrp:FindFirstChild("FlyBG")if o2 then o2:Destroy()end
    local bv=Instance.new("BodyVelocity",hrp)
    bv.Name="FlyBV"
    bv.MaxForce=Vector3.new(9e9,9e9,9e9)
    bv.Velocity=Vector3.zero
    local bg=Instance.new("BodyGyro",hrp)
    bg.Name="FlyBG"
    bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
    bg.P=3000
    bg.D=100
    hm.PlatformStand=true
    if flyC then flyC:Disconnect()end
    flyC=R.RenderStepped:Connect(function()
        if not flyOn then return end
        if not hrp or not hrp.Parent then return end
        local s=FLY_S
        if spdOn then s=WALK_S end
        local cam=workspace.CurrentCamera
        if not cam then return end
        local mv=hm.MoveDirection
        local d=Vector3.zero
        local mo=false
        if mv.Magnitude>0.05 then
            mo=true
            local lk=Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z)
            local rt=Vector3.new(cam.CFrame.RightVector.X,0,cam.CFrame.RightVector.Z)
            if lk.Magnitude>0.001 then lk=lk.Unit end
            if rt.Magnitude>0.001 then rt=rt.Unit end
            d=lk*-mv.Z+rt*mv.X
            if d.Magnitude>0.001 then d=d.Unit end
        end
        bv.Velocity=d*s+Vector3.new(0,upDown*s,0)
        if mo then bg.CFrame=CFrame.new(hrp.Position,hrp.Position+d)end
    end)
    if tS1 then tS1:Disconnect()end
    if tM1 then tM1:Disconnect()end
    if tE1 then tE1:Disconnect()end
    tS1=U.TouchStarted:Connect(function(i)if not flyOn then return end tStartY=i.Position.Y end)
    tM1=U.TouchMoved:Connect(function(i)
        if not flyOn or not tStartY then return end
        local dd=i.Position.Y-tStartY
        if dd<-40 then upDown=1 elseif dd>40 then upDown=-1 else upDown=0 end
    end)
    tE1=U.TouchEnded:Connect(function()tStartY=nil upDown=0 end)
end
local function stopFly()
    if flyC then flyC:Disconnect()flyC=nil end
    if tS1 then tS1:Disconnect()tS1=nil end
    if tM1 then tM1:Disconnect()tM1=nil end
    if tE1 then tE1:Disconnect()tE1=nil end
    upDown=0
    tStartY=nil
    local c=L.Character
    if c then
        local hrp=c:FindFirstChild("HumanoidRootPart")
        local hm=c:FindFirstChildOfClass("Humanoid")
        if hrp then
            local bv=hrp:FindFirstChild("FlyBV")if bv then bv:Destroy()end
            local bg=hrp:FindFirstChild("FlyBG")if bg then bg:Destroy()end
        end
        if hm then hm.PlatformStand=false end
    end
end
flyB.MouseButton1Click:Connect(function()
    flyOn=not flyOn
    flyB.Text=flyOn and "FLY : ON"or"FLY : OFF"
    setBtn(flyB,flyOn)
    if flyOn then startFly()else stopFly()end
end)
spdB.MouseButton1Click:Connect(function()
    spdOn=not spdOn
    spdB.Text=spdOn and "SPEED : ON"or"SPEED : OFF"
    setBtn(spdB,spdOn)
    local c=L.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=spdOn and WALK_S or 16 end
    end
end)
local aimBeam=nil
local function clrAim()
    if aimBeam and aimBeam.att and aimBeam.att.Parent then aimBeam.att:Destroy()end
    aimBeam=nil
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character then
            for _,d in pairs(p.Character:GetDescendants())do
                if d.Name=="AimAtt"then d:Destroy()end
            end
        end
    end
end
local function mkBeam()
    clrAim()
    local c=L.Character
    if not c then return end
    local h=c:FindFirstChild("Head")
    if not h then return end
    local a=Instance.new("Attachment",h)
    a.Name="AimAtt"
    local b=Instance.new("Beam",a)
    b.Attachment0=a
    b.Attachment1=a
    b.Width0=0.12
    b.Width1=0.04
    b.Color=ColorSequence.new(Color3.fromRGB(255,60,70))
    b.FaceCamera=true
    b.Transparency=NumberSequence.new(0.3)
    b.Enabled=false
    aimBeam={att=a,beam=b}
end
local function findT(mode)
    local c=L.Character
    if not c then return nil end
    local mh=c:FindFirstChild("HumanoidRootPart")
    if not mh then return nil end
    local ls={}
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character then
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            local hm=p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hm and hm.Health>0 then
                local pt
                if mode=="head"then
                    pt=p.Character:FindFirstChild("Head")
                else
                    pt=p.Character:FindFirstChild("UpperTorso")or p.Character:FindFirstChild("Torso")or hrp
                end
                if pt then
                    local d=(hrp.Position-mh.Position).Magnitude
                    table.insert(ls,{p=pt,d=d})
                end
            end
        end
    end
    if #ls==0 then return nil end
    table.sort(ls,function(a,b)return a.d<b.d end)
    local fl={}
    for _,v in ipairs(ls)do
        if v.d>=20 and v.d<=250 then table.insert(fl,v)end
    end
    if #fl==0 then return ls[math.floor(#ls/2)+1].p end
    return fl[math.floor(#fl/2)+1].p
end
local function stopAim()
    if aimC then aimC:Disconnect()aimC=nil end
    clrAim()
end
local function startAim(mode)
    stopAim()
    mkBeam()
    aimC=R.Heartbeat:Connect(function()
        if mode=="head"and not aHOn then return end
        if mode=="body"and not aBOn then return end
        local cam=workspace.CurrentCamera
        if not cam then return end
        local t=findT(mode)
        if not t or not t.Parent then
            if aimBeam and aimBeam.beam then aimBeam.beam.Enabled=false end
            return
        end
        local tcf=CFrame.new(cam.CFrame.Position,t.Position)
        cam.CFrame=cam.CFrame:Lerp(tcf,0.45)
        if aimBeam and aimBeam.beam then
            local a1=t:FindFirstChild("AimAtt")
            if not a1 then
                a1=Instance.new("Attachment",t)
                a1.Name="AimAtt"
            end
            aimBeam.beam.Attachment1=a1
            aimBeam.beam.Enabled=true
        end
    end)
end
aHB.MouseButton1Click:Connect(function()
    aHOn=not aHOn
    aHB.Text=aHOn and "AIM HEAD : ON"or"AIM HEAD : OFF"
    setBtn(aHB,aHOn)
    if aHOn then
        aBOn=false
        aBB.Text="AIM BODY : OFF"
        setBtn(aBB,false)
        startAim("head")
    else
        stopAim()
    end
end)
aBB.MouseButton1Click:Connect(function()
    aBOn=not aBOn
    aBB.Text=aBOn and "AIM BODY : ON"or"AIM BODY : OFF"
    setBtn(aBB,aBOn)
    if aBOn then
        aHOn=false
        aHB.Text="AIM HEAD : OFF"
        setBtn(aHB,false)
        startAim("body")
    else
        stopAim()
    end
end)
local tpM=Instance.new("Frame",sg)
tpM.Size=UDim2.new(0,175,0,250)
tpM.Position=UDim2.new(0.5,-87,0.5,-125)
tpM.BackgroundColor3=BG
tpM.BorderSizePixel=0
tpM.Visible=false
tpM.ZIndex=10
Instance.new("UICorner",tpM).CornerRadius=UDim.new(0,12)
local tps=Instance.new("UIStroke",tpM)
tps.Color=RD
tps.Thickness=1.5
local tpH=Instance.new("Frame",tpM)
tpH.Size=UDim2.new(1,0,0,36)
tpH.BackgroundColor3=HD
tpH.BorderSizePixel=0
tpH.ZIndex=11
Instance.new("UICorner",tpH).CornerRadius=UDim.new(0,12)
local tpf=Instance.new("Frame",tpH)
tpf.Size=UDim2.new(1,0,0,10)
tpf.Position=UDim2.new(0,0,1,-10)
tpf.BackgroundColor3=HD
tpf.BorderSizePixel=0
tpf.ZIndex=11
local tpL2=Instance.new("Frame",tpH)
tpL2.Size=UDim2.new(1,-20,0,1)
tpL2.Position=UDim2.new(0,10,1,-1)
tpL2.BackgroundColor3=RD
tpL2.BorderSizePixel=0
tpL2.ZIndex=12
local tpT=Instance.new("TextLabel",tpH)
tpT.Size=UDim2.new(1,-34,1,0)
tpT.Position=UDim2.new(0,12,0,0)
tpT.BackgroundTransparency=1
tpT.Text="TELEPORT"
tpT.TextColor3=RD
tpT.Font=Enum.Font.GothamBold
tpT.TextSize=12
tpT.TextXAlignment=Enum.TextXAlignment.Left
tpT.ZIndex=12
local tpX=Instance.new("TextButton",tpH)
tpX.Size=UDim2.new(0,22,0,22)
tpX.Position=UDim2.new(1,-26,0.5,-11)
tpX.BackgroundColor3=RDD
tpX.Text="X"
tpX.TextColor3=TX
tpX.Font=Enum.Font.GothamBold
tpX.TextSize=12
tpX.BorderSizePixel=0
tpX.ZIndex=12
Instance.new("UICorner",tpX).CornerRadius=UDim.new(0,6)
local tpS=Instance.new("ScrollingFrame",tpM)
tpS.Size=UDim2.new(1,-14,1,-50)
tpS.Position=UDim2.new(0,7,0,42)
tpS.BackgroundTransparency=1
tpS.BorderSizePixel=0
tpS.ScrollBarThickness=3
tpS.ScrollBarImageColor3=RD
tpS.CanvasSize=UDim2.new(0,0,0,0)
tpS.AutomaticCanvasSize=Enum.AutomaticSize.Y
tpS.ZIndex=11
local tpL=Instance.new("UIListLayout",tpS)
tpL.Padding=UDim.new(0,5)
tpL.SortOrder=Enum.SortOrder.LayoutOrder
local function refreshTP()
    for _,c in pairs(tpS:GetChildren())do
        if c:IsA("TextButton")then c:Destroy()end
    end
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character then
            local b=Instance.new("TextButton",tpS)
            b.Size=UDim2.new(1,-4,0,30)
            b.BackgroundColor3=BG2
            b.Text=p.Name
            b.TextColor3=TX
            b.Font=Enum.Font.GothamBold
            b.TextSize=10
            b.AutoButtonColor=false
            b.BorderSizePixel=0
            b.ZIndex=12
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
            local st=Instance.new("UIStroke",b)
            st.Color=RD
            st.Thickness=1
            st.Transparency=0.55
            b.MouseButton1Click:Connect(function()
                local mc=L.Character
                if not mc then return end
                local mh=mc:FindFirstChild("HumanoidRootPart")
                local th=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if mh and th then
                    mh.CFrame=th.CFrame*CFrame.new(0,0,3)
                    b.Text="OK"
                    task.wait(0.6)
                    if b and b.Parent then b.Text=p.Name end
                end
            end)
        end
    end
end
tpB.MouseButton1Click:Connect(function()
    tpM.Visible=not tpM.Visible
    if tpM.Visible then refreshTP()end
end)
tpX.MouseButton1Click:Connect(function()tpM.Visible=false end)
do
    local dg,ds,sp
    tpH.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dg=true
            ds=i.Position
            sp=tpM.Position
        end
    end)
    tpH.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
    end)
    U.InputChanged:Connect(function(i)
        if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
            local d=i.Position-ds
            tpM.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
end
L.CharacterAdded:Connect(function()
    task.wait(0.5)
    if spdOn then
        local c=L.Character
        if c then
            local h=c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=WALK_S end
        end
    end
end)
R.RenderStepped:Connect(function()
    if not espOn then return end
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character and p.Character:FindFirstChild("Head")then
            mkESP(p)
            local hm=p.Character:FindFirstChildOfClass("Humanoid")
            local h=p.Character:FindFirstChild("Head")
            if hm and h then
                local bb=h:FindFirstChild("ESPBB")
                if bb then
                    local bg2=bb:FindFirstChild("BarBg")
                    if bg2 then
                        local fl=bg2:FindFirstChild("Fill")
                        if fl then
                            local r=math.clamp(hm.Health/math.max(hm.MaxHealth,1),0,1)
                            fl.Size=UDim2.new(r,0,1,0)
                            if r>0.6 then fl.BackgroundColor3=Color3.fromRGB(50,220,80)
                            elseif r>0.3 then fl.BackgroundColor3=Color3.fromRGB(255,200,0)
                            else fl.BackgroundColor3=Color3.fromRGB(255,50,50)end
                        end
                    end
                end
            end
        end
    end
end)
R.Heartbeat:Connect(function()
    if spdOn then
        local c=L.Character
        if c then
            local h=c:FindFirstChildOfClass("Humanoid")
            if h and h.WalkSpeed~=WALK_S then h.WalkSpeed=WALK_S end
        end
    end
end)
local min=false
mn.MouseButton1Click:Connect(function()
    min=not min
    if min then
        mf.Size=UDim2.new(0,210,0,42)
        bd.Visible=false
        mn.Text="+"
    else
        mf.Size=UDim2.new(0,210,0,300)
        bd.Visible=true
        mn.Text="-"
    end
end)
cb.MouseButton1Click:Connect(function()
    stopFly()
    stopAim()
    clrESP()
    sg:Destroy()
end)
do
    local dg,ds,sp
    hd.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dg=true
            ds=i.Position
            sp=mf.Position
        end
    end)
    hd.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
    end)
    U.InputChanged:Connect(function(i)
        if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
            local d=i.Position-ds
            mf.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
end
