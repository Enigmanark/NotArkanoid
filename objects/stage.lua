require("../libs/utils")
local class = require("../libs/lowerclass/lowerclass")
local bump = require("libs/bump/bump")
local Stage = class("Stage")

local ball = require("objects/ball")()
local paddle = require("objects/paddle")()

local level1 = {
    x = 70,
    y = 100,
    width = 12,
    height = 5
}

local blocks = {}

function Stage:initialize()
    self.addRects(self)
    self.addBlocks(self)

    paddle:restart(self.world)
    ball:restart(self.world)
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

function Stage.addRects(self)
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
end

function Stage.addBlocks(self)
    --Add blocks
    local blockX = level1.x
    local blockY = level1.y
    for i = 0, level1.height do
        for j = 0, level1.width do
            local newBlock = require("objects/block")(getBlockID(), blockX, blockY)
            table.insert(blocks, newBlock)
            self.world:add(newBlock, newBlock.x, newBlock.y, newBlock.width, newBlock.height)
            blockX = blockX + newBlock.width
        end
        blockY = blockY + blockHeight
        blockX = level1.x
    end
end

function Stage:restart()
    initialize()
end

return Stage