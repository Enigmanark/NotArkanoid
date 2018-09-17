local class = require("../libs/lowerclass/lowerclass")
local Block = class("Block")

function Block:initialize(id, x, y, width, height)
    self.name = "Block"
    self.id = id
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dead = false
end

return Block