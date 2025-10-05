-- Brainrot Server Admin Panel (Safe & Mobile GUI)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Evita duplicar GUI
if game.CoreGui:FindFirstChild("BrainrotServerGUI") then
    game.CoreGui.BrainrotServerGUI:Destroy()
end

-- Criar ScreenGui
local screen = Instance.new("ScreenGui")
screen.Name = "BrainrotServerGUI"
screen.ResetOnSpawn = false
screen.Parent = game.CoreGui

-- Criar Frame principal
local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -10, 0, 36)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🧠 Brainrot Server"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextStrokeTransparency = 0.5
title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão fechar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 60, 0, 28)
closeBtn.Position = UDim2.new(1, -70, 0, 8)
closeBtn.Text = "Fechar"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)

-- Botão minimizar
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 60, 0, 28)
minBtn.Position = UDim2.new(1, -140, 0, 8)
minBtn.Text = "Minimizar"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
minBtn.TextColor3 = Color3.fromRGB(255,255,255)

-- Container do conteúdo
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -20, 1, -56)
content.Position = UDim2.new(0, 10, 0, 48)
content.BackgroundTransparency = 1

-- Funções para labels e boxes
local function makeLabel(parent, text, y)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(0, 140, 0, 22)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(0, 200, 255)
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
    box.Font = Enum.Font.GothamBold
    box.TextSize = 14
    box.TextColor3 = Color3.fromRGB(255, 255, 0)
    box.BackgroundColor3 = Color3.fromRGB(20,20,30)
    box.BorderSizePixel = 0
    box.TextXAlignment = Enum.TextXAlignment.Center
    return box
end

-- Labels e boxes
makeLabel(content, "WalkSpeed (Speed):", 8)
local speedBox = makeBox(content, "16", 6)
makeLabel(content, "JumpPower (Jump):", 44)
local jumpBox = makeBox(content, "50", 42)

-- Função criar botões
local function makeBtn(parent, text, x, y, w, h, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, w or 140, 0, h or 28)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BackgroundColor3 = color or Color3.fromRGB(0,120,220)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Funções seguras
local function getHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

local defaultSpeed = 16
local defaultJump = 50
do
    local h = getHumanoid()
    if h then
        defaultSpeed = h.WalkSpeed
        defaultJump = h.JumpPower
    end
end

local function safeSetWalkSpeed(val)
    local h = getHumanoid()
    if h and tonumber(val) then h.WalkSpeed = tonumber(val) end
end

local function safeSetJumpPower(val)
    local h = getHumanoid()
    if h and tonumber(val) then h.JumpPower = tonumber(val) end
end

-- Botões aplicar/reset
makeBtn(content, "Aplicar Speed", 10, 84, 140, 28, Color3.fromRGB(0,120,220), function()
    safeSetWalkSpeed(speedBox.Text ~= "" and speedBox.Text or defaultSpeed)
end)
makeBtn(content, "Reset Speed", 160, 84, 140, 28, Color3.fromRGB(255,150,0), function()
    safeSetWalkSpeed(defaultSpeed)
    speedBox.Text = tostring(defaultSpeed)
end)
makeBtn(content, "Aplicar Jump", 10, 124, 140, 28, Color3.fromRGB(0,120,220), function()
    safeSetJumpPower(jumpBox.Text ~= "" and jumpBox.Text or defaultJump)
end)
makeBtn(content, "Reset Jump", 160, 124, 140, 28, Color3.fromRGB(255,150,0), function()
    safeSetJumpPower(defaultJump)
    jumpBox.Text = tostring(defaultJump)
end)

-- fechar/minimizar
closeBtn.MouseButton1Click:Connect(function()
    StarterGui:SetCore("SendNotification", {Title="Brainrot Server", Text="Obrigado por usar!", Duration=4})
    screen:Destroy()
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    minBtn.Text = minimized and "Restaurar" or "Minimizar"
end)

-- Enter aplica automaticamente
speedBox.FocusLost:Connect(function(enter)
    if enter then safeSetWalkSpeed(speedBox.Text ~= "" and speedBox.Text or defaultSpeed) end
end)
jumpBox.FocusLost:Connect(function(enter)
    if enter then safeSetJumpPower(jumpBox.Text ~= "" and jumpBox.Text or defaultJump) end
end)

print("Brainrot Server GUI carregada com sucesso!")