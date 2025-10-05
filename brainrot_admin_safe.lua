-- Menu Admin Local (Safe) - Powered by redzlib quando disponível
-- Ajusta Speed e Jump localmente; tem botões seguros de "admin"
-- Ao fechar: notificação "Obrigado por usar"
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- tenta carregar redzlib (opcional)
local success, redzlib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()
end)
local usingRedz = success and type(redzlib) == "table"

-- salva valores padrão do Humanoid (para reset)
local function getHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

local defaultWalkSpeed = 16
local defaultJumpPower = 50
do
    local h = getHumanoid()
    if h then
        defaultWalkSpeed = h.WalkSpeed or defaultWalkSpeed
        defaultJumpPower = h.JumpPower or defaultJumpPower
    end
end

-- cria GUI (vai usar redzlib no título apenas; UI real é personalizada para garantir compatibilidade)
if usingRedz then
    -- se quiser, pode usar funções do redzlib aqui; vamos apenas indicar que está ativo
    print("redzlib carregado — GUI irá mostrar que está 'powered by redzlib'.")
end

-- Evita duplicar GUI
if game.CoreGui:FindFirstChild("AdminLocalGUI_by_You") then
    game.CoreGui.AdminLocalGUI_by_You:Destroy()
end

local screen = Instance.new("ScreenGui")
screen.Name = "AdminLocalGUI_by_You"
screen.ResetOnSpawn = false
screen.Parent = game.CoreGui

local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(15, 18, 23)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.ZIndex = 10
frame.Name = "MainFrame"

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -10, 0, 36)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🔧 Admin Control Panel (local)"
if usingRedz then title.Text = title.Text .. " — powered by redzlib" end
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(220,220,255)
title.TextXAlignment = Enum.TextXAlignment.Left

-- fechar button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 60, 0, 28)
closeBtn.Position = UDim2.new(1, -70, 0, 8)
closeBtn.Text = "Fechar"
closeBtn.Font = Enum.Font.Gotham
closeBtn.TextSize = 14
closeBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.AutoButtonColor = true

-- se fechar: destruir gui e notificar
local function closeGui()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Admin Panel",
            Text = "Obrigado por usar!",
            Duration = 4
        })
    end)
    screen:Destroy()
end
closeBtn.MouseButton1Click:Connect(closeGui)

-- se quiser minimizar (decorativo)
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 60, 0, 28)
minBtn.Position = UDim2.new(1, -140, 0, 8)
minBtn.Text = "Minimizar"
minBtn.Font = Enum.Font.Gotham
minBtn.TextSize = 14
minBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
minBtn.AutoButtonColor = true

local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -20, 1, -56)
content.Position = UDim2.new(0, 10, 0, 48)
content.BackgroundTransparency = 1

-- Labels e TextBoxes para Speed e Jump
local function makeLabel(parent, text, y)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(0, 140, 0, 22)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(200,200,220)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function makeBox(parent, placeholder, y)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0, 150, 0, 26)
    box.Position = UDim2.new(0, 160, 0, y)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = Color3.fromRGB(240,240,240)
    box.BackgroundColor3 = Color3.fromRGB(30,30,35)
    box.BorderSizePixel = 0
    box.TextXAlignment = Enum.TextXAlignment.Center
    return box
end

makeLabel(content, "WalkSpeed (Speed):", 8)
local speedBox = makeBox(content, tostring(defaultWalkSpeed), 6)

makeLabel(content, "JumpPower (Jump):", 44)
local jumpBox = makeBox(content, tostring(defaultJumpPower), 42)

