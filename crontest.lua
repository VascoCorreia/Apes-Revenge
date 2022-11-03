local cron = require 'cron'

local function printMessage()
  print('Hello')
end

local c3 = cron.every(3, printMessage)

function love.update(dt)

  c3:update(dt)

end
