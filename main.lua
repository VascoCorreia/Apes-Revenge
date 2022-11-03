require "vector2"
require "conf"
require "collision"
require "player"
require "world"
require "trampolines"
require "shooting"
require "weapons"
require "UI"

world = {}


function love.load()
  love.window.setMode(0,0, {fullscreen = true})
  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]
  loadRoundTimer()
 
  world[1] = createObject(0, 980, 1920, 100) -- floor
  world[2] = createObject(350, 780, 500, 50) -- 1st layer platform left
  world[3] = createObject(1070, 780, 500, 50) -- 1st layer platform right
  world[4] = createObject(810, 550, 300, 100) -- 2nd layer middle
  world[5] = createObject(200,400, 200, 50) -- 2nd layer left
  world[6] = createObject(1520,400,200,50) -- 2nd layer right
  world[7] = createObject(600,320,720,50) -- 3rd layer middle
  world[8] = createObject(0,90, 200, 50) -- 3rd layer left
  world[9] = createObject(1720,90,200,50) -- 3rd layer right
  world[10] = createObject(95,680,10,150) -- left trampoline left barrier
  world[11] = createObject(100,830,150,10) -- left trampoline down barrier
  world[12] = createObject(1650,830,150,10) -- right trampoline down barrier
  world[13] = createObject(1800,680,10,150)
  -- trampolines hitboxes
  --start of left trampoline
--[[
  world[10] = createObject(100,700,20,10) 
  world[11] = createObject(100,710,30,10)
  world[12] = createObject(100,720,40,10)
  world[13] = createObject(100,730,50,10)
  world[14] = createObject(100,740,60,10)
  world[15] = createObject(100,750,70,10)
  world[16] = createObject(100,760,80,10)
  world[17] = createObject(100,770,90,10)
  world[18] = createObject(100,780,100,10)
  world[19] = createObject(100,790,110,10)
  world[20] = createObject(100,800,120,10)
  world[21] = createObject(100,810,130,10)
  world[22] = createObject(100,820,140,10)
  world[23] = createObject(100,830,150,10)
  
  -- end of left trampoline
  --start of right trampoline
  
  world[24] = createObject(1780,700,20,10) 
  world[25] = createObject(1770,710,30,10)
  world[26] = createObject(1760,720,40,10)
  world[27] = createObject(1750,730,50,10)
  world[28] = createObject(1740,740,60,10)
  world[29] = createObject(1730,750,70,10)
  world[30] = createObject(1720,760,80,10)
  world[31] = createObject(1710,770,90,10)
  world[32] = createObject(1700,780,100,10)
  world[33] = createObject(1690,790,110,10)
  world[34] = createObject(1680,800,120,10)
  world[35] = createObject(1670,810,130,10)
  world[36] = createObject(1660,820,140,10)
  world[37] = createObject(1650,830,150,10)
  ]]--


end

function love.update(dt)

  updatePlayer1(dt,world)
  updatePlayer2(dt,world)
  updateBullets(dt,"Pistol")
  updateBullets(dt,"Shotgun")
  player1Death("Pistol")
  player1Death("Shotgun")
  player2Death("Pistol")
  player2Death("Shotgun")
  updateWeapons(dt,"Pistol")
  updateWeapons(dt,"Shotgun")
  updateRoundTime(dt)
  weaponCooldown(dt, "Pistol", 1 )
  weaponCooldown(dt, "Shotgun", 1 )
  weaponCooldown(dt, "Pistol", 2 )
  weaponCooldown(dt, "Shotgun", 2 )
  --trampolinesAirTimer(dt,1,1) -- player 1, left trampoline timer
  --trampolinesAirTimer(dt,2,1) -- player 1, right trampoline timer
  print(players[1].onTrampoline, players[1].velocity.x, players[1].acceleration.x, players[1].acceleration.y)
  
  
  
  --weaponCooldown("Pistol", dt, 1)
end  

function love.draw()

  drawTrampolines(trampolines)
  drawWorld(world)
  drawPlayer()
  drawBullets()
  love.graphics.setColor(0,1,0)
  drawWeapon("Pistol")
  love.graphics.setColor(0,0,1) -- shotguns are blue
  drawWeapon("Shotgun")
  drawTimer()
  drawPlayerScores()  

end

function love.keypressed(key)--[[love.gamepadpressed(joystick,button)--]]
  if (key == 'w') and players[1].jumpsleft == 1 then   --if the player only has 1 jump left this means it is the doublejump
    players[1].doublejump = true  
  else
    players[1].doublejump = false
  end
    
  --[[if (key == "up") and players[2].jumpsleft == 1 then-- if the player only has 1 jump left this means it is the doublejump
    players[2].doublejump = true  

  else
    players[2].doublejump = false -- else it is the regular jump
  end  
  ]]--
  if key == "l" then
    spawnWeapon("Pistol")
  elseif key == "o" then
    spawnWeapon("Shotgun")
  end
end





-- IF NEEDED TO KNOW PLATFORM COORDINATES --

   --[[
    for i= 1, table.getn(world),1 do
    local position = {}
    position[i] = world[i].position.x + world[i].size.x
    end 
    
    love.graphics.print(tostring(position[i]), (world[i].position.x + world[i].size.x) - 100 ,  (world[i].position.y + world[i].size.y) - 100)
    love.graphics.print(tostring(world[i].size.x), (world[i].position.x + world[i].size.x) - 100 ,  (world[i].position.y + world[i].size.y) - 70)
    love.graphics.print(tostring(world[i].position.x), (world[i].position.x) ,  (world[i].position.y + world[i].size.y) - 70)--]]
