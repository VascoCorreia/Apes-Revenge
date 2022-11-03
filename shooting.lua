cooldownPlayer = {
    {
     up = true
    },
    {
     up = false
    }
   }

bulletsPlayer = 
{
  {
  Pistol = {},
  Shotgun = {}
  },
  {
  Pistol = {},
  Shotgun = {}
  }
}



bulletProperties = {size = vector2.new(15,15)}

function drawBullets()

  love.graphics.setColor(1,0,0)
  for i = 1, table.getn(bulletsPlayer[1].Shotgun), 1 do -- draw bullets player1 shotgun
    if bulletsPlayer[1].Shotgun[i] ~= nil then
      love.graphics.rectangle('fill', bulletsPlayer[1].Shotgun[i].positionx, bulletsPlayer[1].Shotgun[i].positiony, bulletProperties.size.x,bulletProperties.size.y)    
    end
  end
  
  for i = 1, table.getn(bulletsPlayer[1].Pistol), 1 do -- draw bullets player1 shotgun
    if bulletsPlayer[1].Pistol[i] ~= nil then
      love.graphics.rectangle('fill', bulletsPlayer[1].Pistol[i].positionx, bulletsPlayer[1].Pistol[i].positiony, bulletProperties.size.x,bulletProperties.size.y)    
    end
  end
    love.graphics.setColor(0,0,1)
    for i = 1, table.getn(bulletsPlayer[2].Pistol), 1 do -- draw bullets Player2
    if bulletsPlayer[2].Pistol[i] ~= nil then
      
      love.graphics.rectangle('fill', bulletsPlayer[2].Pistol[i].positionx, bulletsPlayer[2].Pistol[i].positiony, bulletProperties.size.x,bulletProperties.size.y  )    
    
    end
  end
  
  for i = 1, table.getn(bulletsPlayer[2].Shotgun), 1 do -- draw bullets Player2
    if bulletsPlayer[2].Shotgun[i] ~= nil then
      
      love.graphics.rectangle('fill', bulletsPlayer[2].Shotgun[i].positionx, bulletsPlayer[2].Shotgun[i].positiony, bulletProperties.size.x,bulletProperties.size.y  )    
    
    end
  end
  
end

function updateBullets(dt, weapon)
  -- UPDATE BULLET PLAYER 1
  for i = 1, table.getn(bulletsPlayer[1][weapon]), 1 do -- update bullets shotgun player 1
    if bulletsPlayer[1][weapon][i] ~= nil then
      bulletsPlayer[1][weapon][i].positionx = bulletsPlayer[1][weapon][i].positionx + (bulletsPlayer[1][weapon][i].directionx * dt)
      bulletsPlayer[1][weapon][i].positiony = bulletsPlayer[1][weapon][i].positiony + (bulletsPlayer[1][weapon][i].directiony * dt)
    -- bullet movement (end) --
      if bulletsPlayer[1][weapon][i].positionx > love.graphics.getWidth() or bulletsPlayer[1][weapon][i].positiony <= 0 or bulletsPlayer[1][weapon][i].positionx < 0  then -- bullets dissappear if touch end screen or ceiling
        
        table.remove(bulletsPlayer[1][weapon], i)
        
      end
    end
  end 
  
  -- UPDATE BULLET PLAYER 2
  for i = 1, table.getn(bulletsPlayer[2][weapon]), 1 do 
    if bulletsPlayer[2][weapon][i] ~= nil then
      bulletsPlayer[2][weapon][i].positionx = bulletsPlayer[2][weapon][i].positionx + (bulletsPlayer[2][weapon][i].directionx * dt)
      bulletsPlayer[2][weapon][i].positiony = bulletsPlayer[2][weapon][i].positiony + (bulletsPlayer[2][weapon][i].directiony * dt)
      -- bullet movement (end) --
      
      if bulletsPlayer[2][weapon][i].positionx > love.graphics.getWidth() or bulletsPlayer[2][weapon][i].positiony <= 0 or bulletsPlayer[2][weapon][i].positionx < 0  then -- bullets dissappear if touch end screen or ceiling
        
        table.remove(bulletsPlayer[2][weapon], i)
        
      end
    end
  end 
  
  bulletCollisionWorld("Pistol", 1)
  bulletCollisionWorld("Shotgun", 1)
  bulletCollisionWorld("Pistol", 2)
  bulletCollisionWorld("Shotgun", 2)
 
  
  
  
end

function createBullet(x,y,angle,speed,weapon,player)
  

  local directionx = speed * math.cos(angle)
  local directiony = speed * math.sin(angle)
  
  table.insert(bulletsPlayer[player][weapon], {positionx = x, positiony = y, directionx = directionx, directiony= directiony, speed = speed})
  
end



function bulletCollisionWorld(weapon, player)
  
  for i = 1, table.getn(bulletsPlayer[player][weapon]),1 do
    for j = 1, table.getn(world),1 do
      if bulletsPlayer[player][weapon][i] ~= nil then
    
        local collided =  CheckBoxCollision(world[j].position.x,world[j].position.y,world[j].size.x,world[j].size.y,bulletsPlayer[player][weapon][i].positionx,bulletsPlayer[player][weapon][i].positiony,bulletProperties.size.x,bulletProperties.size.y) 
      
        if collided then
          table.remove(bulletsPlayer[player][weapon],i)
        end
      end
    end
  end
end

