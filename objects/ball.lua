local vector = require("../libs/hump/vector")
local class = require("../libs/lowerclass/lowerclass")
local Ball = class("ball")
local inspect = require("../libs/inspect/inspect")
local ballFilter = function(item, other)
  return "bounce"
end

function Ball:initialize()
  self.startPosition = vector(0, 0)
  self.position = self.startPosition
  self.speed = vector(270, 270)
  self.radius = 10
end

function Ball:update(dt, world)
  local newX = self.position.x + (self.speed.x * dt)
  local newY = self.position.y + (self.speed.y * dt)
  local actualX, actualY, cols, len = world:move(self, newX, newY, ballFilter)
  self.position.x = actualX
  self.position.y = actualY
  for i = 1, #cols do
    local collision = cols[i]
    if collision.other.name == "Block" then
      collision.other.dead = true
    end
    local nx = collision.normal.x
    local ny = collision.normal.y

    if (nx < 0 and self.speed.x > 0) or (nx > 0 and self.speed.x < 0) then
      self.speed.x = -self.speed.x
    end

    if (ny < 0 and self.speed.y > 0) or (ny > 0 and self.speed.y < 0) then
      self.speed.y = -self.speed.y
    end
  end
end

function Ball:draw(dt)
    --Draw Ball
  local circle_segments = 16
  love.graphics.circle("line", self.position.x, self.position.y, self.radius, circle_segments)
end

function Ball:restart(world)
  local newX = self.startPosition.x
  local newY = self.startPosition.y
  local actualX, actualY, cols, len = world:move(self, newX, newY, ballFilter)
  self.position.x = actualX
  self.position.y = actualY
end

return Ball
