-- LocalScript SCR HUB - Dynamic UI
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- =========================
-- STEP 1: Splash nhỏ ban đầu
-- =========================
local splashGui = Instance.new("ScreenGui", PlayerGui)
splashGui.Name = "SCR_SPLASH"

local splashFrame = Instance.new("Frame", splashGui)
splashFrame.Size = UDim2.new(0,200,0,50)
splashFrame.Position = UDim2.new(0.5,-100,0.5,-25)
splashFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
splashFrame.BorderSizePixel = 2
splashFrame.BorderColor3 = Color3.new(0,0,0)
splashFrame.BackgroundTransparency = 0.5
splashFrame.ClipsDescendants = true

local splashText = Instance.new("TextLabel", splashFrame)
splashText.Size = UDim2.new(1,0,1,0)
splashText.Text = ""
splashText.TextColor3 = Color3.fromRGB(0,200,255)
splashText.Font = Enum.Font.SourceSansBold
splashText.TextScaled = true
splashText.BackgroundTransparency = 1

-- Hiệu ứng chữ chạy
local splashString = "SCR"
for i = 1,#splashString do
    splashText.Text = string.sub(splashString,1,i)
    wait(0.05)
end

-- =========================
-- STEP 2: Phóng to UI chính
-- =========================
local mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "SCR_HUB_UI"

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0,400,0,300)
mainFrame.Position = UDim2.new(0.5,-200,0.5,-150)
mainFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.new(0,0,0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false -- start hidden

-- Gradient
local uiGradient = Instance.new("UIGradient", mainFrame)
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160,160,160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80,80,80))
}

-- Thanh trên to
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1,0,0,50)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
topBar.BorderSizePixel = 0

-- Tiêu đề góc trái trên
local topTitle = Instance.new("TextLabel", topBar)
topTitle.Size = UDim2.new(0.5,0,1,0)
topTitle.Position = UDim2.new(0,10,0,0)
topTitle.Text = "CHÚNG TA"
topTitle.TextColor3 = Color3.fromRGB(0,0,0)
topTitle.TextScaled = true
topTitle.Font = Enum.Font.SourceSansBold
topTitle.BackgroundTransparency = 1

-- Tên tác giả dưới tiêu đề
local authorLabel = Instance.new("TextLabel", topBar)
authorLabel.Size = UDim2.new(0.5,0,0.4,0)
authorLabel.Position = UDim2.new(0,10,0.6,0)
authorLabel.Text = "NGUYỄN TRỌNG AN"
authorLabel.TextColor3 = Color3.fromRGB(0,0,0)
authorLabel.TextScaled = true
authorLabel.Font = Enum.Font.SourceSansItalic
authorLabel.BackgroundTransparency = 1

-- Thanh dưới cho tab
local bottomBar = Instance.new("Frame", mainFrame)
bottomBar.Size = UDim2.new(1,0,0,20)
bottomBar.Position = UDim2.new(0,0,1,-20)
bottomBar.BackgroundColor3 = Color3.fromRGB(90,90,90)
bottomBar.BorderSizePixel = 0

-- Nút demo tab (tối đa 5 tab)
local tabNames = {"Tab1","Tab2","Tab3","Tab4","Tab5"}
for i,tabName in pairs(tabNames) do
    local tabBtn = Instance.new("TextButton", bottomBar)
    tabBtn.Size = UDim2.new(0.18,0,1,0)
    tabBtn.Position = UDim2.new(0.18*(i-1),0,0,0)
    tabBtn.Text = tabName
    tabBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
    tabBtn.BorderSizePixel = 0
end

-- =========================
-- STEP 3: Hiệu ứng chuyển đổi splash → UI chính
-- =========================
-- Xóa splash bằng fade out
for i = 0,1,0.05 do
    splashFrame.BackgroundTransparency = i*0.5
    splashText.TextTransparency = i
    wait(0.03)
end
splashGui:Destroy()

-- Hiện UI chính với hiệu ứng phóng to
mainFrame.Visible = true
mainFrame.Size = UDim2.new(0,50,0,30)
mainFrame.Position = UDim2.new(0.5,-25,0.5,-15)
for i = 0,1,0.05 do
    mainFrame.Size = UDim2.new(0,400*i,0,300*i)
    mainFrame.Position = UDim2.new(0.5,-200*i,0.5,-150*i)
    wait(0.02)
end

-- =========================
-- STEP 4: Nút chức năng in/out dần
-- =========================
local function createButton(name, posY)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0,100,0,40)
    btn.Position = UDim2.new(0.5,-50,posY,0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(80,80,120)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundTransparency = 1
    -- fade in
    for i=1,0,-0.1 do
        btn.BackgroundTransparency = i
        wait(0.02)
    end
end

-- Tạo 3 nút ví dụ
createButton("Nút 1", 100)
createButton("Nút 2", 150)
createButton("Nút 3", 200)
