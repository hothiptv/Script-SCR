-- LocalScript SCR HUB
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Engine = {UI_Created = false, ScriptName = nil}

-- Hàm tạo UI SCR HUB với hiệu ứng gradient xám
local function createSCRHub(scriptName)
    if Engine.UI_Created then return end
    Engine.UI_Created = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "SCR_HUB_UI"
    gui.Parent = PlayerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,600,0,400)
    frame.Position = UDim2.new(0.5,-300,0.5,-200)
    frame.BackgroundColor3 = Color3.fromRGB(100,100,100)
    frame.BackgroundTransparency = 0.4 -- nhìn xuyên
    frame.BorderSizePixel = 3
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.Active = true
    frame.Draggable = true

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
    title.Text = scriptName
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
        Engine.UI_Created = false
    end)
end

-- Lệnh bắt buộc đặt tên script
function name(scriptName)
    if scriptName == nil or scriptName == "" then
        warn("Bạn phải đặt tên script để UI hiện!")
        return
    end
    Engine.ScriptName = scriptName
    createSCRHub(scriptName)
end

-- Ví dụ:
-- name("SCR HUB")  -- UI sẽ xuất hiện với gradient xám
