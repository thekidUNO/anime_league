local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer

local enabled = false
local tracked = {}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DevTrailGUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 50)
button.Position = UDim2.new(0, 20, 0, 20)
button.Text = "Trails: OFF"
button.TextScaled = true
button.Parent = gui

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	button.Text = enabled and "Trails: ON" or "Trails: OFF"
end)

local function startTrail(character)
	if tracked[character] then
		return
	end

	tracked[character] = true

	task.spawn(function()
		local root = character:FindFirstChild("HumanoidRootPart")
			or character:WaitForChild("HumanoidRootPart", 10)

		if not root then
			tracked[character] = nil
			return
		end

		while character.Parent do
			if enabled then
				local orb = Instance.new("Part")
				orb.Shape = Enum.PartType.Ball
				orb.Size = Vector3.new(1, 1, 1)
				orb.Position = root.Position + Vector3.new(0, 1, 0)
				orb.Anchored = true
				orb.CanCollide = false
				orb.Material = Enum.Material.Neon
				orb.Parent = workspace

				TweenService:Create(
					orb,
					TweenInfo.new(1.5),
					{
						Transparency = 1,
						Size = Vector3.new(0.1, 0.1, 0.1)
					}
				):Play()

				Debris:AddItem(orb, 1.5)
			end

			task.wait(0.05)
		end

		tracked[character] = nil
	end)
end

local function setupPlayer(player)
	if player.Character then
		startTrail(player.Character)
	end

	player.CharacterAdded:Connect(startTrail)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
