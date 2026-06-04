local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "PositionTracerGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 40)
button.Position = UDim2.new(0, 20, 0, 20)
button.Text = "Tracer: OFF"
button.Parent = gui

local enabled = false
local loopRunning = false

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	button.Text = enabled and "Tracer: ON" or "Tracer: OFF"

	if enabled and not loopRunning then
		loopRunning = true

		task.spawn(function()
			while enabled do
				local character = player.Character
				if character then
					local hrp = character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local marker = Instance.new("Part")
						marker.Shape = Enum.PartType.Ball
						marker.Size = Vector3.new(0.5, 0.5, 0.5)
						marker.Anchored = true
						marker.CanCollide = false
						marker.Position = hrp.Position
						marker.Parent = workspace

						task.delay(10, function()
							if marker then
								marker:Destroy()
							end
						end)
					end
				end
				task.wait(0.5)
			end
			loopRunning = false
		end)
	end
end)
