-- LocalScript SCR HUB với hiệu ứng intro
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local SCR = {}
SCR.tabs = {}

-- ==== Chức năng tên script ==== 
function name(scriptName)
    SCR.scriptName = scriptName
end

-- ==== Chức năng tạo tab ====
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

-- ==== Splash intro hiệu ứng ====
function text(titleText)
    local splash = Instance.new("ScreenGui", PlayerGui)
    local frame = Instance.new("Frame", splash)
    frame.Size = UDim2.new(0,150,0,50)
    frame.Position = UDim2.new(0.5,-75,0.5,-25)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.BackgroundTransparency = 0.5
    frame.ClipsDescendants = true

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0,200,255)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Text = ""

    -- Hiệu ứng gõ chữ
    for i = 1,#titleText do
        label.Text = string.sub(titleText,1,i)
        wait(0.05)
    end

    -- Phóng to UI chính sau 2s
    wait(1)
    local mainFrame = Instance.new("Frame", splash)
    mainFrame.Size = UDim2.new(0,0,0,0)
    mainFrame.Position = UDim2.new(0.5,0,0.5,0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.new(0,0,0)
    mainFrame.BackgroundTransparency = 0.2

    -- Phóng to dần
    for i=0,1,0.05 do
        mainFrame.Size = UDim2.new(0,500*i,0,350*i)
        mainFrame.Position = UDim2.new(0.5,-250*i,0.5,-175*i)
        wait(0.03)
    end

    -- Xóa label splash
    label:Destroy()

    -- Thanh trên
    local topBar = Instance.new("Frame", mainFrame)
    topBar.Size = UDim2.new(1,0,0,50)
    topBar.Position = UDim2.new(0,0,0,0)
    topBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
    topBar.BorderSizePixel = 0

    local titleLbl = Instance.new("TextLabel", topBar)
    titleLbl.Size = UDim2.new(0.8,0,0.6,0)
    titleLbl.Position = UDim2.new(0,10,0,0)
    titleLbl.Text = SCR.scriptName or "SCR HUB"
    titleLbl.TextColor3 = Color3.fromRGB(0,0,150)
    titleLbl.TextScaled = true
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.BackgroundTransparency = 1

    local author = Instance.new("TextLabel", topBar)
    author.Size = UDim2.new(0.8,0,0.4,0)
    author.Position = UDim2.new(0,10,0.6,0)
    author.Text = "NGUYỄN TRỌNG AN"
    author.TextColor3 = Color3.fromRGB(0,0,0)
    author.TextScaled = true
    author.Font = Enum.Font.SourceSansItalic
    author.BackgroundTransparency = 1

    -- Nút đóng
    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,5)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.BorderSizePixel = 0
    closeBtn.MouseButton1Click:Connect(function()
        splash:Destroy()
    end)

    -- Nút ẩn
    local hideBtn = Instance.new("TextButton", topBar)
    hideBtn.Size = UDim2.new(0,30,0,30)
    hideBtn.Position = UDim2.new(1,-70,0,5)
    hideBtn.Text = "_"
    hideBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
    hideBtn.BorderSizePixel = 0
    hideBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        local hiddenBtn = Instance.new("TextButton", splash)
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