-- botões aplicar/reset para speed/jump
local function makeBtn(parent, text, x, y, w, h)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, w or 90, 0, h or 28)
    b.Position = UDim2.new(0, x, 0, y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(0,120,220)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.AutoButtonColor = true
    return b
end

local applySpeedBtn = makeBtn(content, "Aplicar Speed", 10, 84, 140)
local resetSpeedBtn = makeBtn(content, "Reset Speed", 160, 84, 140)
local applyJumpBtn = makeBtn(content, "Aplicar Jump", 10, 124, 140)
local resetJumpBtn = makeBtn(content, "Reset Jump", 160, 124, 140)

-- Funções seguras para alterar humanoid (apenas local)
local function safeSetWalkSpeed(val)
    local ok, err = pcall(function()
        local h = getHumanoid()
        if h and tonumber(val) then
            h.WalkSpeed = tonumber(val)
        end
    end)
    if not ok then
        warn("Erro ao setar WalkSpeed:", err)
    end
end

local function safeSetJumpPower(val)
    local ok, err = pcall(function()
        local h = getHumanoid()
        if h and tonumber(val) then
            h.JumpPower = tonumber(val)
        end
    end)
    if not ok then
        warn("Erro ao setar JumpPower:", err)
    end
end

applySpeedBtn.MouseButton1Click:Connect(function()
    local v = tonumber(speedBox.Text) or tonumber(speedBox.PlaceholderText) or defaultWalkSpeed
    if v < 0 then v = 0 end
    safeSetWalkSpeed(v)
    StarterGui:SetCore("SendNotification", {Title="Speed", Text="WalkSpeed definida para "..tostring(v), Duration=2})
end)

resetSpeedBtn.MouseButton1Click:Connect(function()
    safeSetWalkSpeed(defaultWalkSpeed)
    speedBox.Text = tostring(defaultWalkSpeed)
    StarterGui:SetCore("SendNotification", {Title="Speed", Text="WalkSpeed resetada para "..tostring(defaultWalkSpeed), Duration=2})
end)

applyJumpBtn.MouseButton1Click:Connect(function()
    local v = tonumber(jumpBox.Text) or tonumber(jumpBox.PlaceholderText) or defaultJumpPower
    if v < 0 then v = 0 end
    safeSetJumpPower(v)
    StarterGui:SetCore("SendNotification", {Title="Jump", Text="JumpPower definida para "..tostring(v), Duration=2})
end)

resetJumpBtn.MouseButton1Click:Connect(function()
    safeSetJumpPower(defaultJumpPower)
    jumpBox.Text = tostring(defaultJumpPower)
    StarterGui:SetCore("SendNotification", {Title="Jump", Text="JumpPower resetada para "..tostring(defaultJumpPower), Duration=2})
end)

-- Aba "Admin" com ações inofensivas
local adminLabel = Instance.new("TextLabel", content)
adminLabel.Size = UDim2.new(0, 360, 0, 22)
adminLabel.Position = UDim2.new(0, 10, 0, 170)
adminLabel.BackgroundTransparency = 1
adminLabel.Text = "Admin (ações locais e seguras)"
adminLabel.Font = Enum.Font.GothamSemibold
adminLabel.TextSize = 13
adminLabel.TextColor3 = Color3.fromRGB(200,200,220)
adminLabel.TextXAlignment = Enum.TextXAlignment.Left

local adminBtn1 = makeBtn(content, "Notificar Todos (Local)", 10, 200, 170)
local adminBtn2 = makeBtn(content, "Toggle Noclip (Local)", 200, 200, 170)
local adminBtn3 = makeBtn(content, "Teleport p/ Spawn (Local)", 10, 235, 360, 28)

-- Notificação que só aparece para você (não envia nada a outros players)
adminBtn1.MouseButton1Click:Connect(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Admin Local",
        Text = "Mensagem admin (apenas local) — testando painel",
        Duration = 4
    })
end)

-- Noclip local toggle (aplica no personagem local apenas)
local noclipOn = false
local noclipCon
adminBtn2.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    local char = LocalPlayer.Character
    if not char then
        StarterGui:SetCore("SendNotification", {Title="Noclip", Text="Personagem não encontrado.", Duration=2})
        return
    end
    if noclipOn then
        -- torna as partes CanCollide = false localmente (não afeta servidor em muitos jogos)
        noclipCon = game:GetService("RunService").Stepped:Connect(function()
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        StarterGui:SetCore("SendNotification", {Title="Noclip", Text="Noclip local ativado", Duration=2})
    else
        if noclipCon then noclipCon:Disconnect() noclipCon = nil end
        -- tenta restaurar CanCollide = true em partes físicas
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                pcall(function() part.CanCollide = true end)
            end
        end
        StarterGui:SetCore("SendNotification", {Title="Noclip", Text="Noclip local desativado", Duration=2})
    end
end)

-- Teleport para spawn local (move seu personagem local para SpawnLocation)
adminBtn3.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        StarterGui:SetCore("SendNotification", {Title="Teleport", Text="Não foi possível encontrar seu personagem.", Duration=2})
        return
    end
    local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChildWhichIsA("SpawnLocation")
    if spawn and spawn.Position then
        pcall(function()
            char.HumanoidRootPart.CFrame = CFrame.new(spawn.Position + Vector3.new(0,3,0))
        end)
        StarterGui:SetCore("SendNotification", {Title="Teleport", Text="Teleport local para spawn efetuado", Duration=2})
    else
        StarterGui:SetCore("SendNotification", {Title="Teleport", Text="Spawn não encontrado.", Duration=2})
    end
end)

-- Minimizar (apenas esconde)
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    minBtn.Text = minimized and "Restaurar" or "Minimizar"
end)

-- Remove GUI automaticamente quando o personagem morrer/spawn novamente? Apenas mantém simples: limpa quando personagem reaparece
LocalPlayer.CharacterAdded:Connect(function()
    -- opcional: reset humanoid pro padrão quando morre e reaparece
    task.delay(1, function()
        safeSetWalkSpeed(defaultWalkSpeed)
        safeSetJumpPower(defaultJumpPower)
    end)
end)

-- Foco do textbox: Enter para aplicar (melhora usabilidade)
speedBox.FocusLost:Connect(function(enter)
    if enter then
        applySpeedBtn:Activate()
    end
end)
jumpBox.FocusLost:Connect(function(enter)
    if enter then
        applyJumpBtn:Activate()
    end
end)

-- instrução final no console
print("Admin Local GUI carregada. Use com responsabilidade. (GUI criada localmente; não concede admin real.)")