require "vector2"
require "collision"

 players = { 
   
  [1] = {
    score = 0,
    initialposition = vector2.new(400, 0),
    position = vector2.new(400,100),
    height = 50,
    width = 50,
    velocity = vector2.new(0,0),
    mass = 1,
    frictioncoefficient = 3000,
    onGround = false,
    jumpsleft = 2,
    doublejump = false, -- is true when player only has 1 jump left
    counterforce = false, -- is true when player has 1 jumpleft and doublejump is true
    movedirection = vector2.new(0,-1),
    weaponequipped = {Pistol = true, Shotgun = false},
    onTrampoline = false

    },
    
  [2] = {
    score = 0,
    initialposition = vector2.new(1520 - 50, 0), -- 50 is the player 2 width
    position = vector2.new(1520-50,100),
    height = 50,
    width = 50,
    velocity = vector2.new(0,0),
    mass = 1,
    frictioncoefficient = 3000,
    onGround = false,
    jumpsleft = 2,
    doublejump = false, -- is true when player only has 1 jump left
    counterforce = false, -- is true when player has 1 jumpleft and doublejump is true
    acceleration = vector2.new(0,0),
    movedirection = vector2.new(0,-1),
    weaponequipped = {Pistol = true, Shotgun = false},
    onTrampoline = false

    }
  }
  
  local jump = vector2.new(0,-60000)
  
  
function drawPlayer()
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("fill", players[1].position.x,players[1].position.y, players[1].width, players[2].height)
  
  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill", players[2].position.x,players[2].position.y, players[2].width, players[2].height)
end

function updatePlayer1(dt, world)

  gravity = vector2.new(0, 3000)
  players[1].acceleration = vector2.new(0,0)
  players[1].acceleration = vector2.addForce(gravity, players[1].mass, players[1].acceleration)  
  
  if (players[1].onGround) then
    if vector2.magnitude(players[1].velocity) > 1.8 then
      players[1].friction = vector2.mult(players[1].velocity, -1)
      players[1].friction = vector2.normalize(players[1].friction)
      players[1].friction = vector2.mult(players[1].friction, players[1].frictioncoefficient)
      players[1].acceleration = vector2.addForce(players[1].friction, players[1].mass, players[1].acceleration)
    end
  end

 if love.keyboard.isDown('a') then
 --   if joystick1:isGamepadDown("dpleft") then
      local move = vector2.new(-8000,0)
      players[1].acceleration = vector2.addForce(move,players[1].mass,players[1].acceleration)
      players[1].movedirection.x = -1
    end
    
   if love.keyboard.isDown('d') then
    --if joystick1:isGamepadDown("dpright") then
      local move = vector2.new(8000,0)
      players[1].acceleration = vector2.addForce(move,players[1].mass,players[1].acceleration)
      players[1].movedirection.x = 1
    end
  
    
  if love.keyboard.isDown("w") and (players[1].doublejump == true or players[1].onGround == true) then
  
    players[1].acceleration = vector2.addForce(jump, players[1].mass, players[1].acceleration)
    players[1].jumpsleft = players[1].jumpsleft - 1
    players[1].onGround = false
    players[1].doublejump = false
    
    if players[1].jumpsleft == 0  --[[or(players[1].onGround == false and players[1].jumpsleft == 2)--]] then
      players[1].velocity.y = 0 -- cancels velocity of the player to allow correct doublejump
    end
   end 
   
  if (players[1].position.x > love.graphics.getWidth()) then
    players[1].position.x = 0
  elseif (players[1].position.x < 0) then
    players[1].position.x = love.graphics.getWidth()
  end


  players[1].futurevelocity = vector2.add(players[1].velocity, vector2.mult(players[1].acceleration, dt))
  players[1].futurevelocity = vector2.limit(players[1].futurevelocity, 800)
  players[1].futureposition = vector2.add(players[1].position, vector2.mult(players[1].futurevelocity, dt)) 
  players[1].acceleration = checkPlayer1Collision(world, players[1].futureposition, players[1].movedirection, players[1].acceleration)
  players[1].acceleration = checkPlayerTrampolineCollision(1,1) -- left trampoline collision
  players[1].acceleration = checkPlayerTrampolineCollision(1,2) -- right trampoline collision

  if players[1].onTrampoline == false  then 
    if players[1].velocity.x > 800 then -- limiting x component of player velocity
      players[1].velocity.x = 800
    elseif players[1].velocity.x < -800 then
     players[1].velocity.x = -800
    end
  elseif players[1].onTrampoline == true then
    if players[1].velocity.x > 1400 then -- limiting x component of player velocity
      players[1].velocity.x = 1400
    elseif players[1].velocity.x < -1400 then
     players[1].velocity.x = -1400
    end
  end
  

  players[1].velocity = vector2.add(players[1].velocity, vector2.mult(players[1].acceleration,dt))
  
  players[1].position = vector2.add(players[1].position, vector2.mult(players[1].velocity,dt))
  
  if players[1].velocity.y ~= 0 then
    players[1].onGround = false
  end
