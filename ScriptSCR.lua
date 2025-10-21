--// SCR HUB - Framework (Bản test có intro & nút ẩn/hiện)
local scr = {}
local Tabs = {}

function scr.createWindow(title, config)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "SCR_HUB"
	ScreenGui.Parent = game:GetService("CoreGui")

	-- Hiệu ứng intro
	local IntroFrame = Instance.new("Frame", ScreenGui)
	IntroFrame.Size = UDim2.new(1, 0, 1, 0)
	IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	IntroFrame.BackgroundTransparency = 0

	local IntroText = Instance.new("TextLabel", IntroFrame)
	IntroText.AnchorPoint = Vector2.new(0.5, 0.5)
	IntroText.Position = UDim2.new(0.5, 0, 0.5, 0)
	IntroText.Size = UDim2.new(0, 400, 0, 100)
	IntroText.Text = "SCR HUB"
	IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
	IntroText.BackgroundTransparency = 1
	IntroText.Font = Enum.Font.GothamBold
	IntroText.TextScaled = true
	IntroText.TextTransparency = 1

	-- Hiệu ứng fade in/out
	task.spawn(function()
		for i = 1, 0, -0.05 do
			IntroText.TextTransparency = i
			task.wait(0.05)
		end
		task.wait(1)
		for i = 0, 1, 0.05 do
			IntroText.TextTransparency = i
			IntroFrame.BackgroundTransparency = i
			task.wait(0.05)
		end
		IntroFrame:Destroy()
	end)

	-- UI chính (ẩn lúc đầu)
	local Main = Instance.new("Frame", ScreenGui)
	Main.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Main.BackgroundTransparency = 0.3
	Main.Size = UDim2.new(0.5, 0, 0.6, 0)
	Main.Position = UDim2.new(0.25, 0, 0.2, 0)
	Main.Visible = false
	Main.Name = "MainUI"
	Main.Active = true
	Main.Draggable = true

	-- Delay hiện UI sau intro
	task.delay(2.5, function()
		Main.Visible = true
	end)

	-- Thanh trên
	local TopBar = Instance.new("Frame", Main)
	TopBar.Size = UDim2.new(1, 0, 0, 30)
	TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

	local TitleText = Instance.new("TextLabel", TopBar)
	TitleText.Text = title or "SCR HUB"
	TitleText.Size = UDim2.new(1, -40, 1, 0)
	TitleText.TextColor3 = Color3.new(1, 1, 1)
	TitleText.BackgroundTransparency = 1
	TitleText.Font = Enum.Font.GothamBold
	TitleText.TextSize = 16

	-- Nút ẩn/hiện trong UI
	local HideBtn = Instance.new("TextButton", TopBar)
	HideBtn.Text = "-"
	HideBtn.Size = UDim2.new(0, 30, 1, 0)
	HideBtn.Position = UDim2.new(1, -30, 0, 0)
	HideBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	HideBtn.TextColor3 = Color3.new(1, 1, 1)

	HideBtn.MouseButton1Click:Connect(function()
		Main.Visible = false
	end)

	-- Thanh tab bên trái
	local TabBar = Instance.new("ScrollingFrame", Main)
	TabBar.Size = UDim2.new(0, 120, 1, -30)
	TabBar.Position = UDim2.new(0, 0, 0, 30)
	TabBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabBar.ScrollBarThickness = 4
	TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)

	-- Hệ thống tạo tab
	function Tabs.CreateTab(name, id, order)
		local TabBtn = Instance.new("TextButton", TabBar)
		TabBtn.Text = name
		TabBtn.Size = UDim2.new(1, 0, 0, 30)
		TabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		TabBtn.TextColor3 = Color3.new(1, 1, 1)
		TabBtn.LayoutOrder = order or 1

		local TabFrame = Instance.new("Frame", Main)
		TabFrame.Size = UDim2.new(1, -120, 1, -30)
		TabFrame.Position = UDim2.new(0, 120, 0, 30)
		TabFrame.BackgroundTransparency = 1
		TabFrame.Visible = false

		TabBtn.MouseButton1Click:Connect(function()
			for _, v in pairs(Main:GetChildren()) do
				if v:IsA("Frame") and v ~= TopBar and v ~= TabBar then
					v.Visible = false
				end
			end
			TabFrame.Visible = true
		end)

		-- Tạo khung
		function Tabs.CreateKhung(name, tabId, index)
			if tabId ~= id then return end
			local Khung = Instance.new("Frame", TabFrame)
			Khung.Size = UDim2.new(0.9, 0, 0, 100)
			Khung.Position = UDim2.new(0.05, 0, 0, (index - 1) * 110)
			Khung.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			local Title = Instance.new("TextLabel", Khung)
			Title.Size = UDim2.new(1, 0, 0, 25)
			Title.Text = name
			Title.BackgroundTransparency = 1
			Title.TextColor3 = Color3.new(1, 1, 1)
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			return Khung
		end

		-- Nút
		function Tabs.CreateButton(name, tabId, khungIndex, callback)
			if tabId ~= id then return end
			local Khung = TabFrame:FindFirstChildWhichIsA("Frame")
			if not Khung then return end
			local Btn = Instance.new("TextButton", Khung)
			Btn.Text = name
			Btn.Size = UDim2.new(0.8, 0, 0, 25)
			Btn.Position = UDim2.new(0.1, 0, 0.3 * khungIndex, 0)
			Btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			Btn.TextColor3 = Color3.new(1, 1, 1)
			Btn.MouseButton1Click:Connect(callback)
		end
	end

	-- Nút ẩn/hiện ngoài UI
	local ToggleButton = Instance.new("TextButton", ScreenGui)
	ToggleButton.Size = UDim2.new(0, 100, 0, 40)
	ToggleButton.Position = UDim2.new(0, 20, 0.5, -20)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleButton.Text = "Ẩn/Hiện UI"
	ToggleButton.TextScaled = true

	local uiVisible = true
	ToggleButton.MouseButton1Click:Connect(function()
		uiVisible = not uiVisible
		Main.Visible = uiVisible
	end)

	return Tabs
end

return scr
