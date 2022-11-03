require "vector2"

function createObject(x, y, w, h)
  return {position = vector2.new(x, y), size = vector2.new(w, h)}
end

function drawWorld(world)
  love.graphics.setColor(1,1,1)
  for i = 1, table.getn(world), 1 do
    love.graphics.rectangle("fill", world[i].position.x, world[i].position.y, world[i].size.x, world[i].size.y)
  end
end

