local class = require("../libs/lowerclass/lowerclass")
local Block = class("Block")

function Block:initialize(id, x, y)
    self.name = "Block"
    self.id = id
    self.x = x
    self.y = y
    self.width = blockWidth
    self.height = blockHeight
    self.dead = false
end

return Block