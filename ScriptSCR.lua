-- LocalScript SCR HUB nâng cấp
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ===================
-- Main UI
-- ===================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "SCR_HUB_UI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,400,0,300) -- UI to hơn
frame.Position = UDim2.new(0.5,-200,0.5,-150)
frame.BackgroundColor3 = Color3.fromRGB(80,80,80)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.new(0,0,0)
frame.Active = true
frame.Draggable = true

-- Gradient
local uiGradient = Instance.new("UIGradient", frame)
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160,160,160)), -- trên nhạt
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,60))     -- dưới đậm
}

-- Icon góc
local icon = Instance.new("ImageLabel", frame)
icon.Size = UDim2.new(0,40,0,40)
icon.Position = UDim2.new(0,10,0,10)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://6023426915" -- ví dụ icon

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,-60,0,40)
title.Position = UDim2.new(0,60,0,10)
title.Text = "SCR HUB"
title.TextColor3 = Color3.fromRGB(0,50,150)
title.TextTransparency = 0.3
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Thanh tab (hiển thị nhưng chưa đặt tab)
local tabBar = Instance.new("Frame", frame)
tabBar.Size = UDim2.new(1,-20,0,10)
tabBar.Position = UDim2.new(0,10,0,60)
tabBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
tabBar.BorderSizePixel = 0

-- Nút đóng
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,30)
closeBtn.Position = UDim2.new(1,-50,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0.3,0)

-- Nút ẩn
local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0,40,0,30)
hideBtn.Position = UDim2.new(1,-100,0,5)
hideBtn.Text = "▢"
hideBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local hideCorner = Instance.new("UICorner", hideBtn)
hideCorner.CornerRadius = UDim.new(0.3,0)

local hiddenFrame = nil

hideBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    -- Tạo frame nhỏ chữ nhật trong suốt, không kéo
    hiddenFrame = Instance.new("Frame", PlayerGui)
    hiddenFrame.Size = UDim2.new(0,100,0,30)
    hiddenFrame.Position = UDim2.new(0.5,-50,0,50)
    hiddenFrame.BackgroundColor3 = Color3.fromRGB(80,80,80)
    hiddenFrame.BackgroundTransparency = 0.7
    hiddenFrame.BorderSizePixel = 2
    hiddenFrame.BorderColor3 = Color3.new(0,0,0)
    local hiddenText = Instance.new("TextLabel", hiddenFrame)
    hiddenText.Size = UDim2.new(1,0,1,0)
    hiddenText.Text = "SCR HUB"
    hiddenText.TextColor3 = Color3.fromRGB(0,50,150)
    hiddenText.Font = Enum.Font.SourceSansBold
    hiddenText.TextScaled = true
    hiddenText.BackgroundTransparency = 1

    -- Nút hiện lại UI
    hiddenFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            frame.Visible = true
            hiddenFrame:Destroy()
        end
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
