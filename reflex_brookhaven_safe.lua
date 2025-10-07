-- 🃏 Reflex Hub | Brookhaven
-- by zerin

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

local Window = redzlib:MakeWindow({
    Title = "🃏reflex HUB | Brookhaven",
    SubTitle = "by zerin",
    SaveFolder = ""
})

-- Botão de minimizar com decal
Window:AddMinimizeButton({
    Button = { 
        Image = "rbxassetid://108738805961062",
        Size = UDim2.fromOffset(60, 60),
        BackgroundTransparency = 0 
    },
    Corner = { CornerRadius = UDim.new(0, 6) }
})

-- Aba PRINCIPAL
local Main = Window:MakeTab({"Principal", "star"})

-- Rael Hub Troll
Main:AddButton({
    Title = "🎭 Rael Hub Troll",
    Description = "Carrega script troll do Rael Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Laelmano24/Rael-Hub/refs/heads/main/Brookhaven/script%20troll.txt"))()
    end
})

-- Sec Hub Troll
Main:AddButton({
    Title = "🃏sec Hub Troll",
    Description = "Carrega script troll do sec Hub",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-brookhaven-v2-admin-54462"))()        
    end
})

-- Hack zeron
Main:AddButton({
    Title = "🃏hack zeron",
    Description = "Carrega hack GUI universal",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-TROLL-GUI-51920"))()
    end
})

-- Caixa de som personalizada
Main:AddButton({
    Title = "🎵 bombox zerin",
    Description = "Tocador de música customizado",
    Callback = function()
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "CaixaDeSom"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0, 250, 0, 260)
        frame.Position = UDim2.new(0.35, 0, 0.35, 0)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.Active = true
        frame.Draggable = true

        local titulo = Instance.new("TextLabel", frame)
        titulo.Size = UDim2.new(1, 0, 0, 40)
        titulo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        titulo.Text = "🎵 𝗕𝗼𝗼𝗺𝗯𝗼𝘅"
        titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
        titulo.TextScaled = true
        titulo.Font = Enum.Font.GothamBold

        local grad = Instance.new("UIGradient", titulo)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 255))
        }
        grad.Rotation = 90

        local sound = Instance.new("Sound", game.Workspace)
        sound.Volume = 5
        sound.Looped = false
        sound.Name = "CaixaSomAudio"

        local box = Instance.new("TextBox", frame)
        box.Size = UDim2.new(1, -10, 0, 30)
        box.Position = UDim2.new(0, 5, 0, 50)
        box.PlaceholderText = "ID da música aqui"
        box.Text = ""
        box.TextScaled = true
        box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)

        local function criarBotao(texto, posY, func)
            local botao = Instance.new("TextButton", frame)
            botao.Size = UDim2.new(1, -10, 0, 30)
            botao.Position = UDim2.new(0, 5, 0, posY)
            botao.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
            botao.Text = texto
            botao.TextScaled = true
            botao.TextColor3 = Color3.fromRGB(255, 255, 255)
            botao.Font = Enum.Font.GothamBold
            botao.MouseButton1Click:Connect(func)
        end

        criarBotao("▶️ Tocar", 90, function()
            if tonumber(box.Text) then
                sound.SoundId = "rbxassetid://"..box.Text
                sound:Play()
            end
        end)

        criarBotao("⏸️ Pausar", 125, function()
            if sound.IsPlaying then
                sound:Pause()
            end
        end)

        criarBotao("⏯️ Continuar", 160, function()
            if not sound.IsPlaying then
                sound:Resume()
            end
        end)

        criarBotao("⏹️ Parar", 195, function()
            sound:Stop()
        end)

        criarBotao("🔁 Loop ON/OFF", 230, function()
            sound.Looped = not sound.Looped
        end)
    end
})

-- Fly System
Main:AddButton({
    Title = "✈️ Fly System",
    Description = "Ativar/Desativar voo",
    Callback = function()
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "PainelFly"

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0, 200, 0, 150)
        frame.Position = UDim2.new(0.4, 0, 0.4, 0)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        frame.Active = true
        frame.Draggable = true

        local titulo = Instance.new("TextLabel", frame)
        titulo.Size = UDim2.new(1, 0, 0, 30)
        titulo.Text = "✈️ Fly System"
        titulo.TextScaled = true
        titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
        titulo.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        titulo.Font = Enum.Font.GothamBold

        local box = Instance.new("TextBox", frame)
        box.Size = UDim2.new(1, -10, 0, 30)
        box.Position = UDim2.new(0, 5, 0, 40)
        box.PlaceholderText = "Velocidade"
        box.Text = "50"
        box.TextScaled = true
        box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)

        local flying = false
        local vel = 50
        local bodyVel, bodyGyro

        local function startFly()
            if flying then return end
            flying = true
            vel = tonumber(box.Text) or 50
            local char = game.Players.LocalPlayer.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            bodyVel = Instance.new("BodyVelocity", root)
            bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVel.Velocity = Vector3.new(0,0,0)

            bodyGyro = Instance.new("BodyGyro", root)
            bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bodyGyro.CFrame = root.CFrame

            local uis = game:GetService("UserInputService")
            while flying do
                task.wait()
                local move = Vector3.new()
                if uis:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
                bodyVel.Velocity = move.Unit * vel
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            end
        end

        local function stopFly()
            flying = false
            if bodyVel then bodyVel:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end

        local flyBtn = Instance.new("TextButton", frame)
        flyBtn.Size = UDim2.new(1, -10, 0, 30)
        flyBtn.Position = UDim2.new(0, 5, 0, 80)
        flyBtn.Text = "🟢 Fly"
        flyBtn.TextScaled = true
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        flyBtn.Font = Enum.Font.GothamBold
        flyBtn.MouseButton1Click:Connect(startFly)

        local unflyBtn = Instance.new("TextButton", frame)
        unflyBtn.Size = UDim2.new(1, -10, 0, 30)
        unflyBtn.Position = UDim2.new(0, 5, 0, 115)
        unflyBtn.Text = "🔴 Unfly"
        unflyBtn.TextScaled = true
        unflyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        unflyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        unflyBtn.Font = Enum.Font.GothamBold
        unflyBtn.MouseButton1Click:Connect(stopFly)
    end
})

-- Jumpscare Defthekiller
Main:AddButton({
    Title = "🃏 Jumpscare Defthekiller",
    Description = "Assusta geral com som e imagem",
    Callback = function()
        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        local frame = Instance.new("ScreenGui")
        frame.Name = "JumpscareGUI"
        frame.ResetOnSpawn = false
        frame.Parent = playerGui

        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(1,0,1,0)
        img.Position = UDim2.new(0,0,0,0)
        img.Image = "rbxassetid://137475359184371"
        img.BackgroundTransparency = 1
        img.Parent = frame
        img.ZIndex = 10

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://103215672097028"
        sound.Volume = 1
        sound.Parent = frame

        task.wait(0.1)
        sound:Play()

        task.delay(20, function()
            frame:Destroy()
        end)
    end
})

-- Notificação final
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🃏joker hub",
    Text = "Hub carregado com sucesso! by zerin",
    Duration = 5
})