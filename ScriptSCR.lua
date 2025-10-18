-- Dòng 1: Kiểm tra mật khẩu
local function pw(key)
    if key ~= "0904" then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "SCR HUB";
            Text = "MẬT KHẨU SAI!";
            Duration = 3;
        })
        return false
    end
    return true
end

if not pw("0904") then return end

-- Dòng 2: Tạo UI (block awd riêng)
local function awd(nameUI, configFile)
    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "SCR_HUB_UI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,600,0,400)
    frame.Position = UDim2.new(0.5,-300,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(100,100,100)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true

    local topBar = Instance.new("Frame", frame)
    topBar.Size = UDim2.new(1,0,0,40)
    topBar.Position = UDim2.new(0,0,0,0)
    topBar.BackgroundColor3 = Color3.fromRGB(170,170,170)

    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0,40,0,30)
    closeBtn.Position = UDim2.new(1,-50,0,5)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0.3,0)
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local hideBtn = Instance.new("TextButton", topBar)
    hideBtn.Size = UDim2.new(0,40,0,30)
    hideBtn.Position = UDim2.new(1,-100,0,5)
    hideBtn.Text = "_"
    hideBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local hideCorner = Instance.new("UICorner", hideBtn)
    hideCorner.CornerRadius = UDim.new(0.3,0)

    local hiddenBtn = Instance.new("TextButton", gui)
    hiddenBtn.Size = UDim2.new(0,60,0,40)
    hiddenBtn.Position = UDim2.new(0.5,-30,0,10)
    hiddenBtn.Text = "Hiện UI"
    hiddenBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    local hiddenCorner = Instance.new("UICorner", hiddenBtn)
    hiddenCorner.CornerRadius = UDim.new(0.3,0)
    hiddenBtn.Visible = false
    hiddenBtn.Active = true
    hiddenBtn.Draggable = true

    hideBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
        hiddenBtn.Visible = true
    end)
    hiddenBtn.MouseButton1Click:Connect(function()
        frame.Visible = true
        hiddenBtn.Visible = false
    end)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,50)
    title.BackgroundTransparency = 1
    title.Text = nameUI
    title.TextColor3 = Color3.fromRGB(0,150,255)
    title.Font = Enum.Font.SourceSansBold
    title.TextScaled = true
end

-- Gọi awd với tên UI và file config
awd("SCR HUB","ConfigSCR")
