-- Brainrot Hub | Speed, Jump & Sound ID
local success, redzlib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()
end)
if not success then
    warn("RedzLib não carregou.")
    return
end

-- Criar Window
local Window = redzlib:MakeWindow({
    Title = "🧠 Brainrot Server",
    SubTitle = "Speed / Jump / Sound",
    SaveFolder = ""
})

-- Botão minimizar no canto
Window:AddMinimizeButton({
    Button = { 
        Image = "rbxassetid://108738805961062",
        Size = UDim2.fromOffset(60, 60),
        BackgroundTransparency = 0
    },
    Corner = { CornerRadius = UDim.new(0, 6) }
})

-- Aba principal
local Main = Window:MakeTab({"Main", "star"})

-- Função humanoid
local function getHumanoid()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

-- Valores padrão
local defaultSpeed, defaultJump = 16, 50
do
    local h = getHumanoid()
    if h then
        defaultSpeed = h.WalkSpeed
        defaultJump = h.JumpPower
    end
end

-- Speed textbox
local speedBox = Main:AddTextBox({
    Name = "Speed",
    Default = tostring(defaultSpeed),
    Placeholder = "Digite a velocidade",
    Callback = function(val)
        local h = getHumanoid()
        if h then h.WalkSpeed = tonumber(val) or defaultSpeed end
    end
})

-- Jump textbox
local jumpBox = Main:AddTextBox({
    Name = "Jump",
    Default = tostring(defaultJump),
    Placeholder = "Digite JumpPower",
    Callback = function(val)
        local h = getHumanoid()
        if h then h.JumpPower = tonumber(val) or defaultJump end
    end
})

-- Sound ID textbox
local soundBox = Main:AddTextBox({
    Name = "Sound ID",
    Default = "",
    Placeholder = "Digite ID do som",
    Callback = function(val) end
})

-- Botão aplicar speed
Main:AddButton({
    Title = "Aplicar Speed",
    Description = "Aplica o valor do textbox",
    Callback = function()
        local h = getHumanoid()
        if h then h.WalkSpeed = tonumber(speedBox:GetText()) or defaultSpeed end
    end
})

-- Botão reset speed
Main:AddButton({
    Title = "Reset Speed",
    Description = "Reseta para padrão",
    Callback = function()
        local h = getHumanoid()
        if h then
            h.WalkSpeed = defaultSpeed
            speedBox:SetText(tostring(defaultSpeed))
        end
    end
})

-- Botão aplicar jump
Main:AddButton({
    Title = "Aplicar Jump",
    Description = "Aplica o valor do textbox",
    Callback = function()
        local h = getHumanoid()
        if h then h.JumpPower = tonumber(jumpBox:GetText()) or defaultJump end
    end
})

-- Botão reset jump
Main:AddButton({
    Title = "Reset Jump",
    Description = "Reseta para padrão",
    Callback = function()
        local h = getHumanoid()
        if h then
            h.JumpPower = defaultJump
            jumpBox:SetText(tostring(defaultJump))
        end
    end
})

-- Botão tocar som
Main:AddButton({
    Title = "▶️ Tocar som",
    Description = "Toca o som do ID",
    Callback = function()
        local id = tonumber(soundBox:GetText())
        if id then
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://"..id
            sound.Volume = 5
            sound:Play()
            task.delay(10,function() sound:Destroy() end)
        end
    end
})

-- Botão minimizar dentro do menu
Main:AddButton({
    Title = "🟢 Minimizar",
    Description = "Minimiza/Maximiza painel",
    Callback = function()
        Window:Minimize()
    end
})

-- Botão fechar com notificação
Window:AddCloseButton({
    Button = {Text="Fechar", BackgroundColor=Color3.fromRGB(0,170,255), TextColor=Color3.fromRGB(255,255,255)},
    Callback = function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Brainrot Server",
            Text = "Obrigado por usar!",
            Duration = 4
        })
    end
})

-- Notificação de inicialização
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Brainrot Server",
    Text = "Painel Speed/Jump/Sound carregado!",
    Duration = 4
})