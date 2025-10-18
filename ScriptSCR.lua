-- SCR HUB Engine Lua
local function SCR_Engine()
    local Player = game.Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    local Activated = false
    local UI_Created = false

    -- Hàm pw
    function pw(input)
        if input == "0904" then
            Activated = true
            print("SCR HUB Activated")
        else
            warn("Mật khẩu sai!")
        end
    end

    -- Hàm awd để tạo UI
    function awd(name, config)
        if not Activated then
            warn("Chưa nhập mật khẩu!")
            return
        end
        if UI_Created then return end
        UI_Created = true

        -- Tạo UI cơ bản
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
        title.Text = name
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

    -- Trả về các hàm để chạy kiểu local SCR = loadstring(...)() ; pw() ; awd()
    return {
        pw = pw,
        awd = awd
    }
end

-- Khởi tạo engine
local SCR = SCR_Engine()

-- Ví dụ sử dụng:
-- SCR.pw("0904")
-- SCR.awd("SCR HUB","SCR_config")
