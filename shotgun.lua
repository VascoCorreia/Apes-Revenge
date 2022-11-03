
bullets = {

  }

function love.load()
  
  bullets1 = createBullet(100,100,0,400)
  bullets2 = createBullet(100,100,(math.pi/6),400)
  bullets3 = createBullet(100,100,-(math.pi/6),400)

  
end


function love.draw()
  for i = 1, table.getn(bullets), 1 do
    love.graphics.rectangle("fill", bullets[i].positionx, bullets[i].positiony,30,30)
  end
  
  love.graphics.print(tostring(bullets[2].directionx))
end



function love.update(dt)
  for i = 1, table.getn(bullets), 1 do
    bullets[i].positionx = bullets[i].positionx + (bullets[i].directionx*dt)
    bullets[i].positiony = bullets[i].positiony + (bullets[i].directiony*dt)
  end
end





function createBullet(x,y,angle,speed,weapon)
  
  local directionx = speed * math.cos(angle)
  local directiony = speed * math.sin(angle)
  
  table.insert(bullets, {positionx = x, positiony = y, directionx = directionx, directiony= directiony, speed = speed})
  
end