local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer

local ENABLED = false
local ACTIVE = {}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DevVisualizer"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 220, 0, 60)
button.Position = UDim2.new(0, 20, 0, 20)
button.Text = "VISUALIZER: OFF"
button.TextScaled = true
button.Parent = gui

button.MouseButton1Click:Connect(function()
	ENABLED = not ENABLED
	button.Text = ENABLED and "VISUALIZER: ON" or "VISUALIZER: OFF"
end)

local function addHighlight(character)
	if character:FindFirstChild("DevHighlight") then
		return
	end

	local hl = Instance.new("Highlight")
	hl.Name = "DevHighlight"
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.FillColor = Color3.fromRGB(0, 255, 255)
	hl.OutlineColor = Color3.fromRGB(255, 255, 255)
	hl.FillTransparency = 0.4
	hl.OutlineTransparency = 0
	hl.Parent = character
end

local function startVisuals(character)
	if ACTIVE[character] then
		return
	end

	ACTIVE[character] = true

	addHighlight(character)

	task.spawn(function()
		local root = character:FindFirstChild("HumanoidRootPart")
			or character:WaitForChild("HumanoidRootPart", 10)

		if not root then
			ACTIVE[character] = nil
			return
		end

		while character.Parent do
			if ENABLED then
				local orb = Instance.new("Part")
				orb.Shape = Enum.PartType.Ball
				orb.Size = Vector3.new(6, 6, 6)
				orb.Position = root.Position + Vector3.new(0, 3, 0)
				orb.Anchored = true
				orb.CanCollide = false
				orb.Material = Enum.Material.Neon
				orb.Transparency = 0.15
				orb.Color = Color3.fromRGB(0, 255, 255)
				orb.Parent = workspace

				local light = Instance.new("PointLight")
				light.Range = 35
				light.Brightness = 8
				light.Parent = orb

				TweenService:Create(
					orb,
					TweenInfo.new(2.5),
					{
						Transparency = 1,
						Size = Vector3.new(12, 12, 12)
					}
				):Play()

				Debris:AddItem(orb, 2.5)
			end

			task.wait(0.03)
		end

		ACTIVE[character] = nil
	end)
end

local function setupPlayer(player)
	if player.Character then
		startVisuals(player.Character)
	end

	player.CharacterAdded:Connect(startVisuals)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
