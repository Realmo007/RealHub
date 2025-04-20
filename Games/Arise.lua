-- Simple UI Menu
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
local Toggle = Instance.new("TextButton", Frame)

ScreenGui.Name = "RealHubUI"
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 50, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

Toggle.Size = UDim2.new(1, 0, 1, 0)
Toggle.Text = "🔥 Toggle Auto Farm"
Toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

local AutoFarm = false

Toggle.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    Toggle.Text = AutoFarm and "✅ Auto Farm: ON" or "❌ Auto Farm: OFF"
end)

-- Auto Farm loop
task.spawn(function()
    while task.wait(0.3) do
        if AutoFarm then
            local mob = getMob()
            if mob then
                hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                mouse1click()
            end
        end
    end
end)
