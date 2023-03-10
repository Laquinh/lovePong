local enums = require "enums"

local GeneralVariables = {}

GeneralVariables.tileWidth = 16
GeneralVariables.tileHeight = 16
GeneralVariables.mapWidth = 64*16
GeneralVariables.mapHeight = 32*16
GeneralVariables.pixelScale = 2

GeneralVariables.drawMode = enums.DrawMode.GEOMETRY
assert(GeneralVariables.drawMode ~= nil, "GeneralVariables.drawMode is nil")

return GeneralVariables