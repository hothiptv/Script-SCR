-- LocalScript SCR HUB trực tiếp, không cần mật khẩu
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. Tạo UI SCR HUB
local gui = Instance.new("ScreenGui")
gui.Name = "SCR_HUB_UI"
gui.Parent = PlayerGui

-- 2. Frame chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,600,0,400)
frame.Position = UDim2.new(0.5,-300,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(50,150,255) -- xanh dương
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0,0,0)
frame.Active = true
frame.Draggable = true

-- 3. Tiêu đề SCR HUB
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,10)
title.Text = "SCR HUB"
title.TextColor3 = Color3.fromRGB(0,50,150)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- 4. Nút đóng
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,40,0,30)
closeBtn.Position = UDim2.new(1,-50,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0.3,0)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- 5. Nút ẩn UI (tạo nút có thể di chuyển)
local hideBtn = Instance.new("TextButton", frame)
hideBtn.Size = UDim2.new(0,60,0,30)
hideBtn.Position = UDim2.new(1,-120,0,5)
hideBtn.Text = "Ẩn"
hideBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
local hideCorner = Instance.new("UICorner", hideBtn)
hideCorner.CornerRadius = UDim.new(0.3,0)
hideBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    -- Nút hiện UI
    local showBtn = Instance.new("TextButton", gui)
    showBtn.Size = UDim2.new(0,80,0,40)
    showBtn.Position = UDim2.new(0.5,-40,0,10)
    showBtn.Text = "Hiện UI"
    local showCorner = Instance.new("UICorner", showBtn)
    showCorner.CornerRadius = UDim.new(0.3,0)
    showBtn.MouseButton1Click:Connect(function()
        frame.Visible = true
        showBtn:Destroy()
    end)
end)
