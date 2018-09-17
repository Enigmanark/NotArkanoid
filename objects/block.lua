local class = require("../libs/lowerclass/lowerclass")
local Block = class("Block")

function Block:initialize(id, x, y, width, height)
    self.id = id
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

return Block