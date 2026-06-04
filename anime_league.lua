local RunService = game:GetService("RunService")

local container = workspace:WaitForChild("AgentRollEnvironment")

local trackers = {}

local function createTracker(character)
    local head = character:FindFirstChild("Head")
    if not head then return end

    if trackers[character] then
        trackers[character]:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "DebugTracker"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = billboard

    trackers[character] = billboard

    RunService.RenderStepped:Connect(function()
        if not character.Parent then return end

        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            label.Text =
                character.Name ..
                "\nX:" .. math.floor(root.Position.X) ..
                " Y:" .. math.floor(root.Position.Y) ..
                " Z:" .. math.floor(root.Position.Z)
        end
    end)
end

for _, obj in ipairs(container:GetChildren()) do
    if obj:IsA("Model") then
        createTracker(obj)
    end
end

container.ChildAdded:Connect(function(obj)
    if obj:IsA("Model") then
        task.wait(1)
        createTracker(obj)
    end
end)
