-- LocalScript SCR HUB Intro -> Main UI với nút ẩn/hiện
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Engine = {UI_Created=false, ScriptName="SCR VN"}

-- ===================
-- Splash screen nhỏ
-- ===================
local splashGui = Instance.new("ScreenGui", PlayerGui)
splashGui.Name = "SCR_SPLASH"

local splashFrame = Instance.new("Frame", splashGui)
splashFrame.Size = UDim2.new(0,200,0,100)
splashFrame.Position = UDim2.new(0.5,-100,0.5,-50)
splashFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
splashFrame.BorderSizePixel = 3
splashFrame.BorderColor3 = Color3.new(0,0,0)

local splashText = Instance.new("TextLabel", splashFrame)
splashText.Size = UDim2.new(1,0,1,0)
splashText.Text = ""
splashText.TextColor3 = Color3.fromRGB(0,200,255)
splashText.Font = Enum.Font.SourceSansBold
splashText.TextScaled = true

-- Hiệu ứng chữ SCR VN xuất hiện từng ký tự
local textToShow = "SCR VN"
for i = 1,#textToShow do
    splashText.Text = string.sub(textToShow,1,i)
    wait(0.2)
end

-- ===================
-- Splash to dần thành UI chính
-- ===================
local mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "SCR_HUB_UI"

local frame = Instance.new("Frame", mainGui)
frame.Size = UDim2.new(0,200,0,100)
frame.Position = UDim2.new(0.5,-100,0.5,-50)
frame.BackgroundColor3 = Color3.fromRGB(80,80,80)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.new(0,0,0)
frame.Active = true
frame.Draggable = true

local uiGradient = Instance.new("UIGradient", frame)
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160,160,160)), -- trên nhạt
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,60))     -- dưới đậm
}

-- Hiệu ứng to dần
for i = 0,1,0.05 do
    frame.Size = UDim2.new(0,200 + 400*i,0,100 + 300*i)
    frame.Position = UDim2.new(0.5,-(100+200*i),0.5,-(50+150*i))
    wait(0.03)
end

-- Xóa splash screen
splashGui:Destroy()

-- Tiêu đề (dòng chữ người dùng đặt)
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,10)
title.Text = ""
title.TextColor3 = Color3.fromRGB(0,50,150)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Hàm hiển thị chữ theo hiệu ứng từng ký tự
local function setTitle(text)
    title.Text = ""
    for i = 1,#text do
        title.Text = string.sub(text,1,i)
        wait(0.1)
    end
end

-- Nút đóng
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,30)
closeBtn.Position = UDim2.new(1,-50,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0.3,0)
closeBtn.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-- Nút ẩn/hiện
local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0,40,0,30)
hideBtn.Position = UDim2.new(1,-100,0,5)
hideBtn.Text = "▢"
hideBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local hideCorner = Instance.new("UICorner", hideBtn)
hideCorner.CornerRadius = UDim.new(0.3,0)
local hiddenGuiBtn = nil

hideBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    -- Tạo nút tròn di chuyển để hiện UI lại
    hiddenGuiBtn = Instance.new("TextButton", PlayerGui)
    hiddenGuiBtn.Size = UDim2.new(0,40,0,40)
    hiddenGuiBtn.Position = UDim2.new(0.5,-20,0,50)
    hiddenGuiBtn.Text = "▢"
    hiddenGuiBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    local corner = Instance.new("UICorner", hiddenGuiBtn)
    corner.CornerRadius = UDim.new(0.5,0)
    hiddenGuiBtn.Active = true
    hiddenGuiBtn.Draggable = true
    hiddenGuiBtn.MouseButton1Click:Connect(function()
        frame.Visible = true
        hiddenGuiBtn:Destroy()
    end)
end)

-- Lệnh đặt tên script
function name(scriptName)
    if not scriptName or scriptName == "" then return end
    Engine.ScriptName = scriptName
    setTitle(scriptName)
end

-- Ví dụ tự động đặt tên
name("SCR HUB")
