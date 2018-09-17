local drawingController = require("objects/drawingController")
local ball = require("objects/ball")()
local paddle = require("objects/paddle")()
local stage = require("objects/stage")(ball, paddle)

function love.load()

end

function love.update(dt)
  ball:update(dt, stage.world)
  paddle:update(dt, stage.world)
end

function love.draw()
  drawingController:draw(paddle, ball)
end
