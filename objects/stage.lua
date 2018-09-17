local class = require("../libs/lowerclass/lowerclass")
local bump = require("libs/bump/bump")
local Stage = class("Stage")

function Stage:initialize(ball, paddle)
    local leftBounds = {name="LeftBounds", x=0, y=0, width=1, height=love.graphics.getHeight()}
    local rightBounds = {name="RightBounds", x=love.graphics.getWidth()-1, y=0, width=1, 
                    height=love.graphics.getHeight()}
    local topBounds = {name="TopBounds", x=0, y=0, width=love.graphics.getWidth(), height=1}
    
    self.world = bump.newWorld(50)
    self.world:add(ball, ball.position.x, ball.position.y, ball.radius, ball.radius)
    self.world:add(paddle, paddle.position.x, paddle.position.y, paddle.width, paddle.height)
    self.world:add(leftBounds, leftBounds.x, leftBounds.y, leftBounds.width, leftBounds.height)
    self.world:add(rightBounds, rightBounds.x, rightBounds.y, rightBounds.width, rightBounds.height)
    self.world:add(topBounds, topBounds.x, topBounds.y, topBounds.width, topBounds.height)

end

return Stage