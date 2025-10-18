-- LocalScript SCR HUB với hiệu ứng mở/đóng
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Tạo GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SCR_HUB_UI"
gui.Parent = PlayerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,400,0,200)
frame.Position = UDim2.new(0.5,-200,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(80,80,80)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.new(0,0,0)
frame.Active = false -- không kéo được

-- Gradient từ trên nhạt xuống dưới đậm
local uiGradient = Instance.new("UIGradient", frame)
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160,160,160)), -- trên nhạt
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,60))     -- dưới đậm
}

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,10)
title.Text = "SCR VN"
title.TextColor3 = Color3.fromRGB(0,50,150)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Nút đóng với hiệu ứng fade-out
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,30)
closeBtn.Position = UDim2.new(1,-50,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0.3,0)
closeBtn.MouseButton1Click:Connect(function()
    -- Hiệu ứng đóng dần
    for i = 0,1,0.05 do
        frame.BackgroundTransparency = i
        title.TextTransparency = i
        wait(0.03)
    end
    gui:Destroy()
end)

-- Hiệu ứng mở dần
frame.BackgroundTransparency = 1
title.TextTransparency = 1
for i = 0,1,0.05 do
    frame.BackgroundTransparency = 1 - i
    title.TextTransparency = 1 - i
    wait(0.03)
end
