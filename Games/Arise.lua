-- Arise Crossover Auto Farm by Real Hub

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local chr = lp.Character or lp.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

local function getMob()
    local nearest, dist = nil, math.huge
    for _, mob in pairs(workspace:GetDescendants()) do
        if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
            local d = (hrp.Position - mob.HumanoidRootPart.Position).Magnitude
            if d < dist then
                nearest = mob
                dist = d
            end
        end
    end
    return nearest
end

while task.wait(0.3) do
    local mob = getMob()
    if mob then
        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
        mouse1click()
    end
end
