require("../libs/utils")
local class = require("../libs/lowerclass/lowerclass")
local bump = require("libs/bump/bump")
local Stage = class("Stage")

local ball = require("objects/ball")()
local paddle = require("objects/paddle")()

local block1 = require("objects/block")(getBlockID(), 100, 100, 30, 30)
local block2 = require("objects/block")(getBlockID(), 100, 200, 30, 30)
local block3 = require("objects/block")(getBlockID(), 100, 300, 30, 30)

local blocks = {}
table.insert(blocks, block1)
table.insert(blocks, block2)
table.insert(blocks, block3)

function Stage:initialize()
    --Make rects for bounds
    local leftBounds = {
        name = "LeftBounds", 
        x = 0, 
        y = 0, 
        width = 1, 
        height = love.graphics.getHeight()
    }
    local rightBounds = {
        name = "RightBounds", 
        x = love.graphics.getWidth() - 1, 
        y = 0, 
        width = 1, 
        height = love.graphics.getHeight()
    }
    local topBounds = {
        name = "TopBounds", 
        x = 0, 
        y = 0, 
        width = love.graphics.getWidth(), 
        height = 1
    }

    --Make world for colliders
    self.world = bump.newWorld(50)
    
    --Add ball and paddle
    self.world:add(ball, ball.position.x, ball.position.y, ball.radius, ball.radius)
    self.world:add(paddle, paddle.position.x, paddle.position.y, paddle.width, paddle.height)
    --Add bounds
    self.world:add(leftBounds, leftBounds.x, leftBounds.y, leftBounds.width, leftBounds.height)
    self.world:add(rightBounds, rightBounds.x, rightBounds.y, rightBounds.width, rightBounds.height)
    self.world:add(topBounds, topBounds.x, topBounds.y, topBounds.width, topBounds.height)

    --Add blocks
    for i, block in pairs(blocks) do
        self.world:add(block, block.x, block.y, block.width, block.height)
    end
end

function Stage:draw(dt)
    for i, block in pairs(blocks) do
        love.graphics.rectangle("line", block.x, block.y, block.width, block.height)
    end
    ball:draw(dt)
    paddle:draw(dt)
end

function Stage:update(dt)
    ball:update(dt, self.world)
    paddle:update(dt, self.world)

    --Update blocks
    for i, block in pairs(blocks) do
        if block.dead == true then
            blocks[i] = nil
            self.world:remove(block)
        end
    end
end

return Stage