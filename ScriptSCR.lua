-- Load SCR HUB
local SCR = (function()
    local plr = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
    gui.Name = "SCR_HUB"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,500,0,400)
    frame.Position = UDim2.new(0.5,-250,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(0,120,255)
    frame.BorderSizePixel = 4
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0.2,0)

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,10)
    title.Text = "SCR HUB"
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.TextColor3 = Color3.fromRGB(0,50,150)
    title.BackgroundTransparency = 1

    -- Nút đóng
    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(0,40,0,40)
    closeBtn.Position = UDim2.new(1,-50,0,10)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0.5,0)
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Nút ẩn
    local hideBtn = Instance.new("TextButton", frame)
    hideBtn.Size = UDim2.new(0,40,0,40)
    hideBtn.Position = UDim2.new(1,-100,0,10)
    hideBtn.Text = "-"
    hideBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0.5,0)

    -- Nút hiện UI tròn
    local hiddenBtn = Instance.new("TextButton", gui)
    hiddenBtn.Size = UDim2.new(0,60,0,60)
    hiddenBtn.Position = UDim2.new(0.5,-30,0,10)
    hiddenBtn.Text = "Hiện UI"
    hiddenBtn.BackgroundColor3 = Color3.fromRGB(0,80,200)
    Instance.new("UICorner", hiddenBtn).CornerRadius = UDim.new(0.5,0)
    hiddenBtn.Visible = false
    hiddenBtn.Active = true
    hiddenBtn.Draggable = true

    hideBtn.MouseButton1Click:Connect(function()
        frame.Visible=false
        hiddenBtn.Visible=true
    end)
    hiddenBtn.MouseButton1Click:Connect(function()
        frame.Visible=true
        hiddenBtn.Visible=false
    end)

    -- TextBox
    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0,200,0,30)
    textBox.Position = UDim2.new(0,20,0,80)
    textBox.PlaceholderText = "Nhập gì đó"
    textBox.BackgroundColor3 = Color3.fromRGB(30,30,60)
    textBox.TextColor3 = Color3.new(1,1,1)
    textBox.BorderSizePixel = 2
    textBox.TextScaled = true
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0.2,0)

    -- Nút Rejoin
    local rejoinBtn = Instance.new("TextButton", frame)
    rejoinBtn.Size = UDim2.new(0,120,0,40)
    rejoinBtn.Position = UDim2.new(0,20,0,130)
    rejoinBtn.Text = "Rejoin"
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(50,50,100)
    rejoinBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0.5,0)
    rejoinBtn.MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, plr)
    end)

    -- Footer
    local footer = Instance.new("TextLabel", frame)
    footer.Size = UDim2.new(1,0,0,30)
    footer.Position = UDim2.new(0,0,1,-40)
    footer.Text = "Người tạo: Nguyễn Trọng An"
    footer.BackgroundTransparency = 1
    footer.TextScaled = true

    -- Return object SCR, có thể mở window hay thêm nút sau này
    local SCRObj = {}
    function SCRObj:MakeWindow(config)
        frame.Visible = true
        title.Text = config.Name or "SCR HUB"
        return frame
    end

    return SCRObj
end)()
