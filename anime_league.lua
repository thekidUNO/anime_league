local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local function createTrail(character)
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		root = character:WaitForChild("HumanoidRootPart", 10)
	end

	if not root then
		return
	end

	task.spawn(function()
		while character.Parent do
			local orb = Instance.new("Part")
			orb.Shape = Enum.PartType.Ball
			orb.Size = Vector3.new(1, 1, 1)
			orb.Position = root.Position
			orb.Anchored = true
			orb.CanCollide = false
			orb.Material = Enum.Material.Neon
			orb.Transparency = 0
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

			task.wait(0.05)
		end
	end)
end

local function setupPlayer(player)
	if player.Character then
		createTrail(player.Character)
	end

	player.CharacterAdded:Connect(createTrail)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
