--// SCR HUB - UI Framework có kéo thả
local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- UI chính
local MainUI = Instance.new("ScreenGui", PlayerGui)
MainUI.Name = "SCR_UI"
MainUI.IgnoreGuiInset = true
MainUI.ResetOnSpawn = false

-- Frame chính
local MainFrame = Instance.new("Frame", MainUI)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Thanh trên (chỉ phần này được kéo)
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Active = true
TitleBar.Draggable = true -- ✅ Chỉ kéo được bằng thanh này

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Text = "SCR HUB"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.BackgroundTransparency = 1

-----------------------------------------------------------
-- Nút ẩn/hiện có thể kéo (👁)
-----------------------------------------------------------
local ToggleBtn = Instance.new("TextButton", MainUI)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0.8, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextScaled = true
ToggleBtn.Text = "👁"
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local uiVisible = true

-- Cho phép kéo nút
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = ToggleBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		update(input)
	end
end)

-----------------------------------------------------------
-- INTRO (chỉ chữ, không nền)
-----------------------------------------------------------
local IntroText = Instance.new("TextLabel", MainUI)
IntroText.AnchorPoint = Vector2.new(0.5, 0.5)
IntroText.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroText.Text = "CHÀO MỪNG ĐẾN VỚI SCR HUB"
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 36
IntroText.TextColor3 = Color3.fromRGB(255,255,255)
IntroText.BackgroundTransparency = 1
IntroText.TextTransparency = 1
IntroText.TextStrokeTransparency = 0.7

TweenService:Create(IntroText, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(2.5)
TweenService:Create(IntroText, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
task.wait(1.5)
IntroText:Destroy()

MainFrame.Visible = true

-----------------------------------------------------------
-- TAB & NỘI DUNG
-----------------------------------------------------------
local TabBar = Instance.new("ScrollingFrame", MainFrame)
TabBar.Size = UDim2.new(0, 120, 1, -30)
TabBar.Position = UDim2.new(0,0,0,30)
TabBar.ScrollBarThickness = 6
TabBar.BackgroundColor3 = Color3.fromRGB(40,40,40)
local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local TabFrames = {}
local Khungs = {}
local SettingsFrame

-- Tạo tab
local function CreateTab(name, id, order)
	local btn = Instance.new("TextButton", TabBar)
	btn.Size = UDim2.new(1,0,0,30)
	btn.Text = name
	btn.LayoutOrder = order or 1
	btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
	btn.TextColor3 = Color3.new(1,1,1)

	local frame = Instance.new("ScrollingFrame", MainFrame)
	frame.Name = id
	frame.Size = UDim2.new(1, -120, 1, -30)
	frame.Position = UDim2.new(0, 120, 0, 30)
	frame.BackgroundTransparency = 1
	frame.ScrollBarThickness = 6
	frame.Visible = false

	local layout = Instance.new("UIListLayout", frame)
	layout.Padding = UDim.new(0,8)

	TabFrames[id] = frame
	Khungs[id] = {}

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(TabFrames) do v.Visible = false end
		if SettingsFrame then SettingsFrame.Visible = false end -- ✅ Ẩn tab cài đặt khi chuyển tab khác
		frame.Visible = true
	end)

	return frame
end

-- Tạo khung
local function CreateKhung(name, tabId)
	local tab = TabFrames[tabId]
	if not tab then return end
	local khung = Instance.new("Frame", tab)
	khung.Size = UDim2.new(1, -10, 0, 100)
	khung.BackgroundColor3 = Color3.fromRGB(60,60,60)
	Instance.new("UICorner", khung).CornerRadius = UDim.new(0,8)

	local title = Instance.new("TextLabel", khung)
	title.Size = UDim2.new(1, -10, 0, 25)
	title.Position = UDim2.new(0,5,0,5)
	title.BackgroundTransparency = 1
	title.Text = name
	title.TextColor3 = Color3.new(1,1,1)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 14

	table.insert(Khungs[tabId], khung)
	return khung
end

-- Tạo nút
local function CreateButton(name, tabId, khungIndex, callback)
	local khung = Khungs[tabId][khungIndex]
	if not khung then return end
	local btn = Instance.new("TextButton", khung)
	btn.Size = UDim2.new(0.8, 0, 0, 28)
	btn.Position = UDim2.new(0.1,0,0,40)
	btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = "🔘 " .. name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

	btn.MouseButton1Click:Connect(callback)
end

-----------------------------------------------------------
-- ẨN / HIỆN UI
-----------------------------------------------------------
ToggleBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	MainFrame.Visible = uiVisible
	if uiVisible then
		ToggleBtn.Text = "👁"
	else
		ToggleBtn.Text = "🚫"
	end
end)

-----------------------------------------------------------
-- Nút CÀI ĐẶT (ở cuối TabBar)
-----------------------------------------------------------
local SettingsBtn = Instance.new("TextButton", TabBar)
SettingsBtn.Size = UDim2.new(1,0,0,35)
SettingsBtn.Text = "⚙ Cài đặt"
SettingsBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
SettingsBtn.TextColor3 = Color3.fromRGB(255,255,255)
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.TextSize = 14
Instance.new("UICorner", SettingsBtn).CornerRadius = UDim.new(0,6)

local padding = Instance.new("UIPadding", TabBar)
padding.PaddingBottom = UDim.new(0, 5)
SettingsBtn.Position = UDim2.new(0,0,1,-40)

SettingsFrame = Instance.new("Frame", MainFrame)
SettingsFrame.Size = UDim2.new(1, -120, 1, -30)
SettingsFrame.Position = UDim2.new(0, 120, 0, 30)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
SettingsFrame.Visible = false

local Title = Instance.new("TextLabel", SettingsFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "⚙ CÀI ĐẶT"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)

local CloseBtn = Instance.new("TextButton", SettingsFrame)
CloseBtn.Size = UDim2.new(0, 200, 0, 40)
CloseBtn.Position = UDim2.new(0.5, -100, 0.5, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
CloseBtn.Text = "❌ Đóng UI vĩnh viễn"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,8)

local hoverOnClose = TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 50, 50)})
local hoverOffClose = TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 40, 40)})

CloseBtn.MouseEnter:Connect(function() hoverOnClose:Play() end)
CloseBtn.MouseLeave:Connect(function() hoverOffClose:Play() end)
CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(SettingsFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	task.wait(0.5)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "❌ UI đã bị đóng hoàn toàn.",
		Color = Color3.fromRGB(255, 80, 80)
	})
	MainUI:Destroy()
end)

SettingsBtn.MouseButton1Click:Connect(function()
	for _,v in pairs(TabFrames) do v.Visible = false end
	SettingsFrame.Visible = true
end)

-----------------------------------------------------------
-- TEST UI
-----------------------------------------------------------
CreateTab("Tab 1","main",1)
CreateTab("Tab 2","other",2)
CreateKhung("Hành động","main")
CreateButton("Bật test","main",1,function()
	game.StarterGui:SetCore("ChatMakeSystemMessage",{
		Text="✅ Nút test hoạt động!",
		Color=Color3.fromRGB(0,255,0)
	})
end)
