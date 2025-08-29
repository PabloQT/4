repeat task.wait() until game:IsLoaded()
task.wait(2)

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Fps = Instance.new("TextLabel")
local Ping = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- FPS Label
Fps.Name = "Fps"
Fps.Parent = ScreenGui
Fps.BackgroundTransparency = 1
Fps.AnchorPoint = Vector2.new(0.5, 0.5) -- center alignment
Fps.Position = UDim2.new(0.5, 0, 0.5, -20) -- centered, a bit above middle
Fps.Size = UDim2.new(0, 300, 0, 50) -- bigger box
Fps.Font = Enum.Font.SourceSansBold
Fps.TextColor3 = Color3.fromRGB(255, 255, 255)
Fps.TextScaled = true
Fps.Text = "FPS: 0"

-- Ping Label (below FPS)
Ping.Name = "Ping"
Ping.Parent = ScreenGui
Ping.BackgroundTransparency = 1
Ping.AnchorPoint = Vector2.new(0.5, 0.5)
Ping.Position = UDim2.new(0.5, 0, 0.5, 40) -- directly under FPS
Ping.Size = UDim2.new(0, 300, 0, 50)
Ping.Font = Enum.Font.SourceSansBold
Ping.TextColor3 = Color3.fromRGB(255, 255, 255)
Ping.TextScaled = true
Ping.Text = "Ping: 0"

-- FPS Script
local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function(deltaTime)
	Fps.Text = "FPS: " .. math.floor(1 / deltaTime + 0.5)
end)

-- Ping Script with color
local Stats = game:GetService("Stats")
local PingStat = Stats.Network.ServerStatsItem["Data Ping"]

RunService.RenderStepped:Connect(function()
	local pingString = PingStat:GetValueString()
	local pingNumber = tonumber(pingString:match("%d+")) or 0
	
	-- Change color based on ping value
	if pingNumber < 100 then
		Ping.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
	elseif pingNumber < 200 then
		Ping.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow
	else
		Ping.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red
	end
	
	Ping.Text = "Ping: " .. pingString
end)
