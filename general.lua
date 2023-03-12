local enums = require 'enums'

local GeneralVariables = {}

GeneralVariables.tileWidth = 16
GeneralVariables.tileHeight = 16
GeneralVariables.mapWidth = 64*16
GeneralVariables.mapHeight = 32*16
GeneralVariables.pixelScale = 2

GeneralVariables.winningScore = 7

GeneralVariables.defaultPosition = {[enums.PlayerType.ONE] = enums.Position.RIGHT}

GeneralVariables.fontPath = 'assets/fonts/Pixeboy-z8XGD.ttf'

GeneralVariables.drawMode = enums.DrawMode.GEOMETRY
assert(GeneralVariables.drawMode ~= nil, "GeneralVariables.drawMode is nil")

return GeneralVariables