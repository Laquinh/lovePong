local GeneralVariables = require 'general'
local enums = require 'enums'

local scoreboard = {}

local LEFT = enums.Position.LEFT
local RIGHT = enums.Position.RIGHT

function scoreboard.load()
    scoreboard.scores =
    {
        [LEFT] = 0,
        [RIGHT] = 0
    }
    
    scoreboard.offset = 50

    scoreboard.color = {1, 1, 1, 0.75}
    scoreboard.font = love.graphics.newFont(GeneralVariables.fontPath, 136)
    love.graphics.setFont(scoreboard.font)

    scoreboard.updateWidth()

    print(scoreboard.scoreWidth[LEFT], scoreboard.scoreWidth[RIGHT])
end

function scoreboard.update(position)
    scoreboard.scores[position] = scoreboard.scores[position] + 1

    scoreboard.updateWidth()
end

function scoreboard.draw()
    love.graphics.setColor(scoreboard.color)
    love.graphics.setFont(scoreboard.font)

    love.graphics.print(scoreboard.scores[LEFT], GeneralVariables.mapWidth/2 - scoreboard.offset - scoreboard.scoreWidth[LEFT], 10)
    love.graphics.print(scoreboard.scores[RIGHT], GeneralVariables.mapWidth/2 + scoreboard.offset, 10)
end

function scoreboard.updateWidth()
    scoreboard.scoreWidth =
    {
        [LEFT] = scoreboard.font:getWidth(scoreboard.scores[LEFT]..""),
        [RIGHT] = scoreboard.font:getWidth(scoreboard.scores[RIGHT].."")
    }
end

return scoreboard