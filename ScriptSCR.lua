--// SCR HUB - Framework (bản test)
local scr = {}
local Tabs = {}

-- Tạo UI chính
function scr.createWindow(title, config)
	local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	ScreenGui.Name = "SCR_HUB"

	-- Hiệu ứng load
	local LoadingFrame = Instance.new("Frame", ScreenGui)
	LoadingFrame.Size = UDim2.new(1,0,1,0)
	LoadingFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	LoadingFrame.BackgroundTransparency = 0
	local Title = Instance.new("TextLabel", LoadingFrame)
	Title.Size = UDim2.new(1,0,1,0)
	Title.Text = "SCR HUB"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.TextScaled = true
	Title.Font = Enum.Font.GothamBold

	task.spawn(function()
		for i=0,1,0.05 do
			task.wait(0.05)
			LoadingFrame.BackgroundTransparency = i
			Title.TextTransparency = i
		end
		LoadingFrame:Destroy()
	end)

	-- UI chính
	local Main = Instance.new("Frame", ScreenGui)
	Main.BackgroundColor3 = Color3.fromRGB(60,60,60)
	Main.BackgroundTransparency = 0.3
	Main.Size = UDim2.new(0.5, 0, 0.6, 0)
	Main.Position = UDim2.new(0.25,0,0.2,0)
	Main.Visible = true
	Main.Name = "MainUI"
	Main.Active = true
	Main.Draggable = true

	-- Thanh trên (Title + Hide)
	local TopBar = Instance.new("Frame", Main)
	TopBar.Size = UDim2.new(1,0,0,30)
	TopBar.BackgroundColor3 = Color3.fromRGB(45,45,45)
	local TitleText = Instance.new("TextLabel", TopBar)
	TitleText.Text = title or "SCR HUB"
	TitleText.Size = UDim2.new(1,-40,1,0)
	TitleText.TextColor3 = Color3.new(1,1,1)
	TitleText.BackgroundTransparency = 1
	TitleText.Font = Enum.Font.GothamBold
	TitleText.TextSize = 16
	local HideBtn = Instance.new("TextButton", TopBar)
	HideBtn.Text = "-"
	HideBtn.Size = UDim2.new(0,30,1,0)
	HideBtn.Position = UDim2.new(1,-30,0,0)
	HideBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
	HideBtn.TextColor3 = Color3.new(1,1,1)

	HideBtn.MouseButton1Click:Connect(function()
		Main.Visible = not Main.Visible
	end)

	-- Thanh tab trái
	local TabBar = Instance.new("ScrollingFrame", Main)
	TabBar.Size = UDim2.new(0,120,1,-30)
	TabBar.Position = UDim2.new(0,0,0,30)
	TabBar.BackgroundColor3 = Color3.fromRGB(50,50,50)
	TabBar.ScrollBarThickness = 4
	TabBar.CanvasSize = UDim2.new(0,0,0,0)

	function Tabs.CreateTab(name, id, order)
		local TabBtn = Instance.new("TextButton", TabBar)
		TabBtn.Text = name
		TabBtn.Size = UDim2.new(1,0,0,30)
		TabBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
		TabBtn.TextColor3 = Color3.new(1,1,1)
		TabBtn.LayoutOrder = order or 1

		local TabFrame = Instance.new("Frame", Main)
		TabFrame.Size = UDim2.new(1,-120,1,-30)
		TabFrame.Position = UDim2.new(0,120,0,30)
		TabFrame.BackgroundTransparency = 1
		TabFrame.Visible = false

		TabBtn.MouseButton1Click:Connect(function()
			for _,v in pairs(Main:GetChildren()) do
				if v:IsA("Frame") and v ~= TopBar and v ~= TabBar then
					v.Visible = false
				end
			end
			TabFrame.Visible = true
		end)

		-- Khung con
		function Tabs.CreateKhung(name, tabId, index)
			if tabId ~= id then return end
			local Khung = Instance.new("Frame", TabFrame)
			Khung.Size = UDim2.new(0.9,0,0,100)
			Khung.Position = UDim2.new(0.05,0,0,(index-1)*110)
			Khung.BackgroundColor3 = Color3.fromRGB(70,70,70)
			local Title = Instance.new("TextLabel", Khung)
			Title.Size = UDim2.new(1,0,0,25)
			Title.Text = name
			Title.BackgroundTransparency = 1
			Title.TextColor3 = Color3.new(1,1,1)
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			return Khung
		end

		function Tabs.CreateButton(name, tabId, khungIndex, callback)
			if tabId ~= id then return end
			local Khung = TabFrame:FindFirstChildWhichIsA("Frame")
			if not Khung then return end
			local Btn = Instance.new("TextButton", Khung)
			Btn.Text = name
			Btn.Size = UDim2.new(0.8,0,0,25)
			Btn.Position = UDim2.new(0.1,0,0.3*khungIndex,0)
			Btn.BackgroundColor3 = Color3.fromRGB(100,100,100)
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.MouseButton1Click:Connect(callback)
		end
	end

	return Tabs
end

return scr