end

function updatePlayer2(dt, world)

  gravity = vector2.new(0, 3000)
  players[2].acceleration = vector2.new(0,0)
  players[2].acceleration = vector2.addForce(gravity, players[2].mass, players[2].acceleration)  
  
  if (players[2].onGround) then
    if vector2.magnitude(players[2].velocity) > 1.8 then
      players[2].friction = vector2.mult(players[2].velocity, -1)
      players[2].friction = vector2.normalize(players[2].friction)
      players[2].friction = vector2.mult(players[2].friction, players[2].frictioncoefficient)
      players[2].acceleration = vector2.addForce(players[2].friction, players[2].mass, players[2].acceleration)
    end
  end

 --if love.keyboard.isDown('left') then
   if joystick:isGamepadDown("dpleft") then
      local move = vector2.new(-8000,0)
      players[2].acceleration = vector2.addForce(move,players[2].mass,players[2].acceleration)
      players[2].movedirection.x =-1
    end
    
 -- if love.keyboard.isDown('right') then
    if joystick:isGamepadDown("dpright") then
      local move = vector2.new(8000,0)
      players[2].acceleration = vector2.addForce(move,players[2].mass,players[2].acceleration)
      players[2].movedirection.x = 1
    end
  
    
  if joystick:isGamepadDown("dpup") and (players[2].onGround == true or players[2].doublejump == true) then


    players[2].acceleration = vector2.addForce(jump, players[2].mass, players[2].acceleration)
    players[2].jumpsleft = players[2].jumpsleft - 1
    players[2].onGround = false
    players[2].doublejump = false

    if players[2].jumpsleft == 0 then
      players[2].velocity.y = 0 -- cancels velocity of the player to allow correct doublejump
    end
   end 
   
  if (players[2].position.x > love.graphics.getWidth()) then
    players[2].position.x = 0
  elseif (players[2].position.x < 0) then
    players[2].position.x = love.graphics.getWidth()
  end


  players[2].futurevelocity = vector2.add(players[2].velocity, vector2.mult(players[2].acceleration, dt))
  players[2].futurevelocity = vector2.limit(players[2].futurevelocity, 800)
  players[2].futureposition = vector2.add(players[2].position, vector2.mult(players[2].futurevelocity, dt)) 
  players[2].acceleration = checkPlayer2Collision(world, players[2].futureposition, players[2].movedirection, players[2].acceleration)
  players[2].acceleration = checkPlayerTrampolineCollision(2,1) -- left trampoline collision
  players[2].acceleration = checkPlayerTrampolineCollision(2,2) -- right trampoline collision

  if players[2].onTrampoline == false  then 
    if players[2].velocity.x > 800 then -- limiting x component of player velocity
      players[2].velocity.x = 800
    elseif players[2].velocity.x < -800 then
     players[2].velocity.x = -800
    end
  elseif players[2].onTrampoline == true then
    if players[2].velocity.x > 1400 then -- limiting x component of player velocity
      players[2].velocity.x = 1400
    elseif players[2].velocity.x < -1400 then
     players[2].velocity.x = -1400
    end
  end
  
  

  players[2].velocity = vector2.add(players[2].velocity, vector2.mult(players[2].acceleration,dt))
  players[2].position = vector2.add(players[2].position, vector2.mult(players[2].velocity,dt))
  
  if players[2].velocity.y ~= 0 then
    players[2].onGround = false
  
  end
