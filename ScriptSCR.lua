local SCR = {}

function SCR:MakeWindow(config)
    local plr = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "SCR_HUB"
    gui.ResetOnSpawn = false
    gui.Parent = plr:WaitForChild("PlayerGui")

    -- Chỉ hiển thị khi Name = "SCR.exe"
    if config.Name ~= "SCR.exe" then return end

    -- Main Frame (hình vuông xám)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,600,0,400)
    frame.Position = UDim2.new(0.5,-300,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(100,100,100)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true

    -- Top bar (màu xám nhạt)
    local topBar = Instance.new("Frame", frame)
    topBar.Size = UDim2.new(1,0,0,40)
    topBar.Position = UDim2.new(0,0,0,0)
    topBar.BackgroundColor3 = Color3.fromRGB(170,170,170)
    topBar.BorderSizePixel = 0

    -- Nút đóng
    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0,40,0,30)
    closeBtn.Position = UDim2.new(1,-50,0,5)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0.3,0)
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Nút ẩn
    local hideBtn = Instance.new("TextButton", topBar)
    hideBtn.Size = UDim2.new(0,40,0,30)
    hideBtn.Position = UDim2.new(1,-100,0,5)
    hideBtn.Text = "_"
    hideBtn.TextColor3 = Color3.new(1,1,1)
    hideBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local hideCorner = Instance.new("UICorner", hideBtn)
    hideCorner.CornerRadius = UDim.new(0.3,0)

    -- Nút hiện UI khi ẩn
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
end

-- Cách dùng:
-- local SCR = loadstring(game:HttpGet("LINK LUA SCR"))()
-- SCR:MakeWindow({Name="SCR.exe"})
