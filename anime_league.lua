local target = workspace:WaitForChild("AgentRollEnvironment")
	:WaitForChild("Character")
	:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 40)
button.Position = UDim2.new(0, 20, 0, 20)
button.Text = "Tracer: OFF"
button.Parent = gui

local enabled = false

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	button.Text = enabled and "Tracer: ON" or "Tracer: OFF"
end)

task.spawn(function()
	while true do
		if enabled and target then
			local marker = Instance.new("Part")
			marker.Shape = Enum.PartType.Ball
			marker.Size = Vector3.new(1, 1, 1)
			marker.Anchored = true
			marker.CanCollide = false
			marker.Position = target.Position
			marker.Parent = workspace

			game:GetService("Debris"):AddItem(marker, 10)
		end

		task.wait(0.25)
	end
end)
