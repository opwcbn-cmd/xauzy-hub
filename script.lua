
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
mf.Size=UDim2.new(0,220,0,330)
mf.Position=UDim2.new(0.5,-110,0.5,-165)
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
hd.Size=UDim2.new(1,0,0,45)
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
local logo=Instance.new("TextLabel",hd)
logo.Size=UDim2.new(0,32,0,32)
logo.Position=UDim2.new(0,8,0.5,-16)
logo.BackgroundColor3=RDD
logo.Text="XY"
logo.TextColor3=TX
logo.Font=Enum.Font.GothamBlack
logo.TextSize=14
logo.BorderSizePixel=0
logo.ZIndex=2
Instance.new("UICorner",logo).CornerRadius=UDim.new(0,8)
local tt=Instance.new("TextLabel",hd)
tt.Size=UDim2.new(1,-100,1,0)
tt.Position=UDim2.new(0,48,0,0)
tt.BackgroundTransparency=1
tt.Text="XAUZY HUB"
tt.TextColor3=TX
tt.Font=Enum.Font.GothamBold
tt.TextSize=13
tt.TextXAlignment=Enum.TextXAlignment.Left
tt.ZIndex=2
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
bd.Size=UDim2.new(1,-20,1,-60)
bd.Position=UDim2.new(0,10,0,50)
bd.BackgroundTransparency=1
local lay=Instance.new("UIListLayout",bd)
lay.Padding=UDim.new(0,6)
lay.SortOrder=Enum.SortOrder.LayoutOrder
local btnStrokes={}
local function mk(t,o,par)
    local b=Instance.new("TextButton",par or bd)
    b.Size=UDim2.new(1,0,0,32)
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
    btnStrokes[b]=s
    b.MouseEnter:Connect(function()
        if b.BackgroundColor3~=RDD then
            b.BackgroundColor3=Color3.fromRGB(38,10,15)
            s.Transparency=0.2
        end
    end)
    b.MouseLeave:Connect(function()
        if b.BackgroundColor3~=RDD then
            b.BackgroundColor3=BG2
            s.Transparency=0.55
        end
    end)
    return b
end
local function setBtn(b,on)
    local s=btnStrokes[b]
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
local aHB=mk("AIM LOCK HEAD : OFF",4)
local aBB=mk("AIM LOCK BODY : OFF",5)
local tpB=mk("TELEPORT",6)
local cpB=mk("COPY AVA",7)
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
        local hlp=Instance.new("Highlight",c)
        hlp.Name="ESPH"
        hlp.FillColor=Color3.fromRGB(255,60,70)
        hlp.OutlineColor=Color3.new(1,1,1)
        hlp.FillTransparency=0.7
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
    return ls[1].p
end
local function stopAim()
    if aimC then aimC:Disconnect()aimC=nil end
    clrAim()
