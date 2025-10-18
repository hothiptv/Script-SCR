-- LocalScript SCR HUB
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local SCR = {}
SCR.tabs = {}

-- ==== Chức năng đặt tên script ==== 
function name(scriptName)
    SCR.scriptName = scriptName
end

-- ==== Tạo tab ====
function tab(varName, tabName)
    local t = {var = varName, name = tabName, buttons={}, toggles={}, textboxes={}}
    table.insert(SCR.tabs, t)
    return t
end

function button(tabVar, btnName, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.buttons,{name=btnName,callback=callback})
        end
    end
end

function toggle(tabVar, toggleName, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.toggles,{name=toggleName,callback=callback,state=false})
        end
    end
end

function textbox(tabVar, boxName, saveVar, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.textboxes,{name=boxName,save=saveVar,callback=callback})
        end
    end
end

-- ==== Hiệu ứng intro + UI chính ====
function text(titleText)
    -- Tạo UI intro
    local splash = Instance.new("ScreenGui", PlayerGui)
    local introFrame = Instance.new("Frame", splash)
    introFrame.Size = UDim2.new(0,200,0,60)
    introFrame.Position = UDim2.new(0.5,-100,0.5,-30)
    introFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    introFrame.BorderSizePixel = 2
    introFrame.BorderColor3 = Color3.new(0,0,0)
    introFrame.BackgroundTransparency = 0.5

    local introLabel = Instance.new("TextLabel", introFrame)
    introLabel.Size = UDim2.new(1,0,1,0)
    introLabel.BackgroundTransparency = 1
    introLabel.TextColor3 = Color3.fromRGB(0,200,255)
    introLabel.Font = Enum.Font.SourceSansBold
    introLabel.TextScaled = true
    introLabel.Text = ""

    -- Chạy hiệu ứng gõ chữ
    for i=1,#titleText do
        introLabel.Text = string.sub(titleText,1,i)
        wait(0.05)
    end

    wait(1)

    -- Xóa toàn bộ UI intro
    splash:Destroy()

    -- Tạo UI chính
    local mainGui = Instance.new("ScreenGui", PlayerGui)
    local mainFrame = Instance.new("Frame", mainGui)
    mainFrame.Size = UDim2.new(0,0,0,0)
    mainFrame.Position = UDim2.new(0.5,0,0.5,0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(80,80,80)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.new(0,0,0)
    mainFrame.BackgroundTransparency = 0.3

    -- Phóng to UI chính
    for i=0,1,0.05 do
        mainFrame.Size = UDim2.new(0,500*i,0,350*i)
        mainFrame.Position = UDim2.new(0.5,-250*i,0.5,-175*i)
        wait(0.03)
    end

    -- Thanh trên
    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1,0,0,50)
    topBar.Position = UDim2.new(0,0,0,0)
    topBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
    topBar.BorderSizePixel = 0

    local titleLbl = Instance.new("TextLabel", topBar)
    titleLbl.Size = UDim2.new(0.7,0,0.5,0)
    titleLbl.Position = UDim2.new(0,10,0,0)
    titleLbl.Text = SCR.scriptName or "SCR HUB"
    titleLbl.TextColor3 = Color3.fromRGB(0,0,150)
    titleLbl.TextScaled = true
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.BackgroundTransparency = 1

    local author = Instance.new("TextLabel", topBar)
    author.Size = UDim2.new(0.7,0,0.5,0)
    author.Position = UDim2.new(0,10,0,25)
    author.Text = "NGUYỄN TRỌNG AN"
    author.TextColor3 = Color3.fromRGB(0,0,0)
    author.TextScaled = true
    author.Font = Enum.Font.SourceSansItalic
    author.BackgroundTransparency = 1

    -- Nút đóng
    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,10)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.BorderSizePixel = 0
    closeBtn.MouseButton1Click:Connect(function()
        mainGui:Destroy()
    end)

    -- Nút ẩn
    local hideBtn = Instance.new("TextButton", topBar)
    hideBtn.Size = UDim2.new(0,30,0,30)
    hideBtn.Position = UDim2.new(1,-70,0,10)
    hideBtn.Text = "_"
    hideBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
    hideBtn.BorderSizePixel = 0
    hideBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        local hiddenBtn = Instance.new("TextButton", mainGui)
        hiddenBtn.Size = UDim2.new(0,50,0,30)
        hiddenBtn.Position = UDim2.new(0.5,-25,0,50)
        hiddenBtn.Text = "SCR"
        hiddenBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        hiddenBtn.TextColor3 = Color3.fromRGB(255,255,255)
        hiddenBtn.BorderSizePixel = 0
        hiddenBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = true
            hiddenBtn:Destroy()
        end)
    end)

    -- Tab thanh dưới
    local tabBar = Instance.new("Frame", mainFrame)
    tabBar.Size = UDim2.new(1,0,0,40)
    tabBar.Position = UDim2.new(0,0,1,-40)
    tabBar.BackgroundColor3 = Color3.fromRGB(70,70,70)
    tabBar.BorderSizePixel = 0

    -- Tạo nút tab
    for i,t in pairs(SCR.tabs) do
        local tabBtn = Instance.new("TextButton", tabBar)
        tabBtn.Size = UDim2.new(0,90,0,30)
        tabBtn.Position = UDim2.new(0,10+(i-1)*100,0,5)
        tabBtn.Text = t.name
        tabBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
        tabBtn.TextColor3 = Color3.fromRGB(255,255,255)
        tabBtn.BorderSizePixel = 0
    end
end

return {
    SCR = SCR,
    name = name,
    tab = tab,
    button = button,
    toggle = toggle,
    textbox = textbox,
    text = text
}
