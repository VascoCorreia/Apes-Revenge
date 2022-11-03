require "vector2"

trampolines = {
  
  [1] = { vertice1 = vector2.new(100, 680), vertice2 = vector2.new(100,830), vertice3 = vector2.new(250,830) },
  [2] = { vertice1 = vector2.new(1800, 680), vertice2 = vector2.new(1800,830), vertice3 = vector2.new(1650,830) }
  }

  trampolines_Hitboxes =
  {
    {
      [1] = createObject(100,700,20,10),
      [2] = createObject(100,710,30,10),
      [3] = createObject(100,720,40,10),
      [4] = createObject(100,730,50,10),
      [5] = createObject(100,740,60,10),
      [6] = createObject(100,750,70,10),
      [7] = createObject(100,760,80,10),
      [8] = createObject(100,770,90,10),
      [9] = createObject(100,780,100,10),
      [10] = createObject(100,790,110,10),
      [11] = createObject(100,800,120,10),
      [12] = createObject(100,810,130,10),
      [13] = createObject(100,820,140,10),
      [14] = createObject(100,830,150,10)
      },
    {
      [1] = createObject(1780,700,20,10), 
      [2] = createObject(1770,710,30,10),
      [3] = createObject(1760,720,40,10),
      [4] = createObject(1750,730,50,10),
      [5] = createObject(1740,740,60,10),
      [6] = createObject(1730,750,70,10),
      [7] = createObject(1720,760,80,10),
      [8] = createObject(1710,770,90,10),
      [9] = createObject(1700,780,100,10),
      [10] = createObject(1690,790,110,10),
      [11] = createObject(1680,800,120,10),
      [12] = createObject(1670,810,130,10),
      [13] = createObject(1660,820,140,10),
      [14] = createObject(1650,830,150,10)
      }
  }

function drawTrampolines(trampolines)
  love.graphics.setColor(0,1,0)
  for i = 1, table.getn(trampolines), 1 do
    love.graphics.polygon("fill", trampolines[i].vertice1.x, trampolines[i].vertice1.y, trampolines[i].vertice2.x, trampolines[i].vertice2.y, trampolines[i].vertice3.x, trampolines[i].vertice3.y)
  end
end

function checkPlayerTrampolineCollision(player, number)
  
  for i = 1, table.getn(trampolines_Hitboxes[number]), 1 do 
    local collided_Trampoline = CheckBoxCollision(players[player].position.x,players[player].position.y,players[player].width,players[player].height,trampolines_Hitboxes[number][i].position.x,trampolines_Hitboxes[number][i].position.y,trampolines_Hitboxes[number][i].size.x,trampolines_Hitboxes[number][i].size.y)
    
    if collided_Trampoline then
      players[player].onTrampoline =  true
      players[player].velocity = vector2.mult(players[player].velocity,0)
      players[player].acceleration = vector2.mult(players[player].velocity,0)
     
      if number == 1 then -- left trampoline
         impulse = vector2.new(150000,-90000)
      elseif number == 2 then  -- right trampoline
         impulse = vector2.new(-150000,-90000)
      end
       players[player].acceleration = vector2.addForce(impulse ,players[player].mass, players[player].acceleration) 
       break
    end
   
  end
  return players[player].acceleration
end


 --[[function trampolinesAirTimer(dt, number, player)

  for i = 1, table.getn(trampolines_Hitboxes[number]), 1 do 
    local collided_Trampoline = CheckBoxCollision(players[player].position.x,players[player].position.y,players[player].width,players[player].height,trampolines_Hitboxes[number][i].position.x,trampolines_Hitboxes[number][i].position.y,trampolines_Hitboxes[number][i].size.x,trampolines_Hitboxes[number][i].size.y)
  
    if collided_Trampoline then
     flag = true
    end
     if flag then 
      trampolineAirTimer = trampolineAirTimer - dt
      if trampolineAirTimer <= 0 then
        trampolineAirTimer = 12
        flag = false
      end
      
    end
  
 
  end
end
end
--]]