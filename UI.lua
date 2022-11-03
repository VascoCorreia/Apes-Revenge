
function loadRoundTimer()
  
  timer_Font = love.graphics.newFont('Bittermilk.ttf',40)
  round_Time = 120
  
end

function drawTimer()
  love.graphics.setFont(timer_Font)
  love.graphics.setColor(1,1,1)
  love.graphics.print(tostring(string.format('%.0f',round_Time)), 950, 50)
end



function updateRoundTime(dt)
  round_Time = round_Time - dt
  
  if round_Time <= 0 then
    round_Over = true
  end
  if round_Over then
    love.event.quit()
  end
  
end

function drawPlayerScores()
  
  love.graphics.print('Humans: ' .. tostring(players[1].score), 650, 50)
  love.graphics.print('Apes: ' .. tostring(players[2].score), 1150, 50)
end