function weaponCooldown(dt, weapon, player) -- bullet cooldown
  
  if cooldownPlayer[player].up == true and players[player].weaponequipped[weapon] ==  true then
    
  weapons[weapon].cooldown = weapons[weapon].cooldown - dt
  
    if weapons[weapon].cooldown <= 0 and weapon == "Pistol" then
    
      weapons[weapon].cooldown = 0.5
      cooldownPlayer[player].up = false
    elseif weapons[weapon].cooldown <= 0 and weapon == "Shotgun" then
      weapons[weapon].cooldown = 1.50
      cooldownPlayer[player].up = false
    end
  end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		local startX = players[1].position.x + players[1].width / 2
		local startY = players[1].position.y + players[1].height / 2
		local mouseX = x
		local mouseY = y
 
		local angle = math.atan2((mouseY - startY), (mouseX - startX))
   
   if players[1].weaponequipped.Pistol == true  and cooldownPlayer[1].up == false then
      cooldownPlayer[1].up = true
      createBullet(players[1].position.x, players[1].position.y ,angle, 1300, "Pistol", 1)
    elseif players[1].weaponequipped.Shotgun == true and cooldownPlayer[1].up == false then
      cooldownPlayer[1].up = true
      createBullet(players[1].position.x, players[1].position.y ,angle ,600 ,"Shotgun", 1)
      createBullet(players[1].position.x, players[1].position.y ,angle  + (math.pi/24) ,600 ,"Shotgun", 1)
      createBullet(players[1].position.x, players[1].position.y ,angle - (math.pi/24
          ) ,600 ,"Shotgun", 1)
    end
  end
end

function love.gamepadpressed( joystick, button )
  if joystick == joystick and button == "dpup" and players[2].jumpsleft == 1 then
    players[2].doublejump = true  
  else
    players[2].doublejump = false 
  end
  if joystick == joystick and button == "rightshoulder" then 
    if players[2].weaponequipped.Pistol == true and cooldownPlayer[2].up == false then
        cooldownPlayer[2].up = true
        createBullet(players[2].position.x, players[2].position.y , math.atan2(((players[1].position.y + joystick:getGamepadAxis("righty")) - players[1].position.y), ((players[1].position.x+joystick:getGamepadAxis("rightx")) - players[1].position.x)), 1000, "Pistol", 2)
      elseif players[2].weaponequipped.Shotgun == true and cooldownPlayer[2].up == false then
        cooldownPlayer[2].up = true
       createBullet(players[2].position.x + (players[2].width/2), players[2].position.y + (players[2].height/2) , math.atan2(((players[1].position.y + joystick:getGamepadAxis("righty")) - players[1].position.y), ((players[1].position.x+joystick:getGamepadAxis("rightx")) - players[1].position.x)), 600, "Shotgun", 2)
        createBullet(players[2].position.x + (players[2].width/2), players[2].position.y + (players[2].height/2) ,  (math.atan2(((players[1].position.y + joystick:getGamepadAxis("righty")) - players[1].position.y), ((players[1].position.x+joystick:getGamepadAxis("rightx")) - players[1].position.x))+ math.pi/24) ,600 ,"Shotgun", 2)
        createBullet(players[2].position.x + (players[2].width/2), players[2].position.y + (players[2].height/2) ,  (math.atan2(((players[1].position.y + joystick:getGamepadAxis("righty")) - players[1].position.y), ((players[1].position.x+joystick:getGamepadAxis("rightx")) - players[1].position.x))- math.pi/24) ,600 ,"Shotgun", 2)
      end
  end
end

--[[
local startX = players[1].position.x + players[1].width / 2
local startY = players[1].position.y + players[1].height / 2
local mouseX = x
local mouseY = y
 
local angle = math.atan2((mouseY - startY), (mouseX - startX))

local directionx = speed * math.cos(angle)
local directiony = speed * math.sin(angle)--]]

--PLAYER 1  NOW SHOOTS WITH MOUSE!!!
--PLAYER 2 SHOOTS WITH CONTROLLER!!!
--[[function love.keyreleased(key, scancode, isrepeat)

  
  if key == 'space'  then   
    if players[1].weaponequipped.Pistol == true and cooldownPlayer[1].up == false then
      cooldownPlayer[1].up = true
      createBullet(players[1].position.x, players[1].position.y ,0 , 1000, "Pistol", 1)
    elseif players[1].weaponequipped.Shotgun == true and cooldownPlayer[1].up == false then
      cooldownPlayer[1].up = true
      createBullet(players[1].position.x, players[1].position.y ,0 ,600 ,"Shotgun", 1)
      createBullet(players[1].position.x, players[1].position.y ,(math.pi/12) ,600 ,"Shotgun", 1)
      createBullet(players[1].position.x, players[1].position.y ,-(math.pi/12) ,600 ,"Shotgun", 1)
    end
      
    if key == 'kpenter' then
      if players[2].weaponequipped.Pistol == true and cooldownPlayer[2].up == false then
        cooldownPlayer[2].up = true
        createBullet(players[2].position.x, players[2].position.y , math.atan2(((players[1].position.y + joystick:getGamepadAxis("righty")) - players[1].position.y), ((players[1].position.x+joystick:getGamepadAxis("rightx")) - players[1].position.x)), 1000, "Pistol", 2)
      elseif players[2].weaponequipped.Shotgun == true and cooldownPlayer[2].up == false then
        cooldownPlayer[2].up = true
        createBullet(players[2].position.x, players[2].position.y ,0 ,600 ,"Shotgun", 2)
        createBullet(players[2].position.x, players[2].position.y ,(math.pi/12) ,600 ,"Shotgun", 2)
        createBullet(players[2].position.x, players[2].position.y ,-(math.pi/12) ,600 ,"Shotgun", 2)
      end
  end
end--]]