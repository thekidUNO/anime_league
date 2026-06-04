local player = game:GetService("Players").LocalPlayer
local myRoot = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")

local targetRoot = workspace:WaitForChild("AgentRollEnvironment")
    :WaitForChild("Character")
    :WaitForChild("HumanoidRootPart")

local a0 = Instance.new("Attachment", myRoot)
local a1 = Instance.new("Attachment", targetRoot)

local beam = Instance.new("Beam")
beam.Attachment0 = a0
beam.Attachment1 = a1
beam.Width0 = 0.2
beam.Width1 = 0.2
beam.FaceCamera = true
beam.Parent = workspace
