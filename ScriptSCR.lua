-- LocalScript SCR HUB với hiệu ứng
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Engine = {UI_Created = false}

-- Hàm tạo UI
local function createUI(name, config)
    if Engine.UI_Created then return end
    Engine.UI_Created = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "SCR_HUB_UI"
    gui.Parent = PlayerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,600,0,400)
    frame.Position = UDim2.new(0.5,-300,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(50,150,255)
    frame.BorderSizePixel = 3
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true
    frame.BackgroundTransparency = 1  -- bắt đầu trong suốt

    -- Fade in UI
    for i = 0,1,0.05 do
        frame.BackgroundTransparency = 1 - i
        wait(0.03)
    end

    -- Tiêu đề
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,10)
    title.Text = ""
    title.TextColor3 = Color3.fromRGB(0,50,150)
    title.Font = Enum.Font.SourceSansBold
    title.TextScaled = true

    -- Hiệu ứng chữ xuất hiện từng ký tự
    local text = name
    spawn(function()
        for i = 1,#text do
            title.Text = string.sub(text,1,i)
            wait(0.05)
        end
    end)

    -- Nút đóng
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

    -- Nút ẩn UI
    local hideBtn = Instance.new("TextButton", frame)
    hideBtn.Size = UDim2.new(0,60,0,30)
    hideBtn.Position = UDim2.new(1,-120,0,5)
    hideBtn.Text = "Ẩn"
    hideBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    local hideCorner = Instance.new("UICorner", hideBtn)
    hideCorner.CornerRadius = UDim.new(0.3,0)
    hideBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
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
end

-- Lệnh gọi UI
createUI("SCR HUB","SCR_config")