end
local function startAim(mode)
    stopAim()
    mkBeam()
    aimC=R.RenderStepped:Connect(function()
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
        cam.CFrame=cam.CFrame:Lerp(tcf,0.25)
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
    aHB.Text=aHOn and "AIM LOCK HEAD : ON"or"AIM LOCK HEAD : OFF"
    setBtn(aHB,aHOn)
    if aHOn then
        aBOn=false
        aBB.Text="AIM LOCK BODY : OFF"
        setBtn(aBB,false)
        startAim("head")
    else
        stopAim()
    end
end)
aBB.MouseButton1Click:Connect(function()
    aBOn=not aBOn
    aBB.Text=aBOn and "AIM LOCK BODY : ON"or"AIM LOCK BODY : OFF"
    setBtn(aBB,aBOn)
    if aBOn then
        aHOn=false
        aHB.Text="AIM LOCK HEAD : OFF"
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
                local th=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if th then
                    mc:PivotTo(th.CFrame*CFrame.new(0,0,2))
                    b.Text="TP OK"
                    task.wait(0.5)
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
local cpM=Instance.new("Frame",sg)
cpM.Size=UDim2.new(0,190,0,260)
cpM.Position=UDim2.new(0.5,-95,0.5,-130)
cpM.BackgroundColor3=BG
cpM.BorderSizePixel=0
cpM.Visible=false
cpM.ZIndex=10
Instance.new("UICorner",cpM).CornerRadius=UDim.new(0,12)
local cps=Instance.new("UIStroke",cpM)
cps.Color=RD
cps.Thickness=1.5
local cpH=Instance.new("Frame",cpM)
cpH.Size=UDim2.new(1,0,0,36)
cpH.BackgroundColor3=HD
cpH.BorderSizePixel=0
cpH.ZIndex=11
Instance.new("UICorner",cpH).CornerRadius=UDim.new(0,12)
local cpf=Instance.new("Frame",cpH)
cpf.Size=UDim2.new(1,0,0,10)
cpf.Position=UDim2.new(0,0,1,-10)
cpf.BackgroundColor3=HD
cpf.BorderSizePixel=0
cpf.ZIndex=11
local cpL2=Instance.new("Frame",cpH)
cpL2.Size=UDim2.new(1,-20,0,1)
cpL2.Position=UDim2.new(0,10,1,-1)
cpL2.BackgroundColor3=RD
cpL2.BorderSizePixel=0
cpL2.ZIndex=12
local cpT=Instance.new("TextLabel",cpH)
cpT.Size=UDim2.new(1,-34,1,0)
cpT.Position=UDim2.new(0,12,0,0)
cpT.BackgroundTransparency=1
cpT.Text="COPY AVA"
cpT.TextColor3=RD
cpT.Font=Enum.Font.GothamBold
cpT.TextSize=12
cpT.TextXAlignment=Enum.TextXAlignment.Left
cpT.ZIndex=12
local cpX=Instance.new("TextButton",cpH)
cpX.Size=UDim2.new(0,22,0,22)
cpX.Position=UDim2.new(1,-26,0.5,-11)
cpX.BackgroundColor3=RDD
cpX.Text="X"
cpX.TextColor3=TX
cpX.Font=Enum.Font.GothamBold
cpX.TextSize=12
cpX.BorderSizePixel=0
cpX.ZIndex=12
Instance.new("UICorner",cpX).CornerRadius=UDim.new(0,6)
local cpS=Instance.new("ScrollingFrame",cpM)
cpS.Size=UDim2.new(1,-14,1,-50)
cpS.Position=UDim2.new(0,7,0,42)
cpS.BackgroundTransparency=1
cpS.BorderSizePixel=0
cpS.ScrollBarThickness=3
cpS.ScrollBarImageColor3=RD
cpS.CanvasSize=UDim2.new(0,0,0,0)
cpS.AutomaticCanvasSize=Enum.AutomaticSize.Y
cpS.ZIndex=11
local cpL=Instance.new("UIListLayout",cpS)
cpL.Padding=UDim.new(0,5)
cpL.SortOrder=Enum.SortOrder.LayoutOrder
local function getAv(p)
    local s,e=pcall(function()
        return P:GetHumanoidDescriptionFromUserId(p.UserId)
    end)
    if s and e then return e end
    return nil
end
local function applyAv(desc)
    local c=L.Character
    if not c then return end
    local h=c:FindFirstChildOfClass("Humanoid")
    if h and desc then
        pcall(function() h:ApplyDescription(desc) end)
    end
end
local function mkAvBtn(txt,onClick)
    local b=Instance.new("TextButton",cpS)
    b.Size=UDim2.new(1,-4,0,30)
    b.BackgroundColor3=BG2
    b.Text=txt
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
    b.MouseButton1Click:Connect(onClick)
    return b
end
local function refreshCP()
    for _,c in pairs(cpS:GetChildren())do
        if c:IsA("TextButton")then c:Destroy()end
    end
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character then
            mkAvBtn(p.Name,function()
                local d=getAv(p)
                if d then applyAv(d) end
            end)
        end
    end
    mkAvBtn("HerulAjaDeh",function()
        local id=0
        pcall(function() id=P:GetUserIdFromNameAsync("HerulAjaDeh") end)
        if id>0 then
            local s,d=pcall(function() return P:GetHumanoidDescriptionFromUserId(id) end)
            if s and d then applyAv(d) end
        end
    end)
    mkAvBtn("kojayy1",function()
        local id=0
        pcall(function() id=P:GetUserIdFromNameAsync("kojayy1") end)
        if id>0 then
            local s,d=pcall(function() return P:GetHumanoidDescriptionFromUserId(id) end)
            if s and d then applyAv(d) end
        end
    end)
end
cpB.MouseButton1Click:Connect(function()
    cpM.Visible=not cpM.Visible
    if cpM.Visible then refreshCP()end
end)
cpX.MouseButton1Click:Connect(function()cpM.Visible=false end)
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
        mf.Size=UDim2.new(0,220,0,45)
        bd.Visible=false
        mn.Text="+"
    else
        mf.Size=UDim2.new(0,220,0,330)
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
do
    local dg,ds,sp
    cpH.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dg=true
            ds=i.Position
            sp=cpM.Position
        end
    end)
    cpH.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
    end)
    U.InputChanged:Connect(function(i)
        if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
            local d=i.Position-ds
            cpM.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
end
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