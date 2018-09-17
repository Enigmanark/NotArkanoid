local class = require("../libs/lowerclass/lowerclass")
local DrawingController = class("DrawingController")

function DrawingController:draw(paddle, ball)
  --Draw Ball
  local circle_segments = 16
  love.graphics.circle("line", ball.position.x, ball.position.y, ball.radius, circle_segments)

  --Draw paddle
  love.graphics.rectangle("line", paddle.position.x, paddle.position.y, paddle.width, paddle.height)
end

return DrawingController
