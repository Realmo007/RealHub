-- Real Hub Loader (ไม่มี Key ใช้งานได้ทันที)
-- โหลดเมนูสำหรับแต่ละเกม โดยเริ่มจาก Arise Crossover

local PlaceId = game.PlaceId

if PlaceId == 123456789 then -- 👈 เปลี่ยนเป็น PlaceId จริงของ Arise Crossover
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Realmo007/RealHub/main/Games/Arise.lua"))()
else
    warn("🔴 Game not supported yet by Real Hub")
end