end

function checkPlayer1Collision(world, futureposition, movedirection, acceleration)

  
  for i = 1, table.getn(world), 1 do
    local collisiondir = GetBoxCollisionDirection(players[1].futureposition.x, players[1].futureposition.y, players[1].width, players[1].height, world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
   
    if not (collisiondir.x == 0 and collisiondir.y == 0) then
      if collisiondir.y == players[1].movedirection.y then --down collision
        players[1].velocity.y = 0
        players[1].acceleration.y = 0
        players[1].jumpsleft = 2
        players[1].onGround = true
        players[1].onTrampoline = false
        
       -- players[1].position.y  = world[i].position.y + players[1].height
      elseif collisiondir.y == 1 then --up collision
        players[1].velocity.y = 0
        players[1].acceleration.y = 0
        players[1].position.y = world[i].position.y + world[i].size.y
      elseif players[1].movedirection.x ~= collisiondir.x then --side collision
        players[1].velocity.x = 0
        players[1].acceleration.x = 0
      end
    end
  end
  
return players[1].acceleration
end

function checkPlayer2Collision(world, futureposition, movedirection, acceleration)
  for i = 1, table.getn(world), 1 do
    local collisiondir = GetBoxCollisionDirection(players[2].futureposition.x, players[2].futureposition.y, players[2].width, players[2].height, world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
    if not (collisiondir.x == 0 and collisiondir.y == 0) then
      if collisiondir.y == players[2].movedirection.y then --down collision
        players[2].velocity.y = 0
        players[2].acceleration.y = 0
        players[2].jumpsleft = 2
        players[2].onGround = true
        players[2].onTrampoline = false
        --players[2].position.y = world[i].position.y
      elseif collisiondir.y == 1 then --up collision
        players[2].velocity.y = 0
        players[2].acceleration.y = 0
        players[2].position.y = world[i].position.y + world[i].size.y
      elseif players[2].movedirection.x ~= collisiondir.x then --side collision
        players[2].velocity.x = 0
        players[2].acceleration.x = 0
      end
    end
  end
  
return players[2].acceleration
end
    
function player1Death(weapon)
  for i=1, table.getn(bulletsPlayer[2][weapon]), 1 do 
    if bulletsPlayer[2][weapon][i] ~= nil then
    
      local collided = CheckBoxCollision(players[1].position.x, players[1].position.y, players[1].width, players[1].height, bulletsPlayer[2][weapon][i].positionx, bulletsPlayer[2][weapon][i].positiony, bulletProperties.size.x,bulletProperties.size.y)
    
      if collided == true then
        players[2].score = players[2].score + 1 
        table.remove(bulletsPlayer[2][weapon], i)
        players[1].position.x = players[1].initialposition.x
        players[1].position.y = players[1].initialposition.y
    
      end
    end
  end
end

function player2Death(weapon)
  for i=1, table.getn(bulletsPlayer[1][weapon]), 1 do 
    if bulletsPlayer[1][weapon][i] ~= nil then
    
      local collided = CheckBoxCollision(players[2].position.x, players[2].position.y, players[2].width, players[2].height, bulletsPlayer[1][weapon][i].positionx, bulletsPlayer[1][weapon][i].positiony, bulletProperties.size.x,bulletProperties.size.y)
    
      if collided == true then
        players[1].score = players[1].score + 1
        table.remove(bulletsPlayer[1][weapon], i)
        players[2].position.x = players[2].initialposition.x
        players[2].position.y = players[2].initialposition.y
    
      end
    end
  end
end