local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local enabled = true
local trackers = {}

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Tracker: ON"
toggleButton.Parent = screenGui

local function updateVisibility()
	for _, tracker in pairs(trackers) do
		if tracker then
			tracker.Enabled = enabled
		end
	end

	toggleButton.Text = enabled and "Tracker: ON" or "Tracker: OFF"
end

toggleButton.MouseButton1Click:Connect(function()
	enabled = not enabled
	updateVisibility()
end)

local function createTracker(character)
	local head = character:FindFirstChild("Head")
	if not head then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "DebugTracker"
	billboard.Size = UDim2.new(0, 150, 0, 40)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Enabled = enabled
	billboard.Parent = head

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.Text = character.Name
	label.Parent = billboard

	trackers[character] = billboard
end

local container = workspace:WaitForChild("AgentRollEnvironment")

for _, obj in ipairs(container:GetChildren()) do
	if obj:IsA("Model") then
		createTracker(obj)
	end
end

container.ChildAdded:Connect(function(obj)
	if obj:IsA("Model") then
		task.wait(0.5)
		createTracker(obj)
	end
end)
