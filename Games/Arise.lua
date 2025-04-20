-- ฟังก์ชั่นนี้จะหามอนสเตอร์ในโฟลเดอร์ "Enemies.Client"
local function findMonsters()
    local monsters = {}
    for _, v in pairs(workspace.__Main.Enemies.Client:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            table.insert(monsters, v)
        end
    end
    return monsters
end

-- ฟังก์ชั่นวาร์ปไปหามอนสเตอร์ใกล้ ๆ
local function teleportToMonster(monster)
    local hrp = monster:FindFirstChild("HumanoidRootPart")
    if hrp then
        game.Players.LocalPlayer.Character:MoveTo(hrp.Position)
    end
end

-- ฟังก์ชั่นโจมตีมอนสเตอร์
local function attackMonster(monster)
    local humanoid = monster:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health > 0 then
        -- โค้ดโจมตีหรือยิงมอนสเตอร์ (อาจจะใช้ RemoteEvent หรือการคลิกมอนสเตอร์)
        fireclickdetector(monster.PrimaryPart:FindFirstChildOfClass("ClickDetector"))
    end
end

-- ฟังก์ชั่นหลักที่จะทำงานในลูป
local function autoFarm()
    while true do
        local monsters = findMonsters()  -- หา monster ทั้งหมด
        if #monsters > 0 then
            -- เลือกมอนสเตอร์แบบสุ่ม
            local monster = monsters[math.random(1, #monsters)]
            teleportToMonster(monster)  -- วาร์ปไปหามอนสเตอร์
            attackMonster(monster)  -- ตีมอนสเตอร์
        end
        wait(1)  -- พัก 1 วินาที
    end
end

-- เริ่มฟังก์ชั่น Auto Farm
autoFarm()
