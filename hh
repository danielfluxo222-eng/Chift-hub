-- Interface simples de teste
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LoginGui"

-- Tela inicial
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
mainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "Tela Inicial"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Botões
local entrarBtn = Instance.new("TextButton", mainFrame)
entrarBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
entrarBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
entrarBtn.Text = "Entrar"
entrarBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
entrarBtn.TextColor3 = Color3.new(1, 1, 1)
entrarBtn.Font = Enum.Font.SourceSansBold
entrarBtn.TextScaled = true

local cadastrarBtn = Instance.new("TextButton", mainFrame)
cadastrarBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
cadastrarBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
cadastrarBtn.Text = "Cadastrar"
cadastrarBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 90)
cadastrarBtn.TextColor3 = Color3.new(1, 1, 1)
cadastrarBtn.Font = Enum.Font.SourceSansBold
cadastrarBtn.TextScaled = true

-- Formulário de cadastro
local formFrame = Instance.new("Frame", gui)
formFrame.Size = UDim2.new(0.5, 0, 0.6, 0)
formFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
formFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
formFrame.Visible = false

local aviso = Instance.new("TextLabel", formFrame)
aviso.Size = UDim2.new(1, 0, 0.15, 0)
aviso.Text = "⚠️ Não use seu nome real"
aviso.BackgroundTransparency = 1
aviso.TextColor3 = Color3.new(1, 1, 0)
aviso.Font = Enum.Font.SourceSansBold
aviso.TextScaled = true

local nomeBox = Instance.new("TextBox", formFrame)
nomeBox.Size = UDim2.new(0.9, 0, 0.15, 0)
nomeBox.Position = UDim2.new(0.05, 0, 0.18, 0)
nomeBox.PlaceholderText = "Insira um nome"
nomeBox.Font = Enum.Font.SourceSans
nomeBox.TextScaled = true

-- Data de nascimento (3 caixas lado a lado)
local dataFrame = Instance.new("Frame", formFrame)
dataFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
dataFrame.Position = UDim2.new(0.05, 0, 0.38, 0)
dataFrame.BackgroundTransparency = 1

local dia = Instance.new("TextBox", dataFrame)
dia.Size = UDim2.new(0.3, 0, 1, 0)
dia.PlaceholderText = "Dia"
dia.Font = Enum.Font.SourceSans
dia.TextScaled = true

local mes = Instance.new("TextBox", dataFrame)
mes.Size = UDim2.new(0.3, 0, 1, 0)
mes.Position = UDim2.new(0.35, 0, 0, 0)
mes.PlaceholderText = "Mês"
mes.Font = Enum.Font.SourceSans
mes.TextScaled = true

local ano = Instance.new("TextBox", dataFrame)
ano.Size = UDim2.new(0.3, 0, 1, 0)
ano.Position = UDim2.new(0.7, 0, 0, 0)
ano.PlaceholderText = "Ano"
ano.Font = Enum.Font.SourceSans
ano.TextScaled = true

local senhaBox = Instance.new("TextBox", formFrame)
senhaBox.Size = UDim2.new(0.9, 0, 0.15, 0)
senhaBox.Position = UDim2.new(0.05, 0, 0.58, 0)
senhaBox.PlaceholderText = "Senha"
senhaBox.TextScaled = true
senhaBox.Font = Enum.Font.SourceSans

local confirmarBtn = Instance.new("TextButton", formFrame)
confirmarBtn.Size = UDim2.new(0.5, 0, 0.15, 0)
confirmarBtn.Position = UDim2.new(0.25, 0, 0.78, 0)
confirmarBtn.Text = "Confirmar"
confirmarBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
confirmarBtn.TextColor3 = Color3.new(1, 1, 1)
confirmarBtn.Font = Enum.Font.SourceSansBold
confirmarBtn.TextScaled = true

-- Funções dos botões
entrarBtn.MouseButton1Click:Connect(function()
	print("Entrou no jogo!") -- só pra testar
end)

cadastrarBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	formFrame.Visible = true
end)

confirmarBtn.MouseButton1Click:Connect(function()
	print("Cadastro feito!")
	print("Nome:", nomeBox.Text)
	print("Data:", dia.Text.."/"..mes.Text.."/"..ano.Text)
	print("Senha:", senhaBox.Text)
	formFrame.Visible = false
	mainFrame.Visible = true
end)
