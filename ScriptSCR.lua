-- LocalScript SCR HUB
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ====== Framework SCR HUB ======
local SCR = {}
SCR.tabs = {}

-- Bắt buộc đặt tên script
function name(scriptName)
    SCR.scriptName = scriptName
end

-- Tạo tab
function tab(varName, tabName)
    local t = {var = varName, name = tabName, buttons={}, toggles={}, textboxes={}}
    table.insert(SCR.tabs, t)
    return t
end

-- Tạo button trong tab
function button(tabVar, btnName, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.buttons,{name=btnName,callback=callback})
        end
    end
end

-- Tạo toggle trong tab
function toggle(tabVar, toggleName, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.toggles,{name=toggleName,callback=callback,state=false})
        end
    end
end

-- Tạo textbox trong tab
function textbox(tabVar, boxName, saveVar, callback)
    for _,t in pairs(SCR.tabs) do
        if t.var == tabVar then
            table.insert(t.textboxes,{name=boxName,save=saveVar,callback=callback})
        end
    end
end

-- Thêm tiêu đề splash UI
function text(titleText)
    local splash = Instance.new("ScreenGui", PlayerGui)
    local frame = Instance.new("Frame", splash)
    frame.Size = UDim2.new(0,200,0,50)
    frame.Position = UDim2.new(0.5,-100,0.5,-25)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0,0,0)
    frame.BackgroundTransparency = 0.5

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0,200,255)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Text = titleText

    -- Hiệu ứng chữ
    for i = 1,#titleText do
        label.Text = string.sub(titleText,1,i)
        wait(0.05)
    end

    -- Phóng to UI chính sau 2s
    wait(2)
    splash:Destroy()
end

-- ======= Tạo UI chính =======
local mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "SCR_HUB_UI"

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0,500,0,350)
mainFrame.Position = UDim2.new(0.5,-250,0.5,-175)
mainFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(0,0,0)
mainFrame.BackgroundTransparency = 0.2
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

-- Thanh trên
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1,0,0,50)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
topBar.BorderSizePixel = 0

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.8,0,0.6,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = SCR.scriptName or "SCR HUB"
title.TextColor3 = Color3.fromRGB(0,0,150)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.BackgroundTransparency = 1

local author = Instance.new("TextLabel", topBar)
author.Size = UDim2.new(0.8,0,0.4,0)
author.Position = UDim2.new(0,10,0.6,0)
author.Text = "NGUYỄN TRỌNG AN"
author.TextColor3 = Color3.fromRGB(0,0,0)
author.TextScaled = true
author.Font = Enum.Font.SourceSansItalic
author.BackgroundTransparency = 1

-- Nút đóng UI
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BorderSizePixel = 0
closeBtn.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-- Nút ẩn UI
local hideBtn = Instance.new("TextButton", topBar)
hideBtn.Size = UDim2.new(0,30,0,30)
hideBtn.Position = UDim2.new(1,-70,0,5)
hideBtn.Text = "_"
hideBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
hideBtn.TextColor3 = Color3.fromRGB(255,255,255)
hideBtn.BorderSizePixel = 0
local hiddenFrame
hideBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    hiddenFrame = Instance.new("TextButton", mainGui)
    hiddenFrame.Size = UDim2.new(0,50,0,30)
    hiddenFrame.Position = UDim2.new(0.5,-25,0,50)
    hiddenFrame.Text = "SCR"
    hiddenFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    hiddenFrame.TextColor3 = Color3.fromRGB(255,255,255)
    hiddenFrame.BorderSizePixel = 0
    hiddenFrame.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        hiddenFrame:Destroy()
    end)
end)

-- Thanh dưới cho tab
local bottomBar = Instance.new("Frame", mainFrame)
bottomBar.Size = UDim2.new(1,0,0,30)
bottomBar.Position = UDim2.new(0,0,1,-30)
bottomBar.BackgroundColor3 = Color3.fromRGB(90,90,90)
bottomBar.BorderSizePixel = 0

-- Tạo tab từ SCR.tabs
for i,t in pairs(SCR.tabs) do
    local tabBtn = Instance.new("TextButton", bottomBar)
    tabBtn.Size = UDim2.new(0.18,0,1,0)
    tabBtn.Position = UDim2.new(0.18*(i-1),0,0,0)
    tabBtn.Text = t.name
    tabBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
    tabBtn.BorderSizePixel = 0
end

-- ====== Kết thúc ======
return {
    SCR = SCR,
    name = name,
    tab = tab,
    button = button,
    toggle = toggle,
    textbox = textbox,
    text = text
}
