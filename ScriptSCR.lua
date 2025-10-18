-- LocalScript SCR HUB trực tiếp
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. Kiểm tra mật khẩu
local Password = "0904"
local function checkPw(input)
    if input ~= Password then
        warn("Mật khẩu sai!")
        return false
    end
    return true
end

-- 2. Tạo UI SCR HUB
local function createUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "SCR_HUB_UI"
    gui.Parent = PlayerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,600,0,400)
    frame.Position = UDim2.new(0.5,-300,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(50,150,255)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,10)
    title.Text = "SCR HUB"
    title.TextColor3 = Color3.fromRGB(0,50,150)
    title.Font = Enum.Font.SourceSansBold
    title.TextScaled = true

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
end

-- 3. Chạy kiểm tra mật khẩu trước khi tạo UI
if checkPw("0904") then
    createUI()
end
