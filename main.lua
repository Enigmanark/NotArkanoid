local stage = require("objects/stage")()

function love.load()

end

function love.update(dt)
  stage:update(dt)
end

function love.draw(dt)
  stage:draw(dt)
end
