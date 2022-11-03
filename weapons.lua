local cron = require "cron"

weapons = {
  
  Pistol = {collided_Pistol_World = false,  cooldown = 0.75}, -- 1 cooldown
  Shotgun = {collided_Shotgun_World = false, cooldown = 1.50} -- 2 cooldown
  
}



function spawnWeaponFinal()
  
  local numbers = {}
  
  numbers[1] = math.random(1, 100)
  numbers[2] = math.random(1, 100)

  if (numbers[1] > 1 or numbers[2] > 1) and (numbers[1]<=50 or numbers[2] <= 50) then
    spawnWeapon("Pistol")
  elseif (numbers[1]>51 or numbers[2] > 51) and (numbers[1]<= 100 or numbers[2] <= 100) then
    spawnWeapon("Shotgun")
  end
end

function removeWeapons(weapon)
  for i = 1 , table.getn(weapons[weapon]), 1 do
    weapons[weapon][i] = nil
  end
end


function spawnWeapon(weapon)
  table.insert(weapons[weapon], 1)  
  for i = 1 , table.getn(weapons[weapon]), 1 do 
    weapons[weapon][i] = createObject(math.random(0,1920), 0, 30,30)
  end
end

local removePistolTimer = cron.every(10,removeWeapons,"Pistol") -- removes Pistols on map every 10 seconds
local removeShotgunTimer = cron.every(10,removeWeapons,"Shotgun") --removes Shotguns on map every 10 seconds
local spawnWeaponTimer = cron.every(10,spawnWeaponFinal) -- spawns a weapon every 10 seconds
local spawnWeaponTimer2 = cron.every(10,spawnWeaponFinal) -- spawns a weapon every 10 seconds

function updateWeapons(dt, weapon)
  
  removePistolTimer:update(dt)-- timer to remove pistols using cron library
  removeShotgunTimer:update(dt)
  spawnWeaponTimer:update(dt)
  spawnWeaponTimer2:update(dt)

--WEAPON COLLECTED COLLISION FOR BOTH PLAYERS

  for i = 1, table.getn(weapons[weapon]), 1 do
    if weapons[weapon][i] ~= nil then
     
      local collected_weapon_Player1 = CheckBoxCollision(players[1].position.x,players[1].position.y, players[1].width, players[1].height ,weapons[weapon][i].position.x,weapons[weapon][i].position.y ,weapons[weapon][i].size.x, weapons[weapon][i].size.y) 
      local collected_weapon_Player2 = CheckBoxCollision(players[2].position.x,players[2].position.y, players[2].width, players[2].height, weapons[weapon][i].position.x, weapons[weapon][i].position.y ,weapons[weapon][i].size.x,weapons[weapon][i].size.y) 
      
      -- IF PLAYER 1 COLLECTS SHOTGUN
      
      if collected_weapon_Player1 and weapon == "Shotgun" then
        
        players[1].weaponequipped.Shotgun = true
        players[1].weaponequipped.Pistol = false
        weapons[weapon][i] = nil
        
        --IF PLAYER 1 COLLECTS PISTOL
        
      elseif collected_weapon_Player1 and weapon == "Pistol" then
        players[1].weaponequipped.Shotgun = false
        players[1].weaponequipped.Pistol = true
        weapons[weapon][i] = nil 
        
        -- IF PLAYER 2 COLLECTS SHOTGUN
        
      elseif  collected_weapon_Player2 and weapon == "Shotgun" then
        players[2].weaponequipped.Shotgun = true
        players[2].weaponequipped.Pistol = false
        weapons[weapon][i] = nil
        
      -- IF PLAYER 2 COLLECTS PISTOL
        
      elseif collected_weapon_Player2 and weapon == "Pistol" then
        players[2].weaponequipped.Shotgun = false
        players[2].weaponequipped.Pistol = true
        weapons[weapon][i] = nil
        
      end
    end
  end
   
  for i = 1, table.getn(world), 1 do
   for j = 1, table.getn(weapons[weapon]), 1 do

      if weapons[weapon][j] ~= nil then
        local collided = CheckBoxCollision(world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y , weapons[weapon][j].position.x, weapons[weapon][j].position.y ,weapons[weapon][j].size.x, weapons[weapon][j].size.y) 
        if collided then
          weapons[weapon][j].collided_Pistol_World = true
        end
      end
    end
  end
  
  for i = 1, table.getn(weapons[weapon]), 1 do
    if weapons[weapon][i] ~= nil then
      if not weapons[weapon][i].collided_Pistol_World then
        weapons[weapon][i].position.y = weapons[weapon][i].position.y + (400 * dt) 
      end
    end
  end
end

function drawWeapon(weapon)
  for i = 1, table.getn(weapons[weapon]), 1 do
    if weapons[weapon][i] ~= nil then

      love.graphics.rectangle("fill", weapons[weapon][i].position.x, weapons[weapon][i].position.y, weapons[weapon][i].size.x, weapons[weapon][i].size.y)
  
    end
  end
    
end


--[[function weaponCooldown(weapon, dt, player)
  
  local pistol_Cooldown = 1
  local shotgun_Cooldown = 2
  
  if weapon == "Pistol" and weapons[weapon].cooldown == true then
    pistol_Cooldown = pistol_Cooldown - dt
  elseif weapon == "Shotgun" and weapons[weapon].cooldown == true then
    shotgun_Cooldown = shotgun_Cooldown - dt
  end
  
  if pistol_Cooldown <= 0 then
    weapons["Pistol"].cooldown = false
  elseif shotgun_Cooldown <= 0 then
    weapons["Shotgun"].cooldown = false
  else
    weapons["Pistol"].cooldown = true
    weapons["Shotgun"].cooldown = true
  end

end--]]