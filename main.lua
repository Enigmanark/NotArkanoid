blockWidth = 50
blockHeight = 20
local stage = require("objects/stage")()

function love.load()

end

function love.update(dt)
  stage:update(dt)

  if love.keyboard.isDown("r") then
    stage:restart()
  end
  
end

function love.draw(dt)
  stage:draw(dt)
end
