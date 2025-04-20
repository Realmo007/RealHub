-- Arise Crossover Auto Farm | Real Hub Edition (ปรับปรุง)
-- วาร์ป + ตี มอนสเตอร์อัตโนมัติ พร้อม UI เปิด/ปิด

local Players    = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP         = Character:WaitForChild("HumanoidRootPart")
local RunService  = game:GetService("RunService")

-- 1) สร้าง UI เรียบง่าย
local ui        = Instance.new("ScreenGui")
ui.Name         = "RealHubUI"
ui.ResetOnSpawn = false
ui.Parent       = game:GetService("CoreGui")

local frame      = Instance.new("Frame", ui)
frame.Size       = UDim2.new(0, 220, 0, 60)
frame.Position   = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active     = true
frame.Draggable  = true

local btn        = Instance.new("TextButton", frame)
btn.Size         = UDim2.new(1, -4, 1, -4)
btn.Position     = UDim2.new(0, 2, 0, 2)
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.Font         = Enum.Font.GothamBold
btn.TextSize     = 14
btn.TextColor3   = Color3.new(1,1,1)
btn.Text         = "✅ เปิด Auto Farm"

local autoFarmEnabled = false
btn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    btn.Text = autoFarmEnabled and "⏹ ปิด Auto Farm" or "✅ เปิด Auto Farm"
end)

-- 2) ฟังก์ชันค้นหาโฟลเดอร์มอนสเตอร์แบบไดนามิก
local function getClientFolder()
    for _, child in ipairs(workspace:GetChildren()) do
        -- ถ้าชื่อมีคำว่า “enem” รวมถึง “enemies”, “enemy”
        if child:IsA("Folder") and string.find(child.Name:lower(), "enem") then
            local client = child:FindFirstChild("Client")
            if client and client:IsA("Folder") then
                return client
            end
        end
    end
    return nil
end

-- 3) ฟังก์ชันดึงรายชื่อมอนสเตอร์ที่ยังไม่ตาย
local function getMonsters()
    local folder = getClientFolder()
    if not folder then return {} end
    local list = {}
    for _, mob in ipairs(folder:GetChildren()) do
        if mob:IsA("Model")
        and mob:FindFirstChild("Humanoid")
        and mob:FindFirstChild("HumanoidRootPart")
        and mob.Humanoid.Health > 0 then
            table.insert(list, mob)
        end
    end
    return list
end

-- 4) ฟังก์ชันวาร์ป + ตี
local function farmOnce()
    local monsters = getMonsters()
    if #monsters == 0 then return end

    -- เลือกมอนสเตอร์แบบสุ่ม (จะได้ไม่วนเจอตัวเดิมจนเบื่อ)
    local target = monsters[math.random(1, #monsters)]
    local root   = target:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- วาร์ปไปใกล้ ๆ หน้าเป้า
    HRP.CFrame = root.CFrame * CFrame.new(0, 0, 2)

    -- รอให้วาร์ปเสร็จ แล้วโจมตี
    task.wait(0.1)
    -- ถ้าเกมใช้ ClickDetector:
    local cd = target.PrimaryPart and target.PrimaryPart:FindFirstChildOfClass("ClickDetector")
    if cd then
        fireclickdetector(cd)
    else
        -- ไม่งั้นลองคลิกเมาส์ธรรมดา
        mouse1click()
    end
end

-- 5) ลูป Auto Farm
RunService.Heartbeat:Connect(function()
    if autoFarmEnabled then
        farmOnce()
    end
end)
