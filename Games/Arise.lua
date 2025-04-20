-- Arise Crossover Auto Farm | Real Hub Edition

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- สร้าง UI
local ui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ui.Name = "RealHubUI"

local btn = Instance.new("TextButton", ui)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0, 20, 0, 150)
btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.Gotham
btn.TextSize = 16
btn.Text = "✅ เปิด Auto Farm"

local autofarm = false
btn.MouseButton1Click:Connect(function()
    autofarm = not autofarm
    btn.Text = autofarm and "🛑 ปิด Auto Farm" or "✅ เปิด Auto Farm"
end)

-- ฟังก์ชันหามอน
local function getMob()
    local nearest, dist = nil, math.huge

    for _, mob in pairs(workspace:GetDescendants()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            if mob.Humanoid.Health > 0 then
                local d = (hrp.Position - mob.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    nearest = mob
                    dist = d
                end
            end
        end
    end

    return nearest
end

-- ลูปฟาร์ม
task.spawn(function()
    while task.wait(0.3) do
        if autofarm then
            local mob = getMob()
            if mob then
                pcall(function()
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                    mouse1click()
                end)
            end
        end
    end
end)
